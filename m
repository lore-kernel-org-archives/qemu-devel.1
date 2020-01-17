Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE715C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791072073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NqzUIRAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791072073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSEh-0001OW-Ui
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:04:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isSBK-0007Qv-54
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isSBE-0005uH-QH
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:01:02 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42439)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isSBE-0005t0-DS
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:00:56 -0500
Received: by mail-ot1-x342.google.com with SMTP id 66so22574387otd.9
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 06:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ER+LkyNb1e+F6XJEMqagb4//d3ToXFWicQDU9yloNKc=;
 b=NqzUIRAmrGKHWKdtnkWYTBCbFS5MTyjnH3GLSZQAOoHDSVjpB+33FHxr034Iden8hs
 5vTF9egfQuRwy36yWVuAncxW2TsHLTJsL0nDLS2AM9My0cvUVngyyUJzWnVE236gAa3D
 IosqoyrLmp/0h/b/EjhBC1duffmunURwPGwjEj6JMcwleK4tU0GTtcOK7q4bnuFSA8NY
 vgt/aEtz4EX/n1L/V9GVYUtOh30MstwFGP/3Mp77r3acyROZSb1g/+FmUI2zNWyddcP7
 /mrzNjPPlRicHKgR95D1rkuww2F57EH8LfG2Gd9SDwL1ISDnle+UUtut3feShIafnRxJ
 z06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ER+LkyNb1e+F6XJEMqagb4//d3ToXFWicQDU9yloNKc=;
 b=mnU5KNmX7Ja+XRlO6r/VW8uh18unUyR4WGEwLQ+p/aOEzFUHKEtxruyBLII1GNsmXr
 XddPjbm0m/qZeOw1Igs0IKxo4vP2p4iPJQGCPyt+HKuyad9zxspCQ0rgVdpJ26tJ/aU3
 QfEBhnb4yIfUE5lYkzLROa1RxICGuSKGiSC92OZ0W/87MEkHwx2B68ncsgfuWu+bUsc2
 BnBVoENZtPWnMXNcgr4nbu6eEef2d92pnapcI3CcVLdLh9cD+YnpcniKfaOYtLC84GBA
 YwydlgIK07vOF5iP71FyMFEBRwIOH3dGPiLLlPWjEfnYtwG9vm1qyFPiylFkt3sLp5Tk
 Cj1Q==
X-Gm-Message-State: APjAAAXSmTW9yJzM+Rk0K2u+KONxb7V6XdMoefUrSKksN1hCM2V0WJ6z
 3C5DteSkmeLicErtj4LpdRZvSY3jLjrn/8qfx9X30A==
X-Google-Smtp-Source: APXvYqxj1eJw3xkRrlviQ2/HsOp/FQ+/nXMPQtAsobr6DKH0eBasuPuC/SEZL4BDuA+Lb7WaYtQmckFiU5iw7E79wM0=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr5810406otq.97.1579269654059; 
 Fri, 17 Jan 2020 06:00:54 -0800 (PST)
MIME-Version: 1.0
References: <20191219040612.28431-1-gshan@redhat.com>
In-Reply-To: <20191219040612.28431-1-gshan@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jan 2020 14:00:43 +0000
Message-ID: <CAFEAcA-aucN9anYbhqLMQZTOzhfYaBB0DLV0d16B2HkgEs=ULw@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/arm/virt: Support NMI injection
To: Gavin Shan <gshan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Eric Auger <eric.auger@redhat.com>, Andrew Jones <drjones@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Dec 2019 at 04:06, Gavin Shan <gshan@redhat.com> wrote:
> This supports NMI injection for virtual machine and currently it's only
> supported on GICv3 controller, which is emulated by qemu or host kernel.
> The design is highlighted as below:
>
>    * The NMI is identified by its priority (0x20). In the guest (linux)
>      kernel, the GICC_PMR is set to 0x80, to block all interrupts except
>      the NMIs when the external interrupt is disabled. It means the FIQ
>      and IRQ bit in PSTATE isn't touched when the functionality (NMI) is
>      functional.
>    * LPIs aren't considered as NMIs because of their nature. It means NMI
>      is either SPI or PPI. Besides, the NMIs are injected in round-robin
>      fashion is there are multiple NMIs existing.
>    * When the GICv3 controller is emulated by qemu, the interrupt states
>      (e.g. enabled, priority) is fetched from the corresponding data struct
>      directly. However, we have to pause all CPUs to fetch the interrupt
>      states from host in advance if the GICv3 controller is emulated by
>      host.
>
> The testing scenario is to tweak guest (linux) kernel where the pl011 SPI
> can be enabled as NMI by request_nmi(). Check "/proc/interrupts" after injecting
> several NMIs, to see if the interrupt count is increased or not. The result
> is just as expected.

So, QEMU is trying to emulate actual hardware. None of this
looks to me like what GICv3 hardware does... If you want to
have the virt board send an interrupt, do it the usual way
by wiring up a qemu_irq from some device to the GIC, please.
(More generally, there is no concept of an "NMI" in the GIC;
there are just interrupts at varying possible guest-programmable
priority levels.)

thanks
-- PMM

