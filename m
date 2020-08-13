Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96B2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD545204FD
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MaH5ehXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD545204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k67O5-0000oJ-SZ
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 03:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k67ND-0008EJ-9D
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 03:10:03 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46421 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k67N9-0006xx-Q6
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 03:10:02 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BRyPY67PBz9sTR; Thu, 13 Aug 2020 17:09:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597302593;
 bh=CDouRUfmn0DVhAqEvIlph0RBDWOAqqou106EFH3BjtY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MaH5ehXfmBMCqEJirvztntzQ5aCE6Soh9zPQ3Dvgc/L7JRI4H11UZOWbQNVmc71zh
 Y9aDyhEs54wpszQn0q3vdg5xaGznvLQ39fzCTgGEr397nhzivHWCEjhsIC6npznqmi
 0uyVAGgqeW8upAnztCJYkQD6QLr33SpScQ+ZPxf8=
Date: Thu, 13 Aug 2020 16:36:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH v4 0/9] memory: assert and define MemoryRegionOps callbacks
Message-ID: <20200813063644.GB17532@yekko.fritz.box>
References: <20200811114133.672647-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline
In-Reply-To: <20200811114133.672647-1-ppandit@redhat.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:09:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2020 at 05:11:24PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>=20
> Hello,
>=20
> * This series asserts that MemoryRegionOps objects define read/write
>   callback methods. Thus avoids potential NULL pointer dereference.
>   ex. -> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3Dbb15013ef34617=
eb1344f5276292cadd326c21b2
>=20
> * Also adds various undefined MemoryRegionOps read/write functions
>   to avoid potential assert failure.

The overall idea seems fine.  Looks like we could avoid a fair bit of
boilerplate - and slightly reduce our binary size - by introducing a
global unimplemented_write() function.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8033oACgkQbDjKyiDZ
s5Lnlw//eQ/RhQIAQrLSuTXkaHtck0mxT/ouOXa/FDftJ9jRj0TBLHjQKUcolOD9
MRs4xbCRCXmrT5EKwFk/B7xljmybpHo+rJqZPZo6h7Ut/3FRZmLruJWMqnDw+5Kn
6wEyGXxGjN08zt887r6bQVbyI/z8gIc+KPKzbSs58mWuSRhkX/bv0M4Ws1/GSIrY
p9xTMQ1FJHa3ZHS5/klvbiPgtCL7pmh41Y5UPDml2e0PNmOfzdriGZfo+zrwA61q
Rm7XcnjHVdQoqDqdyxwsabZCv58Jg2vNbC2ElMdbPNr8SH8WIMD6sot2tsbCgjnh
i42Tzwi4HGV9xQWW6E92dfj7v1VVMM2JvVLfAmCRoc4IgxrVLC0PpI8cSO1FB+ll
zn9AaDo3QIysBBiLIMGk/emdmZoRHwK0I9mkISjArWJ+QkpFvm6gxZbBzNKZUdj2
ucsVXpq6/yk550hs8wtM5e9lENZqkMg/JQ8VnoYyFTv1eiQbSI+pqsqV7pUcTABo
krGZSeavV2Tv6/GhCrZoKE0VpCJL6uVz7vSszfTb580ytgmrOoc3ARUppijnOo8k
mZM9US8TWPNfCDAo4OU/R+IDm9DN88p9sDXuqVzsoGHnYTGWy/7bpu2ayYpl7KSy
qio7rRu8lZa2NI7rn9E15Cu0B19KlgCZkuFTs/52TfpdfVSvm8o=
=8UTy
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--

