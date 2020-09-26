Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B01C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 08:09:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A460C2083B
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 08:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A460C2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kM5Gu-0002RS-6N
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 04:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kM5G0-0001ri-2L; Sat, 26 Sep 2020 04:08:36 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:53437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kM5Fy-0001Y3-5e; Sat, 26 Sep 2020 04:08:35 -0400
Received: from [192.168.100.1] ([82.252.129.222]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MLRI3-1k48iy1rMZ-00IXg7; Sat, 26 Sep 2020 10:08:07 +0200
Subject: Re: [PATCH] hw/scsi/lsi53c895a: Sanitize some trace events format
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200915174639.1366226-1-philmd@redhat.com>
 <8934c787-b909-e885-b15a-c4bcd194f458@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0f936b80-f33a-d166-45c2-d96d323936b8@vivier.eu>
Date: Sat, 26 Sep 2020 10:08:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <8934c787-b909-e885-b15a-c4bcd194f458@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:e9LhqDtroO2oKEXY8Dd7gSRYx4jh/aQ4du2jD9ku3FQ6hbK2iED
 0wH0IG6i7HF3wL0yn1PoPc2JBBYyFx18wDsuVBS7YXtjgwBGra+MPfSJ9b/+o1Psu6PlhWR
 K/pY96N4ZxOoP3HHN/8kt5nZYRxLhp1nyZg+LpzsGPkhe3KT5FHcItvbNiBb2phJpUZjqmi
 5HoynGLuNI/iAjk1v3b+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AzSvWAmNzfs=:iFHwVJOrt7D4q7h/3uA6Q4
 Gsy24mXIfqH7u3jsvjO4sUPySI97yt6SpS5QBeAjwzNx8nzxAj4Gl1ffShkF2oaF/t6g7tVrU
 4Gslz4dchYjLjc6xrY/p6Ze9qj7EUKl/MsbB9wgyYBjMI8vIskt4xWfxtxzx5xdZ+x34kvwfp
 YERRvFtlh+2iSeA19RMUtqvk6INOiyz23RinY+o6Dvr7DSHTXd0tYzoI2xMQwVjx7DfO19La+
 5SdXQGY/rNR5/1+ljOFwp7DssZSqfX8nEhqGjoGZ68xb87XyORHq1mQCPNkJcX8jhjv3II5Sw
 fg9iJsVeRkz+8BLWNBI7LH76gfhHVeqlEofG7Tg5h1ag4pHtZUtN3FXhV7MMlUGNcU4orixj3
 l41DsWn6vABp+U7+fEfxHbMBO7nFZTBzLUFR6HPEBnN3/UNA3yFMkIfEMLehqCcEKRHVou7MA
 KmWMRRI5JnJhggBU8PweFtaRhYHP8DChz/akz8gPUkkYe6lyktZWWoK1aKz43LxfY9HD5iwlT
 YmXHTr0NXk60AqU+Dxzc68GHe6q6jXO30HqA3O4KsTQD+1BONwK4tI1pQvEkaAas3tLE4V/qz
 fU8lk9XTdQPSKlLTzy5tctyRjDSiM5yVM3g48zfQY3ghna2ehw4eamijSbBl100HMOLJsPRfu
 GacJfkMH5itAsr8tqsyw5dYhbHCpiyJdPDkPaqZXjcmxx/HLSYULz6A9yqY/y1pl5498gJGs1
 x004UUQyqvyfpxuWlfUiOwJNg6H7NNT7uZ6pVhQCP7I4BvhCYe9f9mN1dE9odF9scBAgb/JwI
 dUiP10wZxFkIPakXngrkXmZJ5Xm0BT+p/Rx2Mu9BUTHI8Te38N3227kkz4kPq+1UFm6F9EU
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/26 04:08:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.238,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/09/2020 à 22:12, Paolo Bonzini a écrit :
> On 15/09/20 19:46, Philippe Mathieu-Daudé wrote:
>> Make some lsi53c895a trace events more understandable.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/scsi/trace-events | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
>> index 9a4a60ca635..ac4209f361e 100644
>> --- a/hw/scsi/trace-events
>> +++ b/hw/scsi/trace-events
>> @@ -234,9 +234,9 @@ spapr_vscsi_do_crq(unsigned c0, unsigned c1) "crq: %02x %02x ..."
>>  
>>  # lsi53c895a.c
>>  lsi_reset(void) "Reset"
>> -lsi_update_irq(int level, uint8_t dstat, uint8_t sist1, uint8_t sist0) "Update IRQ level %d dstat 0x%02x sist 0x%02x0x%02x"
>> +lsi_update_irq(int level, uint8_t dstat, uint8_t sist1, uint8_t sist0) "Update IRQ level %d dstat 0x%02x sist 1:0x%02x 0:0x%02x"
>>  lsi_update_irq_disconnected(void) "Handled IRQs & disconnected, looking for pending processes"
>> -lsi_script_scsi_interrupt(uint8_t stat1, uint8_t stat0, uint8_t sist1, uint8_t sist0) "SCSI Interrupt 0x%02x0x%02x prev 0x%02x0x%02x"
>> +lsi_script_scsi_interrupt(uint8_t stat1, uint8_t stat0, uint8_t sist1, uint8_t sist0) "SCSI Interrupt stat 1:0x%02x 0:0x%02x sist 1:0x%02x 0:0x%02x"
>>  lsi_script_dma_interrupt(uint8_t stat, uint8_t dstat) "DMA Interrupt 0x%x prev 0x%x"
>>  lsi_bad_phase_jump(uint32_t dsp) "Data phase mismatch jump to 0x%"PRIX32
>>  lsi_bad_phase_interrupt(void) "Phase mismatch interrupt"
>>
> 
> The idea of the patch is that SIST0 and SIST1 are usually read in pairs.
>  So it's a bit weird in the tracepoint format but it's actually more
> understandable this way when you see it printed.
> 
> Laurent, can you please unqueue this?

No problem. Done.

Thanks,
Laurent

