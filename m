Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B1EC3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 09:42:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5BAA208C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 09:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="byEq3FOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BAA208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j944B-00039L-W9
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 04:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j943G-0002Ms-7L
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 04:41:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j943C-00020G-SY
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 04:41:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37774
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j943C-0001zx-K1
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 04:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583228477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0bZsUZX3JwEsEM0cUl/sPAOimjlcxFt+l8FcLrIa9b8=;
 b=byEq3FOnRMlKHjiER1lBBi9KLRQ21XW1msTZmnvCVifYRSwPMARL6oxaYp2yB33/yoYWXj
 63DoFa3cZgoj/bxJ4V4Pp2VlLNXz8IvA0w3e7gZSfW5YoUK2sihXpP/KJ4YtZbhyWmDh+/
 yoaIpnwRzZrIIITr40Gt8B2B/INOYx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-Ybd9wDgCP4-umTW-7IWIyw-1; Tue, 03 Mar 2020 04:41:13 -0500
X-MC-Unique: Ybd9wDgCP4-umTW-7IWIyw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A6BB13E2;
 Tue,  3 Mar 2020 09:41:11 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 811668D568;
 Tue,  3 Mar 2020 09:41:01 +0000 (UTC)
Subject: Re: [PATCH v16 00/10] VIRTIO-IOMMU device
To: Zhangfei Gao <zhangfei.gao@gmail.com>
References: <20200214132745.23392-1-eric.auger@redhat.com>
 <20200227111717.GG1645630@redhat.com>
 <431cb39d-833c-6d02-d7b3-02b3e90446e2@redhat.com>
 <CAMj5Bkib3CTzCB02ScueFR84r28LGowF7uxYO8Ygmnj9X7oNOg@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <fea625f1-b58e-6da6-8e2a-f32fc9391fc8@redhat.com>
Date: Tue, 3 Mar 2020 10:40:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMj5Bkib3CTzCB02ScueFR84r28LGowF7uxYO8Ygmnj9X7oNOg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kevin.tian@intel.com,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 kenneth-lee-2012@foxmail.com, tnowicki@marvell.com,
 "Michael S. Tsirkin" <mst@redhat.com>, quintela@redhat.com,
 zhangfei.gao@foxmail.com, qemu-devel@nongnu.org, peterx@redhat.com,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 "Wangzhou \(B\)" <wangzhou1@hisilicon.com>, jean-philippe@linaro.org,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Zhangfei,
On 3/3/20 4:23 AM, Zhangfei Gao wrote:
> Hi Eric
>=20
> On Thu, Feb 27, 2020 at 9:50 PM Auger Eric <eric.auger@redhat.com> wrote:
>>
>> Hi Daniel,
>>
>> On 2/27/20 12:17 PM, Daniel P. Berrang=C3=A9 wrote:
>>> On Fri, Feb 14, 2020 at 02:27:35PM +0100, Eric Auger wrote:
>>>> This series implements the QEMU virtio-iommu device.
>>>>
>>>> This matches the v0.12 spec (voted) and the corresponding
>>>> virtio-iommu driver upstreamed in 5.3. All kernel dependencies
>>>> are resolved for DT integration. The virtio-iommu can be
>>>> instantiated in ARM virt using:
>>>>
>>>> "-device virtio-iommu-pci".
>>>
>>> Is there any more documentation besides this ?
>>
>> not yet in qemu.
>>>
>>> I'm wondering on the intended usage of this, and its relation
>>> or pros/cons vs other iommu devices
>>
>> Maybe if you want to catch up on the topic, looking at the very first
>> kernel RFC may be a good starting point. Motivation, pros & cons were
>> discussed in that thread (hey, April 2017!)
>> https://lists.linuxfoundation.org/pipermail/iommu/2017-April/021217.html
>>
>> on ARM we have SMMUv3 emulation. But the VFIO integration is not
>> possible because SMMU does not have any "caching mode" and my nested
>> paging kernel series is blocked. So the only solution to integrate with
>> VFIO is looming virtio-iommu.
>>
>> In general the pros that were put forward are: virtio-iommu is
>> architecture agnostic, removes the burden to accurately model complex
>> device states, driver can support virtualization specific optimizations
>> without being constrained by production driver maintenance. Cons is perf
>> and mem footprint if we do not consider any optimization.
>>
>> You can have a look at
>>
>> http://events17.linuxfoundation.org/sites/events/files/slides/viommu_arm=
.pdf
>>
> Thanks for the patches.
>=20
> Could I ask one question?
> To support vSVA and pasid in guest, which direction you recommend,
> virtio-iommu or vSMMU (your nested paging)
>=20
> Do we still have any obstacles?
you can ask the question but not sure I can answer ;-)

1) SMMUv3 2stage implementation is blocked by Will at kernel level.

Despite this situation I may/can respin as Marvell said they were
interested in this effort. If you are also interested in (I know you
tested it several times and I am grateful to you for that), please reply
to:
[PATCH v9 00/14] SMMUv3 Nested Stage Setup (IOMMU part)
(https://patchwork.kernel.org/cover/11039871/) and say you are
interested in that work so that maintainers are aware there are
potential users.

At the moment I have not supported multiple CDs because it introduced
other dependencies.

2) virtio-iommu

So only virtio-iommu dt boot on machvirt is currently supported. For non
DT, Jean respinned his kernel series
"[PATCH v2 0/3] virtio-iommu on x86 and non-devicetree platforms" as you
may know. However non DT integration still is controversial. Michael is
pushing for putting the binding info the PCI config space. Joerg
yesterday challenged this solution and said he would prefer ACPI
integration. ACPI support depends on ACPI spec update & vote anyway.

To support PASID at virtio-iommu level you also need virtio-iommu API
extensions to be proposed and written + kernel works. So that's a long
road. I will let Jean-Philippe comment on that.

I would just say that Intel is working on nested paging solution with
their emulated intel-iommu. We can help them getting that upstream and
partly benefit from this work.

> Would you mind give some breakdown.
> Jean mentioned PASID still not supported in QEMU.
Do you mean support of multiple CDs in the emulated SMMU? That's a thing
I could implement quite easily. What is more tricky is how to test it.

Thanks

Eric
>=20
> Thanks
>=20


