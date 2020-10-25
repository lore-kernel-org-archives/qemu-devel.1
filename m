Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638BCC388F7
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 20:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A555A22265
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 20:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pifplIaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A555A22265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWmZW-0000df-Iv
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 16:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWmYq-00005o-3A; Sun, 25 Oct 2020 16:24:16 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWmYo-0003cK-Bz; Sun, 25 Oct 2020 16:24:15 -0400
Received: by mail-wr1-x444.google.com with SMTP id e17so10165574wru.12;
 Sun, 25 Oct 2020 13:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=THVXZtFk1+0rqc3vAyqUiK0iOcElwAkwgVDLMAHZfsM=;
 b=pifplIaAR4p+1Kl+enwT/7Cr/mb5qzqYbSxgXYek355LFrrveOfIlj/WcnKA3okYJp
 Uu+GPZOaCCu3XupyOZZ661N2hbZi0Rk4jx7COkI3y4kLnzw/Q1YDdYt8B5NaRxIp91kU
 w6op9AzWlg59oUTPGQMXB3ajsoaTbTj71o+DmFKbSHoG5Rb/GrRjJPswqhaAT/PjtD9i
 g/XQkFfRTqZ3BNHUf+2PK8pibo2WRC44QoBMSHtKsYyne0AklhkANsfVHkqmouLvqSKY
 aShHmUY6H2j+zDYMH58Op3I2mrWveWnb2wp13DMzCpzx/g+dp7uKfwkxCC8uBDJGrhQU
 Qd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=THVXZtFk1+0rqc3vAyqUiK0iOcElwAkwgVDLMAHZfsM=;
 b=nLlFOrOgf04bUkEkCklTYo0AopgdkN55myFRu0dBb5L6EAg1AsFXniqh0/jyoDqycB
 ahLyL+ZdJs52jc5RYj5lwSpf+reQmeo1z4lqoc31cyS4a91IUbV5zCBQW37x3saLO8fU
 c6v9d3HnkCFHDQhHqW+dsGNS0BiHQVaB+ObrqRlGNbT5P5hhp+OxwVnVzNRLLMpZMCZR
 +Cf+JfirFKuhIFhwBJsFdb8OX3HhCKUm/IOdfMovgOm2m5wYSrvg8ULr1SbxAYmgLRdj
 +VR2jbMALFMaCQQInHV/QAAfDma7sTXmOBbX3ADrmNCub/Q1KbylYkTRUHJkbhhA4icC
 EoWA==
X-Gm-Message-State: AOAM531cz87wiv8K43JdBCYyaWZ4gCIicJ2wPRYkD4Cj8xMIi9VtEJgC
 A3vh36QNpGkGCcVYpVYrfxk=
X-Google-Smtp-Source: ABdhPJx5v97bYUSLtIY23tAVA0N39JSIAAc2HgE1ybbOIks9z6lJXuD1qbAmfXVyXXp2S45FsPyyLA==
X-Received: by 2002:a5d:44cb:: with SMTP id z11mr13795353wrr.290.1603657452176; 
 Sun, 25 Oct 2020 13:24:12 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id v19sm16317823wmj.31.2020.10.25.13.24.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2020 13:24:11 -0700 (PDT)
Subject: Re: [PATCH] hw/sd: Fix 2 GiB card CSD register values
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20201025152357.11865-1-bmeng.cn@gmail.com>
 <10ba2a1c-4e8d-a860-2e8d-99dd32e61c9e@amsat.org>
Message-ID: <59a5519d-84ff-bf2a-b7ee-8d05d86daa9d@amsat.org>
Date: Sun, 25 Oct 2020 21:24:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <10ba2a1c-4e8d-a860-2e8d-99dd32e61c9e@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>,
 Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/25/20 7:56 PM, Philippe Mathieu-Daudé wrote:
> On 10/25/20 4:23 PM, Bin Meng wrote:
>> From: Bin Meng <bin.meng@windriver.com>
>>
>> Per the SD spec, to indicate a 2 GiB card, BLOCK_LEN shall be 1024
>> bytes, hence the READ_BL_LEN field in the CSD register shall be 10
>> instead of 9.
>>
>> This fixes the acceptance test error for the NetBSD 9.0 test of the
>> Orange Pi PC that has an expanded SD card image of 2 GiB size.
>>
>> Fixes: 6d2d4069c47e ("hw/sd: Correct the maximum size of a Standard 
>> Capacity SD Memory Card")
>> Reported-by: Niek Linnenbank <nieklinnenbank@gmail.com>
>> Signed-off-by: Bin Meng <bin.meng@windriver.com>
>> ---
>>
>>   hw/sd/sd.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index bd10ec8fc4..732fcb5ff0 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -386,10 +386,17 @@ static const uint8_t sd_csd_rw_mask[16] = {
>>   static void sd_set_csd(SDState *sd, uint64_t size)
>>   {
>> -    uint32_t csize = (size >> (CMULT_SHIFT + HWBLOCK_SHIFT)) - 1;
>> +    int hwblock_shift = HWBLOCK_SHIFT;
>> +    uint32_t csize;
>>       uint32_t sectsize = (1 << (SECTOR_SHIFT + 1)) - 1;
>>       uint32_t wpsize = (1 << (WPGROUP_SHIFT + 1)) - 1;
>> +    /* To indicate 2 GiB card, BLOCK_LEN shall be 1024 bytes */
>> +    if (size == SDSC_MAX_CAPACITY) {
>> +        hwblock_shift += 1;
> 
> This is going in the good direction, however now we have an huge
> security hole, as SDState::data[] is 512 bytes, and you announce the
> guest it can use 1024 bytes. See sd_blk_read() and sd_blk_write().
> 
> Now SDState::data[] is migrated, so this isn't an easy field to
> modify without breaking compatibility again :(

OMG see commit 12c125cba9c ("sd: Switch to byte-based block access")...
We have 512 bytes available just after the 512 data[] in the migration
stream!!! How can we be that lucky? =)

> 
> I've been working on a more robust approach today, doing some cleanup
> first. I'll send it during the next days hopefully.
> 
>> +    }
>> +    csize = (size >> (CMULT_SHIFT + hwblock_shift)) - 1;
>> +
>>       if (size <= SDSC_MAX_CAPACITY) { /* Standard Capacity SD */
>>           sd->csd[0] = 0x00;    /* CSD structure */
>>           sd->csd[1] = 0x26;    /* Data read access-time-1 */
>> @@ -397,7 +404,7 @@ static void sd_set_csd(SDState *sd, uint64_t size)
>>           sd->csd[3] = 0x32;      /* Max. data transfer rate: 25 MHz */
>>           sd->csd[4] = 0x5f;    /* Card Command Classes */
>>           sd->csd[5] = 0x50 |    /* Max. read data block length */
>> -            HWBLOCK_SHIFT;
>> +            hwblock_shift;
>>           sd->csd[6] = 0xe0 |    /* Partial block for read allowed */
>>               ((csize >> 10) & 0x03);
>>           sd->csd[7] = 0x00 |    /* Device size */
>> @@ -411,9 +418,9 @@ static void sd_set_csd(SDState *sd, uint64_t size)
>>           sd->csd[11] = 0x00 |    /* Write protect group size */
>>               ((sectsize << 7) & 0x80) | wpsize;
>>           sd->csd[12] = 0x90 |    /* Write speed factor */
>> -            (HWBLOCK_SHIFT >> 2);
>> +            (hwblock_shift >> 2);
>>           sd->csd[13] = 0x20 |    /* Max. write data block length */
>> -            ((HWBLOCK_SHIFT << 6) & 0xc0);
>> +            ((hwblock_shift << 6) & 0xc0);
>>           sd->csd[14] = 0x00;    /* File format group */
>>       } else {            /* SDHC */
>>           size /= 512 * KiB;
>>
> 

