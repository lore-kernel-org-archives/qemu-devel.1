Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1165BC43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5DD9238D7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5lSqZV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5DD9238D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKOyS-0002OD-8O
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 12:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKOx4-00014q-BW; Mon, 21 Sep 2020 12:46:06 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52309)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKOx2-0001eh-AO; Mon, 21 Sep 2020 12:46:06 -0400
Received: by mail-wm1-x341.google.com with SMTP id q9so177488wmj.2;
 Mon, 21 Sep 2020 09:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7xLLDx1x2JYSVCcdlCwiZuHm/O6qggRKuxknbHAE59g=;
 b=I5lSqZV+mKaiAA3Qy+GNk/x5Quyg8+Ok90vPdmNZi8KBBnbPc/wIPIlQiLqERTzMOZ
 bg17PnBQqXboq4d7FpTrjif+UMvNJYu3U8jYW9xbtdDBiLQhFDMm1J8YDvhY8rE/yepX
 0Ni0BJZ7dRJrCLLTC1IgU0glGqKdjQqfM3ndZO91TawsSoprRYut3cIHcisSez3cqX5X
 t7Jn1C/P92dyr4sW7Si4vALkUoDyc7lPsRJku5uuhW7pPSJYex9NYIF1bKYTt1T68Ujh
 1r7k/Q/Gs1POQXCIk3xmepHuK1bcnixE3pDBJ7VFowmcTJcTLYxR4iQlbASIl5p4Udv/
 kijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7xLLDx1x2JYSVCcdlCwiZuHm/O6qggRKuxknbHAE59g=;
 b=SP4dmO3ZBVhISo40aEMpKgBHAmxlbaNpe6SrAS94CUStt5rKdRhiCIYiGuYe3fIXzo
 c6bwnSV9N5wv9EQdClYMwNG7WMqT75ouYAkVW80dBSO7mWoUZvbTKdCvpqNljIhUrBx0
 wSxE+IH6CDtZNd+c8Pk3IZJrcJ9ycFr5y9kq3hzzZot9+0Jd8XeHjL3VLbCL1iQndiY+
 2tZM9n0eGg7tiUNLyk3A0FdffyxkQLm6S7B1D8k2gPpbR3IQtx+uVUF0EqU9AM0mduA8
 EFoMP7RMZDkG0qG1nmqHeiAta33tgM+gbLg0mPbh482CTKuzjy6a/6dTwuMU0eIZBfjJ
 YJOw==
X-Gm-Message-State: AOAM5315voo8ns8un0MF+OQy6oJaTIF4jYc45aQuagdTBda4248otR09
 beos7pJAE4EUztD259luBDU=
X-Google-Smtp-Source: ABdhPJz0fb/ANFgiAxDPtbuYAjq5x//Ow0CBmotKTg/gMvCIvvfDR0A+U2soIkiL7dBQ3SZGmSqYVw==
X-Received: by 2002:a1c:80cd:: with SMTP id b196mr285149wmd.104.1600706761187; 
 Mon, 21 Sep 2020 09:46:01 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u17sm23785661wri.45.2020.09.21.09.45.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2020 09:46:00 -0700 (PDT)
Subject: Re: [PATCH v2 12/13] hw/arm/raspi: Add the Raspberry Pi B+ machine
To: Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20200217114533.17779-1-f4bug@amsat.org>
 <20200217114533.17779-13-f4bug@amsat.org>
 <CAPan3Wr=hxEu_XdKWEYJAZXJY4hHf774O2UfsJd0OmCHc8X0OQ@mail.gmail.com>
 <4d419e3f-9e85-c014-7cc7-b25544eb341f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <28b9f5c7-5375-6f3f-2ff8-414257a62db7@amsat.org>
Date: Mon, 21 Sep 2020 18:45:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <4d419e3f-9e85-c014-7cc7-b25544eb341f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 Luc Michel <luc.michel@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/24/20 9:55 AM, Philippe Mathieu-Daudé wrote:
> On 2/22/20 11:19 PM, Niek Linnenbank wrote:
>> Hey Philippe,
>>
>> Very nice to see that the Raspberry 1 will be supported again, thanks
>> for contributing this!
>>
>> I tried to bring up the machine using raspbian 2019-09-26. It ran
>> throught the early kernel initialisation
>> but for me it gets stuck at this point:
>>
>> ./arm-softmmu/qemu-system-arm -M raspi1b -kernel
>> $HOME/raspi/boot/kernel.img -append 'printk.time=0
>> earlycon=pl011,0x20201000 console=ttyAMA0 rootwait root=/dev/mmcblk0p2' \
>> -dtb $HOME/raspi/boot/bcm2708-rpi-b-plus.dtb -m 512 -sd
>> $HOME/raspi/2019-09-26-raspbian-buster-lite.img -serial stdio -s
>>
>> [    0.000000] Booting Linux on physical CPU 0x0
>> [    0.000000] Linux version 4.19.75+ (dom@buildbot) (gcc version
>> 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1270 Tue Sep 24
>> 18:38:54 BST 2019
>> [    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7
>> (ARMv7), cr=00c5387d
>> [    0.000000] CPU: VIPT aliasing data cache, unknown instruction cache
>> [    0.000000] OF: fdt: Machine model: Raspberry Pi Model B+
>> [    0.000000] earlycon: pl11 at MMIO 0x20201000 (options '')
>> [    0.000000] bootconsole [pl11] enabled
>> [    0.000000] Memory policy: Data cache writeback
>> [    0.000000] cma: Reserved 8 MiB at 0x1b800000
>> [    0.000000] random: get_random_bytes called from
>> start_kernel+0x8c/0x49c with crng_init=0
>> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages:
>> 113680
>> [    0.000000] Kernel command line: printk.time=0
>> earlycon=pl011,0x20201000 console=ttyAMA0 rootwait root=/dev/mmcblk0p2
>> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
>> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
>> Memory: 434380K/458752K available (6973K kernel code, 635K rwdata,
>> 2080K rodata, 464K init, 797K bss, 16180K reserved, 8192K cma-reserved)
>> Virtual kernel memory layout:
>>      vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>>      fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
>>      vmalloc : 0xdc800000 - 0xff800000   ( 560 MB)
>>      lowmem  : 0xc0000000 - 0xdc000000   ( 448 MB)
>>      modules : 0xbf000000 - 0xc0000000   (  16 MB)
>>        .text : 0x(ptrval) - 0x(ptrval)   (6975 kB)
>>        .init : 0x(ptrval) - 0x(ptrval)   ( 464 kB)
>>        .data : 0x(ptrval) - 0x(ptrval)   ( 636 kB)
>>         .bss : 0x(ptrval) - 0x(ptrval)   ( 798 kB)
>> SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
>> ftrace: allocating 25197 entries in 74 pages
>> NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
>> sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every
>> 2147483647500ns
>> clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff,
>> max_idle_ns: 1911260446275 ns
>> bcm2835: system timer (irq = 27)
>> Console: colour dummy device 80x30
>>
>> Maybe it should switch to the graphical console here, but I dont see
>> the boot splash logo either (when using -stdio instead of -nographic).
>> With -M raspi2 and -dtb bcm2709-rpi-2-b.dtb the same raspbian image
>> can fully boot to the login console.
> 
> Argh this is because I split this of a bigger series and didn't included
> changes related to the GPU 'properties', sorry.

Actually it was missing SYS_timer changes, now rebased/posted:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg742694.html

> 
>>
>> Regards,
>> Niek
>>
>>
>>
>> On Mon, Feb 17, 2020 at 12:51 PM Philippe Mathieu-Daudé
>> <f4bug@amsat.org <mailto:f4bug@amsat.org>> wrote:
>>
>>        $ qemu-system-arm -M raspi1b -serial stdio \
>>            -kernel raspberrypi/firmware/boot/kernel.img \
>>            -dtb raspberrypi/firmware/boot/bcm2708-rpi-b.dtb \
>>            -append 'printk.time=0 earlycon=pl011,0x20201000
>> console=ttyAMA0'
>>        [    0.000000] Booting Linux on physical CPU 0x0
>>        [    0.000000] Linux version 4.19.69+ (dom@buildbot) (gcc version
>>     4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1261 Tue Sep
>>     3 20:21:01 BST 2019
>>        [    0.000000] CPU: ARMv6-compatible processor [410fb767]
>>     revision 7 (ARMv7), cr=00c5387d
>>        [    0.000000] CPU: VIPT aliasing data cache, unknown instruction
>>     cache
>>        [    0.000000] OF: fdt: Machine model: Raspberry Pi Model B
>>        [    0.000000] earlycon: pl11 at MMIO 0x20201000 (options '')
>>        [    0.000000] bootconsole [pl11] enabled
>>        [    0.000000] Memory policy: Data cache writeback
>>        [    0.000000] cma: Reserved 8 MiB at 0x1b800000
>>        [    0.000000] random: get_random_bytes called from
>>     start_kernel+0x8c/0x49c with crng_init=0
>>        [    0.000000] Built 1 zonelists, mobility grouping on.  Total
>>     pages: 113680
>>        [    0.000000] Kernel command line: printk.time=0
>>     earlycon=pl011,0x20201000 console=ttyAMA0
>>        Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
>>        Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
>>        Memory: 434380K/458752K available (6971K kernel code, 635K
>>     rwdata, 2080K rodata, 464K init, 797K bss, 16180K reserved, 8192K
>>     cma-reserved)
>>        ...
>>
>>     Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org
>>     <mailto:f4bug@amsat.org>>
>>     ---
>>       hw/arm/raspi.c | 13 +++++++++++++
>>       1 file changed, 13 insertions(+)
>>
>>     diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
>>     index 3537a329ac..2d9f4e3085 100644
>>     --- a/hw/arm/raspi.c
>>     +++ b/hw/arm/raspi.c
>>     @@ -324,6 +324,15 @@ static void
>>     raspi_machine_class_common_init(MachineClass *mc,
>>           mc->default_ram_size = board_ram_size(board_rev);
>>       };
>>
>>     +static void raspi1b_machine_class_init(ObjectClass *oc, void *data)
>>     +{
>>     +    MachineClass *mc = MACHINE_CLASS(oc);
>>     +    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
>>     +
>>     +    rmc->board_rev = 0x900032;
>>     +    raspi_machine_class_common_init(mc, rmc->board_rev);
>>     +};
>>     +
>>       static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
>>       {
>>           MachineClass *mc = MACHINE_CLASS(oc);
>>     @@ -348,6 +357,10 @@ static void
>>     raspi3b_machine_class_init(ObjectClass *oc, void *data)
>>
>>       static const TypeInfo raspi_machine_types[] = {
>>           {
>>     +        .name           = MACHINE_TYPE_NAME("raspi1b"),
>>     +        .parent         = TYPE_RASPI_MACHINE,
>>     +        .class_init     = raspi1b_machine_class_init,
>>     +    }, {
>>               .name           = MACHINE_TYPE_NAME("raspi2b"),
>>               .parent         = TYPE_RASPI_MACHINE,
>>               .class_init     = raspi2b_machine_class_init,
>>     --     2.21.1
>>
>>
>>
>>
>> -- 
>> Niek Linnenbank
>>

