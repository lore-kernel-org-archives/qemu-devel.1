Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C67C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 478DD20700
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478DD20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG0f1-0001DW-Fx
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 08:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iG0dj-0000Y7-HM
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:55:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iG0di-0003zs-6j
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:55:27 -0400
Received: from 8.mo1.mail-out.ovh.net ([178.33.110.239]:60582)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iG0di-0003yw-0d
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:55:26 -0400
Received: from player168.ha.ovh.net (unknown [10.109.146.82])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 98C7E1915B8
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 14:55:23 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player168.ha.ovh.net (Postfix) with ESMTPSA id 0107AA6F67DE;
 Thu,  3 Oct 2019 12:55:19 +0000 (UTC)
Date: Thu, 3 Oct 2019 14:55:18 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 5/7] spapr/xics: Configure number of servers in KVM
Message-ID: <20191003145518.302b5bd6@bahia.lan>
In-Reply-To: <f73f91b3-175f-b0c5-6ebb-93cff15940e6@kaod.org>
References: <157010404888.246126.9768030542733152637.stgit@bahia.lan>
 <157010410405.246126.5846482955650460662.stgit@bahia.lan>
 <f73f91b3-175f-b0c5-6ebb-93cff15940e6@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 17274400796387809675
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeekgdehlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.110.239
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

On Thu, 3 Oct 2019 14:29:46 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 03/10/2019 14:01, Greg Kurz wrote:
> > The XICS-on-XIVE KVM devices now has an attribute to configure the numb=
er
> > of interrupt servers. This allows to greatly optimize the usage of the =
VP
> > space in the XIVE HW, and thus to start a lot more VMs.
> >=20
> > Only set this attribute if available in order to support older POWER9 K=
VM
> > and pre-POWER9 XICS KVM devices.
> >=20
> > The XICS-on-XIVE KVM device now reports the exhaustion of VPs upon the
> > connection of the first VCPU. Check that in order to have a chance to
> > provide an hint to the user.
>=20
> That part would have been better in its own patch. Simpler to review.
> =20

Yeah, possibly... on the other hand, it's only two fairly simple
hunks. :)

> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> Anyhow, if you split or not :
>=20
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> > ---
> >  hw/intc/xics_kvm.c |   24 ++++++++++++++++++++++--
> >  1 file changed, 22 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> > index ba90d6dc966c..12d9524cc432 100644
> > --- a/hw/intc/xics_kvm.c
> > +++ b/hw/intc/xics_kvm.c
> > @@ -165,8 +165,15 @@ void icp_kvm_realize(DeviceState *dev, Error **err=
p)
> > =20
> >      ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, kernel_xics_f=
d, vcpu_id);
> >      if (ret < 0) {
> > -        error_setg(errp, "Unable to connect CPU%ld to kernel XICS: %s"=
, vcpu_id,
> > -                   strerror(errno));
> > +        Error *local_err =3D NULL;
> > +
> > +        error_setg(&local_err, "Unable to connect CPU%ld to kernel XIC=
S: %s",
> > +                   vcpu_id, strerror(errno));
> > +        if (errno =3D=3D ENOSPC) {
> > +            error_append_hint(&local_err, "Try -smp maxcpus=3DN with N=
 < %u\n",
> > +                              MACHINE(qdev_get_machine())->smp.max_cpu=
s);
> > +        }
> > +        error_propagate(errp, local_err);
> >          return;
> >      }
> >      enabled_icp =3D g_malloc(sizeof(*enabled_icp));
> > @@ -344,6 +351,7 @@ void ics_kvm_set_irq(ICSState *ics, int srcno, int =
val)
> > =20
> >  int xics_kvm_connect(SpaprMachineState *spapr, Error **errp)
> >  {
> > +    ICSState *ics =3D spapr->ics;
> >      int rc;
> >      CPUState *cs;
> >      Error *local_err =3D NULL;
> > @@ -397,6 +405,18 @@ int xics_kvm_connect(SpaprMachineState *spapr, Err=
or **errp)
> >          goto fail;
> >      }
> > =20
> > +    /* Tell KVM about the # of VCPUs we may have (POWER9 and newer onl=
y) */
> > +    if (kvm_device_check_attr(rc, KVM_DEV_XICS_GRP_CTRL,
> > +                              KVM_DEV_XICS_NR_SERVERS)) {
> > +        uint32_t nr_servers =3D xics_nr_servers(ics->xics);
> > +
> > +        if (kvm_device_access(rc, KVM_DEV_XICS_GRP_CTRL,
> > +                              KVM_DEV_XICS_NR_SERVERS, &nr_servers, tr=
ue,
> > +                              &local_err)) {
> > +            goto fail;
> > +        }
> > +    }
> > +
> >      kernel_xics_fd =3D rc;
> >      kvm_kernel_irqchip =3D true;
> >      kvm_msi_via_irqfd_allowed =3D true;
> >=20
>=20


