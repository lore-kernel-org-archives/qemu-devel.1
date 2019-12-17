Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F774C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7372067C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="veGF3xKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7372067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihHMb-0000vt-DU
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 13:14:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ihHLw-0000Sy-TM
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:13:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ihHLv-0006fi-Gb
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:13:48 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:46205)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ihHLv-0006eu-9e
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:13:47 -0500
Received: by mail-ot1-x32e.google.com with SMTP id c22so3470023otj.13
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 10:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tC3wW3n5O1INqhutE2gaG6tKCVqJW9cCEUGwo50wAOw=;
 b=veGF3xKajsmAUseXgIinO3Mxx29G6jdVS3JMxEjdWATrRPnlL0KJk4cna/vWiDpWBv
 8GHDDXeBwDio7RQ+zDfs+BA4kUt1o1a5LT/5m2bF4AfFM9Z1JElbjn4jFpJJIOlYlpau
 o8ppp4+NA7n6ogoa3NjZlYbtlF/14HshkzXBxgOKa/WmCnR7HNI50qBH2v4n7OOjnte1
 5H4QZ0QXG2svhFA6XOE5FxHY5hd5T3oXMAWTUJnbNRWoi+PGRmn8vftQNOWg/J+TRXVf
 5tMeI8TabXgFYLG0Wxb41lhk5r6yepMhzxIZNwNdp1/AQLIHj/Q36GL9yIAjoyDt4Zkq
 +nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tC3wW3n5O1INqhutE2gaG6tKCVqJW9cCEUGwo50wAOw=;
 b=oC2EZ7CFM0j2MV21qbHvWhy0Fm1x4GfGjjKsWzetbeSVkHSZAL0PpZFkELc7sZmnTP
 COi9cj2mX9/eHh61xjRWU2WQ5vCuL97Xv5pdbgLaeqtknX9o2GxYRCB1sy4zKlDiom9I
 crdwyiDGm//uyeQ94CoAMSvg1izuHRp8haOiNyQ+XYZIXBYdgNNq6zAeWY6y/8M1T2hd
 yiSh9WEgV9vUhlJLgk4Z4xy3sb8Yy2NpkCXuk1EKwKun0qTi1OTo3WKMYxyY5YRKK1cr
 m6QR3szW6JOeZ+WVGW3fSAmOYja57cCtGbk1LJEyHg/QTowUF5T0UQ0wMAXQBqmQGxwK
 RE2A==
X-Gm-Message-State: APjAAAWi2vJuv7JRSMNXed/V5GPQv27+BtE4USLd4D5Yl8wVLKcPyD8w
 viLINnr68pIhG9xjfT3bIizhdA+NvKJyxPLu/oTRMQ==
X-Google-Smtp-Source: APXvYqxTAkn4W1agc55+zJuJc+HcSYG/2pFKA5TQK/kdl+on28PjouKhXHtvkzbpIBE2qBYEexhwCZ2Mg6bbm32kdC8=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr39457173otq.135.1576606426402; 
 Tue, 17 Dec 2019 10:13:46 -0800 (PST)
MIME-Version: 1.0
References: <1576605445-28158-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576605445-28158-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2019 18:13:35 +0000
Message-ID: <CAFEAcA96uWaOD0wN5g6Q7+eMH-RbkiCYo-aE-d_KvkSFVmUP3Q@mail.gmail.com>
Subject: Re: [PULL v2 00/62] Misc patches for 2019-12-16
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
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

On Tue, 17 Dec 2019 at 17:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 084a398bf8aa7634738e6c6c0103236ee1b3b7=
2f:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2019-12-13 18:14:07 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 74c14076700436f9d340652042c81f46eaf0cf9f:
>
>   colo: fix return without releasing RCU (2019-12-17 14:03:44 +0100)
>
> ----------------------------------------------------------------
> * More uses of RCU_READ_LOCK_GUARD (Dave, myself)
> * QOM doc improvments (Greg)
> * Cleanups from the Meson conversion (Marc-Andr=C3=A9)
> * Support for multiple -accel options (myself)
> * Many x86 machine cleanup (Philippe, myself)
> * tests/migration-test cleanup (Juan)
>
> ----------------------------------------------------------------

Conflict:

diff --cc hw/ppc/spapr_irq.c
index 07e08d6544,15c3dd4812..0000000000
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@@ -70,17 -70,15 +70,22 @@@ void spapr_irq_msi_free(SpaprMachineSta
      bitmap_clear(spapr->irq_map, irq - SPAPR_IRQ_MSI, num);
  }

 -int spapr_irq_init_kvm(int (*fn)(SpaprInterruptController *, Error **),
 +int spapr_irq_init_kvm(SpaprInterruptControllerInitKvm fn,
                         SpaprInterruptController *intc,
 +                       uint32_t nr_servers,
                         Error **errp)
  {
-     MachineState *machine =3D MACHINE(qdev_get_machine());
      Error *local_err =3D NULL;

++<<<<<<< HEAD
 +    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
 +        if (fn(intc, nr_servers, &local_err) < 0) {
 +            if (machine_kernel_irqchip_required(machine)) {
++=3D=3D=3D=3D=3D=3D=3D
+     if (kvm_enabled() && kvm_kernel_irqchip_allowed()) {
+         if (fn(intc, &local_err) < 0) {
+             if (kvm_kernel_irqchip_required()) {
++>>>>>>> remotes/bonzini/tags/for-upstream
                  error_prepend(&local_err,
                                "kernel_irqchip requested but unavailable: =
");
                  error_propagate(errp, local_err);


I could probably figure out the resolution but I'm about 5 minutes
from having to leave the office; sorry.

-- PMM

