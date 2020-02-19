Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB13C34022
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 06:45:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D96A2176D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 06:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="zQx9gG+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D96A2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4J6w-00012W-M7
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 01:45:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1j4J6A-0000BA-S5
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 01:44:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1j4J68-0001Pb-S1
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 01:44:42 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46202)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1j4J68-0001NT-CU
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 01:44:40 -0500
Received: by mail-pg1-x541.google.com with SMTP id y30so593352pga.13
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 22:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:from:to:cc:references:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=L1AlwN3oM5BKpno5UsItpNNul+JBnw1pH1ry9RnYEZU=;
 b=zQx9gG+BW273QEa2LcNFjkpQPPltIiNj+1JNrSmIYuzbtZPgoXgjo6ypPUd+r7oiTU
 cKY7/ex3cn56h1Qoi9m38dZzlD6A6QxfcN6enFbdZxFAAp1pHmVAhcee8wkL0Abmw9Se
 c9Lid+MHLRRmP3MwkjHmyWMrawjC6lHjES/MQI9Y/m1N05kLfoNryy4EACugClwhuxpX
 C+K6lKEfPRga0CHYWpzSKLwWGAV7c7zYbAr5GIid6KW9N9N0aKCeTgaGfo+Pf+s6ahdx
 +QWpG3K8GXD2GpVDIRml2HqWd+yJfz/s3qDRyuVtwhkASAhFm0WEPP8NwF4HveFy8uqO
 RI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=L1AlwN3oM5BKpno5UsItpNNul+JBnw1pH1ry9RnYEZU=;
 b=l9k0feZb6q6GU50Aq2o3neEl7L+4Reh7r3v5tCc3OoY6bSMgQoWRj3Q6kJW03oiDc6
 vOh1uw/9qdVGmpCIPkZDMAFb3MJ3YMNyIqJQVKFkU34vxDmbdn1KBwsnMtnDUEI1U4Sw
 eLyt/g4NRxPJKZ/H48IwrfRLYkKBAVgA6ApKHyCmld5xCqYh5i3/ptKNRUdQYRYoyd/Y
 d5sFlMB3exyw12v+qIuo238+9eJfdP963etJIl2FCiapTRj0GjukH7hwz0rvf0Fnsia4
 GZbV/eNnDAG7i+VwkxAwbG33wwgdoF9qEZbeq/oFR0mNWnVpgwjF18udSVeYylnmnw/U
 Z9Mw==
X-Gm-Message-State: APjAAAVZUKJWeFaniYfcDswPw9LudowLlt0Dn0JBbp5HohhEGzOhoeFw
 OL005QWLSvr5Qavo78Kl9kH9+nkAQ/I=
X-Google-Smtp-Source: APXvYqyvnl/QelKCGKhnIBT/81AjGuLuObfL96VCVrye68NcGPMvukL5aSMTmQouSpxdECPhRgQJIw==
X-Received: by 2002:a63:5508:: with SMTP id j8mr25873616pgb.170.1582094678185; 
 Tue, 18 Feb 2020 22:44:38 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id f3sm1280868pfg.115.2020.02.18.22.44.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 22:44:37 -0800 (PST)
Subject: Re: [PULL SUBSYSTEM qemu-pseries] pseries: Update SLOF firmware image
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200217021217.95766-1-aik@ozlabs.ru>
 <8e67117e-e74a-fb5c-226b-78e62ac26291@kaod.org>
 <44499677-3099-56c6-7249-afa8eccc7668@ozlabs.ru>
 <bdfb7d07-c5fd-c21e-f812-4a0a747b02c3@kaod.org>
 <0c21bb33-e6c0-c117-c9e7-dda16d3b13a5@ozlabs.ru>
 <4a8261b3-3842-869c-0997-b997229ff3f6@ozlabs.ru>
 <20649920-f867-7193-e86e-89b42ec6ae97@kaod.org>
 <474f7204-fcee-ae4b-eb9a-d5d0a987c4a2@kaod.org>
 <74ccc95e-d4bb-e540-5d63-ab057c504806@kaod.org>
 <4914aaf9-18e9-54e7-c71c-d2aeb9b573f4@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <67b9d53f-110a-47c7-b6c9-d1cf9ace3e3b@ozlabs.ru>
Date: Wed, 19 Feb 2020 17:44:34 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <4914aaf9-18e9-54e7-c71c-d2aeb9b573f4@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 19/02/2020 12:20, Alexey Kardashevskiy wrote:
> 
> 
> On 18/02/2020 23:59, Cédric Le Goater wrote:
>> On 2/18/20 1:48 PM, Cédric Le Goater wrote:
>>> On 2/18/20 10:40 AM, Cédric Le Goater wrote:
>>>> On 2/18/20 10:10 AM, Alexey Kardashevskiy wrote:
>>>>>
>>>>>
>>>>> On 18/02/2020 20:05, Alexey Kardashevskiy wrote:
>>>>>>
>>>>>>
>>>>>> On 18/02/2020 18:12, Cédric Le Goater wrote:
>>>>>>> On 2/18/20 1:30 AM, Alexey Kardashevskiy wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 17/02/2020 20:48, Cédric Le Goater wrote:
>>>>>>>>> On 2/17/20 3:12 AM, Alexey Kardashevskiy wrote:
>>>>>>>>>> The following changes since commit 05943fb4ca41f626078014c0327781815c6584c5:
>>>>>>>>>>
>>>>>>>>>>   ppc: free 'fdt' after reset the machine (2020-02-17 11:27:23 +1100)
>>>>>>>>>>
>>>>>>>>>> are available in the Git repository at:
>>>>>>>>>>
>>>>>>>>>>   git@github.com:aik/qemu.git tags/qemu-slof-20200217
>>>>>>>>>>
>>>>>>>>>> for you to fetch changes up to ea9a03e5aa023c5391bab5259898475d0298aac2:
>>>>>>>>>>
>>>>>>>>>>   pseries: Update SLOF firmware image (2020-02-17 13:08:59 +1100)
>>>>>>>>>>
>>>>>>>>>> ----------------------------------------------------------------
>>>>>>>>>> Alexey Kardashevskiy (1):
>>>>>>>>>>       pseries: Update SLOF firmware image
>>>>>>>>>>
>>>>>>>>>>  pc-bios/README   |   2 +-
>>>>>>>>>>  pc-bios/slof.bin | Bin 931032 -> 968560 bytes
>>>>>>>>>>  roms/SLOF        |   2 +-
>>>>>>>>>>  3 files changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> *** Note: this is not for master, this is for pseries
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hello Alexey,
>>>>>>>>>
>>>>>>>>> QEMU fails to boot from disk. See below.
>>>>>>>>
>>>>>>>>
>>>>>>>> It does boot mine (fedora 30, ubuntu 18.04), see below. I believe I
>>>>>>>> could have broken something but I need more detail. Thanks,
>>>>>>>
>>>>>>> fedora31 boots but not ubuntu 19.10. Could it be GRUB version 2.04 ? 
>>>>>>
>>>>>>
>>>>>> No, not that either:
>>>>>
>>>>>
>>>>> but it might be because of power9 - I only tried power8, rsyncing the
>>>>> image to a p9 machine now...
>>>>
>>>> Here is the disk : 
>>>>
>>>> Disk /dev/sda: 50 GiB, 53687091200 bytes, 104857600 sectors
>>>> Disk model: QEMU HARDDISK   
>>>> Units: sectors of 1 * 512 = 512 bytes
>>>> Sector size (logical/physical): 512 bytes / 512 bytes
>>>> I/O size (minimum/optimal): 512 bytes / 512 bytes
>>>> Disklabel type: gpt
>>>> Disk identifier: 27DCE458-231A-4981-9FF1-983F87C2902D
>>>>
>>>> Device         Start       End   Sectors Size Type
>>>> /dev/sda1       2048     16383     14336   7M PowerPC PReP boot
>>>> /dev/sda2      16384 100679679 100663296  48G Linux filesystem
>>>> /dev/sda3  100679680 104857566   4177887   2G Linux swap
>>>>
>>>>
>>>> GPT ? 
>>>
>>> For the failure, I bisected up to :
>>>
>>> f12149908705 ("ext2: Read all 64bit of inode number")
>>
>> Here is a possible fix for it. I did some RPN on my hp28s in the past 
>> but I am not forth fluent.
> 
> 
> you basically zeroed the top bits by shifting them too far right :)
> 
> The proper fix I think is:
> 
> -  32 lshift or
> +  20 lshift or
> 
> I keep forgetting it is all in hex. Can you please give it a try? My
> 128GB disk does not expose this problem somehow. Thanks,

Better try this one please:

https://github.com/aik/SLOF/tree/ext4

What I still do not understand is why GRUB is using ext2 from SLOF, it
should parse ext4 itself :-/


> 
> 
>>
>> "slash not found" is still there though. 


Yeah I see these but they are harmless as far as I can tell.



>>
>> Cheers,
>>
>> C.
>>
>>
>> From 92dc9f6dc7c6434419306d5a382adb42169b712a Mon Sep 17 00:00:00 2001
>> From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
>> Date: Tue, 18 Feb 2020 13:54:54 +0100
>> Subject: [PATCH] ext2: Fix 64bit inode number
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=UTF-8
>> Content-Transfer-Encoding: 8bit
>>
>> Fixes: f12149908705 ("ext2: Read all 64bit of inode number")
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  slof/fs/packages/ext2-files.fs | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/slof/fs/packages/ext2-files.fs b/slof/fs/packages/ext2-files.fs
>> index b6a7880bd88e..f1d9fdfd67e2 100644
>> --- a/slof/fs/packages/ext2-files.fs
>> +++ b/slof/fs/packages/ext2-files.fs
>> @@ -152,7 +152,7 @@ CONSTANT /ext4-ee
>>    dup
>>    8 + l@-le               \ reads bg_inode_table_lo
>>    swap 28 + l@-le         \ reads bg_inode_table_hi
>> -  32 lshift or
>> +  32 rshift or
>>    block-size @ *          \ # in group, inode table
>>    swap inode-size @ * + xlsplit seek drop  inode @ inode-size @ read drop
>>  ;
>>
> 

-- 
Alexey

