Return-Path: <SRS0=i/12=ZI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10454C432C3
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 00:59:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F64206D5
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 00:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F64206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVmRI-0000np-1r
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 19:59:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gengdongjiu@huawei.com>) id 1iVmQf-0000GM-5x
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 19:59:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gengdongjiu@huawei.com>) id 1iVmQe-0001wM-1Z
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 19:59:08 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2051 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
 id 1iVmQb-0001uK-OA; Fri, 15 Nov 2019 19:59:05 -0500
Received: from lhreml708-cah.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id 2BCFE9E064E08B3D09D5;
 Sat, 16 Nov 2019 00:59:02 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml708-cah.china.huawei.com (10.201.108.49) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 16 Nov 2019 00:59:01 +0000
Received: from dggeme755-chm.china.huawei.com (10.3.19.101) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1713.5; Sat, 16 Nov 2019 00:59:00 +0000
Received: from dggeme755-chm.china.huawei.com ([10.7.64.71]) by
 dggeme755-chm.china.huawei.com ([10.7.64.71]) with mapi id 15.01.1713.004;
 Sat, 16 Nov 2019 08:58:58 +0800
From: gengdongjiu <gengdongjiu@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [RESEND PATCH v21 3/6] ACPI: Add APEI GHES table generation
 support
Thread-Topic: [RESEND PATCH v21 3/6] ACPI: Add APEI GHES table generation
 support
Thread-Index: AdWbyMkE/1gyxkpeREeYn2g+7NgH+g==
Date: Sat, 16 Nov 2019 00:58:58 +0000
Message-ID: <99a06454b0fa4eac9116af9ec978aaea@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.148.208.123]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Wanghaibin \(D\)" <wanghaibin.wang@huawei.com>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "zhengxiang \(A\)" <zhengxiang9@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "james.morse@arm.com" <james.morse@arm.com>, "xuwei \(O\)" <xuwei5@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "lersek@redhat.com" <lersek@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> On Fri, 15 Nov 2019 14:32:47 +0000
> gengdongjiu <gengdongjiu@huawei.com> wrote:
>=20
> > > > + */
> > > > +static void acpi_ghes_build_notify(GArray *table, const uint8_t
> > > > +type)
> > >
> > > typically format should be build_WHAT(), so
> > >  build_ghes_hw_error_notification()
> > >
> > > And I'd move this out into its own patch.
> > > this applies to other trivial in-depended sub-tables, that take all d=
ata needed to construct them from supplied arguments.
> >
> > I very used your suggested method in previous series[1], but other
> > maintainer suggested to move this function to this file, because he
> > think only GHES used it
>=20
> Using this file is ok, what I've meant for you to split function from thi=
s patch into a separate smaller patch.
>=20
> With the way code split now I have to review 2 big complex patches at the=
 same which makes reviewing hard and I have a hard time
> convincing myself that code it correct.
>=20
> Moving small self-contained chunks of code in to separate smaller patches=
 makes review easier.

Ok, got it. Thanks very much for the explanations

