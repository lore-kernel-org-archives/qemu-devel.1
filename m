Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D5BC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 11:16:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09950207FD
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 11:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09950207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieH1M-00027d-6J
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 06:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ieH0R-0001Tc-6q
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:15:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ieH0P-0003E3-Su
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:15:10 -0500
Received: from 1.mo178.mail-out.ovh.net ([178.33.251.53]:59172)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ieH0P-0003CN-ME
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:15:09 -0500
Received: from player729.ha.ovh.net (unknown [10.108.42.66])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 61CD083754
 for <qemu-devel@nongnu.org>; Mon,  9 Dec 2019 12:15:07 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player729.ha.ovh.net (Postfix) with ESMTPSA id 8315CD36D47A;
 Mon,  9 Dec 2019 11:14:58 +0000 (UTC)
Date: Mon, 9 Dec 2019 12:14:55 +0100
From: Greg Kurz <groug@kaod.org>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [for-5.0 PATCH 0/4] ppc: Fix interrupt controller emulation
Message-ID: <20191209121455.17193284@bahia.w3ibm.bluemix.net>
In-Reply-To: <20191209120735.4fe6e4ea.cohuck@redhat.com>
References: <157548861171.3650476.14824062174573272058.stgit@bahia.lan>
 <20191209011428.GE2482@umbus.fritz.box>
 <20191209115947.2fb92760@bahia.w3ibm.bluemix.net>
 <20191209120735.4fe6e4ea.cohuck@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/V76gIZgmaJaz+YlPYQujAVK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 3223169961448610242
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeltddgvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtdefreertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejvdelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.251.53
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/V76gIZgmaJaz+YlPYQujAVK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Dec 2019 12:07:35 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Mon, 9 Dec 2019 11:59:47 +0100
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Mon, 9 Dec 2019 12:14:28 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > On Wed, Dec 04, 2019 at 08:43:31PM +0100, Greg Kurz wrote: =20
> > > > Guest hangs have been observed recently on POWER9 hosts, specifical=
ly LC92x
> > > > "Boston" systems, when the guests are being rebooted multiple times=
. The
> > > > issue isn't POWER9 specific though. It is caused by a very long sta=
nding bug
> > > > when using the uncommon accel=3Dkvm,kernel-irqchip=3Doff machine co=
nfiguration
> > > > which happens to be enforced on LC92x because of a host FW limitati=
on. This
> > > > affects both the XICS and XIVE emulated interrupt controllers.
> > > >=20
> > > > The actual fix is in patch 1. Patch 2 is a followup cleanup. The ot=
her
> > > > patches are unrelated cleanups I came up with while investigating.
> > > >=20
> > > > Since this bug always existed and we're already in rc4, I think it =
is better
> > > > to fix it in 5.0 and possibly backport it to stable and downstream =
if needed. =20
> > >=20
> > > Applied to ppc-for-5.0.
> > >=20
> > >  =20
> >=20
> > According to Cornelia's comments, it seems I need to respin this against
> > the s390-next branch to avoid conflicts.
>=20
>=20
> Aren't these ppc-only patches, though? Confused.

Oops... I've mixed up with the CPUReset series, sorry for the confusion :-)

--Sig_/V76gIZgmaJaz+YlPYQujAVK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl3uLLAACgkQcdTV5YIv
c9ZgvRAAh/Rh7F9ohWa3rSEdBGB3AvvnfARcW1O/QSLcl23BNWn9FAyY7Co35kAS
1HV312e2UrCEdTanmtqFDGoErQl7zWOsCuZTQy9CemLxcr1l40hGzbkjO70C5irm
7JUUc797sr2doGoKqQG860UcfuROFLDMXvl2+gb1eYxYOHE+lrbwZPZ7MZk2hheB
wedtsmfpkvLv347EXX2vbBiY4R2hsC6oWVFA0TUmK822LlHrivftItVOcY3bOROF
gWXqqpJ6NowNs4EUm5zkRhpQwjwzbjIDi14Y2KCFn9p/Py8iu5TOiqzKCGWC13rt
UyN4syUqva3oYskMC9YCMTT0RsGpdhGkLqNCOF3hfLk4TzpGjeW8Y9rckuwwgYV6
3IlFNkLLQymTAFZsm7ZNgwphzJxLSkMNf+2aH6CSVjpewU89b/UnJ50hrhq+zylv
L/h9s2tlzLiRnXDBUUoxSSZGH2ROJ1GsOKmTLaMSZrvNLM3sloYOCcNfpwyEyWP8
3m9HAdUKEhA7qo0hhZn+oPSNgNTW89pwiCfIGdlPiz223Wts0w+s0mIEq5O956p9
LtmqGwWoK5jA84F1Z2b/6h9LhTFyvqu884/+1ZaeylRbI7Ps/QafV2ev8FQGQGpC
/MyvmGgnRAA7RsNjR1DciI9dBVOVTePGLQtPn9Y9bem5QglepZ4=
=ZAxA
-----END PGP SIGNATURE-----

--Sig_/V76gIZgmaJaz+YlPYQujAVK--

