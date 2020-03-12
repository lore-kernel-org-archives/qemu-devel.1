Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0194FC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C141020663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gaHs3QU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C141020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQcR-00018g-VT
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQbR-00009S-6J
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQbQ-00062I-3q
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:22:32 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:44848)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQbP-00061J-UI
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:22:32 -0400
Received: by mail-oi1-x229.google.com with SMTP id d62so6024468oia.11
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n8mouH4+5KXIU8ayOQ93LGAgkFs47pe1sEFjRgLZ1/U=;
 b=gaHs3QU9bPUoSE/1Ij8i64wwJXEznu8EGTgNACwRwFbeiUhWE0Ejw7gWVY1n5PTcU+
 qGhRyTQMYv1RaVu5psGuJAldAe9g3QhQUoPOy3m1G3UBlUjPXj+TrMIdkS54bUIpDCIJ
 ZoMruusZcBMBK+Z6IoSMXs+L2eBD6TM51xV6GY8+hSKuJ5VFDBZwegwq8ryithmW5lBm
 /WOqKlQzAGiOLcBhiGGU+Fgik3I8nQS24ccxBBzTEaXOudAwyYWN3y3FAG8ngVeOv2Pa
 tcwXYb6AOeCvTRiRbDrsMW+P/bJYHZIuegUhNBeppYlkK+4vwO362alL0MaYqB9fe1pl
 d3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n8mouH4+5KXIU8ayOQ93LGAgkFs47pe1sEFjRgLZ1/U=;
 b=kIO8c4cF4RL9qlN69/2ULpOZ89NJCdROtHRJkThIHM8CiEPDuyv8Q7lHVPjYv4DRwk
 2DYAtKqdBltnSYbspXbx/i0FgQJGxyu1CRySA8bXM7XFqTKIZgI/qsbptizVc9D5eync
 aWTKgds/h+wyye2lhjd7qWf27uO0kRB9OYwNaLLCly8FjTatB1jrbqNCD3egfP5iARhF
 LsWSaxpXYpFcjVSsGDenE+ljFw0+s1k428tTn8dDRIua7Deth4bVTXcb+zBi1KgiIRpI
 ateV2503uMC1E+zau2pe8n67oer4FOkNI26d99ZMYtoDbDQeDIDvoQUEZ0P6u5+Y6DvU
 1MyQ==
X-Gm-Message-State: ANhLgQ3r0U/jkuaNGvSR6jJ/7ssoiyBxh7u/99TLkSTDrtMhwc/eqZLB
 I5Uvt2Y56gMCkYggl0eeZB88BiG4VpQYDIlH6Sa1wA==
X-Google-Smtp-Source: ADFU+vvm44QeZu5ArgZHy6JC9416PD5p7ISXpNWGeiJLcDgIKjF8BqpmiDXrjBzfiR6rVei4BxgtyIasTqglgktXers=
X-Received: by 2002:aca:47c8:: with SMTP id u191mr3355461oia.170.1584030150729; 
 Thu, 12 Mar 2020 09:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200311221854.30370-1-nieklinnenbank@gmail.com>
In-Reply-To: <20200311221854.30370-1-nieklinnenbank@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2020 16:22:19 +0000
Message-ID: <CAFEAcA9UqDRT-32Qnap8n3uYh8hyK_89KhsTwceHDRiTzihyJg@mail.gmail.com>
Subject: Re: [PATCH v8 00/18] Add Allwinner H3 SoC and Orange Pi PC Machine
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::229
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 at 22:19, Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
>
> Dear QEMU developers,
>
> Hereby I would like to contribute the following set of patches to QEMU
> which add support for the Allwinner H3 System on Chip and the
> Orange Pi PC machine. The following features and devices are supported:
>
>  * SMP (Quad Core Cortex A7)
>  * Generic Interrupt Controller configuration
>  * SRAM mappings
>  * SDRAM controller
>  * Real Time Clock
>  * Timer device (re-used from Allwinner A10)
>  * UART
>  * SD/MMC storage controller
>  * EMAC ethernet
>  * USB 2.0 interfaces
>  * Clock Control Unit
>  * System Control module
>  * Security Identifier device



Applied to target-arm.next, thanks. (I moved
the doc into the its new location now that the split-out
of the arm board docs into separate files has landed.)

-- PMM

