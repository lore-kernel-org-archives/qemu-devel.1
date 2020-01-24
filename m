Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A060C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 15:03:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E25B020704
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 15:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E25B020704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv0UB-00059e-11
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 10:03:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <salil.mehta@huawei.com>) id 1iv0TS-0004kH-6f
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 10:02:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <salil.mehta@huawei.com>) id 1iv0TQ-0005Hx-Ub
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 10:02:18 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2064 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <salil.mehta@huawei.com>)
 id 1iv0TO-0005ET-4Q; Fri, 24 Jan 2020 10:02:14 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 47B7F6D3AF6BD62E247B;
 Fri, 24 Jan 2020 15:02:11 +0000 (GMT)
Received: from lhreml701-chm.china.huawei.com (10.201.108.50) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 24 Jan 2020 15:02:10 +0000
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 lhreml701-chm.china.huawei.com (10.201.108.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Fri, 24 Jan 2020 15:02:10 +0000
Received: from lhreml703-chm.china.huawei.com ([10.201.68.198]) by
 lhreml703-chm.china.huawei.com ([10.201.68.198]) with mapi id 15.01.1713.004; 
 Fri, 24 Jan 2020 15:02:10 +0000
From: Salil Mehta <salil.mehta@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: RE: [Question] Regarding containers "unattached/peripheral/anonymous"
 - their relation with hot(un)plug of devices
Thread-Topic: [Question] Regarding containers
 "unattached/peripheral/anonymous" - their relation with hot(un)plug of
 devices
Thread-Index: AdXSpuyfn6DVS59zTi+rGkiX0i4oLAAFtBwAAADWJeA=
Date: Fri, 24 Jan 2020 15:02:10 +0000
Message-ID: <77dbc712482545078986adcd72567630@huawei.com>
References: <70446b6cbf5442488a40fe809f38c3c8@huawei.com>
 <20200124145404.1d15209e@redhat.com>
In-Reply-To: <20200124145404.1d15209e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.226.53]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 185.176.76.210
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
Cc: "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, pbonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: Friday, January 24, 2020 1:54 PM
> To: Salil Mehta <salil.mehta@huawei.com>
>=20
> On Fri, 24 Jan 2020 11:20:15 +0000
> Salil Mehta <salil.mehta@huawei.com> wrote:
>=20
> > Hello,
> > I am working on vCPU Hotplug feature for ARM64 and I am in mid of under=
standing
> > some aspect of device_add/device_del interface of the QEMU.
> >
> > Observations:
> > 1. Any object initialised by qmp_device_add() gets into /machine/unatta=
ched
> > container. I traced the flow to code leg inside  device_set_realized()
> > 2. I could see the reverse qmp_device_del() expects the device to be in
> > /machine/peripheral container.
> > 3. I could see any object initially added to unattached container did n=
ot had
> > their parents until object_add_property_child() was called further in t=
he leg.
> > which effectively meant a new property was created and property table
> > populated and child was parented.
> > 4. Generally, container  /machine/peripheral was being used wherever
> > DEVICE(dev)->id was present and non-null.
> >
> > Question:
> > 1. Wanted to confirm my understanding about the use of having separate
> > containers like unattached, peripheral and anonymous.
>=20
> > 2. At init time all the vcpus goes under *unattached* container. Now,
> > qmp_device_del() cannot be used to unplug them. I am wondering
>=20
> device is put into 'unattached' in case it wasn't assigned a parent.
> Usually it happens when board creates device directly.


Sure, but if we decide that certain number(N) of vcpus are hotplugabble
and certain subset of N (say 'n' < 'N') should be allowed to be present
or cold-plugged at the init time then I wonder which of the following
is correct approach:

1. Bring all of N vcpus at boot time under "peripheral" container
                                   OR
2. Just bring subset 'n' of 'N' under "peripheral" container and rest
    under "unattached" container? And later as and when rest of the
    vcpus are hotplugged they should be transferred from "unattached"
    container to "peripheral" container?


> >    if all the hotplug devices need to go under the *peripheral* contain=
er while
> > they are hotplugged and during object init time as well?
>=20
> theoretically device_del may use QOM path (the later users can get with
> query-hotpluggable-cpus),
> but I think it's mostly debugging feature.


Sure.


> users are supposed to specify 'id' during -device/device_add if they are =
going
> to manage that device.
> afterwards (like unplugging it). Then they could use that 'id' in other c=
ommands
> (including device_del)
>=20
> So 'id'-ed devices end up in 'peripheral' container.


Sure, what if hotplugged device is removed and then added again? It looks=20
qmp_device_add() interface will again end up calling the device_set_realize=
d()
which eventually would put hotplugged devices under "unattached" container?


> > 3. I could not see any device being place under *anonymous* container d=
uring
> init time. What is the use of this container?
>=20
> if I recall it right, devices created with help of device_add but without=
 'id'
> go to this container


Any examples on top of your head where such an interface might be of use?


Many thanks
Salil.



