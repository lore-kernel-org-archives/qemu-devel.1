Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBD0C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 03:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A0E206CC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 03:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="C0xSHjqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A0E206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLekW-00071F-89
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 23:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kLejF-0004z0-Oh; Thu, 24 Sep 2020 23:49:01 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:56829 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kLejB-0004Nd-W3; Thu, 24 Sep 2020 23:49:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4ByHvg2d0pz9sTM; Fri, 25 Sep 2020 13:48:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1601005727;
 bh=2tudTPYvafVYwOiYjcP946HMO3oAaZcgpkj2ZW+zUgU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C0xSHjqOi8FIH+aa9ltwbYR8e7k5NO30360Er63PkrpVirNYLArEukUmJF1GhnlaP
 0AjRIOaTo3oy7OOl7eOnANUSRSGhMGomIDBrm+335FHMpyxBuRFK0btysuo5PjKSYh
 mNGR5H/wgQCUeWC+OiXZo1XQs7+mt413ipGAdpBU=
Date: Fri, 25 Sep 2020 13:43:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 6/6] specs/ppc-spapr-numa: update with new NUMA support
Message-ID: <20200925034343.GU2298@yekko.fritz.box>
References: <20200924195058.362984-1-danielhb413@gmail.com>
 <20200924195058.362984-7-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="l/3WCmqZNZ+BnHMk"
Content-Disposition: inline
In-Reply-To: <20200924195058.362984-7-danielhb413@gmail.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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


--l/3WCmqZNZ+BnHMk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 04:50:58PM -0300, Daniel Henrique Barboza wrote:
> This update provides more in depth information about the
> choices and drawbacks of the new NUMA support for the
> spapr machine.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  docs/specs/ppc-spapr-numa.rst | 213 ++++++++++++++++++++++++++++++++++
>  1 file changed, 213 insertions(+)
>=20
> diff --git a/docs/specs/ppc-spapr-numa.rst b/docs/specs/ppc-spapr-numa.rst
> index e762038022..994bfb996f 100644
> --- a/docs/specs/ppc-spapr-numa.rst
> +++ b/docs/specs/ppc-spapr-numa.rst
> @@ -189,3 +189,216 @@ QEMU up to 5.1, as follows:
> =20
>  This also means that user input in QEMU command line does not change the
>  NUMA distancing inside the guest for the pseries machine.
> +
> +New NUMA mechanics for pseries in QEMU 5.2
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I'd suggest putting the new mechanics - which we intend to become the
normal mechanis - at the top of the document, with the old version later.

> +
> +Starting in QEMU 5.2, the pseries machine now considers user input when
> +setting NUMA topology of the guest. The following changes were made:
> +
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
> +  0  10  20  20  40
> +  1  20  10  80  40
> +  2  20  80  10  20
> +  3  40  40  20  10
> +
> +Honoring just the relative distances of node 0 to every other node, one =
possible
> +value for all associativity arrays would be:
> +
> +* node 0: 0 B A 0
> +* node 1: 0 0 A 1
> +* node 2: 0 0 A 2
> +* node 3: 0 B 0 3
> +
> +With the reference points {0x4, 0x3, 0x2, 0x1}, for node 0:
> +
> +* distance from 0 to 1 is 20 (no match at 0x4, will match at 0x3)
> +* distance from 0 to 2 is 20 (no match at 0x4, will match at 0x3)
> +* distance from 0 to 3 is 40 (no match at 0x4 and 0x3, will match
> +  at 0x2)
> +
> +The distances related to node 0 are well represented. Doing for node 1, =
and keeping
> +in mind that we don't need to revisit node 0 again, the distance from no=
de 1 to
> +2 is 80, matching at 0x4:
> +
> +* node 1: C 0 A 1
> +* node 2: C 0 A 2
> +
> +Over here we already have the first conflict. Even if we assign a new as=
sociativity
> +domain at 0x4 for 1 and 2, and we do that in the code, the kernel will d=
efine
> +the distance between 1 and 2 as 20, not 80, because both 1 and 2 have th=
e "A"
> +associativity domain from the previous step. If we decide to discard the
> +associativity with "A" then the node 0 distances are compromised.
> +
> +Following up with the distance from 1 to 3 being 40 (a match in 0x2) we =
have another
> +decision to make. These are the current associativity domains of each:
> +
> +* node 1: C 0 A 1
> +* node 3: 0 B 0 3
> +
> +There is already an associativity domain at 0x2 in node 3, "B", which wa=
s assigned
> +by the node 0 distances. If we define a new associativity domain at this=
 level
> +for 1 and 3 we will overwrite the existing associativity between 0 and 3=
=2E What
> +the code is doing in this case is to assign the existing domain to the
> +current associativity, in this case, "B" is now assigned to the 0x2 of n=
ode 1,
> +resulting in the following associativity arrays:
> +
> +* node 0: 0 B A 0
> +* node 1: C 0 A 1
> +* node 2: C B A 2
> +* node 3: 0 B 0 3
> +
> +In the last step we will analyze just nodes 2 and 3. The desired distanc=
e between
> +2 and 3 is 20, i.e. a match in 0x3. Node 2 already has a domain assigned=
 in 0x3,
> +A, so we do the same as we did in the previous case and assign it to nod=
e 3
> +at 0x3. This is the end result for the associativity arrays:
> +
> +* node 0: 0 B A 0
> +* node 1: C 0 A 1
> +* node 2: C B A 2
> +* node 3: 0 B A 3
> +
> +The kernel will read these arrays and will calculate the following NUMA =
topology for
> +the guest:
> +
> +::
> +
> +      0   1   2   3
> +  0  10  20  20  20
> +  1  20  10  20  20
> +  2  20  20  10  20
> +  3  20  20  20  10
> +
> +Which is not what the user wanted, but it is what the current logic and =
implementation
> +constraints of the kernel and QEMU will provide inside the LOPAPR specif=
ication.
> +
> +Changing a single value, specially a low distance value, makes for drast=
ic changes
> +in the result. For example, with the same user input from above, but cha=
nging the
> +node distance from 0 to 1 to 40:
> +
> +::
> +
> +      0   1   2   3
> +  0  10  40  20  40
> +  1  40  10  80  40
> +  2  20  80  10  20
> +  3  40  40  20  10
> +
> +This is the result inside the guest, applying the same heuristics:
> +
> +::
> +
> +  $ numactl -H
> +  available: 4 nodes (0-3)
> +  (...)
> +  node distances:
> +  node   0   1   2   3
> +    0:  10  40  20  20
> +    1:  40  10  80  40
> +    2:  20  80  10  20
> +    3:  20  40  20  10
> +
> +This result is much closer to the user input and only a single distance =
was changed
> +from the original.
> +
> +The kernel will always match with the shortest associativity domain poss=
ible, and we're
> +attempting to retain the previous established relations between the node=
s. This means
> +that a distance equal to 20 between nodes A and B and the same distance =
20 between nodes
> +A and F will cause the distance between B and F to also be 20. The same =
will happen to
> +other distances, but shorter distances has precedent over it to the dist=
ance calculation.
> +
> +Users are welcome to use this knowledge and experiment with the input to=
 get the
> +NUMA topology they want, or as closer as they want. The important thing =
is to keep
> +expectations up to par with what we are capable of provide at this momen=
t: an
> +approximation.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--l/3WCmqZNZ+BnHMk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9tZ28ACgkQbDjKyiDZ
s5KexQ//ZG7hU2jnDx1WpKW4aOeGlF0qYhTKNADgBrg8zQ0w49yArSD9ZVZE0HNM
r/Z6iunIIVdgRDDfARMC2p3bhi5bZL6euKBVWWbmnk5JygIt2zC457dvwi7PsrON
yHmTtQpCjVPviq+fVIj45bVxoJZDGpkNS9mAhzGYmClBLhGfGkwFz3zQ6UbBSoxe
5oX/+e+CKeKROK06Pn2z+omGMbcrJZPpeUZfieq4Pj9GO1IJq6giOpiUcK9GD0B0
vKVCa1KncXQkAkHbN72JZw8xhLTXy2ZAFN2tBMc0qqPpA9OgUXXig77x/tDwWD1k
XXgxENfpmsJOhJM7MWPBZil9P0MGnTyW0qao2dsXzZlKglMMryHfm+iNknuNB5E2
NCf2kaWRb+ORHF9SnoK7RzyiRtwbdTFId8yhIRA7K0Ff7mlq3Osdfw8IsesM/JRz
7Qvyjas/mgEUlN2YUSghPUjb4FbeAfLcEQaQcNENyM4BLwdE1Z+Kb6rH66JfWMIS
rp7X1m5hvEzKMMfOoewU98HlXSp821dWaAhvncNmK/ifIb2N+iAtAjBw7I2Y+GxC
2HNqmqFqcQZAuuE0clVQFsC40kkwO76PeJKgyIvSlUPz9l9guCkP739cvIO5Wpcp
qb0eGXeEqQ/8zEFES1mMIROWN6m9XQuvt/dOoYIVbuuDx6foRQ4=
=dvE5
-----END PGP SIGNATURE-----

--l/3WCmqZNZ+BnHMk--

