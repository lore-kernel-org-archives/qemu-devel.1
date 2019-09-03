Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E67C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 12:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AEC32087E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 12:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AEC32087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i57rg-0000ie-Dg
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 08:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i57qp-0000BF-LG
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 08:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i57qo-0007nF-MW
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 08:23:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57174)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i57qk-0007lC-W3; Tue, 03 Sep 2019 08:23:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A566FC057F88;
 Tue,  3 Sep 2019 12:23:53 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B0D25D6B7;
 Tue,  3 Sep 2019 12:23:43 +0000 (UTC)
To: Peter Xu <peterx@redhat.com>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-11-eric.auger@redhat.com>
 <20190819120815.GD13560@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <96d99b72-0b6b-f9f5-e62a-03e1edf62d11@redhat.com>
Date: Tue, 3 Sep 2019 14:23:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190819120815.GD13560@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 03 Sep 2019 12:23:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 v10 10/15] virtio-iommu: Implement
 probe request
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 tn@semihalf.com, qemu-devel@nongnu.org, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, jean-philippe@linaro.org, bharat.bhushan@nxp.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 8/19/19 2:08 PM, Peter Xu wrote:
> On Tue, Jul 30, 2019 at 07:21:32PM +0200, Eric Auger wrote:
> 
> [...]
> 
>> +/* Fill the properties[] buffer with properties of type @type */
>> +static int virtio_iommu_fill_property(int type,
>> +                                      viommu_property_buffer *bufstate)
>> +{
>> +    int ret = -ENOSPC;
>> +
>> +    if (bufstate->filled + sizeof(struct virtio_iommu_probe_property)
>> +            >= VIOMMU_PROBE_SIZE) {
>> +        /* no space left for the header */
>> +        bufstate->error = true;
>> +        goto out;
>> +    }
>> +
>> +    switch (type) {
>> +    case VIRTIO_IOMMU_PROBE_T_NONE:
>> +        ret = virtio_iommu_fill_none_prop(bufstate);
>> +        break;
>> +    case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
>> +    {
>> +        viommu_endpoint *ep = bufstate->endpoint;
>> +
>> +        g_tree_foreach(ep->reserved_regions,
>> +                       virtio_iommu_fill_resv_mem_prop,
>> +                       bufstate);
>> +        if (!bufstate->error) {
>> +            ret = 0;
>> +        }
>> +        break;
>> +    }
>> +    default:
>> +        ret = -ENOENT;
>> +        break;
>> +    }
>> +out:
>> +    if (ret) {
>> +        error_report("%s property of type=%d could not be filled (%d),"
>> +                     " remaining size = 0x%lx",
>> +                     __func__, type, ret, bufstate->filled);
> 
> Nit: If this can really be triggered then we might still change it to
> error_report_once()?  If it's not (which it seems to), maybe assert
> directly?
I put error_report_once() at the moment. The reserved regions may be
passed through cfg or device properties. I think it may happen that
their size get larger than the size set in the device config.


> 
> Other than that it looks good to me:
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>

Thank you for the review!

Best Regards

Eric
> 
> Regards,
> 

