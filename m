Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523FFC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 10:31:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E67B2067D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 10:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WA2NmZOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E67B2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jveh8-000454-Cr
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 06:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jvegH-0003YU-QZ
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 06:30:30 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:51285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jvegE-0001v6-Sh
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 06:30:29 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B6DDD4qzKz9sTQ; Wed, 15 Jul 2020 20:30:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594809020;
 bh=GjtEAxVXWmpKPy2K5f+eqECvHruOCY542r72yIiOv34=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WA2NmZOb84/fbIJz/1WKI0z84Hu+Fb8Gb8njEvXu8B+tH/grPyJEAN4LTcdvLTjSc
 tE1q6VxRb6AZTGHqzCIE2Kq36bw0UlhvJ/JAXONNGhbaOeZrpRWtgpt8K5G9gfgyjs
 XgtmrebIiQfGtiMPmC8gRyAupMjysaJyidu1ewKY=
Date: Wed, 15 Jul 2020 18:56:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] .travis.yml: skip ppc64abi32-linux-user with plugins
Message-ID: <20200715085612.GH93134@umbus.fritz.box>
References: <20200714175516.5475-1-alex.bennee@linaro.org>
 <20200715040619.GG93134@umbus.fritz.box>
 <87o8ohxl36.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="poJSiGMzRSvrLGLs"
Content-Disposition: inline
In-Reply-To: <87o8ohxl36.fsf@linaro.org>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--poJSiGMzRSvrLGLs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2020 at 09:02:05AM +0100, Alex Benn=E9e wrote:
>=20
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > On Tue, Jul 14, 2020 at 06:55:16PM +0100, Alex Benn=E9e wrote:
> >> We actually see failures on threadcount running without plugins:
> >>=20
> >>   retry.py -n 1000 -c -- \
> >>     ./ppc64abi32-linux-user/qemu-ppc64abi32 \
> >>     ./tests/tcg/ppc64abi32-linux-user/threadcount
> >>=20
> >> which reports:
> >>=20
> >>   0: 978 times (97.80%), avg time 0.270 (0.01 varience/0.08 deviation)
> >>   -6: 21 times (2.10%), avg time 0.336 (0.01 varience/0.12 deviation)
> >>   -11: 1 times (0.10%), avg time 0.502 (0.00 varience/0.00 deviation)
> >>   Ran command 1000 times, 978 passes
> >>=20
> >> But when running with plugins we hit the failure a lot more often:
> >>=20
> >>   0: 91 times (91.00%), avg time 0.302 (0.04 varience/0.19 deviation)
> >>   -11: 9 times (9.00%), avg time 0.558 (0.01 varience/0.11 deviation)
> >>   Ran command 100 times, 91 passes
> >>=20
> >> The crash occurs in guest code which is the same in both pass and fail
> >> cases. However we see various messages reported on the console about
> >> corrupted memory lists which seems to imply the guest memory allocation
> >> is corrupted. This lines up with the seg fault being in the guest
> >> __libc_free function. So we think this is a guest bug which is
> >> exacerbated by various modes of translation. If anyone has access to
> >> real hardware to soak test the test case we could prove this properly.
> >>=20
> >> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> >> Cc: David Gibson <david@gibson.dropbear.id.au>
> >> Cc: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> >
> > Acked-by: David Gibson <david@gibson.dropbear.id.au>
> >
> > Honestly, AFAICT the ppc64abi32-linux-user target is pretty much
> > entirely broken anyway.  Many things about it appear to make no
> > sense, it's difficult to work out what it's even supposed to be, and I
> > strongly suspect no-one's actually used it in like a decade.
>=20
> Should we think about marking it deprecated for 5.2?

Yes, probably.  I just haven't gotten around to it.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--poJSiGMzRSvrLGLs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8OxKoACgkQbDjKyiDZ
s5Lnyg/+KBoLp5qM3iFufJNcWBpJWQ1wnKm72TJYwfbO+YcszDn5ilEp+LHWlnpp
/vZukorX3Bf7qdlwewdfvOI6HC3NL/tGShez1kgmKljrJ1LuQOvqhxuPJofQBmBj
Ol/ME1eyaxfdEr0gaCQFAo09iMbbnP0HXARhyAmNrpfdfL08EzDxO5XpJD3IOrLd
rCNmTpRlPPEG1CXCMT6MqxWT+UHLspBFBbsP2+l0cPTLGyDmcBvE99oI+c/Rrx4r
1FNPjQ7Qmd7I3fNU6e6YmqTDfE3qzmW1h2X2PuzMsE0M4FRyAP59LaeCBQ6S7MNj
IvzmdmtP7j9a701Wf2tpeUvbr30V9eX1FIbNah9SERzD6HXplR0Mj2B2uzyuDuaE
RAn9jO093IoiVWlbAnCwfWZXZ2w2nk16ZhPTvHPeT6MUY/gUQBM/4YM+QN08AYcZ
5aBnQRKistq5x4XFy1zkoHDkMVqJbSC8XNrQ1s0eiL1rZoUr8Hn+SVKbA0095KOI
xH47dqDapvkAY3qGE4qwPXic2GBnocLbCwK6kRETg9L225/Y/MANreJsh93d9HB4
8puad6rq0qgR/yl4sNLjvK7mS/XRg9HOg6WDqbc3TcId4mD7dpwzpjLWygyEdgta
3AxcZbdjDTc2MHASLiCdtg1ouZer6QLceY/dTnBDPFujqNwWcqI=
=hYJv
-----END PGP SIGNATURE-----

--poJSiGMzRSvrLGLs--

