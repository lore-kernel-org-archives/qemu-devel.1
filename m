Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D27C352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 10:19:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F160208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 10:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="leudyyEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F160208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPO62-0002IT-BF
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 06:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jPO4z-0001iF-TV
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:18:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jPO4y-00024B-G6
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:18:37 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41189)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jPO4y-00021S-2x
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:18:36 -0400
Received: by mail-ot1-x343.google.com with SMTP id c3so992100otp.8
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 03:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BHfzOl57Vt5eZWueNHBEjKCGYLGwOjGU3EevLupElFg=;
 b=leudyyEGhe52g+dviyNr0ovvFimiw+kWA72MzMUfQP4HSKNzMJIfMdB99RqNH96k70
 QQzvYHuHnxU2JAcNCYr0uoErTQ+B5z5qcVm8Esu1RS0t35mv3IPapNP7K4KaAMFFtS36
 sPhMxXhhT0ckEgMjGdsvUkPAU7xSRfRn+hUy/aFXSebaLZFQf5PI0p2Ze06V903p8LRJ
 C5AFzP1Fn8NUcjPcuAZ/Ug9ve6C2hQqLXkk/jAKvFltnXp1KNjV2CZ64IQRA0HZTCBu3
 nKRJ2rUs8A9U1mOU7i0DUf6XXRWVs9vx6bWWUvRXJb77Ho/ajcPxWLNysA3qbt4SHYIM
 2tpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BHfzOl57Vt5eZWueNHBEjKCGYLGwOjGU3EevLupElFg=;
 b=sG+fcKQpjnj6H1VBqnRaihMr8I2fLS87AxmQSoMd7Sn5o+j0XqIoQFRaQX+KR+NfCW
 OIckb9VBeX78W29l6tgF4fccLQuhHet4GmgsW4olw5VOt+o73nKaA6ZzpEBJ0iPrKq24
 PcN/ysjqDRHITeAlN11pcrVez8TJjgewt9sq4HzLoYiybBZfeq2z3vkNaOZ+ZOPePx6Y
 ADxKHBqhH4Zh8BEmixfSDZvi1gXOHYX0GSyWv+NKq0WrKYcgDFquJr2aGutcfpatwZ0d
 aQR6KUnK8p5dLB92ETgR/6RqPfeOawDCy7s3uTXgHTtKRIAd7gkb409eFNwaX3N7qJ06
 HV5Q==
X-Gm-Message-State: AGi0Puav9OK7OGmux4J0JTYHnArUxJTXhjoHw+bJGqqVa/BfbiPnXn+w
 ojTzi3ZCSrbobalWRQ0UhQCPZqrYwiIwH1PJ7bVGIA==
X-Google-Smtp-Source: APiQypIB/VlOfEvSw3QL1oy6T813cZNZPmG/3AHR/aRslbcw5g5JEv4Fajobu26dxpc8E1I+U+SPxr9cR5QolpN8Wbc=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr1920516otj.91.1587118712958; 
 Fri, 17 Apr 2020 03:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200410153916.17718-1-jerome@forissier.org>
In-Reply-To: <20200410153916.17718-1-jerome@forissier.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Apr 2020 11:18:21 +0100
Message-ID: <CAFEAcA-JpeYgDwKRarWwggrU5XX7eWsdVy1ngLn538rC6J75vg@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: Add DT property /secure-chosen/kaslr-seed
To: Jerome Forissier <jerome@forissier.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Apr 2020 at 18:02, Jerome Forissier <jerome@forissier.org> wrote:
>
> This commit generates a random seed to be used by the secure OS for
> ASLR when the machine is secure. The seed is a 64-bit random value
> exported via the DT in /secure-chosen/kaslr-seed. This interface is
> used by OP-TEE [1].
>
> [1] https://github.com/OP-TEE/optee_os/commit/ef262691fe0e

The kernel devicetree documentation documents this as a generic
property of /chosen -- should we be providing a /chosen/kaslr-seed
too ?

> Signed-off-by: Jerome Forissier <jerome@forissier.org>
> ---

> +static void create_secure_kaslr_seed(VirtMachineState *vms)
> +{
> +    Error *err = NULL;
> +    uint64_t seed;
> +
> +    if (qcrypto_random_bytes(&seed, sizeof(seed), &err)) {
> +        error_free(err);
> +        return;
> +    }

Since this is exposed to the guest I'm wondering if we should
use qemu_guest_getrandom() (which lets you make the randomness
deterministic for the benefit of record-and-replay). But I'm
not sure if that function is usable before the guest has even
started running. Pavel, could you answer that?

> +    qemu_fdt_setprop_u64(vms->fdt, "/secure-chosen", "kaslr-seed", seed);
> +}
> +
>  static void machvirt_init(MachineState *machine)
>  {
>      VirtMachineState *vms = VIRT_MACHINE(machine);
> @@ -1837,6 +1850,7 @@ static void machvirt_init(MachineState *machine)
>      if (vms->secure) {
>          create_secure_ram(vms, secure_sysmem);
>          create_uart(vms, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
> +        create_secure_kaslr_seed(vms);

This is implicitly relying on create_uart() having created
the "/secure-chosen" node. I think it would be better now
that we have multiple things we might want to put there if we
just pulled the "create /secure-chosen" code out to the
create_fdt() function so we do it at the same place we
create "/chosen". (You can do that as a simple patch of its own
that comes before this one in the patchseries.)

>      }
>
>      vms->highmem_ecam &= vms->highmem && (!firmware_loaded || aarch64);

thanks
-- PMM

