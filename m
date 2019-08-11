Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C233C32751
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 02:27:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B8F520880
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 02:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8F520880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwdZr-0002sG-BI
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 22:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58996)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <piaojun@huawei.com>) id 1hwdZT-0002Sb-Ji
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 22:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <piaojun@huawei.com>) id 1hwdZS-0004aC-Lx
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 22:26:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38866 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <piaojun@huawei.com>) id 1hwdZS-0004Xk-Ap
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 22:26:58 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 7DEB9A0B7621928E98B9;
 Sun, 11 Aug 2019 10:26:48 +0800 (CST)
Received: from [10.45.43.239] (10.45.43.239) by smtp.huawei.com (10.3.19.210)
 with Microsoft SMTP Server id 14.3.439.0;
 Sun, 11 Aug 2019 10:26:45 +0800
To: Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>
References: <20190801165409.20121-1-stefanha@redhat.com>
 <20190807180355.GA22758@stefanha-x1.localdomain>
 <20190807205715.GE18557@redhat.com>
 <20190808090213.GD31476@stefanha-x1.localdomain>
 <20190808095316.GC2852@work-vm>
 <20190809082102.GB25286@stefanha-x1.localdomain>
From: piaojun <piaojun@huawei.com>
Message-ID: <277d9cd6-a8fa-fa1f-9cbc-7a7cd0897c84@huawei.com>
Date: Sun, 11 Aug 2019 10:26:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809082102.GB25286@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.43.239]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.32
Subject: Re: [Qemu-devel] [Virtio-fs] [PATCH 0/4] virtiofsd: multithreading
 preparation part 3
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 Vivek Goyal <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/8/9 16:21, Stefan Hajnoczi wrote:
> On Thu, Aug 08, 2019 at 10:53:16AM +0100, Dr. David Alan Gilbert wrote:
>> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
>>> On Wed, Aug 07, 2019 at 04:57:15PM -0400, Vivek Goyal wrote:
>>> 2. Can MAP/UNMAP be performed directly in QEMU via a separate virtqueue?
>>
>> I think there's two things to solve here that I don't currently know the
>> answer to:
>>   2a) We'd need to get the fd to qemu for the thing to mmap;
>>       we might be able to cache the fd on the qemu side for existing
>>       mappings, so when asking for a new mapping for an existing file then
>>       it would already have the fd.
>>
>>   2b) Running a device with a mix of queues inside QEMU and on
>>       vhost-user; I don't think we have anything with that mix
> 
> vhost-user-net works in the same way.  The ctrl queue is handled by QEMU
> and the rx/tx queues by the vhost device.  This is in fact how vhost was
> initially designed: the vhost device is not a full virtio device, only
> the dataplane.

Agreed.

> 
>>> 3. Can READ/WRITE be performed directly in QEMU via a separate virtqueue
>>>    to eliminate the bad address problem?
>>
>> Are you thinking of doing all read/writes that way, or just the corner
>> cases? It doesn't seem worth it for the corner cases unless you're
>> finding them cropping up in real work loads.
> 
> Send all READ/WRITE requests to QEMU instead of virtiofsd.
> 
> Only handle metadata requests in virtiofsd (OPEN, RELEASE, READDIR,
> MKDIR, etc).
> 

Sorry for not catching your point, and I like the virtiofsd to do
READ/WRITE requests and qemu handle metadata requests, as virtiofsd is
good at processing dataplane things due to thread-pool and CPU
affinity(maybe in the future). As you said, virtiofsd is just acting as
a vhost-user device which should care less about ctrl request.

If our concern is improving mmap/write/read performance, why not adding
a delay worker for unmmap which could decrease the ummap times. Maybe
virtiofsd could still handle both data and meta requests by this way.

Jun

