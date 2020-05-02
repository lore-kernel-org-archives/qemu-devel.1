Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76372C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4877A2137B
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4877A2137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jV0Wz-0003hT-Ek
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 18:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gengdongjiu@huawei.com>)
 id 1jV0WE-0002m3-NG
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <gengdongjiu@huawei.com>) id 1jV0WE-0006xR-6M
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:21:58 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2100 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gengdongjiu@huawei.com>)
 id 1jV0WB-0006Wl-QB; Sat, 02 May 2020 18:21:55 -0400
Received: from lhreml714-chm.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id 2AF87D59739CFA60A635;
 Sat,  2 May 2020 23:21:45 +0100 (IST)
Received: from dggeme755-chm.china.huawei.com (10.3.19.101) by
 lhreml714-chm.china.huawei.com (10.201.108.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Sat, 2 May 2020 23:21:43 +0100
Received: from dggeme755-chm.china.huawei.com ([10.7.64.71]) by
 dggeme755-chm.china.huawei.com ([10.7.64.71]) with mapi id 15.01.1913.007;
 Sun, 3 May 2020 06:21:41 +0800
From: gengdongjiu <gengdongjiu@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v25 00/10] Add ARMv8 RAS virtualization support in QEMU
Thread-Topic: [PATCH v25 00/10] Add ARMv8 RAS virtualization support in QEMU
Thread-Index: AdYgz//oho/0lGTqbEC6pfKPUDNKmA==
Date: Sat, 2 May 2020 22:21:41 +0000
Message-ID: <d3ca73f6fdbf46078f68f142a4a03d26@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.46.14.22]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.76.210;
 envelope-from=gengdongjiu@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 18:21:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, kvm-devel <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "zhengxiang \(A\)" <zhengxiang9@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>=20
> On Thu, 30 Apr 2020 11:56:24 +0800
> gengdongjiu <gengdongjiu@huawei.com> wrote:
>=20
> > On 2020/4/17 21:32, Peter Maydell wrote:
> > > On Fri, 10 Apr 2020 at 12:46, Dongjiu Geng <gengdongjiu@huawei.com> w=
rote:
> > >>
> > >> In the ARMv8 platform, the CPU error types includes synchronous
> > >> external abort(SEA) and SError Interrupt (SEI). If exception
> > >> happens in guest, host does not know the detailed information of
> > >> guest, so it is expected that guest can do the recovery. For
> > >> example, if an exception happens in a guest user-space application, =
host does not know which application encounters errors, only
> guest knows it.
> > >>
> > >> For the ARMv8 SEA/SEI, KVM or host kernel delivers SIGBUS to notify =
userspace.
> > >> After user space gets the notification, it will record the CPER
> > >> into guest GHES buffer and inject an exception or IRQ to guest.
> > >>
> > >> In the current implementation, if the type of SIGBUS is
> > >> BUS_MCEERR_AR, we will treat it as a synchronous exception, and
> > >> notify guest with ARMv8 SEA notification type after recording CPER i=
nto guest.
> > >
> > > Hi. I left a comment on patch 1. The other 3 patches unreviewed are
> > > 5, 6 and 8, which are all ACPI core code, so that's for MST, Igor or
> > > Shannon to review.
> >
> > Ping MST, Igor and Shannon, sorry for the noise.
>=20
> I put it on my review queue

Igor, thank you very much in advance.

>=20
> >
> > >
> > > Once those have been reviewed, please ping me if you want this to go
> > > via target-arm.next.
> > >
> > > thanks
> > > -- PMM
> > >
> > > .
> > >
> >


