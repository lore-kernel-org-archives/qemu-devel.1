Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816A0C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 07:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55C4825610
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 07:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C4825610
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48667 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWFgp-0008UO-IO
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 03:41:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hWFfz-0007vq-Bv
	for qemu-devel@nongnu.org; Thu, 30 May 2019 03:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hWFfy-00079u-7U
	for qemu-devel@nongnu.org; Thu, 30 May 2019 03:40:39 -0400
Received: from 8.mo1.mail-out.ovh.net ([178.33.110.239]:54216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hWFfw-00077k-T8
	for qemu-devel@nongnu.org; Thu, 30 May 2019 03:40:37 -0400
Received: from player756.ha.ovh.net (unknown [10.108.42.75])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 2BF5817BD0D
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 09:40:32 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player756.ha.ovh.net (Postfix) with ESMTPSA id 4F2DB58123E7;
	Thu, 30 May 2019 07:40:28 +0000 (UTC)
Date: Thu, 30 May 2019 09:40:27 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190530094027.169cf54b@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190530004049.GA2017@umbus.fritz.box>
References: <155915010892.2061314.10485622810149098411.stgit@bahia.lan>
	<20190530004049.GA2017@umbus.fritz.box>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/x7JOIa2VaC4=aoepJyfa3XO";
	protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 9867386783771367910
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddvkedguddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.110.239
Subject: Re: [Qemu-devel] [PATCH] spapr_pci: Improve error message
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/x7JOIa2VaC4=aoepJyfa3XO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 30 May 2019 10:40:49 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, May 29, 2019 at 07:15:09PM +0200, Greg Kurz wrote:
> > Every PHB must have a unique index. This is checked at realize but when
> > a duplicate index is detected, an error message mentioning BUIDs is
> > printed. This doesn't help much, especially since BUID is an internal
> > concept that is no longer exposed to the user.
> >=20
> > Fix the message to mention the index property instead of BUID. As a bon=
us
> > print a list of indexes already in use.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr_pci.c |    9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 97961b012859..fb8c54f4d90f 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1699,7 +1699,14 @@ static void spapr_phb_realize(DeviceState *dev, =
Error **errp)
> >      }
> > =20
> >      if (spapr_pci_find_phb(spapr, sphb->buid)) {
> > -        error_setg(errp, "PCI host bridges must have unique BUIDs");
> > +        SpaprPhbState *s;
> > +
> > +        error_setg(errp, "PCI host bridges must have unique indexes");
> > +        error_append_hint(errp, "The following indexes are already in =
use:");
> > +        QLIST_FOREACH(s, &spapr->phbs, list) {
> > +            error_append_hint(errp, " %d", s->index);
> > +        }
> > +        error_append_hint(errp, "\nTry another value for the index pro=
perty\n"); =20
>=20
> I like the idea, but I think newlines in error messages are frowned
> upon.  You certainly don't need the trailing one.
>=20

newlines are definitely not welcome in strings passed to error_report()
or error_setg(), but they are okay in hints and the trailing one is
actually required:

/*
 * Append a printf-style human-readable explanation to an existing error.
 * If the error is later reported to a human user with
 * error_report_err() or warn_report_err(), the hints will be shown,
 * too.  If it's reported via QMP, the hints will be ignored.
 * Intended use is adding helpful hints on the human user interface,
 * e.g. a list of valid values.  It's not for clarifying a confusing
 * error message.
 * @errp may be NULL, but not &error_fatal or &error_abort.
 * Trivially the case if you call it only after error_setg() or
 * error_propagate().
 * May be called multiple times.  The resulting hint should end with a
 * newline.
 */
void error_append_hint(Error **errp, const char *fmt, ...)
    GCC_FMT_ATTR(2, 3);


Cc'ing Markus for insights.

> >          return;
> >      }
> > =20
> >  =20
>=20


--Sig_/x7JOIa2VaC4=aoepJyfa3XO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlzviOsACgkQcdTV5YIv
c9aLFhAAuhkxJXMxhiukeY+ofAJVT62wJKsXV5ASyJT5c8UmaoZrTV+O9T7gM+e0
UHQbR6KZO4HkIF26eQvFlDqoS8xWIXqnfuotnjHF/9bcVV8zgYVqyxqbWcRr3VDM
rViz5CBFjuKfEELdOko2ksz59QT7Z+SZbhHBkdz/DTf5hDJQS3E/URcNBuCOc0vz
j+RREKzhuPyz+fG0tge3grimBTfy60vY/1pTQbwYd2GPBx1sVpueO94jrVxqtytt
6qP5fq1m3NbMFUaN+uuRxaC2iALT7XRZFgNZvXXgOErCXfQ+DTGlQREKDa4r3Kso
/QoF2izjPdyZuiKB9u3WJy5gaaMJbCgP471W6h4Qkaf1++Pp7eeJ0WpOfVUSaPgQ
Z8aRpiEOAxc9niHItFO595zO97CbUdgQi7MfGiE3IP0ByiVLgYTSuXIjpwTKhKon
nDivokYG9Zui0sA0Cny/BjxPMZVI64DJHfeUpday9VYefTHs1cGw3JJ8j6WEeg67
yO7tF5C9lScAaPmmIFVR+62giZOVvaKO7mtOHh8PkVIt3NnL2qTjOWS7897dTV+k
GtbaB0ahv+DvWGZoid+PpRLOSAyI3vbSCNUAMciVR5J8imwXY9953cpY7tSLqqon
482rdr7g45ie6M1sRTfiLjTr+g9SjuWE64ch5/xeRq+kGu3fd4A=
=JZFN
-----END PGP SIGNATURE-----

--Sig_/x7JOIa2VaC4=aoepJyfa3XO--

