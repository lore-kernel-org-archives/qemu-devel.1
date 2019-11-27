Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A47C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 17:21:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE12206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 17:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE12206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia0zu-0004DR-SK
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 12:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.kiszka@siemens.com>) id 1ia0ym-0003SZ-2A
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:19:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@siemens.com>) id 1ia0yj-0007pB-Hz
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:19:51 -0500
Received: from gecko.sbs.de ([194.138.37.40]:48773)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
 id 1ia0yg-0007l4-NT
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:19:47 -0500
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
 by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id xARHJajl008247
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Nov 2019 18:19:37 +0100
Received: from [139.25.68.37] ([139.25.68.37])
 by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id xARHJa7L001485;
 Wed, 27 Nov 2019 18:19:36 +0100
Subject: Re: [RFC][PATCH 0/3] IVSHMEM version 2 device for QEMU
To: Liang Yan <LYan@suse.com>, qemu-devel <qemu-devel@nongnu.org>
References: <cover.1573477032.git.jan.kiszka@siemens.com>
 <efd5fa87-90de-fccc-97a5-a4fc71a050c8@suse.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fb213f9e-8bd8-6c33-7a6e-47dda982903d@siemens.com>
Date: Wed, 27 Nov 2019 18:19:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <efd5fa87-90de-fccc-97a5-a4fc71a050c8@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 194.138.37.40
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
Cc: Jailhouse <jailhouse-dev@googlegroups.com>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hannes Reinecke <hare@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Liang,

On 27.11.19 16:28, Liang Yan wrote:
> 
> 
> On 11/11/19 7:57 AM, Jan Kiszka wrote:
>> To get the ball rolling after my presentation of the topic at KVM Forum
>> [1] and many fruitful discussions around it, this is a first concrete
>> code series. As discussed, I'm starting with the IVSHMEM implementation
>> of a QEMU device and server. It's RFC because, besides specification and
>> implementation details, there will still be some decisions needed about
>> how to integrate the new version best into the existing code bases.
>>
>> If you want to play with this, the basic setup of the shared memory
>> device is described in patch 1 and 3. UIO driver and also the
>> virtio-ivshmem prototype can be found at
>>
>>      http://git.kiszka.org/?p=linux.git;a=shortlog;h=refs/heads/queues/ivshmem2
>>
>> Accessing the device via UIO is trivial enough. If you want to use it
>> for virtio, this is additionally to the description in patch 3 needed on
>> the virtio console backend side:
>>
>>      modprobe uio_ivshmem
>>      echo "1af4 1110 1af4 1100 ffc003 ffffff" > /sys/bus/pci/drivers/uio_ivshmem/new_id
>>      linux/tools/virtio/virtio-ivshmem-console /dev/uio0
>>
>> And for virtio block:
>>
>>      echo "1af4 1110 1af4 1100 ffc002 ffffff" > /sys/bus/pci/drivers/uio_ivshmem/new_id
>>      linux/tools/virtio/virtio-ivshmem-console /dev/uio0 /path/to/disk.img
>>
>> After that, you can start the QEMU frontend instance with the
>> virtio-ivshmem driver installed which can use the new /dev/hvc* or
>> /dev/vda* as usual.
>>
>> Any feedback welcome!
> 
> Hi, Jan,
> 
> I have been playing your code for last few weeks, mostly study and test,
> of course. Really nice work. I have a few questions here:
> 
> First, qemu part looks good, I tried test between couple VMs, and device
> could pop up correctly for all of them, but I had some problems when
> trying load driver. For example, if set up two VMs, vm1 and vm2, start
> ivshmem server as you suggested. vm1 could load uio_ivshmem and
> virtio_ivshmem correctly, vm2 could load uio_ivshmem but could not show
> up "/dev/uio0", virtio_ivshmem could not be loaded at all, these still
> exist even I switch the load sequence of vm1 and vm2, and sometimes
> reset "virtio_ivshmem" could crash both vm1 and vm2. Not quite sure this
> is bug or "Ivshmem Mode" issue, but I went through ivshmem-server code,
> did not related information.

If we are only talking about one ivshmem link and vm1 is the master, 
there is not role for virtio_ivshmem on it as backend. That is purely a 
frontend driver. Vice versa for vm2: If you want to use its ivshmem 
instance as virtio frontend, uio_ivshmem plays no role.

The "crash" is would be interesting to understand: Do you see kernel 
panics of the guests? Or are they stuck? Or are the QEMU instances 
stuck? Do you know that you can debug the guest kernels via gdb (and 
gdb-scripts of the kernel)?

> 
> I started some code work recently, such as fix code style issues and
> some work based on above testing, however I know you are also working on
> RFC V2, beside the protocol between server-client and client-client is
> not finalized yet either, things may change, so much appreciate if you
> could squeeze me into your develop schedule and share with me some
> plans, :-)  Maybe I could send some pull request in your github repo?

I'm currently working on a refresh of the Jailhouse queue and the kernel 
patches to incorporate just two smaller changes:

  - use Siemens device ID
  - drop "features" register from ivshmem device

I have not yet touched the QEMU code for that so far, thus no conflict 
yet. I would wait for your patches then.

If it helps us to work on this together, I can push things to github as 
well. Will drop you a note when done. We should just present the outcome 
frequently as new series to the list.

> 
> I personally like this project a lot, there would be a lot of potential
> and user case for it, especially some devices like
> ivshmem-net/ivshmem-block. Anyway, thanks for adding me to the list, and
> looking forward to your reply.

Thanks for the positive feedback. I'm looking forward to work on this 
together!

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

