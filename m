Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE772C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 13:06:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8481422CF8
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 13:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8481422CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2xeG-0006O5-H3
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 09:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i2xYY-0003jI-LH
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 09:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i2xYW-0003Af-F7
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 09:00:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i2xYW-000398-7f
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 09:00:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 77595881347;
 Wed, 28 Aug 2019 13:00:06 +0000 (UTC)
Received: from [10.36.116.105] (ovpn-116-105.ams2.redhat.com [10.36.116.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCE641001944;
 Wed, 28 Aug 2019 12:59:46 +0000 (UTC)
To: Jason Wang <jasowang@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org
References: <20190812074531.28970-1-peterx@redhat.com>
 <319f1d6a-ef55-cc1b-98d6-f99b365bd88a@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e128decc-8b40-160e-fe8e-673682530750@redhat.com>
Date: Wed, 28 Aug 2019 14:59:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <319f1d6a-ef55-cc1b-98d6-f99b365bd88a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Wed, 28 Aug 2019 13:00:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH RFC 0/4] intel_iommu: Do sanity check of
 vfio-pci earlier
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Bandan Das <bsd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 8/13/19 10:41 AM, Jason Wang wrote:
>=20
> On 2019/8/12 =E4=B8=8B=E5=8D=883:45, Peter Xu wrote:
>> This is a RFC series.
>>
>> The VT-d code has some defects, one of them is that we cannot detect
>> the misuse of vIOMMU and vfio-pci early enough.
>>
>> For example, logically this is not allowed:
>>
>> =C2=A0=C2=A0 -device intel-iommu,caching-mode=3Doff \
>> =C2=A0=C2=A0 -device vfio-pci,host=3D05:00.0
>>
>> Because the caching mode is required to make vfio-pci devices
>> functional.
>>
>> Previously we did this sanity check in vtd_iommu_notify_flag_changed()
>> as when the memory regions change their attributes.=C2=A0 However that=
's
>> too late in most cases!=C2=A0 Because the memory region layouts will o=
nly
>> change after IOMMU is enabled, and that's in most cases during the
>> guest OS boots.=C2=A0 So when the configuration is wrong, we will only=
 bail
>> out during the guest boots rather than simply telling the user before
>> QEMU starts.
>>
>> The same problem happens on device hotplug, say, when we have this:
>>
>> =C2=A0=C2=A0 -device intel-iommu,caching-mode=3Doff
>>
>> Then we do something like:
>>
>> =C2=A0=C2=A0 (HMP) device_add vfio-pci,host=3D05:00.0,bus=3Dpcie.1
>>
>> If at that time the vIOMMU is enabled in the guest then the QEMU
>> process will simply quit directly due to this hotplug event.=C2=A0 Thi=
s is
>> a bit insane...
>>
>> This series tries to solve above two problems by introducing two
>> sanity checks upon these places separately:
>>
>> =C2=A0=C2=A0 - machine done
>> =C2=A0=C2=A0 - hotplug device
>>
>> This is a bit awkward but I hope this could be better than before.
>> There is of course other solutions like hard-code the check into
>> vfio-pci but I feel it even more unpretty.=C2=A0 I didn't think out an=
y
>> better way to do this, if there is please kindly shout out.
>>
>> Please have a look to see whether this would be acceptable, thanks.
>>
>> Peter Xu (4):
>> =C2=A0=C2=A0 intel_iommu: Sanity check vfio-pci config on machine init=
 done
>> =C2=A0=C2=A0 qdev/machine: Introduce hotplug_allowed hook
>> =C2=A0=C2=A0 pc/q35: Disallow vfio-pci hotplug without VT-d caching mo=
de
>> =C2=A0=C2=A0 intel_iommu: Remove the caching-mode check during flag ch=
ange
>>
>> =C2=A0 hw/core/qdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 17 +++++++++++++++++
>> =C2=A0 hw/i386/intel_iommu.c=C2=A0 | 40 ++++++++++++++++++++++++++++++=
++++------
>> =C2=A0 hw/i386/pc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 21 +++++++++++++++++++++
>> =C2=A0 include/hw/boards.h=C2=A0=C2=A0=C2=A0 |=C2=A0 9 +++++++++
>> =C2=A0 include/hw/qdev-core.h |=C2=A0 1 +
>> =C2=A0 qdev-monitor.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 7 +++++++
>> =C2=A0 6 files changed, 89 insertions(+), 6 deletions(-)
>>
>=20
> Do we need a generic solution other than an Intel specific one?

In
[PATCH v4 2/5] memory: Add IOMMU_ATTR_HW_NESTED_PAGING IOMMU memory
region attribute (https://patchwork.kernel.org/patch/11109701/)

[PATCH v4 3/5] hw/vfio/common: Fail on VFIO/HW nested paging detection
(https://patchwork.kernel.org/patch/11109697/)

I proposed to introduce a new IOMMU MR attribute to retrieve whether the
vIOMMU uses HW nested paging to integrate with VFIO. I wonder whether
this kind of solution would fit your need too.

Assuming we would rename the attribute (whose name is challenged by
Peter anyway) into something like IOMMU_ATTR_PHYS_MAP_MODE
taking the possible values: NONE, CM, HW_NESTED_PAGING. SMMUv3 would
return HW_NESTED_PAGING, Intel IOMMU would return CM if CM is enabled or
NONE in the negative. Then we could implement the check directly in VFIO
common.c. That way I don't think you would need the new notifiers and
this would satisfy both requirements?

Thoughts?

Thanks

Eric

>=20
> Thanks
>=20
>=20

