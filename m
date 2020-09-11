Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDD8C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 06:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861B1221EB
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 06:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861B1221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGcW6-0003xk-Ds
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 02:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kGcVU-0003PL-6q; Fri, 11 Sep 2020 02:26:00 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:49669)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kGcVR-0001sY-Q8; Fri, 11 Sep 2020 02:25:59 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.180])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id BD8D959DC40A;
 Fri, 11 Sep 2020 08:25:54 +0200 (CEST)
Received: from kaod.org (37.59.142.97) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 11 Sep
 2020 08:25:53 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0020f8465f2-d2aa-420c-b116-c932b61acd28,
 864FBEA0465FE1F0C66A9C6AC37977A76827B8ED) smtp.auth=groug@kaod.org
Date: Fri, 11 Sep 2020 08:25:52 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [for-5.2 v4 10/10] s390: Recognize host-trust-limitation option
Message-ID: <20200911082552.1b7d7bde@bahia.lan>
In-Reply-To: <20200911000718.GF66834@yekko.fritz.box>
References: <20200724025744.69644-1-david@gibson.dropbear.id.au>
 <20200724025744.69644-11-david@gibson.dropbear.id.au>
 <20200907172253.0a51f5f7.pasic@linux.ibm.com>
 <20200910133609.4ac88c25.cohuck@redhat.com>
 <20200910202924.3616935a.pasic@linux.ibm.com>
 <20200911000718.GF66834@yekko.fritz.box>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qq16TA.RbBJtpBs.5w6QU1y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 603d3a54-b52f-44da-a31e-7633abf7e05f
X-Ovh-Tracer-Id: 1761470407334599123
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudehkedguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtghisehgtderreertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeelgffgfeeugedugeekveeiveevjeffhfduvdegffetkeeiveeufefgledtgfeiteenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegvhhgrsghkohhsthesrhgvughhrghtrdgtohhm
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 02:19:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, ehabkost@redhat.com, dgilbert@redhat.com,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, pbonzini@redhat.com, Thomas Huth <thuth@redhat.com>,
 "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, mdroth@linux.vnet.ibm.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/qq16TA.RbBJtpBs.5w6QU1y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Sep 2020 10:07:18 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Sep 10, 2020 at 08:29:24PM +0200, Halil Pasic wrote:
> > On Thu, 10 Sep 2020 13:36:09 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >=20
> > > On Mon, 7 Sep 2020 17:22:53 +0200
> > > Halil Pasic <pasic@linux.ibm.com> wrote:
> > >=20
> > > > On Fri, 24 Jul 2020 12:57:44 +1000
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >=20
> > > > > At least some s390 cpu models support "Protected Virtualization" =
(PV),
> > > > > a mechanism to protect guests from eavesdropping by a compromised
> > > > > hypervisor.
> > > > >=20
> > > > > This is similar in function to other mechanisms like AMD's SEV and
> > > > > POWER's PEF, which are controlled bythe "host-trust-limitation"
> > > > > machine option.  s390 is a slightly special case, because we alre=
ady
> > > > > supported PV, simply by using a CPU model with the required featu=
re
> > > > > (S390_FEAT_UNPACK).
> > > > >=20
> > > > > To integrate this with the option used by other platforms, we
> > > > > implement the following compromise:
> > > > >=20
> > > > >  - When the host-trust-limitation option is set, s390 will recogn=
ize
> > > > >    it, verify that the CPU can support PV (failing if not) and set
> > > > >    virtio default options necessary for encrypted or protected gu=
ests,
> > > > >    as on other platforms.  i.e. if host-trust-limitation is set, =
we
> > > > >    will either create a guest capable of entering PV mode, or fail
> > > > >    outright =20
> > > >=20
> > > > Shouldn't we also fail outright if the virtio features are not PV
> > > > compatible (invalid configuration)?
> > > >=20
> > > > I would like to see something like follows as a part of this series.
> > > > ----------------------------8<--------------------------
> > > > From: Halil Pasic <pasic@linux.ibm.com>
> > > > Date: Mon, 7 Sep 2020 15:00:17 +0200
> > > > Subject: [PATCH] virtio: handle host trust limitation
> > > >=20
> > > > If host_trust_limitation_enabled() returns true, then emulated virt=
io
> > > > devices must offer VIRTIO_F_ACCESS_PLATFORM, because the device is =
not
> > > > capable of accessing all of the guest memory. Otherwise we are in
> > > > violation of the virtio specification.
> > > >=20
> > > > Let's fail realize if we detect that VIRTIO_F_ACCESS_PLATFORM featu=
re is
> > > > obligatory but missing.
> > > >=20
> > > > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > > > ---
> > > >  hw/virtio/virtio.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >=20
> > > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > > index 5bd2a2f621..19b4b0a37a 100644
> > > > --- a/hw/virtio/virtio.c
> > > > +++ b/hw/virtio/virtio.c
> > > > @@ -27,6 +27,7 @@
> > > >  #include "hw/virtio/virtio-access.h"
> > > >  #include "sysemu/dma.h"
> > > >  #include "sysemu/runstate.h"
> > > > +#include "exec/host-trust-limitation.h"
> > > > =20
> > > >  /*
> > > >   * The alignment to use between consumer and producer parts of vri=
ng.
> > > > @@ -3618,6 +3619,12 @@ static void virtio_device_realize(DeviceStat=
e *dev, Error **errp)
> > > >      /* Devices should either use vmsd or the load/save methods */
> > > >      assert(!vdc->vmsd || !vdc->load);
> > > > =20
> > > > +    if (host_trust_limitation_enabled(MACHINE(qdev_get_machine()))
> > > > +        && !virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)=
) {
> > > > +        error_setg(&err, "devices without VIRTIO_F_ACCESS_PLATFORM=
 are not compatible with host trust imitation");
> > > > +        error_propagate(errp, err);
> > > > +        return;
> > >=20
> > > How can we get here? I assume only if the user explicitly turned the
> > > feature off while turning HTL on, as otherwise patch 9 should have
> > > taken care of it?
> > >=20
> >=20
> > Yes, we can get here only if iommu_platform is explicitly turned off.
>=20
> Right.. my assumption was that if you really want to specify
> contradictory options, you get to keep both pieces.  Or, more
> seriously, there might be some weird experimental cases where this
> combination could do something useful if you really know what you're
> doing, and explicitly telling qemu to do this implies you know what
> you're doing.
>=20

I guess this deserves at least a warning for the case of someone that
doesn't really know what they're doing, eg. borrowing a complex QEMU
command line or libvirt XML from somewhere else ?

--Sig_/qq16TA.RbBJtpBs.5w6QU1y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl9bGHAACgkQcdTV5YIv
c9aLFw//SBEpcqO6AeWXyaEf1IuQO8Jdfa+YbYgQ+f3kss0PYrJVnbHDS6NKGHEV
VCHF1PfT4R7ELXOFc8cCIEmbF0X0giH4fDoTxhSUNz33hC5GRYe5mJp2DKHcuDYo
6wH0mmBu0OqU3Sa7Bce7kaWSovngQqxlTBFLSK44szJ/W+Pm5uG8F6LYEEJbQLr+
L0fMyJusrozpPESWcHoRAk9C2EiUi7xGVUUcCBEkF9Iqa5f5D2h/bNzqVHzRQhTm
LIaL5M8rH21Np/UYD23HZEDf4TDgfJo2NoZFkdGUDnQ9QNS5xBdG5xFuNlPEixTi
RyWWogofOp06IEmmFi3KitZ7EjATJSVi+Zl2xcdK3LMj8ehd6GPOqzNOK1oNzVUS
T8vfgzjGG8NtcV4GAzrX8NdRdg+4q8d7nWleUiSxh5acDCFkvrsjKoSVZGh3XAOX
9p4Rk9aXKB2eSQirglsgbqbUMgAH0VpOpury69BM1CSMFGJlFdgY4M/JrGhlsldM
/Io/Dv/C91UyCG52P5Nv7KD0C5hkpFsvKO207LuR+jbRu9seOiF6cLrnRyS6F+w3
6UGAub1oZamWpnbLZ3/c/WWhymR8MIFKaUe+YCxjI+qRJPUj/WcuLKCy+/0zjWCl
qph/FWyVqrKJRkoqDJUz+0Q8rvI1sYTuWc6ljJbemtXQyGT7tHo=
=/qie
-----END PGP SIGNATURE-----

--Sig_/qq16TA.RbBJtpBs.5w6QU1y--

