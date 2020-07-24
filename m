Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576D8C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 03:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2901320709
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 03:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2901320709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyoIP-0004im-FO
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 23:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <king.wang@huawei.com>)
 id 1jyoHh-0004Ip-EI
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 23:22:09 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2472 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <king.wang@huawei.com>)
 id 1jyoHe-0000fH-H8
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 23:22:09 -0400
Received: from nkgeml707-chm.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 8EBA57340CC32C743A90;
 Fri, 24 Jul 2020 11:21:59 +0800 (CST)
Received: from dggema763-chm.china.huawei.com (10.1.198.205) by
 nkgeml707-chm.china.huawei.com (10.98.57.157) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Fri, 24 Jul 2020 11:21:59 +0800
Received: from dggema763-chm.china.huawei.com ([10.9.49.85]) by
 dggema763-chm.china.huawei.com ([10.9.49.85]) with mapi id 15.01.1913.007;
 Fri, 24 Jul 2020 11:21:58 +0800
From: "Wangjing (Hogan, Cloud Infrastructure Service Product Dept.)"
 <king.wang@huawei.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
Subject: Re: [PATCH v1] hw/pci-host: save/restore pci host config register
Thread-Topic: [PATCH v1] hw/pci-host: save/restore pci host config register
Thread-Index: AdZhaT+s8aHRNmrveEmbvmzXYw8iJg==
Date: Fri, 24 Jul 2020 03:21:58 +0000
Message-ID: <ec09235475524a94b8aeb5dc73cd0e74@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.56]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187; envelope-from=king.wang@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 23:22:00
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "jusual@redhat.com" <jusual@redhat.com>,
 "Wangxin \(Alexander\)" <wangxinxin.wang@huawei.com>,
 "Huangweidong \(C\)" <weidong.huang@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 25, 2020 at 10:53:03AM Hogan Wang wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
> > On Thu, Jul 23, 2020 at 02:12:54PM +0100, Dr. David Alan Gilbert wrote:
> > > * Michael S. Tsirkin (mst@redhat.com) wrote:
> > > > On Thu, Jul 23, 2020 at 08:53:03PM +0800, Hogan Wang wrote:
> > > > > From: Hogan Wang <king.wang@huawei.com>
> > > > >=20
> > > > > The pci host config register is used to save PCI address for=20
> > > > > read/write config data. If guest write a value to config=20
> > > > > register, and then pause the vcpu to migrate, After the=20
> > > > > migration, the guest continue to write pci config data, and the=20
> > > > > write data will be ignored because of new qemu process lost the c=
onfig register state.
> > > > >=20
> > > > > Reproduction steps are:
> > > > > 1. guest booting in seabios.
> > > > > 2. guest enable the SMRAM in seabios:piix4_apmc_smm_setup, and th=
en
> > > > >    expect to disable the SMRAM by pci_config_writeb.
> > > > > 3. after guest write the pci host config register, and then pasue=
d vcpu
> > > > >    to finish migration.
> > > > > 4. guest write config data(0x0A) fail to disable the SMRAM becasu=
e of
> > > > >    config register state lost.
> > > > > 5. guest continue to boot and crash in ipxe option ROM due to SMR=
AM in
> > > > >    enabled state.
> > > > >=20
> > > > > Signed-off-by: Hogan Wang <king.wang@huawei.com>
> > > >=20
> > > > I guess this is like v3 right?
> > > >=20
> > > > thanks a lot for the patch!
> > > >=20
> > > > My question stands : does anyone see a way to pass this info=20
> > > > around without breaking migration for all existing machine types?
> > >=20
> > > You need a .needed clause in the vmstate_i440fx_pcihost and=20
> > > vmstate_q35_pcihost which is a pointer to a function which enables=20
> > > it on new machine types and ignores it on old ones.
> > >=20
> > > Or, if it always crashes if the SMRAM is enabled, then the migration=
=20
> > > is dead anyway; so you could make the .needed only save the config=20
> > > if the SMRAM is opened, so you'd get a unknown section error, which=20
> > > is nasty but it would only happen in the case it would crash anyway.
> > >=20
> > > Dave
> >=20
> > Problem is we never know whether it's needed.
> >=20
> > For example: guest programs cf8, then cfc.
> > Guest on destination can crash if migrated after writing cf8 before=20
> > writing cfc.
> > But in theory it can also crash if guest assumes
> > cf8 is unchanged and just writes cfc.
> >=20
> > So what I'd prefer to do is put it in some data that old qemu ignores.=
=20
> > Then once qemu on destination is updated, it will start interpreting=20
> > it.
>=20
> We don't have a way to do that; the choice is:
>   a) Not sending it for old versions, so you only get the
>     fix for new machine types
>=20
>   b) Trying to second guess when it will crash
>=20
> I recommend (a) generally - but the format has no way to ignore unknown d=
ata.
>=20
> Dave
>=20

The i440fx and q35 machines integrate i440FX or ICH9-LPC PCI device by
default. Refer to i440FX and ICH9-LPC spcifications, there are some reserve=
d
configuration registers can used to save/restore PCIHostState.config_reg,
like i440FX.config[0x57] used for Older coreboot to get RAM size from QEMU.

whitch is nasty but it friendly to old ones.

> >=20
> > > >=20
> > > > > ---
> > > > >  hw/pci-host/i440fx.c       | 11 +++++++++++
> > > > >  hw/pci-host/q35.c          | 11 +++++++++++
> > > > >  hw/pci/pci_host.c          | 11 +++++++++++
> > > > >  hw/pci/pcie_host.c         | 11 +++++++++++
> > > > >  include/hw/pci/pci_host.h  | 10 ++++++++++ =20
> > > > > include/hw/pci/pcie_host.h | 10 ++++++++++
> > > > >  6 files changed, 64 insertions(+)
> > > > >=20
> > > >=20
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


