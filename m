Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEA2C761A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 781B8206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 781B8206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3d2h-0002Ca-NV
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 04:50:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1j3d1H-0000zg-Mz
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:48:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1j3d1G-0003rl-76
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:48:51 -0500
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:60419)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1j3d1G-0003lA-0d
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:48:50 -0500
Received: from player693.ha.ovh.net (unknown [10.110.171.227])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 4917C122126
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 10:48:46 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player693.ha.ovh.net (Postfix) with ESMTPSA id 1EB8CF67740E;
 Mon, 17 Feb 2020 09:48:34 +0000 (UTC)
Subject: Re: [PULL SUBSYSTEM qemu-pseries] pseries: Update SLOF firmware image
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200217021217.95766-1-aik@ozlabs.ru>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8e67117e-e74a-fb5c-226b-78e62ac26291@kaod.org>
Date: Mon, 17 Feb 2020 10:48:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217021217.95766-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7024770997117094720
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrjeeigddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuffhomhgrihhnpehophgvnhhsohhurhgtvgdrohhrghenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileefrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.61.98
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

On 2/17/20 3:12 AM, Alexey Kardashevskiy wrote:
> The following changes since commit 05943fb4ca41f626078014c0327781815c6584c5:
> 
>   ppc: free 'fdt' after reset the machine (2020-02-17 11:27:23 +1100)
> 
> are available in the Git repository at:
> 
>   git@github.com:aik/qemu.git tags/qemu-slof-20200217
> 
> for you to fetch changes up to ea9a03e5aa023c5391bab5259898475d0298aac2:
> 
>   pseries: Update SLOF firmware image (2020-02-17 13:08:59 +1100)
> 
> ----------------------------------------------------------------
> Alexey Kardashevskiy (1):
>       pseries: Update SLOF firmware image
> 
>  pc-bios/README   |   2 +-
>  pc-bios/slof.bin | Bin 931032 -> 968560 bytes
>  roms/SLOF        |   2 +-
>  3 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> *** Note: this is not for master, this is for pseries
> 

Hello Alexey,

QEMU fails to boot from disk. See below.

Thanks,

C.


QEMU Starting
 Build Date = Feb 17 2020 13:06:47
 FW Version = git-42228d763f1fdb7b
 Press "s" to enter Open Firmware.

Populating /vdevice methods
Populating /vdevice/vty@71000000
Populating /vdevice/nvram@71000001
Populating /pci@800000020000000
                     00 0800 (D) : 1af4 1004    virtio [ scsi ]
Populating /pci@800000020000000/scsi@1
       SCSI: Looking for devices
          100000000000000 DISK     : "QEMU     QEMU HARDDISK    2.5+"
                     00 1000 (D) : 1af4 1000    virtio [ net ]
                     00 2000 (D) : 1b36 000d    serial bus [ usb-xhci ]
No NVRAM common partition, re-initializing...
Scanning USB 
  XHCI: Initializing
Using default console: /vdevice/vty@71000000
     
  Welcome to Open Firmware

  Copyright (c) 2004, 2017 IBM Corporation All rights reserved.
  This program and the accompanying materials are made available
  under the terms of the BSD License available at
  http://www.opensource.org/licenses/bsd-license.php


Trying to load:  from: /pci@800000020000000/scsi@1/disk@100000000000000 ...  slash SCSI-DISK: Access beyond end of device ! 

Out of internal memory.
SCSI-DISK: Access beyond end of device ! 
SCSI-DISK: Access beyond end of device ! 
SCSI-DISK: Access beyond end of device ! 
SCSI-DISK: Access beyond end of device ! 
SCSI-DISK: Access beyond end of device ! 

