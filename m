Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2905CC04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 02:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F5A2182B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 02:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="j7koJyrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F5A2182B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35843 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOvl4-0001ak-19
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 22:59:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOvjJ-0000Ul-Ew
	for qemu-devel@nongnu.org; Thu, 09 May 2019 22:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOvjI-00019M-4r
	for qemu-devel@nongnu.org; Thu, 09 May 2019 22:57:49 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59757 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hOvjH-00015w-CT; Thu, 09 May 2019 22:57:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 450ZdM1l7Xz9sNm; Fri, 10 May 2019 12:57:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557457063;
	bh=Ns1db8FlMwXt7WCGWY8UcGaO1YT9pMk1HBSxHSCDXuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7koJyrKGTAs46UTeR5OnCxA3IzA9u/1l9Eyx8qvcBXdCS3y2x3gA8ENvFF8pKsA2
	1bFw9VN97gSd2k4nOCLR2W84OReK5IOIWhrL0y4VWQrASfyIFPlVNlrsHuCTfuK9CD
	IIqbn3xwCqO5rKynSZPJxJhLZNVicxNieNwnF6Ho=
Date: Fri, 10 May 2019 12:11:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190510021121.GB20559@umbus.fritz.box>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
	<20190503055316.6441-7-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
In-Reply-To: <20190503055316.6441-7-sjitindarsingh@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 06/13] target/ppc: Enforce that
 the root page directory size must be at least 5
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
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2019 at 03:53:09PM +1000, Suraj Jitindar Singh wrote:
> According to the ISA the root page directory size of a radix tree for
> either process or partition scoped translation must be >=3D 5.
>=20
> Thus add this to the list of conditions checked when validating the
> partition table entry in validate_pate();
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/mmu-radix64.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index a6ab290323..afa5ba506a 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -249,6 +249,8 @@ static bool validate_pate(PowerPCCPU *cpu, uint64_t l=
pid, ppc_v3_pate_t *pate)
>      if (lpid =3D=3D 0 && !msr_hv) {
>          return false;
>      }
> +    if ((pate->dw0 & PATE1_R_PRTS) < 5)
> +        return false;
>      /* More checks ... */
>      return true;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzU3ckACgkQbDjKyiDZ
s5JeAg//bjLQa4EnA7TnRijJrK9Fiq3XCwQ4K4r4aFn/b2kTBvKBdNxzBZqFq2CG
96G7tFNXc+PYiGXgF1NwITuPVNSZe3SXnU2l4UxL3BqN6Yn1gDO7D3NAzzXXuDOZ
tpOWGkjTGS2s6VdSwIwWTb27XEVnN5109EgpG6GIipzOSZj9O9DDH4m8Uuu0sQRk
8Li9Yitp82WSjjsoWKzW500KstnJbCXUxom8yniFmw9niShatRL2YJKXx6nTkuqx
8FDCOJrYCJbLuQz0qAbvkEPj2R1QcejLFSY3ADmRgaBhycoQnwW3PZu13sEeKIyE
g15SnaH2yBK8sCYPFUDGBnAsVEQMahfeJoVp7GfcElm0AnFIBVRiWKHsf+axzYqf
b+9VtM94wS1iCPMNRZrUNWrdGzwy8gi855jJLEtWRdJU9uHGxmY8hEsJDPDgQzJ2
wxl9ENo8t11GjXyql2hu5aX8k/GWPMH0nC9Dp9y3qzUGZ23jjgRmt9WGB/wmqBD/
+01tzWTGFSFgpjQ0zus+7Uf/k7RGRnbB/WrJxmLWR9sKkaARTJghTaneAD17acux
3s2IdHzE1cE3H8zrMFWhwSkA4Tn+8zBICwUYecaoJRV9lWC6qBK+56+SmWBpTGi8
uaRRP++fXuGlk2Z1NpHGQkMlCwbLq6hVFB2T/gT9c4CKKahFfwY=
=qPpx
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--

