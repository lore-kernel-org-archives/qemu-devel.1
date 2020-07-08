Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2310C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 02:08:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD62620708
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 02:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aDy6/h8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD62620708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jszVW-0004ES-0o
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 22:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jszUo-0003gY-4W; Tue, 07 Jul 2020 22:07:38 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:48161)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jszUk-0004Se-15; Tue, 07 Jul 2020 22:07:37 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B1jPC51Ldz9sSt; Wed,  8 Jul 2020 12:07:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594174047;
 bh=pYWBgI9plRPgFBf4T6QgHDLsOOaqFOOOQasS2xVVdWs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aDy6/h8waJIZdZNZytK6yUHwBCMMcaYOXq1Z1aq53wafNG5Wbx+lW4dqQG6RPgOVp
 1qHXOygUbU7jkA2Kz9xt+4Gu/ECx26F6subhRwrrrh91XSwamWx24jA83zRmF7XgrT
 5CsbLANZndSOiHY88wOyHFNcE/gsCj54DlHYmjVU=
Date: Wed, 8 Jul 2020 12:01:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] ppc/pnv: Make PSI device types not user creatable
Message-ID: <20200708020103.GF18595@umbus.fritz.box>
References: <159413975752.169116.5808968580649255382.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3yNHWXBV/QO9xKNm"
Content-Disposition: inline
In-Reply-To: <159413975752.169116.5808968580649255382.stgit@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3yNHWXBV/QO9xKNm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2020 at 06:35:57PM +0200, Greg Kurz wrote:
> QEMU aborts with -device pnv-psi-POWER8:
>=20
> $ qemu-system-ppc64 -device pnv-psi-POWER8
> qemu-system-ppc64: hw/intc/xics.c:605: ics_realize: Assertion
> `ics->xics' failed.
> Aborted (core dumped)
>=20
> The Processor Service Interface Controller is an internal device.
> It should only be instantiated by the chip, which takes care of
> configuring the link required by the ICS object in the case of
> POWER8. It doesn't make sense for a user to specify it on the
> command line.
>=20
> Note that the PSI model for POWER8 was added 3 yrs ago but the
> devices weren't available on the command line because of a bug
> that was fixed by recent commit 2f35254aa0 ("pnv/psi: Correct
> the pnv-psi* devices not to be sysbus devices").
>=20
> Fixes: 54f59d786c ("ppc/pnv: Add cut down PSI bridge model and hookup ext=
ernal interrupt")
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.1.

> ---
>  hw/ppc/pnv_psi.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 75b8ae9703d0..653b41774c34 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -937,6 +937,7 @@ static void pnv_psi_class_init(ObjectClass *klass, vo=
id *data)
>      dc->desc =3D "PowerNV PSI Controller";
>      device_class_set_props(dc, pnv_psi_properties);
>      dc->reset =3D pnv_psi_reset;
> +    dc->user_creatable =3D false;
>  }
> =20
>  static const TypeInfo pnv_psi_info =3D {
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3yNHWXBV/QO9xKNm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8FKNwACgkQbDjKyiDZ
s5JMsxAAkNCYFq+EBk7KSr73nBIcPw8itm+YQ2+FKMmp41uNfYt2vUrv2rrZ3O/W
t9b0WSNBcOg/XGRC7IIX98SVBNB5mCWB0EQsX0lAvOwQTwjm1zfEdCMTMA/TlM+A
5xN2hq66TEFCuQiM0477eNOk69uX0XafiYZYS3mvMHhLss20uRp0mte0EqvDDn6G
cEizzEanUXni4HQNX1qbyuj3FbdkSysDzu8TvIx70Zc5AiK03gXoRHjSlrUTnUOo
OYwKOKkQeF/6u9l2w5JML3ZD5lgvu+G45ncrM8isIAL+AuuGFlOsn5nclddr4lr4
B0NDCCDwgXe+OmpxMfleVCGiAkh946DtUdA5jDxIFqrk70t7BMgCEymMj4Vs0442
QgmesFyC8O8zpvIM/quEqU2ot5qFBLTYPXCOylyCbuzthMZuMCL7AG3D8rxmm2jI
X4dYa/mOr4Vs4IIJWesQnHLSTgnlzk1ytvW8N1RDeWLagT0ZFvEDvnx0sNdjIhQE
osNfCMxozzlfvu22n7dADxNYNrDGloA29XlshgqfNrvv2MjWBcu2KmaZi/fTLwU6
YUndFbGjz4plP3hj6jMIMdbj0G6kOrk6L2/m5IVYNWjcaM4L3DqlcHif168mqzu+
uQxfX0EDgo0Nb7d4Aol9XsYuE8SvHbFPO3ND1oKsLvNsm6NRVuI=
=BJXN
-----END PGP SIGNATURE-----

--3yNHWXBV/QO9xKNm--

