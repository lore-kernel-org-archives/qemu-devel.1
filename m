Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3991C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 07:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6664D214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 07:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TjXWqD/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6664D214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAUDz-00019R-Ih
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 03:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iAUD8-0000gF-Gt
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 03:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iAUD7-0003Da-B6
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 03:17:10 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:33607)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1iAUD6-0003CJ-Af
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 03:17:09 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46YBB64DCCz9sN1; Wed, 18 Sep 2019 17:17:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568791022;
 bh=PoPkufCv/6gwHZHALM52oDppjzP6BOFvKuuVhvB/f64=;
 h=Date:From:To:Cc:Subject:From;
 b=TjXWqD/mUvpWDpHa2b/p6nn/PvfollKCvxRJetgxHvozlWrtE2zAbiP6BrmI85chk
 vVTy3CerS0Hmhg8sy9brBQqYX3Ug1r9/QrW8b33rvZT76b9B2wt34kISxoYvn0g8lS
 CujLSnZ2Tu5Zz6biECsXNgyFQNJWFuqhb4ww78lw=
Date: Wed, 18 Sep 2019 17:16:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: philmd@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Message-ID: <20190918071654.GK2440@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2WS97oupGEGbYNpW"
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] Problems with MIPS Malta SSH tests in make
 check-acceptance
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


--2WS97oupGEGbYNpW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm finding make check-acceptance is currently useless for me as a
pre-pull test, because a bunch of the tests are not at all reliable.
There are a bunch which I'm still investigating, but for now I'm
looking at the MIPS Malta SSH tests.

There seem to be at least two problems here.  First, the test includes
a download of a pretty big guest disk image.  This can easily exhaust
the 2m30 timeout on its own.

Even without the timeout, it makes the test really slow, even on
repeated runs.  Is there some way we can make the image download part
of "building" the tests rather than actually running the testsuite, so
that a) the test themselves go faster and b) we don't include the
download in the test timeout - obviously the download speed is hugely
dependent on factors that aren't really related to what we're testing
here.

In the meantime, I tried hacking it by just increasing the timeout to
10m.  That got several of the tests working for me, but one still
failed.  Specifically 'LinuxSSH.test_mips_malta32eb_kernel3_2_0' still
timed out for me, but now after booting the guest, rather than during
the image download.  Looking at the avocado log file I'm seeing a
bunch of soft lockup messages from the guest console, AFAICT.  So it
looks like we have a real bug here, which I suspect has been
overlooked precisely because the download problems mean this test
isn't reliable.

Any thoughts on how to improve the situation?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2WS97oupGEGbYNpW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2B2eQACgkQbDjKyiDZ
s5IBvA/7By76xlfusW3RbBTVboS8Yshx8nQGOeX/29p7uABecSQIcWFekExnUTgB
rQqNaBgM0g1YcyZapf0jAUPiTbbPMvWTKp6tvdvCLVp2OpgCHnxZNvJl+f8YlZPf
N5qzAw79+wDHVrxPIXGATxh651BW8Gzr1UWvzMH4ofaWDu50ROCJXhpx8ltHNHxd
4ijSqK6qHo0cal7+wPrRRcDsmwFmCXirOOIs+j6os4dnYE4Ijfe4DfilRnNT5Gsd
hZS/y5gl7EhKdUW/uSxRCQSrXqdKVlDoJs2eEpkqkdXnFPRBLXjV9zcqoZPhI/S4
OEadvXFjQYXzsP+RI2awaETlAL5LI8n3UmJHicMnUWHpY5EZkdYfHoqGZ3mOHlhn
b3hHfkc9il2PLHnO6pOYpfspsEB15X0iXLsKeFpJDTFnHmVMn0tscAj1F8nj7kOV
9TKYiKrLFpve5PtesV1eL5VDf4zUG2C0gAE9nRAimpGr4jpGHkW4Yh54C5KAZrLt
UZ9wqfKUOXlGnptPSp9E3JSp+mPaqN1jPGV3qvoN8gfsFo21B3UXZslr1J6B+F+8
vcwEpz2uXxLhaQWyGe3jCv1MvmKsI8/sYYvv1K5NoUtK6U2eTHXQd4Cej7foQQQp
s7g7SCtTwWlx5eXrnn97BomtMXncX7ztsFVvCIwJU/1anO9pXNc=
=3nR8
-----END PGP SIGNATURE-----

--2WS97oupGEGbYNpW--

