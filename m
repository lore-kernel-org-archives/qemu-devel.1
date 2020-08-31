Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188FFC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:35:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28BA206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28BA206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrSM-0001Qq-TF
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrCw-0003KM-HL
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:19:18 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37523)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrCu-0001Vt-VM
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:19:18 -0400
Received: by mail-qt1-f195.google.com with SMTP id d27so5894873qtg.4
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PXHuyGMFN8Fp0t7Q1JaJVdLkVmSaGYKuDGs7sODlsMo=;
 b=nQObQmpOzbACA3QpaDzJeqak79fj2KeULY7XvuG3Vrxne+S9K2XfhqPWX0rg25CeDS
 pAhN5NJNZtBLW2BBgvNrIxALWOXaHAcY6XqIWYsp3NsiyFQLCt1cUkz1+hVMyKY1Avtx
 S0kS5ytcPB0pynt1hCru8srtTYr3J/ZOZ0pTh5uiv+Zh534hWVsghRoDpyOKItKGtJyf
 N9usvJ6qM3XIw9LdgyDv59tNOV8ur9DsKkN9pubGVQGwJvwjV/nNm6R9eDXAOu2xn4nq
 7qiLzPUkDwlwDiskTTrIsAT4zl1o6/9/iLALoURdaMmNgjMGtaQPbM8ECgaZ/H2mrVAI
 SuQA==
X-Gm-Message-State: AOAM533010Ti95rlCn4THh2ZNFxbDpunIfIvOFo2nNhor/fg1XQtnrQ6
 MjK7EbMHclgd2ptQ8cYxxm6Eo8Yszbt0ddS9uw6VEtUs
X-Google-Smtp-Source: ABdhPJwQqJHSrMYUlqw//cPzyf4WFiBR1s7TCmDK3v202z9wo//GDvqDGeBJaLNvnjQNJC9pnn7bucJvG0cLzuHmfrs=
X-Received: by 2002:aed:21a6:: with SMTP id l35mr3334674qtc.178.1598908756251; 
 Mon, 31 Aug 2020 14:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200827173051.31050-1-sw@weilnetz.de>
In-Reply-To: <20200827173051.31050-1-sw@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 22:01:07 +0200
Message-ID: <CAAdtpL508gaCmuencEu31H0bcQorUhywUXGkD-3ZukafjsdLzw@mail.gmail.com>
Subject: Re: [PATCH] docs/system: Fix grammar in documentation
To: Stefan Weil <sw@weilnetz.de>
Content-Type: multipart/alternative; boundary="00000000000071d72b05ae32f44d"
Received-SPF: pass client-ip=209.85.160.195;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-qt1-f195.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:15:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000071d72b05ae32f44d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 27 ao=C3=BBt 2020 19:31, Stefan Weil <sw@weilnetz.de> a =C3=A9crit =
:

> Signed-off-by: Stefan Weil <sw@weilnetz.de>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
>  docs/system/build-platforms.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/docs/system/build-platforms.rst
> b/docs/system/build-platforms.rst
> index c2b92a9698..9734eba2f1 100644
> --- a/docs/system/build-platforms.rst
> +++ b/docs/system/build-platforms.rst
> @@ -57,12 +57,12 @@ macOS
>  -----
>
>  The project supports building with the two most recent versions of
> -macOS, with the current homebrew package set available.
> +macOS, with the current Homebrew package set available.
>
>  FreeBSD
>  -------
>
> -The project aims to support the all the versions which are not end of
> +The project aims to support all versions which are not end of
>  life.
>
>  NetBSD
> @@ -75,5 +75,5 @@ new major version is released.
>  OpenBSD
>  -------
>
> -The project aims to support the all the versions which are not end of
> +The project aims to support all versions which are not end of
>  life.
> --
> 2.28.0
>
>
>

--00000000000071d72b05ae32f44d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Le jeu. 27 ao=C3=BBt 2020 19:31, Stefan Weil &lt;<a hr=
ef=3D"mailto:sw@weilnetz.de">sw@weilnetz.de</a>&gt; a =C3=A9crit=C2=A0:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">Signed-off-by: Stefan Weil &lt;<a href=
=3D"mailto:sw@weilnetz.de" target=3D"_blank" rel=3D"noreferrer">sw@weilnetz=
.de</a>&gt;<br></blockquote></div></div><div dir=3D"auto"><br></div><div di=
r=3D"auto"><span style=3D"font-family:sans-serif;font-size:13.696px">Review=
ed-by: Philippe Mathieu-Daud=C3=A9 &lt;</span><a href=3D"mailto:f4bug@amsat=
.org" style=3D"text-decoration:none;color:rgb(66,133,244);font-family:sans-=
serif;font-size:13.696px">f4bug@amsat.org</a><span style=3D"font-family:san=
s-serif;font-size:13.696px">&gt;</span><br></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
---<br>
=C2=A0docs/system/build-platforms.rst | 6 +++---<br>
=C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/docs/system/build-platforms.rst b/docs/system/build-platforms.=
rst<br>
index c2b92a9698..9734eba2f1 100644<br>
--- a/docs/system/build-platforms.rst<br>
+++ b/docs/system/build-platforms.rst<br>
@@ -57,12 +57,12 @@ macOS<br>
=C2=A0-----<br>
<br>
=C2=A0The project supports building with the two most recent versions of<br=
>
-macOS, with the current homebrew package set available.<br>
+macOS, with the current Homebrew package set available.<br>
<br>
=C2=A0FreeBSD<br>
=C2=A0-------<br>
<br>
-The project aims to support the all the versions which are not end of<br>
+The project aims to support all versions which are not end of<br>
=C2=A0life.<br>
<br>
=C2=A0NetBSD<br>
@@ -75,5 +75,5 @@ new major version is released.<br>
=C2=A0OpenBSD<br>
=C2=A0-------<br>
<br>
-The project aims to support the all the versions which are not end of<br>
+The project aims to support all versions which are not end of<br>
=C2=A0life.<br>
-- <br>
2.28.0<br>
<br>
<br>
</blockquote></div></div></div>

--00000000000071d72b05ae32f44d--

