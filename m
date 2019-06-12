Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81108C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 03:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 474AB20B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 03:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jeYuH1f7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474AB20B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36786 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbGg1-0000s0-FV
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 23:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57580)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hbGc8-000561-Vw
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 23:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hbGc4-0006nd-LO
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 23:41:22 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:43169 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hbGc2-0006hR-8b; Wed, 12 Jun 2019 23:41:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45PTzp2TLqz9sDX; Thu, 13 Jun 2019 13:41:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560397270;
 bh=Glcflht8/5c2cwvi5mt7EBIj+Ghntwcsz5GB3vFXp3c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jeYuH1f7efcPWDSxQtY2LAQvkNXDQ6Ned8FMhYBK/WDK6Zszqux+1o06yRAwCKJoI
 gU8L8L8gKeAtZoiVFbopTTaii4RRvviJjsCQ4+H8vwPStxwflupb3xiXj28/cH9vyg
 +buR4eWHd+hJMtFCKYGTe+V1RT7HMwPM6SJ6Dk9s=
Date: Thu, 13 Jun 2019 09:56:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190612235627.GE26378@umbus.fritz.box>
References: <20190612230202.878-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SNIs70sCzqvszXB4"
Content-Disposition: inline
In-Reply-To: <20190612230202.878-1-philmd@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [RFC PATCH] spapr_pci: Fix Null pointer
 dereferences in spapr_dt_pci_bus()
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
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2019 at 01:02:02AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Commit 14e714900f6 refactored the call to spapr_dt_drc(),
> but used an incorrect object owner as argument.
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
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Nack.  The bus bridge is the correct owner in most cases here.  It
*used* to be that all the PCI DRCs were owned by the PHB, but that's
intentionally not the case with the changes to allow hotplug under P2P
bridges.

AFAICT, the bus parameter does have to be non-NULL from both callers,
so I think the correct fix is to remove the test on if (bus) earlier
in the function.

> ---
>  hw/ppc/spapr_pci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 957ae88bbd..e0cd3f11f1 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1364,8 +1364,7 @@ static int spapr_dt_pci_bus(SpaprPhbState *sphb, PC=
IBus *bus,
>          }
>      }
> =20
> -    ret =3D spapr_dt_drc(fdt, offset, OBJECT(bus->parent_dev),
> -                       SPAPR_DR_CONNECTOR_TYPE_PCI);
> +    ret =3D spapr_dt_drc(fdt, offset, OBJECT(sphb), SPAPR_DR_CONNECTOR_T=
YPE_PCI);
>      if (ret) {
>          return ret;
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SNIs70sCzqvszXB4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0BkSgACgkQbDjKyiDZ
s5JGWg/+KiignT1Y+Ob22gLNbOqgGff5T3e42QEPzCumtwLhxZDPT/OyXVo24uuZ
CAZ4lkLX4eMgkueMo03JRnr6jhLQ+MBtypL49nVzSibHvPVPXMtaNyn17zAoshO/
EAKIo8hJVqFSn9u/JiDVcTJiNgy4qbJjZySNPIYW+C7MI+3YD+QW1MNeNLYKRUtj
9SoIC92Mnptl08e+3hENRAmxOS0WfgmuJ/Lu0dJEMTw9LWuoQjJn0QJAjc9xv2Q6
/wemhZPRv33FDDtm+hXUi1y7p5cj6b4S7c86FYEBGDeqTNIAcV4HQrgwS+Wq2Cey
wi34BV6CSooFdtqMwLiSZAcHEUURdSsV2sewvjUrTXg7/avJ0ZauidGBYcvQHsLa
TS1Qfa5HHPwLeqSesV8JKM0+dUx+cujhqMUL0PauJjqbd+HtJheXqBSTD/P1S4pu
OSclaBBzkZKh4xAu0aUE0SQ+9BITOsJ7ERDQJC4fYquvVBOYEBvdxsDZzxPLC471
KeOVLB71A38qInnJhOpV6UQSXnIXvO1D2qC1qe/nlZIPuaVWyINoKFJXKpBQ4doe
CxzYgyg8jDWYBP9F9funiyD3PWpOz8rMQfrvnuIpDs/DRD2CxZ2c0CrHizcyPQUb
3x1ihBD08PCS2uKkO2KIfXtFuJLZdyspsUr56e6voNl25KnVwag=
=Su7x
-----END PGP SIGNATURE-----

--SNIs70sCzqvszXB4--

