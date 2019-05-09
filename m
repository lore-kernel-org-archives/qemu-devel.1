Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F13DC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 05:46:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 285502053B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 05:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PaEi65Rb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285502053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48374 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hObtG-0007g2-FH
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 01:46:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hObof-0003Q6-M7
	for qemu-devel@nongnu.org; Thu, 09 May 2019 01:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOboe-0001ev-9z
	for qemu-devel@nongnu.org; Thu, 09 May 2019 01:42:01 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:54843)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hObod-0001ZX-Jr; Thu, 09 May 2019 01:42:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 4502KB6NWTz9sD4; Thu,  9 May 2019 15:41:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557380510;
	bh=NkVlvdV0uGTjk/2Af9y53Hhd5h0R2lQlTGMcrSEYleU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PaEi65RbXMOJNM5bkTsYcLu0nnJ0jQgqYFBAElySaO+EnUUKu/CUZi3IYPn3bzpQX
	DPAtQloZioMLIVt88xMJzgB+6sjG7lV5TwXV1fuCV/LN9fNq44rOOiRle7JHuIDIhP
	J1PeBAC0c5k+VTiHxkbyhQzG74ncuHuir+eGpXK0=
Date: Thu, 9 May 2019 15:40:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190509054000.GT7073@umbus.fritz.box>
References: <20190508171946.657-1-clg@kaod.org>
	<20190508171946.657-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aEcIyhw0mmnxygNd"
Content-Disposition: inline
In-Reply-To: <20190508171946.657-3-clg@kaod.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 2/3] spapr/xive: fix EQ page addresses
 above 64GB
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


--aEcIyhw0mmnxygNd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2019 at 07:19:45PM +0200, C=E9dric Le Goater wrote:
> The high order bits of the address of the OS event queue is stored in
> bits [4-31] of word2 of the XIVE END internal structures and the low
> order bits in word3. This structure is using Big Endian ordering and
> computing the value requires some simple arithmetic which happens to
> be wrong. The mask removing bits [0-3] of word2 is applied to the
> wrong value and the resulting address is bogus when above 64GB.
>=20
> Guests with more than 64GB of RAM will allocate pages for the OS event
> queues which will reside above the 64GB limit. In this case, the XIVE
> device model will wake up the CPUs in case of a notification, such as
> IPIs, but the update of the event queue will be written at the wrong
> place in memory. The result is uncertain as the guest memory is
> trashed and IPI are not delivered.
>=20
> Introduce a helper xive_end_qaddr() to compute this value correctly in
> all places where it is used.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>  include/hw/ppc/xive_regs.h | 6 ++++++
>  hw/intc/spapr_xive.c       | 3 +--
>  hw/intc/xive.c             | 9 +++------
>  3 files changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> index bf36678a242c..1a8c5b5e64f0 100644
> --- a/include/hw/ppc/xive_regs.h
> +++ b/include/hw/ppc/xive_regs.h
> @@ -208,6 +208,12 @@ typedef struct XiveEND {
>  #define xive_end_is_backlog(end)  (be32_to_cpu((end)->w0) & END_W0_BACKL=
OG)
>  #define xive_end_is_escalate(end) (be32_to_cpu((end)->w0) & END_W0_ESCAL=
ATE_CTL)
> =20
> +static inline uint64_t xive_end_qaddr(XiveEND *end)
> +{
> +    return ((uint64_t) be32_to_cpu(end->w2) & 0x0fffffff) << 32 |
> +        be32_to_cpu(end->w3);
> +}
> +
>  /* Notification Virtual Target (NVT) */
>  typedef struct XiveNVT {
>          uint32_t        w0;
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 666e24e9b447..810435c30cc7 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -1150,8 +1150,7 @@ static target_ulong h_int_get_queue_config(PowerPCC=
PU *cpu,
>      }
> =20
>      if (xive_end_is_enqueue(end)) {
> -        args[1] =3D (uint64_t) be32_to_cpu(end->w2 & 0x0fffffff) << 32
> -            | be32_to_cpu(end->w3);
> +        args[1] =3D xive_end_qaddr(end);
>          args[2] =3D xive_get_field32(END_W0_QSIZE, end->w0) + 12;
>      } else {
>          args[1] =3D 0;
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index a0b87001da25..dcf2fcd10893 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1042,8 +1042,7 @@ static const TypeInfo xive_source_info =3D {
> =20
>  void xive_end_queue_pic_print_info(XiveEND *end, uint32_t width, Monitor=
 *mon)
>  {
> -    uint64_t qaddr_base =3D (uint64_t) be32_to_cpu(end->w2 & 0x0fffffff)=
 << 32
> -        | be32_to_cpu(end->w3);
> +    uint64_t qaddr_base =3D xive_end_qaddr(end);
>      uint32_t qsize =3D xive_get_field32(END_W0_QSIZE, end->w0);
>      uint32_t qindex =3D xive_get_field32(END_W1_PAGE_OFF, end->w1);
>      uint32_t qentries =3D 1 << (qsize + 10);
> @@ -1072,8 +1071,7 @@ void xive_end_queue_pic_print_info(XiveEND *end, ui=
nt32_t width, Monitor *mon)
> =20
>  void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor *mo=
n)
>  {
> -    uint64_t qaddr_base =3D (uint64_t) be32_to_cpu(end->w2 & 0x0fffffff)=
 << 32
> -        | be32_to_cpu(end->w3);
> +    uint64_t qaddr_base =3D xive_end_qaddr(end);
>      uint32_t qindex =3D xive_get_field32(END_W1_PAGE_OFF, end->w1);
>      uint32_t qgen =3D xive_get_field32(END_W1_GENERATION, end->w1);
>      uint32_t qsize =3D xive_get_field32(END_W0_QSIZE, end->w0);
> @@ -1101,8 +1099,7 @@ void xive_end_pic_print_info(XiveEND *end, uint32_t=
 end_idx, Monitor *mon)
> =20
>  static void xive_end_enqueue(XiveEND *end, uint32_t data)
>  {
> -    uint64_t qaddr_base =3D (uint64_t) be32_to_cpu(end->w2 & 0x0fffffff)=
 << 32
> -        | be32_to_cpu(end->w3);
> +    uint64_t qaddr_base =3D xive_end_qaddr(end);
>      uint32_t qsize =3D xive_get_field32(END_W0_QSIZE, end->w0);
>      uint32_t qindex =3D xive_get_field32(END_W1_PAGE_OFF, end->w1);
>      uint32_t qgen =3D xive_get_field32(END_W1_GENERATION, end->w1);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aEcIyhw0mmnxygNd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzTvTAACgkQbDjKyiDZ
s5LVwQ//UC8pcwLLn1l4QP1KFkQF47zOut1RAmFSZt13IyVSgQGGobEadRw8cR1U
Mjj63PDaBJBwf9CI6q/U8dGUXB+QaT6yW7+4W0QOG0Y7p5ixoCbPYuQZOVDFiIuN
21MQAaCk2KJlGZmJmeBXd14ozb4kvRTrp9eVtzTbSpbduCD/6AXm+JFTe/2cmyuG
woy6R4AVEV/GTAEHPeQCqqICfeabGNTS0NHCILiY4Uct40eKviHzU+YIwfWPPhwE
V3jzsA621r6elS/i61cmVZRKCpm/XgiOiaa/6g39gwAQOC30QOXMmkVrBOhOk696
006/kMrxmcJszmLkrsH8YqqRdCa+PXn5G51Keq+ikwD/IyexvS4VTftw8Xd/8NEh
huKNdtGFwuFFZSQXzBfeLd0Ct79c4gBLttOmCDMBhY3pN9teTceJLtrmKH3miB4J
8Vj+QEPJr67sDQ2tKXfszViod0zzA2MoO9zJPCvd8C5koohPco+9N/7Uk6rO4gfM
FPQHsQZXaqjH81uD1xahPEkOBtD6cpeyCZRWCbBkTNEtTt9g4kr7OCieUVJZxj9X
qpUBqH0pRmyKod1D74zZae/IYeWuG4Pyna8tbPZxDo7aFPqhBbSnH+QmSIwRgeKI
ovtWhdWvdYI0/loSenERQ3U2tKAwssMpo2pmIygTXomaYcj12ec=
=EGqM
-----END PGP SIGNATURE-----

--aEcIyhw0mmnxygNd--

