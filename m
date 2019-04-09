Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF7DC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 10:44:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B512206B7
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 10:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B512206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38953 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDoEp-0007JL-Hl
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 06:44:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hDoE4-0006yH-Qo
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hDoE3-0004oL-T0
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:43:36 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:45388 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hDoE1-0004nR-II; Tue, 09 Apr 2019 06:43:33 -0400
Received: from lhreml708-cah.china.huawei.com (unknown [172.18.7.106])
	by Forcepoint Email with ESMTP id 6A5F8AEE51A49630A611;
	Tue,  9 Apr 2019 11:43:31 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.229]) by
	lhreml708-cah.china.huawei.com ([10.201.108.49]) with mapi id
	14.03.0415.000; Tue, 9 Apr 2019 11:43:25 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH v3 07/10] hw/arm/virt: Introduce opt-in
	feature "fdt"
Thread-Index: AQHU39PgLS6qaIxo3EqaH9uSQe0Wh6YiZMSAgAAFAfCAADi+gIAAAGKAgAALywCABJiAgIABuf+AgAACnwCAATC0gIAAM+4AgAAJpICAAD95YIAHQ2EAgAHMzWA=
Date: Tue, 9 Apr 2019 10:43:25 +0000
Message-ID:
 <5FC3163CFD30C246ABAA99954A238FA83935C5D0@lhreml524-mbs.china.huawei.com>
References: <20190321104745.28068-1-shameerali.kolothum.thodi@huawei.com>
	<20190321104745.28068-8-shameerali.kolothum.thodi@huawei.com>
	<98c7f0fd-8446-8897-0808-e7615af29670@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA83933836A@lhreml524-mbs.china.huawei.com>
	<0dcd3f3c-15c4-318f-28bd-4b6706708c0d@redhat.com>
	<CAKv+Gu_-nRqeCT0s6ZwW+q3=sbGmtazFJ9R=19U5SJ=gSUmJLw@mail.gmail.com>
	<a2c37d40-e2ee-e7aa-3f34-ab39a9a6449d@redhat.com>
	<459862f9-18f7-0a37-dfb9-b8ca9aa6a2d2@redhat.com>
	<3de6adf3-30c7-5908-e153-2195bc6879c5@redhat.com>
	<9e939ea4-4be2-a165-dce4-47d8196020b0@redhat.com>
	<20190403114901.6e4ea653@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA839353082@lhreml524-mbs.china.huawei.com>
	<ebf745ce-f5bc-be0c-c0ce-3ce25bd7afa9@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA8393564E2@lhreml524-mbs.china.huawei.com>
	<20190408101132.5d849d1f@redhat.com>
In-Reply-To: <20190408101132.5d849d1f@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 185.176.76.210
Subject: Re: [Qemu-devel] [PATCH v3 07/10] hw/arm/virt: Introduce opt-in
 feature "fdt"
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"sameo@linux.intel.com" <sameo@linux.intel.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Linuxarm <linuxarm@huawei.com>, Auger Eric <eric.auger@redhat.com>,
	"shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"xuwei \(O\)" <xuwei5@huawei.com>,
	"sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>,
	Laszlo Ersek <lersek@redhat.com>, Leif Lindholm <Leif.Lindholm@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409104325.rHyc9S5ehoEVW0c6PKdv-Juo4kwEDHXf58dTNJUrceo@z>



> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: 08 April 2019 09:12
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Laszlo Ersek <lersek@redhat.com>; Auger Eric <eric.auger@redhat.com>;
> Ard Biesheuvel <ard.biesheuvel@linaro.org>; peter.maydell@linaro.org;
> sameo@linux.intel.com; qemu-devel@nongnu.org; Linuxarm
> <linuxarm@huawei.com>; shannon.zhaosl@gmail.com;
> qemu-arm@nongnu.org; xuwei (O) <xuwei5@huawei.com>;
> sebastien.boeuf@intel.com; Leif Lindholm <Leif.Lindholm@arm.com>
> Subject: Re: [Qemu-devel] [PATCH v3 07/10] hw/arm/virt: Introduce opt-in
> feature "fdt"

[...]
=20
> > > > If the above is correct(with 32-bit variant of UEFI, OS cannot have=
 ACPI
> boot),
> > > > then do we really have the issue of memory becoming non
> > > hot-un-unpluggable?
> > > > May be I am missing something.
> > >
> > > I think Igor and Peter dislike adding complex logic to QEMU that
> > > reflects the behavior of a specific firmware. AIUI their objection is=
n't
> > > that it wouldn't work, but that it's not the right thing to do, from =
a
> > > design perspective.
> >
> > Understood. Hope we can converge on something soon.
> Lets try adding a parameter to memory descriptors in DT that would mark
> them as hotpluggable.

Just send out v4 incorporating this. Please take a look and let me know.

Thanks,
Shameer
=20

