Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755E2C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3682E24650
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PH49SUkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3682E24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtd1-0003Q5-77
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 06:05:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1ihtb4-0001ee-Qw
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:03:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1ihtb3-0001fh-Fj
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:03:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28883
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1ihtb3-0001d2-9j
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576753436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c/XZkYHGQZ+Qe6fjvAxBLlDlAWbyR1Du9b+N0e7LYn8=;
 b=PH49SUkWg4v3BmkHzTGlKbqi5azeAcvwBST8URaMxvgqtcycSQzEB5dll8o99mGe7jV7Ch
 rgQi4I81u8B4p5z21T7y862UejjbRVCTYhJGeCqMPVuwerLaC+qHErUJHgniNmkk2fHXK+
 8e0MmIFOYyjF8M4EgkM7kfQtAOMyqmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-3ze0b_d8Pu6b0pOpxszu2w-1; Thu, 19 Dec 2019 06:03:55 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D962477;
 Thu, 19 Dec 2019 11:03:53 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DFA3A6889D;
 Thu, 19 Dec 2019 11:03:43 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v11 18/20] virtio-iommu: Support migration
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-19-eric.auger@redhat.com>
 <20191210165006.GP277340@myrica>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a8b88770-c70e-3e41-7e57-9f17ef21feaf@redhat.com>
Date: Thu, 19 Dec 2019 12:03:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191210165006.GP277340@myrica>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 3ze0b_d8Pu6b0pOpxszu2w-1
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

On 12/10/19 5:50 PM, Jean-Philippe Brucker wrote:
> On Fri, Nov 22, 2019 at 07:29:41PM +0100, Eric Auger wrote:
>> +static const VMStateDescription vmstate_virtio_iommu_device = {
>> +    .name = "virtio-iommu-device",
>> +    .minimum_version_id = 1,
>> +    .version_id = 1,
>> +    .post_load = iommu_post_load,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_GTREE_DIRECT_KEY_V(domains, VirtIOIOMMU, 1,
>> +                                   &vmstate_domain, viommu_domain),
>> +        VMSTATE_GTREE_DIRECT_KEY_V(endpoints, VirtIOIOMMU, 1,
>> +                                   &vmstate_endpoint, viommu_endpoint),
> 
> So if I understand correctly these fields are state that is modified by
> the guest? We don't need to save/load fields that cannot be modified by
> the guest, static information that is created from the QEMU command-line. 

Yes that's correct.
> 
> I think the above covers everything we need to migrate in VirtIOIOMMU
> then, except for acked_features, which (as I pointed out on another patch)
> seems redundant anyway since there is vdev->guest_features.

you're right, acked features were not properly migrated.
> 
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Thanks!

Eric
> 
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +
>> +
>>  static const VMStateDescription vmstate_virtio_iommu = {
>>      .name = "virtio-iommu",
>>      .minimum_version_id = 1,
>> -- 
>> 2.20.1
>>
>>
> 


