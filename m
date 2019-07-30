Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA2AC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 00:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0119E2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 00:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0119E2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsG6I-00087Q-9K
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 20:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59020)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <piaojun@huawei.com>) id 1hsG5r-0007dd-2W
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 20:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <piaojun@huawei.com>) id 1hsG5p-0006T5-5g
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 20:34:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43864 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <piaojun@huawei.com>) id 1hsG5o-0006R0-Jc
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 20:34:17 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 8F55EEA39494D70861EB;
 Tue, 30 Jul 2019 08:34:12 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 30 Jul 2019
 08:34:02 +0800
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20190726091103.23503-1-stefanha@redhat.com>
 <20190726091103.23503-3-stefanha@redhat.com>
 <e83e2463-5239-e5c0-cc44-e1e0b74df37c@huawei.com>
 <20190729154118.GA21560@stefanha-x1.localdomain>
From: piaojun <piaojun@huawei.com>
Message-ID: <5D3F9078.2070607@huawei.com>
Date: Tue, 30 Jul 2019 08:34:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20190729154118.GA21560@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.35
Subject: Re: [Qemu-devel] [Virtio-fs] [PATCH 2/5] virtiofsd: prevent
 lo_lookup() NULL pointer dereference
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
Cc: virtio-fs@redhat.com, piaojun@huawei.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/7/29 23:41, Stefan Hajnoczi wrote:
> On Mon, Jul 29, 2019 at 08:35:36PM +0800, piaojun wrote:
>> Hi Stefan,
>>
>> On 2019/7/26 17:11, Stefan Hajnoczi wrote:
>>> Most lo_do_lookup() have already checked that the parent inode exists.
>>> lo_lookup() hasn't and can therefore hit a NULL pointer dereference when
>>> lo_inode(req, parent) returns NULL.
>>>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>>  contrib/virtiofsd/passthrough_ll.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthrough_ll.c
>>> index 9ae1381618..277a17fc03 100644
>>> --- a/contrib/virtiofsd/passthrough_ll.c
>>> +++ b/contrib/virtiofsd/passthrough_ll.c
>>> @@ -766,6 +766,10 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *name,
>>>  	struct lo_data *lo = lo_data(req);
>>>  	struct lo_inode *inode, *dir = lo_inode(req, parent);
>>>  
>>> +	if (!dir) {
>>> +		return EBADF;
>>> +	}
>>> +
>>
>> I worry about that dir will be released or set NULL just after NULL
>> checking. Or could we use some lock to prevent the simultaneity?
> 
> Yes, I agree.  I haven't audited lo_inode yet, but it needs a refcount
> and/or lock to ensure accesses are safe.  I'll do that and other things
> in a separate patch series.
> 
> Stefan

OK, that sounds good.

Jun

> 

