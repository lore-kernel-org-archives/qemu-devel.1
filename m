Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26532C34033
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 07:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F36C8207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 07:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36C8207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3x48-0007rO-2m
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 02:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1j3x3V-0007Bf-Ib
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 02:12:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1j3x3U-0003QN-3N
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 02:12:29 -0500
Received: from 11.mo4.mail-out.ovh.net ([46.105.34.195]:44390)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1j3x3T-0003NL-U8
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 02:12:28 -0500
Received: from player797.ha.ovh.net (unknown [10.110.208.144])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id E11942235F8
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 08:12:25 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player797.ha.ovh.net (Postfix) with ESMTPSA id 96428B6F10FE;
 Tue, 18 Feb 2020 07:12:21 +0000 (UTC)
Subject: Re: [PULL SUBSYSTEM qemu-pseries] pseries: Update SLOF firmware image
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200217021217.95766-1-aik@ozlabs.ru>
 <8e67117e-e74a-fb5c-226b-78e62ac26291@kaod.org>
 <44499677-3099-56c6-7249-afa8eccc7668@ozlabs.ru>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bdfb7d07-c5fd-c21e-f812-4a0a747b02c3@kaod.org>
Date: Tue, 18 Feb 2020 08:12:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <44499677-3099-56c6-7249-afa8eccc7668@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 10257229628829109056
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrjeejgddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucffohhmrghinhepohhpvghnshhouhhrtggvrdhorhhgnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeljedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.34.195
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

On 2/18/20 1:30 AM, Alexey Kardashevskiy wrote:
>=20
>=20
> On 17/02/2020 20:48, C=C3=A9dric Le Goater wrote:
>> On 2/17/20 3:12 AM, Alexey Kardashevskiy wrote:
>>> The following changes since commit 05943fb4ca41f626078014c0327781815c=
6584c5:
>>>
>>>   ppc: free 'fdt' after reset the machine (2020-02-17 11:27:23 +1100)
>>>
>>> are available in the Git repository at:
>>>
>>>   git@github.com:aik/qemu.git tags/qemu-slof-20200217
>>>
>>> for you to fetch changes up to ea9a03e5aa023c5391bab5259898475d0298aa=
c2:
>>>
>>>   pseries: Update SLOF firmware image (2020-02-17 13:08:59 +1100)
>>>
>>> ----------------------------------------------------------------
>>> Alexey Kardashevskiy (1):
>>>       pseries: Update SLOF firmware image
>>>
>>>  pc-bios/README   |   2 +-
>>>  pc-bios/slof.bin | Bin 931032 -> 968560 bytes
>>>  roms/SLOF        |   2 +-
>>>  3 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>>
>>> *** Note: this is not for master, this is for pseries
>>>
>>
>> Hello Alexey,
>>
>> QEMU fails to boot from disk. See below.
>=20
>=20
> It does boot mine (fedora 30, ubuntu 18.04), see below. I believe I
> could have broken something but I need more detail. Thanks,

fedora31 boots but not ubuntu 19.10. Could it be GRUB version 2.04 ?=20

C.


>=20
>=20
>=20
>=20
> SLOF ******************************************************************=
****
> QEMU Starting
>  Build Date =3D Feb 17 2020 13:06:47
>  FW Version =3D git-42228d763f1fdb7b
>  Press "s" to enter Open Firmware.
>=20
> Populating /vdevice methods
> Populating /vdevice/nvram@71000000
> Populating /vdevice/vty@71000110
> Populating /pci@800000020000000
>                      00 0000 (D) : 1af4 1000    virtio [ net ]
>                      00 0800 (D) : 1af4 1004    virtio [ scsi ]
> Populating /pci@800000020000000/scsi@1
>        SCSI: Looking for devices
>           100000000000000 DISK     : "QEMU     QEMU HARDDISK    2.5+"
> No NVRAM common partition, re-initializing...
> Scanning USB
> Using default console: /vdevice/vty@71000110
>=20
>   Welcome to Open Firmware
>=20
>   Copyright (c) 2004, 2017 IBM Corporation All rights reserved.
>   This program and the accompanying materials are made available
>   under the terms of the BSD License available at
>   http://www.opensource.org/licenses/bsd-license.php
>=20
>=20
> Trying to load:  from: /pci@800000020000000/scsi@1/disk@100000000000000
> ...   Successfully loaded
>=20
>=20
>=20
>=20
>=20
>=20
>       Fedora (5.5.0-rc5-le-guest_v5.5-rc5_a+fstn1) 30 (Thirty)
>=20
>       Fedora (5.0.9-301.fc30.ppc64le) 30 (Thirty)
>=20
>       Fedora (0-rescue-8f8bbec520a44fd09da6af8e0d2c6571) 30 (Thirty)
>=20
>=20
>=20
>=20
>>
>> Thanks,
>>
>> C.
>>
>>
>> QEMU Starting
>>  Build Date =3D Feb 17 2020 13:06:47
>>  FW Version =3D git-42228d763f1fdb7b
>>  Press "s" to enter Open Firmware.
>>
>> Populating /vdevice methods
>> Populating /vdevice/vty@71000000
>> Populating /vdevice/nvram@71000001
>> Populating /pci@800000020000000
>>                      00 0800 (D) : 1af4 1004    virtio [ scsi ]
>> Populating /pci@800000020000000/scsi@1
>>        SCSI: Looking for devices
>>           100000000000000 DISK     : "QEMU     QEMU HARDDISK    2.5+"
>>                      00 1000 (D) : 1af4 1000    virtio [ net ]
>>                      00 2000 (D) : 1b36 000d    serial bus [ usb-xhci =
]
>> No NVRAM common partition, re-initializing...
>> Scanning USB=20
>>   XHCI: Initializing
>> Using default console: /vdevice/vty@71000000
>>     =20
>>   Welcome to Open Firmware
>>
>>   Copyright (c) 2004, 2017 IBM Corporation All rights reserved.
>>   This program and the accompanying materials are made available
>>   under the terms of the BSD License available at
>>   http://www.opensource.org/licenses/bsd-license.php
>>
>>
>> Trying to load:  from: /pci@800000020000000/scsi@1/disk@10000000000000=
0 ...  slash SCSI-DISK: Access beyond end of device !=20
>>
>> Out of internal memory.
>> SCSI-DISK: Access beyond end of device !=20
>> SCSI-DISK: Access beyond end of device !=20
>> SCSI-DISK: Access beyond end of device !=20
>> SCSI-DISK: Access beyond end of device !=20
>> SCSI-DISK: Access beyond end of device !=20
>>
>=20


