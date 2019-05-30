Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C6EC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:58:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48282257A0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bzPPLeoo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48282257A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51944 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIlA-000820-C0
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:58:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWIkP-0007hn-Jn
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:57:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWIkO-0002uJ-K2
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:57:25 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hWIkO-0002rd-Co
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:57:24 -0400
Received: by mail-oi1-x244.google.com with SMTP id u64so4611728oib.1
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=8CUGtddsQAcpIedVPK7EXveMNL6giQ7v3lJi/i4QwOk=;
	b=bzPPLeoowxHw8ZPNXM8RxeuD0sTMM6S0gjpSG70GcVSRudlJBBWeTMM1rF5F5Ke6T3
	LiEK5muKGjMe0VW1nGasvrtxFASjQT9ghGNTEk69aRjEPkVhhzSXydVbDPf+BBvwqZgv
	v10LUoxHcMzCdw6tfqSQIdPfsPOWbdZAXdEPkY92uV0LCQ3C2g+g5ILqohoIFWzhjJZL
	wcxSWUGGbJKUkrllgA0Am2/msjHHenxOVXyJDMt4Oy9Ze28K9/ejmXIcrVELhka4khK/
	KmODPMD7YObw+SG4HxZj0FCB6tqQzIPVeY4cEryZGG1VaeQJYKsuhrvtz/yj3faOkhys
	2KdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=8CUGtddsQAcpIedVPK7EXveMNL6giQ7v3lJi/i4QwOk=;
	b=iINsToAN1F2azgEhlVTO/tlb/ClLEIpN28NqFeytg4kgrtZAhO3uGQk0GKqSxIIWVh
	ruw4sdqAHTZGtjVNw35nuGpt+LVNl3i2rHe62mj9IqqsA9eOe3j+Gf6yfJuaGoOxXUBV
	l2MZ6hnIJdho2k/imROP6zw+DUQWZzh28cWFBJ62071zUheSoiZJOtFd9QI/u3aqoD8Q
	pHctzOJmsm6Myji9Vpt0viyEj8dGW8O0/r7WQbNDJ3GyNrkJCPGumv60afYPDYJX5tKo
	x2JmS3j6QegPVt5iMpu41Hc/iFO5tBJ+//8/0jFXIHdi0RxOhDx0KAI6L3xLfRf2qh9h
	9b4g==
X-Gm-Message-State: APjAAAVrGXXqXSPNGBIDDnEiamYfLpnjZpViz2iddN6sJvk3IbYKOIEB
	Llh5OmlTq6BRrTcKQfYgC/OUOQ782EMezjzKeBLF9A==
X-Google-Smtp-Source: APXvYqyPQ9nqn37SloKIULf2etAGLfCBkH00WHyi0wZur1IOn2ahOeCnNybcpbK/80a0otx0Bl/ZJJek0Zg0eIY+wiY=
X-Received: by 2002:aca:5785:: with SMTP id l127mr1910631oib.48.1559213843255; 
	Thu, 30 May 2019 03:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190526010948.3923-1-palmer@sifive.com>
	<20190526010948.3923-2-palmer@sifive.com>
In-Reply-To: <20190526010948.3923-2-palmer@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2019 11:57:12 +0100
Message-ID: <CAFEAcA-01sahAvfLRoe3e9RfCcgmk4+Ubceufg9hhmwQAFpbRQ@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PULL 01/29] SiFive RISC-V GPIO Device
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Fabien Chouteau <chouteau@adacore.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 26 May 2019 at 02:10, Palmer Dabbelt <palmer@sifive.com> wrote:
>
> From: Fabien Chouteau <chouteau@adacore.com>
>
> QEMU model of the GPIO device on the SiFive E300 series SOCs.
>
> The pins are not used by a board definition yet, however this
> implementation can already be used to trigger GPIO interrupts from the
> software by configuring a pin as both output and input.
>
> Signed-off-by: Fabien Chouteau <chouteau@adacore.com>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Hi; this patch causes Coverity to complain about a memory
leak (CID 1401707):

>  static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
>  {
>      const struct MemmapEntry *memmap = sifive_e_memmap;
> +    Error *err = NULL;
>
>      SiFiveESoCState *s = RISCV_E_SOC(dev);
>      MemoryRegion *sys_mem = get_system_memory();
> @@ -184,8 +188,28 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
>      sifive_mmio_emulate(sys_mem, "riscv.sifive.e.aon",
>          memmap[SIFIVE_E_AON].base, memmap[SIFIVE_E_AON].size);
>      sifive_prci_create(memmap[SIFIVE_E_PRCI].base);
> -    sifive_mmio_emulate(sys_mem, "riscv.sifive.e.gpio0",
> -        memmap[SIFIVE_E_GPIO0].base, memmap[SIFIVE_E_GPIO0].size);
> +
> +    /* GPIO */
> +
> +    object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }

This function allocated xip_mem and mask_rom via g_new() but
then this error-exit doesn't free them.

The best way to fix this is to stop doing separate memory
allocations at all -- instead just have fields in the
SiFiveESoCState struct
   MemoryRegion xip_mem;
   Memory_Region mask_rom;

and pass &s->xip_mem etc where currently the code uses xip_mem.

thanks
-- PMM

