Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9425C5ACC4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 01:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 945B421D56
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 01:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="rFhPaQLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945B421D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4b0A-0000xg-Oc
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 20:51:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1j4az0-0000Mj-Ph
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 20:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1j4ayy-000334-FH
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 20:50:30 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:36454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1j4ayy-00031A-0n
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 20:50:28 -0500
Received: by mail-pl1-x633.google.com with SMTP id a6so895023plm.3
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 17:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZSQuAJ3n2VfXKVmLthiXQ/IFlOhraljm+fqzMDveLSs=;
 b=rFhPaQLmyHb5se1tv6MhsPP6w4zMnQ3pTPPaFMJg5Aevjuv5NlcgSc8K9etUa7mbxn
 1FnXos8PXBgQ8di/4bsDYDyDPJPLejyvxPJ6/5s7d80nChV+UelRGQ01iuY6CQANU62V
 cyiuwDU3suAoOrvpOM4yRZ9kDU5riZ8LiqXxP5fMMZhTJ34opFRTUH1r6huUkC28xs2e
 iHEI9XbEToR7QFiUfw7z+BqZEhgVExzQp3k9t1fxcKbYUzKzTyiCT8nvAuwbg4pEPWzq
 18MqpHr3in2Ti05nLexkUmQrXD7YEC4t4U+fjaB0zk6HMx60j2ArO+n7Z+LAGB5kWNhy
 yJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ZSQuAJ3n2VfXKVmLthiXQ/IFlOhraljm+fqzMDveLSs=;
 b=SPh7LolRee9QvJKVV8ygKTV8bmpMXzCRkuPbdvfr3TQyVsEyW9RTt/QLB/XGgYIkJV
 px9IdWWIlqQqNnuAN+IAvsFkQKNPB3EJu0BTnd33QGxsUN4Pf/ntnHo7dxx3RJl0XCt+
 PtZ6XWHoATeD66RGD3ImRr0oH0wwcDJPFYoMmFEP9Lpd+o6E2aFM+qMjvOqPeG23pXRT
 4sJ22Xa92C1r6A4XR5I6rX58tSazGHo5hQ937iWaAxW8a0Zj1iZzYmT8S0jnpL9XjoJt
 my8BMASt8TZbY+BAuYksBeVji1JCaK1qY9/n2tohgDb4YPd8Yfe7NSwxcGckaRtk/go9
 +HTA==
X-Gm-Message-State: APjAAAVVAdqJeFQFG6mbD3SrtHoMN3v/tgUTpImgFYXofDX2K96dgtqF
 auOCiHUz7Vc+gjbVXbyV5n2Ysnk7hOA=
X-Google-Smtp-Source: APXvYqyZLn9k1XZxvUGsH2hyw0pOAJIIVCHwpNO0p+YxJ4JMjP85a7iWU+oPG0zuDmLnlQRaSokSow==
X-Received: by 2002:a17:902:8b81:: with SMTP id
 ay1mr26584112plb.275.1582163425541; 
 Wed, 19 Feb 2020 17:50:25 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id d24sm898388pfq.75.2020.02.19.17.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2020 17:50:24 -0800 (PST)
Subject: Re: [PULL SUBSYSTEM qemu-pseries] pseries: Update SLOF firmware image
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
 <67b9d53f-110a-47c7-b6c9-d1cf9ace3e3b@ozlabs.ru>
 <d77a4310-9f0e-0c1e-8408-50e195462fed@kaod.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <c6d5bc21-9234-646f-18e3-d445486a4098@ozlabs.ru>
Date: Thu, 20 Feb 2020 12:50:20 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <d77a4310-9f0e-0c1e-8408-50e195462fed@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::633
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



On 19/02/2020 18:18, Cédric Le Goater wrote:
> On 2/19/20 7:44 AM, Alexey Kardashevskiy wrote:
>>
>>
>> On 19/02/2020 12:20, Alexey Kardashevskiy wrote:
>>>
>>>
>>> On 18/02/2020 23:59, Cédric Le Goater wrote:
>>>> On 2/18/20 1:48 PM, Cédric Le Goater wrote:
>>>>> On 2/18/20 10:40 AM, Cédric Le Goater wrote:
>>>>>> On 2/18/20 10:10 AM, Alexey Kardashevskiy wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 18/02/2020 20:05, Alexey Kardashevskiy wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 18/02/2020 18:12, Cédric Le Goater wrote:
>>>>>>>>> On 2/18/20 1:30 AM, Alexey Kardashevskiy wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 17/02/2020 20:48, Cédric Le Goater wrote:
>>>>>>>>>>> On 2/17/20 3:12 AM, Alexey Kardashevskiy wrote:
>>>>>>>>>>>> The following changes since commit 05943fb4ca41f626078014c0327781815c6584c5:
>>>>>>>>>>>>
>>>>>>>>>>>>   ppc: free 'fdt' after reset the machine (2020-02-17 11:27:23 +1100)
>>>>>>>>>>>>
>>>>>>>>>>>> are available in the Git repository at:
>>>>>>>>>>>>
>>>>>>>>>>>>   git@github.com:aik/qemu.git tags/qemu-slof-20200217
>>>>>>>>>>>>
>>>>>>>>>>>> for you to fetch changes up to ea9a03e5aa023c5391bab5259898475d0298aac2:
>>>>>>>>>>>>
>>>>>>>>>>>>   pseries: Update SLOF firmware image (2020-02-17 13:08:59 +1100)
>>>>>>>>>>>>
>>>>>>>>>>>> ----------------------------------------------------------------
>>>>>>>>>>>> Alexey Kardashevskiy (1):
>>>>>>>>>>>>       pseries: Update SLOF firmware image
>>>>>>>>>>>>
>>>>>>>>>>>>  pc-bios/README   |   2 +-
>>>>>>>>>>>>  pc-bios/slof.bin | Bin 931032 -> 968560 bytes
>>>>>>>>>>>>  roms/SLOF        |   2 +-
>>>>>>>>>>>>  3 files changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> *** Note: this is not for master, this is for pseries
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Hello Alexey,
>>>>>>>>>>>
>>>>>>>>>>> QEMU fails to boot from disk. See below.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> It does boot mine (fedora 30, ubuntu 18.04), see below. I believe I
>>>>>>>>>> could have broken something but I need more detail. Thanks,
>>>>>>>>>
>>>>>>>>> fedora31 boots but not ubuntu 19.10. Could it be GRUB version 2.04 ? 
>>>>>>>>
>>>>>>>>
>>>>>>>> No, not that either:
>>>>>>>
>>>>>>>
>>>>>>> but it might be because of power9 - I only tried power8, rsyncing the
>>>>>>> image to a p9 machine now...
>>>>>>
>>>>>> Here is the disk : 
>>>>>>
>>>>>> Disk /dev/sda: 50 GiB, 53687091200 bytes, 104857600 sectors
>>>>>> Disk model: QEMU HARDDISK   
>>>>>> Units: sectors of 1 * 512 = 512 bytes
>>>>>> Sector size (logical/physical): 512 bytes / 512 bytes
>>>>>> I/O size (minimum/optimal): 512 bytes / 512 bytes
>>>>>> Disklabel type: gpt
>>>>>> Disk identifier: 27DCE458-231A-4981-9FF1-983F87C2902D
>>>>>>
>>>>>> Device         Start       End   Sectors Size Type
>>>>>> /dev/sda1       2048     16383     14336   7M PowerPC PReP boot
>>>>>> /dev/sda2      16384 100679679 100663296  48G Linux filesystem
>>>>>> /dev/sda3  100679680 104857566   4177887   2G Linux swap
>>>>>>
>>>>>>
>>>>>> GPT ? 
>>>>>
>>>>> For the failure, I bisected up to :
>>>>>
>>>>> f12149908705 ("ext2: Read all 64bit of inode number")
>>>>
>>>> Here is a possible fix for it. I did some RPN on my hp28s in the past 
>>>> but I am not forth fluent.
>>>
>>>
>>> you basically zeroed the top bits by shifting them too far right :)
>>>
>>> The proper fix I think is:
>>>
>>> -  32 lshift or
>>> +  20 lshift or
>>>
>>> I keep forgetting it is all in hex. Can you please give it a try? My
>>> 128GB disk does not expose this problem somehow. Thanks,
>>
>> Better try this one please:
>>
>> https://github.com/aik/SLOF/tree/ext4
> Tested with the same image. Looks good. 


Thanks for testing. But it is still bizarre behaviour, why do we end up
there anyway...


>> What I still do not understand is why GRUB is using ext2 from SLOF, it
>> should parse ext4 itself :-/
> 
> Here is the fs information.
> 
> 
> Filesystem volume name:   <none>
> Last mounted on:          /
> Filesystem UUID:          8d53f6b4-ffc2-4d8f-bd09-67ac97d7b0c5
> Filesystem magic number:  0xEF53
> Filesystem revision #:    1 (dynamic)
> Filesystem features:      has_journal ext_attr resize_inode dir_index filetype needs_recovery extent flex_bg sparse_super large_file huge_file uninit_bg dir_nlink extra_isize


huh, this one does not have 64bit like mine, I blindly assumed that by
2020 everything would be using that. Well that explains the bug. And
yours also has uninit_bg (the whole idea of this flag is not obvious but
ok).


> Filesystem flags:         unsigned_directory_hash 
> Default mount options:    user_xattr acl
> Filesystem state:         clean
> Errors behavior:          Continue
> Filesystem OS type:       Linux
> Inode count:              3127296
> Block count:              12582912
> Reserved block count:     552210
> Free blocks:              7907437
> Free inodes:              2863361
> First block:              0
> Block size:               4096
> Fragment size:            4096


Mine here has:
Group descriptor size:    64

so there is no "hi" part and this is what my fix now handles (0x32 vs.
0x20 was not the problem actually).

Did you do this on purpose or the installer did it? :)

Anyway, I'd like to get this particular disk image to understand why on
earth it is using the ext2 package from SLOF. Thanks,


> Reserved GDT blocks:      1021
> Blocks per group:         32768
> Fragments per group:      32768
> Inodes per group:         8144
> Inode blocks per group:   509
> Flex block group size:    16
> Filesystem created:       Wed Dec 14 15:40:55 2016
> Last mount time:          Wed Feb 19 08:06:52 2020
> Last write time:          Wed Feb 19 08:06:46 2020
> Mount count:              1863
> Maximum mount count:      -1
> Last checked:             Fri Nov 23 19:09:13 2018
> Check interval:           0 (<none>)
> Lifetime writes:          883 GB
> Reserved blocks uid:      0 (user root)
> Reserved blocks gid:      0 (group root)
> First inode:              11
> Inode size:	          256
> Required extra isize:     28
> Desired extra isize:      28
> Journal inode:            8
> Default directory hash:   half_md4
> Directory Hash Seed:      f7cb5863-4885-47b6-b24b-369df6a3b1a4
> Journal backup:           inode blocks
> Journal features:         journal_incompat_revoke
> Journal size:             128M
> Journal length:           32768
> Journal sequence:         0x0004beb2
> 
> Thanks,
> 
> C.
> 
>>
>>>
>>>
>>>>
>>>> "slash not found" is still there though. 
>>
>>
>> Yeah I see these but they are harmless as far as I can tell.
>>
>>
>>
>>>>
>>>> Cheers,
>>>>
>>>> C.
>>>>
>>>>
>>>> From 92dc9f6dc7c6434419306d5a382adb42169b712a Mon Sep 17 00:00:00 2001
>>>> From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
>>>> Date: Tue, 18 Feb 2020 13:54:54 +0100
>>>> Subject: [PATCH] ext2: Fix 64bit inode number
>>>> MIME-Version: 1.0
>>>> Content-Type: text/plain; charset=UTF-8
>>>> Content-Transfer-Encoding: 8bit
>>>>
>>>> Fixes: f12149908705 ("ext2: Read all 64bit of inode number")
>>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>>> ---
>>>>  slof/fs/packages/ext2-files.fs | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/slof/fs/packages/ext2-files.fs b/slof/fs/packages/ext2-files.fs
>>>> index b6a7880bd88e..f1d9fdfd67e2 100644
>>>> --- a/slof/fs/packages/ext2-files.fs
>>>> +++ b/slof/fs/packages/ext2-files.fs
>>>> @@ -152,7 +152,7 @@ CONSTANT /ext4-ee
>>>>    dup
>>>>    8 + l@-le               \ reads bg_inode_table_lo
>>>>    swap 28 + l@-le         \ reads bg_inode_table_hi
>>>> -  32 lshift or
>>>> +  32 rshift or
>>>>    block-size @ *          \ # in group, inode table
>>>>    swap inode-size @ * + xlsplit seek drop  inode @ inode-size @ read drop
>>>>  ;
>>>>
>>>
>>
> 

-- 
Alexey

