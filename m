Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0BBC4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 12:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B332089C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 12:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJzk4fke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B332089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJGQo-0007fP-0p
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 08:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iJGPT-0006xW-34
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 08:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iJGPR-0001K1-HO
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 08:22:11 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38129)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iJGPO-0001Id-Mz; Sat, 12 Oct 2019 08:22:06 -0400
Received: by mail-oi1-x241.google.com with SMTP id m16so10223843oic.5;
 Sat, 12 Oct 2019 05:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=CsvYkan0+HaVOnj1el4uyfArjQc9tuaEiV3+i2g5oxg=;
 b=kJzk4fket16jJIojhHMMSyTpmvCHiDDjJ7TZyADOA9z8nSF6MpB5ceczz4jSwekmKk
 omJcLy7/6Vn3kJHgPolt4tVhiKrxTNz5MO2qbnXMoxcJ+gCp/3oBtQVeI9/L+kunVMCo
 vTVLqRlHXmd/uTYPhMauhtYtNUhtkvNbvrdXrcvnwkYuVpVCbYiwDS3sz/tfhOLvdY+q
 J7wlipRxXiAURCDbPB0vc0IRPHvHueS8zeMMlMfncZBp7BsJPjEATwTrX0wuTbStzzXu
 Arwgk5BLLBkFd1Zu1u+psCHCHYKTxGC/lrvuE8k7yFI6cue6wEQ+TRSyNvKoG+y49Gqz
 ZO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=CsvYkan0+HaVOnj1el4uyfArjQc9tuaEiV3+i2g5oxg=;
 b=KQQvnjP59eg12CKVF8qD9TFx2vbU0vDMtvuo2GlZTiLKXg1KUP5Kqx+6uK1f2r3h07
 QPI9A7tvQIWq2Z4uqNkX3xK0GemFC/XiUF8qurUfaAq11ixwUv1p3cajV7FsW8mOScEk
 +qUcXSTT/RAYYCfgFRi0tLWv3WIPKNSTDKNEFgf+fGsltaXXjIij/iI0+M5oC/mT1791
 tsWUtmWjc2oRjFHlSUT4fe2yisrEjriu7sh9baMYURUknpSFylsPQADjHsPtKKxQBN2z
 lQY+cwv9shZYMdbOZh+Vup5y/Yq12/N+984v2qYJpAOZrvWTLIaKPpP9KXNVbKF5f14e
 Ru1Q==
X-Gm-Message-State: APjAAAUbwMc18cOVaygh3Rf11kGXHDIR51oHihR+bg7mP3jY3wtEOEPG
 BNrjd0ePdFuqK2eN7Bg4Swes6kj2AQIqZYhEwQM=
X-Google-Smtp-Source: APXvYqzP2WM1YtlF0SBmVfPnGG920D5rbbMnKbuW4nyHBhVIDNKvgRJh8T1gXSY2BE1q4Fz9pmUvjDlR+RwkiHplYQE=
X-Received: by 2002:aca:d64f:: with SMTP id n76mr15932589oig.79.1570882925734; 
 Sat, 12 Oct 2019 05:22:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Sat, 12 Oct 2019 05:22:05
 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Sat, 12 Oct 2019 05:22:05
 -0700 (PDT)
In-Reply-To: <20191012071307.14314-1-philmd@redhat.com>
References: <20191012071307.14314-1-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 12 Oct 2019 14:22:05 +0200
Message-ID: <CAL1e-=jC7+1EAsry8D5N9-L_o2oiuOWHWDyj1uJgt4bpEc0GJQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Replace tab indent by spaces in the Status
 description
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c5add60594b5aedf"
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c5add60594b5aedf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

12.10.2019. 09.16, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> =D1=98=
=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> The Status description has a mix of tabs and spaces and displays
> unaligned. Unify using spaces.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3ca814850e..b9093e4dac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24,15 +24,15 @@ Descriptions of section entries:
>         Q: Patchwork web based patch tracking system site
>         T: SCM tree type and location.  Type is one of: git, hg, quilt,
stgit.
>         S: Status, one of the following:
> -          Supported:   Someone is actually paid to look after this.
> -          Maintained:  Someone actually looks after it.
> -          Odd Fixes:   It has a maintainer but they don't have time to d=
o
> -                       much other than throw the odd patch in. See below=
.
> -          Orphan:      No current maintainer [but maybe you could take
the
> -                       role as you write your new code].
> -          Obsolete:    Old code. Something tagged obsolete generally
means
> -                       it has been replaced by a better system and you
> -                       should be using that.
> +          Supported:   Someone is actually paid to look after this.
> +          Maintained:  Someone actually looks after it.
> +          Odd Fixes:   It has a maintainer but they don't have time to d=
o
> +                       much other than throw the odd patch in. See below=
.
> +          Orphan:      No current maintainer [but maybe you could take
the
> +                       role as you write your new code].
> +          Obsolete:    Old code. Something tagged obsolete generally
means
> +                       it has been replaced by a better system and you
> +                       should be using that.
>         F: Files and directories with wildcard patterns.
>            A trailing slash includes all files and subdirectory files.
>            F:   drivers/net/    all files in and below drivers/net
> --
> 2.21.0
>
>

--000000000000c5add60594b5aedf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
12.10.2019. 09.16, &quot;Philippe Mathieu-Daud=C3=A9&quot; &lt;<a href=3D"m=
ailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=
=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; The Status description has a mix of tabs and spaces and displays<br>
&gt; unaligned. Unify using spaces.<br>
&gt;<br>
&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philm=
d@redhat.com">philmd@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0MAINTAINERS | 18 +++++++++---------<br>
&gt; =C2=A01 file changed, 9 insertions(+), 9 deletions(-)<br>
&gt;</p>
<p dir=3D"ltr">Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:amark=
ovic@wavecomp.com">amarkovic@wavecomp.com</a>&gt;</p>
<p dir=3D"ltr">&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index 3ca814850e..b9093e4dac 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -24,15 +24,15 @@ Descriptions of section entries:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Q: Patchwork web based patch tracking syst=
em site<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 T: SCM tree type and location.=C2=A0 Type =
is one of: git, hg, quilt, stgit.<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 S: Status, one of the following:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Supported:=C2=A0 =C2=A0Someone is =
actually paid to look after this.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Maintained:=C2=A0 Someone actually=
 looks after it.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Odd Fixes:=C2=A0 =C2=A0It has a ma=
intainer but they don&#39;t have time to do<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0much other than throw the odd patch in. See below.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Orphan:=C2=A0 =C2=A0 =C2=A0 No cur=
rent maintainer [but maybe you could take the<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0role as you write your new code].<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Obsolete:=C2=A0 =C2=A0 Old code. S=
omething tagged obsolete generally means<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0it has been replaced by a better system and you<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0should be using that.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Supported:=C2=A0 =C2=A0Someone is =
actually paid to look after this.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Maintained:=C2=A0 Someone actually=
 looks after it.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Odd Fixes:=C2=A0 =C2=A0It has a ma=
intainer but they don&#39;t have time to do<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0much other than throw the odd patch in. See below.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Orphan:=C2=A0 =C2=A0 =C2=A0 No cur=
rent maintainer [but maybe you could take the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0role as you write your new code].<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Obsolete:=C2=A0 =C2=A0 Old code. S=
omething tagged obsolete generally means<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0it has been replaced by a better system and you<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0should be using that.<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 F: Files and directories with wildcard pat=
terns.<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0A trailing slash includes all=
 files and subdirectory files.<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0F:=C2=A0 =C2=A0drivers/net/=
=C2=A0 =C2=A0 all files in and below drivers/net<br>
&gt; -- <br>
&gt; 2.21.0<br>
&gt;<br>
&gt;<br>
</p>

--000000000000c5add60594b5aedf--

