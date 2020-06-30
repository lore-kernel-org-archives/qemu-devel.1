Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695E6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FCDA20675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3jbH9Y/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FCDA20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqD51-0007OV-No
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqD41-0006oD-Ju; Tue, 30 Jun 2020 06:00:29 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:43361)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqD3z-00047Q-Uu; Tue, 30 Jun 2020 06:00:29 -0400
Received: by mail-ed1-x542.google.com with SMTP id d15so15588245edm.10;
 Tue, 30 Jun 2020 03:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wP+KWXpq2yGZrKogw0wPbBHdHwie6uhbtS+YQR5YgnA=;
 b=c3jbH9Y/xd+KLx7w8pYdjYI9gZ1Czc192YXumgjOs5XQlXn1145gL02Sz7Hv3CgiN9
 GBeroTDeBPcoeqzS7TCd0bub5vABjwH0BhfCLwFeO9US0ksQZm64ik+9iFHO4XQI134g
 M4im3TbHNq5/MeOsJKvc1xskQ2aP49Gp7RozV9uai9qfTRAp94lfkh0Sr7Pgs95w0vZ7
 aohgqwC46QMCwVRDI4uyZtvUTFfohsvPyYpyNCM9dCalVSSG0ZUlyq+T0FtDWVgWWwtO
 tABcgKcB97ttJ2ubJfJFDUzXp4SFr8CWazqNXwnVo3UwrnHZUgF2ctjh7BBahOfJzkc9
 f6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wP+KWXpq2yGZrKogw0wPbBHdHwie6uhbtS+YQR5YgnA=;
 b=B2diFvImRkL2D1rYovhSx8WKgKr7qWvvDMQlKKXXhM5KtyInYoQ3XOJB7SdGRKWU0G
 yMFtBAxwy4Ob9LRWLdwYZ7yjphNTGoCukU73TyYHMBHwp33PBA3E6GytX06dsLOdsuhS
 pYRJ+c1TTy7zsrl5q65XP8gmt/64vPDcGqbY0j0m19JUBqcJQOlb3WuZnJCBE/b9tRD6
 5E7UOjx/HwVkuUQhRxvjcE9xq91odKy2oQ1SIABkZte4+oeSIk5dVB79qn8Ng6YtqjvN
 UCTaXyW1+zWifv3DuQtw9srp38Ei/SoGfXBcCbgsNhVzKaQ7Lxn46ruHgozQy2SZSw7d
 Ka2w==
X-Gm-Message-State: AOAM530UXfNvo2zHOfdG5U/LBETmWruWH2uIYU3jKE+Td0JlI/c2cQbr
 Nd6DR/4CK97o16TcLhuaTDzggRxa3v0=
X-Google-Smtp-Source: ABdhPJxSOXNZYrmXyMfsMrnKCxVBCAZfn7RBXBSwMjrihOYsEo27g9CiCS/Cx5H6Dtvw5yCENaTQZA==
X-Received: by 2002:a50:b2c2:: with SMTP id p60mr21527451edd.374.1593511224945; 
 Tue, 30 Jun 2020 03:00:24 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o6sm592499edr.94.2020.06.30.03.00.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 03:00:24 -0700 (PDT)
Subject: Re: [PATCH v5 08/15] hw/sd/sdcard: Check address is in range
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200626164026.766-1-f4bug@amsat.org>
 <20200626164026.766-9-f4bug@amsat.org>
 <001fb1d8-c689-36b9-3d49-31285c82422a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0149de5e-3b9c-51ce-ef75-870bd363b5b8@amsat.org>
Date: Tue, 30 Jun 2020 12:00:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <001fb1d8-c689-36b9-3d49-31285c82422a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/20 7:43 PM, Philippe Mathieu-Daudé wrote:
> On 6/26/20 6:40 PM, Philippe Mathieu-Daudé wrote:
>> As a defense, assert if the requested address is out of the card area.
>>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/sd/sd.c | 18 ++++++++++--------
>>  1 file changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 22392e5084..2689a27b49 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -537,8 +537,10 @@ static void sd_response_r7_make(SDState *sd, uint8_t *response)
>>      stl_be_p(response, sd->vhs);
>>  }
>>  
>> -static inline uint64_t sd_addr_to_wpnum(uint64_t addr)
>> +static uint64_t sd_addr_to_wpnum(SDState *sd, uint64_t addr)
>>  {
>> +    assert(addr < sd->size);
> 
> This should be:
> 
>        assert(addr <= sd->size);

No, the current code is correct...

> 
>> +
>>      return addr >> (HWBLOCK_SHIFT + SECTOR_SHIFT + WPGROUP_SHIFT);
>>  }
>>  
>> @@ -575,7 +577,7 @@ static void sd_reset(DeviceState *dev)
>>      sd_set_cardstatus(sd);
>>      sd_set_sdstatus(sd);
>>  
>> -    sect = sd_addr_to_wpnum(size) + 1;
>> +    sect = sd_addr_to_wpnum(sd, size) + 1;

... but here this should be:

        sect = sd_addr_to_wpnum(sd, size - 1) + 1;

>>      g_free(sd->wp_groups);
>>      sd->wp_switch = sd->blk ? blk_is_read_only(sd->blk) : false;
>>      sd->wpgrps_size = sect;
>> @@ -759,8 +761,8 @@ static void sd_erase(SDState *sd)
>>          erase_end *= HWBLOCK_SIZE;
>>      }
>>  
>> -    erase_start = sd_addr_to_wpnum(erase_start);
>> -    erase_end = sd_addr_to_wpnum(erase_end);
>> +    erase_start = sd_addr_to_wpnum(sd, erase_start);
>> +    erase_end = sd_addr_to_wpnum(sd, erase_end);
>>      sd->erase_start = 0;
>>      sd->erase_end = 0;
>>      sd->csd[14] |= 0x40;
>> @@ -777,7 +779,7 @@ static uint32_t sd_wpbits(SDState *sd, uint64_t addr)
>>      uint32_t i, wpnum;
>>      uint32_t ret = 0;
>>  
>> -    wpnum = sd_addr_to_wpnum(addr);
>> +    wpnum = sd_addr_to_wpnum(sd, addr);
>>  
>>      for (i = 0; i < 32; i++, wpnum++, addr += WPGROUP_SIZE) {
>>          if (addr < sd->size && test_bit(wpnum, sd->wp_groups)) {
>> @@ -819,7 +821,7 @@ static void sd_function_switch(SDState *sd, uint32_t arg)
>>  
>>  static inline bool sd_wp_addr(SDState *sd, uint64_t addr)
>>  {
>> -    return test_bit(sd_addr_to_wpnum(addr), sd->wp_groups);
>> +    return test_bit(sd_addr_to_wpnum(sd, addr), sd->wp_groups);
>>  }
>>  
>>  static void sd_lock_command(SDState *sd)
>> @@ -1331,7 +1333,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>>              }
>>  
>>              sd->state = sd_programming_state;
>> -            set_bit(sd_addr_to_wpnum(addr), sd->wp_groups);
>> +            set_bit(sd_addr_to_wpnum(sd, addr), sd->wp_groups);
>>              /* Bzzzzzzztt .... Operation complete.  */
>>              sd->state = sd_transfer_state;
>>              return sd_r1b;
>> @@ -1350,7 +1352,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>>              }
>>  
>>              sd->state = sd_programming_state;
>> -            clear_bit(sd_addr_to_wpnum(addr), sd->wp_groups);
>> +            clear_bit(sd_addr_to_wpnum(sd, addr), sd->wp_groups);
>>              /* Bzzzzzzztt .... Operation complete.  */
>>              sd->state = sd_transfer_state;
>>              return sd_r1b;
>>
> 

