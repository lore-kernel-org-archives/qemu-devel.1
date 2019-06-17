Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDB7C31E50
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A954D2084A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A954D2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47798 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcsDy-0008Bz-MH
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36893)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hcsB2-00079d-9S
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:00:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hcsB0-0001SR-Bp
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:00:04 -0400
Received: from 13.mo3.mail-out.ovh.net ([188.165.33.202]:57223)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hcsAy-0001N1-Bl
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:00:00 -0400
Received: from player799.ha.ovh.net (unknown [10.109.143.223])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 4A48B21953C
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 15:59:55 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id EBD656E869AA;
 Mon, 17 Jun 2019 13:59:50 +0000 (UTC)
Date: Mon, 17 Jun 2019 15:59:49 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Message-ID: <20190617155949.3ad75f15@bahia.lan>
In-Reply-To: <97e49445-5d99-f37d-24a1-595123fa00f1@kaod.org>
References: <156077793153.431407.3975189408068375970.stgit@bahia.lan>
 <97e49445-5d99-f37d-24a1-595123fa00f1@kaod.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 11302627692048062859
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeijedgjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.33.202
Subject: Re: [Qemu-devel] [PATCH] xics: Don't call icp_kvm_realize() from
 icp_realize()
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Jun 2019 15:46:14 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 17/06/2019 15:25, Greg Kurz wrote:
> > kvm_kernel_irqchip is set by xics_kvm_init() which is always called aft=
er
> > icp_realize() since commit 3f777abc7107 "spapr/irq: add KVM support to =
the
> > 'dual' machine". =20
>=20
> I think we still need it for CPU hotplug.
>=20

Yes you're right of course... a comment would probably help

> C.
>=20
>=20
> > This is thus dead code. Drop it.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/intc/xics.c |    8 --------
> >  1 file changed, 8 deletions(-)
> >=20
> > diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> > index 29f7d397813e..1dc3a0f12280 100644
> > --- a/hw/intc/xics.c
> > +++ b/hw/intc/xics.c
> > @@ -351,14 +351,6 @@ static void icp_realize(DeviceState *dev, Error **=
errp)
> >          return;
> >      }
> > =20
> > -    if (kvm_irqchip_in_kernel()) {
> > -        icp_kvm_realize(dev, &err);
> > -        if (err) {
> > -            error_propagate(errp, err);
> > -            return;
> > -        }
> > -    }
> > -
> >      qemu_register_reset(icp_reset_handler, dev);
> >      vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, ic=
p);
> >  }
> >  =20
>=20


