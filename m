Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE64C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E30222BE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E30222BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDOuj-0005wB-NH
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 04:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDOtl-0005Mn-Bo
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:13:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDOtk-000560-7e
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:13:13 -0400
Received: from 14.mo7.mail-out.ovh.net ([178.33.251.19]:60443)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDOtk-0004vW-0u
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:13:12 -0400
Received: from player771.ha.ovh.net (unknown [10.108.42.239])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 6F1C413178F
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 10:13:07 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player771.ha.ovh.net (Postfix) with ESMTPSA id 41735A3EC6CA;
 Thu, 26 Sep 2019 08:13:02 +0000 (UTC)
Date: Thu, 26 Sep 2019 10:13:00 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] spapr/irq: Fix migration of older machine types with XIVE
Message-ID: <20190926101300.6fa73adc@bahia.lan>
In-Reply-To: <20190926013808.GV17405@umbus>
References: <156942766014.1274533.10792048853177121231.stgit@bahia.lan>
 <20190926013808.GV17405@umbus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/rxAyO1_3rtlQHn2a+=veLSX"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 8291689866541767142
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.251.19
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
Cc: qemu-ppc@nongnu.org, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/rxAyO1_3rtlQHn2a+=veLSX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Sep 2019 11:38:08 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Sep 25, 2019 at 06:07:40PM +0200, Greg Kurz wrote:
> > Recent patch "spapr/irq: Only claim VALID interrupts at the KVM level"
> > broke migration of older machine types started with ic-mode=3Dxive:
> >=20
> > qemu-system-ppc64: KVM_SET_DEVICE_ATTR failed: Group 3 attr 0x000000000=
0001300: Invalid argument
> > qemu-system-ppc64: error while loading state for instance 0x0 of device=
 'spapr'
> > qemu-system-ppc64: load of migration failed: Operation not permitted
> >=20
> > This is because we should set the interrupt source in KVM at post load,
> > since we no longer do it unconditionaly at reset time for all interrupt=
s.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >=20
> > David,
> >=20
> > I guess you should probably fold this fix directly into Cedric's
> > patch (currently SHA1 966d526cdfd9 in ppc-for-4.2) to avoid
> > bisection breakage.
>=20
> Done.
>=20

Ok, I see it in ppc-for-4.2. Just one cosmetic nit, missing ']' in
the updated changelog:

[dwg: Folded in fix up from Greg Kurz

> > ---
> >  hw/intc/spapr_xive_kvm.c |   11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >=20
> > diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> > index 71b88d7797bc..2006f96aece1 100644
> > --- a/hw/intc/spapr_xive_kvm.c
> > +++ b/hw/intc/spapr_xive_kvm.c
> > @@ -678,6 +678,17 @@ int kvmppc_xive_post_load(SpaprXive *xive, int ver=
sion_id)
> >              continue;
> >          }
> > =20
> > +        /*
> > +         * We can only restore the source config if the source has been
> > +         * previously set in KVM. Since we don't do that for all inter=
rupts
> > +         * at reset time anymore, let's do it now.
> > +         */
> > +        kvmppc_xive_source_reset_one(&xive->source, i, &local_err);
> > +        if (local_err) {
> > +            error_report_err(local_err);
> > +            return -1;
> > +        }
> > +
> >          kvmppc_xive_set_source_config(xive, i, &xive->eat[i], &local_e=
rr);
> >          if (local_err) {
> >              error_report_err(local_err);
> >=20
>=20


--Sig_/rxAyO1_3rtlQHn2a+=veLSX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl2McwwACgkQcdTV5YIv
c9bzCBAAmiMeZyr2FiJH/cb59HQHv+KilJNwp++EIOYXwvtz9Ewp36mB8cVQ/NrQ
pwoFec6sRcuw8rHA/AxghkFeZHiMlHvLpSB0LVgh2jlL3yZoItX/Kxgd5lcSqqBo
P+cwlB6NXj/N7BzC9Hvwiv3rfdPfdViMToUJB1pGT+66MdFAHsZBUMOSdtzzHPGa
k+nsVUjuwABUmIzHgF3TUiiKQnx4PUQrVCOJ4pgSKieNj2evhcPwfuK9bVzqEFlY
c2y178HrjB67Rrq6g3FMpqNTdXN0Oecn8ABooTavDm3noG8YKUghMj8Tcn46BRO8
PXFHZc6Vm+oKZIG4B+KL4Ng8wJICsP2gdNBsVOfXepvQWgQjVVL56Aroht5wj9fK
rqAGzZ0cy+glaYbDJHyU7a4u8elpjJDbPnUWNLRXyLvwJz7LztR67lqNV59jM1vC
5N8DKWu0dWlcg7AYE74SL8GE4T9lhfbb8xdXWCuncbRw6EC4du2J5cN6ISpjOhLs
mibxr4y2nbI7YqA+MhhOYJ8sv5KyYcgzRxsqahIlorzhPwwPBKB95BSud0w85C5n
zoghTjLsjZAHaSdF9GXvl3HcN1TA8IKCsETaMXnl1JRDGg/eYmh1vVJK1tJmF1om
2O0sAqxl3w+onNWFn7hlvPTByzYuGhDkf8QxI6Xqy9IZueeFTZI=
=qmpF
-----END PGP SIGNATURE-----

--Sig_/rxAyO1_3rtlQHn2a+=veLSX--

