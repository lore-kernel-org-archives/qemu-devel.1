Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FE0C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 17:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A1B120740
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 17:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eVbnkL+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1B120740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46987 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZIOi-0001Az-H5
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 12:43:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iZIMD-00006p-98
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 12:41:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iZI9e-0002ov-Rt
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 12:28:07 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37795)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iZI9e-0002og-HF
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 12:28:06 -0500
Received: by mail-oi1-x241.google.com with SMTP id 128so5779977oih.4
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 09:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ODipN45RKDugqEFByxohJfMmDdgzkjUfNBbVFYHiRmI=;
 b=eVbnkL+Vk3EkMi7q6dN4vXzhJf7Ftx3WPG9I73qm0Gb34i7HeKk2DPCCMLkegdCbXK
 Lzv937WHEy+KSrJC7a4Rh4R3T2I+kXu2ErH91rS75fe5wpQvc6mvGcN5qOhbrvvCR4ZA
 75JLGS3ULzc/F2ux0OppY/ZEGpNOwbEp/4wyqeyF+DCwDqI6COdTzGo03xjRVLu4gn68
 odi6GKPosFyxZJ6dxnKs7SYo5+zcpvz1loIPGC2ndrvthlHoPj/G/MrPpDX1+DUNKiEO
 EDcLkdFj5+HUCLY4vWLEuEz6Bw1M/RLfMnhWQX/QVLDIDSlH5vp3MFJrocx7TjyYV4wm
 WFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ODipN45RKDugqEFByxohJfMmDdgzkjUfNBbVFYHiRmI=;
 b=WAbPo04lw/yO+qTwfSilHEtU0C8ynBdEbZgR2oVhlCuI40bdqsLoPBSu3p7qFNV72X
 Elk3JejYgXN5dwxFRKHsh7egFNfal657XqVqMMYMl7qsHpQvS2HKsjYux6uBYEQL23T1
 gklHA5mcyBYlhoSMps4WShAKr0XJJSJhNdcyBCWhuwLASWdtYjfXP1iWOKbKtPJ+MipE
 zo3JDVkU9p3Xhs2mcdads88lTwDhBIxPglkwkJtley7TjA8oajv5Sa0rejBbLOFXCxO6
 0OO0q31tX8pDo24olVz+Y1l1MlPyMtsn//kNXcOfxK5A2xFnUQvwOhRDOVCoUtrlI+4s
 zzwg==
X-Gm-Message-State: APjAAAV0IwNonQIU7Wiv9gQHE5c0bRYdBfD/1SydwjSYqlSSHEMA1sOp
 f+lpiOADVFyslJJcPm8MS4/0maqcHxd34cdEOjpkxA==
X-Google-Smtp-Source: APXvYqyHtjqHcQwQ1kxjFN2sdOoix589I/J3kl2Mykq4RvSYXPJz1FlyLbetm0ZeYRQXecq1Z5ODCNt3h2rQ9AE4t90=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr23885342oij.163.1574702885777; 
 Mon, 25 Nov 2019 09:28:05 -0800 (PST)
MIME-Version: 1.0
References: <20191123115618.29230-1-maz@kernel.org>
 <CAFEAcA_MQpJ=8UFnP=Qnt+4GWMUO_AtJBBNz-bM2L2wf5htuaQ@mail.gmail.com>
 <4d8c4763da39d5bfb1800735f90d82d1@www.loen.fr>
In-Reply-To: <4d8c4763da39d5bfb1800735f90d82d1@www.loen.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Nov 2019 17:27:54 +0000
Message-ID: <CAFEAcA87ceF_0ifLn1t9CxyEwJ-rwW8h4QauJGk+ATphJaWa6Q@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Honor HCR_EL2.TID3 trapping requirements
To: Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Will Deacon <will@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 25 Nov 2019 at 17:08, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2019-11-25 16:21, Peter Maydell wrote:
> > Missing .accessfn for ID_AA4PFR2_EL1_RESERVED ?
>
> Indeed, I oversaw that one. I'll fix it and repost it together with
> the extra patches to handle TID1 and TID2.

Given that rc3 (last chance, more or less, for bugfixes for 4.2)
is tomorrow, I propose that I take this patch with the
+              .accessfn = access_aa64idreg,
line for ID_AA64PFR2_EL1_RESERVED squashed in. I think
TID1/TID2 and the MMFR-from-aarch32 parts are less urgent ?

> > These are the AArch64 accessors for the aarch32 MVFR registers,
> > but this trap bit is also supposed to trap aarch32 accesses to
> > the MVFR registers, which are via the vmrs insn. That needs
> > to be done in trans_VMSR_VMRS(); we can do that with a
> > followup patch, since the mechanism there is completely different.
>
> Holy cow! I'm afraid that my newly acquired QEMU-foo is missing
> a few key options. Does it mean we need to generate a trapping
> instruction, as opposed to take the exception on access?

We will need to generate a call to a helper function which
does the access check (and possibly raises an exception).
We can't determine at translate time whether the insn is
going to cause an exception, because the TID3 bit is not one
of the fairly limited set of information which we put into
the TB flags and allow to be baked into the generated code.
(In theory we could add it, but we don't have very many TB
flags so we only do that for cases where the overhead of doing
the check at runtime matters.)

thanks
-- PMM

