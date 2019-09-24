Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354F4C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:46:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0899520872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0899520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCl9T-00082n-Pw
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 09:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iCkab-0007Xl-37
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iCkaT-0002H6-D7
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:10:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50542)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iCkaT-0002GM-4v
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:10:37 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1061BC055673
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 13:10:36 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id 190so926193wme.4
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 06:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q0MJSSKSV6Cq9kr0Fbr8b6Bqd4XX1IZh6fNcOtMVgFA=;
 b=K15S5taqfD0zhWV5apIdss3SB5+kLmGTOg3MDnrnYXf23G58VZtIDzKNdHz8I/FTK+
 jO9/ucJeZ9qvCNBoj5uy876xUA3xpAYk57s/k0AVtnGSHljzmbHDSalfsaamXtNdFVyw
 XamZ6YEvIeSxlkU/g0g/yVi+VX9xPhxRyzK6m/P3hUS2dDxOXxNXgFq2J87+ogIVPCcS
 yiWjqu+uT/tWQRIjYpGUqsUf7pNzsRfgso4f4SnfQQWqFUEMCNDC93BVIvnBO7PjQV+Y
 CwAOitTdufBZiWaBWcDN3AyiqPffIPWyjG5pKl0OGHIlew6JieqQjYHwhUjrIk/m3xPf
 1hBw==
X-Gm-Message-State: APjAAAVaUpR8nQn1M4/S9s8EJfjBVm2D+qav9d3BgG3M4s95GqZXBd+U
 Be65tSwHnpWDzFIAphaa/cW5XX5qgObw+S3eOCHBfDcCox/wbx8JhYMsO9XT7im9mGNm1jEDZNE
 sVC/dT292ce/2S0o=
X-Received: by 2002:a7b:cbc5:: with SMTP id n5mr2857062wmi.31.1569330634633;
 Tue, 24 Sep 2019 06:10:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwT50WNRh9TiZTaR+GDMyzI/HA/Ucnwa1fcbZCxIjKtaggqpyZFT6A1MN41iIYAAfZYqHmqfA==
X-Received: by 2002:a7b:cbc5:: with SMTP id n5mr2857028wmi.31.1569330634348;
 Tue, 24 Sep 2019 06:10:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id j26sm3660988wrd.2.2019.09.24.06.10.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2019 06:10:33 -0700 (PDT)
Subject: Re: [PATCH v4 7/8] docs/microvm.txt: document the new microvm machine
 type
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-8-slp@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <23a6e891-c3ba-3991-d627-433eb1fe156d@redhat.com>
Date: Tue, 24 Sep 2019 15:10:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924124433.96810-8-slp@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mst@redhat.com, lersek@redhat.com,
 mtosatti@redhat.com, kraxel@redhat.com, imammedo@redhat.com, philmd@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/09/19 14:44, Sergio Lopez wrote:
> +Microvm is a machine type inspired by both NEMU and Firecracker, and
> +constructed after the machine model implemented by the latter.

I would say it's inspired by Firecracker only.  The NEMU virt machine
had virtio-pci and ACPI.

> +It's main purpose is providing users a minimalist machine type free
> +from the burden of legacy compatibility,

I think this is too strong, especially if you keep the PIC and PIT. :)
Maybe just "It's a minimalist machine type without PCI support designed
for short-lived guests".

> +serving as a stepping stone
> +for future projects aiming at improving boot times, reducing the
> +attack surface and slimming down QEMU's footprint.

"Microvm also establishes a baseline for benchmarking QEMU and operating
systems, since it is optimized for both boot time and footprint".

> +The microvm machine type supports the following devices:
> +
> + - ISA bus
> + - i8259 PIC
> + - LAPIC (implicit if using KVM)
> + - IOAPIC (defaults to kernel_irqchip_split = true)
> + - i8254 PIT

Do we need the PIT?  And perhaps the PIC even?

Paolo

> + - MC146818 RTC (optional)
> + - kvmclock (if using KVM)
> + - fw_cfg
> + - One ISA serial port (optional)
> + - Up to eight virtio-mmio devices (configured by the user)
> +


