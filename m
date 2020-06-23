Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B66C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473AF20738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473AF20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnfc9-0002vO-JR
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 05:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jnfbY-0002ON-Ix; Tue, 23 Jun 2020 05:52:36 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2116 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jnfbV-0003D6-Rx; Tue, 23 Jun 2020 05:52:36 -0400
Received: from lhreml706-chm.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 08B246F5EAE537DE9D22;
 Tue, 23 Jun 2020 10:52:28 +0100 (IST)
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 lhreml706-chm.china.huawei.com (10.201.108.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 23 Jun 2020 10:52:27 +0100
Received: from lhreml703-chm.china.huawei.com ([10.201.68.198]) by
 lhreml703-chm.china.huawei.com ([10.201.68.198]) with mapi id 15.01.1913.007; 
 Tue, 23 Jun 2020 10:52:27 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: Andrew Jones <drjones@redhat.com>
Subject: RE: [PATCH RFC 07/22] arm/cpuhp: Init PMU at host for all possible
 vcpus
Thread-Topic: [PATCH RFC 07/22] arm/cpuhp: Init PMU at host for all possible
 vcpus
Thread-Index: AQHWQcvlALxTosOEL0WOmckyuAuHIajl5TGAgAAdZoA=
Date: Tue, 23 Jun 2020 09:52:27 +0000
Message-ID: <0d8b94575a884f56b60524632ad63586@huawei.com>
References: <20200613213629.21984-1-salil.mehta@huawei.com>
 <20200613213629.21984-8-salil.mehta@huawei.com>
 <20200623090043.fwf7h6zmprc3oug4@kamzik.brq.redhat.com>
In-Reply-To: <20200623090043.fwf7h6zmprc3oug4@kamzik.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.79.3]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.76.210;
 envelope-from=salil.mehta@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 05:40:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mehta.salil.lnk@gmail.com" <mehta.salil.lnk@gmail.com>,
 "gshan@redhat.com" <gshan@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maz@kernel.org" <maz@kernel.org>, "david@redhat.com" <david@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "will@kernel.org" <will@kernel.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "maran.wilson@oracle.com" <maran.wilson@oracle.com>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng \(C\)" <wangxiongfeng2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Andrew Jones [mailto:drjones@redhat.com]
> Sent: Tuesday, June 23, 2020 10:01 AM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; peter.maydell@linaro.org;
> sudeep.holla@arm.com; gshan@redhat.com; mst@redhat.com; jiakernel2@gmail.=
com;
> maz@kernel.org; zhukeqian <zhukeqian1@huawei.com>; david@redhat.com;
> richard.henderson@linaro.org; Linuxarm <linuxarm@huawei.com>;
> eric.auger@redhat.com; james.morse@arm.com; catalin.marinas@arm.com;
> imammedo@redhat.com; pbonzini@redhat.com; mehta.salil.lnk@gmail.com;
> maran.wilson@oracle.com; will@kernel.org; wangxiongfeng (C)
> <wangxiongfeng2@huawei.com>
> Subject: Re: [PATCH RFC 07/22] arm/cpuhp: Init PMU at host for all possib=
le vcpus
>=20
> On Sat, Jun 13, 2020 at 10:36:14PM +0100, Salil Mehta wrote:
> > PMU for all possible vcpus must be initialized at the virt machine
> > initialization time. This patch refactors existing code to accomodate p=
ossible
> > vcpus. This also assumes that all processor being used are identical at=
 least
> > for now but does not affect the normal scanarios where they might not b=
e in
> > future. This assumption only affects the future hotplug scenarios if ev=
er there
> > exists any hetergenous processors. In such a case PMU might not be enab=
led
> on
> > some vcpus. Is it acceptable and doable tradeoff for now?
> >
> > This perhaps needs more discussion. please check below link,
> > Link: https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00131.ht=
ml
> >
> > Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > ---
> >  hw/arm/virt.c         | 51 ++++++++++++++++++++++++++++++-------------
> >  include/hw/arm/virt.h |  1 +
> >  2 files changed, 37 insertions(+), 15 deletions(-)
> >
>=20
> I have a similar patch to this one in my steal-time dev branch that I jus=
t
> started last week. I'm creating a new function that must be called after
> cpu realization and gic creation that completes cpu setup. There's a few
> things that will end up there (including steal-time stuff).

ok.=20

>=20
> Thanks,
> drew


