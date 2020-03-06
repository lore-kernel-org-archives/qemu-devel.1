Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E9CC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:00:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D6F520848
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6F520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAAia-0007dN-Rd
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:00:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tianjia.zhang@linux.alibaba.com>) id 1jAAhr-0007Br-3w
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:59:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tianjia.zhang@linux.alibaba.com>) id 1jAAhk-0001Qs-RA
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:59:45 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:54289)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tianjia.zhang@linux.alibaba.com>)
 id 1jAAhk-0000qL-Gq
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:59:44 -0500
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R401e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01f04428;
 MF=tianjia.zhang@linux.alibaba.com; NM=1; PH=DS; RN=2; SR=0;
 TI=SMTPD_---0TrozvF9_1583492361; 
Received: from 30.27.224.42(mailfrom:tianjia.zhang@linux.alibaba.com
 fp:SMTPD_---0TrozvF9_1583492361) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 06 Mar 2020 18:59:22 +0800
Subject: Re: [PATCH] tests: Fix a bug with count variables
From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20200207115433.118254-1-tianjia.zhang@linux.alibaba.com>
 <20200212135937.GD432724@stefanha-x1.localdomain>
 <6a59cc95-4c75-6b36-eaf7-c5a5d2ecdf2d@linux.alibaba.com>
Message-ID: <1e613efd-6e9a-218a-35a4-b60d58086a7f@linux.alibaba.com>
Date: Fri, 6 Mar 2020 18:59:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <6a59cc95-4c75-6b36-eaf7-c5a5d2ecdf2d@linux.alibaba.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 47.88.44.36
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/3/6 18:22, Tianjia Zhang wrote:
> 
> On 2020/2/12 21:59, Stefan Hajnoczi wrote:
>> On Fri, Feb 07, 2020 at 07:54:33PM +0800, Tianjia Zhang wrote:
>>> The counting code here should use the local variable n_nodes_local.
>>> Otherwise, the variable n_nodes is counting incorrectly, causing the
>>> counting logic of the code to be wrong.
>>>
>>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>>> ---
>>>   tests/test-rcu-list.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>
> 
> Hi,
> 
> I see that this patch has not entered the mainline. It has been more 
> than 20 days. Dont forget it.
> 
> Thanks,
> Tianjia

Thanks and Best,
Tianjia

