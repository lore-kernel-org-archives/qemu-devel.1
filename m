Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1F9C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:20:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BAEA20838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVECPz3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BAEA20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j00kn-0004oL-BQ
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 05:20:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j00jh-0002nm-Id
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:19:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j00jf-0003zm-F9
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:19:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52791
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j00jf-0003xh-Bo
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:19:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581070783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZBrn9SGNO71zqqFpslql7PX6hoM1RQldG9GD7Gqg1jk=;
 b=iVECPz3XPwlsnelUsaAnq9rP0C/h9Tw916Doa6tmYpdhky4/Qo23d66TLkXfjsGCVQKzK/
 hL9f/au51fHfliKAIa3NYfKh2C99Kmxm9N8883TN3Utz7l28ep5eD+DfbVAx3PVPwaQQm/
 Ab/h5ykpW0ChJeowcOp2b36Cu3khgE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-qKpaNl-HNJCNNo9nQwKAeA-1; Fri, 07 Feb 2020 05:19:41 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A09CDB60;
 Fri,  7 Feb 2020 10:19:38 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E23B863AB;
 Fri,  7 Feb 2020 10:19:28 +0000 (UTC)
Subject: Re: [PATCH v14 08/11] virtio-iommu-pci: Introduce the x-dt-binding
 option
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20200207093203.3788-1-eric.auger@redhat.com>
 <20200207093203.3788-9-eric.auger@redhat.com>
 <20200207100540.GA1999431@myrica>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <cec24814-2192-1e8f-495b-e57f5548df9e@redhat.com>
Date: Fri, 7 Feb 2020 11:19:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200207100540.GA1999431@myrica>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: qKpaNl-HNJCNNo9nQwKAeA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 mst@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jean,

On 2/7/20 11:05 AM, Jean-Philippe Brucker wrote:
> Hi Eric,
> 
> On Fri, Feb 07, 2020 at 10:32:00AM +0100, Eric Auger wrote:
>> At the moment, the kernel only supports device tree
>> integration of the virtio-iommu. DT bindings between the
>> PCI root complex and the IOMMU must be created by the machine
>> in conformance to:
>>
>> Documentation/devicetree/bindings/virtio/iommu.txt.
>>
>> To make sure the end-user is aware of this, force him to use the
>> temporary device option "x-dt-binding" and also double check the
>> machine has a hotplug handler for the virtio-iommu-pci device.
>> This hotplug handler is in charge of creating those DT bindings.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> [...]
>> @@ -39,6 +42,21 @@ static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>>      VirtIOIOMMUPCI *dev = VIRTIO_IOMMU_PCI(vpci_dev);
>>      DeviceState *vdev = DEVICE(&dev->vdev);
>>  
>> +    if (!dev->dt_binding) {
>> +        error_setg(errp,
>> +                   "Instantiation currently only is possible if the machine "
>> +                   "creates device tree iommu-map bindings, ie. ACPI is not "
>> +                   "yet supported");
>> +        error_append_hint(errp, "use -virtio-iommu-pci,x-dt-binding\n");
> 
> "use -device virtio-iommu-pci,x-dt-binding"?
> 
> Can the option be safely removed as soon as we implement a topology
> description for the remaining platforms?  Or will we need to carry it
> forever for backward-compatibility (ie. ensure that an old command-line
> invocation that contains this option still works)?

"x-" properties are experimental so yes it is bound to be removed as
soon as we get the topology description feature.

I now have to figure out how to fix the make-check issue it introduces :-(

Thanks

Eric
> 
> Thanks,
> Jean
> 


