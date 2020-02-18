Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C08C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:03:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E4E2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzJ6ZGgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E4E2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j47Dg-0000zO-2y
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 13:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j47Cn-0008UB-Nj
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j47Cm-0006Id-95
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:02:45 -0500
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944]:42839)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j47Cm-0006IJ-43; Tue, 18 Feb 2020 13:02:44 -0500
Received: by mail-ua1-x944.google.com with SMTP id p2so7777151uao.9;
 Tue, 18 Feb 2020 10:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=dKt1/1CzcCSZmyL/KELU4HmgChVSKcUWMHMSBLZC3a0=;
 b=RzJ6ZGgSgMesQnQ0kxUxECWN6YXoj83j4GqRJCVgDO/6TbTdj0o+Z9OPESs8O6KSlf
 IqN0UqMH6Oa3q5nqwKpQK/OyD2kUrriOTsayHJEfc9/u9FbhBeTVLlGu4qvp/eXehWSG
 02wkFxPt9deQ129xKIQ3j/mpROL8U32SADq6raq09Trd4sL0+VI4+I4Pze3QQL/GQolm
 g2EZ/K24yaO9J1Yd2FYrnVAP7sJ1j8NFHpTgRI6nTwFQheVhiE6fakKK7wIF09S8/CW9
 Tu/YALO6xb+/vFdVKph2QaaCFHuFxer+yuhdATZfSEst+6eFWFcEgaVWDUzJyNgHa3n3
 qKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=dKt1/1CzcCSZmyL/KELU4HmgChVSKcUWMHMSBLZC3a0=;
 b=geamAvFSzcuBUj5cuNHhngJ4ckbB7gclNxFLtzMetwp8/fzZcRHHsWN1oG3zx0nMNB
 TZ02MnTYTdjHUwEL+zDCGg67sFib+3QrzdA1OBJbCQOHkMedgsvlxjOhPnxwh9NGmmC4
 bO7bihDwM0KfT+lSh6+dKv5W87+2dUAlg7ExNfmUs0vkMf8rNXX6jIVvwt4jKYDR+EHw
 5BJcsLsNRLEpnp+PpA25CbZ0tMbhnS2cLqS/vRVRzbwrhKVdThLSirzBgBdX6/CTgGge
 MhvyZHh2/wL7bW5TAL7TSSJBs04ancX/WyVlgsXNcRmjmHdegZaNLJRU/jOIqMM2LgAZ
 RvDg==
X-Gm-Message-State: APjAAAVKcjP43Z6WbYZJ7iYqdotx3+YHvvmWqk55sOrYNd8Rr1WiL2at
 0B6/XZ1tz0wJWy7OB6ZpEAz0iYgt17ZsrQjJKl0ghOb+
X-Google-Smtp-Source: APXvYqxsCVcrG27o+FMqis+eyUfqxp8yJROuMjqQ8YKiX1qFS5jyjOEfy98wN5Yp51vfQ2+b3SM29T52LAS8IcDnQiM=
X-Received: by 2002:a05:6830:1042:: with SMTP id
 b2mr16412109otp.306.1582048595321; 
 Tue, 18 Feb 2020 09:56:35 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Tue, 18 Feb 2020 09:56:34 -0800 (PST)
In-Reply-To: <20200217223558.863199-20-laurent@vivier.eu>
References: <20200217223558.863199-1-laurent@vivier.eu>
 <20200217223558.863199-20-laurent@vivier.eu>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 18 Feb 2020 18:56:34 +0100
Message-ID: <CAL1e-=gG+z-PKb-=ugFV31utC+My44xmrg-j0P1Oxr72p3yBsw@mail.gmail.com>
Subject: Re: [PATCH 19/22] linux-user,
 scripts: add a script to update syscall.tbl
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="0000000000008aa869059edd64cb"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::944
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008aa869059edd64cb
Content-Type: text/plain; charset="UTF-8"

On Monday, February 17, 2020, Laurent Vivier <laurent@vivier.eu> wrote:

> scripts/update-syscalltbl.sh has the list of syscall.tbl to update and
> can copy them from the linux source directory
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---


Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


>  MAINTAINERS                  |  1 +
>  scripts/update-syscalltbl.sh | 49 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
>  create mode 100755 scripts/update-syscalltbl.sh
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1740a4fddc14..dac93f447544 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2422,6 +2422,7 @@ S: Maintained
>  F: linux-user/
>  F: default-configs/*-linux-user.mak
>  F: scripts/qemu-binfmt-conf.sh
> +F: scripts/update-syscalltbl.sh
>
>  Tiny Code Generator (TCG)
>  -------------------------
> diff --git a/scripts/update-syscalltbl.sh b/scripts/update-syscalltbl.sh
> new file mode 100755
> index 000000000000..2d23e5680075
> --- /dev/null
> +++ b/scripts/update-syscalltbl.sh
> @@ -0,0 +1,49 @@
> +TBL_LIST="\
> +arch/alpha/kernel/syscalls/syscall.tbl,linux-user/alpha/syscall.tbl \
> +arch/arm/tools/syscall.tbl,linux-user/arm/syscall.tbl \
> +arch/m68k/kernel/syscalls/syscall.tbl,linux-user/m68k/syscall.tbl \
> +arch/microblaze/kernel/syscalls/syscall.tbl,linux-user/microblaze/syscall.tbl
> \
> +arch/mips/kernel/syscalls/syscall_n32.tbl,linux-user/mips64/syscall_n32.tbl
> \
> +arch/mips/kernel/syscalls/syscall_n64.tbl,linux-user/mips64/syscall_n64.tbl
> \
> +arch/mips/kernel/syscalls/syscall_o32.tbl,linux-user/mips/syscall_o32.tbl
> \
> +arch/parisc/kernel/syscalls/syscall.tbl,linux-user/hppa/syscall.tbl \
> +arch/powerpc/kernel/syscalls/syscall.tbl,linux-user/ppc/syscall.tbl \
> +arch/s390/kernel/syscalls/syscall.tbl,linux-user/s390x/syscall.tbl \
> +arch/sh/kernel/syscalls/syscall.tbl,linux-user/sh4/syscall.tbl \
> +arch/sparc/kernel/syscalls/syscall.tbl,linux-user/sparc64/syscall.tbl \
> +arch/sparc/kernel/syscalls/syscall.tbl,linux-user/sparc/syscall.tbl \
> +arch/x86/entry/syscalls/syscall_32.tbl,linux-user/i386/syscall_32.tbl \
> +arch/x86/entry/syscalls/syscall_64.tbl,linux-user/x86_64/syscall_64.tbl \
> +arch/xtensa/kernel/syscalls/syscall.tbl,linux-user/xtensa/syscall.tbl\
> +"
> +
> +linux="$1"
> +output="$2"
> +
> +if [ -z "$linux" ] || ! [ -d "$linux" ]; then
> +    cat << EOF
> +usage: update-syscalltbl.sh LINUX_PATH [OUTPUT_PATH]
> +
> +LINUX_PATH      Linux kernel directory to obtain the syscall.tbl from
> +OUTPUT_PATH     output directory, usually the qemu source tree (default:
> $PWD)
> +EOF
> +    exit 1
> +fi
> +
> +if [ -z "$output" ]; then
> +    output="$PWD"
> +fi
> +
> +for entry in $TBL_LIST; do
> +    OFS="$IFS"
> +    IFS=,
> +    set $entry
> +    src=$1
> +    dst=$2
> +    IFS="$OFS"
> +    if ! cp "$linux/$src" "$output/$dst" ; then
> +        echo "Cannot copy $linux/$src to $output/$dst" 1>&2
> +        exit 1
> +    fi
> +done
> +
> --
> 2.24.1
>
>
>

--0000000000008aa869059edd64cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, February 17, 2020, Laurent Vivier &lt;<a href=3D"mailto:=
laurent@vivier.eu">laurent@vivier.eu</a>&gt; wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">scripts/update-syscalltbl.sh has the list of syscall.tbl to upda=
te and<br>
can copy them from the linux source directory<br>
<br>
Signed-off-by: Laurent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu">laur=
ent@vivier.eu</a>&gt;<br>
---</blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);font=
-size:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Markovic=
 &lt;</span><a href=3D"mailto:amarkovic@wavecomp.com" style=3D"font-size:14=
px;line-height:22.1200008392334px">amarkovic@wavecomp.com</a><span style=3D=
"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px">&gt;</s=
pan><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 1 +<br>
=C2=A0scripts/update-syscalltbl.sh | 49 ++++++++++++++++++++++++++++++<wbr>=
++++++<br>
=C2=A02 files changed, 50 insertions(+)<br>
=C2=A0create mode 100755 scripts/update-syscalltbl.sh<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 1740a4fddc14..dac93f447544 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -2422,6 +2422,7 @@ S: Maintained<br>
=C2=A0F: linux-user/<br>
=C2=A0F: default-configs/*-linux-user.<wbr>mak<br>
=C2=A0F: scripts/qemu-binfmt-conf.sh<br>
+F: scripts/update-syscalltbl.sh<br>
<br>
=C2=A0Tiny Code Generator (TCG)<br>
=C2=A0-------------------------<br>
diff --git a/scripts/update-syscalltbl.sh b/scripts/update-syscalltbl.sh<br=
>
new file mode 100755<br>
index 000000000000..2d23e5680075<br>
--- /dev/null<br>
+++ b/scripts/update-syscalltbl.sh<br>
@@ -0,0 +1,49 @@<br>
+TBL_LIST=3D&quot;\<br>
+arch/alpha/kernel/syscalls/<wbr>syscall.tbl,linux-user/alpha/<wbr>syscall.=
tbl \<br>
+arch/arm/tools/syscall.tbl,<wbr>linux-user/arm/syscall.tbl \<br>
+arch/m68k/kernel/syscalls/<wbr>syscall.tbl,linux-user/m68k/<wbr>syscall.tb=
l \<br>
+arch/microblaze/kernel/<wbr>syscalls/syscall.tbl,linux-<wbr>user/microblaz=
e/syscall.tbl \<br>
+arch/mips/kernel/syscalls/<wbr>syscall_n32.tbl,linux-user/<wbr>mips64/sysc=
all_n32.tbl \<br>
+arch/mips/kernel/syscalls/<wbr>syscall_n64.tbl,linux-user/<wbr>mips64/sysc=
all_n64.tbl \<br>
+arch/mips/kernel/syscalls/<wbr>syscall_o32.tbl,linux-user/<wbr>mips/syscal=
l_o32.tbl \<br>
+arch/parisc/kernel/syscalls/<wbr>syscall.tbl,linux-user/hppa/<wbr>syscall.=
tbl \<br>
+arch/powerpc/kernel/syscalls/<wbr>syscall.tbl,linux-user/ppc/<wbr>syscall.=
tbl \<br>
+arch/s390/kernel/syscalls/<wbr>syscall.tbl,linux-user/s390x/<wbr>syscall.t=
bl \<br>
+arch/sh/kernel/syscalls/<wbr>syscall.tbl,linux-user/sh4/<wbr>syscall.tbl \=
<br>
+arch/sparc/kernel/syscalls/<wbr>syscall.tbl,linux-user/<wbr>sparc64/syscal=
l.tbl \<br>
+arch/sparc/kernel/syscalls/<wbr>syscall.tbl,linux-user/sparc/<wbr>syscall.=
tbl \<br>
+arch/x86/entry/syscalls/<wbr>syscall_32.tbl,linux-user/<wbr>i386/syscall_3=
2.tbl \<br>
+arch/x86/entry/syscalls/<wbr>syscall_64.tbl,linux-user/x86_<wbr>64/syscall=
_64.tbl \<br>
+arch/xtensa/kernel/syscalls/<wbr>syscall.tbl,linux-user/xtensa/<wbr>syscal=
l.tbl\<br>
+&quot;<br>
+<br>
+linux=3D&quot;$1&quot;<br>
+output=3D&quot;$2&quot;<br>
+<br>
+if [ -z &quot;$linux&quot; ] || ! [ -d &quot;$linux&quot; ]; then<br>
+=C2=A0 =C2=A0 cat &lt;&lt; EOF<br>
+usage: update-syscalltbl.sh LINUX_PATH [OUTPUT_PATH]<br>
+<br>
+LINUX_PATH=C2=A0 =C2=A0 =C2=A0 Linux kernel directory to obtain the syscal=
l.tbl from<br>
+OUTPUT_PATH=C2=A0 =C2=A0 =C2=A0output directory, usually the qemu source t=
ree (default: $PWD)<br>
+EOF<br>
+=C2=A0 =C2=A0 exit 1<br>
+fi<br>
+<br>
+if [ -z &quot;$output&quot; ]; then<br>
+=C2=A0 =C2=A0 output=3D&quot;$PWD&quot;<br>
+fi<br>
+<br>
+for entry in $TBL_LIST; do<br>
+=C2=A0 =C2=A0 OFS=3D&quot;$IFS&quot;<br>
+=C2=A0 =C2=A0 IFS=3D,<br>
+=C2=A0 =C2=A0 set $entry<br>
+=C2=A0 =C2=A0 src=3D$1<br>
+=C2=A0 =C2=A0 dst=3D$2<br>
+=C2=A0 =C2=A0 IFS=3D&quot;$OFS&quot;<br>
+=C2=A0 =C2=A0 if ! cp &quot;$linux/$src&quot; &quot;$output/$dst&quot; ; t=
hen<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;Cannot copy $linux/$src to $output/=
$dst&quot; 1&gt;&amp;2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit 1<br>
+=C2=A0 =C2=A0 fi<br>
+done<br>
+<br>
-- <br>
2.24.1<br>
<br>
<br>
</blockquote>

--0000000000008aa869059edd64cb--

