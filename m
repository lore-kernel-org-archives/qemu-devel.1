Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E989FC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 00:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F367020771
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 00:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F367020771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ4FO-0000p4-34
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 20:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1kJ4Dg-0000DV-Jz; Thu, 17 Sep 2020 20:25:44 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2979 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1kJ4Dc-0001pr-9s; Thu, 17 Sep 2020 20:25:44 -0400
Received: from nkgeml704-chm.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id BF03A8844843A18C743D;
 Fri, 18 Sep 2020 08:25:23 +0800 (CST)
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 nkgeml704-chm.china.huawei.com (10.98.57.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Fri, 18 Sep 2020 08:25:21 +0800
Received: from lhreml703-chm.china.huawei.com ([10.201.68.198]) by
 lhreml703-chm.china.huawei.com ([10.201.68.198]) with mapi id 15.01.1913.007; 
 Fri, 18 Sep 2020 01:25:19 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: Andrew Jones <drjones@redhat.com>, fangying <fangying1@huawei.com>
Subject: RE: [RFC PATCH 04/12] device_tree: add qemu_fdt_add_path
Thread-Topic: [RFC PATCH 04/12] device_tree: add qemu_fdt_add_path
Thread-Index: AQHWjKHH5zES4p0+/UadBbZsJn/3JalsapaAgAEMekA=
Date: Fri, 18 Sep 2020 00:25:19 +0000
Message-ID: <a0ef33da132a411a8da14a8b05f78c1d@huawei.com>
References: <20200917032033.2020-1-fangying1@huawei.com>
 <20200917032033.2020-5-fangying1@huawei.com>
 <20200917081239.bdfhkofodqvhg3i6@kamzik.brq.redhat.com>
In-Reply-To: <20200917081239.bdfhkofodqvhg3i6@kamzik.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.65.147]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=salil.mehta@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 20:25:24
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alexander Graf <agraf@suse.de>, "Chenzhendong \(alex\)" <alex.chen@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> From: Qemu-arm [mailto:qemu-arm-bounces+salil.mehta=3Dhuawei.com@nongnu.o=
rg]
> On Behalf Of Andrew Jones
> Sent: Thursday, September 17, 2020 9:13 AM
> To: fangying <fangying1@huawei.com>
> Cc: peter.maydell@linaro.org; Zhanghailiang <zhang.zhanghailiang@huawei.c=
om>;
> Alexander Graf <agraf@suse.de>; qemu-devel@nongnu.org; Chenzhendong (alex=
)
> <alex.chen@huawei.com>; shannon.zhaosl@gmail.com; qemu-arm@nongnu.org;
> alistair.francis@wdc.com; imammedo@redhat.com
> Subject: Re: [RFC PATCH 04/12] device_tree: add qemu_fdt_add_path
>=20
> On Thu, Sep 17, 2020 at 11:20:25AM +0800, Ying Fang wrote:
> > From: Andrew Jones <drjones@redhat.com>
> >
> > qemu_fdt_add_path works like qemu_fdt_add_subnode, except it
> > also recursively adds any missing parent nodes.
> >
> > Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> > Cc: Alexander Graf <agraf@suse.de>
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >  device_tree.c                | 24 ++++++++++++++++++++++++
> >  include/sysemu/device_tree.h |  1 +
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/device_tree.c b/device_tree.c
> > index b335dae707..1854be3a02 100644
> > --- a/device_tree.c
> > +++ b/device_tree.c
> > @@ -524,6 +524,30 @@ int qemu_fdt_add_subnode(void *fdt, const char *na=
me)
> >      return retval;
> >  }
> >
> > +int qemu_fdt_add_path(void *fdt, const char *path)
> > +{
> > +    char *parent;
> > +    int offset;
> > +
> > +    offset =3D fdt_path_offset(fdt, path);
> > +    if (offset < 0 && offset !=3D -FDT_ERR_NOTFOUND) {
> > +        error_report("%s Couldn't find node %s: %s", __func__, path,
> > +                     fdt_strerror(offset));
> > +        exit(1);
> > +    }
> > +
> > +    if (offset !=3D -FDT_ERR_NOTFOUND) {
> > +        return offset;
> > +    }
> > +
> > +    parent =3D g_strdup(path);
> > +    strrchr(parent, '/')[0] =3D '\0';
> > +    qemu_fdt_add_path(fdt, parent);
> > +    g_free(parent);
> > +
> > +    return qemu_fdt_add_subnode(fdt, path);
> > +}
>=20
> Igor didn't like the recursion when I posted this before so I changed
> it when doing the refresh[*] that I gave to Salil Mehta. Salil also
> works for Huawei, are you guys not working together?
>=20
> [*] https://github.com/rhdrjones/qemu/commits/virt-cpu-topology-refresh
>=20


I was not aware of this work going on. I am based at Cambridge and Fangying
in Hangzhou and work for different teams.

Yes, I have it and have integrated it with the Virtual CPU hotplug branch
and I am testing them.

I have also rebased virtual cpu hotplug patches and integrated the PMU
related changes recently been discussed in other mail-chain. Plus, I am
also dealing with the MPIDR/affinity part from the Kernel which has been
discussed earlier with the Marc Zyngier.=20

It looks some of the changes are common here like ability to set MPIDR
of the vcpus at the time of their creation inside KVM. And the PPTT
table changes which were present in your refresh branch as well. Changes
related to the possible and present vcpus might need a sync as well.

@Andrew, should I take out the part which is common and affects the
virtual cpu hotplug and push them separately. This way I can have part
of the changes related to the vcpu hotplug done which will also cover
this patch-set requirements as well?=20

@Fangying, will this work for you?


Salil.=20


