Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F7EC33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F77214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F77214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir2Xt-00052N-RE
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 11:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pl@kamp.de>) id 1ir2X2-0004Aj-7D
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:25:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pl@kamp.de>) id 1ir2Wz-0000za-RA
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:25:35 -0500
Received: from kerio.kamp.de ([195.62.97.192]:36889)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pl@kamp.de>) id 1ir2Wy-0000lR-0Y
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:25:33 -0500
X-Footer: a2FtcC5kZQ==
Received: from [172.21.12.60] ([172.21.12.60]) (authenticated user pl@kamp.de)
 by kerio.kamp.de with ESMTPSA
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
 Mon, 13 Jan 2020 17:25:17 +0100
Subject: Re: qemu-4.0.1: vhost_region_add_section:Section rounded to 0 prior
 to previous a0000
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <985fea06-ede6-dcb7-8829-a48a9416bc09@kamp.de>
 <20200108150458.GC3184@work-vm>
 <ca222a5f-1ec6-477c-ed83-6ef52ea9e97f@kamp.de>
 <20200109184440.GR6795@work-vm>
From: Peter Lieven <pl@kamp.de>
Message-ID: <b89e8ba2-49e9-8c0d-1129-116afa76366a@kamp.de>
Date: Mon, 13 Jan 2020 17:25:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109184440.GR6795@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 195.62.97.192
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 09.01.20 um 19:44 schrieb Dr. David Alan Gilbert:
> * Peter Lieven (pl@kamp.de) wrote:
>> Am 08.01.20 um 16:04 schrieb Dr. David Alan Gilbert:
>>> * Peter Lieven (pl@kamp.de) wrote:
>>>> Hi,
>>>>
>>>>
>>>> I have a Qemu 4.0.1 machine with vhost-net network adapter, thats polluting the log with the above message.
>>>>
>>>> Is this something known? Googling revealed the following patch in Nemu (with seems to be a Qemu fork from Intel):
>>>>
>>>> https://github.com/intel/nemu/commit/03940ded7f5370ce7492c619dccced114ef7f56e
>>>>
>>>>
>>>> The network stopped functioning. After a live-migration the vServer is reachable again.
>>>>
>>>>
>>>> Any ideas?
>>> What guest are you running and what does your qemu commandline look
>>> like?
>>
>> Its running debian9. We have hundreds of other VMs with identical setup. Do not know why this one makes trouble.
> Could you extract an 'info mtree' from it - particularly the
> 'address-space: memory' near the top.


Here we go:


address-space: memory
   0000000000000000-ffffffffffffffff (prio 0, i/o): system
     0000000000000000-000000003fffffff (prio 0, i/o): alias ram-below-4g @pc.ram 0000000000000000-000000003fffffff
     0000000000000000-ffffffffffffffff (prio -1, i/o): pci
       00000000000a0000-00000000000affff (prio 2, i/o): alias vga.chain4 @vga.vram 0000000000000000-000000000000ffff
       00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
       00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
       00000000000e0000-00000000000fffff (prio 1, i/o): alias isa-bios @pc.bios 0000000000020000-000000000003ffff
       00000000fd000000-00000000fdffffff (prio 1, ram): vga.vram
       00000000fe000000-00000000fe00ffff (prio 1, ram): vmsvga.fifo
       00000000fe010000-00000000fe013fff (prio 1, i/o): virtio-pci
         00000000fe010000-00000000fe010fff (prio 0, i/o): virtio-pci-common
         00000000fe011000-00000000fe011fff (prio 0, i/o): virtio-pci-isr
         00000000fe012000-00000000fe012fff (prio 0, i/o): virtio-pci-device
         00000000fe013000-00000000fe013fff (prio 0, i/o): virtio-pci-notify
       00000000fe014000-00000000fe017fff (prio 1, i/o): virtio-pci
         00000000fe014000-00000000fe014fff (prio 0, i/o): virtio-pci-common
         00000000fe015000-00000000fe015fff (prio 0, i/o): virtio-pci-isr
         00000000fe016000-00000000fe016fff (prio 0, i/o): virtio-pci-device
         00000000fe017000-00000000fe017fff (prio 0, i/o): virtio-pci-notify
       00000000fe018000-00000000fe01bfff (prio 1, i/o): virtio-pci
         00000000fe018000-00000000fe018fff (prio 0, i/o): virtio-pci-common
         00000000fe019000-00000000fe019fff (prio 0, i/o): virtio-pci-isr
         00000000fe01a000-00000000fe01afff (prio 0, i/o): virtio-pci-device
         00000000fe01b000-00000000fe01bfff (prio 0, i/o): virtio-pci-notify
       00000000fe01c000-00000000fe01ffff (prio 1, i/o): virtio-pci
         00000000fe01c000-00000000fe01cfff (prio 0, i/o): virtio-pci-common
         00000000fe01d000-00000000fe01dfff (prio 0, i/o): virtio-pci-isr
         00000000fe01e000-00000000fe01efff (prio 0, i/o): virtio-pci-device
         00000000fe01f000-00000000fe01ffff (prio 0, i/o): virtio-pci-notify
       00000000febd0000-00000000febd0fff (prio 1, i/o): virtio-net-pci-msix
         00000000febd0000-00000000febd002f (prio 0, i/o): msix-table
         00000000febd0800-00000000febd0807 (prio 0, i/o): msix-pba
       00000000febd1000-00000000febd1fff (prio 1, i/o): virtio-scsi-pci-msix


Peter





