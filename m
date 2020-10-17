Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0712AC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 11:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7B620704
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 11:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7B620704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTkGe-0008Oq-Nf
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 07:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kTkFk-0007eX-Ef; Sat, 17 Oct 2020 07:20:00 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:58572
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kTkFi-0002MM-PM; Sat, 17 Oct 2020 07:20:00 -0400
Received: from host86-148-246-80.range86-148.btcentralplus.com
 ([86.148.246.80] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kTkFc-00040J-Du; Sat, 17 Oct 2020 12:19:58 +0100
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org, hpoussin@reactos.org,
 qemu-ppc@nongnu.org, atar4qemu@gmail.com, david@gibson.dropbear.id.au
References: <20201016182739.22875-1-mark.cave-ayland@ilande.co.uk>
 <20201016182739.22875-6-mark.cave-ayland@ilande.co.uk>
 <ad533302-e715-cc8a-12ec-d7e4ad75c120@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <3a5a388d-8be7-dc1b-401f-ed9e8fa3b554@ilande.co.uk>
Date: Sat, 17 Oct 2020 12:19:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <ad533302-e715-cc8a-12ec-d7e4ad75c120@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.148.246.80
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 5/5] m48t59: remove legacy m48t59_init() function
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.253,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/10/2020 10:53, Philippe Mathieu-Daudé wrote:

> On 10/16/20 8:27 PM, Mark Cave-Ayland wrote:
>> Now that all of the callers of this function have been switched to use qdev
>> properties, this legacy init function can now be removed.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/rtc/m48t59.c         | 35 -----------------------------------
>>   include/hw/rtc/m48t59.h |  4 ----
>>   2 files changed, 39 deletions(-)
> 
> In the PoC I started after your suggestion, I see:
> 
> #define TYPE_M48T02_SRAM "sysbus-m48t02"
> #define TYPE_M48T08_SRAM "sysbus-m48t08"
> #define TYPE_M48T59_SRAM "sysbus-m48t59"
> 
> static void m48t02_class_init(ObjectClass *oc, void *data)
> {
>      M48txxSysBusDeviceClass *amc = M48TXX_SYS_BUS_CLASS(oc);
> 
>      amc->model = 2;
>      amc->size = 2 * KiB;
> };
> 
> static void m48t08_class_init(ObjectClass *oc, void *data)
> {
>      M48txxSysBusDeviceClass *amc = M48TXX_SYS_BUS_CLASS(oc);
> 
>      amc->model = 8;
>      amc->size = 8 * KiB;
> };
> 
> static void m48t59_class_init(ObjectClass *oc, void *data)
> {
>      M48txxSysBusDeviceClass *amc = M48TXX_SYS_BUS_CLASS(oc);
> 
>      amc->model = 59;
>      amc->size = 8 * KiB;
> };
> 
> static const TypeInfo m48t59_register_types[] = {
>      {
>          .name           = TYPE_M48T02_SRAM,
>          .parent         = TYPE_M48TXX_SYSBUS,
>          .class_init     = m48t02_class_init,
>      }, {
>          .name           = TYPE_M48T08_SRAM,
>          .parent         = TYPE_M48TXX_SYSBUS,
>          .class_init     = m48t08_class_init,
>      }, {
>          .name           = TYPE_M48T59_SRAM,
>          .parent         = TYPE_M48TXX_SYSBUS,
>          .class_init     = m48t59_class_init,
>      }, {
>          .name           = TYPE_M48TXX_SYSBUS,
>          .parent         = TYPE_SYS_BUS_DEVICE,
>          .instance_size  = sizeof(M48txxSysBusState),
>          .instance_init = m48t59_init1,
>          .class_size     = sizeof(M48txxSysBusDeviceClass),
>          .class_init     = m48txx_sysbus_class_init,
>          .abstract       = true,
>          .interfaces = (InterfaceInfo[]) {
>              { TYPE_NVRAM },
>              { }
>          }
>      }
> };
> 
> and:
> 
> #define TYPE_M48T59_SRAM "isa-m48t59"
> 
> static void m48t59_class_init(ObjectClass *oc, void *data)
> {
>      M48txxISADeviceClass *midc = M48TXX_ISA_CLASS(oc);
> 
>      midc->model = 59;
>      midc->size = 8 * KiB;
> };
> 
> static const TypeInfo m48t59_isa_register_types[] = {
>      {
>          .name           = TYPE_M48T59_SRAM,
>          .parent         = TYPE_M48TXX_ISA,
>          .class_init     = m48t59_class_init,
>      }, {
>          .name           = TYPE_M48TXX_ISA,
>          .parent         = TYPE_ISA_DEVICE,
>          .instance_size  = sizeof(M48txxISAState),
>          .class_size     = sizeof(M48txxISADeviceClass),
>          .class_init     = m48txx_isa_class_init,
>          .abstract       = true,
>          .interfaces = (InterfaceInfo[]) {
>              { TYPE_NVRAM },
>              { }
>          }
>      }
> };
> 
> I guess I didn't pursue because I wondered what was the
> best way to have the same model usable by sysbus/isa.
> 
> IIRC I wanted to proceed as having TYPE_M48T59_SRAM being
> an abstract qdev parent, and then TYPE_M48TXX_SYSBUS /
> TYPE_M48TXX_ISA implementing the SYSBUS/ISA interfaces.
> 
> As it need some thinking I postponed that for after 5.2.
> 
> Anyhow back to this patch:
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Ha indeed, I think you also came to the same conclusion that I did in my previous 
email :)

I'm also not convinced by the dynamic generation of various M48TXX types using 
class_data - this seems overly complex, and there's nothing there I can see that 
can't be just as easily handled using qdev properties using an abstract parent as you 
suggest above.


ATB,

Mark.

