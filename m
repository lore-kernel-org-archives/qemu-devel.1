Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D662C33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 04:21:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22998217BA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 04:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oG9PkkKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22998217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irDhO-00042J-8p
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 23:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1irDgg-0003Qs-Um
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 23:20:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1irDge-0006EQ-TO
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 23:20:18 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:34733 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1irDgb-00061u-LZ; Mon, 13 Jan 2020 23:20:15 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47xcgS31zTz9sPn; Tue, 14 Jan 2020 15:20:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578975604;
 bh=2G8XNmcmq56/NRqi7/o5EbK91/Yl6iDxVUBLEyYwtJM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oG9PkkKY0PRyaTWURuLv6DKUNNdF4dslNczDWg1cl5RDoNnsoiGMZHiZrUxltp46n
 lavXyMWMB9+Ld2VLY/nwEGTQEzRusaDeTdJNKUdy3Pf/RAlRZ7c0yyJ4oQ9Hchpgwh
 ghVIqiCsRmv9n9AtcxLG2CmdoJW9lgJ2OstkPGKI=
Date: Tue, 14 Jan 2020 12:11:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 5/7] target/ppc: Add privileged message send facilities
Message-ID: <20200114021131.GJ19995@umbus>
References: <20191128134700.16091-1-clg@kaod.org>
 <20191128134700.16091-6-clg@kaod.org>
 <20191217040048.GM6242@umbus.fritz.box>
 <8f906ec1-bc56-3e14-640a-572c862f4bea@kaod.org>
 <20200109014521.GJ8586@umbus.fritz.box>
 <2f676176-1fcf-8753-12bc-8d2c9fb94061@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Encpt1P6Mxii2VuT"
Content-Disposition: inline
In-Reply-To: <2f676176-1fcf-8753-12bc-8d2c9fb94061@kaod.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Encpt1P6Mxii2VuT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2020 at 08:13:38AM +0100, C=E9dric Le Goater wrote:
> >>>>  void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
> >>>>  {
> >>>> -    int irq =3D book3s_dbell2irq(rb);
> >>>> +    int irq =3D book3s_dbell2irq(rb, 1);
> >>>
> >>> true/false are preferred to 0/1 for bool types.
> >>
> >> yes or a define ?
> >=20
> > Sorry, I don't understand the question.  The second argument to
> > book3s_dbell2irq() is a 'bool' type, so the parameter should be 'true'
> > rather than '1'.
>=20
> Yes. I was thinking of adding defines for the 'true' and 'false' value
> to clarify what the parameter is doing. But it does not seem really=20
> useful now.

You don't need your own defines, they already exist.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Encpt1P6Mxii2VuT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4dI1AACgkQbDjKyiDZ
s5LXXRAAwVgDRIj6f/VIu+8239lCewCjb4ANAC13W84lhh2MmRSEJJdQm/EJzZvQ
F3UVYktN1XYWGf3k6DlLa8thzqx+ERgJUMxyHjDsbJZ4exmpe73fejR7R2IQSh1v
OKWmuotbddvf6RXTxItKPyuY4EeAPxSrwAQhv5Oa3jUM5ui4DoKlA6Gf18zyg0Nb
NLQAJT20sUlyWzQogqpoYyXlpiQmYJCZrXKoOw0iUAG7ghIw32AYvu1s94ksXwbJ
a68ftPgQCXnzXRPRXY/jEBSaYJRJmGBu6mvsMpzFPN22YQYqvyFuiPBjPbep9SdV
laXBPBpTS673RhDHc+fv0vrgqfUcj+yOcR61MJkPQ8zT1u4sLXlc4X1XOwAoKqom
lfWepv21Ty4TsmdnNRSSnL219WP7fv93IdEYvdnFQ8QTU8UFK2SZpZoIPSNMEV2j
zmGEYBM9dVv7pJzlv3H1nzVZ4pn1qwrENu0mzv2w9EETI16eBumdOG8pu9aPVytN
UV3sJn0jmCWAS09G6OYshiWWeCsk6Ei3N/QuQSHHg8+lgpwwxr7pGpcl49JTHzVV
fyUVk1AGHtVCgHA8A0N6Tyi/TMObxQuYuunm5I8eBCy/qlXFlNxm+rWwVo1QUOsj
DelwmSwv3SKBZURzD9fIObOprL98hSyKSwyCG7t0Mon/mNUDCMY=
=p5JT
-----END PGP SIGNATURE-----

--Encpt1P6Mxii2VuT--

