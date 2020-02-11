Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6B9C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0914820870
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJlysz7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0914820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ZP3-0002Vt-8K
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 12:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j1ZNz-0001h0-D5
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j1ZNw-0001Zp-AY
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:31:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56399
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j1ZNu-0001WR-Gj
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581442301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KIG2jWNZvHfn1cjKvDlDX4wdBlCaBbkHWqDYpEE/6ns=;
 b=NJlysz7ZT/hzhhSdLkMMjmbCXT27o8GO1W0/k1L9TipEhvUkff0DpIaYVnKC/A71BMDzk8
 VxUcbwioZCX7Tog0WDpgmElMNKyv0y03sEvsKMwXJJWzCRpSUw39WCkddyVyQZp+K//jhB
 ywJt15oewjPst/FxeWZFHCqxqPNWrhM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-NQZSC5K5NZyQRz1_OJwEKQ-1; Tue, 11 Feb 2020 12:31:37 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 139E618C43EE;
 Tue, 11 Feb 2020 17:31:36 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2B4F90092;
 Tue, 11 Feb 2020 17:31:20 +0000 (UTC)
Subject: Re: [PATCH v15 8/9] hw/arm/virt: Add the virtio-iommu device tree
 mappings
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200208120022.1920-1-eric.auger@redhat.com>
 <20200208120022.1920-9-eric.auger@redhat.com>
 <CAFEAcA-n97LKaQo9haLdEv+c7k8QkK=LegP_gORr9z4WrBU2Ww@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <5e4549f4-44c3-6a2c-a270-4923db8b455e@redhat.com>
Date: Tue, 11 Feb 2020 18:31:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-n97LKaQo9haLdEv+c7k8QkK=LegP_gORr9z4WrBU2Ww@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: NQZSC5K5NZyQRz1_OJwEKQ-1
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
Cc: jean-philippe@linaro.org, "Tian, Kevin" <kevin.tian@intel.com>,
 tnowicki@marvell.com, Juan Quintela <quintela@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 bharatb.linux@gmail.com, qemu-arm <qemu-arm@nongnu.org>,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 2/11/20 4:00 PM, Peter Maydell wrote:
> On Sat, 8 Feb 2020 at 12:01, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> Adds the "virtio,pci-iommu" node in the host bridge node and
>> the RID mapping, excluding the IOMMU RID.
>>
>> This is done in the virtio-iommu-pci hotplug handler which
>> gets called only if no firmware is loaded or if -no-acpi is
>> passed on the command line. As non DT integration is
>> not yet supported by the kernel we must make sure we
>> are in DT mode. This limitation will be removed as soon
>> as the topology description feature gets supported.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> +static void create_virtio_iommu(VirtMachineState *vms, Error **errp)
>> +{
>> +    const char compat[] = "virtio,pci-iommu";
>> +    uint16_t bdf = vms->virtio_iommu_bdf;
>> +    char *node;
>> +
>> +    vms->iommu_phandle = qemu_fdt_alloc_phandle(vms->fdt);
>> +
>> +    node = g_strdup_printf("%s/virtio_iommu@%d", vms->pciehb_nodename, bdf);
>> +    qemu_fdt_add_subnode(vms->fdt, node);
>> +    qemu_fdt_setprop(vms->fdt, node, "compatible", compat, sizeof(compat));
>> +    qemu_fdt_setprop_sized_cells(vms->fdt, node, "reg",
>> +                                 1, bdf << 8, 1, 0, 1, 0,
>> +                                 1, 0, 1, 0);
>> +
>> +    qemu_fdt_setprop_cell(vms->fdt, node, "#iommu-cells", 1);
>> +    qemu_fdt_setprop_cell(vms->fdt, node, "phandle", vms->iommu_phandle);
>> +    g_free(node);
>> +
>> +    qemu_fdt_setprop_cells(vms->fdt, vms->pciehb_nodename, "iommu-map",
>> +                           0x0, vms->iommu_phandle, 0x0, bdf,
>> +                           bdf + 1, vms->iommu_phandle, bdf + 1, 0xffff - bdf);
>> +}
> 
> This function name implies that we're creating the IOMMU device
> here (which would be a weird thing to do in a hotplug callback
> for some other device), but it looks like we're only adding
> device tree nodes ?
yes the actual iommu device is created through the -device option. I can
rename into create_iommu_dt_bindings
> 
> Given that we write the FDT blob into the guest RAM on bootup,
> how does making changes to it here on hotplug (which I assume
> to be 'after boot, whenever the user hot-plugs something') work?

the virtio-iommu is not supposed to be hotplugged but rather
cold-plugged. I use this hotplug mechanism to detect its presence and
add the related dt mappings. Maybe I can add a check to detect if the
bootup is over?

Thoughts?

Eric
> 
> thanks
> -- PMM
> 


