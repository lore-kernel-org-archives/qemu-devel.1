Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39083C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F162082E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FS1wLAf2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F162082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j00yT-0004QB-62
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 05:35:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j00ww-0002nr-3M
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:33:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j00wu-0005JN-Kn
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:33:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30376
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j00wu-0005Ie-GG
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581071604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ozIjojcK3lm7pcb+VZNtYHYXa6itwsLNePmJfCbfq5c=;
 b=FS1wLAf2gZQxkhnktqDbZZVji5fUf8hDXAx48CmO0Mz/udN1LkxJnXr6dTEyiFQh81tt/N
 dvJUYXQTJvck91LVxYZYUlBNkbP0ng+9Rv1AJGn/0TuTVAX1xPiFot0FRQV/clZjrj1f6N
 12gz65E4lDZSgPM1yG4SHcDs3VKR6M0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-K7RYvPHEOgeDwqMqqmr7Xw-1; Fri, 07 Feb 2020 05:33:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCD81100551A;
 Fri,  7 Feb 2020 10:33:18 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 100DD87B1C;
 Fri,  7 Feb 2020 10:33:08 +0000 (UTC)
Subject: Re: [PATCH v14 08/11] virtio-iommu-pci: Introduce the x-dt-binding
 option
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20200207093203.3788-1-eric.auger@redhat.com>
 <20200207093203.3788-9-eric.auger@redhat.com>
 <20200207100540.GA1999431@myrica>
 <20200207052405-mutt-send-email-mst@kernel.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <bc48f14c-5be1-194b-b057-fbac121b2718@redhat.com>
Date: Fri, 7 Feb 2020 11:33:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200207052405-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: K7RYvPHEOgeDwqMqqmr7Xw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On 2/7/20 11:24 AM, Michael S. Tsirkin wrote:
> On Fri, Feb 07, 2020 at 11:05:40AM +0100, Jean-Philippe Brucker wrote:
>> Hi Eric,
>>
>> On Fri, Feb 07, 2020 at 10:32:00AM +0100, Eric Auger wrote:
>>> At the moment, the kernel only supports device tree
>>> integration of the virtio-iommu. DT bindings between the
>>> PCI root complex and the IOMMU must be created by the machine
>>> in conformance to:
>>>
>>> Documentation/devicetree/bindings/virtio/iommu.txt.
>>>
>>> To make sure the end-user is aware of this, force him to use the
>>> temporary device option "x-dt-binding" and also double check the
>>> machine has a hotplug handler for the virtio-iommu-pci device.
>>> This hotplug handler is in charge of creating those DT bindings.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> [...]
>>> @@ -39,6 +42,21 @@ static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>>>      VirtIOIOMMUPCI *dev = VIRTIO_IOMMU_PCI(vpci_dev);
>>>      DeviceState *vdev = DEVICE(&dev->vdev);
>>>  
>>> +    if (!dev->dt_binding) {
>>> +        error_setg(errp,
>>> +                   "Instantiation currently only is possible if the machine "
>>> +                   "creates device tree iommu-map bindings, ie. ACPI is not "
>>> +                   "yet supported");
>>> +        error_append_hint(errp, "use -virtio-iommu-pci,x-dt-binding\n");
>>
>> "use -device virtio-iommu-pci,x-dt-binding"?
>>
>> Can the option be safely removed as soon as we implement a topology
>> description for the remaining platforms?  Or will we need to carry it
>> forever for backward-compatibility (ie. ensure that an old command-line
>> invocation that contains this option still works)?
>>
>> Thanks,
>> Jean
> 
> I'd worry that if we actually document it then users will come to
> depend on it for sure, even though it starts with x-.

Let's rephrase my previous answer. Once we get the topology description
feature we can leave the x-dt-binding property supported but do not test
it anymore and document it at deprecated?

Thanks

Eric
> 


