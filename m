Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCACCA9EC9
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 07:31:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A650020862
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 07:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIVV7nqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A650020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQRPZ-00006h-Rq
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 03:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iQRO9-00080z-Kx
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 03:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iQRO7-0002Dh-M3
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 03:30:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25633
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iQRO7-0002Co-EG
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 03:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572593425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6KsUiQYdyNLyb5aUkASLMu4wDADVn4VnI/FHfv9fstE=;
 b=EIVV7nqMuyzejWpjFF98aoe5p7di8Q/QVJuP+nV3AkrrX9D3FN7Sjhq3zhtF7lqWmd1hOZ
 6PKkYQfdXCidFpk9CXsk30RLdV29mk10Zn84gkD3B0sKHqk6CqaM0v+I02conXeIedTUVg
 BmRYZ6A5bwsrWKoHegbPjXs9ajVaVLE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-ptN-xec8NNGqZ_IpHXCAmA-1; Fri, 01 Nov 2019 03:30:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C8931005500;
 Fri,  1 Nov 2019 07:30:19 +0000 (UTC)
Received: from [10.72.12.30] (ovpn-12-30.pek2.redhat.com [10.72.12.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D851B60852;
 Fri,  1 Nov 2019 07:29:51 +0000 (UTC)
Subject: Re: [RFC v2 00/22] intel_iommu: expose Shared Virtual Addressing to VM
To: "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
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
From: Jason Wang <jasowang@redhat.com>
Message-ID: <960389b5-2ef4-8921-fc28-67c9a6398c43@redhat.com>
Date: Fri, 1 Nov 2019 15:29:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A0EACA6@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ptN-xec8NNGqZ_IpHXCAmA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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


On 2019/10/31 =E4=B8=8B=E5=8D=8810:07, Liu, Yi L wrote:
>> From: Jason Wang [mailto:jasowang@redhat.com]
>> Sent: Thursday, October 31, 2019 5:33 AM
>> Subject: Re: [RFC v2 00/22] intel_iommu: expose Shared Virtual Addressin=
g to VM
>>
>>
>> On 2019/10/25 =E4=B8=8B=E5=8D=886:12, Tian, Kevin wrote:
>>>> From: Jason Wang [mailto:jasowang@redhat.com]
>>>> Sent: Friday, October 25, 2019 5:49 PM
>>>>
>>>>
>>>> On 2019/10/24 =E4=B8=8B=E5=8D=888:34, Liu Yi L wrote:
>>>>> Shared virtual address (SVA), a.k.a, Shared virtual memory (SVM) on
>>>>> Intel platforms allow address space sharing between device DMA and
>>>> applications.
>>>>
>>>>
>>>> Interesting, so the below figure demonstrates the case of VM. I
>>>> wonder how much differences if we compare it with doing SVM between
>>>> device and an ordinary process (e.g dpdk)?
>>>>
>>>> Thanks
>>> One difference is that ordinary process requires only stage-1
>>> translation, while VM requires nested translation.
>>
>> A silly question, then I believe there's no need for VFIO DMA API in thi=
s case consider
>> the page table is shared between MMU and IOMMU?
> Echo Kevin's reply. We use nested translation here. For stage-1, yes, no =
need to use
> VFIO DMA API. For stage-2, we still use VFIO DMA API to program the GPA->=
HPA
> mapping to host. :-)


Cool, two more questions:

- Can EPT shares its page table with IOMMU L2?

- Similar to EPT, when GPA->HPA (actually HVA->HPA) is modified by mm,=20
VFIO need to use MMU notifier do modify L2 accordingly besides DMA API?

Thanks


>
> Regards,
> Yi Liu
>> Thanks
>>


