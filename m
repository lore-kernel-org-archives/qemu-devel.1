Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD4BC43468
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:40:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBEE92220C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBEE92220C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKMzE-0002aX-2o
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 10:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.reiter@proxmox.com>)
 id 1kKMyF-0001jx-4e
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:39:11 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:11861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.reiter@proxmox.com>)
 id 1kKMyC-0005Ds-Oo
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:39:10 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id BC36E4547F;
 Mon, 21 Sep 2020 16:39:03 +0200 (CEST)
Subject: Re: [SeaBIOS] Regression with latest SeaBIOS booting multi-disk root
 LVs?
To: Paul Menzel <pmenzel@molgen.mpg.de>
References: <247d7ead-e426-abb5-07a1-0bd009253c37@proxmox.com>
 <271e19f4-9dcf-a531-5826-45e6f62805ba@molgen.mpg.de>
From: Stefan Reiter <s.reiter@proxmox.com>
Message-ID: <681ed11e-6659-5aaf-7bf0-d2508acd8a47@proxmox.com>
Date: Mon, 21 Sep 2020 16:38:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <271e19f4-9dcf-a531-5826-45e6f62805ba@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.186.127.180;
 envelope-from=s.reiter@proxmox.com; helo=proxmox-new.maurer-it.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 09:10:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: seabios@seabios.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/09/2020 15:44, Paul Menzel wrote:
> Dear Stefan,
> 
> 
> Am 21.09.20 um 15:10 schrieb Stefan Reiter:
> 
>> since SeaBIOS 1.14.0 (QEMU 5.1) VMs with LVM root disks spanning more 
>> than one PV fail to boot, if only the first is set as bootable. I 
>> believe this is due to the changes in SeaBIOS only initializing drives 
>> marked as 'bootable' by QEMU.
>>
>> One fix is to mark all disks containing root data as bootable, but 
>> existing setups will still break on upgrade (where only the disk 
>> containing the bootloader is marked). This is not ideal.
>>
>> Discovered by a user in our bugtracker:
>> https://bugzilla.proxmox.com/show_bug.cgi?id=3011
>>
>> and verified by installing Ubuntu 20.04 w/ LVM and GRUB on 
>> virtio-scsi, then expanding the LV to a second disk.
>>
>> I found that just reverting SeaBIOS to 1.13.0 makes it work again, 
>> same guest install, even with QEMU 5.1.
>>
>> Is this intended behaviour? A bug in GRUB? Any fix or workaround?
> 
> As SeaBIOS 1.13.0 works and SeaBIOS 1.14.0 does not, please bisect the 
> issue, and tell us the commit introducing the regression.
> 

Bisected for virtio-blk drives:

   2f4d068645 "virtio: Do not init non-bootable devices"

...as expected. Also, untested, but I would strongly assume:

   d6bdb85eb0 "virtio-scsi: skip initializing non-bootable devices"

is the equivalent for virtio-scsi devices, and

   76551856b2 "nvme: skip initializing non-bootable devices"

for NVMe.

> 
> Kind regards,
> 
> Paul
> 


