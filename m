Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F31C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0676B2072E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0676B2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaN0U-0004mh-RG
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 12:55:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kaMzn-0003pG-Ul; Wed, 04 Nov 2020 12:54:55 -0500
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:58383)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kaMzl-0003M0-Aj; Wed, 04 Nov 2020 12:54:55 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.197])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id A972570EF28F;
 Wed,  4 Nov 2020 18:54:41 +0100 (CET)
Received: from kaod.org (37.59.142.97) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Wed, 4 Nov 2020
 18:54:40 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002a60b9b55-a377-4b09-8ef1-53f1e0dae1a2,
 B675344909C57F45DE6B9FBDE8367EDF8CA03E23) smtp.auth=groug@kaod.org
Date: Wed, 4 Nov 2020 18:54:39 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH-for-5.2 v3 2/4] hw/9pfs: Fix Kconfig dependency problem
 between 9pfs and Xen
Message-ID: <20201104185439.41e9ddb3@bahia.lan>
In-Reply-To: <8965407.pN9RvXrJQ9@silver>
References: <20201104115706.3101190-1-philmd@redhat.com>
 <20201104115706.3101190-3-philmd@redhat.com>
 <8965407.pN9RvXrJQ9@silver>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 003e621b-1e17-4f77-9185-fd9f201e51e8
X-Ovh-Tracer-Id: 16924808878257838352
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedruddthedguddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepveelhfdtudffhfeiveehhfelgeellefgteffteekudegheejfffghefhfeeuudffnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtoheprhhthhesthifihguughlvgdrnhgvth
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 12:54:43
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_BL_SPAMCOP_NET=1.347,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, "Daniel P .
 Berrange" <berrange@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Paul Durrant <paul@xen.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 04 Nov 2020 13:18:09 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Mittwoch, 4. November 2020 12:57:04 CET Philippe Mathieu-Daud=C3=A9 wr=
ote:
> > Commit b2c00bce54c ("meson: convert hw/9pfs, cleanup") introduced
> > CONFIG_9PFS (probably a wrong conflict resolution). This config is
> > not used anywhere. Backends depend on CONFIG_FSDEV_9P which itself
> > depends on CONFIG_VIRTFS.
> >=20
> > Remove the invalid CONFIG_9PFS and use CONFIG_FSDEV_9P instead, to
> > fix the './configure --without-default-devices --enable-xen' build:
> >=20
> >   /usr/bin/ld: libcommon.fa.p/hw_xen_xen-legacy-backend.c.o: in function
> > `xen_be_register_common': hw/xen/xen-legacy-backend.c:754: undefined
> > reference to `xen_9pfs_ops' /usr/bin/ld:
> > libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x8): undefined referenc=
e to
> > `local_ops' /usr/bin/ld:
> > libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x20): undefined referen=
ce
> > to `synth_ops' /usr/bin/ld:
> > libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x38): undefined referen=
ce
> > to `proxy_ops' collect2: error: ld returned 1 exit status
> >=20
> > Fixes: b2c00bce54c ("meson: convert hw/9pfs, cleanup")
> > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > Acked-by: Greg Kurz <groug@kaod.org>
> > Tested-by: Greg Kurz <groug@kaod.org>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
>=20

Phil,

Same questioning as Connie. Do you intend to get this merged or should
Christian or I take care of that ?

> > ---
> > v2: Reworded description (Greg)
> >=20
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: Anthony Perard <anthony.perard@citrix.com>
> > Cc: Paul Durrant <paul@xen.org>
> > Cc: xen-devel@lists.xenproject.org
> > Cc: Greg Kurz <groug@kaod.org>
> > Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> >  hw/9pfs/Kconfig     | 4 ----
> >  hw/9pfs/meson.build | 2 +-
> >  2 files changed, 1 insertion(+), 5 deletions(-)
> >=20
> > diff --git a/hw/9pfs/Kconfig b/hw/9pfs/Kconfig
> > index d3ebd737301..3ae57496613 100644
> > --- a/hw/9pfs/Kconfig
> > +++ b/hw/9pfs/Kconfig
> > @@ -2,12 +2,8 @@ config FSDEV_9P
> >      bool
> >      depends on VIRTFS
> >=20
> > -config 9PFS
> > -    bool
> > -
> >  config VIRTIO_9P
> >      bool
> >      default y
> >      depends on VIRTFS && VIRTIO
> >      select FSDEV_9P
> > -    select 9PFS
> > diff --git a/hw/9pfs/meson.build b/hw/9pfs/meson.build
> > index cc094262122..99be5d91196 100644
> > --- a/hw/9pfs/meson.build
> > +++ b/hw/9pfs/meson.build
> > @@ -15,6 +15,6 @@
> >    'coxattr.c',
> >  ))
> >  fs_ss.add(when: 'CONFIG_XEN', if_true: files('xen-9p-backend.c'))
> > -softmmu_ss.add_all(when: 'CONFIG_9PFS', if_true: fs_ss)
> > +softmmu_ss.add_all(when: 'CONFIG_FSDEV_9P', if_true: fs_ss)
> >=20
> >  specific_ss.add(when: 'CONFIG_VIRTIO_9P', if_true:
> > files('virtio-9p-device.c'))
>=20
> Best regards,
> Christian Schoenebeck
>=20
>=20


