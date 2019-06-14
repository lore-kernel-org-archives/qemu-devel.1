Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF3CC31E45
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 01:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80703208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 01:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Gq3osKjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80703208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46624 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbbN3-0004lJ-J6
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 21:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56909)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hbbKz-0003Hi-RT
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 21:49:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hbbKy-0003OL-KY
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 21:49:05 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59759 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hbbKx-0003FY-5e; Thu, 13 Jun 2019 21:49:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45Q3Rt0Wkyz9sBr; Fri, 14 Jun 2019 11:48:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560476938;
 bh=2PblEQ6v+jEbOquTNZjJoEAKyfYbSuwoy9T43whjSoM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Gq3osKjVpYzYD04JDYrZPV+97dg2ukxSCaFw7z4OvqZHG0bMPyxTFVpJnjcQ20zqP
 xImO/L1yZQ39dk6C+XbpZtLZymnaOp3EIZOqnf76XyiH5RJCWQLiqCE+1DZWqDHfxm
 vLPXjuKMSLS8pZ0rjz72h0mW3hO/vyrc7WRG5EwA=
Date: Fri, 14 Jun 2019 11:32:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190614013252.GA4021@umbus.fritz.box>
References: <20190613213406.22053-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <20190613213406.22053-1-philmd@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v2] spapr_pci: Fix potential NULL pointer
 dereference in spapr_dt_pci_bus()
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
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2019 at 11:34:06PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Commit 14e714900f6 refactored the call to spapr_dt_drc(),
> introducing a potential NULL pointer dereference while
> accessing bus->parent_dev.
> A trivial audit show 'bus' is not null in the two places
> the static function spapr_dt_drc() is called.
>=20
> Since the 'bus' parameter is not NULL in both callers, remove
> remove the test on if (bus), and add an assert() to silent
> static analyzers.
>=20
> This fixes:
>=20
>   /hw/ppc/spapr_pci.c: 1367 in spapr_dt_pci_bus()
>   >>>     CID 1401933:  Null pointer dereferences  (FORWARD_NULL)
>   >>>     Dereferencing null pointer "bus".
>   1367         ret =3D spapr_dt_drc(fdt, offset, OBJECT(bus->parent_dev),
>   1368                            SPAPR_DR_CONNECTOR_TYPE_PCI);
>=20
> Fixes: 14e714900f6
> Reported-by: Coverity (CID 1401933)
> Suggested-by: Greg Kurz <groug@kaod.org>
> Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Applied, thanks.

> ---
>  hw/ppc/spapr_pci.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 957ae88bbd..fbeb1c90ee 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1356,12 +1356,11 @@ static int spapr_dt_pci_bus(SpaprPhbState *sphb, =
PCIBus *bus,
>      _FDT(fdt_setprop_cell(fdt, offset, "#size-cells",
>                            RESOURCE_CELLS_SIZE));
> =20
> -    if (bus) {
> -        pci_for_each_device_reverse(bus, pci_bus_num(bus),
> -                                    spapr_dt_pci_device_cb, &cbinfo);
> -        if (cbinfo.err) {
> -            return cbinfo.err;
> -        }
> +    assert(bus);
> +    pci_for_each_device_reverse(bus, pci_bus_num(bus),
> +                                spapr_dt_pci_device_cb, &cbinfo);
> +    if (cbinfo.err) {
> +        return cbinfo.err;
>      }
> =20
>      ret =3D spapr_dt_drc(fdt, offset, OBJECT(bus->parent_dev),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0C+UIACgkQbDjKyiDZ
s5IIAg/+Ki2gjg+f3jv79YlGGjotKry04tsfK6BZNcNxPXnfGyurn3fEaFPRXB08
7XT63zV5u2gJhOEzuNNRTSWmGkKKHbIw6KhyoA03JMqtcsv8X2EQtlmEirpUh1Mt
Q/9+8Z+6v/xRHovh951LbjhlGgAtzv62QEb/sDCeDAiqUF1Ifo9FYcbAr5IMjTSb
fWl+JZ/GoTWlNIZ8OYt5LFkTuDDIRfw9P7AQNB0pgWmpb5endL1BJa7aY+S8fmio
sxu6GA6fG1jQZWEmTxb8/KEP+1XN58+LE5cYa3B+/Vi5blR9d3k1Z3fRrZzdRCWZ
qU8Xp6vQUrhDX0opgEBGQcEc/NOsvH64NmilUgYuE6/SvMZei2pbRInu+mHjvbma
gd7VueGFQjsa5hb3Qz8JNRZE54mAQ3mEauj3J1x+pJeBqjhkHqHZaXvXXfy/Rnex
GoOKWnDIh8+5rHVEzoZ7+N0bFwKRZC5SCjT7nh5zEz2NWycEfoVXLkArk4Prt8CK
CItbX2VL2jOo15MW2eQf0T3wjdFVNI+pq0yYPfLgrahrvdxKce0JTwfHXYOE1Bav
ExRhsHzaG/ZOMJjXE6i1ci6kBbEX7Dj1JVFy2vrSS57FTYwVKn27oSZMR9YTi93l
ZPweSq05BqKbiLb/VlLj1BM6PjNO0SLvUF1Hxsnk5YIRTVJR2kc=
=If0G
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--

