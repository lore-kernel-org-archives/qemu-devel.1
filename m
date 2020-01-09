Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A13C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:45:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BAB02075D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHMm6X9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BAB02075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipXBL-0002Fq-N2
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:44:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ipXAY-0001a4-4b
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:44:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ipXAW-0001Zm-AC
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:44:09 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34914)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ipXAW-0001VZ-1s
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:44:08 -0500
Received: by mail-oi1-x241.google.com with SMTP id k4so5742652oik.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 04:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=lcTb//QPZ8nEbmSy3M/rVGbHXdZe4jgLUvuk7SY69jQ=;
 b=cHMm6X9jVemkBJoPcDYHqSxJjmZ9DsROWMmhzUqJ/QMWvza7sI4bTpI1YamMIm0Fqz
 ORi1CLwNmVat2rknQ3SfGlFUjrmtLI2LZbWupI3V47gJHJ5zUBcwZnRRdI3Lzbt3FUzz
 zIuvgjIRQ+7T9dEolhalIiPA9Yax6W3WDXK948VMKTab1tvEZzK04uhYiyaQiUqiOnuq
 KF4lz5OvQOrejMmNerjlifUZUQsXIX5A9WJ5y9JRfkMYHQhUQ/wVu4khk+uGqwXD1xTM
 vItj5SZ+FaIFmUGXKg30jc8HxR6/9EmVzpdAEjq6R+3YiUjvxm2NsSYlTEHTUUDSHuer
 +6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=lcTb//QPZ8nEbmSy3M/rVGbHXdZe4jgLUvuk7SY69jQ=;
 b=nws8pyQYPAN5wyQ6GwszTTaCWVPebU2to/JlJfQq23dv55r9f9Vx2sb2blCMXJ0oNV
 avBFm6AtPnu44utd2ZqVdkmSw5rq11OnjkuCct9PiAdjyczTCM0V5O7CkS+ge0hGRgPM
 B2RUmb5/dr9N9tVbrgIh5IKzdI6uMs+q/ugJKeb0B84X8mRILbrHqorXfhFTX6JycyTz
 JUYri6X62nvw6MzLkX+JtKpgREJmB6G1z+DGEW2UKvAlhmR75jERc/MBM2qkz21CjW7A
 HVwpkNEImQYHOmtObiEHaugX9n1Vys0mkppQxxNnBCtKTJKaccwFJ5hXRu7ahK94cV+b
 Sfrw==
X-Gm-Message-State: APjAAAWdmjTWbrMUW4KmHzCKnc4+ms3pi9fq8w3SY5Qh6DuWpwGM44uX
 0ZnC1GSIGH0AR8KF2uumZnJtCou8yYTZyla/ycA=
X-Google-Smtp-Source: APXvYqxbm15EpEFvE5Lxat0zWyWKTchnnBrt3e7ZVvnjcAgKNx9AcqsoJeHTSF54jtsemNqv8qmais2WTs3zQZxyTwo=
X-Received: by 2002:a05:6808:64e:: with SMTP id
 z14mr2774524oih.79.1578573847053; 
 Thu, 09 Jan 2020 04:44:07 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Thu, 9 Jan 2020 04:44:06 -0800 (PST)
In-Reply-To: <20200109122913.3413914-1-berrange@redhat.com>
References: <20200109122913.3413914-1-berrange@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 9 Jan 2020 13:44:06 +0100
Message-ID: <CAL1e-=jG0ZQF0yrWrbJQ8TPS0gani1=KAeeg=7yKX6dYcORNUA@mail.gmail.com>
Subject: Re: [PATCH] docs: stop documenting the e1000 NIC model as the default
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000067caa6059bb45de3"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000067caa6059bb45de3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thursday, January 9, 2020, Daniel P. Berrang=C3=A9 <berrange@redhat.com>
wrote:

> The default NIC model for QEMU varies per machine type, and is liable to
> change across machine type versions. Documenting e1000 NIC as the
> default for PC/i386 is thus misleading to users at best. In particular
> the PC q35 machine type switched to use e1000e, but only in machine
> type versions after 2.11.
>
> Rather than try to explain which NIC model is used for each machine
> type version, remove mention of e1000 as the default, and steer users
> towards always specifying their desired model.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qemu-options.hx | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
>
Reviewed by: Aleksandar Markovic <amarkovic@wavecomp.com>



> diff --git a/qemu-options.hx b/qemu-options.hx
> index e9d6231438..ca57145126 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2344,8 +2344,7 @@ Use @option{model=3Dhelp} to list the available dev=
ice
> types.
>  The hardware MAC address can be set with @option{mac=3D@var{macaddr}}.
>
>  The following two example do exactly the same, to show how @option{-nic}
> can
> -be used to shorten the command line length (note that the e1000 is the
> default
> -on i386, so the @option{model=3De1000} parameter could even be omitted
> here, too):
> +be used to shorten the command line length:
>  @example
>  @value{qemu_system} -netdev user,id=3Dn1,ipv6=3Doff -device
> e1000,netdev=3Dn1,mac=3D52:54:98:76:54:32
>  @value{qemu_system} -nic user,ipv6=3Doff,model=3De1000,mac=3D52:54:98:76=
:54:32
> @@ -2759,9 +2758,12 @@ netdev with ID @var{nd} by using the
> @option{netdev=3D@var{nd}} option.
>  Legacy option to configure or create an on-board (or machine default)
> Network
>  Interface Card(NIC) and connect it either to the emulated hub with ID 0
> (i.e.
>  the default hub), or to the netdev @var{nd}.
> -The NIC is an e1000 by default on the PC target. Optionally, the MAC
> address
> -can be changed to @var{mac}, the device address set to @var{addr} (PCI
> cards
> -only), and a @var{name} can be assigned for use in monitor commands.
> +If @var{model} is omitted, then the default NIC model associated with
> +the machine type is used. Note that the default NIC model may change in
> +future QEMU releases, so it is highly recommended to always specify a
> model.
> +Optionally, the MAC address can be changed to @var{mac}, the device
> +address set to @var{addr} (PCI cards only), and a @var{name} can be
> +assigned for use in monitor commands.
>  Optionally, for PCI cards, you can specify the number @var{v} of MSI-X
> vectors
>  that the card should have; this option currently only affects virtio
> cards; set
>  @var{v} =3D 0 to disable MSI-X. If no @option{-net} option is specified,=
 a
> single
> --
> 2.23.0
>
>
>

--00000000000067caa6059bb45de3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, January 9, 2020, Daniel P. Berrang=C3=A9 &lt;<a href=
=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">The default NIC model for QEMU varies per machine=
 type, and is liable to<br>
change across machine type versions. Documenting e1000 NIC as the<br>
default for PC/i386 is thus misleading to users at best. In particular<br>
the PC q35 machine type switched to use e1000e, but only in machine<br>
type versions after 2.11.<br>
<br>
Rather than try to explain which NIC model is used for each machine<br>
type version, remove mention of e1000 as the default, and steer users<br>
towards always specifying their desired model.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com">berrange@redhat.com</a>&gt;<br>
---<br>
=C2=A0qemu-options.hx | 12 +++++++-----<br>
=C2=A01 file changed, 7 insertions(+), 5 deletions(-)<br>
<br></blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);fon=
t-size:14px;line-height:22.1200008392334px">Reviewed by: Aleksandar Markovi=
c &lt;</span><a href=3D"mailto:amarkovic@wavecomp.com" target=3D"_blank" st=
yle=3D"font-size:14px;line-height:22.1200008392334px">amarkovic@wavecomp.co=
m</a><span style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.12000=
08392334px">&gt;</span><br></div><div><br></div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
diff --git a/qemu-options.hx b/qemu-options.hx<br>
index e9d6231438..ca57145126 100644<br>
--- a/qemu-options.hx<br>
+++ b/qemu-options.hx<br>
@@ -2344,8 +2344,7 @@ Use @option{model=3Dhelp} to list the available devic=
e types.<br>
=C2=A0The hardware MAC address can be set with @option{mac=3D@var{macaddr}}=
.<br>
<br>
=C2=A0The following two example do exactly the same, to show how @option{-n=
ic} can<br>
-be used to shorten the command line length (note that the e1000 is the def=
ault<br>
-on i386, so the @option{model=3De1000} parameter could even be omitted her=
e, too):<br>
+be used to shorten the command line length:<br>
=C2=A0@example<br>
=C2=A0@value{qemu_system} -netdev user,id=3Dn1,ipv6=3Doff -device e1000,net=
dev=3Dn1,mac=3D52:54:98:<wbr>76:54:32<br>
=C2=A0@value{qemu_system} -nic user,ipv6=3Doff,model=3De1000,mac=3D<wbr>52:=
54:98:76:54:32<br>
@@ -2759,9 +2758,12 @@ netdev with ID @var{nd} by using the @option{netdev=
=3D@var{nd}} option.<br>
=C2=A0Legacy option to configure or create an on-board (or machine default)=
 Network<br>
=C2=A0Interface Card(NIC) and connect it either to the emulated hub with ID=
 0 (i.e.<br>
=C2=A0the default hub), or to the netdev @var{nd}.<br>
-The NIC is an e1000 by default on the PC target. Optionally, the MAC addre=
ss<br>
-can be changed to @var{mac}, the device address set to @var{addr} (PCI car=
ds<br>
-only), and a @var{name} can be assigned for use in monitor commands.<br>
+If @var{model} is omitted, then the default NIC model associated with<br>
+the machine type is used. Note that the default NIC model may change in<br=
>
+future QEMU releases, so it is highly recommended to always specify a mode=
l.<br>
+Optionally, the MAC address can be changed to @var{mac}, the device<br>
+address set to @var{addr} (PCI cards only), and a @var{name} can be<br>
+assigned for use in monitor commands.<br>
=C2=A0Optionally, for PCI cards, you can specify the number @var{v} of MSI-=
X vectors<br>
=C2=A0that the card should have; this option currently only affects virtio =
cards; set<br>
=C2=A0@var{v} =3D 0 to disable MSI-X. If no @option{-net} option is specifi=
ed, a single<br>
-- <br>
2.23.0<br>
<br>
<br>
</blockquote>

--00000000000067caa6059bb45de3--

