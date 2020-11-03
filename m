Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA8FC388F2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 04:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65ACA22245
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 04:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YRY749xv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65ACA22245
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZncU-0003Hy-ER
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 23:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kZnbt-0002oh-5D
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 23:07:53 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:41443 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kZnbq-0007Ba-8D
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 23:07:52 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CQGTR2btSz9sVK; Tue,  3 Nov 2020 15:07:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1604376459;
 bh=zeBMBE7b3gfz1mWHSjPim7M9f9nUUMZvNfmtctYchyw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YRY749xvJfSbV4E6kjf8NXalXLvZ0FKDMqMBNHJVW+GhU/6meLL5UFx296CVNBA/I
 cqnAdoFDvssZCiuDUa3LCXrFKo9YidS0Wehl/6OKpGi2McLw6HjywCCqV8AsYESv1H
 /3y6pBoD7OsPF2SfyDYFpqdPJJ7wJDXIomqV55IM=
Date: Tue, 3 Nov 2020 12:41:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Does QEMU's coverity-scan run need to track coverity issues in
 dtb or slirp ?
Message-ID: <20201103014143.GF143651@yekko.fritz.box>
References: <CAFEAcA93d5VKj+jbJQcyxsG+54G32r1k53DPT8rGRqZcROU2hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mrJd9p1Ce66CJMxE"
Content-Disposition: inline
In-Reply-To: <CAFEAcA93d5VKj+jbJQcyxsG+54G32r1k53DPT8rGRqZcROU2hA@mail.gmail.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 23:07:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--mrJd9p1Ce66CJMxE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2020 at 07:54:14PM +0000, Peter Maydell wrote:
> Currently QEMU's Coverity-Scan project has a bunch of unresolved
> issues in code in dtc/ and also in slirp/. (I suspect most of them
> are actually false-positives that got re-reported when we switched
> to Meson and the filenames changed, or some similar event.)
>=20
> Do dtc and slirp as upstream projects already track Coverity issues
> (in which case we can just close the issues in the QEMU tracker as
> irrelevant, or do we need to investigate these and potentially
> forward them into whatever upstream bug tracker is appropriate?

dtc is wired up to coverity_scan, and quite a few of the things it
caught were fixed a while back.  I must admit I don't re-examine the
remaining warnings very frequently though.  I *think* what's still
there are false positives, but I'm not super confident about that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mrJd9p1Ce66CJMxE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+gtVUACgkQbDjKyiDZ
s5LfMhAAn2aKjqPgYDi+lCin3iAdZ/BLpSkZjEY1Qx7MCuoxc/ROMyUc4v2jFUYM
UfOlhM35OCPWz+r/1++SLzmYG8zh1VCoTEeetfxEFh35Nk1gp8crX/rUKDv6BZqT
gvFs9RopHN6he8l7oBVVdeNAw+7rjSMMb6M5GD6FrRgKBqOGmrgsTj7kFuexX1Fk
K/uQ8At3MKP5qk1gu97QIxBnlgQKCq2EB5HSg2BcLlQ8k5GuhLzzQzsFG+G6eh9i
Z8De34nx2j+iDP7jOmZxHs5Bsm22t6VTQ7ywWSVD6NDvl26KaxbXQNSgdNlB598D
r3uHRxXsQdbuTnv+H1wiTg0Ga5vkzluyBC3D4jT0KSVrKIANKN3gTjssEWrIJFLX
9oWYtgyrpZn7AsOy2sVpn4gDE8LgPrnOg4t0wr0p88ilfXJkbfsPp1KmlvAR6BIo
0LTIcD6Acwb9uFDbYxhQt5NJIvmgAR3r6gHk1xNc0UKulAVuH91CY8LUnesGp6na
it+qqISidzcwX8BHnsa0bfsTC9jlm8INmud5YJ/ijCJKErJWU2vMYaJfXn530r1l
uV5Z3AeDM5jQKcp09lsKPEecx4lE7OpCGC7KtRpN7BYlVEx3nGtnA3tGukB489TC
ZZ6Hp2pNx4X4M916C2U8mITXjRVmulkJlWo5tI9iplsGTKPjcNk=
=VtK7
-----END PGP SIGNATURE-----

--mrJd9p1Ce66CJMxE--

