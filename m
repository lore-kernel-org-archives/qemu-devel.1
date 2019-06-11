Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EA5C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 02:58:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A277C20820
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 02:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jeo4JzMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A277C20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51542 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haWze-00079O-RJ
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 22:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38728)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1haWxE-0004VW-6T
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 22:56:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1haWlZ-00076a-Ml
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 22:44:07 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:50649 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1haWlW-0006sb-TP; Mon, 10 Jun 2019 22:44:05 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45NDpK6n4lz9sNT; Tue, 11 Jun 2019 12:43:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560221017;
 bh=5MWNcbdX4c47c3P89F8k+Le5Llb1WY17pgZ6bWfs/qI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jeo4JzMGzGR/kfnG4hEAeRLMeDz7Ndl9WDA/hbNuNwKrDOloO79zORthmWs6ZPNHk
 5gR1UyDFD8DVzjzFh1wn3zQVnYlMdsxBCxUMTj7jE1gWB6uVV+BYskpfeIJXOf7JfR
 F3S0TQZCDTGtC/KIhln2VpOsQTrgTFAtl7qwhngI=
Date: Tue, 11 Jun 2019 12:43:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190611024324.GB3998@umbus.fritz.box>
References: <20190529065017.15149-1-david@gibson.dropbear.id.au>
 <20190529065017.15149-24-david@gibson.dropbear.id.au>
 <31966f5b-d46c-4b86-6852-c949d9f72497@redhat.com>
 <9218989c-c92d-6e7b-71a9-08d511c3a0b3@redhat.com>
 <32a8e668-80f5-1429-58f4-8935c973dd2b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
In-Reply-To: <32a8e668-80f5-1429-58f4-8935c973dd2b@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PULL 23/44] target/ppc: Use vector variable
 shifts for VSL, VSR, VSRA
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
Cc: Laurent Vivier <lvivier@redhat.com>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2019 at 09:28:49AM -0500, Richard Henderson wrote:
> On 6/7/19 9:09 AM, Laurent Vivier wrote:
> > On 07/06/2019 11:29, Laurent Vivier wrote:
> >> On 29/05/2019 08:49, David Gibson wrote:
> >>> From: Richard Henderson <richard.henderson@linaro.org>
> >>>
> >>> The gvec expanders take care of masking the shift amount
> >>> against the element width.
> >>>
> >>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >>> Message-Id: <20190518191430.21686-2-richard.henderson@linaro.org>
> >>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >>> ---
> >>>  target/ppc/helper.h                 | 12 ----------
> >>>  target/ppc/int_helper.c             | 37 ---------------------------=
--
> >>>  target/ppc/translate/vmx-impl.inc.c | 24 +++++++++----------
> >>>  3 files changed, 12 insertions(+), 61 deletions(-)
> >>
> >> This patch introduces a regressions
> >>  with Fedora 29 guest:
> >>
> >> - during kernel boot:
> >>
> >> [   40.397876] crypto_register_alg 'aes' =3D 0
> >> [   40.577517] crypto_register_alg 'cbc(aes)' =3D 0
> >> [   40.743576] crypto_register_alg 'ctr(aes)' =3D 0
> >> [   41.061379] alg: skcipher: Test 1 failed (invalid result) on encryp=
tion for p8_aes_xts
> >> [   41.062054] 00000000: 91 7c f6 9e bd 68 b2 ec 9b 9f e9 a3 ea dd a6 =
92
> >> [   41.062163] 00000010: 98 10 35 57 5e dc 36 1e 9a f7 bc ba 39 f2 5c =
eb
> >> [   41.062834] crypto_register_alg 'xts(aes)' =3D 0
> >> [   41.077358] alg: hash: Test 2 failed for p8_ghash
> >> [   41.077553] 00000000: 5f 89 ab f7 20 57 20 57 20 57 20 57 20 57 20 =
57
> >>
> >> - with libssl:
> >>
> >> # curl -o /dev/null https://www.google.com
> >>   % Total    % Received % Xferd  Average Speed   Time    Time     Time=
  Current
> >>                                  Dload  Upload   Total   Spent    Left=
  Speed
> >>   0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:=
--     0
> >> curl: (35) error:1408F119:SSL routines:ssl3_get_record:decryption fail=
ed or bad record mac
> >>
> >> [before, this one fails with:
> >> curl: (35) error:04091068:rsa routines:int_rsa_verify:bad signature ]
> >>
> >> If I revert this patch on top of 0d74f3b427 + "target/ppc: Fix lxvw4x,=
 lxvh8x and lxvb16x", all works fine.
> >>
> >> Thanks,
> >> Laurent
> >>
> >=20
> > This seems to fix the problem:
> >=20
> > diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
> > index 3b6052fe97..6f0709b307 100644
> > --- a/accel/tcg/tcg-runtime-gvec.c
> > +++ b/accel/tcg/tcg-runtime-gvec.c
> > @@ -874,7 +874,7 @@ void HELPER(gvec_sar8v)(void *d, void *a, void *b,
> > uint32_t desc)
> >      intptr_t oprsz =3D simd_oprsz(desc);
> >      intptr_t i;
> >=20
> > -    for (i =3D 0; i < oprsz; i +=3D sizeof(vec8)) {
> > +    for (i =3D 0; i < oprsz; i +=3D sizeof(uint8_t)) {
> >          uint8_t sh =3D *(uint8_t *)(b + i) & 7;
> >          *(int8_t *)(d + i) =3D *(int8_t *)(a + i) >> sh;
> >      }
>=20
> Grr.  I really really need to come up with a solution for testing that al=
lows
> me to test paths that the host cpu would not ordinarily take.  This bug is
> hidden on a host with AVX2.
>=20
> Thanks for the digging.

Can one of you send this fix formally with a S-o-b and so forth?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlz/FUwACgkQbDjKyiDZ
s5JW9A/+PKC5rlZY8E5E/xIUry6mRvH0JxAKnmIgS5isjR+YqBSrZmeN6UcAJOyK
cZQUHyTECxshnzrnk4wj5Qeu4ovF+bqUsuO1cBxjFBesJeA5Qj3zIP79LYCRi+Nk
6z68S9cudKofyvyIl4EV+C5u8i3upSea7d3/A8XjkVansPv1htpcJLD1IKISacjv
gIGeg0cGCG0/6KbyyCdA2if+jgBdxB+C1q454g57cO84Zhq2/UQapOwDh0+RO7nL
9TT9I3B/Cu8aG426YW2MGCu0MPqR0metgfBiC8kPKysRsN8xeZu5syfFa0Uge5no
G2vheBZgmDNZ4neS3lKzchdDLTqP1JFXqHK6tx0p+h5xNX6GhIpPW0ks9HSdGg3c
3P3lcHKy9c1E6MSaCYRvjPOTzO5uAVhRve8WAC2TkxiGBYhmkwLzTJQix+m5uoLU
mht5eYw1+2Uvl34xZ6VFGPC5t/BrxJumpRtqUT5YM6i2KSLMV8CwTsw+6jJvoe5w
UX2k1LPDN+AnvW/UYDa4pQocyCBibtks+U7XcVUCWe6V05XaoVDvllB1zLqdSH1i
scMamqRp0g/NDS+Jv8ejB5o3AuKSMcJXPJCCacwnA/RwmvZ3ylHFuD7Knr6doT/K
YDQiEMdG8lgqibJJ5r6bP2eVmll+aZC2ypm7KOmpoaP04fEB/Q0=
=Hlvw
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--

