Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BFAC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 05:43:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE592053B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 05:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oINT04KE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE592053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48316 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hObqW-0004is-0i
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 01:43:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hObog-0003Qg-AM
	for qemu-devel@nongnu.org; Thu, 09 May 2019 01:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hObof-0001fV-4C
	for qemu-devel@nongnu.org; Thu, 09 May 2019 01:42:02 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:40231 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hOboe-0001ZI-E0; Thu, 09 May 2019 01:42:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 4502KB5cNRz9sBr; Thu,  9 May 2019 15:41:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557380510;
	bh=u0RCeZzCbmldhb+JRNB3Fb33PDYzCE+hnE7neIl+AuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oINT04KEccVxXetvO5ui9EVTPyj1aDo0MjIkn0GzWEd9oKP710DmHiKR9QyiQdh1X
	LuU7b0/Q4hWn24Mg8+2gxnfbLLrEywDapv4IxFC2b1NmLwAl4yPDDPbQcdm7BNT6Z9
	KYi42WaNPth34+iTQPmFF9tCpEw10fQ4xytMtOq0=
Date: Thu, 9 May 2019 15:40:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190509054031.GU7073@umbus.fritz.box>
References: <20190508171946.657-1-clg@kaod.org>
	<20190508171946.657-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pzbqGaOtRNiVr7w4"
Content-Disposition: inline
In-Reply-To: <20190508171946.657-4-clg@kaod.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 3/3] spapr/xive: print out the EQ page
 address in the monitor
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--pzbqGaOtRNiVr7w4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2019 at 07:19:46PM +0200, C=E9dric Le Goater wrote:
> This proved to be a useful information when debugging issues with OS
> event queues allocated above 64GB.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>  hw/intc/spapr_xive.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 810435c30cc7..7faf03b1fb7c 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -120,6 +120,7 @@ static int spapr_xive_target_to_end(uint32_t target, =
uint8_t prio,
>  static void spapr_xive_end_pic_print_info(SpaprXive *xive, XiveEND *end,
>                                            Monitor *mon)
>  {
> +    uint64_t qaddr_base =3D xive_end_qaddr(end);
>      uint32_t qindex =3D xive_get_field32(END_W1_PAGE_OFF, end->w1);
>      uint32_t qgen =3D xive_get_field32(END_W1_GENERATION, end->w1);
>      uint32_t qsize =3D xive_get_field32(END_W0_QSIZE, end->w0);
> @@ -127,9 +128,9 @@ static void spapr_xive_end_pic_print_info(SpaprXive *=
xive, XiveEND *end,
>      uint32_t nvt =3D xive_get_field32(END_W6_NVT_INDEX, end->w6);
>      uint8_t priority =3D xive_get_field32(END_W7_F0_PRIORITY, end->w7);
> =20
> -    monitor_printf(mon, "%3d/%d % 6d/%5d ^%d",
> +    monitor_printf(mon, "%3d/%d % 6d/%5d @%"PRIx64" ^%d",
>                     spapr_xive_nvt_to_target(0, nvt),
> -                   priority, qindex, qentries, qgen);
> +                   priority, qindex, qentries, qaddr_base, qgen);
> =20
>      xive_end_queue_pic_print_info(end, 6, mon);
>      monitor_printf(mon, "]");

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pzbqGaOtRNiVr7w4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzTvU4ACgkQbDjKyiDZ
s5J9kQ/+PH38gSr4N05voUowWefVDdDQyAR24yr/Ac578HnDa0ImN5DYLakwqGix
gkaoBA7h4NdFxhsIUbFQLVh+QIReFHsCzTUOZlmSBWneRrbgSApxcymYx7Fpy+ng
OWdslKUfZN3Kn7RoHPfTpNloDp+U76zj85rtAXyaESsgyMiNpHXZnbf4/ETfYMTK
jVUjBbUPbMPbkQX1J3nXxzypydlcQsgeJW12SQjK8Ie7xa6k0xNGugzndZPZJYSV
8tpFwyaC7VVmSycOHCfaib7+4XhpT6J/qv2ztjEWVmZQqNW2847LOQ4unJVn3AYZ
AFNX/9FQUm1ECJw9o9xHWiWal/I4sc0VUeg7Mn2iDplUOlF6+JYmqlrwfk5Lr42F
taQXMyXPsBAggZV1V0mFAKn/3I7PrtMzV6bciAWoxOV5rQxIX2m0PmmCm7pA5yj2
bRMU46stiJtKiDkqIYZDHZOIy/QYv7VVdy4d4Y82OFCtrEmkU0r3qk/eFnvui5jt
KaaHD/pMK/SoBF7+EaM5WFlGNprnCKiYV5SkPtVPDcW5RMRWaLoEzJ4lCclTYoUp
CZXiitrrw3lLu2GGEAUEcRjwrDQ1gZqgtYF+EXG4Z3VUu1XmdaE935VjJaMvYSM9
TUg/FTObE2MU+v3MkgghT2yoIHeLrZwZWy+cMNdTSc+Zg7uLVDk=
=ps4d
-----END PGP SIGNATURE-----

--pzbqGaOtRNiVr7w4--

