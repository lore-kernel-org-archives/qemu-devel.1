Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URI_WP_DIRINDEX,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0CAC2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:32:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ABF3206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GH3hLUN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ABF3206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLP3a-0001Lr-Jl
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jLP2E-0008V7-Ee
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jLP2C-000697-OL
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:31:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24489
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jLP2C-00068l-Jp
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586169076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Frr3U9FewSH3rwJWC1POGOuw/i/P/MIPEW7fR+tNJOo=;
 b=GH3hLUN4TKSBvip+/e1JNUdi0NrrkdR8q7jQCbb2OlzptpLfeDAxl8Ln9l8y5BYuxejg7X
 m2e8GDnCQ0byDknanlyJISjdtNVMa5WaqWIvlH9f9h3y9ykYrHghZq+3LDEzhjJpGJXypF
 QXYpBcK53J7yliGFTJmbG0TOEv6za0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-p-t34X7RPyeNPqCCGcDabQ-1; Mon, 06 Apr 2020 06:30:47 -0400
X-MC-Unique: p-t34X7RPyeNPqCCGcDabQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE647113784E;
 Mon,  6 Apr 2020 10:30:45 +0000 (UTC)
Received: from [10.36.112.58] (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5D8A60BF1;
 Mon,  6 Apr 2020 10:30:41 +0000 (UTC)
Subject: Re: [PATCH v2 04/22] hw/iommu: introduce HostIOMMUContext
To: "Liu, Yi L" <yi.l.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-5-git-send-email-yi.l.liu@intel.com>
 <aa1bfbd5-e6de-6475-809e-a6ca46089aaa@redhat.com>
 <A2975661238FB949B60364EF0F2C25743A2230B3@SHSMSX104.ccr.corp.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <338937be-9b1e-163f-90ef-2cf0c437c3e8@redhat.com>
Date: Mon, 6 Apr 2020 12:30:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A2230B3@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu,
 Hao" <hao.wu@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Yi,

On 4/6/20 10:04 AM, Liu, Yi L wrote:
> Hi Eric,
> 
>> From: Auger Eric < eric.auger@redhat.com>
>> Sent: Tuesday, March 31, 2020 1:23 AM
>> To: Liu, Yi L <yi.l.liu@intel.com>; qemu-devel@nongnu.org;
>> Subject: Re: [PATCH v2 04/22] hw/iommu: introduce HostIOMMUContext
>>
>> Yi,
>>
>> On 3/30/20 6:24 AM, Liu Yi L wrote:
>>> Currently, many platform vendors provide the capability of dual stage
>>> DMA address translation in hardware. For example, nested translation
>>> on Intel VT-d scalable mode, nested stage translation on ARM SMMUv3,
>>> and etc. In dual stage DMA address translation, there are two stages
>>> address translation, stage-1 (a.k.a first-level) and stage-2 (a.k.a
>>> second-level) translation structures. Stage-1 translation results are
>>> also subjected to stage-2 translation structures. Take vSVA (Virtual
>>> Shared Virtual Addressing) as an example, guest IOMMU driver owns
>>> stage-1 translation structures (covers GVA->GPA translation), and host
>>> IOMMU driver owns stage-2 translation structures (covers GPA->HPA
>>> translation). VMM is responsible to bind stage-1 translation structures
>>> to host, thus hardware could achieve GVA->GPA and then GPA->HPA
>>> translation. For more background on SVA, refer the below links.
>>>  - https://www.youtube.com/watch?v=Kq_nfGK5MwQ
>>>  - https://events19.lfasiallc.com/wp-content/uploads/2017/11/\
>>> Shared-Virtual-Memory-in-KVM_Yi-Liu.pdf
>>>
> [...]
>>> +void host_iommu_ctx_init(void *_iommu_ctx, size_t instance_size,
>>> +                         const char *mrtypename,
>>> +                         uint64_t flags)
>>> +{
>>> +    HostIOMMUContext *iommu_ctx;
>>> +
>>> +    object_initialize(_iommu_ctx, instance_size, mrtypename);
>>> +    iommu_ctx = HOST_IOMMU_CONTEXT(_iommu_ctx);
>>> +    iommu_ctx->flags = flags;
>>> +    iommu_ctx->initialized = true;
>>> +}
>>> +
>>> +static const TypeInfo host_iommu_context_info = {
>>> +    .parent             = TYPE_OBJECT,
>>> +    .name               = TYPE_HOST_IOMMU_CONTEXT,
>>> +    .class_size         = sizeof(HostIOMMUContextClass),
>>> +    .instance_size      = sizeof(HostIOMMUContext),
>>> +    .abstract           = true,
>> Can't we use the usual .instance_init and .instance_finalize?
> sorry, I somehow missed this comment. In prior patch, .instace_init
> was used, but the current major init method is via host_iommu_ctx_init(),
> so .instance_init is not really necessary.
> https://www.spinics.net/lists/kvm/msg210878.html

OK globally what disturbs me is you introduced a QOM object but globally
the inheritance schema is not totally clear to me (only a VFIO derived
is created and I do not understand what other backend would be able to
use it) and this does not really have the look & feel of standard QOM
objects. I tried to compare its usage/implementation version
MemoryRegion for instance.

Thanks

Eric
> Regards,
> Yi Liu
> 


