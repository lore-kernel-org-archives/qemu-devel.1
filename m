Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C594C3A5A9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 00:56:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2DFD206D7
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 00:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="RR5qE8Gc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2DFD206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVlt8-0003pC-2X
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 20:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jVls7-0003Kt-If
 for qemu-devel@nongnu.org; Mon, 04 May 2020 20:55:43 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54101 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jVls0-0007qZ-Uv
 for qemu-devel@nongnu.org; Mon, 04 May 2020 20:55:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49GLqg4lrNz9sT1; Tue,  5 May 2020 10:55:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588640127;
 bh=3+GdaMRkqZ6W3RnU48Hg6c4IfSv19Oog9d57vMYq6kg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RR5qE8GcehpFmKGhL9Lu4AJN9ndXRLByuMpS4KBeoLTxavHfD7uyhNTZn15CBLyg1
 H78PmnX3DZMIkc5o57GxMdcF0baiJpjGXf0w/RmSDh7YVxn6t9CV1BNS+I5sh4ISeG
 MIjwOHmJd1CxSY5svlT8lWb68ELnIYZ+PBHXcTYM=
Date: Tue, 5 May 2020 10:40:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v1 4/4] .travis.yml: reduce the load on [ppc64] GCC
 check-tcg
Message-ID: <20200505004023.GE13695@umbus.fritz.box>
References: <20200501111505.4225-1-alex.bennee@linaro.org>
 <20200501111505.4225-5-alex.bennee@linaro.org>
 <ad941829-a2f3-6ef3-6251-0681b36be24a@redhat.com>
 <877dxvke0o.fsf@linaro.org>
 <20200504021047.GA13695@umbus.fritz.box>
 <bfdd7881-c9e8-d058-52a8-1c88518b90fb@linaro.org>
 <87r1vz5vmp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="idY8LE8SD6/8DnRI"
Content-Disposition: inline
In-Reply-To: <87r1vz5vmp.fsf@linaro.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 20:37:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--idY8LE8SD6/8DnRI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2020 at 08:48:46PM +0100, Alex Benn=E9e wrote:
>=20
> Richard Henderson <richard.henderson@linaro.org> writes:
>=20
> > On 5/3/20 7:10 PM, David Gibson wrote:
> >>>>>           - TEST_CMD=3D"make check check-tcg V=3D1"
> >>>>> -        - CONFIG=3D"--disable-containers --target-list=3D${MAIN_SO=
FTMMU_TARGETS},ppc64le-linux-user"
> >>>>> +        - CONFIG=3D"--disable-containers --target-list=3Dppc64-sof=
tmmu,ppc64le-linux-user"
> >>>>
> >>>> Cc'ing David, since I'm not sure about this one... Maybe split as we
> >>>> did with other jobs?
> > ...
> >> Hrm.  I'd prefer not to drop this coverage if we can avoid it.  What
> >> we're not testing with the proposed patch is TCG generation for a ppc
> >> host but a non-ppc target.  e.g. if the x86 or ARM target side generat=
es
> >> some pattern of TCG ops that's very rare for the ppc target, and is
> >> buggy in the ppc host side.
> >
> > Are we actually testing those here?  As far as I can see, we're not ins=
talling
> > any cross-compilers here, so we're not building any non-ppc binaries.  =
Nor are
> > we running check-acceptance which would download pre-built foreign
> > binaries.
>=20
> We are testing the very minimal boot stubs that each -system binary has
> in qtest but they are hardly going to be exercising the majority of the
> TCG. Basically the $SELF-linux-user is going to be exercising more of
> the TCG than anything else.

Oh, good points.

Go ahead then.  In fact we should probably do that for all the
check-tcg builds that don't install cross compilers.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--idY8LE8SD6/8DnRI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6wtfcACgkQbDjKyiDZ
s5L0fhAAzHP4G2ENnr5NLPm1s6hPoNhuPQGF3vRu8wGzVdMHnK4ZxEDQiLDoHL32
ykJdcmaxFrmxFBiWEeHKKDed2eMI+EJIo8NW4WJxVYup/GfYhLKFeEiEDzAYXzei
sSVCR6FuMxQdoWXwiOPZqMHF4rNDmVqteG8uYIJ9jiu91GFxSHUMKQLHr7XJhbq3
26HzkC+0VsqsQs5L91ieO+FCmX7SEk7oBS3SXU9G1URLk/bX/NmtWTdkNCnZ8uGX
SJqft2CH8kgN4Z/0J1uQdXe4eyz4VdwtiFz9EKuKTX71DrqNxJStxWj85WGHTOIZ
FW5l1GC5UHyRsNKLwFcUfJBYvjJN/zdB70JShrkTiNic0DBE4Q0j1U4D+wstpool
6R0HPXBDa4TTQFDRwD/tjz9Tt1TalmZFFYL9xXKKoPTKnC1O1fGnbLTWyuVqBTfK
egjavVVhO7flFINb3k0p/JjrTd52hORASJlLWuEFkxsr8ouUHVx6+Qn6b4eTEWiP
Ppr7Swj6blDlr/B7KMI/rnfFtT/8AIJ5dmhGn2cYQHwCJm6vwKQ3x+qIHV9J1Yx/
PsVHt8iOCYitoj8HpZRtKBQdRVrtx+zzzpIcIOni+dqIMJCYoK9G3WMwuItaf4mc
r3vsEr6DGKvD3foQCNA0GQS69Fdcd94YjTGSTkDwjPcBe0oer/I=
=Ou6a
-----END PGP SIGNATURE-----

--idY8LE8SD6/8DnRI--

