Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F006AC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A632082F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XYBM+yOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A632082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2NZf-0002Gd-W5
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 18:07:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j2NQy-00075Q-Mu
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:58:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j2NQx-0006V4-8x
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:58:12 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:34085 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j2NQw-0006Gj-BZ; Thu, 13 Feb 2020 17:58:11 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48JX3Z67X0z9s29; Fri, 14 Feb 2020 09:58:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581634682;
 bh=X1vgOpqyDNmAZ02SAi1Zjqk0fxNRP35hkvyITlY5dlw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XYBM+yOByVYFjTL46IxzTY1+KdyfdOnTU+mYQSqJtBLvLeHfZu/p5xBtZzZd2wrfY
 OdyfkRz5n1zY3+btnpPKwXvweMGM6I8gZEbnvSUYPg7KhMEL0+8+4HYsg7bp8nhCJ7
 gN+F5dd87TSucaWVX+ljOn+FmHn/fL3w/yNKyEJM=
Date: Fri, 14 Feb 2020 09:56:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 1/2] spapr: Disable legacy virtio devices for
 pseries-5.0 and later
Message-ID: <20200213225650.GH124369@umbus.fritz.box>
References: <20200213005837.131791-1-david@gibson.dropbear.id.au>
 <20200213005837.131791-2-david@gibson.dropbear.id.au>
 <20200213153425.53b5c53c@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="l06SQqiZYCi8rTKz"
Content-Disposition: inline
In-Reply-To: <20200213153425.53b5c53c@bahia.lan>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: pair@us.ibm.com, mst@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, clg@kaod.org, mdroth@us.ibm.com, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--l06SQqiZYCi8rTKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2020 at 03:34:25PM +0100, Greg Kurz wrote:
> On Thu, 13 Feb 2020 11:58:36 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > PAPR specifies a kind of odd, paravirtualized PCI bus, which looks to
> > the guess mostly like classic PCI, even if some of the individual
> > devices on the bus are PCI Express.  One consequence of that is that
> > virtio-pci devices still default to being in transitional mode, though
> > legacy mode is now disabled by default on current q35 x86 machine
> > types.
> >=20
> > Legacy mode virtio devices aren't really necessary any more, and are
> > causing some problems for future changes.  Therefore, for the
> > pseries-5.0 machine type (and onwards), switch to modern-only
> > virtio-pci devices by default.
> >=20
> > This does mean we no longer support guest kernels prior to 4.0, unless
> > they have modern virtio support backported (which some distro kernels
> > like that in RHEL7 do).
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index cb220fde45..6e1e467cc6 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -65,6 +65,7 @@
> > =20
> >  #include "hw/pci/pci.h"
> >  #include "hw/scsi/scsi.h"
> > +#include "hw/virtio/virtio-pci.h"
> >  #include "hw/virtio/virtio-scsi.h"
> >  #include "hw/virtio/vhost-scsi-common.h"
> > =20
> > @@ -4567,7 +4568,14 @@ static void spapr_machine_latest_class_options(M=
achineClass *mc)
> >   */
> >  static void spapr_machine_5_0_class_options(MachineClass *mc)
> >  {
> > -    /* Defaults for the latest behaviour inherited from the base class=
 */
>=20
> Hmm... and so it seems we still have to carry this around when we
> add a new machine version. At least, that's what I had to do when
> adding a dummy 5.1 machine. This is because it is the old machine
> type that calls the class_options() function of the new one, not
> the other way around.

Uh.. no. It can just go in latest_class_options.  I thought I'd
already moved it there, but obviously not.  I've fixed that up for the
next spin.

> I was thinking about adapting Michael's patch. Instead of having
> a class_options() function that we only call for the latest
> machine type, we need a function that sets the default behaviour
> and call it for all machine types (which can still change the
> behaviour in their own class_options() function).

This will be confusing in a different way.  It will reset the default
options on each of the chained old machine types, which means anything
set in the "default" options needs to be overriden in *all* old
machine types that don't want it, not just the latest which doesn't
want it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--l06SQqiZYCi8rTKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5F1C8ACgkQbDjKyiDZ
s5IUjBAAkiCCHnyzVMzfq4xng8thPYhPLgBuvtTtEX/hhqaDCCBKV/cGXRpGjkqB
oK/pjwr6OQ3kvv0Np8xCxvEbddS+u0KScTGlltN3mQzDR22P/yCk2BQ7LxXvkbX5
gYhPcs7Cauq1h8jk0VggnHAMlcOjPhRvTLHw8A9NSTHFlGy8bqXGWPhnRgdWs6jI
evvuAElkphoeNwAKhedh1qJRe98hlqieeMhy2jScnIfAahpbg7FZ7qO388415tXk
eFCJ1k8NRrikeHA0yS4CChWybse8rlsSRJ9k6/+nGfC5SvBpV+HkxVOJCkxhhluH
RR+qziitmIGxO+dnTxshHDWvQ58JFxNAqNQmPSsKGmRyedyiviqt3K9uvTQ8vWGS
hO38X8Y5RucJawjBP/n/fmzDYJiriDymWFZ/G5gxilrhvBBCxJAfbpSC2q2cYYsP
HyeMIgYPeyMoHUhkN3srYKRW4kJnqObvfYgYuM5BWkVp2H6Yu0v+NuCYNPt7V2+f
50zY+VORl+9qyJcYxii1CoWf4kVBTCLmVXtAojQGFJJtmbErY9Wl3PnrslZQzPnp
/okBxRl+uqa0VIsSwOfyCTzsxJC9yNKv8T7Y7M9OUuKKCmB3+50RKz5wbWfPM1CS
cuwPrU3BZ/pGe2d6P8hxJTldAp/ku0l7gfoLvYkzJhYF+VR4BoA=
=XVds
-----END PGP SIGNATURE-----

--l06SQqiZYCi8rTKz--

