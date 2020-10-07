Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2A7C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6433B208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmhU+Qcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6433B208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQAuS-0001m7-9Y
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 10:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQAru-0007hF-LD; Wed, 07 Oct 2020 10:56:38 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:45563)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQArs-0007EM-Jx; Wed, 07 Oct 2020 10:56:38 -0400
Received: by mail-lj1-x241.google.com with SMTP id a4so2253463lji.12;
 Wed, 07 Oct 2020 07:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=KEBpAeWU5Zy5B8JqteBkDPWXaSVE6DdEnGqGKd7z9Bg=;
 b=FmhU+Qcx47GqcbQxXtCGk2FTG90LmY4W41GZ6ueA8X8dm/1mKVW/EaUlbudivzYMjl
 piEk9ztE4I5mjf9A4OeDcYHDYb78LPmCXnYa+/VndCHRdZkO+AqDL999QMwrEKMFA49I
 suarothr42qZ56gSPM7XtS51M+Ghw9PyGXFcyvskGsXTzA4Td/0f5f+HOhnCzC2OCWEQ
 2hwz/54PPNCLVEEEDF2YG4b6FZmLzR5jhbtZnsrU4Qpn0k1DgvgkZjsCwhpgUff8CV5u
 deJ6IZNQcjyKqUjQO9OiF6F6CW3/dfPXwm33b5ywQIowrhW1VCsX/eGEqlmcw0ASEMSQ
 /ODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=KEBpAeWU5Zy5B8JqteBkDPWXaSVE6DdEnGqGKd7z9Bg=;
 b=K3z1EvHwhTjfEUpyj19z49Q4iQNS7dbTFeQ3r0w8sS9jgyv3I9OWVko9aGdDbX+3LW
 odezjjJMxmYDYwAMCxxP4xNW1o8PIMVCEZbfMwj6K2Ho1CiOSu/KFRP1PoB0nhCxaFo7
 XD31Y3s9Puc4oPjxhMhu+GSzB/HpcvAY7rXlkHG/q6Nm/L/V9zAi1isxkCFxIMIkURgy
 BFvNO60sN3l2aH0KYReo9DWdGXIVIONWbzYzxLruq/fQ4jOQQeYCRajoCEG+7UPOOYLY
 kH6XT1DoM4uwfJcXr8r/tQJ6qdSRI9HezoGiJ7TDC1iwyFKt7l5K7BfxeZ99gs+1zDTg
 UpAA==
X-Gm-Message-State: AOAM532XpIl7Al+WycSwSx8nv2DfYqtNwCaD5IQwc40reB8Vp2ReBPt6
 MHFLyZ9pcalhPaoiYMbJl/fiFOrcqDunhv1wbEuiQXX8V+g=
X-Google-Smtp-Source: ABdhPJzsKfy+BuIV6jZwS0zw2LI03pl+2gynKLhXzwxlGRnZ9pXGYpMHN6BwLbgTgFfXeDwAkn5mMGRHOahwXLrYIBo=
X-Received: by 2002:a2e:8983:: with SMTP id c3mr1432602lji.171.1602082593326; 
 Wed, 07 Oct 2020 07:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201007145300.1197-1-luoyonggang@gmail.com>
In-Reply-To: <20201007145300.1197-1-luoyonggang@gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 7 Oct 2020 22:56:21 +0800
Message-ID: <CAE2XoE_5J07roLdUzPZzZx_KHvO-oLHSZGBSSw5wb42qD7vn0A@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Improve cirrus msys2
To: qemu-level <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000e04b0d05b115eb91"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x241.google.com
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

--000000000000e04b0d05b115eb91
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC Alex, now it's really fixed

On Wed, Oct 7, 2020 at 10:53 PM Yonggang Luo <luoyonggang@gmail.com> wrote:
>
> Fixes the broken msys2/mingw ci and speed it up.
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
> Yonggang Luo (2):
>   cirrus: Fixing and speedup the msys2/mingw CI
>   cirrus: msys2/mingw speed is up, add excluded target back
>
>  .cirrus.yml | 113 +++++++++++++++++++++++++++++++---------------------
>  1 file changed, 67 insertions(+), 46 deletions(-)
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

--000000000000e04b0d05b115eb91
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">CC Alex, now it&#39;s really fixed<div><br>On Wed, Oct 7, =
2020 at 10:53 PM Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">=
luoyonggang@gmail.com</a>&gt; wrote:<br>&gt;<br>&gt; Fixes the broken msys2=
/mingw ci and speed it up.<br>&gt;<br>&gt; V4-V5<br>&gt; Now the cache are =
usefull by using 7zip to archive msys64<br>&gt; Saved about 18min, compare<=
br>&gt; <a href=3D"https://cirrus-ci.com/task/5093551157542912">https://cir=
rus-ci.com/task/5093551157542912</a><br>&gt; <a href=3D"https://cirrus-ci.c=
om/task/6177196538593280">https://cirrus-ci.com/task/6177196538593280</a><b=
r>&gt;<br>&gt; V3-V4<br>&gt; Using cirrus cache to speed up msys2 ci instea=
d of downloading archive file<br>&gt;<br>&gt; V2-V3<br>&gt; Add one more pa=
tch:<br>&gt; cirrus: msys2/mingw speed is up, add excluded target back<br>&=
gt; Do not build sphinx on windows, that&#39;s failing<br>&gt; set the numb=
er of parallel count to fixed number 8<br>&gt;<br>&gt; V1-V2<br>&gt; Resolv=
e the cirrus conflict<br>&gt;<br>&gt; Yonggang Luo (2):<br>&gt; =C2=A0 cirr=
us: Fixing and speedup the msys2/mingw CI<br>&gt; =C2=A0 cirrus: msys2/ming=
w speed is up, add excluded target back<br>&gt;<br>&gt; =C2=A0.cirrus.yml |=
 113 +++++++++++++++++++++++++++++++---------------------<br>&gt; =C2=A01 f=
ile changed, 67 insertions(+), 46 deletions(-)<br>&gt;<br>&gt; --<br>&gt; 2=
.28.0.windows.1<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=
=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--000000000000e04b0d05b115eb91--

