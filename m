Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673E8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 07:35:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B422070B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 07:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B422070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsLf6-0002k2-GN
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 03:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jsLe6-0001bf-1S
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 03:34:34 -0400
Received: from 7.mo173.mail-out.ovh.net ([46.105.44.159]:56595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jsLe3-0005Xx-U5
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 03:34:33 -0400
Received: from player779.ha.ovh.net (unknown [10.110.103.112])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id D3949144ACB
 for <qemu-devel@nongnu.org>; Mon,  6 Jul 2020 09:34:21 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player779.ha.ovh.net (Postfix) with ESMTPSA id 78455140A9E7C;
 Mon,  6 Jul 2020 07:34:13 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G0014494c1af-d210-4b67-90d6-1f3790b67fed,C4ABCEF356A601883B7DEB1AA4190402CFF29AFD)
 smtp.auth=groug@kaod.org
Date: Mon, 6 Jul 2020 09:34:12 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 00/11] Add several Power ISA 3.1 32/64-bit vector
 instructions
Message-ID: <20200706093412.51d3e514@bahia.lan>
In-Reply-To: <20200705091046.GE12576@umbus.fritz.box>
References: <20200701234344.91843-1-ljp@linux.ibm.com>
 <20200705091046.GE12576@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/X4wOqI4iMears9J0O04IOVW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 15275365514807056870
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -51
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddvgdduvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeejjeffgfeitdegtdehudeuudeitedtlefguddugfeujeejleeufeektdehheetgfenucffohhmrghinhepihgsmhdrtghomhdpsghogidrtghomhenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.44.159; envelope-from=groug@kaod.org;
 helo=7.mo173.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 03:34:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, richard.henderson@linaro.org,
 Lijun Pan <ljp@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/X4wOqI4iMears9J0O04IOVW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 5 Jul 2020 19:10:46 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Jul 01, 2020 at 06:43:35PM -0500, Lijun Pan wrote:
> > This patch series add several newly introduced 32/64-bit vector
> > instructions in Power ISA 3.1. Power ISA 3.1 flag is introduced in
> > this version. In v4 version, coding style issues are fixed, community
> > reviews/suggestions are taken into consideration.
>=20
> So, is the ISA 3.1 document available somewhere?
>=20

In https://www-355.ibm.com/systems/power/openpower/ there's a link to
the PDF:

https://ibm.ent.box.com/s/hhjfw0x0lrbtyzmiaffnbxh2fuo0fog0

> >=20
> > Lijun Pan (11):
> >   target/ppc: Introduce Power ISA 3.1 flag
> >   target/ppc: Enable Power ISA 3.1
> >   target/ppc: add byte-reverse br[dwh] instructions
> >   target/ppc: convert vmuluwm to tcg_gen_gvec_mul
> >   target/ppc: add vmulld instruction
> >   Update PowerPC AT_HWCAP2 definition
> >   target/ppc: add vmulld to INDEX_op_mul_vec case
> >   target/ppc: add vmulh{su}w instructions
> >   fix the prototype of muls64/mulu64
> >   target/ppc: add vmulh{su}d instructions
> >   target/ppc: add vdiv{su}{wd} vmod{su}{wd} instructions
> >=20
> >  include/elf.h                       |  1 +
> >  include/qemu/host-utils.h           |  4 +-
> >  target/ppc/cpu.h                    |  4 +-
> >  target/ppc/helper.h                 | 13 ++++-
> >  target/ppc/int_helper.c             | 75 ++++++++++++++++++++++++-----
> >  target/ppc/translate.c              | 43 +++++++++++++++++
> >  target/ppc/translate/vmx-impl.inc.c | 26 +++++++++-
> >  target/ppc/translate/vmx-ops.inc.c  | 27 +++++++++--
> >  target/ppc/translate_init.inc.c     |  2 +-
> >  tcg/ppc/tcg-target.h                |  2 +
> >  tcg/ppc/tcg-target.inc.c            | 12 ++++-
> >  11 files changed, 184 insertions(+), 25 deletions(-)
> >=20
>=20


--Sig_/X4wOqI4iMears9J0O04IOVW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl8C0/QACgkQcdTV5YIv
c9ZhbQ//fHBDAO+rrYhMrlQw8jnr9n1zen7EPnwpQ17XmK3sNKrzs50Q2dNkCvPL
YfDKjzvmgD0LeTuNvZmv8m2btoUOJBagQj8lTxH54RXtNlxVbrSHKyP+u/cO/HxK
NZW8fUJIhMtTEtGSYGHn6OsugyTzlJjpi8AIK9sfJ4yQudkeLDkjvtWW23iGtMth
y5FW56F3Do5lJ3fKrEVChnoM5wBxpiAD1+bGcN4aTs9snT/pqqQ3km7TKgPmyjWd
o7cUcFnH+K8xuR9bAMDE2t+g0h89l89C/z4XG2CD8Y9DYWt9VDioLv5uEhLpawIT
qm+vVp6x8lSv0cttl8xYXTR29aQYs9bmx8uZ5f91gy8v7GPtfg7sOSOx8IYQSfIE
NIQe4fsgq/UO1bsg8yJ9SAy28jJyY/leGWxL5Ct3GyXGqyXVKpY8v1gN6IIlLKPv
t2bjqFjvdQHhSKt9nWgtXznKK45dULit2jG2WsvbHtKtAbMNPs+zTfSW26sVEuWm
S3/5YgVj6NCstOjymy2jEcRv3Y6FQkTySM7+B8S1PPD2njQ5W5nObcXFw72R4/Cw
C0wssWKJ4LGJM0fs6vmuqr7smAACIBaR3H/3rh1fxXnia5SVM2jyQSSu4CqXGdvT
48r6kwy5SRxdh/dCdbSZa+4kM2oEtDQdJFQNlxm7aZ14iPlV1Jk=
=usUA
-----END PGP SIGNATURE-----

--Sig_/X4wOqI4iMears9J0O04IOVW--

