Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D248BC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9F9206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DEozrOHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9F9206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNBTx-0004mC-1t
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 04:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNBSx-0003VU-Cr
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:58:31 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:47056)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNBSv-0000Vj-K2
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:58:31 -0400
Received: by mail-ej1-x643.google.com with SMTP id z23so13818295ejr.13
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 01:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G4NWW82W+5zt0Px1qaZ+spEY5xGGEI0i9tHBKTL1qd4=;
 b=DEozrOHfDkDxaIyrLJbjNyU3Hi7Ebi0GHx9RNVTlUL9CurU7c001jcGxuonHP1ymqy
 jxFNq7bclGkV3srvWOtJFyBspO48CD+kUBms9pi67sWgMJHIyWYDIci9Ofad6zpNVmuw
 N++bJS+n6vsNGHOEibzTJ/0kCo4AgKYGlMHfZer1+4lVuFWQ7dE5MpL8Ro6aI7Nnt8je
 vgB5ip+S4QW/TXzyq6dEsFu9VbCFjmriGMBBG4w/G2N7G6SDw1zyw6cf75TrBR27us9P
 pG28G+aAFUaCWoGZUN3UUbCYoc5wvOAt0dnQaT2GYapBHZAzwW0kfS0OYPVBwb1D6XX3
 O8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G4NWW82W+5zt0Px1qaZ+spEY5xGGEI0i9tHBKTL1qd4=;
 b=DrIBVb5kijFMg9oLhDGQimrDTag1+smJKLS5d5+uwIDdQTnVMMobg4737vT6V2Tjsm
 e9y6dvD2M+mPpmkrY2cIVFJ0PL1AFryZBH83wOpqhDhC0WPy7Fo8wYqfizn8oP2kEHTS
 yiJVNjklnsmhoGBGgdnC93eZtZmF/7xAn6DW1XXfOkUos7Ye7eKTLarqWqUOk6D6oJwN
 psiW/i5atD/47dNj4fOcJnu1v7Y4L0SxEyCUa6sBxBCOMZCXu4+EluxiT+zdFSHSHRQF
 EnAHYQRrVuAu5XtyNKaX52TLWyikN+dxWizx5kZV1SpYVEVJYIlsj+P+ZTb3+9sfTFFP
 7F7Q==
X-Gm-Message-State: AOAM533wiR6u5G9Pj2IcPyzb752lobuF6ldbOyM9YKcjAWlIZkGHObGe
 j4oSHx1PAsS2BUIX7nQ+omgoik4cCZwtGZMi/kDknbNEiAmtyA==
X-Google-Smtp-Source: ABdhPJydcCniWfOe9kLdzfRsz01AoS5Kn0C0NfS028r4CVmAQfWlPEXy9AC71RYOKci4svntLSiucEBJ1UYcVt73kFw=
X-Received: by 2002:a17:906:71c9:: with SMTP id
 i9mr2762865ejk.250.1601369908304; 
 Tue, 29 Sep 2020 01:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200928131934.739451-1-philmd@redhat.com>
 <20200928131934.739451-8-philmd@redhat.com>
 <dcb7bb1f-eaec-7039-1cbd-80e50d298707@netbsd.org>
In-Reply-To: <dcb7bb1f-eaec-7039-1cbd-80e50d298707@netbsd.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 09:58:17 +0100
Message-ID: <CAFEAcA9B-RMKxzfTv3RQ-a5EP3yGdNmdcyn4KJSKXB_c_wVX1Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] qemu/bswap: Use compiler __builtin_bswap() on
 NetBSD
To: Kamil Rytarowski <kamil@netbsd.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Sep 2020 at 23:02, Kamil Rytarowski <kamil@netbsd.org> wrote:
>
> Personally, I prefer using the system headers. but if you want to use
> the GCC builtins, please go for it.

I'd agree if the system header approach was cross-platform
or if this was a BSD-only program or if we were aiming for
complete compiler-implementation independence, but since we
rely on GCC/clang all over the place already it seems nicer to
avoid all the machinery for identifying which of the multiple
different system header implementations is present, and
instead just have a single implementation that works on
all the hosts we care about...

thanks
-- PMM

