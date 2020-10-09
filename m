Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A578C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 11:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 988C822272
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 11:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AN2qrJmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988C822272
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQqME-0000y6-EM
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 07:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQqIn-0006Ky-BL; Fri, 09 Oct 2020 07:11:09 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:44111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQqIj-00007u-0t; Fri, 09 Oct 2020 07:11:09 -0400
Received: by mail-lf1-x143.google.com with SMTP id b1so6891403lfp.11;
 Fri, 09 Oct 2020 04:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=3CPuO7I8eoYKkXE8k4B1pfLZ919K+JefxhSSs/CXInI=;
 b=AN2qrJmULQYRsOuxO+d9AEA8L6BgfSj4ziDr+rYtPQVrZTt08BCKi5/5nrNTAmFkyI
 ZoRFY+gmoDPKdLedLk8ZXMqoXtydfoE6WT7ost1LHXfq3bbd5F+08cCWcNdn5UWbQ3+O
 fM09OSbSA/p9p3pbbugyY03N2lTxrd8UB7rslXTVWLo+kIl/lHlKYjGDjWPTVIoDvp5M
 eZebggCNv86h7D7UACDZPMRyXnzO1vZEZt3qaLpKF6xdeZBmkJA70E0XF1HWocx5A+qt
 9qqYmPh04pOQ5QHYdsNy3CJd/cD/93eZe7aLBtUBh92eCmlN+XiQcm2YCDTNrECOIUHY
 k09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=3CPuO7I8eoYKkXE8k4B1pfLZ919K+JefxhSSs/CXInI=;
 b=ApCm+93GHsQx9noooEqH1RPuhPdoTxw0YwIq7IyqJk35qdFxHTtneIFw9VetjGLGKg
 nKHvYvwgNZBSYorbPJxaD7qiTP/OCYapk5ouNHNk2wd3MNjJANEwrT3hs96krKh6AzCM
 8ub0NKQ0V7bwpnde19WkmCw2EcOLFEGrRn7sEeGh/p+jjLPHTZFCPXI/bwELhac17EG+
 ETxfM20vc/bmH8tDrnK2QAVqcbP2icMwXfbYpQIjlBQAllbMzpsfffanZDx4hvouk99r
 Qb3Sh2TvfWgyCG356gRnLqCHBGrztQlBvA1PalA3tn6IvWDFIZ+v6pAUkmBJjQaMlVNw
 hk3g==
X-Gm-Message-State: AOAM531S282Z1LkvRCvYt+1iZsta1L7Ca0rxZgZ+EISyecRJz863zxXC
 Js+k42QqwHDKhOjTXh7YS4OaomwNFwQOE17xXo+DuDqUX7dopA==
X-Google-Smtp-Source: ABdhPJyTtsCtSx3F21Wr6OHJlwZj9eKOD340OfXcJOAqocqq0HGSOFY0epzRp0aDrDunxJLpzJXQFHHKw4O30UhyIvE=
X-Received: by 2002:a05:6512:3f0:: with SMTP id
 n16mr3837533lfq.554.1602241862607; 
 Fri, 09 Oct 2020 04:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201009110800.432-1-luoyonggang@gmail.com>
In-Reply-To: <20201009110800.432-1-luoyonggang@gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 9 Oct 2020 19:10:51 +0800
Message-ID: <CAE2XoE8Wq0N2iBS5mQ+kPPVUwTEDSAeW8qpYnWrj1F6V099ypQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Improve cirrus msys2
To: qemu-level <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000010a7af05b13b01eb"
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x143.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000010a7af05b13b01eb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, alex, the msys2 main repo are back, so I removed the university mirror

On Fri, Oct 9, 2020 at 7:08 PM Yonggang Luo <luoyonggang@gmail.com> wrote:
>
> Fixes the broken msys2/mingw ci and speed it up.
>
> V5-V6
> Remove the university mirror, the main repo are back.
> rename to setup_script.
> Add fixes for msys2/mingw rST document fixes
>
> V4-V5
> Now the cache are usefull by using 7zip to archive msys64
> Saved about 18min, compare
> https://cirrus-ci.com/task/5093551157542912
> https://cirrus-ci.com/task/6177196538593280
>
> V3-V4
> Using cirrus cache to speed up msys2 ci instead of downloading archive
file
>
> V2-V3
> Add one more patch:
> cirrus: msys2/mingw speed is up, add excluded target back
> Do not build sphinx on windows, that's failing
> set the number of parallel count to fixed number 8
>
> V1-V2
> Resolve the cirrus conflict
>
> Yonggang Luo (4):
>   cirrus: Fixing and speedup the msys2/mingw CI
>   cirrus: msys2/mingw speed is up, add excluded target back
>   docs: Fixes build docs on msys2/mingw
>   cirrus: Enable doc build on msys2/mingw
>
>  .cirrus.yml                   | 119 ++++++++++++++++++++--------------
>  docs/conf.py                  |   2 +-
>  docs/sphinx/kerneldoc.py      |   2 +-
>  scripts/rst-sanitize.py       |  21 ++++++
>  tests/qapi-schema/meson.build |   5 +-
>  5 files changed, 98 insertions(+), 51 deletions(-)
>  create mode 100644 scripts/rst-sanitize.py
>
> --
> 2.28.0.windows.1
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000010a7af05b13b01eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, alex, the msys2 main repo are back, so I removed the u=
niversity mirror<br><br>On Fri, Oct 9, 2020 at 7:08 PM Yonggang Luo &lt;<a =
href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt; wrote:<=
br>&gt;<br>&gt; Fixes the broken msys2/mingw ci and speed it up.<br>&gt;<br=
>&gt; V5-V6<br>&gt; Remove the university mirror, the main repo are back.<b=
r>&gt; rename to setup_script.<br>&gt; Add fixes for msys2/mingw rST docume=
nt fixes<br>&gt;<br>&gt; V4-V5<br>&gt; Now the cache are usefull by using 7=
zip to archive msys64<br>&gt; Saved about 18min, compare<br>&gt; <a href=3D=
"https://cirrus-ci.com/task/5093551157542912">https://cirrus-ci.com/task/50=
93551157542912</a><br>&gt; <a href=3D"https://cirrus-ci.com/task/6177196538=
593280">https://cirrus-ci.com/task/6177196538593280</a><br>&gt;<br>&gt; V3-=
V4<br>&gt; Using cirrus cache to speed up msys2 ci instead of downloading a=
rchive file<br>&gt;<br>&gt; V2-V3<br>&gt; Add one more patch:<br>&gt; cirru=
s: msys2/mingw speed is up, add excluded target back<br>&gt; Do not build s=
phinx on windows, that&#39;s failing<br>&gt; set the number of parallel cou=
nt to fixed number 8<br>&gt;<br>&gt; V1-V2<br>&gt; Resolve the cirrus confl=
ict<br>&gt;<br>&gt; Yonggang Luo (4):<br>&gt; =C2=A0 cirrus: Fixing and spe=
edup the msys2/mingw CI<br>&gt; =C2=A0 cirrus: msys2/mingw speed is up, add=
 excluded target back<br>&gt; =C2=A0 docs: Fixes build docs on msys2/mingw<=
br>&gt; =C2=A0 cirrus: Enable doc build on msys2/mingw<br>&gt;<br>&gt; =C2=
=A0.cirrus.yml =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 119 ++++++++++++++++++++--------------<br>&gt; =C2=A0docs/conf.py =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 2 +-<br=
>&gt; =C2=A0docs/sphinx/kerneldoc.py =C2=A0 =C2=A0 =C2=A0| =C2=A0 2 +-<br>&=
gt; =C2=A0scripts/rst-sanitize.py =C2=A0 =C2=A0 =C2=A0 | =C2=A021 ++++++<br=
>&gt; =C2=A0tests/qapi-schema/meson.build | =C2=A0 5 +-<br>&gt; =C2=A05 fil=
es changed, 98 insertions(+), 51 deletions(-)<br>&gt; =C2=A0create mode 100=
644 scripts/rst-sanitize.py<br>&gt;<br>&gt; --<br>&gt; 2.28.0.windows.1<br>=
&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<=
br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 since=
rely,<br>Yonggang Luo</div>

--00000000000010a7af05b13b01eb--

