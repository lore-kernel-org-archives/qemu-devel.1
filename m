Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE69FC76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 12:30:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78E7E20880
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 12:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/cpSREo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E7E20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho5Yk-0008L2-Ed
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 08:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43171)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1ho5YQ-00071p-J5
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 08:30:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ho5YP-0006d1-BY
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 08:30:34 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38788)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ho5YP-0006bd-3i
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 08:30:33 -0400
Received: by mail-oi1-x241.google.com with SMTP id v186so21325069oie.5
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 05:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zFnjLmowUHqMHozeo3lOU20NDgPgaeAhaqSC3ciU/mA=;
 b=D/cpSREo8exI1sSIYgNXWtZB2mYq1AmNVUTr7b/nc6xO9oRYHiKDrDvhazr/dQb93I
 BLXcvLJohYBDn2gJAwdh9cJBhRiDFsMmH4xSRypUIWOb/8KUeJOEmhD4AujY6yuNITyP
 hA9jY85m2oyFuqVYTh7X7LIUJV8GeO60aAWw4k+U6qrU5z6wC0haE83KwHsI/J2UoPrG
 eDY3NbVmajnOAzEmyADPuQcSNqbqsJxG2fubMkJuzu12nJWJl1DKyIt5gdA5fVqtZBNl
 bbELBpHK7dzIi2coym2yxkoDpUvOropw6ZZAvdpuWeUUZqq2mZYYxAl2YTRBWe4Wpq/V
 k+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zFnjLmowUHqMHozeo3lOU20NDgPgaeAhaqSC3ciU/mA=;
 b=nYLLQQtEcXT4cQi6xO5b5Of5SZQ5wyaOK6zvHQOfWS93pYIrCIzXMzvRqD6J9WR04E
 S6yK4LNMTgSRlQ7XMLIDQ3gDZVxvuVntfN5GT+YdInb5Q3j6iPGsRuvHG1mrd/ssos1s
 b0ylMs2dFUxxLlbK4SnhBs2+yesyAh/cgDyjHNz8XN2l/E8MaDfDEPffysSrztTsYyiz
 kaSbxk97gn9qT9+YF9K5bdNPcOUsUvU/Tscjg0LroSly3RRPLdC6qzr3AomPDuY427dj
 XcfxwSoAWetMODM57a/CEdo9bV0x8b92rhTLV0s0Ap1W1c2GPDDFZm+cJ7FEb1tzMNxH
 gPDQ==
X-Gm-Message-State: APjAAAVDxWO5iSbCebJO5RBuCY1qShV/6CUzQXv9NyTZJHaVPj+fXMAz
 TqLzfym6ue+CS3SZxuPJzavSvPdInUBPhcbm6YVQhQ==
X-Google-Smtp-Source: APXvYqzyw7AViEBV/zBsWNfcv9hqKZlvPZIbc2OSBdQmGB2mW3N0Dp6+aaYPx6mTUenX8hulEA81C0iTJ38o6DMBkUU=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr22303327oij.98.1563453031814; 
 Thu, 18 Jul 2019 05:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181102171638.24069-1-peter.maydell@linaro.org>
 <20181102171638.24069-9-peter.maydell@linaro.org>
 <3e3d2018-3993-f651-8e94-5bea612bd776@redhat.com>
 <CAFEAcA_FtoHOUv_cPgfO7GrZ8Ug9cKCvmY2z75i9DaAQ8Qx+gQ@mail.gmail.com>
 <417cd887-aec4-d8ba-1dd2-810bc4c04977@redhat.com>
 <CAFEAcA_JntiaOOWisqLVqAV6jc=wk4nR548KbbUcG0XLabcNpA@mail.gmail.com>
 <8d06b8f2-7ee8-a77a-81d7-3219d5e43c45@redhat.com>
 <dfeab9fd-7ee1-01f2-dd38-cba449b1de63@redhat.com>
 <f625f1f1-ad97-1c75-e44d-3b0c015312b3@redhat.com>
 <cf9156f6-c3fa-ec7e-c51a-8b8d2fd1e6d6@redhat.com>
 <7b45c073-8653-28e0-9d06-9e3aaa6dc460@redhat.com>
 <CAFEAcA8RZuzv=KkATMozxfp8MTsCOPPsK7mN6oCJq_TfwWiPMA@mail.gmail.com>
 <97ca4042-a224-7480-cc94-b58c687c353a@redhat.com>
In-Reply-To: <97ca4042-a224-7480-cc94-b58c687c353a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jul 2019 13:30:20 +0100
Message-ID: <CAFEAcA_jasrCne5=iLGuciJmf9FSQTduQD8xfnzbES6527mbgQ@mail.gmail.com>
To: Laszlo Ersek <lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PULL 08/10] target/arm: Conditionalize some
 asserts on aarch32 support
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 17 Jul 2019 at 16:08, Laszlo Ersek <lersek@redhat.com> wrote:
>
> On 07/17/19 15:46, Peter Maydell wrote:
> > On Wed, 17 Jul 2019 at 14:36, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
> >> I still wonder why this didn't assert on Peter's setup.
> >
> > My setup does not assert because my host kernel correctly
> > provides the ID register values to QEMU. Laszlo's appears
> > to be providing all-zeroes, which then obviously breaks
> > assertions being made about the sanity of those ID register
> > values...
>
> OK. Can you suggest a location that I should check in the host kernel?

I was about to write out the process of how we get these values
from the kernel, but as the first step of that I read through
QEMU's target/arm/kvm64.c:kvm_arm_get_host_cpu_features(),
which is the function which reads these values using the
KVM_GET_ONE_REG ioctl. It starts with an attempt to read
ID_AA64PFR0, and has a comment for the error-handling case:

        /*
         * Before v4.15, the kernel only exposed a limited number of system
         * registers, not including any of the interesting AArch64 ID regs.
         * For the most part we could leave these fields as zero with minim=
al
         * effect, since this does not affect the values seen by the guest.
         *
         * However, it could cause problems down the line for QEMU,
         * so provide a minimal v8.0 default.
         *
         * ??? Could read MIDR and use knowledge from cpu64.c.
         * ??? Could map a page of memory into our temp guest and
         *     run the tiniest of hand-crafted kernels to extract
         *     the values seen by the guest.
         * ??? Either of these sounds like too much effort just
         *     to work around running a modern host kernel.
         */

I have 4.15, and don't hit this assert; you have 4.14 and do,
so I think you're going to be going through this codepath which
currently sets only ahcf->isar.id_aa64pfr0 and none of the other
ID register fields in the isar struct.

I'm not sure exactly which kernel commits added the ID register
reading support. (The relevant kernel code is in
arch/arm64/kvm/sys_regs.c I think.)

Anyway, I think we need to do at least one of:
 * enhance the "provide a minimal v8.0 default" code in this
   condition in kvm_arm_get_host_cpu_features() so that it
   populates the ID registers sufficiently to avoid asserts
   and other bad things
 * make the asserts on ID register oddnesses be only for TCG
   (ie where QEMU controls the values) and not for KVM

thanks
-- PMM

