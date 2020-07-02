Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52199C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 20:30:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20949207D4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 20:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20949207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr5rE-00027x-Bs
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 16:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jr5ps-0000cu-J1; Thu, 02 Jul 2020 16:29:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:61705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jr5pp-0004sS-W1; Thu, 02 Jul 2020 16:29:32 -0400
IronPort-SDR: PZ7EC5Ty8ahbbZj6hOOUcRuYFl6ThrGtyzoh4YTT70dTh89ygOvN5T95sGZPdkMqryZgKEWVhP
 Rdoo7Qmdd0ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="148560792"
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="148560792"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 13:29:26 -0700
IronPort-SDR: pvqX6ntg3dWiziXvEJlbSB5y1/Q3vFV7ZRUT3mQszE6Gbr6NvEg57mCL3ScA28Bxg3AtAYpKzE
 HjidLe+afM4w==
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="426073606"
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.212.130.2])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 13:29:25 -0700
Subject: Re: nvme emulation merge process
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Kevin Wolf <kwolf@redhat.com>
References: <20200630100139.1483002-1-its@irrelevant.dk>
 <20200630125932.GA553472@localhost.localdomain>
 <c10b18a8-44f3-7dab-b9bb-7d017f210934@redhat.com>
 <20200630154228.GB1987534@dhcp-10-100-145-180.wdl.wdc.com>
 <20200630203630.am3a3bc5ze5m2r3k@apples.localdomain>
 <20200701103407.GA11634@linux.fritz.box>
 <20200701131820.l4gb2ewjmnm6ysmt@apples.localdomain>
 <645af679-d2a3-a744-d07c-477198879680@redhat.com>
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Message-ID: <28258e14-843d-d736-e3b1-9bb11bf2e138@linux.intel.com>
Date: Thu, 2 Jul 2020 13:29:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <645af679-d2a3-a744-d07c-477198879680@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.24;
 envelope-from=andrzej.jakowski@linux.intel.com; helo=mga09.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 16:29:27
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/20 6:57 AM, Philippe Mathieu-Daudé wrote:
> On 7/1/20 3:18 PM, Klaus Jensen wrote:
>> On Jul  1 12:34, Kevin Wolf wrote:
>>> Am 30.06.2020 um 22:36 hat Klaus Jensen geschrieben:
>>>> On Jun 30 08:42, Keith Busch wrote:
>>>>> On Tue, Jun 30, 2020 at 04:09:46PM +0200, Philippe Mathieu-DaudÃ© wrote:
>>>>>> What I see doable for the following days is:
>>>>>> - hw/block/nvme: Fix I/O BAR structure [3]
>>>>>> - hw/block/nvme: handle transient dma errors
>>>>>> - hw/block/nvme: bump to v1.3
>>>>>
>>>>>
>>>>> These look like sensible patches to rebase future work on, IMO. The 1.3
>>>>> updates had been prepared a while ago, at least.
>>>>
>>>> I think Philippe's "hw/block/nvme: Fix I/O BAR structure" series is a
>>>> no-brainer. It just needs to get in asap.
>>>
>>> I think we need to talk about how nvme patches are supposed to get
>>> merged. I'm not familiar with the hardware nor the code, so the model
>>> was that I just blindly merge patches that Keith has reviewed/acked,
>>> just to spare him the work to prepare a pull request. But obviously, we
>>> started doing things this way when there was a lot less activity around
>>> the nvme emulation.
>>>
>>> If we find that this doesn't scale any more, maybe we need to change
>>> something.
>>
>> Honestly, I do not think the current model has worked very well for some
>> time; especially for larger series where I, for one, has felt that my
>> work was largely ignored due to a lack of designated reviewers. Things
>> only picked up when Beata, Maxim and Philippe started reviewing my
>> series - maybe out of pity or because I was bombing the list, I don't
>> know ;)
> 
> I have no interest in the NVMe device emulation, but one of the first
> thing I notice when I look at the wiki the time I wanted to send my
> first patch, is the "Return the favor" paragraph:
> https://wiki.qemu.org/Contribute/SubmitAPatch#Return_the_favor
> 
>  "Peer review only works if everyone chips in a bit of review time.
>   If everyone submitted more patches than they reviewed, we would
>   have a patch backlog. A good goal is to try to review at least as
>   many patches from others as what you submit. Don't worry if you
>   don't know the code base as well as a maintainer; it's perfectly
>   fine to admit when your review is weak because you are unfamiliar
>   with the code."
> 
> So as some reviewed my patches, I try to return the favor to the
> community, in particular when I see someone is stuck waiting for
> review, and the patch topic is some area I can understand.
> 
> I don't see that as an "out of pity" reaction.
> 
> Note, it is true bomb series scares reviewers. You learned it the
> bad way. But you can see, after resending the first part of your
> "bomb", even if it took 10 versions, the result is a great
> improvement!
> 
>> We've also seen good patches from Andrzej linger on the list for quite a
>> while, prompting a number of RESENDs. I only recently allocated more
>> time and upped my review game, but I hope that contributors feel that
>> stuff gets reviewed in a timely fashion by now.
>>
>> Please understand that this is in NO WAY a criticism of Keith who
>> already made it very clear to me that he did not have a lot time to
>> review, but only ack the odd patch.
>>
>>> Depending on how much time Keith can spend on review in the
>>> near future and how much control he wants to keep over the development,
>>> I could imagine adding Klaus to MAINTAINERS, either as a co-maintainer
>>> or as a reviewer. Then I could rely on reviews/acks from either of you
>>> for merging series.
>>>
>>
>> I would be happy to step up (officially) to help maintain the device
>> with Keith and review on a daily basis, and my position can support
>> this.
> 
> Sounds good to me, but it is up to Keith Busch to accept.
> 
> It would be nice to have at least one developer from WDC listed as
> designated reviewer too.
> 
> Maxim is candidate for designated reviewer but I think he doesn't
> have the time.
> 
> It would also nice to have Andrzej Jakowski listed, if he is interested.

Thx! Of course I am interested in helping and I think it is actually great 
idea to have couple of designated maintainers/reviewers as it would be easier
for folks to receive feedback vs requesting it in polling manner :)
And please don't get me wrong -- I'm not complaining about anything -- I
think it is just reality that everybody is stretched out into multiple directions
struggling to allocate time for multiple things. Having many people will
actually increase likelihood of introducing high quality improvements.

Also, +1 on separate tree for nvme emulation.

> 
>>
>>> Of course, the patches don't necessarily have to go through my tree
>>> either if this only serves to complicate things these days. If sending
>>> separate pull requests directly to Peter would make things easier, I
>>> certainly wouldn't object.
>>>
>>
>> I don't think there is any reason to by-pass your tree. I think the
>> volume would need to increase even further for that to make sense.
>>
> 


