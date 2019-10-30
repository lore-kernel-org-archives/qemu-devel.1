Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4637ACA9EC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 09:26:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA20205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 09:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA20205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPkFe-0004pB-AG
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 05:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iPkEp-0003mX-Ni
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 05:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iPkEo-0002zM-GX
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 05:25:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36014)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iPkEo-0002yQ-81
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 05:25:58 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EAA1537F75
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 09:25:56 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id g21so351047wmh.8
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 02:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X7PMHKifCCjhRv7JinbskbxBcYqirz5tqJQ7vdwlN6w=;
 b=kT8uY1B5Yh5FcTWL4h/9BoYI/77a9vbLuNBiF+i2HtNaWRXo0IsnShtPlgrIabBhLF
 D3sBEpUEAXKpHdrbDZPzpU0nF7bE7HYmLZiU5/cukOwPSa8tmxJCp/zqp4hdOlKRy+aJ
 A4lwmNcxkqqeJCM80B/dZJICyT0KKBtgELxDlKrYbYlJA8uF3rUjaImf0qfHqiJuGznD
 NqkpEGPX0Ll1ojSJJqHoGWJQFy5uWhfp542orROQM5IOxpNwIpuN32uxHhL9St3EI7MK
 VdL9OHxcWKyWGAaZTpmdjxxbeaCxWIi+/W10o38NAMRIgPRNS5CVOx3EA4s7fKGwKXLJ
 BFQA==
X-Gm-Message-State: APjAAAW8qWe2zCIDeuc23i63LpuonpRwZnrO9gmse/Y11USlOX+UKa9A
 3VHzS6DzFxpFFMCA1NpYBCqn/u6zPY+CqIGRgmoP91On9hKY5eWkyltPBs7HQj/jLoN/Wz1kl5s
 TqcDH6xfFZYjxw1k=
X-Received: by 2002:a1c:64d6:: with SMTP id y205mr7499445wmb.136.1572427555691; 
 Wed, 30 Oct 2019 02:25:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyp54bv2GbBkD2SAITpng+JkUJFZ5WgbCcNW0BR9g9aPky7HMGR9VM2T2VKNuF/lwM/28y+Eg==
X-Received: by 2002:a1c:64d6:: with SMTP id y205mr7499416wmb.136.1572427555442; 
 Wed, 30 Oct 2019 02:25:55 -0700 (PDT)
Received: from [172.20.51.145] ([91.217.168.176])
 by smtp.gmail.com with ESMTPSA id n3sm1790926wrr.50.2019.10.30.02.25.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2019 02:25:54 -0700 (PDT)
Subject: Re: [PATCH v11 14/15] hw/i386: Introduce the microvm machine type
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191018105315.27511-1-slp@redhat.com>
 <20191018105315.27511-15-slp@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <58f50ece-5fc2-dcad-f367-455d5f58e184@redhat.com>
Date: Wed, 30 Oct 2019 10:25:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191018105315.27511-15-slp@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: berrange@redhat.com, ehabkost@redhat.com, mst@redhat.com, groug@kaod.org,
 marcandre.lureau@gmail.com, kraxel@redhat.com, pbonzini@redhat.com,
 imammedo@redhat.com, sgarzare@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sergio, Paolo,

On 10/18/19 12:53 PM, Sergio Lopez wrote:
> microvm is a machine type inspired by Firecracker and constructed
> after its machine model.
> 
> It's a minimalist machine type without PCI nor ACPI support, designed
> for short-lived guests. microvm also establishes a baseline for
> benchmarking and optimizing both QEMU and guest operating systems,
> since it is optimized for both boot time and footprint.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   default-configs/i386-softmmu.mak |   1 +
>   include/hw/i386/microvm.h        |  71 ++++
>   hw/i386/microvm.c                | 572 +++++++++++++++++++++++++++++++
>   hw/i386/Kconfig                  |  10 +
>   hw/i386/Makefile.objs            |   1 +
>   5 files changed, 655 insertions(+)
>   create mode 100644 include/hw/i386/microvm.h
>   create mode 100644 hw/i386/microvm.c
> 
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> index 4229900f57..4cc64dafa2 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -28,3 +28,4 @@
>   CONFIG_ISAPC=y
>   CONFIG_I440FX=y
>   CONFIG_Q35=y
> +CONFIG_MICROVM=y

Do we want to maintain a 32-bit microvm?

IIUC the main interest in 64-bit.

Can we restrict it with this change?

-- >8 --
diff --git a/default-configs/i386-softmmu.mak 
b/default-configs/i386-softmmu.mak
index 4cc64dafa2..4229900f57 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -28,4 +28,3 @@
  CONFIG_ISAPC=y
  CONFIG_I440FX=y
  CONFIG_Q35=y
-CONFIG_MICROVM=y
diff --git a/default-configs/x86_64-softmmu.mak 
b/default-configs/x86_64-softmmu.mak
index 64b2ee2960..ef2affe664 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -1,3 +1,4 @@
  # Default configuration for x86_64-softmmu

  include i386-softmmu.mak
+CONFIG_MICROVM=y
---

Thanks,

Phil.

