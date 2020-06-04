Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3892DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE638206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE638206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgnkg-0001rh-5q
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 07:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jgnk7-0001Kr-Pz; Thu, 04 Jun 2020 07:09:03 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2108 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jgnk6-0005Wb-GC; Thu, 04 Jun 2020 07:09:03 -0400
Received: from lhreml709-chm.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 2540E5A64331AD41AF6C;
 Thu,  4 Jun 2020 12:08:53 +0100 (IST)
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 lhreml709-chm.china.huawei.com (10.201.108.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 4 Jun 2020 12:08:52 +0100
Received: from lhreml703-chm.china.huawei.com ([10.201.68.198]) by
 lhreml703-chm.china.huawei.com ([10.201.68.198]) with mapi id 15.01.1913.007; 
 Thu, 4 Jun 2020 12:08:52 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: RE: [Question] Regarding containers "unattached/peripheral/anonymous"
 - their relation with hot(un)plug of devices
Thread-Topic: [Question] Regarding containers
 "unattached/peripheral/anonymous" - their relation with hot(un)plug of
 devices
Thread-Index: AdXSpuyfn6DVS59zTi+rGkiX0i4oLAAFtBwAAADWJeAAA8wjgAACyCnAAJHlbgAAZ8bfMBji6o4AAARuM+A=
Date: Thu, 4 Jun 2020 11:08:52 +0000
Message-ID: <207c66e7e2224e9888973ed5ba1fcfb4@huawei.com>
References: <70446b6cbf5442488a40fe809f38c3c8@huawei.com>
 <20200124145404.1d15209e@redhat.com>
 <77dbc712482545078986adcd72567630@huawei.com>
 <20200124170645.3d794ac6@redhat.com>
 <b8fccc99d7344b2485c0db76886af9c8@huawei.com>
 <20200127160352.54f95875@redhat.com>
 <ab94a6dec7b9435cbb36ca9d488a0daa@huawei.com>
 <20200604115430.029c488a@redhat.com>
In-Reply-To: <20200604115430.029c488a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.68.203]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.76.210;
 envelope-from=salil.mehta@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 07:08:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrew Jones <drjones@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, pbonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: Thursday, June 4, 2020 10:55 AM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: Andrew Jones <drjones@redhat.com>; gshan@redhat.com; mst@redhat.com;
> qemu-devel@nongnu.org; eric.auger@redhat.com; qemu-arm@nongnu.org; pbonzi=
ni
> <pbonzini@redhat.com>
> Subject: Re: [Question] Regarding containers "unattached/peripheral/anony=
mous"
> - their relation with hot(un)plug of devices
>=20
> On Wed, 3 Jun 2020 15:13:26 +0000
> Salil Mehta <salil.mehta@huawei.com> wrote:
>=20

[...]

> >
> > I am not sure why you said "including cold-plugged one"? I hope by
> > cold-plug'ging you mean here are the CPUs which already exist at
> > the boot time of the Guest VM and plugged using -device?
>=20
> yes, it's about a plugged one with  '-device'


Sure, thank you.

Salil.

