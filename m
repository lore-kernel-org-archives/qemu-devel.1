Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8530C2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 21:11:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60DBE206DA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 21:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxmjIZFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60DBE206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO6MO-0008Lv-I1
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 17:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO6Lg-0007of-C4
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 17:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO6Le-0001RD-Py
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 17:10:32 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO6Lb-0001Q6-UI; Mon, 13 Apr 2020 17:10:28 -0400
Received: by mail-wm1-x341.google.com with SMTP id x25so10725182wmc.0;
 Mon, 13 Apr 2020 14:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2jfT25Afb317oYl8K12jzHBHlk1BO8s9gXpEsH6wSvg=;
 b=mxmjIZFdvehNdSYAZgFe0PID9nwEy0QKNXd8WCg4sNN8L8c73woIkqqJD1PbK9NX+s
 JqU1eBQxF8U8TBVhlOGp1QDt1eUQPO4kGJWOixekcluY3Dok95x0zOkiWV7mBvJy2LBg
 QSz4DUUUfjLAK/FV07iYhDCPNZO0+p5+3PZbJfdT+nRRPt728h8X8GBAqDmd5G4xuqNT
 RFlo79a5SPNlfGJVPioY3zc9RXc4SmCQKPrkbSFQQlqj5jzYjqwLwg1Edk/9OqnXGcbW
 xFbBSt8h5OuXH//V1w2HP2wrVe0JT593zHB1YTRRB0hEIiVxQT1VUWQ9+k+gafCVwmva
 WVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=2jfT25Afb317oYl8K12jzHBHlk1BO8s9gXpEsH6wSvg=;
 b=VaR0Y6GlTCn8VrwV/wdhNkQ73UOH7oVa3DOMTl+hLurIkCyJCXranr88nib8GbwvWA
 S3MW1A6jHNYeedDHUZ+c/oxcSRjEPrd2Xs0TlOpZ9L8MrzYT5SbvwC2jiFY6WwGQ64M8
 ZhzyOezhTs/ceD/jYNQtbFD3mfnrfcMUApVi6ydahUBw3KSflME52h2klMvSiw4QGAdM
 FoD+CEFYLkul1DT1dKPeTCoviIMLVlYX0qD3Xg3SDkzHlCsofT1XCJ2hf551TVzpa8Gu
 2qL13dSywhklowEHVVYwAZ8zARHsjDvRBPvDYJUflOAW3lWsSo0OBfaiJpLM+uffWiQy
 AFNw==
X-Gm-Message-State: AGi0Puaxk6mp0rlt8q8mK3PaomHz+opHJn98leJLk5mPf1MMxFPTWF4/
 dEQqf7vf5oVC3OfpGvlcNzc=
X-Google-Smtp-Source: APiQypKFu6VQo9wZ2ImWp5dE+f2AtGGE9Utxo3hewgzzdXQ3XO+Uxep8KWNLlH7qpi9j+qPyCDMoPA==
X-Received: by 2002:a1c:2392:: with SMTP id
 j140mr20068496wmj.136.1586812225508; 
 Mon, 13 Apr 2020 14:10:25 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id i17sm6369018wru.39.2020.04.13.14.10.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2020 14:10:24 -0700 (PDT)
Subject: Re: [PATCH-for-5.1 1/3] hw/ide/ahci: Use qdev gpio rather than
 qemu_allocate_irqs()
To: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Alistair Francis <alistair@alistair23.me>
References: <20200412212943.4117-1-f4bug@amsat.org>
 <20200412212943.4117-2-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <298f26d5-e9d9-507a-c251-866b230ed2d7@amsat.org>
Date: Mon, 13 Apr 2020 23:10:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200412212943.4117-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Stafford Horne <shorne@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[sending again as my previous mail was rejected, sorry if you get this
twice]

On 4/12/20 11:29 PM, Philippe Mathieu-Daudé wrote:
> Switch to using the qdev gpio API which is preferred over
> qemu_allocate_irqs(). One step to eventually deprecate and
> remove qemu_allocate_irqs() one day.
> 
> Patch created mechanically using spatch with this script
> inspired from commit d6ef883d9d7:
> 
>   @@
>   typedef qemu_irq;
>   identifier irqs, handler;
>   expression opaque, count, i;
>   @@
>   -   qemu_irq *irqs;
>       ...
>   -   irqs = qemu_allocate_irqs(handler, opaque, count);
>   +   qdev_init_gpio_in(DEVICE(opaque), handler, count);
>       <+...
>   -   irqs[i]
>   +   qdev_get_gpio_in(DEVICE(opaque), i)
>       ...+>
>   ?-  g_free(irqs);
> 
> Inspired-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/ide/ahci.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 13d91e109a..ef0a0a22ee 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1534,19 +1534,18 @@ void ahci_init(AHCIState *s, DeviceState *qdev)
>  
>  void ahci_realize(AHCIState *s, DeviceState *qdev, AddressSpace *as, int ports)
>  {
> -    qemu_irq *irqs;
>      int i;
>  
>      s->as = as;
>      s->ports = ports;
>      s->dev = g_new0(AHCIDevice, ports);
>      ahci_reg_init(s);
> -    irqs = qemu_allocate_irqs(ahci_irq_set, s, s->ports);
> +    qdev_init_gpio_in(DEVICE(s), ahci_irq_set, s->ports);

This is wrong as AHCIState is not a QOM DEVICE... see commit bb639f829f1:

---
diff --git a/hw/ide/ahci.h b/hw/ide/ahci.h
index c055d6ba6b..c9b3805415 100644
--- a/hw/ide/ahci.h
+++ b/hw/ide/ahci.h
@@ -287,6 +287,8 @@ struct AHCIDevice {
 };

 typedef struct AHCIState {
+    DeviceState *container;
+
     AHCIDevice *dev;
     AHCIControlRegs control_regs;
     MemoryRegion mem;
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 02d85fa0e9..d83efa47a4 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -121,9 +121,9 @@ static uint32_t  ahci_port_read(AHCIState *s, int
port, int offset)

 static void ahci_irq_raise(AHCIState *s, AHCIDevice *dev)
 {
-    AHCIPCIState *d = container_of(s, AHCIPCIState, ahci);
-    PCIDevice *pci_dev =
-        (PCIDevice *)object_dynamic_cast(OBJECT(d), TYPE_PCI_DEVICE);
+    DeviceState *dev_state = s->container;
+    PCIDevice *pci_dev = (PCIDevice *)
object_dynamic_cast(OBJECT(dev_state),
+
TYPE_PCI_DEVICE);

     DPRINTF(0, "raise irq\n");

@@ -136,9 +136,9 @@ static void ahci_irq_raise(AHCIState *s, AHCIDevice
*dev)

 static void ahci_irq_lower(AHCIState *s, AHCIDevice *dev)
 {
-    AHCIPCIState *d = container_of(s, AHCIPCIState, ahci);
-    PCIDevice *pci_dev =
-        (PCIDevice *)object_dynamic_cast(OBJECT(d), TYPE_PCI_DEVICE);
+    DeviceState *dev_state = s->container;
+    PCIDevice *pci_dev = (PCIDevice *)
object_dynamic_cast(OBJECT(dev_state),
+
TYPE_PCI_DEVICE);

     DPRINTF(0, "lower irq\n");

@@ -1436,6 +1436,7 @@ void ahci_init(AHCIState *s, DeviceState *qdev,
AddressSpace *as, int ports)
     s->as = as;
     s->ports = ports;
     s->dev = g_new0(AHCIDevice, ports);
+    s->container = qdev;
     ahci_reg_init(s);
     /* XXX BAR size should be 1k, but that breaks, so bump it to 4k for
now */
     memory_region_init_io(&s->mem, OBJECT(qdev), &ahci_mem_ops, s,
---

Using s/DEVICE(s)/qdev/ works although.

>      for (i = 0; i < s->ports; i++) {
>          AHCIDevice *ad = &s->dev[i];
>  
>          ide_bus_new(&ad->port, sizeof(ad->port), qdev, i, 1);
> -        ide_init2(&ad->port, irqs[i]);
> +        ide_init2(&ad->port, qdev_get_gpio_in(DEVICE(s), i));
>  
>          ad->hba = s;
>          ad->port_no = i;
> @@ -1554,7 +1553,6 @@ void ahci_realize(AHCIState *s, DeviceState *qdev, AddressSpace *as, int ports)
>          ad->port.dma->ops = &ahci_dma_ops;
>          ide_register_restart_cb(&ad->port);
>      }
> -    g_free(irqs);
>  }
>  
>  void ahci_uninit(AHCIState *s)
> 

