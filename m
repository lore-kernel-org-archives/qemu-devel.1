Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F7FC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 01:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1972054F
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 01:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="G/Zthzkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1972054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ5HZ-000759-13
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 21:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jJ5Fn-0005Cs-57
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jJ5Fm-0002mZ-06
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:59:43 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:50595 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jJ5Fl-0002kA-2j; Mon, 30 Mar 2020 20:59:41 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48rrZc607Wz9sPF; Tue, 31 Mar 2020 11:59:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585616376;
 bh=q31xvCFOKPbpPGRLDs7OK80eHHOyLWM3hQzkERkRadc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G/ZthzknFXonJkT/cg7wb9CgfSob0t+I7+y+ql/hvWZyU14ysoLm4DWoYHW87MJkz
 WrYbSp4VZiaAnVhDlbed1JJAN56RObhYuDKrkCZJK05gyZds/QyQWCnHL4xScf2lUn
 CSjpAdWWuKVsRCOGvyKeVOvAYeFflBf1Pnv+7kwA=
Date: Tue, 31 Mar 2020 11:58:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 2/7] target/ppc: Introduce a relocation bool in
 ppc_radix64_handle_mmu_fault()
Message-ID: <20200331005839.GE47772@umbus.fritz.box>
References: <20200330094946.24678-1-clg@kaod.org>
 <20200330094946.24678-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="T6xhMxlHU34Bk0ad"
Content-Disposition: inline
In-Reply-To: <20200330094946.24678-3-clg@kaod.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2020 at 11:49:41AM +0200, C=E9dric Le Goater wrote:
> It will ease the introduction of new routines for partition-scoped
> Radix translation.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-5.1.

> ---
>  target/ppc/mmu-radix64.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index 99678570581b..f6007e956569 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -229,12 +229,13 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, v=
addr eaddr, int rwx,
>      uint64_t lpid =3D 0, pid =3D 0, offset, size, prtbe0, pte;
>      int page_size, prot, fault_cause =3D 0;
>      ppc_v3_pate_t pate;
> +    bool relocation;
> =20
>      assert((rwx =3D=3D 0) || (rwx =3D=3D 1) || (rwx =3D=3D 2));
> =20
> +    relocation =3D ((rwx =3D=3D 2) && (msr_ir =3D=3D 1)) || ((rwx !=3D 2=
) && (msr_dr =3D=3D 1));
>      /* HV or virtual hypervisor Real Mode Access */
> -    if ((msr_hv || cpu->vhyp) &&
> -        (((rwx =3D=3D 2) && (msr_ir =3D=3D 0)) || ((rwx !=3D 2) && (msr_=
dr =3D=3D 0)))) {
> +    if (!relocation && (msr_hv || cpu->vhyp)) {
>          /* In real mode top 4 effective addr bits (mostly) ignored */
>          raddr =3D eaddr & 0x0FFFFFFFFFFFFFFFULL;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--T6xhMxlHU34Bk0ad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6Clb8ACgkQbDjKyiDZ
s5LAYRAAgQJ/c7FApusZN45fuv5VrYs1P7+ZZ8Y/uNlnGTfmaPGWK5iwvyPeDR1h
uf+Wh20lEJo8vUjGXbbTqvMcIptT7hcPkHHvqAoUPCzsiUK/b9DwwdLU9tXU8yT5
GGs3AQPAk+JCGj+C3VYUYDsFJNADF+zSMvJhj3pTwEg1LrwSUnu/twQWg/CCeDl0
kZ7oS2ush+mSwueBNCdCS2rsEG2d55Ak4uxSOEHROimOuRx7HoYSiebzP+eI0HCn
fOQzNGWruKdY/0f3ji1PitR+KR/q6dbglq9NyZWAl+S6OoX75okwDFc0MVBSosHT
ufjtURk+/lImdM08WGHUE67menabi/Pm8FttH1dgPMcrZ4SK8ANq+ArjJd87+uHe
t2AvnnCokRQ37HEofYLP9U2rNvWQoX+d9hk7k2NOBlMMnxABVcDRNnfyvzop5WGL
2I5Vy7+w9xejmHZG/W6CRWGumTbBvbHlp9pT382kVEc2W92m4kfNeRgTNu3Rq7FC
NbmpuhQFggneXSXzeEP+doaPfndDA236DYo2jA6lHydOMbtvNreQIm1guVKUKkV6
daz5EoBdRSVVwgLIHbNcNmq+cDPfjwPfOGls5uiLIgvQxJ3/Db9I1pxnH9THUMJ9
hDYR186b95JNpFj90jnho38n1WbiY7YZVxXaJaPQ906sNAms0RE=
=W03G
-----END PGP SIGNATURE-----

--T6xhMxlHU34Bk0ad--

