Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EE6C4346A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A67B206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A67B206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKPF9-0003Pj-07
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 13:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kKPDy-0002ol-Ir; Mon, 21 Sep 2020 13:03:34 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:59022
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kKPDw-0003zU-Do; Mon, 21 Sep 2020 13:03:34 -0400
Received: from host81-154-161-117.range81-154.btcentralplus.com
 ([81.154.161.117] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kKPER-0000hs-ST; Mon, 21 Sep 2020 18:04:08 +0100
To: Markus Armbruster <armbru@redhat.com>
References: <20200920082018.16135-1-mark.cave-ayland@ilande.co.uk>
 <20200920082018.16135-5-mark.cave-ayland@ilande.co.uk>
 <87imc78osh.fsf@dusky.pond.sub.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <2211cf4a-c35d-cfe2-f123-9a312ea5d72c@ilande.co.uk>
Date: Mon, 21 Sep 2020 18:03:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <87imc78osh.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 81.154.161.117
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 4/6] sparc32-ledma: don't reference nd_table directly
 within the device
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, atar4qemu@gmail.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/09/2020 10:25, Markus Armbruster wrote:

> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
> 
>> Instead use qdev_set_nic_properties() to configure the on-board NIC at the
>> sun4m machine level.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  hw/dma/sparc32_dma.c |  5 -----
>>  hw/sparc/sun4m.c     | 21 +++++++++++++--------
>>  2 files changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
>> index 2cbe331959..b643b413c5 100644
>> --- a/hw/dma/sparc32_dma.c
>> +++ b/hw/dma/sparc32_dma.c
>> @@ -342,12 +342,7 @@ static void sparc32_ledma_device_realize(DeviceState *dev, Error **errp)
>>  {
>>      LEDMADeviceState *s = SPARC32_LEDMA_DEVICE(dev);
>>      SysBusPCNetState *lance = SYSBUS_PCNET(&s->lance);
>> -    NICInfo *nd = &nd_table[0];
>>  
>> -    /* FIXME use qdev NIC properties instead of nd_table[] */
>> -    qemu_check_nic_model(nd, TYPE_LANCE);
>> -
>> -    qdev_set_nic_properties(DEVICE(lance), nd);
>>      object_property_set_link(OBJECT(lance), "dma", OBJECT(dev), &error_abort);
>>      sysbus_realize(SYS_BUS_DEVICE(lance), &error_fatal);
>>  }
>> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
>> index 947b69d159..ed5f3ccd9f 100644
>> --- a/hw/sparc/sun4m.c
>> +++ b/hw/sparc/sun4m.c
>> @@ -319,7 +319,7 @@ static void *iommu_init(hwaddr addr, uint32_t version, qemu_irq irq)
>>  
>>  static void *sparc32_dma_init(hwaddr dma_base,
>>                                hwaddr esp_base, qemu_irq espdma_irq,
>> -                              hwaddr le_base, qemu_irq ledma_irq)
>> +                              hwaddr le_base, qemu_irq ledma_irq, NICInfo *nd)
>>  {
>>      DeviceState *dma;
>>      ESPDMADeviceState *espdma;
>> @@ -328,16 +328,11 @@ static void *sparc32_dma_init(hwaddr dma_base,
>>      SysBusPCNetState *lance;
>>  
>>      dma = qdev_new(TYPE_SPARC32_DMA);
>> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
>> -    sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, dma_base);
>> -
>>      espdma = SPARC32_ESPDMA_DEVICE(object_resolve_path_component(
>>                                     OBJECT(dma), "espdma"));
>>      sysbus_connect_irq(SYS_BUS_DEVICE(espdma), 0, espdma_irq);
>>  
>>      esp = ESP(object_resolve_path_component(OBJECT(espdma), "esp"));
>> -    sysbus_mmio_map(SYS_BUS_DEVICE(esp), 0, esp_base);
>> -    scsi_bus_legacy_handle_cmdline(&esp->esp.bus);
>>  
>>      ledma = SPARC32_LEDMA_DEVICE(object_resolve_path_component(
>>                                   OBJECT(dma), "ledma"));
>> @@ -345,6 +340,14 @@ static void *sparc32_dma_init(hwaddr dma_base,
>>  
>>      lance = SYSBUS_PCNET(object_resolve_path_component(
>>                           OBJECT(ledma), "lance"));
>> +    qdev_set_nic_properties(DEVICE(lance), nd);
>> +
>> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, dma_base);
>> +
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(esp), 0, esp_base);
>> +    scsi_bus_legacy_handle_cmdline(&esp->esp.bus);
>> +
>>      sysbus_mmio_map(SYS_BUS_DEVICE(lance), 0, le_base);
>>  
>>      return dma;
> 
> You delay a bit of work on devices @dma and @esp.  Can you explain why?

This is where it starts to get a little hazy: the sysbus_mmio_map() for the dma
device should be fine, since that's the container device for ledma and espdma devices
which is realised the line above.

The call to scsi_bus_legacy_handle_cmdline() is interesting - AFAICT if the esp
device within the dma device hasn't been realised then I get a crash, and that's why
I moved the legacy command line handling to after realise.

The lance and esp devices are embedded within ledma and espdma devices respectively,
but are actually sysbus devices because they can be used by other machines. I'm not
sure if lance is used anywhere else, but esp certainly is. Hence they are mapped
after the dma device is realised as it feels odd to attach devices to sysbus outside
of a machine init function.


ATB,

Mark.

