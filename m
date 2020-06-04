Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAA6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 571B6206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d6lkZg00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571B6206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgq4k-0001nb-LV
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 09:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgq45-0000uY-Vv
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:37:50 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgq44-00062o-RX
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:37:49 -0400
Received: by mail-oi1-x243.google.com with SMTP id a21so5070708oic.8
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 06:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VzZ6Wiac3hkSNr5jQzhWPiHZxuLwzhsmIf66iTOTCD4=;
 b=d6lkZg00g4aEpYR7gFHX3mGWaI+f6OcmuiSIr1JuUdjzHQQA+cqQJJLp4LcWq+akqu
 ktc7fZV6YkLdsqjUgI6qm7SvZdOB+9/DhHTXBAFCwLfqI7OYzUvV79+1rZvZ3QqHtj3T
 YaM7mP1rp0DNmIDKql5u/BBh/Rq0hLB+NnvFCBgJ2Xui+DBZ7WdaATemgG2S0A40eGOb
 7tEV+aLwq2iNg1nHz1dangZyL5pvFTt+4/yPwme+MHKFTV9AbpVwLS8QTelwXPjNb7WI
 vuoAQXmR6X5VcPAX3juNLHm8MuI9ABi/AG4z1lOD/pTPlmBBSNDkswED7p9NAHUWP7np
 HFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VzZ6Wiac3hkSNr5jQzhWPiHZxuLwzhsmIf66iTOTCD4=;
 b=dJN0IX8+bbC90ASvqk1OV5bW9ZP93JOVgWt3e4cfKs2MEY4hQUwpUJAxFWBZFloHqp
 fYOsVCMoSM5//zdRECSxcgp5uYx6fxuUnS3mdzmLLTxIbZIMYTj/LEltqB0cmzls0OBR
 nDUi1zCP2w0gH5xEcLdH/FwXcg2FwCC/7OTGSy4SJRWliRQky4eGEAOtZBIIXwvtcYio
 lb/A32TVQkfm6vEtnbJF+AAZ0Q/KvSzL5J/35QlAMNMa9qCFP+NEeB3V/gEA6h6pii5d
 +y29b5k8mxJURZABh8ReIXpSFBaESe1UsYOanzJL2Uicl5SLQLfOd7shklwhMOCd5E15
 ORmA==
X-Gm-Message-State: AOAM530XhsS509EvvNPPv9Av9QatL2PCVBN2/QmQ9ojBQMPvg9LWopzJ
 oj4oYGk/gzIEiWBi5qr+Qa7rUo6uYwFSfFUnXce90A==
X-Google-Smtp-Source: ABdhPJw+4eNIl5O3xHQbHlFaV8UFq90vk5gPrGG4mj4ZpCRpmYt4hqvsEwKrEJWc2gN6hxxcN2wEaSkaNdOv95Vhd7I=
X-Received: by 2002:aca:5152:: with SMTP id f79mr3017830oib.146.1591277867402; 
 Thu, 04 Jun 2020 06:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200604125544.GW28566@vanye>
 <CAFEAcA-ACvx19HZBk-nusMCOkr-D3KReUJRTouL02rLEXOUanQ@mail.gmail.com>
 <20200604133221.zpqv5segdv7qwio6@kamzik.brq.redhat.com>
In-Reply-To: <20200604133221.zpqv5segdv7qwio6@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jun 2020 14:37:36 +0100
Message-ID: <CAFEAcA8EOis7=2rderA6qi31Yuaubt=9_yWxoc82v1paPQD_rA@mail.gmail.com>
Subject: Re: kvm_target, QEMU_KVM_ARM_TARGET_GENERIC_V8 questions
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Leif Lindholm <leif@nuviainc.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 4 Jun 2020 at 14:32, Andrew Jones <drjones@redhat.com> wrote:
> On Thu, Jun 04, 2020 at 02:10:08PM +0100, Peter Maydell wrote:
> > These explicit settings are correct, because for these CPUs
> > the kernel does have a "give me what I want in particular"
> > setting (which it will fail on the wrong h/w), and also as
> > back-compat for older kernels that predate the GENERIC_V8
> > define and only recognize the explicit "give me an A53" value.
>
> Actually, I think the failing for the wrong hardware is about all these
> older targets do. I didn't look real closely, but I think all targets
> produce the same result for the guest, which is to pass through the host
> ID registers.

Yes; it's just that originally "specify CPU exactly" was the
only interface, and there wasn't a GENERIC_V8 at all.
I actually suspect that current QEMU will no longer work
on a kernel that's so old that it lacks the GENERIC_V8 and
PREFERRED_TARGET support[*], but we don't have an explicit "we need
at least host kernel version X" requirement that we track, so
it's hard to say for certain. (If we cared enough to test we
could likely delete a bit of back-compat handling code in QEMU.)

[*] in particular I have a feeling that recent changes to the
GIC handling code in the virt board implicitly dropped handling
for ancient kernels

thanks
-- PMM

