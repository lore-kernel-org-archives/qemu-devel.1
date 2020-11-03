Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FACC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 19:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A870421556
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 19:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dC1csiqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A870421556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka2Ju-0002c5-Mc
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 14:50:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1ka2I4-0001i6-Lg
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 14:48:24 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1ka2I2-0000du-I9
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 14:48:24 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fa1b4020000>; Tue, 03 Nov 2020 11:48:18 -0800
Received: from [10.40.101.50] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Nov
 2020 19:48:15 +0000
Subject: Re: [PATCH v1] docs/devel: Add VFIO device migration documentation
To: Alex Williamson <alex.williamson@redhat.com>
References: <1603950791-27236-1-git-send-email-kwankhede@nvidia.com>
 <20201029125221.69352b48.cohuck@redhat.com>
 <9479dffd-e434-e336-6ed8-07fc2edd2453@nvidia.com>
 <20201029130519.7eb1e704@w520.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <47f8ccea-f75a-dfb7-b646-28d5123b322f@nvidia.com>
Date: Wed, 4 Nov 2020 01:18:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201029130519.7eb1e704@w520.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1604432898; bh=ji99AbAIQdpRsOwWOyGgd5kX/5mpLuIKKFFzUlxRU0U=;
 h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
 b=dC1csiqKH5loAd5MAYspbtewEjT29nQPTzZkauHVBmUTf1DNbrtFr618C4qvcsvy+
 5kGmf2z8wqD1ULD4ih76N3+VlXb9nBldVGqOL/2hoKvrazaqXPF+kAvgsIFRtpAaKP
 hDUahkfTB2TwOc9RcGmtH5eAdFWbMP46L31nL3ztcL8tPcYxgx5ZAmHAiuZLvBriIs
 7IqMWy5vgLisCqTZf0CYCow35MV2al17XitqdEL7N0sbrWP9eSYSLBZQyKUAMGcpoB
 3Bja/o/Ije1HLGBrpXCQvsYiufCOtAgEVtWVxIJdRYxBs/SmD/C3pYjFS6YHHPz3vu
 FyxjnL+AatFvw==
Received-SPF: pass client-ip=216.228.121.64; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate25.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 14:48:19
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Cc: mcrossley@nvidia.com, cjia@nvidia.com, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, dnigam@nvidia.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/30/2020 12:35 AM, Alex Williamson wrote:
> On Thu, 29 Oct 2020 23:11:16 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 

<snip>

>>>> +System memory dirty pages tracking
>>>> +----------------------------------
>>>> +
>>>> +A ``log_sync`` memory listener callback is added to mark system memory pages
>>>
>>> s/is added to mark/marks those/
>>>    
>>>> +as dirty which are used for DMA by VFIO device. Dirty pages bitmap is queried
>>>
>>> s/by/by the/
>>> s/Dirty/The dirty/
>>>    
>>>> +per container. All pages pinned by vendor driver through vfio_pin_pages()
>>>
>>> s/by/by the/
>>>    
>>>> +external API have to be marked as dirty during migration. When there are CPU
>>>> +writes, CPU dirty page tracking can identify dirtied pages, but any page pinned
>>>> +by vendor driver can also be written by device. There is currently no device
>>>
>>> s/by/by the/ (x2)
>>>    
>>>> +which has hardware support for dirty page tracking. So all pages which are
>>>> +pinned by vendor driver are considered as dirty.
>>>> +Dirty pages are tracked when device is in stop-and-copy phase because if pages
>>>> +are marked dirty during pre-copy phase and content is transfered from source to
>>>> +destination, there is no way to know newly dirtied pages from the point they
>>>> +were copied earlier until device stops. To avoid repeated copy of same content,
>>>> +pinned pages are marked dirty only during stop-and-copy phase.
>>
>>
>>> Let me take a quick stab at rewriting this paragraph (not sure if I
>>> understood it correctly):
>>>
>>> "Dirty pages are tracked when the device is in the stop-and-copy phase.
>>> During the pre-copy phase, it is not possible to distinguish a dirty
>>> page that has been transferred from the source to the destination from
>>> newly dirtied pages, which would lead to repeated copying of the same
>>> content. Therefore, pinned pages are only marked dirty during the
>>> stop-and-copy phase." ?
>>>    
>>
>> I think above rephrase only talks about repeated copying in pre-copy
>> phase. Used "copied earlier until device stops" to indicate both
>> pre-copy and stop-and-copy till device stops.
> 
> 
> Now I'm confused, I thought we had abandoned the idea that we can only
> report pinned pages during stop-and-copy.  Doesn't the device needs to
> expose its dirty memory footprint during the iterative phase regardless
> of whether that causes repeat copies?  If QEMU iterates and sees that
> all memory is still dirty, it may have transferred more data, but it
> can actually predict if it can achieve its downtime tolerances.  Which
> is more important, less data transfer or predictability?  Thanks,
> 

Even if QEMU copies and transfers content of all sys mem pages during 
pre-copy (worst case with IOMMU backed mdev device when its vendor 
driver is not smart to pin pages explicitly and all sys mem pages are 
marked dirty), then also its prediction about downtime tolerance will 
not be correct, because during stop-and-copy again all pages need to be 
copied as device can write to any of those pinned pages.

Thanks,
Kirti


