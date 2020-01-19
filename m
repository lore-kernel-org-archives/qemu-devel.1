Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9D5C32771
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 00:29:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 184D4246A5
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 00:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6HURLjJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184D4246A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isySw-0002OU-Ae
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 19:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1isySL-0001yJ-Vj
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 19:28:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1isySK-0007xN-E5
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 19:28:45 -0500
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:37590)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1isySK-0007x3-8n; Sat, 18 Jan 2020 19:28:44 -0500
Received: by mail-il1-x141.google.com with SMTP id t8so24448047iln.4;
 Sat, 18 Jan 2020 16:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t4byTpjm4sHf6eSOBjyzkUGuebvhsAwzimOh0Kkin2g=;
 b=M6HURLjJN5XwqvWYCp1cbT3HEINlfQ3JcVMRbKbx6Hcpbb1zBqbzBNkxEK7bdJ6sqx
 /j9gLgr1UHKlqivWkDokGvFK7T28Nh6XVMWDGkYBXwiJ6RjzeL/aVvoVtOgmt+C5D3Xu
 J5bFZJERFUqtQ8/sW3KOiFqp0XW3hpx+GSgJUs6+mJw1QvjrIdeo+SEzAECq1oX+MmQy
 zCC6cB0HL00GUOalC5Tgniqw90TZGPxeNxuXM5IYGRLz2kr2D0y5WgJ1v9LQWc7rAEGa
 WOpE9Hr4SIYXaNsI513EHySelZIBVbI91FbCrnW+pHSszUkTufMzeoEHpxk9X84HYBQv
 THeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t4byTpjm4sHf6eSOBjyzkUGuebvhsAwzimOh0Kkin2g=;
 b=gpZr4vIPKVKueEU7/YgfadVbKsXRrvlgttI13UUPOJa8wrhkpESN3IgvdBM0H0yrvX
 M4j+Gt3Z4Pnvbgtg/USJEU5yZ25QmWuWzxlzGC6Am4XLYg6rxA0y6DAfqqjnmbToyo7X
 TTkkWFVs8EWwEfJSHWKjHCabTKTN8EZWo5i5Zy4z2LHMEDxq+4lM/kAA11nKaIqSe4HU
 V3zI1mCDlvhqC4jYOpQ0W2OjVl/72TkSuuvV7Y8CE/blSqCSGAXyyYu/mx9nUbwjYOqL
 JoHS8RR2dBrWyqpD6WyAhcVViSm9HU3IBmUixer9dzgUcV4rt81vndaT60O0SaWJ1rFn
 gwWg==
X-Gm-Message-State: APjAAAU4ekC89v0BSALRIMf384QH/suEZwZsOveW2cVF1Hby+2PM46D1
 meWsIPofK7cssdtApMfHVKo6r2wc1wRbOFxBwhY=
X-Google-Smtp-Source: APXvYqy70krxw19VvffgEz5GndoWPxCtESgKRna6UNsYqE+J4vXjZPiuQfz8eaj9Zh8W5msI16tIb6IRjREkpG+ETyc=
X-Received: by 2002:a92:a103:: with SMTP id v3mr4971804ili.265.1579393723499; 
 Sat, 18 Jan 2020 16:28:43 -0800 (PST)
MIME-Version: 1.0
References: <20200118191623.32549-1-f4bug@amsat.org>
 <20200118191623.32549-5-f4bug@amsat.org>
In-Reply-To: <20200118191623.32549-5-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sun, 19 Jan 2020 01:28:32 +0100
Message-ID: <CAPan3WpLXi+23k7JDidmGRefz-rwxwaJmh-rRXO125zh422zpw@mail.gmail.com>
Subject: Re: [PATCH 4/4] .travis.yml: Allow untrusted code and large files
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000da63e3059c734151"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::141
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>,
 qemu-arm <qemu-arm@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000da63e3059c734151
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

For some reason, I can't apply this patch with git am:

Applying: .travis.yml: Allow untrusted code and large files
error: patch failed: .travis.yml:260
error: .travis.yml: patch does not apply
Patch failed at 0001 .travis.yml: Allow untrusted code and large files
Use 'git am --show-current-patch' to see the failed patch

I didn't change the .travis.yml file. I'm using latest master from commit
7fb38daf256bd1bcbcb5ea556422283d0d55a1b1

Regards,
Niek

On Sat, Jan 18, 2020 at 8:16 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> As Travis CI runs our tests in a disposable environment, we don't
> care much if the binaries are trusted. The more we test the better.
>
> Also, as of this commmit, the smallest available announced [1] is
> "approx 18GB", plenty of space to run our acceptance tests.
>
> Enable the proper environment variables to allow Avocado download
> from untrusted sources, and to download large files.
>
> Note: As of this commit, all our tests "Ran for 17 min 7 sec"
> before succeeding, see [2].
>
> [1]
> https://docs.travis-ci.com/user/reference/overview/#virtualisation-enviro=
nment-vs-operating-system
> [2] https://travis-ci.org/philmd/qemu/jobs/638823612#L3817
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  .travis.yml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index 638fba4799..b8b9df65a6 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -260,6 +260,8 @@ matrix:
>
>      # Acceptance (Functional) tests
>      - env:
> +        - AVOCADO_ALLOW_LARGE_STORAGE=3D"yes"
> +        - AVOCADO_ALLOW_UNTRUSTED_CODE=3D"sure"
>          - CONFIG=3D"--python=3D/usr/bin/python3
> --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-soft=
mmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-=
softmmu,sparc-softmmu"
>          - TEST_CMD=3D"make check-acceptance"
>        after_failure:
> --
> 2.21.1
>
>

--=20
Niek Linnenbank

--000000000000da63e3059c734151
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Philippe,</div><div><br></div><div>For some reason=
, I can&#39;t apply this patch with git am:</div><div><br></div><div>Applyi=
ng: .travis.yml: Allow untrusted code and large files<br>error: patch faile=
d: .travis.yml:260<br>error: .travis.yml: patch does not apply<br>Patch fai=
led at 0001 .travis.yml: Allow untrusted code and large files<br>Use &#39;g=
it am --show-current-patch&#39; to see the failed patch<br></div><div><br><=
/div><div>I didn&#39;t change the .travis.yml file. I&#39;m using latest ma=
ster from commit 7fb38daf256bd1bcbcb5ea556422283d0d55a1b1</div><div><br></d=
iv><div>Regards,</div><div>Niek<br></div><div><br></div><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jan 18, 2020 at 8:16 =
PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug=
@amsat.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">As Travis CI runs our tests in a disposable environment, we don&=
#39;t<br>
care much if the binaries are trusted. The more we test the better.<br>
<br>
Also, as of this commmit, the smallest available announced [1] is<br>
&quot;approx 18GB&quot;, plenty of space to run our acceptance tests.<br>
<br>
Enable the proper environment variables to allow Avocado download<br>
from untrusted sources, and to download large files.<br>
<br>
Note: As of this commit, all our tests &quot;Ran for 17 min 7 sec&quot;<br>
before succeeding, see [2].<br>
<br>
[1] <a href=3D"https://docs.travis-ci.com/user/reference/overview/#virtuali=
sation-environment-vs-operating-system" rel=3D"noreferrer" target=3D"_blank=
">https://docs.travis-ci.com/user/reference/overview/#virtualisation-enviro=
nment-vs-operating-system</a><br>
[2] <a href=3D"https://travis-ci.org/philmd/qemu/jobs/638823612#L3817" rel=
=3D"noreferrer" target=3D"_blank">https://travis-ci.org/philmd/qemu/jobs/63=
8823612#L3817</a><br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0.travis.yml | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/.travis.yml b/.travis.yml<br>
index 638fba4799..b8b9df65a6 100644<br>
--- a/.travis.yml<br>
+++ b/.travis.yml<br>
@@ -260,6 +260,8 @@ matrix:<br>
<br>
=C2=A0 =C2=A0 =C2=A0# Acceptance (Functional) tests<br>
=C2=A0 =C2=A0 =C2=A0- env:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 - AVOCADO_ALLOW_LARGE_STORAGE=3D&quot;yes&quot=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 - AVOCADO_ALLOW_UNTRUSTED_CODE=3D&quot;sure&qu=
ot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- CONFIG=3D&quot;--python=3D/usr/bin/pyth=
on3 --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-so=
ftmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68=
k-softmmu,sparc-softmmu&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- TEST_CMD=3D&quot;make check-acceptance&=
quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0after_failure:<br>
-- <br>
2.21.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000da63e3059c734151--

