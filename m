Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB27AC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 14:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74CB22067C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 14:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oryjdQVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74CB22067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igrdg-00060a-M2
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 09:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igrcn-00057U-V8
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 09:45:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igrcm-0007iP-IG
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 09:45:29 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41324)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igrcm-0007i3-26
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 09:45:28 -0500
Received: by mail-oi1-x244.google.com with SMTP id i1so3463208oie.8
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 06:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=231fU3iMzQe2NqvaAMOSWvzJKwEVFS75zG4TLEgLhp0=;
 b=oryjdQVSYx4Y3wBBP/su6/e1JjiDmoC24RrLSMLdi7WVJdPVARG+pgV0QfG2aZ27GK
 AKIYKLUfNgIh8h35PGLQpVk8tOSKk/oKjh5UKYGCtLIVnbxGH2IqldSIMLNebs/y0C8L
 zls2jmSXC49ryEubAKNJcut0/ioshx8Dl+HAK9oeyeZdPeSOunirhSfClfe7BZTgy6Qm
 axi5I14Yln7rrye1+ZJs6vUQexW/uIfhkm6QRMoaDqOuTIG+bl5bi7rGmhYZvmrw88wE
 knCI9xp0R1aOsXOGYhG4XBndL/tPqZ4vwImpEUxX/YWljFXtpzx/4IAZnDIjJE0GqNqr
 18Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=231fU3iMzQe2NqvaAMOSWvzJKwEVFS75zG4TLEgLhp0=;
 b=KGOjZGG/oJ104YTdV/+AHgjkCHejBUVQIpOmHKHcnoX3FGCQ54bwhvvh3iyoHBtuJ+
 Kl49QOPkB1IgfGN8Oq/P0zygR4T0j/xLnHvU1YtEkl14I/DKi7JSJDEQQiPhwgyZZ8Xh
 afvJSWEgRBoFv1YqXqFthHq6AdcUgc9B6aVNqTaSD/S1vmo7UGT0NQ7KJ/DLhtCaZkXc
 IkXzilWCHKk1OyfaXrPehsM/9f6P2jXUcHFjP8csQZ6m5m+xtC2NlbSYYPb6rqi2ZVw2
 zODBzVvqpH1hE7UHpTHHTWfZccl8rjGkby+gYiw2iU8ovZ+/M6aSNosE+yWhf7MyMg5v
 09Fg==
X-Gm-Message-State: APjAAAXxR5uG5vm5OKymqwowm7JlQxk7SZ6ek4HtwD3Ohdz/TYbp8KHK
 IyoXt/ghqoyNEF4FLGRnJZ/FQ2kmMV+tWZo3kMWwEA==
X-Google-Smtp-Source: APXvYqzY+roi9PkWi55xMnO6B3/7K1dQEoFGBAP8qFRxq8yHnekhrODeT8t63F0JE3OhyX4yBFYE6HxeJqbwV1F3duU=
X-Received: by 2002:aca:3182:: with SMTP id x124mr9925501oix.170.1576507527017; 
 Mon, 16 Dec 2019 06:45:27 -0800 (PST)
MIME-Version: 1.0
References: <1576076260-18659-1-git-send-email-sveith@amazon.de>
In-Reply-To: <1576076260-18659-1-git-send-email-sveith@amazon.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Dec 2019 14:45:16 +0000
Message-ID: <CAFEAcA-Zz+Ape9z39s8uHEGUN3nOH3-o9t=EEJsm9M+oeDuebQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] hw/arm/smmuv3: Correct stream ID and event address
 handling
To: Simon Veith <sveith@amazon.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Dec 2019 at 14:58, Simon Veith <sveith@amazon.de> wrote:
>
> While working on the Linux SMMUv3 driver, I noticed a few cases where the QEMU
> SMMUv3 behavior relating to stream tables was inconsistent with our hardware.
>
> Also, when debugging those differences, I found that the errors reported through
> the QEMU SMMUv3 event queue contained the address fields in an incorrect
> position.
>
> These patches correct the QEMU SMMUv3 behavior to match the specification (and
> the behavior that I observed in our hardware). Linux guests normally will not
> notice these issues, but other SMMUv3 driver implementations might.
>
> Simon Veith (6):
>   hw/arm/smmuv3: Apply address mask to linear strtab base address
>   hw/arm/smmuv3: Correct SMMU_BASE_ADDR_MASK value
>   hw/arm/smmuv3: Check stream IDs against actual table LOG2SIZE
>   hw/arm/smmuv3: Align stream table base address to table size
>   hw/arm/smmuv3: Use correct bit positions in EVT_SET_ADDR2 macro
>   hw/arm/smmuv3: Report F_STE_FETCH fault address in correct word
>     position

Something funny seems to have happened when this series got
sent out: patches 1,2,3 are correctly followups to the cover
letter, but 4,5,6 are followups to patch 3.
This has confused patchew, which thinks the series is incomplete:

https://patchew.org/QEMU/1576076260-18659-1-git-send-email-sveith@amazon.de/1576076860-24820-1-git-send-email-sveith@amazon.de/

thanks
-- PMM

