Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92F8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 07:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F86F20771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 07:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F86F20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyVG6-0006HH-O3
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 03:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1jyVFC-0005p4-3O
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 03:02:18 -0400
Received: from goliath.siemens.de ([192.35.17.28]:50516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1jyVFA-0004Pr-3C
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 03:02:17 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 06N72ABC031190
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Jul 2020 09:02:10 +0200
Received: from [139.22.112.247] ([139.22.112.247])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06N729ci005475;
 Thu, 23 Jul 2020 09:02:09 +0200
Subject: Re: [virtio-comment] [RFC] ivshmem v2: Shared memory device
 specification
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <f109fe5a-92eb-e5a5-bb83-ada42b3a9b61@siemens.com>
 <20200715132748.GA20677@stefanha-x1.localdomain>
 <88a33034-783a-07d2-85e0-c1a1ecd2721f@siemens.com>
 <20200723065423.GE268427@stefanha-x1.localdomain>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <10df6427-eab0-d3b8-4624-ede98ff7ef09@siemens.com>
Date: Thu, 23 Jul 2020 09:02:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723065423.GE268427@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.35.17.28; envelope-from=jan.kiszka@siemens.com;
 helo=goliath.siemens.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 03:02:13
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Jailhouse <jailhouse-dev@googlegroups.com>, liang yan <lyan@suse.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23.07.20 08:54, Stefan Hajnoczi wrote:
> On Fri, Jul 17, 2020 at 06:15:58PM +0200, Jan Kiszka wrote:
>> On 15.07.20 15:27, Stefan Hajnoczi wrote:
>>> On Mon, May 25, 2020 at 09:58:28AM +0200, Jan Kiszka wrote:
> 
> Thanks for the responses. It would be great to update the spec with
> these clarifications.
> 
>>>> If BAR 2 is not present, the shared memory region is not relocatable
>>>> by the user. In that case, the hypervisor has to implement the Base
>>>> Address register in the vendor-specific capability.
>>>
>>> What does relocatable mean in this context?
>>
>> That the guest can decide (via BAR) where the resource should show up in the
>> physical guest address space. We do not want to support this in setups like
>> for static partitioning hypervisors, and then we use that side-channel
>> read-only configuration.
> 
> I see. I'm not sure what is vendor-specific about non-relocatable shared
> memory. I guess it could be added to the spec too?

That "vendor-specific" comes from the PCI spec which - to my 
understanding - provides us no other means to introduce registers to the 
config space that are outside of the PCI spec. I could introduce a name 
for the ivshmem vendor cap and use that name here - would that be better?

> 
> In any case, since "relocatable" hasn't been fully defined, I suggest
> making the statement more general:
> 
>    If BAR 2 is not present the hypervisor has to implement the Base
>    Address Register in the vendor-specific capability. This can be used
>    for vendor-specific shared memory functionality.
> 

Will integrate this.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

