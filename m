Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C438C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:58:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9CAE2465D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AgsejOh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CAE2465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4ib1-0001tl-Vb
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 04:58:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4iaR-0001TA-2u
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:57:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4iaP-0000Jb-Ly
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:57:38 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46953)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4iaP-0000IT-Fc
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:57:37 -0500
Received: by mail-oi1-x243.google.com with SMTP id a22so26922580oid.13
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 01:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=20SuUM6Yx/3/xygD8wfrJ/5umsJVLPMA656qMptpj4Q=;
 b=AgsejOh+hgXz4TKddEsOqMgoyIAreO09E13EPivhdnXxAFrTtSCFd6ATfGfqCII+5o
 eO5pSh5Qh9wGBQIY7GUhCFolOJi28wllHrvOdej9FQcG2K6Iz6PM79jjhjmrzbh0Q7G2
 hL7lCo/pypGCVSQk7CFi5YGrQ2oA+rZWXMk0yZrqKZD2LrUlth2qDIMBvr3oW2Apx8p4
 9peXVr1f/BrDmmHR1UfJJt1VCqCQ6bxY4Hfg/2vuvZq64KtR+nM2bfWoxPsBxG20jghk
 rr5IPmEj23LtAjouAgr65bBVR+NX1VC/UrWGfgdMZ4yPomEked2YrSqeGD5jCQwxmyV2
 DI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=20SuUM6Yx/3/xygD8wfrJ/5umsJVLPMA656qMptpj4Q=;
 b=O2g/z8a0g92o6i1zFj+jGlaRMxSvo8gdSsVPn3QmxfMw2DYCumL3VFm6MXZBuvFrBO
 SP5k4VMRlXAQ1805gkkAydTLt+aZqevBi3KETPkGp+7oHg8Xy+41tIB7bD83M9nYOU5h
 QQzDDHnQZYsjqvw3GjYHJAQXv9F1VU85XlRXyrmyo5CoUgss4A6dlS2XCuh1JzxZvlrI
 KbZqfOykmqE0MF7VxULlkGdvhWfGVHV81xmCqXXU0H5bswlITWkQsz5mwTpxcmUugdFj
 ZLELvWzxGbXerUMdZT2NhtBTXoIcYH0NiXzjAFUwcDOGrxHpOfdCzEG7am6BEL6vYzYO
 JGBA==
X-Gm-Message-State: APjAAAV6pDYZ0FWwiFSx1mSPUKdQloiFIpMKBsqDL3ayriYXC7zQwc7L
 MtJ9vdOLlh3MGfxxf+sSmfbtpL/bHFUlReJA9gAztA==
X-Google-Smtp-Source: APXvYqzpNUu6M4loDzGydB/sjwAhOIu87yfPAsbKUxVOKswu4vtvVi7Jdalbdah4UUYdFKE/2k8L+sYNdaub6vpnXXk=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr1335379oic.48.1582192656437; 
 Thu, 20 Feb 2020 01:57:36 -0800 (PST)
MIME-Version: 1.0
References: <CAM2K0npCdHfCeMCKO9TX_ifQGDZFFNyMEKH2qByYL9SnXnaPmw@mail.gmail.com>
In-Reply-To: <CAM2K0npCdHfCeMCKO9TX_ifQGDZFFNyMEKH2qByYL9SnXnaPmw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2020 09:57:25 +0000
Message-ID: <CAFEAcA_A5J-j2cZN98j_9G49PAMauHGF47QBoeMK8y_RbMp5FA@mail.gmail.com>
Subject: Re:
To: Wayne Li <waynli329@gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Feb 2020 at 05:41, Wayne Li <waynli329@gmail.com> wrote:
> Also, I do have another side question.  When running with KVM enabled, I
>see the kernel-level ioctl call KVM_RUN running and then returning over
>and over again (by the way before the VM kinda grinds to a halt I only see
>QEMU make the KVM_RUN call twice, but the kernel-level ioctl function
>is being called over and over again for some reason).  And each time the
>KVM_RUN call returns, the return-from-interrupt takes the VM to the
>address 0xFFFFFFFC.  What is the KVM_RUN ioctl call used for?  Why
>is it being called over and over again?  Maybe if I understood this better
>I'd be able to figure out what's stopping my program counter from incrementing.

KVM_RUN is the ioctl which QEMU uses to tell the kernel "hey, please
start running the guest". The kernel will not return control to QEMU
(ie the syscall will not return) until something happens that needs
QEMU's intervention, of which the main one is "guest made a device
access that QEMU must handle". (You can see this run loop in
accel/kvm/kvm-all.c:kvm_cpu_exec()). So in normal operation,
QEMU will do a bunch of setup, and then call KVM_RUN, which
will cause the guest to run, probably for quite a long time. The
ioctl will return when the guest does some IO a QEMU-provided
device, and QEMU will then do that device emulation, set up the
kvm_run struct fields to hold the results of the device access,
and call KVM_RUN again. The cycle continues like this until the
VM is shut down. If the guest goes into an infinite loop, you
should expect that KVM_RUN will never return, as there's never
any need for the kernel to ask QEMU to do anything.

Also important to note: before we call KVM_RUN we push
the CPU register state up to the kernel (using various arch-specific
ioctls), and after that the 'live copy' of the data is in the kernel,
and values in the CPU state struct in QEMU are stale. We only
get the up to date data out of the kernel when we need it, by
calling kvm_cpu_synchronize_state(). So if your 0xfffffffc value
comes from the CPU state struct and you're reading it at a
point before the state has been synchronized back from the
kernel it's not going to be the actual PC value.

The KVM kernel API is comparatively well documented at
https://www.kernel.org/doc/html/latest/virt/kvm/api.html
though the section on KVM_RUN is pretty weak.

thanks
-- PMM

