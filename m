Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88F0C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B839207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9op1vm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B839207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDY27-0007yk-M1
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 15:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDY1N-0007YA-Jc
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:02:14 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:36928)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDY1L-0007a8-Fl
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:02:13 -0400
Received: by mail-lf1-x141.google.com with SMTP id z19so404102lfr.4
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 12:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=5TCONfHYjFOAMEhCAt4e+ATddQxcV8124gr6RdxN27c=;
 b=r9op1vm+E/pWI5vEkRiFjVPH7iafVP/6lvZNfRAlvIwUzJX1he6k4C+BfqOusarK9f
 YJIXa/Nh5gcE3ef4jptdnQacX4VbodE+oBlLFjxabkIpjL2uyRXO0xpnel+7R3hR7A3R
 ulyV1szeUrWJoEY55JSRLAVNLUxdngG5nTOqhd25c9BVZUgEoaZtB9W1MS9u4CQCqYUG
 iFE3wNofHu0cmW61+NYrdsHD1rOnvWxljEA/NLLcFvzXRCYbZ8Aa0KDPJWKgcapN7M8B
 raZ2CfVEGISMWp/oQuIwIC0WI2OO8ki37LJRBvct13L06Oseqn8k+uYkt/Z3ye0dGNPO
 2QUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=5TCONfHYjFOAMEhCAt4e+ATddQxcV8124gr6RdxN27c=;
 b=BYt/W/RfTfiEE4pURog+NUyOtXY0WV4qHsV1WEt/owKyoqd6BSjf23/WsCZY1tXNeQ
 ap/64MjutYwgmUQ2gyeZGs1I/6+ny8smg68/Gcx2cLz+HsbBKs8E7ACy3PBu1UweUFd5
 XmuI6X9OUHCskOg2nDyFDrKhX0DWuXT695cGS3vkymMteCWYbaWrLP1oF2KMZZf/zHR2
 9jU12ljWuRgu5vUe8uRjYEdwl9II3rQQhYWeY7ewiJkufoCNM5jLL8dyOLR5zMzaVCAY
 NMPBN5puFn+MM1F7z0NV1T9qgS5NyaxUF4ZNErId7oId6WZbG8Gjb3Qy2FoceFkmvI0I
 taJA==
X-Gm-Message-State: AOAM533S3ui9r73/QhaobfdKF9av/KUWiVgmXDco17z2kMlWE2iZtq6m
 X+G2Z+mPC8GvShYKFJTbksUGSimP9GWSAIR89Dk=
X-Google-Smtp-Source: ABdhPJx8U2AYW0m6DLUGVc6r1ZOxcCBfUqGAXz5LhbkWkEZ399vTCHVopFWMSgo1EyR7wE6x40QFl2VjzKhGAvyg2K8=
X-Received: by 2002:a05:6512:4cb:: with SMTP id
 w11mr3949014lfq.33.1599073328508; 
 Wed, 02 Sep 2020 12:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200902170054.810-1-luoyonggang@gmail.com>
 <20200902170054.810-4-luoyonggang@gmail.com>
 <5cde63a0-46fe-2944-f96e-1f3268e49af8@amsat.org>
 <CAE2XoE8bsq7jzbw6FMW3TybhQGiNEJ-F_NKPm3LHzkHm69hSdw@mail.gmail.com>
 <19b8d23c-c2e7-2d8e-50de-a4e977bae786@ilande.co.uk>
 <CAE2XoE_yO5kkQBFzJk+FzspJG-3gHD0Xvf7BSkOk45qhp1h4PA@mail.gmail.com>
 <0b52fa43-fa48-0add-40e2-cf3f06983c0c@ilande.co.uk>
In-Reply-To: <0b52fa43-fa48-0add-40e2-cf3f06983c0c@ilande.co.uk>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 3 Sep 2020 03:01:56 +0800
Message-ID: <CAE2XoE-DyKcYMDR2KsZA=1-7zr4jXOMh9ZMSA7OA=tbo4tr0PQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] ci: Install msys2 in a proper way refer to
 https://github.com/cirruslabs/cirrus-ci-docs/issues/699 Enable msys2 ci in
 cirrus
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/alternative; boundary="000000000000b733ec05ae594591"
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b733ec05ae594591
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
>
> Yes indeed, it looks like a very comprehensive build :)  Note that with
> the meson
> build I no longer have to copy/rename toolchain exes compared to your
> .cirrus.yml
> file so maybe that issue is now fixed?
>
> That's not fixed, I am building a full build, so I will use any possible
toolchain, and you may not use it at all.

>
> ATB,
>
> Mark.
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000b733ec05ae594591
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
Yes indeed, it looks like a very comprehensive build :)=C2=A0 Note that wit=
h the meson<br>
build I no longer have to copy/rename toolchain exes compared to your .cirr=
us.yml<br>
file so maybe that issue is now fixed?<br>
<br></blockquote><div>That&#39;s not fixed, I am building a full build, so =
I will use any possible toolchain, and you may not use it at all.=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
ATB,<br>
<br>
Mark.<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000b733ec05ae594591--

