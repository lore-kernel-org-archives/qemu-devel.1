Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51280C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 02:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B74D20878
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 02:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JEPbr/NY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B74D20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTFPu-0008MU-8D
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 22:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kTFPL-0007xb-Bi
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 22:23:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35933)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kTFPJ-00060i-9P
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 22:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602815028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H0WXHoQ14EupyOu7Kg1wisCq6ivhkR8h3f93RGUNzfg=;
 b=JEPbr/NYEHq+tkUmam4RmLMqv+tyqAqdt9fL+rUJ0mEmrS+vtFVUP0fvlH+ycyOIHQMs4s
 KQATaeIuBNj4OQvw3ksJnYbxH+yNPXhKsQFGpbPMX4kWDQqfDRVUZnzTE3qri7quJ1bPvH
 5ju1oqRL4LVpOX3395d4+WD8h8BmMss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-ySpB_ZVvOpK0gk2bjaYiIw-1; Thu, 15 Oct 2020 22:23:46 -0400
X-MC-Unique: ySpB_ZVvOpK0gk2bjaYiIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D7C680365D;
 Fri, 16 Oct 2020 02:23:45 +0000 (UTC)
Received: from [10.72.12.212] (ovpn-12-212.pek2.redhat.com [10.72.12.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CFE406EF61;
 Fri, 16 Oct 2020 02:23:42 +0000 (UTC)
Subject: Re: [PATCH 00/10] COLO project queued patches 20-Oct
To: "Zhang, Chen" <chen.zhang@intel.com>, qemu-dev <qemu-devel@nongnu.org>
References: <20201014072555.12515-1-chen.zhang@intel.com>
 <7638dbe1-9095-28e2-0b5f-2eeaa5e3f98e@redhat.com>
 <f71889f9bb054cdd8c294028878c739c@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <38af8287-393b-1fdb-9fea-d334ff487d33@redhat.com>
Date: Fri, 16 Oct 2020 10:23:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f71889f9bb054cdd8c294028878c739c@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 20:29:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/10/15 下午3:58, Zhang, Chen wrote:
>
>> -----Original Message-----
>> From: Jason Wang <jasowang@redhat.com>
>> Sent: Thursday, October 15, 2020 3:56 PM
>> To: Zhang, Chen <chen.zhang@intel.com>; qemu-dev <qemu-
>> devel@nongnu.org>
>> Cc: Zhang Chen <zhangckid@gmail.com>
>> Subject: Re: [PATCH 00/10] COLO project queued patches 20-Oct
>>
>>
>> On 2020/10/14 下午3:25, Zhang Chen wrote:
>>> From: Zhang Chen <chen.zhang@intel.com>
>>>
>>> Hi Jason, this series include latest COLO related patches.
>>> please check and merge it.
>>>
>>> Thanks
>>> Zhang Chen
>>
>> Hi:
>>
>> I want to merge but I don't get patch 10/10.
>>
>> Is that lost during posting?
> Oh, Sorry I missed it.
> Already resend it:
> [PATCH 10/10] net/colo-compare.c: Increase default queued packet scan frequency
>
> Thanks
> Chen


It looks to me Philippe has some minor comments on some patches, please 
address them and send a new version.

Thanks


>
>> Thanks
>>
>>
>>> Li Zhijian (2):
>>>     colo-compare: fix missing compare_seq initialization
>>>     colo-compare: check mark in mutual exclusion
>>>
>>> Pan Nengyuan (1):
>>>     net/filter-rewriter: destroy g_hash_table in colo_rewriter_cleanup
>>>
>>> Rao, Lei (3):
>>>     Optimize seq_sorter function for colo-compare
>>>     Reduce the time of checkpoint for COLO
>>>     Fix the qemu crash when guest shutdown in COLO mode
>>>
>>> Zhang Chen (4):
>>>     net/colo-compare.c: Fix compare_timeout format issue
>>>     net/colo-compare.c: Change the timer clock type
>>>     net/colo-compare.c: Add secondary old packet detection
>>>     net/colo-compare.c: Increase default queued packet scan frequency
>>>
>>>    migration/ram.c       | 14 ++++++++++-
>>>    net/colo-compare.c    | 57 ++++++++++++++++++++++---------------------
>>>    net/colo.c            |  5 +---
>>>    net/filter-rewriter.c |  2 ++
>>>    softmmu/vl.c          |  1 +
>>>    5 files changed, 46 insertions(+), 33 deletions(-)
>>>


