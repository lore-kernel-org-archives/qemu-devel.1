Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A16C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 23:22:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD3D20720
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 23:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Xv8ksRV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD3D20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9zJM-0006vp-AT
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 19:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k9zIk-0006DM-43; Sun, 23 Aug 2020 19:21:26 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:51173 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k9zIh-0002X3-9C; Sun, 23 Aug 2020 19:21:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BZWTZ4Q8nz9sSG; Mon, 24 Aug 2020 09:21:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1598224866;
 bh=LxVzKoeedsVPGy1y8TQiVQl8tso/aU+d8SWO557vrVY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Xv8ksRV3Fg0ABPkaQ8P0V9sI+VWFYJ4X83Tp11cQtgRHECFXwq7BJ62cuyibZ6u1N
 KDihhK28ghWiAnEaPKSuTQLKB+Nx3GqzbcxO1k8NJxroSRlKadqEwqd6SkLJESbSGd
 G2yDhhxDdSlhAO9i9RvnS+BmKGWIvyzv7+E8z6Rg=
Date: Mon, 24 Aug 2020 09:21:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/40] ppc-for-5.2 queue 20200818
Message-ID: <20200823232101.GD4734@yekko.fritz.box>
References: <20200818041922.251708-1-david@gibson.dropbear.id.au>
 <CAFEAcA_=qV+B17Z=XZhaPK_dvhBOkGutNmCHYEP4xTYKnzukZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jCrbxBqMcLqd4mOl"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_=qV+B17Z=XZhaPK_dvhBOkGutNmCHYEP4xTYKnzukZw@mail.gmail.com>
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>, Greg Kurz <groug@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--jCrbxBqMcLqd4mOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2020 at 02:54:26PM +0100, Peter Maydell wrote:
> On Tue, 18 Aug 2020 at 05:19, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> >
> > The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c=
91cc:
> >
> >   Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/dgibson/qemu.git tags/ppc-for-5.2-20200818
> >
> > for you to fetch changes up to 3110f0ee19ccdb50adff3dfa1321039f69efddcd:
> >
> >   spapr/xive: Use xive_source_esb_len() (2020-08-14 13:35:45 +1000)
> >
> > ----------------------------------------------------------------
> > ppc patch queue 2020-08-18
> >
> > Here's my first pull request for qemu-5.2, which has quite a few
> > accumulated things.  Highlights are:
> >
> >  * Preliminary support for POWER10 (Power ISA 3.1) instruction emulation
> >  * Add documentation on the (very confusing) pseries NUMA configuration
> >  * Fix some bugs handling edge cases with XICS, XIVE and kernel_irqchip
> >  * Fix icount for a number of POWER registers
> >  * Many cleanups to error handling in XIVE code
> >  * Validate size of -prom-env data
>=20
> Hi -- it looks like you've updated the tag but I haven't seen
> a new cover letter. Do you want me to apply it?

Um.. I've updated the branch, but the tag should still be the same.
I'd suggest merging the tag, since that's what I did my testing run
on.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jCrbxBqMcLqd4mOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9C+dsACgkQbDjKyiDZ
s5Jpmw//TlbqHMI4ai0MNNA2RdOH4kHiJ7wxTki+kEdKQrRw5vZUb8fR5POZ5NX1
2G4xE5GFkC5N6kqWUY0wElaaHQbk6+2f11lKHpE80AzIAwo8CpDR6FFrCqX1/M92
9BlprlVaRf0VrDqvA/U0bziIb35TbsSFWJPV9Y5RNZlojTDwH7VoO4uZ+ouDT5DQ
lJYMcGQz5VWLODafYWUlSEGSSDzTnMiXt/ueeoYxat/GaAg80+P7SS7ykXa1lSKY
nWxgAzgtSyjp0Bi2U/PJkbnoGuhVaaaqzw/htKC/R6I/bHEWXtwRXfh0ihV0ftjs
T1k+3+mWtiSgP1IAvV6yI4OVOrGq5OvHLU8Znf4VElCBqHGuwsyqKa2gnLP4AYJr
LeLt+TEAZUBwnLU7nISj886TTvhVDICluOyfzCucQwGxdcP2XikwRDjqzvYO+3XL
ikkhqcxIBv4zFLGoKYCb/zuA+qcJW7GPNhJvqFu9zlzxEL6FjHNzORITh/YYA5VO
glBB4Jp6I/t7poimYfqmahspaQxuSyEESaLbVcitct09J2S+INft5J5e2S3L1VdS
9QNSCTTYU9zZRpGzItRMZ3rWRPLe6tSpa5l5UkE5bKhItutY/AKY4EXXKej3kaWN
+fvjZW3ryQG6+ZT81p4IaG5z2cuEF7plN50IQoNWhTxHYJK+DG4=
=jIcV
-----END PGP SIGNATURE-----

--jCrbxBqMcLqd4mOl--

