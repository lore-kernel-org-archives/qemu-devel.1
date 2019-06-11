Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31356C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 13:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0741C20673
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 13:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0741C20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58768 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haggq-0008Gu-8b
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 09:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50177)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1haget-0007Ct-T4
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:17:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hages-0003Ga-E6
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:17:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34432)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hages-0003Cv-5b
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:17:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3D94A59474;
 Tue, 11 Jun 2019 13:17:39 +0000 (UTC)
Received: from [10.72.12.214] (ovpn-12-214.pek2.redhat.com [10.72.12.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B23460DCA;
 Tue, 11 Jun 2019 13:17:34 +0000 (UTC)
To: "Michael S. Tsirkin" <mst@redhat.com>, Like Xu <like.xu@linux.intel.com>
References: <449c062f-373c-b310-ccc6-f14c702c8f19@linux.intel.com>
 <20190610114708-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4c5a0454-865f-102e-94e5-6a38d011f33c@redhat.com>
Date: Tue, 11 Jun 2019 21:17:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610114708-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 11 Jun 2019 13:17:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [QUESTION] How to reduce network latency to
 improve netperf TCP_RR drastically?
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/6/10 =E4=B8=8B=E5=8D=8811:55, Michael S. Tsirkin wrote:
> On Tue, Jun 04, 2019 at 03:10:43PM +0800, Like Xu wrote:
>> Hi Michael=EF=BC=8C
>>
>> At https://www.linux-kvm.org/page/NetworkingTodo, there is an entry fo=
r
>> network latency saying:
>>
>> ---
>> reduce networking latency:
>>   allow handling short packets from softirq or VCPU context
>>   Plan:
>>     We are going through the scheduler 3 times
>>     (could be up to 5 if softirqd is involved)
>>     Consider RX: host irq -> io thread -> VCPU thread ->
>>     guest irq -> guest thread.
>>     This adds a lot of latency.
>>     We can cut it by some 1.5x if we do a bit of work
>>     either in the VCPU or softirq context.
>>   Testing: netperf TCP RR - should be improved drastically
>>            netperf TCP STREAM guest to host - no regression
>>   Contact: MST
>> ---
>>
>> I am trying to make some contributions to improving netperf TCP_RR.
>> Could you please share more ideas or plans or implemental details to m=
ake it
>> happen?
>>
>> Thanks,
>> Like Xu
>
> So some of this did happen. netif_receive_skb is now called
> directly from tun_get_user.
>
> Question is about the rx/tun_put_user path now.
>
> If the vhost thread is idle, there's a single packet
> outstanding then maybe we can forward the packet to userspace
> directly from BH without waking up the thread.
>
> For this to work we need to map some userspace memory into kernel
> ahead of the time. For example, maybe it can happen when
> guest adds RX buffers? Copying Jason who's looking into
> memory mapping matters.


Btw, I wonder maybe it's time to make TODO wiki up to date.

Thanks


