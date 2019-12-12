Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14E0C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B60C72077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60C72077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifNgJ-0003Qx-VM
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 07:34:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ifNfg-0002t2-5Y
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:34:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ifNfe-0006aS-Uu
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:34:20 -0500
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:40871)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ifNfe-0006Xa-OC
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:34:18 -0500
Received: from player692.ha.ovh.net (unknown [10.108.1.232])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id BDD23115A59
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 13:34:16 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player692.ha.ovh.net (Postfix) with ESMTPSA id B5B7CD16B28C;
 Thu, 12 Dec 2019 12:33:51 +0000 (UTC)
Date: Thu, 12 Dec 2019 13:32:51 +0100
From: Greg Kurz <groug@kaod.org>
To: Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [PATCH v2 ppc-for-5.0 2/2] ppc/spapr: Support reboot of secure
 pseries guest
Message-ID: <20191212133252.483868d7@bahia.tlslab.ibm.com>
In-Reply-To: <20191212085343.GB28362@in.ibm.com>
References: <20191212055059.9399-1-bharata@linux.ibm.com>
 <20191212055059.9399-3-bharata@linux.ibm.com>
 <aeadba2d-1699-a750-2dc2-cf9921e57680@kaod.org>
 <20191212085343.GB28362@in.ibm.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 3731232293415852534
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeljedggeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelvddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.37.72
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxram@us.ibm.com,
 qemu-devel@nongnu.org, paulus@ozlabs.org, qemu-ppc@nongnu.org,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Dec 2019 14:23:43 +0530
Bharata B Rao <bharata@linux.ibm.com> wrote:

> On Thu, Dec 12, 2019 at 08:34:57AM +0100, C=C3=A9dric Le Goater wrote:
> > Hello Bharata,
> >=20
> >=20
> > On 12/12/2019 06:50, Bharata B Rao wrote:
> > > A pseries guest can be run as a secure guest on Ultravisor-enabled
> > > POWER platforms. When such a secure guest is reset, we need to
> > > release/reset a few resources both on ultravisor and hypervisor side.
> > > This is achieved by invoking this new ioctl KVM_PPC_SVM_OFF from the
> > > machine reset path.
> > >=20
> > > As part of this ioctl, the secure guest is essentially transitioned
> > > back to normal mode so that it can reboot like a regular guest and
> > > become secure again.
> > >=20
> > > This ioctl has no effect when invoked for a normal guest. If this ioc=
tl
> > > fails for a secure guest, the guest is terminated.
> >=20
> > This looks OK.=20
> >=20
> > > Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> > > ---
> > >  hw/ppc/spapr.c       | 15 +++++++++++++++
> > >  target/ppc/kvm.c     |  7 +++++++
> > >  target/ppc/kvm_ppc.h |  6 ++++++
> > >  3 files changed, 28 insertions(+)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index f11422fc41..25e1a3446e 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -1597,6 +1597,21 @@ static void spapr_machine_reset(MachineState *=
machine)
> > >      void *fdt;
> > >      int rc;
> > > =20
> > > +    /*
> > > +     * KVM_PPC_SVM_OFF ioctl can fail for secure guests, check and
> > > +     * exit in that case. However check for -ENOTTY explicitly
> > > +     * to ensure that we don't terminate normal guests that are
> > > +     * running on kernels which don't support this ioctl.
> > > +     *
> > > +     * Also, this ioctl returns 0 for normal guests on kernels where
> > > +     * this ioctl is supported.
> > > +     */
> > > +    rc =3D kvmppc_svm_off();
> > > +    if (rc && rc !=3D -ENOTTY) {
> >=20
> > I would put these low level tests under kvmppc_svm_off().
>=20
> Makes sense.
>=20
> >=20
> > > +        error_report("Reset of secure guest failed, exiting...");
> > > +        exit(EXIT_FAILURE);
> >=20
> > The exit() could probably go under kvmppc_svm_off() also.
>=20
> May be not. Then error_report would have also have to go in.
> Doesn't make sense to print this error from there.
>=20

Why doesn't it make sense ? It seems there's a consensus that the
failure (at least the -EINVAL case) isn't recoverable in any way.
Are there cases where we would call this and the caller could
cope with an error ?

> Regards,
> Bharata.
>=20
>=20


