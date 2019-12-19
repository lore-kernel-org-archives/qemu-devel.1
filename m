Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7032DC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA0721D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhpBGbTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA0721D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iht7o-0007fq-50
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 05:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iht5R-0005uK-Ci
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:31:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iht5Q-00005t-9e
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:31:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51630
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iht5O-0008VI-9b
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576751473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gf2YGeZfVn/qtENW1rrykbXMg9iGRIwEYDRSt4RketE=;
 b=FhpBGbTHQ6IlFiL7j0RNekZbW/ZP7L6lTmJJfZ65g/2WlZvNZzG+vTCojjEpgTP4jmUlOr
 zUXPj/cpK1/+DbGCbH1nD0XxQjEu7PFg4nCva4XXakEHSdScZTzE+jpVQFKM12Y7uT+T/x
 UrILrauP5g2+VM/7kjVydcFKwMQefnM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-KaY59EmoPbCKxOBAcFMz2w-1; Thu, 19 Dec 2019 05:31:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68FBA18557C0;
 Thu, 19 Dec 2019 10:31:08 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AFC4269AE2;
 Thu, 19 Dec 2019 10:31:02 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v11 02/20] virtio-iommu: Add skeleton
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-3-eric.auger@redhat.com>
 <20191210163155.GA277340@myrica>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <c7baf4cd-2a5f-fd10-e195-95b1232b3bcf@redhat.com>
Date: Thu, 19 Dec 2019 11:31:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191210163155.GA277340@myrica>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: KaY59EmoPbCKxOBAcFMz2w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 armbru@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jean,

On 12/10/19 5:31 PM, Jean-Philippe Brucker wrote:
> Hi Eric,
> 
> On Fri, Nov 22, 2019 at 07:29:25PM +0100, Eric Auger wrote:
>> +typedef struct VirtIOIOMMU {
>> +    VirtIODevice parent_obj;
>> +    VirtQueue *req_vq;
>> +    VirtQueue *event_vq;
>> +    struct virtio_iommu_config config;
>> +    uint64_t features;
>> +    uint64_t acked_features;
> 
> We already have guest_features in the parent object.
That's correct. I also removed the set_features() specific
implementation as I can rely on the default one.
> 
>> +    GHashTable *as_by_busptr;
>> +    IOMMUPciBus *as_by_bus_num[IOMMU_PCI_BUS_MAX];
> 
> Doesn't seem used anymore.
removed
> 
> Thanks,
> Jean
> 
>> +    PCIBus *primary_bus;
>> +    GTree *domains;
>> +    QemuMutex mutex;
>> +    GTree *endpoints;
>> +} VirtIOIOMMU;
>> +
>> +#endif
>> -- 
>> 2.20.1
>>
>>
> 
Thanks

Eric


