Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A29C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 08:54:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 299122230E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 08:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299122230E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWzHR-00015J-A3
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 03:54:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iWzGj-0000YB-8l
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 03:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iWzGf-00029m-DR
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 03:53:52 -0500
Received: from 17.mo7.mail-out.ovh.net ([188.165.35.227]:36418)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iWzGf-000284-6t
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 03:53:49 -0500
Received: from player791.ha.ovh.net (unknown [10.108.54.38])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id B073B135490
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 09:53:39 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player791.ha.ovh.net (Postfix) with ESMTPSA id 61453C24E22A;
 Tue, 19 Nov 2019 08:53:33 +0000 (UTC)
Date: Tue, 19 Nov 2019 09:53:31 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0] xive/kvm: Trigger interrupts from userspace
Message-ID: <20191119095331.2491e48e@bahia.lan>
In-Reply-To: <50ff4d1f-6576-0fc3-e1d5-9600cdbef5e4@kaod.org>
References: <157408992731.494439.3405812941731584740.stgit@bahia.lan>
 <f81b87b2-c6c9-9c12-2929-adbb341cd391@kaod.org>
 <20191119004713.GF5582@umbus.fritz.box>
 <50ff4d1f-6576-0fc3-e1d5-9600cdbef5e4@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 12507340592312916363
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegjedguddvhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejledurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.35.227
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

On Tue, 19 Nov 2019 09:15:52 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 19/11/2019 01:47, David Gibson wrote:
> > On Mon, Nov 18, 2019 at 04:37:16PM +0100, C=C3=A9dric Le Goater wrote:
> >> On 18/11/2019 16:12, Greg Kurz wrote:
> >>> When using the XIVE KVM device, the trigger page is directly accessib=
le
> >>> in QEMU. Unlike with XICS, no need to ask KVM to fire the interrupt. A
> >>> simple store on the trigger page does the job.
> >>>
> >>> Just call xive_esb_trigger().
> >>
> >> Yes but the KVM XIVE device does a few other checks.=20
> >>
> >> It checks that the interrupt was correctly initialized at the KVM devi=
ce
> >> level. We should be fine in QEMU which has similar checks.
> >>
> >> It caches the LSI assertion level. We should be fine also because it is
> >> useless in KVM when using the XIVE native exploitation mode.
> >>
> >> It checks it is not a passthru interrupt. Any idea on how to check thi=
s=20
> >> condition under QEMU ?=20
> >> =20
> >>> This may improve performance of emulated devices that go through
> >>> qemu_set_irq(), eg. virtio devices created with ioeventfd=3Doff or
> >>> configured by the guest to use LSI interrupts, which aren't really
> >>> recommended setups.
> >>
> >> LGTM.
> >=20
> > Ok, between the comments above and this, I'm not sure if this is ready
> > to merge or not.
>=20
> I think it is.=20
>=20
> With this change, we are loosing a check on passthrough interrupts but=20
> I am not sure how critical this is given that QEMU can anyhow bypass=20
> KVM and trigger the interrupt using a store on the ESB page.=20
>=20

True. Thinking a bit more about this: nothing prevents such a store to
be the result of a bug somewhere else in QEMU, eg. some dangling pointer
with the same value, in a much easier way than doing the KVM ioctl. Is
it a concern we should take into account ?

> >> Any figures to share ?=20
>=20
> I am torturing Greg to have numbers :) but he resisted well.
>=20

Maybe a _liquid_ bribe or two can be convincing enough :-)

> >> C.
> >>
> >>> Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> Let's move on.
>=20
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> C.
>=20
> >>> ---
> >>>  hw/intc/spapr_xive_kvm.c |   16 ++--------------
> >>>  1 file changed, 2 insertions(+), 14 deletions(-)
> >>>
> >>> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> >>> index 08012ac7cd76..69e73552f1ef 100644
> >>> --- a/hw/intc/spapr_xive_kvm.c
> >>> +++ b/hw/intc/spapr_xive_kvm.c
> >>> @@ -354,32 +354,20 @@ static void kvmppc_xive_source_get_state(XiveSo=
urce *xsrc)
> >>>  void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val)
> >>>  {
> >>>      XiveSource *xsrc =3D opaque;
> >>> -    SpaprXive *xive =3D SPAPR_XIVE(xsrc->xive);
> >>> -    struct kvm_irq_level args;
> >>> -    int rc;
> >>> -
> >>> -    /* The KVM XIVE device should be in use */
> >>> -    assert(xive->fd !=3D -1);
> >>> =20
> >>> -    args.irq =3D srcno;
> >>>      if (!xive_source_irq_is_lsi(xsrc, srcno)) {
> >>>          if (!val) {
> >>>              return;
> >>>          }
> >>> -        args.level =3D KVM_INTERRUPT_SET;
> >>>      } else {
> >>>          if (val) {
> >>>              xsrc->status[srcno] |=3D XIVE_STATUS_ASSERTED;
> >>> -            args.level =3D KVM_INTERRUPT_SET_LEVEL;
> >>>          } else {
> >>>              xsrc->status[srcno] &=3D ~XIVE_STATUS_ASSERTED;
> >>> -            args.level =3D KVM_INTERRUPT_UNSET;
> >>>          }
> >>>      }
> >>> -    rc =3D kvm_vm_ioctl(kvm_state, KVM_IRQ_LINE, &args);
> >>> -    if (rc < 0) {
> >>> -        error_report("XIVE: kvm_irq_line() failed : %s", strerror(er=
rno));
> >>> -    }
> >>> +
> >>> +    xive_esb_trigger(xsrc, srcno);
> >>>  }
> >>
> >>
> >=20
>=20


