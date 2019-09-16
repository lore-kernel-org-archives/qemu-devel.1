Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449E5C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 05:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B65206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 05:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KhtIg+GP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B65206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9j9I-0006Rc-J2
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 01:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i9j6L-0005F8-Cx
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 00:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i9j6J-0001M9-Uc
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 00:59:01 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43879 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i9j6J-0001Jf-23; Mon, 16 Sep 2019 00:58:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46WvCg1N2dz9sPl; Mon, 16 Sep 2019 14:58:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568609935;
 bh=JcDStuBFOEQzLP3YNWgH1UjO6MUuDcZTy8TSuBzHmbE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KhtIg+GPp+sTtSTsuz9mzI5i6dlP78PiJVaTiMP4hQ6yReqa+NzY+b3vtlBuM9fAv
 mzTARUk+U8TcaVnj5mYZyROpjjThgx7T4KmgYKu3xuAR3nU3UNQQVU6cALBJdw0UpS
 ZUbGMIiZ1vqywyMGyM83zpKGvoSVTp6iivpfZLa0=
Date: Mon, 16 Sep 2019 10:42:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Message-ID: <20190916004242.GF2104@umbus.fritz.box>
References: <20190915211940.30427-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XIiC+We3v3zHqZ6Z"
Content-Disposition: inline
In-Reply-To: <20190915211940.30427-1-f4bug@amsat.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v2 0/6] tests/acceptance: Add tests for the
 PReP/40p machine
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, qemu-ppc@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--XIiC+We3v3zHqZ6Z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2019 at 11:19:34PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Quick tests worth to avoid regressions with the 40p machine.
> idea from the "Maintainers, please tell us how to boot your machines"
> thread:
> https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04177.html
>=20
> v2: Split Travis job, added Herv=E9 R-b tag
> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg05896.html
>=20
> Regards,
>=20
> Phil.

I'm guessing you're expecting these to go in via the testing tree, in
which case

Acked-by: David Gibson <david@gibson.dropbear.id.au>

Or do you want me to take them via the ppc tree?

>=20
> Philippe Mathieu-Daud=E9 (6):
>   tests/acceptance: Add test that runs NetBSD 4.0 installer on PRep/40p
>   tests/acceptance: Test Open Firmware on the PReP/40p
>   tests/acceptance: Test OpenBIOS on the PReP/40p
>   tests/acceptance: Test Sandalfoot initrd on the PReP/40p
>   .travis.yml: Let the avocado job run the 40p tests
>   .travis.yml: Split enterprise vs. hobbyist acceptance test job
>=20
>  .travis.yml                      |  18 +++-
>  MAINTAINERS                      |   1 +
>  tests/acceptance/ppc_prep_40p.py | 150 +++++++++++++++++++++++++++++++
>  3 files changed, 167 insertions(+), 2 deletions(-)
>  create mode 100644 tests/acceptance/ppc_prep_40p.py
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XIiC+We3v3zHqZ6Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1+2oIACgkQbDjKyiDZ
s5LhlxAAiOBEihKzsbOBCQCrTwVRQBNKVEsmd18E61AH6NiVH/NaBzEZC+Pk9EiT
XMsPWY8owDfbaeYYmyS+e3Sw4Sn7a2R2zroapxgedlC7e8AjPc2Iuh0CBHMsupla
hGJ4sFEZdWy6xVHE7xDIrg+ngcvU1sHAQ/u72SEIeLMJXAEcU7TBzHSh8f+v4hnm
nlYuPwt5xivCH3b94klWrI+Odd7QDrcnBu6SwbJGuT6mwpUXNndeMpEr5UHkFMoJ
QDpBhYHZKFwVYDt0t6eUjd33FaN8ubu0qrDQxR6Ts3LQHVQprvNye6QLwDzGnzr8
RUB1Ww99ROLxHxFjWN02y8BkcO6MVQ4fJom8zoGLAkie53zOuZpmkMPiQmftOZCZ
aQxWMvISDJ3u/npaGr2wqZLthyVXE4k7GHj4yGIhGWxLL1MaKpHWfPtrwJY9kJ4O
ORiH442BC6QEc+9cwvuPRoWaPWaC61/EwQbOl+sym3BtY929D8/L2a9W87ifaGA5
x9eiZFVv2buV8+KnyWA/wztk59wWfzAyfSpwQEKcJ9xFnmqVYozkfVBebdHzeGds
fFUQbKLp4CMNN53JjldsFYd0sj577Fqy7w+LOtrK1Xuv/j9TyGMU93Ol6Ju0au6P
gQ56bWfJ9olaAr7V3SiIfOKLE1Hll5it/fflGRKv7oteJLeGnnI=
=QVbY
-----END PGP SIGNATURE-----

--XIiC+We3v3zHqZ6Z--

