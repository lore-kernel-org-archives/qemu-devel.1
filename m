Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3E5C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:49:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E41F72064C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41F72064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is4an-0007Yq-02
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 07:49:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pl@kamp.de>) id 1is4Yo-0005eQ-Vt
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:47:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pl@kamp.de>) id 1is4Yn-0004TO-Ee
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:47:42 -0500
Received: from kerio.kamp.de ([195.62.97.192]:46791)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pl@kamp.de>) id 1is4Yn-0004QT-74
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:47:41 -0500
X-Footer: a2FtcC5kZQ==
Received: from [172.21.12.60] ([172.21.12.60]) (authenticated user pl@kamp.de)
 by kerio.kamp.de with ESMTPSA
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
 Thu, 16 Jan 2020 13:47:30 +0100
Subject: Re: qemu-4.0.1: vhost_region_add_section:Section rounded to 0 prior
 to previous a0000
From: Peter Lieven <pl@kamp.de>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <985fea06-ede6-dcb7-8829-a48a9416bc09@kamp.de>
 <20200108150458.GC3184@work-vm>
 <ca222a5f-1ec6-477c-ed83-6ef52ea9e97f@kamp.de>
 <20200109184440.GR6795@work-vm>
 <b89e8ba2-49e9-8c0d-1129-116afa76366a@kamp.de>
Message-ID: <cd316fb8-b56b-2913-8b57-f085ca4426d7@kamp.de>
Date: Thu, 16 Jan 2020 13:47:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b89e8ba2-49e9-8c0d-1129-116afa76366a@kamp.de>
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

Am 13.01.20 um 17:25 schrieb Peter Lieven:
> Am 09.01.20 um 19:44 schrieb Dr. David Alan Gilbert:
>> * Peter Lieven (pl@kamp.de) wrote:
>>> Am 08.01.20 um 16:04 schrieb Dr. David Alan Gilbert:
>>>> * Peter Lieven (pl@kamp.de) wrote:
>>>>> Hi,
>>>>>
>>>>>
>>>>> I have a Qemu 4.0.1 machine with vhost-net network adapter, thats polluting the log with the above message.
>>>>>
>>>>> Is this something known? Googling revealed the following patch in Nemu (with seems to be a Qemu fork from Intel):
>>>>>
>>>>> https://github.com/intel/nemu/commit/03940ded7f5370ce7492c619dccced114ef7f56e
>>>>>
>>>>>
>>>>> The network stopped functioning. After a live-migration the vServer is reachable again.
>>>>>
>>>>>
>>>>> Any ideas?
>>>> What guest are you running and what does your qemu commandline look
>>>> like?
>>>
>>> Its running debian9. We have hundreds of other VMs with identical setup. Do not know why this one makes trouble.
>> Could you extract an 'info mtree' from it - particularly the
>> 'address-space: memory' near the top.
>
>
> Here we go:
>
>
> address-space: memory
>   0000000000000000-ffffffffffffffff (prio 0, i/o): system
>     0000000000000000-000000003fffffff (prio 0, i/o): alias ram-below-4g @pc.ram 0000000000000000-000000003fffffff
>     0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>       00000000000a0000-00000000000affff (prio 2, i/o): alias vga.chain4 @vga.vram 0000000000000000-000000000000ffff
>       00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem


What seems special is that the RAM area is prio2. Any idea if this makes trouble?


Peter


