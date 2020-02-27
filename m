Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753A6C3F364
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4446721D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pp/EYpj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4446721D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7JYQ-0001xM-GY
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:50:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j7JXg-0001CL-1j
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:49:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j7JXe-000051-PA
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:49:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47198
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j7JXe-0008WJ-Lz
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582811370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1hYv2W5oVXano1ZG8azGgIHJRbr+8/TKjUIu0Hge0mU=;
 b=Pp/EYpj49mEsCuy3dY+aLT2ep9HnBR7menjw/vwxxzB83RjOiNMKriPS7PVceVNaQUClo7
 xiYKhfBKVoadwwUcR45Ylnm4wsXiHGlNvupWmp5Ccj5eyPkYf8ntYRM0Z7kbOuE6RQB3TJ
 nxojP3Mt2bsv2mXE4EAFYGnmwMp48vo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-H0W1fCkDNlKPnyEZqHdjOw-1; Thu, 27 Feb 2020 08:49:22 -0500
X-MC-Unique: H0W1fCkDNlKPnyEZqHdjOw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C2AB8010C7;
 Thu, 27 Feb 2020 13:49:20 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5356C92981;
 Thu, 27 Feb 2020 13:49:12 +0000 (UTC)
Subject: Re: [PATCH v16 00/10] VIRTIO-IOMMU device
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200214132745.23392-1-eric.auger@redhat.com>
 <20200227111717.GG1645630@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <431cb39d-833c-6d02-d7b3-02b3e90446e2@redhat.com>
Date: Thu, 27 Feb 2020 14:49:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200227111717.GG1645630@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
 quintela@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Daniel,

On 2/27/20 12:17 PM, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Feb 14, 2020 at 02:27:35PM +0100, Eric Auger wrote:
>> This series implements the QEMU virtio-iommu device.
>>
>> This matches the v0.12 spec (voted) and the corresponding
>> virtio-iommu driver upstreamed in 5.3. All kernel dependencies
>> are resolved for DT integration. The virtio-iommu can be
>> instantiated in ARM virt using:
>>
>> "-device virtio-iommu-pci".
>=20
> Is there any more documentation besides this ?

not yet in qemu.
>=20
> I'm wondering on the intended usage of this, and its relation
> or pros/cons vs other iommu devices

Maybe if you want to catch up on the topic, looking at the very first
kernel RFC may be a good starting point. Motivation, pros & cons were
discussed in that thread (hey, April 2017!)
https://lists.linuxfoundation.org/pipermail/iommu/2017-April/021217.html

on ARM we have SMMUv3 emulation. But the VFIO integration is not
possible because SMMU does not have any "caching mode" and my nested
paging kernel series is blocked. So the only solution to integrate with
VFIO is looming virtio-iommu.

In general the pros that were put forward are: virtio-iommu is
architecture agnostic, removes the burden to accurately model complex
device states, driver can support virtualization specific optimizations
without being constrained by production driver maintenance. Cons is perf
and mem footprint if we do not consider any optimization.

You can have a look at

http://events17.linuxfoundation.org/sites/events/files/slides/viommu_arm.pd=
f

>=20
> You mention Arm here, but can this virtio-iommu-pci be used on
> ppc64, s390x, x86_64 too ?=20

Not Yet. At the moment we are stuck with the non DT integration at
kernel level. We can instantiate the device in machvirt with DT boot only.

Work is ongoing on kernel, by Jean-Philippe to support non DT integration:

[1] [PATCH 0/3] virtio-iommu on non-devicetree platforms
(https://www.spinics.net/lists/linux-virtualization/msg41391.html)

This does nor rely on ACPI anymore.

Originally the plan was to integrate with ACPI (IORT) but Michael pushed
to pass the binding info between the protected devices and the IOMMU
through the PCI cfg space. Also this could serve environments where we
do not have ACPI. I think some people are reluctant to expose the
virtio-iommu in the [IORT] ACPI table.

But definitively the end goal is to support the virtio-iommu for other
archs. Integration with x86 is already working based on IORT or [1].


 If so, is it a better choice than
> using intel-iommu on x86_64?
Anything else that is relevant
> for management applications to know about when using this ?

I think We are still at the early stage and this would be premature even
if feasible.

Hope it helps

Thanks

Eric
>=20
>=20
> Regards,
> Daniel
>=20


