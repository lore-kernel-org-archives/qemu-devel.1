Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C13C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:58:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5422421926
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hdYkLwaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5422421926
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpW1i-00089r-Ap
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 06:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40891)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hpW0C-0001ay-QD
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hpW0A-0007Wz-95
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:57:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50693 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hpW09-0007TN-RO; Mon, 22 Jul 2019 06:57:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45sdpg3YwGz9sLt; Mon, 22 Jul 2019 20:56:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563793019;
 bh=uVWvdw+Z7dNJ9/tK9V9EkFtWcHZitElRMeivNTkMz0w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hdYkLwaXsJMsQwlfImzArmkH0J0Vkvhh9/IO1DtUG7EAU7pODEko5UicOo6NCryx8
 lG49xObBVhJIGl0iX3PO4EhkCf2yHaAVCxTfwyR1UC6DMj/FS1iulvzugMY3mxhE7x
 ux+08SgImZVHKXZFMLw23VD9t/zdnGB/6LAehe5Y=
Date: Mon, 22 Jul 2019 18:39:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190722083939.GG25073@umbus.fritz.box>
References: <20190722053215.20808-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ulDeV4rPMk/y39in"
Content-Disposition: inline
In-Reply-To: <20190722053215.20808-1-npiggin@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Series to implement suspend for
 ppc/spapr
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
Cc: Liu Jinsong <jinsong.liu@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Luiz Capitulino <lcapitulino@redhat.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ulDeV4rPMk/y39in
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2019 at 03:32:12PM +1000, Nicholas Piggin wrote:
> Hi, this series is rebased on top of the qmp event fix, and takes
> Paolo's suggestion to implement ->wakeup for i386 before adding
> ppc, which makes it much nicer.
>=20
> If the first two patches can be agreed on initially and merged, I
> can take the third patch through the ppc list after that.

LGTM.  Now, what tree(s) do we merge this through?

>=20
> Thanks,
> Nick
>=20
> Nicholas Piggin (3):
>   machine: Add wakeup method to MachineClass
>   i386: use machine class ->wakeup method
>   spapr: Implement ibm,suspend-me
>=20
>  hw/i386/pc.c           |  8 ++++++++
>  hw/ppc/spapr.c         |  7 +++++++
>  hw/ppc/spapr_rtas.c    | 32 ++++++++++++++++++++++++++++++++
>  include/hw/boards.h    |  1 +
>  include/hw/ppc/spapr.h |  3 ++-
>  vl.c                   | 16 +++++++++++++++-
>  6 files changed, 65 insertions(+), 2 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ulDeV4rPMk/y39in
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl01dkoACgkQbDjKyiDZ
s5JTeBAAqevPBsMSrR7PldnQDoVyfJHqHyU8Y+1PidQpJl45YUNfLIIIk0+5PsOS
PP4jeHmRhTOqTLIUUzqtR7Qjq2NP9RRsTWrmXHporC3Sik8Tb/mzMHwwSuDfPZc8
GKWmE3kAQfUFpDO2YDxfRLCKW4oOtwWyo/0pDtQAj0NyJl1W3csYMk6IzxTkDxBG
vV61PQOB6EFvop5Si8onluIcKkGT90uvOL9Vhi/uH1ng4gRVNwo2G9dwC6BwrQbt
WXu5fUyiF7OniuuqrFk0WyhoOpAPRNefGqTFiOLq5TsOGbge4+4UcYlZ39t33PsG
NtF9VKQXrFWmW0BhbYjARG/jEyhVmTAJCPhwZ2HB7q6vsguPhWOadFkDorGfmUIw
Tin8wakckuo2+Q9JwrCHY+a6RTE46sD/nh4dVTUISPwDgc2euFOvbE/gdgLib4WR
oGYYg6ugbPNy1gtjX/nnJKoDP04Ta4umDxLrI3QYkMgOhoZkGjUuaZiFIPOBmddZ
kER8uv3uT1txLCQNTeliyi3ntwUn1wBiQDTc0vXrvBR1U3sUZNnPn+UEq50Ir7av
n8Fe8vfjbUdro+jtwgHcM7gueBUxw6Zo3cPUn4olXzvTTDCDhQnTKJ5jVgej6+YB
ebYT3lzfSt7B905nf0Oo3Kzw2CwOGRJiSjnJ4tGh5PVs/Cx/e9k=
=QmjK
-----END PGP SIGNATURE-----

--ulDeV4rPMk/y39in--

