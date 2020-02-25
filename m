Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB0EC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12E5A20726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E5A20726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aBQ-0006f9-8n
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gengdongjiu@huawei.com>) id 1j6ZgR-00055l-PU
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:51:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gengdongjiu@huawei.com>) id 1j6ZgQ-0000YC-Rq
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:51:31 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2078 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
 id 1j6ZgO-0000UD-BF; Tue, 25 Feb 2020 07:51:28 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 6BD4368E743091D9D629;
 Tue, 25 Feb 2020 12:51:22 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 25 Feb 2020 12:51:21 +0000
Received: from dggeme755-chm.china.huawei.com (10.3.19.101) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1713.5; Tue, 25 Feb 2020 12:51:20 +0000
Received: from dggeme755-chm.china.huawei.com ([10.7.64.71]) by
 dggeme755-chm.china.huawei.com ([10.7.64.71]) with mapi id 15.01.1713.004;
 Tue, 25 Feb 2020 20:51:18 +0800
From: gengdongjiu <gengdongjiu@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH v24 02/10] hw/arm/virt: Introduce a RAS machine option
Thread-Topic: [PATCH v24 02/10] hw/arm/virt: Introduce a RAS machine option
Thread-Index: AdXr2h074nYmm7QuZEuiffKA50KyvQ==
Date: Tue, 25 Feb 2020 12:51:18 +0000
Message-ID: <e1177221d01442c29b03f551a625a7d2@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.185.193]
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
Cc: Fam Zheng <fam@euphon.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 "zhengxiang \(A\)" <zhengxiang9@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>=20
> On Tue, 25 Feb 2020 08:54:07 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>=20
> > On Tue, 25 Feb 2020 at 08:34, Igor Mammedov <imammedo@redhat.com> wrote=
:
> > >
> > > On Mon, 17 Feb 2020 21:12:40 +0800
> > > Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> > >
> > > > RAS Virtualization feature is not supported now, so add a RAS
> > > > machine
> > >
> > > > option and disable it by default.
> > >              ^^^^
> > >
> > > this doesn't match the patch.
> >
> > Hmm? It seems right to me -- the patch adds a machine option and makes
> > it disabled-by-default, doesn't it?
>=20
> Right, I misread 'and' as 'to' somehow.
> My apologies

Thanks Peter and Igor's clarification.

>=20
> >
> > thanks
> > -- PMM
> >


