Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854E9C4727E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 03:19:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D3C20874
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 03:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Vw6sRamt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D3C20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOBb2-0002bO-CT
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 23:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kOBZN-000211-NX; Thu, 01 Oct 2020 23:17:19 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:40059)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kOBZH-0005EY-Kl; Thu, 01 Oct 2020 23:17:16 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C2Zsq6CYFz9sSn; Fri,  2 Oct 2020 13:17:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1601608623;
 bh=rTB1BNke0TOW00jnhjzBCssxDDTFmkeRp1Pnhe7NmXU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vw6sRamt9Vo1L+QzHpYhvR3ABWzTfOvwgU9Kgp/iSE1HHTafImaSGlkoAYLGB+rPn
 l5aOuG4LaoX4Bkm0selezBy6K0jdYZ8pePb0CMpnjYYIG/ALPfcEBuQ6aP/DEqXdZ9
 2wi+AoNkiEsLYdYnGAbvJYlTwh0DXXHNqstGLYaM=
Date: Fri, 2 Oct 2020 13:16:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v3 5/5] specs/ppc-spapr-numa: update with new NUMA support
Message-ID: <20201002031658.GJ1844@yekko.fritz.box>
References: <20200929133817.560278-1-danielhb413@gmail.com>
 <20200929133817.560278-6-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pWOmaDnDlrCGjNh4"
Content-Disposition: inline
In-Reply-To: <20200929133817.560278-6-danielhb413@gmail.com>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--pWOmaDnDlrCGjNh4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2020 at 10:38:17AM -0300, Daniel Henrique Barboza wrote:
> This update provides more in depth information about the
> choices and drawbacks of the new NUMA support for the
> spapr machine.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  docs/specs/ppc-spapr-numa.rst | 206 +++++++++++++++++++++++++++++++++-
>  1 file changed, 205 insertions(+), 1 deletion(-)
>=20
> diff --git a/docs/specs/ppc-spapr-numa.rst b/docs/specs/ppc-spapr-numa.rst
> index e762038022..6dd13bf97b 100644
> --- a/docs/specs/ppc-spapr-numa.rst
> +++ b/docs/specs/ppc-spapr-numa.rst
> @@ -158,9 +158,213 @@ kernel tree). This results in the following distanc=
es:
>  * resources four NUMA levels apart: 160
> =20
> =20
> -Consequences for QEMU NUMA tuning
> +pseries NUMA mechanics
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Starting in QEMU 5.2, the pseries machine considers user input when sett=
ing NUMA
> +topology of the guest. The following changes were made:

So, moving the new scheme to the top is good, along with that we
should describe it directly, rather than in terms of how it differed
=66rom the old scheme.  The idea is that this should be a description of
what you need to know to use this right now primarily, and a history
only secondarily.

> +* ibm,associativity-reference-points was changed to {0x4, 0x3, 0x2, 0x1}=
, allowing
> +  for 4 distinct NUMA distance values based on the NUMA levels
> +
> +* ibm,max-associativity-domains was changed to support multiple associat=
ivity
> +  domains in all NUMA levels. This is needed to ensure user flexibility
> +
> +* ibm,associativity for all resources now varies with user input
> +
> +These changes are only effective for pseries-5.2 and newer machines that=
 are
> +created with more than one NUMA node (disconsidering NUMA nodes created =
by
> +the machine itself, e.g. NVLink 2 GPUs). The now legacy support has been
> +around for such a long time, with users seeing NUMA distances 10 and 40
> +(and 80 if using NVLink2 GPUs), and there is no need to disrupt the
> +existing experience of those guests.
> +
> +To bring the user experience x86 users have when tuning up NUMA, we had
> +to operate under the current pseries Linux kernel logic described in
> +`How the pseries Linux guest calculates NUMA distances`_. The result
> +is that we needed to translate NUMA distance user input to pseries
> +Linux kernel input.
> +
> +Translating user distance to kernel distance
> +--------------------------------------------
> +
> +User input for NUMA distance can vary from 10 to 254. We need to transla=
te
> +that to the values that the Linux kernel operates on (10, 20, 40, 80, 16=
0).
> +This is how it is being done:
> +
> +* user distance 11 to 30 will be interpreted as 20
> +* user distance 31 to 60 will be interpreted as 40
> +* user distance 61 to 120 will be interpreted as 80
> +* user distance 121 and beyond will be interpreted as 160
> +* user distance 10 stays 10
> +
> +The reasoning behind this aproximation is to avoid any round up to the l=
ocal
> +distance (10), keeping it exclusive to the 4th NUMA level (which is still
> +exclusive to the node_id). All other ranges were chosen under the develo=
per
> +discretion of what would be (somewhat) sensible considering the user inp=
ut.
> +Any other strategy can be used here, but in the end the reality is that =
we'll
> +have to accept that a large array of values will be translated to the sa=
me
> +NUMA topology in the guest, e.g. this user input:
> +
> +::
> +
> +      0   1   2
> +  0  10  31 120
> +  1  31  10  30
> +  2 120  30  10
> +
> +And this other user input:
> +
> +::
> +
> +      0   1   2
> +  0  10  60  61
> +  1  60  10  11
> +  2  61  11  10
> +
> +Will both be translated to the same values internally:
> +
> +::
> +
> +      0   1   2
> +  0  10  40  80
> +  1  40  10  20
> +  2  80  20  10
> +
> +Users are encouraged to use only the kernel values in the NUMA definitio=
n to
> +avoid being taken by surprise with that the guest is actually seeing in =
the
> +topology. There are enough potential surprises that are inherent to the
> +associativity domain assignment process, discussed below.
> +
> +
> +How associativity domains are assigned
> +--------------------------------------
> +
> +LOPAPR allows more than one associativity array (or 'string') per alloca=
ted
> +resource. This would be used to represent that the resource has multiple
> +connections with the board, and then the operational system, when decidi=
ng
> +NUMA distancing, should consider the associativity information that prov=
ides
> +the shortest distance.
> +
> +The spapr implementation does not support multiple associativity arrays =
per
> +resource, neither does the pseries Linux kernel. We'll have to represent=
 the
> +NUMA topology using one associativity per resource, which means that cho=
ices
> +and compromises are going to be made.
> +
> +Consider the following NUMA topology entered by user input:
> +
> +::
> +
> +      0   1   2   3
> +  0  10  40  20  40
> +  1  40  10  80  40
> +  2  20  80  10  20
> +  3  40  40  20  10
> +
> +Honoring just the relative distances of node 0 to every other node, one =
possible
> +value for all associativity arrays would be:
> +
> +* node 0: 0 0 0 0
> +* node 1: 1 0 1 1
> +* node 2: 2 2 0 2
> +* node 3: 3 0 3 3
> +
> +With the reference points {0x4, 0x3, 0x2, 0x1}, for node 0:
> +
> +* distance from 0 to 1 is 40 (no match at 0x4 and 0x3, will match
> +  at 0x2)
> +* distance from 0 to 2 is 20 (no match at 0x4, will match at 0x3)
> +* distance from 0 to 3 is 40 (no match at 0x4 and 0x3, will match
> +  at 0x2)
> +
> +The distances related to node 0 are accounted for. For node 1, and keepi=
ng
> +in mind that we don't need to revisit node 0 again, the distance from
> +node 1 to 2 is 80, matching at 0x4, and distance from 1 to 3 is 40,
> +match in 0x3:
> +
> +* node 0: 0 0 0 0
> +* node 1: 1 0 1 1
> +* node 2: 1 2 0 2
> +* node 3: 3 0 3 3
> +
> +In the last step we will analyze just nodes 2 and 3. The desired distance
> +between 2 and 3 is 20, i.e. a match in 0x3. Node 2 already has a
> +domain assigned in 0x3, 0. We'll preserve it to avoid dissolving the
> +association between node 0 and node 2, and use it as a domain for
> +0x3 as well:
> +
> +* node 0: 0 0 0 0
> +* node 1: 1 0 1 1
> +* node 2: 1 2 0 2
> +* node 3: 3 0 0 3
> +
> +
> +The kernel will read these arrays and will calculate the following NUMA =
topology for
> +the guest:
> +
> +::
> +
> +      0   1   2   3
> +  0  10  40  20  20
> +  1  40  10  80  40
> +  2  20  80  10  20
> +  3  20  40  20  10
> +
> +Note that this is not what the user wanted - the desired distance between
> +0 and 3 is 40, we calculated it as 20. This is what the current logic and
> +implementation constraints of the kernel and QEMU will provide inside the
> +LOPAPR specification.
> +
> +
> +Users are welcome to use this knowledge and experiment with the input to=
 get
> +the NUMA topology they want, or as closer as they want. The important th=
ing
> +is to keep expectations up to par with what we are capable of provide at=
 this
> +moment: an approximation.
> +
> +Limitations of the implementation
>  ---------------------------------
> =20
> +As mentioned above, the pSeries NUMA distance logic is, in fact, a way t=
o approximate
> +user choice. The Linux kernel, and PAPR itself, does not provide QEMU wi=
th the ways
> +to fully map user input to actual NUMA distance the guest will use. Thes=
e limitations
> +creates two notable limitations in our support:
> +
> +* Asymmetrical topologies aren't supported. We only support NUMA topolog=
ies where
> +  the distance from node A to B is always the same as B to A. We do not =
support
> +  any A-B pair where the distance back and forth is asymmetric. For exam=
ple, the
> +  following topology isn't supported and the pSeries guest will not boot=
 with this
> +  user input:
> +
> +::
> +
> +      0   1
> +  0  10  40
> +  1  20  10
> +
> +
> +* 'non-transitive' topologies will be poorly translated to the guest. Th=
is is the
> +  kind of topology where the distance from a node A to B is X, B to C is=
 X, but
> +  the distance A to C is not X. E.g.:
> +
> +::
> +
> +      0   1   2   3
> +  0  10  20  20  40
> +  1  20  10  80  40
> +  2  20  80  10  20
> +  3  40  40  20  10
> +
> +  In the example above, distance 0 to 2 is 20, 2 to 3 is 20, but 0 to 3 =
is 40.
> +  The kernel will always match with the shortest associativity domain po=
ssible,
> +  and we're attempting to retain the previous established relations betw=
een the
> +  nodes. This means that a distance equal to 20 between nodes 0 and 2 an=
d the
> +  same distance 20 between nodes 2 and 3 will cause the distance between=
 0 and 3
> +  to also be 20.
> +
> +
> +Legacy (5.1 and older) pseries NUMA mechanics
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
>  The way the pseries Linux guest calculates NUMA distances has a direct e=
ffect
>  on what QEMU users can expect when doing NUMA tuning. As of QEMU 5.1, th=
is is
>  the default ibm,associativity-reference-points being used in the pseries

I'd suggest moving a discussion of the differences that were made here
down to this point.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pWOmaDnDlrCGjNh4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl92m6gACgkQbDjKyiDZ
s5LLoQ//ck5TYgnrWCFNoGhSL+By8uBp2NeVlV/+J1lIL3GuEZZebeAuUy5jopva
6VKJHmP1KMToDgNIOEUIUhBO7qzAldbz/Qruk3PxvJeEJSmLxnAFT5K5xx7U/AMQ
07fbCACZMUnZD11f95dioKgacwlJyhfSP+d+n0sVgg+DvnWsRyEpiA2V3QCHUrWL
qDeZWvXv+v9/5oQQ61fZ/lI83bY8s6badUzHbrGw8RLtkEGjbmO0fj2+zUH881tB
tzuEVE9Rtj6aGPY55fQpjv/2eOFPQSkyRdXyEZGONXQN/SXJNB9Cy2cgtMzC3Qiy
szoiq2lKEWxkoxVqyuc1bizBPJB/TDUAyF3df2lkpkfZmIvt9nTHnS7NwQhoQ4EU
MSh/6dHv/9dscDAx5hpNV5naFXoCV4OYevyzR3M1cRqlTWf6smwUigr4+6XzL+oD
eilQiIAEWlee8fgQL1yPKDbJcje/Dnf8Ii6vQ5mPBZmCEIFhmhYZTjteexc8O/lR
OXn7HGiUMEAoh9Nc1dmX9u9w+r8zWMWA9FOJe3x8EN6/D6kRrqH7XLFQLICiVtxc
KkkDp9K0eiIMwslcrEjrtLQheAtT61ELwHbh1GvVw5bBg+MZFlicDH97X26hR733
pwBqvY8SkV6TdfdlzrhtMS/0aCtnVMDrnFRI8B1pPbZQut+mSjY=
=+r5f
-----END PGP SIGNATURE-----

--pWOmaDnDlrCGjNh4--

