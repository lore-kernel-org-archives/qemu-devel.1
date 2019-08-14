Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC85C0650F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 03:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C4B2083B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 03:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CblfwF4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C4B2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxjqe-0005bM-UW
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 23:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1hxjpN-0004tD-6p
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 23:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hxjpL-0005nu-Ni
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 23:19:56 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:35043 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hxjpK-0005lP-G4; Tue, 13 Aug 2019 23:19:55 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 467ZZW69sNz9sNp; Wed, 14 Aug 2019 13:19:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565752787;
 bh=IzMf7f36YGH/vJGXu10+914DOL3fn71jN9dYLCffZ+c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CblfwF4vK8QUDR4lfXQCYP+J+VX5U+dEfF221+9U4hHaDW2KTlM/pR3PNfkOvAKFO
 BU4jCpKtULsw96iwFnQ0E+iSCcx/KplDixn7DXwCUWqlBbDJCEOK1KcgIstKnWY8na
 TfU6CSzV/YgzdNAJlHBVfogGp9SGa7+i1dBZVbi0=
Date: Wed, 14 Aug 2019 12:36:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190814023659.GA26205@umbus.fritz.box>
References: <20190813164420.9829-1-clg@kaod.org>
 <CAFEAcA-OmF+gOmhJjsaRVJVg1DAj5nXQz0rJ6wEFfAht+VSqnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-OmF+gOmhJjsaRVJVg1DAj5nXQz0rJ6wEFfAht+VSqnQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] spapr/xive: Mask the EAS when allocating
 an IRQ
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
Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2019 at 05:46:04PM +0100, Peter Maydell wrote:
> On Tue, 13 Aug 2019 at 17:44, C=E9dric Le Goater <clg@kaod.org> wrote:
> >
> > If an IRQ is allocated and not configured, such as a MSI requested by
> > a PCI driver, it can be saved in its default state and possibly later
> > on restored using the same state. If not initially MASKED, KVM will
> > try to find a matching priority/target tuple for the interrupt and
> > fail to restore the VM because 0/0 is not a valid target.
> >
> > When allocating a IRQ number, the EAS should be set to a sane default :
> > VALID and MASKED.
> >
> > Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > ---
> >
> >  David, this fixes a "virsh save/restore" issue in certain configuratio=
ns
> >  of CPU topology which never showed up before :/
> >
> >  Peter, I was busy on a KVM/passthru issue and lacked the time to
> >  investigate all ... you decide.
>=20
> rc5 has been tagged so this is definitely too late for 4.1.

Understood.  It's unfortunate, but I've merged this for 4.2, and I'll
look into stable branch and downstream backports.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1Tc8gACgkQbDjKyiDZ
s5Ktyg//VpS2EkaBvce+aHetEvq5UWRF6ydXUv0/kxKuSauAHH026p+W1hWt3Xoc
5J/u1LlhXQmgOZeF3v4+cH5/SdCNLPDT7io7JPOJcxTmi7zV+Bx3OIBm/k0j0C+W
6KIyHu7mUM+YXaAE78ojZ7OPDklIbIE7ibtYSLIV/JPBHW2giT0vqiCAIgdKQ3d/
Rswzf2ICiqCsU0eNT8COs9DrF2joopACB2upwRoFkguH0ZhNmrloRDewVgV3Hr/J
T4DibrlU1pleqYpycJEXmIdn8CecvjRnK1h/yFho7LDrZmVDT4r4tyjR9KOWiBm2
eB/O4aoGiommaUm1Ak2tWEieNvbbrftqVFdW741BuH3tEGm8N6vMOaRrnj/KDF+W
PlX3M6gNNNlWdUgHGsrZd5dVSoPqQm71RkDyo0/rxgE+HagS4s0NDVHcaOwqDyMQ
uTdyglO0HHPmhj2j2ieO7Z24Fk6Rw/wMQ4HybRkjIdsPFsWrhVoyEqU6QAltNcgx
04KSBguBqNozaI/AhxwTDa4L0hDosrH01ykSPDzjFygbKJqbDfVXBKhagA4VdIww
u7mPlTJyUPGJ3INHqOdBAYB7nxCW05XggVYK90BUnqGEMpVTqgB6g9y5OYOxNwlS
/Xa+uLPP4ngIe/QXTuPylOEWA/ZlAvS84L01QGf4f6F//8PO0RE=
=hxpj
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

