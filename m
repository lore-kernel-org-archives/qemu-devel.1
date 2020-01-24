Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78276C32771
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 11:21:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5137220702
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 11:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5137220702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iux1K-0005RD-Gl
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 06:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <salil.mehta@huawei.com>) id 1iux0k-00052E-Lp
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 06:20:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <salil.mehta@huawei.com>) id 1iux0i-0002db-Je
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 06:20:25 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2063 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <salil.mehta@huawei.com>)
 id 1iux0h-0002Sf-CE
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 06:20:23 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id 1C70AA7C730A7E265E29;
 Fri, 24 Jan 2020 11:20:16 +0000 (GMT)
Received: from lhreml704-chm.china.huawei.com (10.201.108.53) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 24 Jan 2020 11:20:15 +0000
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 lhreml704-chm.china.huawei.com (10.201.108.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Fri, 24 Jan 2020 11:20:15 +0000
Received: from lhreml703-chm.china.huawei.com ([10.201.68.198]) by
 lhreml703-chm.china.huawei.com ([10.201.68.198]) with mapi id 15.01.1713.004; 
 Fri, 24 Jan 2020 11:20:15 +0000
From: Salil Mehta <salil.mehta@huawei.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [Question] Regarding containers "unattached/peripheral/anonymous" -
 their relation with hot(un)plug of devices
Thread-Topic: [Question] Regarding containers
 "unattached/peripheral/anonymous" - their relation with hot(un)plug of
 devices
Thread-Index: AdXSpuyfn6DVS59zTi+rGkiX0i4oLA==
Date: Fri, 24 Jan 2020 11:20:15 +0000
Message-ID: <70446b6cbf5442488a40fe809f38c3c8@huawei.com>
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
Cc: pbonzini <pbonzini@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,
I am working on vCPU Hotplug feature for ARM64 and I am in mid of understan=
ding some aspect of device_add/device_del interface of the QEMU.

Observations:
1. Any object initialised by qmp_device_add() gets into /machine/unattached=
 container. I traced the flow to code leg inside  device_set_realized()
2. I could see the reverse qmp_device_del() expects the device to be in  /m=
achine/peripheral container.
3. I could see any object initially added to unattached container did not h=
ad their parents until object_add_property_child() was called further in th=
e leg.
    which effectively meant a new property was created and property table p=
opulated and child was parented.
4. Generally, container  /machine/peripheral was being used wherever DEVICE=
(dev)->id was present and non-null.

Question:
1. Wanted to confirm my understanding about the use of having separate cont=
ainers like unattached, peripheral and anonymous.
2. At init time all the vcpus goes under *unattached* container. Now, qmp_d=
evice_del() cannot be used to unplug them. I am wondering
   if all the hotplug devices need to go under the *peripheral* container w=
hile they are hotplugged and during object init time as well?
3. I could not see any device being place under *anonymous* container durin=
g init time. What is the use of this container?

I would be thankful for your valuable insights and answers and help in high=
lighting any gap in my understanding.

Thanks in anticipation!

Best Regards
Salil

