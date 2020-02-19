Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E75C34022
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 07:18:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6085E208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 07:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6085E208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4JdJ-0008KN-Gw
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 02:18:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1j4Jci-0007lw-7D
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 02:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1j4Jcg-0006LU-FQ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 02:18:20 -0500
Received: from 1.mo177.mail-out.ovh.net ([178.33.107.143]:56769)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1j4Jcg-0006Jz-9T
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 02:18:18 -0500
Received: from player761.ha.ovh.net (unknown [10.108.42.167])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 46CC9122436
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 08:18:16 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player761.ha.ovh.net (Postfix) with ESMTPSA id C7D62F86F632;
 Wed, 19 Feb 2020 07:18:11 +0000 (UTC)
Subject: Re: [PULL SUBSYSTEM qemu-pseries] pseries: Update SLOF firmware image
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
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
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d77a4310-9f0e-0c1e-8408-50e195462fed@kaod.org>
Date: Wed, 19 Feb 2020 08:18:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <67b9d53f-110a-47c7-b6c9-d1cf9ace3e3b@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 16228721259748100928
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrjeelgddutdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeiuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.107.143
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

On 2/19/20 7:44 AM, Alexey Kardashevskiy wrote:
>=20
>=20
> On 19/02/2020 12:20, Alexey Kardashevskiy wrote:
>>
>>
>> On 18/02/2020 23:59, C=C3=A9dric Le Goater wrote:
>>> On 2/18/20 1:48 PM, C=C3=A9dric Le Goater wrote:
>>>> On 2/18/20 10:40 AM, C=C3=A9dric Le Goater wrote:
>>>>> On 2/18/20 10:10 AM, Alexey Kardashevskiy wrote:
>>>>>>
>>>>>>
>>>>>> On 18/02/2020 20:05, Alexey Kardashevskiy wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 18/02/2020 18:12, C=C3=A9dric Le Goater wrote:
>>>>>>>> On 2/18/20 1:30 AM, Alexey Kardashevskiy wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 17/02/2020 20:48, C=C3=A9dric Le Goater wrote:
>>>>>>>>>> On 2/17/20 3:12 AM, Alexey Kardashevskiy wrote:
>>>>>>>>>>> The following changes since commit 05943fb4ca41f626078014c032=
7781815c6584c5:
>>>>>>>>>>>
>>>>>>>>>>>   ppc: free 'fdt' after reset the machine (2020-02-17 11:27:2=
3 +1100)
>>>>>>>>>>>
>>>>>>>>>>> are available in the Git repository at:
>>>>>>>>>>>
>>>>>>>>>>>   git@github.com:aik/qemu.git tags/qemu-slof-20200217
>>>>>>>>>>>
>>>>>>>>>>> for you to fetch changes up to ea9a03e5aa023c5391bab525989847=
5d0298aac2:
>>>>>>>>>>>
>>>>>>>>>>>   pseries: Update SLOF firmware image (2020-02-17 13:08:59 +1=
100)
>>>>>>>>>>>
>>>>>>>>>>> -------------------------------------------------------------=
---
>>>>>>>>>>> Alexey Kardashevskiy (1):
>>>>>>>>>>>       pseries: Update SLOF firmware image
>>>>>>>>>>>
>>>>>>>>>>>  pc-bios/README   |   2 +-
>>>>>>>>>>>  pc-bios/slof.bin | Bin 931032 -> 968560 bytes
>>>>>>>>>>>  roms/SLOF        |   2 +-
>>>>>>>>>>>  3 files changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> *** Note: this is not for master, this is for pseries
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Hello Alexey,
>>>>>>>>>>
>>>>>>>>>> QEMU fails to boot from disk. See below.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> It does boot mine (fedora 30, ubuntu 18.04), see below. I belie=
ve I
>>>>>>>>> could have broken something but I need more detail. Thanks,
>>>>>>>>
>>>>>>>> fedora31 boots but not ubuntu 19.10. Could it be GRUB version 2.=
04 ?=20
>>>>>>>
>>>>>>>
>>>>>>> No, not that either:
>>>>>>
>>>>>>
>>>>>> but it might be because of power9 - I only tried power8, rsyncing =
the
>>>>>> image to a p9 machine now...
>>>>>
>>>>> Here is the disk :=20
>>>>>
>>>>> Disk /dev/sda: 50 GiB, 53687091200 bytes, 104857600 sectors
>>>>> Disk model: QEMU HARDDISK  =20
>>>>> Units: sectors of 1 * 512 =3D 512 bytes
>>>>> Sector size (logical/physical): 512 bytes / 512 bytes
>>>>> I/O size (minimum/optimal): 512 bytes / 512 bytes
>>>>> Disklabel type: gpt
>>>>> Disk identifier: 27DCE458-231A-4981-9FF1-983F87C2902D
>>>>>
>>>>> Device         Start       End   Sectors Size Type
>>>>> /dev/sda1       2048     16383     14336   7M PowerPC PReP boot
>>>>> /dev/sda2      16384 100679679 100663296  48G Linux filesystem
>>>>> /dev/sda3  100679680 104857566   4177887   2G Linux swap
>>>>>
>>>>>
>>>>> GPT ?=20
>>>>
>>>> For the failure, I bisected up to :
>>>>
>>>> f12149908705 ("ext2: Read all 64bit of inode number")
>>>
>>> Here is a possible fix for it. I did some RPN on my hp28s in the past=
=20
>>> but I am not forth fluent.
>>
>>
>> you basically zeroed the top bits by shifting them too far right :)
>>
>> The proper fix I think is:
>>
>> -  32 lshift or
>> +  20 lshift or
>>
>> I keep forgetting it is all in hex. Can you please give it a try? My
>> 128GB disk does not expose this problem somehow. Thanks,
>=20
> Better try this one please:
>=20
> https://github.com/aik/SLOF/tree/ext4
Tested with the same image. Looks good.=20
=20
> What I still do not understand is why GRUB is using ext2 from SLOF, it
> should parse ext4 itself :-/

Here is the fs information.


Filesystem volume name:   <none>
Last mounted on:          /
Filesystem UUID:          8d53f6b4-ffc2-4d8f-bd09-67ac97d7b0c5
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index fil=
etype needs_recovery extent flex_bg sparse_super large_file huge_file uni=
nit_bg dir_nlink extra_isize
Filesystem flags:         unsigned_directory_hash=20
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              3127296
Block count:              12582912
Reserved block count:     552210
Free blocks:              7907437
Free inodes:              2863361
First block:              0
Block size:               4096
Fragment size:            4096
Reserved GDT blocks:      1021
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         8144
Inode blocks per group:   509
Flex block group size:    16
Filesystem created:       Wed Dec 14 15:40:55 2016
Last mount time:          Wed Feb 19 08:06:52 2020
Last write time:          Wed Feb 19 08:06:46 2020
Mount count:              1863
Maximum mount count:      -1
Last checked:             Fri Nov 23 19:09:13 2018
Check interval:           0 (<none>)
Lifetime writes:          883 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:	          256
Required extra isize:     28
Desired extra isize:      28
Journal inode:            8
Default directory hash:   half_md4
Directory Hash Seed:      f7cb5863-4885-47b6-b24b-369df6a3b1a4
Journal backup:           inode blocks
Journal features:         journal_incompat_revoke
Journal size:             128M
Journal length:           32768
Journal sequence:         0x0004beb2

Thanks,

C.

>=20
>>
>>
>>>
>>> "slash not found" is still there though.=20
>=20
>=20
> Yeah I see these but they are harmless as far as I can tell.
>=20
>=20
>=20
>>>
>>> Cheers,
>>>
>>> C.
>>>
>>>
>>> From 92dc9f6dc7c6434419306d5a382adb42169b712a Mon Sep 17 00:00:00 200=
1
>>> From: =3D?UTF-8?q?C=3DC3=3DA9dric=3D20Le=3D20Goater?=3D <clg@kaod.org=
>
>>> Date: Tue, 18 Feb 2020 13:54:54 +0100
>>> Subject: [PATCH] ext2: Fix 64bit inode number
>>> MIME-Version: 1.0
>>> Content-Type: text/plain; charset=3DUTF-8
>>> Content-Transfer-Encoding: 8bit
>>>
>>> Fixes: f12149908705 ("ext2: Read all 64bit of inode number")
>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>> ---
>>>  slof/fs/packages/ext2-files.fs | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/slof/fs/packages/ext2-files.fs b/slof/fs/packages/ext2-f=
iles.fs
>>> index b6a7880bd88e..f1d9fdfd67e2 100644
>>> --- a/slof/fs/packages/ext2-files.fs
>>> +++ b/slof/fs/packages/ext2-files.fs
>>> @@ -152,7 +152,7 @@ CONSTANT /ext4-ee
>>>    dup
>>>    8 + l@-le               \ reads bg_inode_table_lo
>>>    swap 28 + l@-le         \ reads bg_inode_table_hi
>>> -  32 lshift or
>>> +  32 rshift or
>>>    block-size @ *          \ # in group, inode table
>>>    swap inode-size @ * + xlsplit seek drop  inode @ inode-size @ read=
 drop
>>>  ;
>>>
>>
>=20


