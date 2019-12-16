Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772C4C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:45:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41B74206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x0IRJblQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B74206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igsYX-0000Yg-EN
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 10:45:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igsXi-0008Mi-KA
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:44:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igsXh-0003S4-HB
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:44:18 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42851)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igsXh-0003QZ-By
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:44:17 -0500
Received: by mail-oi1-x242.google.com with SMTP id j22so3622203oij.9
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 07:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KpCH6ZwqEOP5jhIVF4FH+hLREz6L24C45jAN2PLFqpA=;
 b=x0IRJblQ0iBiMkD575D3nz/0svhnHhzPDpNjafxUpqhLw3htp0/aeDRRL9OaLTRzt+
 huLwhC1kAfqUzaaYCM48hZlaBIR0uOrbnpABy9+IzEKGwjLGfynqs1jIrwjiBoScCL0e
 S6WsXsveN6vC3JR9SrkfSUJkPypNW7/kTTxnzsSw2vrH+CxfqEXCJw4AbqXhIPsL333S
 E7G3rh1cmxvslBHFTa9gKngW8R4z9byK3pz7zrNY9yyCoV/sZ/MNODxNYGfCP8bm+qgS
 V+66KyHIw29QMCt5OLtaUcf0BETTVFJ+eYqx2AxfJeuz6q+2FUxU9Yh5BT0Xz0xMVzYl
 F3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KpCH6ZwqEOP5jhIVF4FH+hLREz6L24C45jAN2PLFqpA=;
 b=Ok+/1AG3O3DTiJOmb524rCpvMitlohpcbl9GLJMM6lupNbx85SVsrL77qNJrlMRdW5
 TXPVbdz3yMXLmzlgr5b2l+0N28QdI2cwFCNuUOfi1y92eUbySg/rV6oXntg1XmR9auK0
 193Cp6nL9u7Pa9PxuXxnrEYh5goyoJbRcAu4pu5BnrLjz30Lz5UmLRZlOFR3w2e1MaD5
 i5wlexSz4Kyoj8jbWC2oxtQOce7zDPY4PmRmxhHJEpwHCuVCgDo3SBbjn+CIKfUWTq8v
 cwf+cmprNaSFPyKQ3u4EIW63dx6nU9ilHcyPqlmZeF4stXGRIumQmNas2zi1D5admQbI
 kMJg==
X-Gm-Message-State: APjAAAU4Vu4cGUwlSZpEhWBNUkdzMx18BRCheh0wkzB3qxgn71FgwD7o
 hDnyGeCc/p8oh9NbbOoAFQntS2sfn23FpEZdBwPMdw==
X-Google-Smtp-Source: APXvYqyrPCE7hEFiblr1HO+3t89KPshUIN90ep0vRhKrRSceASwyjOqMZ23O9/EMEnHltmYFwRSq3EbvDd//E2E63aw=
X-Received: by 2002:aca:edd5:: with SMTP id l204mr10220024oih.98.1576511056477; 
 Mon, 16 Dec 2019 07:44:16 -0800 (PST)
MIME-Version: 1.0
References: <20191212173320.11610-1-drjones@redhat.com>
 <CAFEAcA9FprSotg11rS0fM94QiciysZ6kgKhyU4eQfZg7YYaL5Q@mail.gmail.com>
In-Reply-To: <CAFEAcA9FprSotg11rS0fM94QiciysZ6kgKhyU4eQfZg7YYaL5Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Dec 2019 15:44:05 +0000
Message-ID: <CAFEAcA_oF2MX5PGNtp2YZeNRHB5vHM8NbMqQs2=2sAw1PnqfBw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] target/arm/kvm: Adjust virtual time
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: bijan.mottahedeh@oracle.com, Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Heyi Guo <guoheyi@huawei.com>, msys.mizuma@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Dec 2019 at 15:33, Peter Maydell <peter.maydell@linaro.org> wrote:
> So, to be clear, you mean that:
>
> (1) the kernel headers say:
>
> /* EL0 Virtual Timer Registers */
> #define KVM_REG_ARM_TIMER_CTL           ARM64_SYS_REG(3, 3, 14, 3, 1)
> #define KVM_REG_ARM_TIMER_CNT           ARM64_SYS_REG(3, 3, 14, 3, 2)
> #define KVM_REG_ARM_TIMER_CVAL          ARM64_SYS_REG(3, 3, 14, 0, 2)
>
> (2) some of the RHSes of these are wrong
>
> (3) but the kernel internally is using the same 'wrong' value, so
> userspace also needs to use that value, ie trust the #defined name
> rather than manufacturing one ?
>
> That's awkward. I think it would be worth at least having a kernel
> patch to add a comment clearly documenting this bug.
>
> (This error seems to only be in the 64-bit ABI, not 32-bit.)
>
> QEMU does assume that the kernel's ID register values match
> the hardware for sysregs in some ways -- we use this when we
> construct our mapping from KVM register IDs as returned by
> KVM_GET_REG_LIST to QEMU cpreg definitions and thus CPUState
> struct fields. I *think* that in this case the only visible
> effect will be that gdbstub will show you the CNT value
> if you ask it to print the value of the CVAL sysreg.

...perhaps we should work around this kernel bug in the
kvm_to_cpreg_id() and cpreg_to_kvm_id() functions. (Need
to think through/test whether that would break migration.)

thanks
-- PMM

