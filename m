Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465ABC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:04:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1050F2083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="warS5U3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1050F2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixAR5-0001be-A7
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 09:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixAQI-0000gT-1U
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:03:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixAQG-0003lL-In
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:03:57 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45741)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixAQG-0003ke-6S
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:03:56 -0500
Received: by mail-oi1-x243.google.com with SMTP id v19so3533735oic.12
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 06:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+iZsjgsZakLtp6vowX2UviTy1HwcCzzv58SPakeE/f0=;
 b=warS5U3jI+nfBBZmMjN08U3zX3wbr/EKi7+YEZsJGrKnozxfcDtDdi0vcH40pW8WyR
 xQ+1AQ4Ff7t7oM2xo1oV7qsKQYJxiYFQepPpwKR4efAO2vwGlkq7FvBku3WYhlaBrDz3
 zAhpoSqtFV07ErIufrfOEatB/PasVrVs56La7TuY1bM47GsPW8V6WUxtQqqTJlpOf5K4
 nO3ipDPX3TS7+1Y6sbCxkz2ojEKjMydqOe7DNmrpH5jigJfDnd9VmHIKplRA2KluT4Dt
 pjgC/SHVTxNTi2nXMVYMnhKWFkEPwn0lv+eY51pVFZKumES5ffItoGkJh4WzYpbIz1RD
 dllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+iZsjgsZakLtp6vowX2UviTy1HwcCzzv58SPakeE/f0=;
 b=OC4ixJQnt4NkfCGaPEmoQtoXwLK6ubS/Ou6diLFOG7zK8HWFXkrXp8ArYT49yJ0b7G
 F8X4h49Cpvd85YV5OM39+sa2B0BSSaWu6YS9EMr/bjabXnB3G/x07mG/Srpfz6R1AnU1
 uZiQUmKo3+SUd5oFEIT2dbrVFbCyp26V15mVXZWEs9DdlSNrvbNtMcvTx9Q0rxBhncZd
 VqY6D6h0dyEZxlFqdlrtCPHpME/yxOxpSpCcNGXs353ZHxScMXRfTCXNiu3Nsmh1nVMy
 oDrV3l4M6B01Ly8P27D/lK0eL8iSNlyH5Eq+T0a+RXqh2gvTq6fZNX2QgbtLE+qY7Jlr
 gj8Q==
X-Gm-Message-State: APjAAAXPishnAty1r8cZ26ItCSYwbY/upAMbxX9dx97ivu0Wc2OpkL/+
 L0kepQiIczAwkxkk8SZYxybu/PpHTFvmmP5oVUzA2g==
X-Google-Smtp-Source: APXvYqzxvy87xbQ6kIC63XdTIzKDOn1YjfuQUR+7MXWG/OSk7jFKlCe8eE3Fa10ZTBOEHMhZ5zca3hH3eC6HaiM1Qf4=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr2953620oid.98.1580393035139;
 Thu, 30 Jan 2020 06:03:55 -0800 (PST)
MIME-Version: 1.0
References: <20200119133051.642-1-yuzenghui@huawei.com>
In-Reply-To: <20200119133051.642-1-yuzenghui@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jan 2020 14:03:44 +0000
Message-ID: <CAFEAcA8igVrEjyChLmbkeQb+gXYMCVhtgGwrNNKrZNaKKSp04w@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3_kvm: Stop wrongly programming
 GICR_PENDBASER.PTZ bit
To: Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Marc Zyngier <maz@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 wanghaibin.wang@huawei.com, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 19 Jan 2020 at 13:32, Zenghui Yu <yuzenghui@huawei.com> wrote:
>
> If LPIs are disabled, KVM will just ignore the GICR_PENDBASER.PTZ bit when
> restoring GICR_CTLR.  Setting PTZ here makes littlt sense in "reduce GIC
> initialization time".
>
> And what's worse, PTZ is generally programmed by guest to indicate to the
> Redistributor whether the LPI Pending table is zero when enabling LPIs.
> If migration is triggered when the PTZ has just been cleared by guest (and
> before enabling LPIs), we will see PTZ==1 on the destination side, which
> is not as expected.  Let's just drop this hackish userspace behavior.
>
> Also take this chance to refine the comment a bit.

I pulled up the original code-review discussion where this code
was added:
https://lists.gnu.org/archive/html/qemu-devel/2015-10/msg05889.html

It looks like the original reason for adding it was that the
GICR_PENDBASER.PTZ bit is write-only, and so there's no way for
the migration code in QEMU to accurately restore it on the
destination end of a migration. So Pavel picked a heuristic
for guessing what the right value of the PTZ bit was.

It sounds like the penalty if userspace sets the bit to 0
always on a migration is not significant, so I guess that
just setting this bit to 0 always is an OK thing to do (as you
say, there's a window in the existing implementation where
we do the wrong thing sometimes if migration happens at the
wrong time, because the current code's heuristic can
sometimes fail in the wrong direction).

Applied to target-arm.next.

thanks
-- PMM

