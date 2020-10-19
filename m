Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C32C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:45:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E5F22268
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R55ieoV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E5F22268
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUTb7-0002YE-J9
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 07:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUTZs-00010K-LF
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:43:48 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:39954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUTZq-0008SK-Es
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:43:48 -0400
Received: by mail-ed1-x544.google.com with SMTP id p13so9878776edi.7
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 04:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lhRyiaF4Mj4SAFapWDuVKTR91M4N1ZAMCfQG7PSQtZE=;
 b=R55ieoV4chafnTnejfeCIzez71tOjmqPt6Eaa9gpHowReSiqasMTu6h/2iyTbC51Sd
 6qF4op744gdzUEn6hhBRNK860EHqYz2fvdMvGVIWexAZ3R34PR9aDJcgponBXclqPfsY
 Y8wiWlbdaLzy12g+MuBTSN6Gsu1D2DW19vIyb48KXeoB2Q030VvzalZMPdzV9vFYbFIb
 NBm0lKET3zw78IUd4Dsw/mnl1zb7Tv/IZo3rID/MPO2tujGJyLnblNuzy2P+B1WzAsEn
 X1LG7G6PAzvWUbXPogSiaxbOpPedR+fzm+7USziBdsrLxyiUmb7bFpmyIxqKvKHlSkTK
 3QHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lhRyiaF4Mj4SAFapWDuVKTR91M4N1ZAMCfQG7PSQtZE=;
 b=O3Hgi5IV8w1sLjuHv+y4Ch7QNzPa1wWz3lMBeKReCH4lD4uqSigOjXNpZHji2LRQy/
 AUSBtMZxk3WPQHsUH1BPZ36dukDW0gMcLAIW5mM+ZyAJwqoExstAn1PE18r3JbTY0YkE
 iZL+0mQKTcdzFOkHGLfarYeH/3JT5gU0LI6zAe7XhGUxvtYNuywIocUeZxmjSv7WPO33
 6qlk1+IUY2eBDiXm+YO4owqrSySgC2U0g8yA+mFMvOGRc4RZ/MrOjeRCLhu/HUr9Uk/P
 F+m12TdmatwKv8OIC4tWpQRKgLgdHbLhmmWfYa4JN4/QT1Kj6Hcfbdtrrbopa9EG5pJ9
 EW/Q==
X-Gm-Message-State: AOAM532Ne9MkdlaLB3FUs/zCVOZY+qENYFhdYCCqaBC3UEPlcfN7EkL5
 rCMiVKsncldrdxDXGdfNrEOSsqbRuLlNb+8iEdqACQ==
X-Google-Smtp-Source: ABdhPJyWN6vu70FNoDT+mUde/Oxrsko4OlVYRLt7U8r4v0TFnpNAU3f+Bg5gCpqSY5aGvzYrrda8cyfIAg2ZyBrRK8Y=
X-Received: by 2002:aa7:c683:: with SMTP id n3mr17448774edq.146.1603107824651; 
 Mon, 19 Oct 2020 04:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201015040639.70C6D414009F@webmail.sinamail.sina.com.cn>
 <7fecfc67da4caab1d677a8b4cd5386b3@kernel.org>
 <20201015133505.ubxvbrt6xyvl4362@kamzik.brq.redhat.com>
 <16400df4bdf79b8b22e824eb1a20e2b4@kernel.org>
 <20201015144104.ytwzpxjlsgyun3ob@kamzik.brq.redhat.com>
 <CAFEAcA-LBmbjp-Teb35f=O-1QtMLd8bAuq5XaCz9URdQZ1jxow@mail.gmail.com>
 <20201019092525.ekvgbcwwtm63pueu@kamzik.brq.redhat.com>
 <20201019113157.GN32292@arm.com>
In-Reply-To: <20201019113157.GN32292@arm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2020 12:43:33 +0100
Message-ID: <CAFEAcA8oncKmGxKGEZBg9Pnm4hjSO8u9KSv4YxFWxX0+LJ5E2g@mail.gmail.com>
Subject: Re: Kernel patch cases qemu live migration failed.
To: Dave Martin <Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
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
Cc: Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
 xu910121@sina.com, qemu-devel <qemu-devel@nongnu.org>,
 kvmarm <kvmarm@lists.cs.columbia.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Oct 2020 at 12:32, Dave Martin <Dave.Martin@arm.com> wrote:
> I'm not quite sure about Peter's assessment here.
>
> I agree with the inconsistency identified here: we always enumerate all
> unallocated ID regs, but we enumerate ID_AA64ZFR0_EL1 conditionally.
> This doesn't feel right: on a non-SVE guest, ID_AA64ZFR0_EL1 should
> behave exactly as an unallocated ID register.
>
> I'm not sure about the proposed fix.
>
> For one thing, I'm not sure that old hosts will accept writing of 0 to
> arbitrary ID regs.  This may require some digging, but commit
> 93390c0a1b20 ("arm64: KVM: Hide unsupported AArch64 CPU features from guests")
> may be the place to start.

Well, ID regs are special in the architecture -- they always exist
and must RAZ/WI, even if they're not actually given any fields yet.
This is different from other "unused" parts of the system register
encoding space, which UNDEF.

Older hosts didn't permit writing 0 to all parts of the ID
register space (and didn't list all ID registers in the KVM_GET_REG_LIST
list), but that was a kernel bug which we've since fixed.
(QEMU has workaround code for pre-4.15 kernels for this.)
Across that older bugfix, migration works from an old kernel to
a newer one, but wouldn't have worked from a post-bugfix kernel
to a pre-4.15 one.

> My original idea was that at the source end we should be conservative:
> enumerate and dump the minimum set of registers relevant to the
> target -- for compatibility with old hosts that don't handle the
> unallocated ID regs at all.  At the destination end, modern hosts
> should be permissive, i.e., allow any ID reg to be set to 0, but don't
> require the setting of any reg that older source hosts might not send.

The problem is that you've actually removed registers from
the list that were previously in it (because pre-SVE
kernels put this ID register in the list as a RAZ/WI register,
and now it's not in the list if SVE isn't supported).

> So, I think that instead of changing the ID_AA64ZFR0_EL1 behaviour,
> parhaps we should move all ID_UNALLOCATED() regs (and possibly
> ID_HIDDEN(), not sure about that) to have REG_HIDDEN_USER visibility.

What does this do as far as the user-facing list-of-registers
is concerned? All these registers need to remain in the
KVM_GET_REG_LIST list, or you break migration from an old
kernel to a new one.

thanks
-- PMM

