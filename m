Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E4BC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:20:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C17A520872
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gI5iHOOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17A520872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBeIb-0001NF-0T
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kBeHu-0000Ds-6M; Fri, 28 Aug 2020 09:19:26 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:48967)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kBeHr-0004P3-UB; Fri, 28 Aug 2020 09:19:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BdKtp3kK7z9sTC; Fri, 28 Aug 2020 23:19:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1598620754;
 bh=wF0mu/aSv7U+JgvulayvwcMK4i+owkrDLQraXMUnyUM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gI5iHOOoGtSaLuM1k+gVxm46QlaHw1lcbxg4NUSHkft0+sOUpMs43MWdRJZvF00Z+
 Q80+pv7rAoc5I5Ko83q4dNq9kMtdhVkPx0Z935+TrUqAuMrsyU5FXNi1YgQ/MRch1k
 E7KRO57giHkDts4r68xh2wLKT62ZwOvuk+oD1RUU=
Date: Fri, 28 Aug 2020 23:17:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 0/3] spapr NVDIMM: consider 'nvdimm' machine option
Message-ID: <20200828131741.GA36360@yekko.fritz.box>
References: <20200825215749.213536-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20200825215749.213536-1-danielhb413@gmail.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2020 at 06:57:46PM -0300, Daniel Henrique Barboza wrote:
> This series aims to solve bug [1].
>=20
> First patch is a trivial cleanup, feel free to squash into
> patch 02. Patch 02 attempts a code simplification to put
> all NVDIMM related logic in the same function.
>=20
> Patch 03 is where the actual fix is implemented. My initial
> approach here was to make the handling of '-machine nvdimm' for
> pSeries similar to how it is handled elsewhere, but I wasn't
> able to accomplish that without either (1) breaking up existing
> pseries-5.1 guests that didn't care about this option or (2)
> make pseries-5.1 and pseries-5.2+ machines to have different
> semantics for it.
>=20
> I ended up doing what I was sure was sensible: if the user puts
> '-machine nvdimm=3Doff', we must comply to that.

Applied to ppc-for-5.2, thanks.

>=20
>=20
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D1848887
>=20
> Daniel Henrique Barboza (3):
>   ppc/spapr_nvdimm: use g_autofree in spapr_nvdimm_validate_opts()
>   spapr, spapr_nvdimm: fold NVDIMM validation in the same place
>   ppc/spapr_nvdimm: do not enable support with 'nvdimm=3Doff'
>=20
>  hw/ppc/spapr.c                | 18 ++++++------------
>  hw/ppc/spapr_nvdimm.c         | 31 +++++++++++++++++++++++++++----
>  include/hw/ppc/spapr_nvdimm.h |  4 ++--
>  3 files changed, 35 insertions(+), 18 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9JA/MACgkQbDjKyiDZ
s5LpLw/8DS6S93n0m7HgByo2T1fQk3wo8yzM+OroltDmxCU4ipNKMYW74bZRM9dF
CbGDuUCn/NXLfKpV/yV9DlYOJMSmMhtNwClCMotYzUsZ1JpjP6k17Di/sXI2hhRP
gbjErJ4U0t9C5Hr+vj/rcB7C6YhJvu1yGEY0bwyj/qhb0AmOgLxZ5MnOqmg7fwfs
70J/+OuiWoObauCNw4uRcMINZRE+wQUbV+Urs5lWYj+9e3LR6vqyHB02wMGH+Qwv
W0Aojh/UfDSzmTUwp0LVB7E7+ln9mFe91D95rMfmS8pDSxMhnojZGAw5iFafhWd5
JhE40Qrx8eTA93d3/38f6kSwpphX87caW5v20OcktjYeE5GiA8teZOfZIPlu9SjJ
Buz/yZrkmwDu1Tofdj7a7uJq8zeMJvfZMlJ2HrrDL+OVrFbEdZoMzaOHpym9A7Ix
j4hIYLShZ8xOTUtPClaSdIddfB+mg+6nDb/9LYhPouX1u5zoxAcG8ckGzASw7/0Y
MCNWcnjGGbBzQ5YSuGf5XJRq0kPyqfZ1EWWtzw7Atp3T0h8B+/VwGUCDOEA97Jmy
bCUwJU+airw1pVfUM8cTezhxw0qk9Q6nj1he/2PKGqP6gsWTJgGX6MAExkKgQYcR
ViqT3SekxUXMabqffclPHAqTl8RQKcEF2Eu3jpWF0o8dXYdugPE=
=0WF1
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--

