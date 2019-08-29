Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A266BC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 01:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF4B205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 01:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Pe5U7zS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF4B205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i39Jq-0007Ch-Ht
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 21:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i39Hl-00062x-Up
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i39Hk-0005rp-I7
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:31:37 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38119 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1i39Hi-0005pd-Eq
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:31:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46JlSd1Sb2z9sPl; Thu, 29 Aug 2019 11:31:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1567042289;
 bh=1822wVP4YPab0H2gECNHiFO3J/5VouvpVzP8ZeyqdSU=;
 h=Date:From:To:Cc:Subject:From;
 b=Pe5U7zS8VAkRXn+OzPIV3+XniTtUwg0FhVU4Q4TJdswNdaNzolbnmN7Lv2wyUwQMN
 88sPHqsBdVMEumP+U66WMjXwxzsGNkvySvRrRqgUARBq+mnFx3jluyDApK3Lsd1uwm
 e/easeXkVZ7o8b0dMvncn581tZQniFeIJtUVoNOU=
Date: Thu, 29 Aug 2019 11:31:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: ehabkost@redhat.com, crosa@redhat.com, ldoktor@redhat.com
Message-ID: <20190829013125.GG16342@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nqkreNcslJAfgyzk"
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] Cryptic errors from PIP install if missing
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


--nqkreNcslJAfgyzk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If I attempt to run "make check-acceptance" on my POWER9, RHEL8.1
machine when the openssl-devel package isn't installed, I get the
following very cryptic error:

  VENV    /home/dwg/qemu/build/rhel8/tests/venv
  PIP     /home/dwg/qemu/tests/requirements.txt
Command "/home/dwg/qemu/build/rhel8/tests/venv/bin/python -u -c "import set=
uptools, tokenize;__file__=3D'/tmp/pip-build-la4el5r5/cryptography/setup.py=
';f=3Dgetattr(tokenize, 'open', open)(__file__);code=3Df.read().replace('\r=
\n', '\n');f.close();exec(compile(code, __file__, 'exec'))" install --recor=
d /tmp/pip-1efs22iz-record/install-record.txt --single-version-externally-m=
anaged --compile --install-headers /home/dwg/qemu/build/rhel8/tests/venv/in=
clude/site/python3.6/cryptography" failed with error code 1 in /tmp/pip-bui=
ld-la4el5r5/cryptography/

Using V=3D1 doesn't give any more useful information, and it's not
(easily) possible to manually re-run the given command since it relies
on things in /tmp that are removed once the attempt finishes.

I only figured out it was openssl-devel being missing that was the
problem by (mostly) guesswork.  It would be really great if we could
generate a more helpful error here.

In addition, if I rerun "make check-acceptance" it no longer even
attempts the PIP install, since tests/venv already exists in my build
environment.  It then sort of works, but I think it might be hitting
other errors because of the missing python packages.  Sorry that's a
bit vague - I also seem to be getting unrelated errors that I'm still
trying to figure out.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nqkreNcslJAfgyzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1nKuoACgkQbDjKyiDZ
s5LWQQ/9EyYN6Fb8kPJayEsQroQfyKpVTFdUF3Ks89hmCONFoD7Kl6s1N10jWVn7
RaCrjh9gQ2MOULDdxWdJoR++amAVWiOAIxY6ZsikMSqk1wLzwdwLA0kkvV1LVFi4
DIA1q/09JDUaWvLw7cOUx1Q2sRG7Mp0l9fUf5BNfFqn5GUAAjzubiZt2QIgcnN4m
as/XHGx3z20kqZbPewWkDMSrJAq4ulhIcMertScWSIYwHPFCyhE/SgXhxA0WCJey
vDLNU4tQg7Ub4O0L1y6Qq0PteLlS9EqS5KGEmmC4OoRhOtZiw6I6Uz7tUk3aP5kw
xJBc41w11HiQ+zQSubbzLaUktpApwB1yqTY5wIUmBCOCKW7sAPdMnHCebouOcffh
DoTDUaB0ZHGPnkMmtI1HBeibI7qGKrX+IIfg2oIGyRFNJnvGyKTZfatPTSqWC5hT
P0pCk9RUnDAAkWSOQYiiMHE6Eg4eehqas964JmtlrIO6SIHiOZvffpfRUOlfIpg4
kM/jK/sCaHlL1zMOHqrmTJNs1kfRblAtKssAkOnXnBXYKR/ATEk7qevHpYtBX8Bb
oFziZjHvY8rZCfW/h8jPZhS+7hC95k74DMdcLWsyYkwVKctg1AT6F+5Up0bpjT8Q
SG1d0WWZijWQ3xhgEqd9bvUZTlVkYkDTBNQp7p8KwH12DP7xeKU=
=uK7A
-----END PGP SIGNATURE-----

--nqkreNcslJAfgyzk--

