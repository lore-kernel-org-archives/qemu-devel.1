Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA32C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 20:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6CA7212CC
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 20:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uqNwEpUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CA7212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsBgm-0003Im-Su
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 16:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsBeQ-0007WL-8b; Sun, 05 Jul 2020 16:54:14 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:38254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsBeO-0001Yb-QD; Sun, 05 Jul 2020 16:54:13 -0400
Received: by mail-pj1-x1043.google.com with SMTP id k5so6531980pjg.3;
 Sun, 05 Jul 2020 13:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Vc/HBrgID2IsA3qadurmoqsX6c2eBRLY7r2F4iMCf3s=;
 b=uqNwEpUSeEUZGVi51/V9GifUKUpplX6pZF6FIk9ijhpZBnGV0kSWkY9/mZr6u2fSHc
 xYVZCqxqvejmCV9TbmH46DeGqhtMKvPzCsDfoXPcDTMzBmYZjkhzWr7OM4o+QgmCOlwB
 4U9I7h1Sn1SEfI2+0W5ayrFSZtaKBXb7fJ51wZY60Y2NgWZcK4T3gOLgiI6yYbP7Jtmq
 9Rdf35MlNOO/yCGdVd2UkEzMLOslkoM/sD9hOSJd8nyocBbNCdzt3f6iQ0lCPyYN+LOc
 0ymWogWcbWoWJEYqXajU3dpLS3z48jtVddLRZYq52Zo8d2zbVXKtSIGvu1Zi71Py3NXh
 H8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Vc/HBrgID2IsA3qadurmoqsX6c2eBRLY7r2F4iMCf3s=;
 b=SbG1kqWjtD4DinASIDIShqFrMfoB8jdQWIclFdKIw9WNx6ULu5h6DGEKVqd1wuaCym
 0Xi2rNQHtrrQ2B8LEaF6i/SHc22pouQqB+c1F0b03WUjVgZoVlySqnmg89ndQudlN6tD
 A/iCcE4VUCMwi7KMgq6UEGdb1LDiPjIm9nXyQ9bo+J4JW9GrtGL/yCw+RY92Po6njddR
 skOZm6o24QVFauovEx6JWe/hPqVov0yzY4QkvN4ARSsxADRV1ZKFaGbCU5epuSaQR3lz
 LlrNmurlHOJSd620Sa2/52075GpEzLEhHUDXQ+mBDg5+aw457lfqTC+jGexr8hTSQfK8
 cjrw==
X-Gm-Message-State: AOAM530lsAFmFG9PnQBoIXAxvncDL4NRKoT3yHDUPrO9XzWTOppUdfF4
 YAJwxAsyP7TwFJp66f+fBKJk8EmV2af8pIa9zIQ=
X-Google-Smtp-Source: ABdhPJytteY4dHGHW3TQFV1zMy/0pQ96RrHIWNbpVQztA58X1KG2s9EDNzZiaS+jsXACR6FVgrYgHqahqwRASTUM0fs=
X-Received: by 2002:a17:902:b694:: with SMTP id
 c20mr38184926pls.123.1593982450781; 
 Sun, 05 Jul 2020 13:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200629160535.3910-1-wentong.wu@intel.com>
 <20200629160535.3910-3-wentong.wu@intel.com>
 <3260735e-05ab-2d42-f7e4-914ad804f543@linaro.org>
 <CAFEAcA_+e7hrA5GRGb=gv3GxJRL77ARP34vyudRbiqhdsNVKwg@mail.gmail.com>
 <CAMo8BfLVDEFCXWNffVJaRb31UOTPO1iXNz5StexoKvWqQYzg6g@mail.gmail.com>
In-Reply-To: <CAMo8BfLVDEFCXWNffVJaRb31UOTPO1iXNz5StexoKvWqQYzg6g@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 5 Jul 2020 13:53:59 -0700
Message-ID: <CAMo8Bf+Fk32dYH6GV6Z6OWLsnpJy4Sw_ny+8yviQc6MjGD+mRw@mail.gmail.com>
Subject: Re: [PATCH 3/3] target/nios2: Use gen_io_start around wrctl
 instruction
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Wentong Wu <wentong.wu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jul 5, 2020 at 11:16 AM Max Filippov <jcmvbkbc@gmail.com> wrote:
> On Sun, Jul 5, 2020 at 10:09 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> > On Thu, 2 Jul 2020 at 19:53, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> > > This isn't right.  Not so much the gen_io_start portion, but the entire
> > > existence of helper_check_interrupt.
> > I agree that it looks bogus (xtensa has a similar helper as well, incidentally),
> I think there was a reason for it.

...and the reason is that this helper calls cpu_[re]set_interrupt
to update CPU_INTERRUPT_HARD, which makes exit to the
main CPU loop do something to handle IRQ.
Maybe 'check_interrupt' is not a good name for that, but the
action taken there seems right to me.

-- 
Thanks.
-- Max

