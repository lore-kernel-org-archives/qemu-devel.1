Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56C4C742A8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 06:47:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0CAD20863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 06:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="B5xFDI41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CAD20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlpKj-0003yQ-B3
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 02:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54085)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hlpKO-0002z9-Im
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 02:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hlpKM-0004Cv-KA
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 02:46:44 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:44599 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hlpKI-00046c-Pb; Fri, 12 Jul 2019 02:46:41 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45lNkD0R1gz9s00; Fri, 12 Jul 2019 16:46:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562913988;
 bh=A7+kQPzp3+3T7SunwnSbjrkEYBYeMfQ9Dr4oZ4/aIcQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B5xFDI41sm7fBx15+rH0tdKm5mLSBLo2tWB5zETs/kRqRsGwG9+mTAduHmUTptMWm
 B0Iz/nRmzcTYEvMxZNBZbIvTtM/rYIrYkVJfxAsbssusZ7aNW6RH98dKuE+hFOvCL0
 vmeNj5RtOXGHoZcUY5vXlOnYVxnPu8lRU1fbsQao=
Date: Fri, 12 Jul 2019 16:40:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <20190712064051.GG2561@umbus.fritz.box>
References: <20190712011934.29863-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bO4vSxwwZtUjUWHo"
Content-Disposition: inline
In-Reply-To: <20190712011934.29863-1-mdroth@linux.vnet.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] spapr: Implement H_TPM_COMM for
 accessing host TPM device
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
Cc: linuxram@us.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--bO4vSxwwZtUjUWHo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2019 at 08:19:32PM -0500, Michael Roth wrote:
> These patches are also available at:
>=20
>   https://github.com/mdroth/qemu/commits/spapr-tpm-hcall-v0
>=20
> This patchset implements the H_TPM_COMM hypercall, which provides a way
> for an Ultravisor to pass raw TPM commands on to a host's TPM device,
> either directly or through a TPM Resource Manager (needed to support
> multiple guests).
>=20
> Secure Guests running on an Ultravisor have a symmetric key that is
> encrypted using a public key that is bound to a trusted host's TPM
> hardware. This hypercall provides a means to decrypt the symmetric
> key on behalf of a Secure Guest using the host's TPM hardware.
>=20
> More details are provided in the spec summary introduced in patch 1.

This is obviously 4.2 material, other comments on the individual patches.

>=20
>  docs/specs/ppc-spapr-uv-hcalls.txt |  74 +++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++
>  hw/ppc/Makefile.objs               |   1 +
>  hw/ppc/spapr.c                     |  27 +++++++++++++++++++++++++++
>  hw/ppc/spapr_hcall_tpm.c           | 135 +++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++
>  hw/ppc/trace-events                |   4 ++++
>  include/hw/ppc/spapr.h             |   7 ++++++-
>  6 files changed, 247 insertions(+), 1 deletion(-)
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bO4vSxwwZtUjUWHo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0oK3IACgkQbDjKyiDZ
s5IaEA/5AXtJhrjWFFHV8Gu0fGUP4jJ5UDayIp6pSeJPsUF5LUs9DGN8k/lR2HXO
nkHxuoIzorKrRv+D1x3lJgGTxloSotl9RKZLyEe1k9W2jk2tA4MTo9ce6606Sfla
twAfYlgDPtOpGSNzn9TqFl0y/h3ZBq25SIBcPWzA8hcr0ZEfPG49Ymm7ilz5gDGv
270swPY90+WclkYWn6JnIjgtesAST6yK+K/qcB0D7GRHAMzARpuKR37hDEgIIlEo
VU0XyLLk9zVrsvZLHNIq/LHc69DCgwROpi2qTf4rvbWUqdI6SCqAkyjc2OiLRP4t
WB36tnDJlQSI6n3aGeGaVRVWWSGStu8WPMwgUkEClQJgC+Bs9DaBPxvlSzQiBLVH
wTRzVE2VqwMo281AYfoBXlJnhoqWB0FRSw6nHwwzTJiEVNbJ+vInkCSKuOKcV8fg
A+MDXCnUe/QMwGNJ435l/5AIwJk7eh+/CPJGmfCqpOM4VmlpcmtV0pDjydVr8t4Z
tSxYzEpSTO1D1U+D4tXdq6cyySS1j+igR63hucjk3YgQ139XSl9q098H7+749wLI
cK20qSTY26OhVejNc+xvW/2m9NZQHmXM2fO/dmLRo5tvhMMLHpvHjKzBGSPCCDhE
1JJH5LvyX4puFgbb+yG7egqUFVkwKxYKBNqN8F9L2F0U3cKc8Fc=
=2Mw8
-----END PGP SIGNATURE-----

--bO4vSxwwZtUjUWHo--

