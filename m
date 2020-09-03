Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD15C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 01:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439FA2072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 01:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="os6b1Vje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439FA2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDeWB-0002mc-Bp
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 21:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDeUn-00006T-SF; Wed, 02 Sep 2020 21:57:01 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:58751 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDeUi-0005bo-VF; Wed, 02 Sep 2020 21:57:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BhkSd31b0z9sTm; Thu,  3 Sep 2020 11:56:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599098209;
 bh=v3aST9MNftOGyuSLWQg5BuJzjT2jU+BBOq8T6BptK/c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=os6b1VjefpCrzvT44iAJvVXBW/WJAAENvGPrxP7wqd8/Sbf/hNEx/mjchTUL9EI35
 4dnspT0SHGBrKkFIuL2b0ZFgxy2/Ge2kfa8j8gLpyiFK95TTGlVhtp8saGHKofkAdW
 uYxTh4d4gJ2vquvRFDoe5adUzwhptuvcXYvdnRT4=
Date: Thu, 3 Sep 2020 11:51:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 3/7] spapr: introduce
 SpaprMachineClass::numa_assoc_array
Message-ID: <20200903015148.GK1897@yekko.fritz.box>
References: <20200901125645.118026-1-danielhb413@gmail.com>
 <20200901125645.118026-4-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KjSGHOmKKB2VUiQn"
Content-Disposition: inline
In-Reply-To: <20200901125645.118026-4-danielhb413@gmail.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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


--KjSGHOmKKB2VUiQn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2020 at 09:56:41AM -0300, Daniel Henrique Barboza wrote:
> The next step to centralize all NUMA/associativity handling in
> the spapr machine is to create a 'one stop place' for all
> things ibm,associativity.
>=20
> This patch introduces numa_assoc_array, a 2 dimensional array
> that will store all ibm,associativity arrays of all NUMA nodes.
> This array is initialized in a new spapr_numa_associativity_init()
> function, called in spapr_machine_init(). It is being initialized
> with the same values used in other ibm,associativity properties
> around spapr files (i.e. all zeros, last value is node_id).
> The idea is to remove all hardcoded definitions and FDT writes
> of ibm,associativity arrays, doing instead a call to the new
> helper spapr_numa_write_associativity_dt() helper, that will
> be able to write the DT with the correct values.
>=20
> We'll start small, handling the trivial cases first. The
> remaining instances of ibm,associativity will be handled
> next.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

The idea is great, but there's one small but significant problem here:

> +void spapr_numa_associativity_init(MachineState *machine)
> +{
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
> +    int nb_numa_nodes =3D machine->numa_state->num_nodes;
> +    int i;
> +
> +    /*
> +     * For all associativity arrays: first position is the size,
> +     * position MAX_DISTANCE_REF_POINTS is always the numa_id,
> +     * represented by the index 'i'.
> +     *
> +     * This will break on sparse NUMA setups, when/if QEMU starts
> +     * to support it, because there will be no more guarantee that
> +     * 'i' will be a valid node_id set by the user.
> +     */
> +    for (i =3D 0; i < nb_numa_nodes; i++) {
> +        smc->numa_assoc_array[i][0] =3D cpu_to_be32(MAX_DISTANCE_REF_POI=
NTS);
> +        smc->numa_assoc_array[i][MAX_DISTANCE_REF_POINTS] =3D cpu_to_be3=
2(i);

This initialization is called on a machine *instance*, which means it
should treat the machine class as read-only.  i.e. the
numa_assoc_array should be in the SpaprMachineState, rather than the
class.

I mean, we'd get away with it in practice, since there's only ever
likely to be a single machine instance, but still we should correct
this.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KjSGHOmKKB2VUiQn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9QTDQACgkQbDjKyiDZ
s5LwYxAAxnEWnR2TranT4UbYq7fjwFJJkaRJ9Nq5moflYdxfVzrqFvhIKwq1Wm3v
3MVKWOX4qeE4TLHumPNcVAmEYPsqTDkLyr1WYz5bQmSPFTQg2GClE6TT3n3ifMxU
ILgEW6+b8z8EcdQgj+ivdIkPLkLSqruPlTBSj/RX/xPxS9LI5hRFWuoWpn16g9uT
3TyOgWZlYbZaxPc7o2h0Shu4zW5wcomiKngHoz120pP4WTQEL67YLoF/Y9MqGlI4
1i533vJKbKUMrIsPR48LtHF3/j8dKj75JaRlvqbQO8pikjcixX6cJYxBcPdhdTa+
7pc43+KRX1xM9ujYE4H+P2yTQjXKHfclukhDN7KDPVi7Fty5h8oY4aepzHviKAMU
pxo1MROCVGfkNL9khTcXSskyb+rIwrfDkFwAZBkiDaa2Deokf6yzGb3LEntoRnss
j5bkidbXboW8+6fgTX4BWJx8IsUUsTwmF+R2sX54hM6YWLrZP26MRrb1sY4RZ1Gj
aCSyc8hXcF/52effIhFrh+EOBRYFrbNxl6UN+/+nOkO3rovzB3Rq+TyIFn3hQdbL
t+OBFBFBlM22kFgr/vGDd2gmejDFFCZpv8FjA8DkLMVw0UyI5z2tCLwzPLCzLcTT
3MWO9tMNF5I40TZy6sMU+F2VFt7cg9SpB2UYwL0ei9B4t7C0cTE=
=ylLd
-----END PGP SIGNATURE-----

--KjSGHOmKKB2VUiQn--

