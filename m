Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425C1CA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D6CD222BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldxqJHeu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6CD222BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLqaY-0005kA-VQ
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqZF-0004PP-Vr
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqZE-0004gQ-IQ
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:22:57 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqZE-0004fo-BP
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:22:56 -0400
Received: by mail-wr1-x442.google.com with SMTP id c2so3967679wrr.10
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pKp5LIfFO72lH7LZCj9kR6HteTkZAhFNV7prdXzOlWM=;
 b=ldxqJHeuaNN7+YlU2kMnGCkcdHmjrY4qnO48KYC++INsfVFAmVnJcU1GHi0Nd9f76T
 vPrAQ4fae4a9xQu5DnPpwCMlxxA7+PV4X5OX89sT9108ul1NrPuQ4mZfbM8qAmEDOofr
 5/LNac5qBdNj5B8+h32kWobLKJWzwkP1EKfekvj55PtGzqqXfCiu4qXqYhAalGQXtBu1
 nVxoYntvadZW83gQicndSZ/hYekD3YoG8m7u9fyJyvKhw8sv6aFVx7fZwZ3B1OF/PWPc
 iKWK7A3B3oUyclrX7nfKyj8y5r6ETmT9JlyxmZtSnIAceMJQcfVDs/V6dq4cNBJMfO8q
 U+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pKp5LIfFO72lH7LZCj9kR6HteTkZAhFNV7prdXzOlWM=;
 b=U2cOdMr+xtE/Z8tVsgutipDENs97xg9bFLTu4vENZ7NlFJB62+zi+DI/8wWgEsP5er
 fAiy/rSwQwqB1T3OKqD/9A/kyBd83//GGJLPrNaa2Y9r7Z3etqQ4MKbJQcOW1Yd1nU6C
 GKEAmdbCnNXxUsttRphbz/sV64JNdljvzRG4QTH1XP35GM+h42uhgAiJScLv8W13a94l
 KmS/aJbwgy3mB7h7Dc8q6EgIRsMEKsi3YfLIYqG2aDNnQ0jiCwCN6Jlz6KHBVvPSRKwQ
 FoV0EFMUbNusTE02pX4H4TGILIBn4ezlueVDslSIR+PhNdcIW0Rkzfq6eBON3syOng4E
 dTvw==
X-Gm-Message-State: APjAAAVLkDCnphORUUEXuuIG6fvJcTIgd+BX8DqRrbDVV/FpzOlQRNvD
 331+JBOCuume0xlECWt6fQg=
X-Google-Smtp-Source: APXvYqx6O2WT34D+UITlBeedUzfs+xf5uJzp5VIHvaMis7BnwDWrCEy8LdtApQd0zYZnG2uIDg5AoA==
X-Received: by 2002:a5d:6992:: with SMTP id g18mr12957485wru.237.1571498575080; 
 Sat, 19 Oct 2019 08:22:55 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id q66sm9782097wme.39.2019.10.19.08.22.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Oct 2019 08:22:54 -0700 (PDT)
Subject: Re: [PATCH v2 20/20] hw/pci-host/i440fx: Remove the last PIIX3 traces
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20191018134754.16362-1-philmd@redhat.com>
 <20191018134754.16362-21-philmd@redhat.com>
 <CAL1e-=gHBfvchVaAbus+GVaSVUFyae41iCB3i5HGhyLTvOr2Ew@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d98cad41-2e7e-e36d-9b1e-e1293c2197fc@amsat.org>
Date: Sat, 19 Oct 2019 17:22:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gHBfvchVaAbus+GVaSVUFyae41iCB3i5HGhyLTvOr2Ew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paul Durrant <paul@xen.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 10/18/19 7:04 PM, Aleksandar Markovic wrote:
> 
> 
> On Friday, October 18, 2019, Philippe Mathieu-Daudé <philmd@redhat.com 
> <mailto:philmd@redhat.com>> wrote:
> 
>     The PIIX3 is not tied to the i440FX and can even be used without it.
>     Move its creation to the machine code (pc_piix.c).
>     We have now removed the last trace of southbridge code in the i440FX
>     northbridge.
> 
>     Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     ---
>       hw/i386/pc_piix.c            | 8 +++++++-
>       hw/pci-host/i440fx.c         | 8 --------
>       include/hw/pci-host/i440fx.h | 3 +--
>       3 files changed, 8 insertions(+), 11 deletions(-)
> 
> 
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com 
> <mailto:amarkovic@wavecomp.com>>
> 
> Philippe, I don't have any test equipment available at the moment, did 
> you do some smoke tests with new v2 of the series (like booting a Malta 
> board, or other relevant scenario)?

This series pass all 32-bit Avocado tests, and if you apply
"tests/acceptance: Fix 64-bit MIPS target tests" I just sent [*],
all the tests pass.

AVOCADO_TIMEOUT_EXPECTED=1 avocado \
   --show=app,ssh,console \
   run \
   -t arch:mipsel -t arch:mips -t arch:mips64el -t arch:mips64 \
   tests/acceptance/

[*] mid.mail-archive.com/20191019151058.31733-1-f4bug@amsat.org

> Veuillez agréer, Monsieur Philippe, l'assurance de mon parfaite 
> considération.

Merci ;)

> Aleksandar
> 
>     diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>     index 11b8de049f..f6e7196a82 100644
>     --- a/hw/i386/pc_piix.c
>     +++ b/hw/i386/pc_piix.c
>     @@ -199,14 +199,20 @@ static void pc_init1(MachineState *machine,
>           }
> 
>           if (pcmc->pci_enabled) {
>     +        PIIX3State *piix3;
>     +
>               pci_bus = i440fx_init(host_type,
>                                     pci_type,
>     -                              &i440fx_state, &piix3_devfn,
>     &isa_bus, pcms->gsi,
>     +                              &i440fx_state,
>                                     system_memory, system_io,
>     machine->ram_size,
>                                     pcms->below_4g_mem_size,
>                                     pcms->above_4g_mem_size,
>                                     pci_memory, ram_memory);
>               pcms->bus = pci_bus;
>     +
>     +        piix3 = piix3_create(pci_bus, &isa_bus);
>     +        piix3->pic = pcms->gsi;
>     +        piix3_devfn = piix3->dev.devfn;
>           } else {
>               pci_bus = NULL;
>               i440fx_state = NULL;
>     diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
>     index 79ecd58a2b..f27131102d 100644
>     --- a/hw/pci-host/i440fx.c
>     +++ b/hw/pci-host/i440fx.c
>     @@ -27,7 +27,6 @@
>       #include "hw/pci/pci.h"
>       #include "hw/pci/pci_host.h"
>       #include "hw/pci-host/i440fx.h"
>     -#include "hw/southbridge/piix.h"
>       #include "hw/qdev-properties.h"
>       #include "hw/sysbus.h"
>       #include "qapi/error.h"
>     @@ -272,8 +271,6 @@ static void i440fx_realize(PCIDevice *dev, Error
>     **errp)
> 
>       PCIBus *i440fx_init(const char *host_type, const char *pci_type,
>                           PCII440FXState **pi440fx_state,
>     -                    int *piix3_devfn,
>     -                    ISABus **isa_bus, qemu_irq *pic,
>                           MemoryRegion *address_space_mem,
>                           MemoryRegion *address_space_io,
>                           ram_addr_t ram_size,
>     @@ -286,7 +283,6 @@ PCIBus *i440fx_init(const char *host_type, const
>     char *pci_type,
>           PCIBus *b;
>           PCIDevice *d;
>           PCIHostState *s;
>     -    PIIX3State *piix3;
>           PCII440FXState *f;
>           unsigned i;
>           I440FXState *i440fx;
>     @@ -339,10 +335,6 @@ PCIBus *i440fx_init(const char *host_type,
>     const char *pci_type,
>                        PAM_EXPAN_SIZE);
>           }
> 
>     -    piix3 = piix3_create(b, isa_bus);
>     -    piix3->pic = pic;
>     -    *piix3_devfn = piix3->dev.devfn;
>     -
>           ram_size = ram_size / 8 / 1024 / 1024;
>           if (ram_size > 255) {
>               ram_size = 255;
>     diff --git a/include/hw/pci-host/i440fx.h b/include/hw/pci-host/i440fx.h
>     index e327f9bf87..f54e6466e4 100644
>     --- a/include/hw/pci-host/i440fx.h
>     +++ b/include/hw/pci-host/i440fx.h
>     @@ -22,8 +22,7 @@ typedef struct PCII440FXState PCII440FXState;
>       #define TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE
>     "igd-passthrough-i440FX"
> 
>       PCIBus *i440fx_init(const char *host_type, const char *pci_type,
>     -                    PCII440FXState **pi440fx_state, int *piix_devfn,
>     -                    ISABus **isa_bus, qemu_irq *pic,
>     +                    PCII440FXState **pi440fx_state,
>                           MemoryRegion *address_space_mem,
>                           MemoryRegion *address_space_io,
>                           ram_addr_t ram_size,
>     -- 
>     2.21.0
> 
> 

