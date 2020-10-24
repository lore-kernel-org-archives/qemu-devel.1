Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D9BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 20:30:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C16C321D41
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 20:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3Cm52IT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16C321D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWQB0-0003fk-G5
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 16:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWQ9x-0002uy-L5
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 16:29:07 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWQ9v-00040g-VZ
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 16:29:05 -0400
Received: by mail-wm1-x342.google.com with SMTP id c194so6322214wme.2
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 13:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YbGZ0dZ9XYPGIFppRzGvSBz0cT2gImZ2zpGSsB7K6b8=;
 b=p3Cm52ITnGamjLtu+nY7u5s5j88iKqKuySOGKNWRmq03cgkGXgbi4Iq7VE3/2WeG6Q
 +VBQ8AV7CcFngbxe7mqBjo9wRWgeQPQwugZEfSXq/vaQ58FMaDyqqxuox66CuosU8lyO
 3xCTI3cTDhPCU/WNOD6ht6n9xHZqQLe1IxrULyFdpsiq2z+P4K2orti6T3Aqis721jcO
 6YXjPJHzeXP4jt9h04zDUXkZ1sEnn4U9Tw5ritalcHkSU5wrIB44N+BpmJLVxXe8oMih
 mGpEKU7R0mblPrYRmWnLqH36s9OXq/xH2wlhF7fo9cQ8Wv2eYeikowfDjPoJomHv3CIz
 yTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YbGZ0dZ9XYPGIFppRzGvSBz0cT2gImZ2zpGSsB7K6b8=;
 b=Ob/Rv+ouAhuhVlBp57nLpFfTPfUkabWsaBBgv2hHK8BbKbcq8hfKbqw56BAB2xBklV
 pS6f0gwNzwRqcAvpdSvuZNYMoxsoVe7GGIToAcBXSoBH0RvYsaaxHXJoH4rh3/K+cuOY
 a+gRW9cHYmryWblurfkXb+WIjQpHpMr1ZKKBLgKYNoX7Lj7vDXcXN8j9eaGHbuwGDenV
 VXmphy6PhiVtObDmU8XMBIoKP4YcmfF8ECuG5Qlp/NrcP1yA3dEFxyi1MCDIRT3FrHvU
 FY8C3T8dpyS38fDWuGehTh2daXeYfEDxPCo1UubAsIExyHAYVH5yKSF1lUWZ/610S8DF
 NH4w==
X-Gm-Message-State: AOAM533ugubYIqC4LS73BMlDI4+527ZxDxdoW3hLqgsqAJnLwEMKvlCf
 Wo1H3rk6JHiDcprf0dtlQHM=
X-Google-Smtp-Source: ABdhPJxa0Qw7NEIbyIld7+rZT0W/EenWyiF5dG6SI28cGyhKb+ptLDlObv/7f9jwZG8ihnd4ROEfQA==
X-Received: by 2002:a1c:2485:: with SMTP id k127mr8363948wmk.130.1603571342164; 
 Sat, 24 Oct 2020 13:29:02 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id h4sm13134715wrv.11.2020.10.24.13.29.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 13:29:01 -0700 (PDT)
Subject: Re: [PATCH] pci: assert that irqnum is between 0 and bus->nirqs in
 pci_change_irq_level()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 mst@redhat.com, marcel.apfelbaum@gmail.com,
 Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>
References: <20201011082022.3016-1-mark.cave-ayland@ilande.co.uk>
 <ac6228b3-9ebf-fc9c-e3cc-5d26a33166c1@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ead1847c-ab40-81b6-3375-32c4e0f94019@amsat.org>
Date: Sat, 24 Oct 2020 22:29:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <ac6228b3-9ebf-fc9c-e3cc-5d26a33166c1@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Igor/Julia

On 10/11/20 10:27 AM, Mark Cave-Ayland wrote:
> On 11/10/2020 09:20, Mark Cave-Ayland wrote:
> 
>> These assertions similar to those in the adjacent pci_bus_get_irq_level() function
>> ensure that irqnum lies within the valid PCI bus IRQ range.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>
>> This would have immediately picked up on the sabre PCI bus IRQ overflow fixed by
>> the patch I just posted.
>>
>> ---
>>   hw/pci/pci.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 3c8f10b461..b1484b3747 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -258,6 +258,8 @@ static void pci_change_irq_level(PCIDevice *pci_dev, int irq_num, int change)
>>               break;
>>           pci_dev = bus->parent_dev;
>>       }
>> +    assert(irq_num >= 0);
>> +    assert(irq_num < bus->nirq);
>>       bus->irq_count[irq_num] += change;
>>       bus->set_irq(bus->irq_opaque, irq_num, bus->irq_count[irq_num] != 0);
>>   }
> 
> Actually something else is odd here: I've just done a quick check on the callers to
> pci_change_irq_level() and it appears that both pci_update_irq_disabled() and
> pci_irq_handler() assume that irqnum is a PCI device IRQ i.e between 0 and 3, whereas
> pci_change_irq_level() assumes it is working with a PCI bus IRQ between 0 and bus->nirqs.

IIUC pci_map_irq_fn() returns [0..3] (PCI_NUM_PINS).

> 
> It feels like pci_change_irq_level() should be renamed to pci_bus_change_irq_level()

I don't think so, maybe extracted?

-- >8 --
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 100c9381c2f..79fb94394cc 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -248,6 +248,12 @@ static inline void pci_set_irq_state(PCIDevice *d, 
int irq_num, int level)
          d->irq_state |= level << irq_num;
  }

+static void pci_bus_change_irq_level(PCIBus *bus, int irq_num, int change)
+{
+    assert(irq_num >= 0);
+    assert(irq_num < bus->nirq);
+    bus->irq_count[irq_num] += change;
+    bus->set_irq(bus->irq_opaque, irq_num, bus->irq_count[irq_num] != 0);
+}
+
  static void pci_change_irq_level(PCIDevice *pci_dev, int irq_num, int 
change)
  {
      PCIBus *bus;
@@ -258,8 +264,7 @@ static void pci_change_irq_level(PCIDevice *pci_dev, 
int irq_num, int change)
              break;
          pci_dev = bus->parent_dev;
      }
-    bus->irq_count[irq_num] += change;
-    bus->set_irq(bus->irq_opaque, irq_num, bus->irq_count[irq_num] != 0);
+    pci_bus_change_irq_level(bus, irq_num, change);
  }
---

> similar to pci_bus_get_irq_level() but in that case are pci_update_irq_disabled() and
> pci_irq_handler() both incorrect?
> 
> 
> ATB,
> 
> Mark.
> 


