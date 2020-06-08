Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E4BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 13:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67401206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 13:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67401206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIAv-0002BK-LA
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 09:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jiIA5-0001Wt-0y; Mon, 08 Jun 2020 09:50:02 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2110 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jiIA2-0008D2-E3; Mon, 08 Jun 2020 09:50:00 -0400
Received: from lhreml705-chm.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id 5209D2554581C8054EF3;
 Mon,  8 Jun 2020 14:49:46 +0100 (IST)
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 lhreml705-chm.china.huawei.com (10.201.108.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 8 Jun 2020 14:49:45 +0100
Received: from lhreml703-chm.china.huawei.com ([10.201.68.198]) by
 lhreml703-chm.china.huawei.com ([10.201.68.198]) with mapi id 15.01.1913.007; 
 Mon, 8 Jun 2020 14:49:46 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: RE: [Question] Regarding PMU initialization within the QEMU for ARM
 VCPUs
Thread-Topic: [Question] Regarding PMU initialization within the QEMU for ARM
 VCPUs
Thread-Index: AdY3+/mIYt1+TQdDQmymnxAa7PkUWwBhkdKAAHDt5AAABBY/YACLbJEAAAWfgEA=
Date: Mon, 8 Jun 2020 13:49:46 +0000
Message-ID: <1e9b79f1f310452d8167a6ed29266ee3@huawei.com>
References: <b2e401cd17fe49d792d09b31bd726e35@huawei.com>
 <20200603093745.dwfb55ny34az7rez@kamzik.brq.redhat.com>
 <20200605173116.55419a1e@redhat.com>
 <0c91f4bab5d24bb3a1e7ca36d1d57221@huawei.com>
 <20200608140026.1eb49a8b@redhat.com>
In-Reply-To: <20200608140026.1eb49a8b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.31.156]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.76.210;
 envelope-from=salil.mehta@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 09:49:46
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
Cc: Peter
 Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: Monday, June 8, 2020 1:00 PM
>=20
> On Fri, 5 Jun 2020 16:38:37 +0000
> Salil Mehta <salil.mehta@huawei.com> wrote:
>=20
> > > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > > Sent: Friday, June 5, 2020 4:31 PM
> > > To: Andrew Jones <drjones@redhat.com>
> > > Cc: Salil Mehta <salil.mehta@huawei.com>; qemu-devel@nongnu.org;
> > > qemu-arm@nongnu.org; Peter Maydell <peter.maydell@linaro.org>; mst@re=
dhat.com
> > > Subject: Re: [Question] Regarding PMU initialization within the QEMU =
for ARM
> > > VCPUs
> > >
> > > On Wed, 3 Jun 2020 11:37:45 +0200
> > > Andrew Jones <drjones@redhat.com> wrote:
> > >
> > > > On Mon, Jun 01, 2020 at 03:04:33PM +0000, Salil Mehta wrote:
> > > > > Hello,
> > > > > I could see below within function fdt_add_pmu_nodes() part of
> > > > > hw/arm/virt.c during virt machine initialization time:
> > > ...
> > > >
> > > > > Q4. This function  fdt_* looks to be wrongly named. The info
> > > > >     being initialized here shall be used even when ACPI is
> > > > >     being used. Initialization part and FDT info looked
> > > > >     mixed up here if I am right?
> > > >
> > > > Agreed. The function has the wrong name. mach-virt has many functio=
ns that
> > > > mix the initialization and fdt building together, but those functio=
ns are
> > > > named something like create_foo(). Patches welcome.
> > > that was where I gave up on cpu hotplug arm/virt the last time.
> >
> > Were you releasing the ARM objects as well? Or are you referring to som=
e
> > other problem?
> I was talking about mix of FDT and device creation code.

Ok. I have worked around that for now. Maybe you would like to review
it in the cpuhp patches which I should be able to float this week to the
community.

Thanks
Salil.

> > > Ideally we should split out from create_foo() all firmware generation=
 code
> > > (fdt) and move it to virt_machine_done time + make sure that it could=
 be
> > > regenerated at reset time so guest would get updated FDT on reset.
> >
> > Agreed, just like ACPI part. That would be more cleaner.
> >
> > Thanks
> > Salil.


