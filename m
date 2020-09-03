Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C17C2BBD0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 01:57:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F3302072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 01:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="K1kghDxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3302072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDeVe-0001tE-CD
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 21:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDeUo-00006U-1L; Wed, 02 Sep 2020 21:57:02 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60837 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDeUi-0005bq-Vv; Wed, 02 Sep 2020 21:57:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BhkSd1Sl0z9sTh; Thu,  3 Sep 2020 11:56:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599098209;
 bh=c5hJwvVzIUhJzr/+IMqqT130AZxkMgZlaDh6HCv3KjA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=K1kghDxRkZouFDqADI/BlD+PwoGVKeKJkGZcmWekp68RnYcrOqiA8fstzj/grcPyO
 FFNT0TAZRibhnP+QYuh5Iy5vW+ZsqY19GzrTOLXTRXdTcVhMBbVa3V7vFvXeNgxRd4
 33kY7Cw3cTre09bVm9ktCQ/cdwqyWOBtZBD3fvLQ=
Date: Thu, 3 Sep 2020 11:46:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 7/7] spapr_hcall: h_home_node_associativity now reads
 numa_assoc_array
Message-ID: <20200903014645.GI1897@yekko.fritz.box>
References: <20200901125645.118026-1-danielhb413@gmail.com>
 <20200901125645.118026-8-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Az4VpBrmI9+OyhK/"
Content-Disposition: inline
In-Reply-To: <20200901125645.118026-8-danielhb413@gmail.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 20:05:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Az4VpBrmI9+OyhK/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2020 at 09:56:45AM -0300, Daniel Henrique Barboza wrote:
> home_node_associativity reply now uses the associativity
> values for tcpu->node_id provided by numa_assoc_array.
>=20
> This will avoid further changes in this code when numa_assoc_array
> changes values, but it won't be enough to prevent further changes
> if (falar aqui q se mudar o tamanho do array tem q mexer nessa
> funcao tambem, falar q a macro associativity() deixa a automacao
> de tudo mto unreadable)

Uh.. I'm guessing that was a note to yourself you intended to
translate before publishing?

>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  hw/ppc/spapr_hcall.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index c1d01228c6..2ec30efdcb 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1878,9 +1878,13 @@ static target_ulong h_home_node_associativity(Powe=
rPCCPU *cpu,
>                                                target_ulong opcode,
>                                                target_ulong *args)

You could move this function to spapr_numa.c as well (the name's a bit
misleading, but spapr_hcall.c isn't really intended to hold *all*
hcall implementations, just the ones that don't have somewhere better
to live).

>  {
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>      target_ulong flags =3D args[0];
>      target_ulong procno =3D args[1];
>      PowerPCCPU *tcpu;
> +    uint32_t assoc_domain1;
> +    uint32_t assoc_domain2;
> +    uint32_t assoc_domain3;
>      int idx;
> =20
>      /* only support procno from H_REGISTER_VPA */
> @@ -1893,13 +1897,21 @@ static target_ulong h_home_node_associativity(Pow=
erPCCPU *cpu,
>          return H_P2;
>      }
> =20
> +    /*
> +     * Index 0 is the ibm,associativity size of the node,
> +     * which isn't relevant here.
> +     */
> +    assoc_domain1 =3D smc->numa_assoc_array[tcpu->node_id][1];
> +    assoc_domain2 =3D smc->numa_assoc_array[tcpu->node_id][2];
> +    assoc_domain3 =3D smc->numa_assoc_array[tcpu->node_id][3];

Using all these temporaries is a little ugly.  Maybe do something like:
	uint32_t *assoc =3D smc->numa_assoc_array[tcpu->node_id];

Then just use assoc[1], assoc[2] etc. below.

> +
>      /* sequence is the same as in the "ibm,associativity" property */
> =20
>      idx =3D 0;
>  #define ASSOCIATIVITY(a, b) (((uint64_t)(a) << 32) | \
>                               ((uint64_t)(b) & 0xffffffff))
> -    args[idx++] =3D ASSOCIATIVITY(0, 0);
> -    args[idx++] =3D ASSOCIATIVITY(0, tcpu->node_id);
> +    args[idx++] =3D ASSOCIATIVITY(assoc_domain1, assoc_domain2);
> +    args[idx++] =3D ASSOCIATIVITY(assoc_domain3, tcpu->node_id);
>      args[idx++] =3D ASSOCIATIVITY(procno, -1);
>      for ( ; idx < 6; idx++) {
>          args[idx] =3D -1;

Better yet would be to make this handle an arbitrary length of assoc
array, further isolating this from the specifics of how we construct
the arrays.  Ideally, you'd call a common path with
spapr_numa_fixup_cpu_dt() to get the assoc array for a cpu, then here
just translate it into the in-register format the hcall expects.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Az4VpBrmI9+OyhK/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9QSwMACgkQbDjKyiDZ
s5JD4A/8Cd1rDmHVS97kTvzzd97zjjXOtLaRp41QyhnR+XrytEpkComS6SoxOWE7
x5XAjEBdQBS6MY3voCOxeMpSeVVoJ4vCAnI44Xl6F+OTpIXJG2DGyQi1mpJMgQuM
hpJBiAiDaxFoew4gWIl1SaBHqhdPjGk3ssz5yvJHRQ+y+a+GvXUnKRbBp7LyY1dM
qsq30YUXmeNvqarHsQgIMjJ213WFpOFcEhDQKbMQnCLBCQZmDTf1aCIIZENTfRqC
p28j5G5cNdwqHi39vLjKOFYaGwlzz6bG3pBzn4a+c8hKlhQlyKWqVv56N1QB9ajp
oe3Azchs7aNXWkV7iK31lV0wQ8wTq6+uRQ1uA3LW646U5Wq2nj//+pddUY5C5Iy1
OfIv5Hvi3V/e7vXTUBqYGRXCOsuWWOzJsEtyvBVVZswI9gmO7RZhPF1s/PrWg6zd
1Qx9i/5P1IAfxZ/kT4WFMaZVyGXHB56slIjTYe1oapYdNP8M1ebZOVVe4TLGKY1f
CCLiB4DpEaNJXNayiYgPRQLoj+zfXl9wLT/9j6SdGjU9Ha3u/fgOZUqjxdROtKTR
BvCU3rn/sBo2UtO2EKiNJFHeHi51G4E0TkmPk6YKVuekhuzYB7L//JQBMRnH0SdJ
kvbg0nEx66iTxFK06FgTu70KJBbvqH1Kqw9h1Qfi2Q6ynAw0wK4=
=yudK
-----END PGP SIGNATURE-----

--Az4VpBrmI9+OyhK/--

