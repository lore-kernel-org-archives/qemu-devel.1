Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D557DC4646C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 20:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63AFD20665
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 20:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AFD20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54638 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfVuV-0005M2-3V
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 16:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38576)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hfVre-0004KY-GF
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 16:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hfVrc-000595-Fs
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 16:46:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46232)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1hfVrG-0004Gd-06; Mon, 24 Jun 2019 16:46:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7C5AC368FF;
 Mon, 24 Jun 2019 20:46:22 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A94F608BA;
 Mon, 24 Jun 2019 20:46:20 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Keith Busch <keith.busch@intel.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20190617081205.GA26990@apples.localdomain>
 <c754211f-b41d-4b69-585b-b287fb776d81@redhat.com>
 <20190624080154.GA4263@apples.localdomain>
 <20190624101828.GC12855@linux.fritz.box>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3571317f-84c2-8649-ba63-0e6508679b05@redhat.com>
Date: Mon, 24 Jun 2019 22:46:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190624101828.GC12855@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 24 Jun 2019 20:46:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [RFC] nvme: how to support multiple
 namespaces
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/24/19 12:18, Kevin Wolf wrote:
> Am 24.06.2019 um 10:01 hat Klaus Birkelund geschrieben:
>> On Thu, Jun 20, 2019 at 05:37:24PM +0200, Laszlo Ersek wrote:
>>> On 06/17/19 10:12, Klaus Birkelund wrote:
>>>> Hi all,
>>>>
>>>> I'm thinking about how to support multiple namespaces in the NVMe
>>>> device. My first idea was to add a "namespaces" property array to the
>>>> device that references blockdevs, but as Laszlo writes below, this might
>>>> not be the best idea. It also makes it troublesome to add per-namespace
>>>> parameters (which is something I will be required to do for other
>>>> reasons). Some of you might remember my first attempt at this that
>>>> included adding a new block driver (derived from raw) that could be
>>>> given certain parameters that would then be stored in the image. But I
>>>> understand that this is a no-go, and I can see why.
>>>>
>>>> I guess the optimal way would be such that the parameters was something
>>>> like:
>>>>
>>>>    -blockdev raw,node-name=blk_ns1,file.driver=file,file.filename=blk_ns1.img
>>>>    -blockdev raw,node-name=blk_ns2,file.driver=file,file.filename=blk_ns2.img
>>>>    -device nvme-ns,drive=blk_ns1,ns-specific-options (nsfeat,mc,dlfeat)...
>>>>    -device nvme-ns,drive=blk_ns2,...
>>>>    -device nvme,...
>>>>
>>>> My question is how to state the parent/child relationship between the
>>>> nvme and nvme-ns devices. I've been looking at how ide and virtio does
>>>> this, and maybe a "bus" is the right way to go?
>>>
>>> I've added Markus to the address list, because of this question. No
>>> other (new) comments from me on the thread starter at this time, just
>>> keeping the full context.
>>>
>>
>> Hi all,
>>
>> I've succesfully implemented this by introducing a new 'nvme-ns' device
>> model. The nvme device creates a bus named from the device id ('id'
>> parameter) and the nvme-ns devices are then registered on this.
>>
>> This results in an nvme device being creates like this (two namespaces
>> example):
>>
>>   -drive file=nvme0n1.img,if=none,id=disk1
>>   -drive file=nvme0n2.img,if=none,id=disk2
>>   -device nvme,serial=deadbeef,id=nvme0
>>   -device nvme-ns,drive=disk1,bus=nvme0,nsid=1
>>   -device nvme-ns,drive=disk2,bus=nvme0,nsid=2
>>
>> How does that look as a way forward?
> 
> This looks very similar to what other devices do (one bus controller
> that has multiple devices on its but), so I like it.

+1

Also, I believe it's more modern nowadays to express the same example
with "blockdev" syntax, rather than "drive". (Not that I could suggest
the exact spelling for that :)) I don't expect the modern syntax to
behave differently, I just guess it's better to stick with the new in
examples / commit messages etc.

> The thing that is special here is that -device nvme is already a block
> device by itself that can take a drive property. So how does this play
> together? Can I choose to either specify a drive directly for the nvme
> device or nvme-ns devices, but when I do both, I will get an error? What
> happens if I don't specify a drive for nvme, but also don't add nvme-ns
> devices?

Great questions!

Thanks!
Laszlo

