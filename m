Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9073C43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 11:39:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D708217BA
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 11:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyvQnlqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D708217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHQML-0000L1-SQ
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 07:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kHQKo-0007qz-RL; Sun, 13 Sep 2020 07:38:20 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55534)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kHQKn-0003LU-8u; Sun, 13 Sep 2020 07:38:18 -0400
Received: by mail-wm1-x343.google.com with SMTP id d4so2730513wmd.5;
 Sun, 13 Sep 2020 04:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8bL7Tyb3MV/UEGkXFiK/mDEGsL868LauQleEyGp/R4g=;
 b=NyvQnlqVU6RB4l1RGrhqE+Cn4SraiXqEoxlJ9J5NJxiMgjycD39o5UgvTrhkuP8Ch6
 zVbYOOHrZYs22M5FV4SDgGmbGcXfknmOrbvFDZBxvqHS950lm9tPE+0u04karTj1uHIX
 ktCkgipF8+Fbsk4yjWiSivsT7ndQ5qjIZsV8RtZpX0czsYLS0FMepiv7V7P8q+kUvj/B
 TVcc8B5CK3nEPH6T3PVfiOWNUUJTDlRifT/t+/WdWCGytL/eHKsISK7s2Lwx7xGjgped
 sUz0HqcfohZ8xXsjukNv4VAqJhxrbX0SYuQm6eM7KiofWe0R0fSCAwCfaIcgxqorsomE
 mVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=8bL7Tyb3MV/UEGkXFiK/mDEGsL868LauQleEyGp/R4g=;
 b=ucBubYQdEuA8+g3DizoikHMXK9lnJVf3fvT7zZZs7utfyjwtA4w20h1EiIrhN2XC1X
 +AYx0reG+IBhbTrpvvt7nd5UZkYbK+/FRFoU+HCwYQmoS/VsR+qHSKSGVeHMRJdLl3r0
 mnrsUzTd6BVonFzxl6+IOGs2YYlUjZnYFIcAIEiyzlvBiOFQsdZDwaiz8jtWSljL/AVP
 HD++2p9wCCDq3qLDi4TWevoyp7AXqItP7bgQshJSayFzrf/E/1PrxfNVN01CsT1WcQ6c
 xxUT9EitoHjt62Q3F88NnLTGA3ZS3vMo5XrK0BHFsKBoM+grqe4ajXlQs8vxYuoroDAr
 /lOg==
X-Gm-Message-State: AOAM531QCtKnrvu9+YTwtN2dJHbpCKzJ29JJXXKmmoi92SWDq2g1NnT8
 GFDwNkksztTU/21mHt5PnFE=
X-Google-Smtp-Source: ABdhPJyV81ET+xl/q1I11BzF9sSNqafwE5CwOrHF4bqJkyTfSULEIOiKgSs1R+c+wLaaVXMyX7HZ+w==
X-Received: by 2002:a7b:c938:: with SMTP id h24mr10751468wml.142.1599997094481; 
 Sun, 13 Sep 2020 04:38:14 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id b8sm14374571wmh.48.2020.09.13.04.38.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 04:38:13 -0700 (PDT)
Subject: Re: [PATCH] hw/block/nand: Decommission the NAND museum
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
References: <20200814132118.12450-1-f4bug@amsat.org>
 <75f7421f-3ea4-ff6c-2c92-0ea9b5b8fdc1@amsat.org>
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
Message-ID: <d455e7b3-7346-2058-b13f-5455b138577b@amsat.org>
Date: Sun, 13 Sep 2020 13:38:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <75f7421f-3ea4-ff6c-2c92-0ea9b5b8fdc1@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 3:23 PM, Philippe Mathieu-Daudé wrote:
> I forgot to Cc qemu-arm@, doing it now since most of the users
> of this are ARM machines.

The machine using this device are:

- axis-dev88
- tosa (via tc6393xb_init)
- spitz based (akita, borzoi, terrier)

$ git grep nand_init
hw/arm/spitz.c:223:    s->nand = nand_init(nand ?
blk_by_legacy_dinfo(nand) : NULL,
hw/block/nand.c:641:DeviceState *nand_init(BlockBackend *blk, int
manf_id, int chip_id)
hw/cris/axis_dev88.c:278:    nand_state.nand = nand_init(nand ?
blk_by_legacy_dinfo(nand) : NULL,
hw/display/tc6393xb.c:569:    s->flash = nand_init(nand ?
blk_by_legacy_dinfo(nand) : NULL,

> 
> On 8/14/20 3:21 PM, Philippe Mathieu-Daudé wrote:
>> This is the QEMU equivalent of this Linux commit (but 7 years later):
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f7025a43a9da2
>>
>>     The MTD subsystem has its own small museum of ancient NANDs
>>     in a form of the CONFIG_MTD_NAND_MUSEUM_IDS configuration option.
>>     The museum contains stone age NANDs with 256 bytes pages, as well
>>     as iron age NANDs with 512 bytes per page and up to 8MiB page size.
>>
>>     It is with great sorrow that I inform you that the museum is being
>>     decommissioned. The MTD subsystem is out of budget for Kconfig
>>     options and already has too many of them, and there is a general
>>     kernel trend to simplify the configuration menu.
>>
>>     We remove the stone age exhibits along with closing the museum,
>>     but some of the iron age ones are transferred to the regular NAND
>>     depot. Namely, only those which have unique device IDs are
>>     transferred, and the ones which have conflicting device IDs are
>>     removed.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/block/nand.c | 13 ++++++-------
>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/block/nand.c b/hw/block/nand.c
>> index 654e0cb5d1..7d7ccc9aa4 100644
>> --- a/hw/block/nand.c
>> +++ b/hw/block/nand.c
>> @@ -137,7 +137,7 @@ static void mem_and(uint8_t *dest, const uint8_t *src, size_t n)
>>  # define ADDR_SHIFT		16
>>  # include "nand.c"
>>  
>> -/* Information based on Linux drivers/mtd/nand/nand_ids.c */
>> +/* Information based on Linux drivers/mtd/nand/raw/nand_ids.c */
>>  static const struct {
>>      int size;
>>      int width;
>> @@ -153,15 +153,14 @@ static const struct {
>>      [0xe8] = { 1,	8,	8, 4, 0 },
>>      [0xec] = { 1,	8,	8, 4, 0 },
>>      [0xea] = { 2,	8,	8, 4, 0 },
>> -    [0xd5] = { 4,	8,	9, 4, 0 },
>>      [0xe3] = { 4,	8,	9, 4, 0 },
>>      [0xe5] = { 4,	8,	9, 4, 0 },
>> -    [0xd6] = { 8,	8,	9, 4, 0 },
>>  
>> -    [0x39] = { 8,	8,	9, 4, 0 },
>> -    [0xe6] = { 8,	8,	9, 4, 0 },
>> -    [0x49] = { 8,	16,	9, 4, NAND_BUSWIDTH_16 },
>> -    [0x59] = { 8,	16,	9, 4, NAND_BUSWIDTH_16 },
>> +    [0x6b] = { 4,        8,        9, 4, 0 },
>> +    [0xe3] = { 4,        8,        9, 4, 0 },
>> +    [0xe5] = { 4,        8,        9, 4, 0 },
>> +    [0xd6] = { 8,        8,        9, 4, 0 },
>> +    [0xe6] = { 8,        8,        9, 4, 0 },
>>  
>>      [0x33] = { 16,	8,	9, 5, 0 },
>>      [0x73] = { 16,	8,	9, 5, 0 },
>>
> 

