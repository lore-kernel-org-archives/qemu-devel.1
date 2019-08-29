Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8663BC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 01:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 524702054F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 01:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="NfnUt57f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524702054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i39bw-0004Md-FN
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 21:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i39b4-0003uC-1c
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i39b2-0005Jv-Jt
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:51:33 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:32923)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1i39b0-0005GR-4A
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:51:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46Jlvc4Gf2z9sDB; Thu, 29 Aug 2019 11:51:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1567043484;
 bh=eLbltnebOSszWEKT/DLlq3BOD3EkE6V+yKQbXKKKXGQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NfnUt57fmmkTJ84teCHJOnYVFvwtSOOfHo0Odg0kQlrdCzFo3HpaXV2QLzGwbau3B
 XW3E4zSBPrHj7bAK5v+IQzMoCsA1zLQB2nt8vwSQiU66u6WOOZT2JxFgKlzZ2bIegP
 lY3AFly5a5BF6NSI/TLnXaR0JxrMcs/6aXp8TuWI=
Date: Thu, 29 Aug 2019 11:51:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: ehabkost@redhat.com, crosa@redhat.com, ldoktor@redhat.com
Message-ID: <20190829015117.GH16342@umbus.fritz.box>
References: <20190829013125.GG16342@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JI+G0+mN8WmwPnOn"
Content-Disposition: inline
In-Reply-To: <20190829013125.GG16342@umbus.fritz.box>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] Cryptic errors from PIP install if missing
 openssl-devel
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--JI+G0+mN8WmwPnOn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2019 at 11:31:25AM +1000, David Gibson wrote:
> If I attempt to run "make check-acceptance" on my POWER9, RHEL8.1
> machine when the openssl-devel package isn't installed, I get the
> following very cryptic error:
>=20
>   VENV    /home/dwg/qemu/build/rhel8/tests/venv
>   PIP     /home/dwg/qemu/tests/requirements.txt
> Command "/home/dwg/qemu/build/rhel8/tests/venv/bin/python -u -c "import s=
etuptools, tokenize;__file__=3D'/tmp/pip-build-la4el5r5/cryptography/setup.=
py';f=3Dgetattr(tokenize, 'open', open)(__file__);code=3Df.read().replace('=
\r\n', '\n');f.close();exec(compile(code, __file__, 'exec'))" install --rec=
ord /tmp/pip-1efs22iz-record/install-record.txt --single-version-externally=
-managed --compile --install-headers /home/dwg/qemu/build/rhel8/tests/venv/=
include/site/python3.6/cryptography" failed with error code 1 in /tmp/pip-b=
uild-la4el5r5/cryptography/
>=20
> Using V=3D1 doesn't give any more useful information, and it's not
> (easily) possible to manually re-run the given command since it relies
> on things in /tmp that are removed once the attempt finishes.
>=20
> I only figured out it was openssl-devel being missing that was the
> problem by (mostly) guesswork.  It would be really great if we could
> generate a more helpful error here.
>=20
> In addition, if I rerun "make check-acceptance" it no longer even
> attempts the PIP install, since tests/venv already exists in my build
> environment.  It then sort of works, but I think it might be hitting
> other errors because of the missing python packages.  Sorry that's a
> bit vague - I also seem to be getting unrelated errors that I'm still
> trying to figure out.

Fwiw, I also get an equally cryptic error that I haven't figured out
the cause for on my 32-bit Fedora container environment:

  VENV    /home/dwg/src/qemu/build/i386/tests/venv
  PIP     /home/dwg/src/qemu/tests/requirements.txt
  Failed building wheel for bcrypt
Could not build wheels for bcrypt which use PEP 517 and cannot be installed=
 directly
You are using pip version 19.0.3, however version 19.2.3 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.

In this case the check definitely doesn't work - it doesn't appear to
have installed avocado in the venv.

  AVOCADO tests/acceptance
/home/dwg/src/qemu/build/i386/tests/venv/bin/python: No module named avocado

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JI+G0+mN8WmwPnOn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1nL5IACgkQbDjKyiDZ
s5KO3RAAv79cPYpORNfMiH4BoubwAK6eCmX8ycMQzlqYNnkhsPW5xtBLASIN87er
x66JgMsa3QUkxUy3JyP0aCoipVQN7WSotvRATbVq2SKfzwvKC4an/3t9SqXZezJM
Ac/ktLLMXUM7zI0geB0TbooXmMQfe37kYC9XTJHeNsu1NmaKHA39LWVVD+/TxPZx
06LQWuxBk70fIIwzMbLr4E6moISAs/d8LSz4YjrNuXOYIlKWMa9fsoN+5EdmSWKZ
qpPuxFLOeRla6HweP6ontu5dLCHdiRiXOpMNk3bipTdRJyiLQIXLASMkuJmFAhkq
NVpJXvqIyKTn3TTpSkkpRGq6/1SUxowF73g2cxga/lhGm5CVKWgi6PTvWY/0EzEO
T1AdAbwJhpk/mPPuHXGjfOiShYqcHSoMuJNIjAC+VRKLbmjVc1hjIt/op1b01wqf
mDe1yOF43HwnTnw7HzWkZEhI4ZlVG94PpN2q8rFz7vois2oU8yGNRmkx77ysukLV
jxlvBBqntDIDMAoGD290l02clm5vSHduohuljmvzcfH1hKjEwy9CPKne94V5aq5B
a8K2EyfY3pMnus9YsP1hkGZQwyyp2De1mOqKP62YVRT/L3OhwoyuCkiXxT9YTbpv
Gx6Fzmrdf9rd/IEMFRTgycVP8ag3NMJbA3KWSYisFPO+C5eHajM=
=RUAk
-----END PGP SIGNATURE-----

--JI+G0+mN8WmwPnOn--

