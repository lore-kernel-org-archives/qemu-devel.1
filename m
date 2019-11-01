Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DB3CA9EC9
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 08:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42268208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 08:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i3MyzIU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42268208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQS1e-0005lm-FZ
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 04:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iQS0t-0005Mg-4y
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iQS0r-0006h1-FT
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:10:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42827
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iQS0r-0006gG-AQ
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572595828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vGdlymZM+J9HlsfK4iyrriO4t0Rkwu6IDQDp+o3XYaU=;
 b=i3MyzIU9ph/tSpOBcBK4IJY3nBy6fYDa3TjnCTQSBHSKdi4rK17p7nYPjZmhfHdIGwErJR
 qQnSXUpppeLn9wEkJyDQL4cMh19FqmsW4gOP2GJb3anBLNh1fX7HcEUUwUJ7f2rco3Hdo+
 5MYKIDSF2Tgi7X430epay/sDLDWnGsY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-fB_mg0P4POmlypj4mWmt0Q-1; Fri, 01 Nov 2019 04:10:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97E8B800D49;
 Fri,  1 Nov 2019 08:10:20 +0000 (UTC)
Received: from [10.72.12.30] (ovpn-12-30.pek2.redhat.com [10.72.12.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D69CE1001B07;
 Fri,  1 Nov 2019 08:09:46 +0000 (UTC)
Subject: Re: [RFC v2 00/22] intel_iommu: expose Shared Virtual Addressing to VM
From: Jason Wang <jasowang@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <367adad0-eb05-c950-21d7-755fffacbed6@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D5D0619@SHSMSX104.ccr.corp.intel.com>
 <fa994379-a847-0ffe-5043-40a2aefecf43@redhat.com>
 <A2975661238FB949B60364EF0F2C25743A0EACA6@SHSMSX104.ccr.corp.intel.com>
 <960389b5-2ef4-8921-fc28-67c9a6398c43@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D5E17C7@SHSMSX104.ccr.corp.intel.com>
 <18534f1b-3488-994b-73e2-17e7d8ccb4c2@redhat.com>
Message-ID: <4fae7d47-93c6-1278-b55e-ec06fa3ca7f1@redhat.com>
Date: Fri, 1 Nov 2019 16:09:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <18534f1b-3488-994b-73e2-17e7d8ccb4c2@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: fB_mg0P4POmlypj4mWmt0Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "tianyu.lan@intel.com" <tianyu.lan@intel.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/11/1 =E4=B8=8B=E5=8D=884:04, Jason Wang wrote:
>
> On 2019/11/1 =E4=B8=8B=E5=8D=883:46, Tian, Kevin wrote:
>>> From: Jason Wang [mailto:jasowang@redhat.com]
>>> Sent: Friday, November 1, 2019 3:30 PM
>>>
>>>
>>> On 2019/10/31 =E4=B8=8B=E5=8D=8810:07, Liu, Yi L wrote:
>>>>> From: Jason Wang [mailto:jasowang@redhat.com]
>>>>> Sent: Thursday, October 31, 2019 5:33 AM
>>>>> Subject: Re: [RFC v2 00/22] intel_iommu: expose Shared Virtual
>>> Addressing to VM
>>>>>
>>>>> On 2019/10/25 =E4=B8=8B=E5=8D=886:12, Tian, Kevin wrote:
>>>>>>> From: Jason Wang [mailto:jasowang@redhat.com]
>>>>>>> Sent: Friday, October 25, 2019 5:49 PM
>>>>>>>
>>>>>>>
>>>>>>> On 2019/10/24 =E4=B8=8B=E5=8D=888:34, Liu Yi L wrote:
>>>>>>>> Shared virtual address (SVA), a.k.a, Shared virtual memory=20
>>>>>>>> (SVM) on
>>>>>>>> Intel platforms allow address space sharing between device DMA
>>> and
>>>>>>> applications.
>>>>>>>
>>>>>>>
>>>>>>> Interesting, so the below figure demonstrates the case of VM. I
>>>>>>> wonder how much differences if we compare it with doing SVM
>>> between
>>>>>>> device and an ordinary process (e.g dpdk)?
>>>>>>>
>>>>>>> Thanks
>>>>>> One difference is that ordinary process requires only stage-1
>>>>>> translation, while VM requires nested translation.
>>>>> A silly question, then I believe there's no need for VFIO DMA API=20
>>>>> in this
>>> case consider
>>>>> the page table is shared between MMU and IOMMU?
>>>> Echo Kevin's reply. We use nested translation here. For stage-1,=20
>>>> yes, no
>>> need to use
>>>> VFIO DMA API. For stage-2, we still use VFIO DMA API to program the
>>> GPA->HPA
>>>> mapping to host. :-)
>>>
>>> Cool, two more questions:
>>>
>>> - Can EPT shares its page table with IOMMU L2?
>> yes, their formats are compatible.
>>
>>> - Similar to EPT, when GPA->HPA (actually HVA->HPA) is modified by mm,
>>> VFIO need to use MMU notifier do modify L2 accordingly besides DMA API?
>>>
>> VFIO devices need to pin-down guest memory pages that are mapped
>> in IOMMU. So notifier is not required since mm won't change the mapping
>> for those pages.
>
>
> The GUP tends to lead a lot of issues, we may consider to allow=20
> userspace to choose to not pin them in the future.


Btw, I'm asking since I see MMU notifier is used by intel-svm.c to flush=20
IOTLB. (I don't see any users in kernel source that use that API though=20
e.g intel_svm_bind_mm()).

Thanks


>
> Thanks
>
>
>>
>> Thanks
>> Kevin


