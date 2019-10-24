Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB5FCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6437B2084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6437B2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdmf-0004xf-12
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yezhenyu2@huawei.com>) id 1iNdZ8-0001vG-1y
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yezhenyu2@huawei.com>) id 1iNdZ6-0002PP-VT
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:54:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43624 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yezhenyu2@huawei.com>)
 id 1iNdZ6-0002Kf-K7
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:54:12 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 9DB1CC57CC76BCC56728;
 Thu, 24 Oct 2019 21:54:04 +0800 (CST)
Received: from [127.0.0.1] (10.173.223.212) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0;
 Thu, 24 Oct 2019 21:53:55 +0800
Subject: Re: [RFC PATCH] iothread: add set_iothread_poll_* commands
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <5DAEB9D3.3080503@huawei.com>
 <20191023151903.GI9574@stefanha-x1.localdomain>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <5DB1ACF2.9080500@huawei.com>
Date: Thu, 24 Oct 2019 21:53:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20191023151903.GI9574@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.223.212]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: dgilbert@redhat.com, xiexiangyou@huawei.com, qemu-devel@nongnu.org,
 jiangyiwen <jiangyiwen@huawei.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/10/23 23:19, Stefan Hajnoczi wrote:
> On Tue, Oct 22, 2019 at 04:12:03PM +0800, yezhenyu (A) wrote:
>> Since qemu2.9, QEMU added three AioContext poll parameters to struct
>> IOThread: poll_max_ns, poll_grow and poll_shrink. These properties are
>> used to control iothread polling time.
>>
>> However, there isn't properly hmp commands to adjust them when the VM is
>> alive. It's useful to adjust them online when observing the impact of
>> different property value on performance.
>>
>> This patch add three hmp commands to adjust iothread poll-* properties
>> for special iothread:
>>
>> set_iothread_poll_max_ns: set the maximum polling time in ns;
>> set_iothread_poll_grow: set how many ns will be added to polling time;
>> set_iothread_poll_shrink: set how many ns will be removed from polling
>> time.
>>
>> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
>> ---
>> hmp-commands.hx | 42 ++++++++++++++++++++
>> hmp.c | 30 +++++++++++++++
>> hmp.h | 3 ++
>> include/sysemu/iothread.h | 6 +++
>> iothread.c | 80 +++++++++++++++++++++++++++++++++++++++
>> qapi/misc.json | 23 +++++++++++
>> 6 files changed, 184 insertions(+)
> 
> poll-max-ns, poll-grow, poll-shrink are properties of IOThread objects.
> They can already be modified at runtime using:
> 
>   $ qemu -object iothread,id=iothread1
>   (qemu) qom-set /objects/iothread1 poll-max-ns 100000
> 
> I think there is no need for a patch.
> 
> Stefan
> 

Thanks for your review. I have considered using the `qom-set` command to modify
IOThread object's properties, however, this command is not friendly to primary
users. The help info for this command is only:

    qom-set path property value -- set QOM property

It's almost impossible to get the correct `path` parameter for primary user.

This patch provides a more convenient and easy-use hmp&qmp interface to modify
these IOThread properties. I think this patch still has a little value.

And I can implement this patch compactly by reusing your code.

Waiting for your reply.


