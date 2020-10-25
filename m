Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CDFC4363A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 21:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79DCA2225B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 21:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DCA2225B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWnfa-0002K8-Ik
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 17:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kWndl-0000ln-Oy
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 17:33:25 -0400
Received: from 10.mo51.mail-out.ovh.net ([46.105.77.235]:60934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kWndd-0004kM-1E
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 17:33:23 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.170])
 by mo51.mail-out.ovh.net (Postfix) with ESMTPS id CA496231601;
 Sun, 25 Oct 2020 22:33:08 +0100 (CET)
Received: from kaod.org (37.59.142.97) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Sun, 25 Oct
 2020 22:33:07 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002db8e73fe-c2e0-400c-8659-e8c858bb6b1f,
 5F9C93A9F3AD2D257DE4C2DCE7DBF4E7A6D9743C) smtp.auth=groug@kaod.org
Date: Sun, 25 Oct 2020 22:33:06 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 0/5] spapr: Error handling fixes and cleanups (round 3)
Message-ID: <20201025223306.0ca3ee0a@bahia.lan>
In-Reply-To: <20201025111340.48e2a40c@bahia.lan>
References: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
 <20201022041142.GG1821515@yekko.fritz.box>
 <20201025111340.48e2a40c@bahia.lan>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/12Oh8o5aneL_d60QqfnvoXv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG5EX2.mxp5.local (172.16.2.42) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 427d9d9d-7c35-41a0-bd09-a27184234a54
X-Ovh-Tracer-Id: 17227394476430825976
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrkeeggdduhedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtihesghdtreerredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepueeiueejheehueeihfelteeuieduvefguddtjeevieffffefgedtkeehheeltddvnecuffhomhgrihhnpehgnhhurdhorhhgnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtoheprhhthhesthifihguughlvgdrnhgvth
Received-SPF: pass client-ip=46.105.77.235; envelope-from=groug@kaod.org;
 helo=10.mo51.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 17:33:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/12Oh8o5aneL_d60QqfnvoXv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 25 Oct 2020 11:13:40 +0100
Greg Kurz <groug@kaod.org> wrote:

> On Thu, 22 Oct 2020 15:11:42 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Mon, Oct 19, 2020 at 10:47:52AM +0200, Greg Kurz wrote:
> > > Hi,
> > >=20
> > > This is a followup to a previous cleanup for the sPAPR code:
> > >=20
> > > https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg04860.html
> > >=20
> > > The last two patches had to be dropped because they were wrongly assu=
ming
> > > that object_property_get_uint() returning zero meant failure. This le=
d to
> > > a discussion in which arose a consensus that most of the time (not to=
 say
> > > always) object property getters should never fail actually, ie. failu=
re
> > > is very likely the result of a programming error and QEMU should abor=
t.
> > >=20
> > > This series aims at demonstrating a revelant case I've found while au=
diting
> > > object property getters (this is patch 4 that I've isolated from a hu=
ge
> > > 50-patch series I haven't dared to post yet). The sPAPR memory hotplu=
g code
> > > is tailored to support either regular PC DIMMs or NVDIMMs, which inhe=
rit
> > > from PC DIMMs. They expect to get some properties from the DIMM objec=
t,
> > > which happens to be set by default at the PC DIMM class level. It thus
> > > doesn't make sense to pass an error object and propagate it when gett=
ing
> > > them since this would lure the user into thinking they did something =
wrong.
> > >=20
> > > Some preliminary cleanup is done on the way, especially dropping an u=
nused
> > > @errp argument of pc_dimm_plug(). This affects several platforms othe=
r than
> > > sPAPR but I guess the patch is trivial enough to go through David's t=
ree
> > > if it gets acks from the relevant maintainers.
> >=20
> > Since this series mostly affects ppc, I've applied it to ppc-for-5.2.
> >=20
> > It would be nice to have an acked-by from Igor or Michael for the
> > first patch, though.
> >=20
>=20
> David,
>=20
> Igor sent a R-b for patches 1 and 4. He also suggested to call
> spapr_drc_attach() at pre-plug time. I'll look into this, so maybe
> you can drop patch 5 from ppc-for-5.2 (or the entire series at
> your convenience).
>=20

It seems that spapr_drc_attach() cannot be called at pre-plug time
actually because there is no way to call spapr_drc_detach() if
the device fails to realize. I think you there's nothing else to do
for this series than adding Igor's r-b to patches 1 and 4.

> Cheers,
>=20
> --
> Greg
>=20
> > >=20
> > > ---
> > >=20
> > > Greg Kurz (5):
> > >       pc-dimm: Drop @errp argument of pc_dimm_plug()
> > >       spapr: Use appropriate getter for PC_DIMM_ADDR_PROP
> > >       spapr: Use appropriate getter for PC_DIMM_SLOT_PROP
> > >       spapr: Pass &error_abort when getting some PC DIMM properties
> > >       spapr: Simplify error handling in spapr_memory_plug()
> > >=20
> > >=20
> > >  hw/arm/virt.c                 |    9 +-------
> > >  hw/i386/pc.c                  |    8 +------
> > >  hw/mem/pc-dimm.c              |    2 +-
> > >  hw/ppc/spapr.c                |   48 +++++++++++++++----------------=
----------
> > >  hw/ppc/spapr_nvdimm.c         |    5 +++-
> > >  include/hw/mem/pc-dimm.h      |    2 +-
> > >  include/hw/ppc/spapr_nvdimm.h |    2 +-
> > >  7 files changed, 25 insertions(+), 51 deletions(-)
> > >=20
> >=20
>=20


--Sig_/12Oh8o5aneL_d60QqfnvoXv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl+V7xIACgkQcdTV5YIv
c9bw6Q//ZjDFnELrWp5Nix2HeZZunmF3Ni4N24euTPymX5W/SejDCjW/whUec1Ck
C25MxSlyOVJLpLpFBpCjoAlfPDfnLwD5VsO17Emo2jQg9FWQybR431I6waVk5JOX
ljWf3En2N+gO0IDKq/QB+11SShMG6ORjCIvh9Kpub3PDSCIgCPoqvSRN0Zx07gVh
TU4CzQg6WygegU0ze8Ppcm7NETletxJNHJEp9vkoq/HHMuQzmLPFahLNqiLvAGCl
vYIM4Q7hJOOwP6pjt67v8wE6dPrXHahkecvvxGnG2w92bBGwwxsjlCRS1/5peeov
R1IPb4NrN6heVevSad3WPvQIirBstJ4jDVA8o5aDsqIGluXRZKGgeH9JAgyee2Vc
3NXMjH7CR/Qi+1gUZvMOcZ0o1RirEgxSv3awoKQ4dZD61w2B+RBh0iDdy9RS3wgA
ZedDTO9daGWMB9ctBigSSDGshNKfbIQfHLsnakeU8N9ZMSqeb8mCCC4x5923dCdo
i3CVhTzwBGXrYFgQ/KqBNZf3z/FAGAOJv9ocdaH2zGKhijsXZAtXEfBn2vB4aBxM
dX+wjSljhgT4L4hRtjLtWzde4V1eBk8eZRt0Fy2ArkO0gnZvJgLWFfVrH1vayT+3
ouZkRTDXU1QHHh/OQ9Q79o4Mz5s7bAnYQ46jqNgNfSVWRZw6KSE=
=Bk+V
-----END PGP SIGNATURE-----

--Sig_/12Oh8o5aneL_d60QqfnvoXv--

