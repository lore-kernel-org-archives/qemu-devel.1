Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F0CC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A79121920
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cl0whDE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A79121920
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAYJC-0005qo-3z
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 07:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iAYI1-0005Oj-15
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iAYHz-0005QZ-A5
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:38:28 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47555 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1iAYHy-0005OC-2K
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:38:27 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46YHzd1BQVz9sCJ; Wed, 18 Sep 2019 21:38:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568806701;
 bh=6Nwt09VfVyVm2ho+9H0Rj58ZZThHNPimNKBgwF1CZ4w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cl0whDE4gxpQ/BUr6GbWgm0CYZrFDtCaQ4HEo0C7z71Rvdo+joBNYuxaZzx7uMOLe
 RxiU7fdM20Yo6iKV7K/bR76Rp5nXo8MrBXq6mb9J5NE4TOqjRQ8M1xxxUYEqEwUG0P
 U0GLnj5DwRvvbLXf6F21OYl1gmBNfW1aE2V5527A=
Date: Wed, 18 Sep 2019 21:37:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190918113716.GB22790@umbus.fritz.box>
References: <20190918071654.GK2440@umbus.fritz.box>
 <75f4117b-5c87-bd7c-25e9-c7777e51b298@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
In-Reply-To: <75f4117b-5c87-bd7c-25e9-c7777e51b298@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] Problems with MIPS Malta SSH tests in make
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
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 01:13:29PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 9/18/19 9:16 AM, David Gibson wrote:
> > Hi,
> >=20
> > I'm finding make check-acceptance is currently useless for me as a
> > pre-pull test, because a bunch of the tests are not at all reliable.
> > There are a bunch which I'm still investigating, but for now I'm
> > looking at the MIPS Malta SSH tests.
> >=20
> > There seem to be at least two problems here.  First, the test includes
> > a download of a pretty big guest disk image.  This can easily exhaust
> > the 2m30 timeout on its own.
>=20
> Gerd raised this issue few months ago:
>=20
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg615619.html

Ah, yes indeed.

> > Even without the timeout, it makes the test really slow, even on
> > repeated runs.  Is there some way we can make the image download part
> > of "building" the tests rather than actually running the testsuite, so
> > that a) the test themselves go faster and b) we don't include the
> > download in the test timeout - obviously the download speed is hugely
> > dependent on factors that aren't really related to what we're testing
> > here.
> >=20
> > In the meantime, I tried hacking it by just increasing the timeout to
> > 10m.  That got several of the tests working for me, but one still
> > failed.  Specifically 'LinuxSSH.test_mips_malta32eb_kernel3_2_0' still
> > timed out for me, but now after booting the guest, rather than during
> > the image download.  Looking at the avocado log file I'm seeing a
> > bunch of soft lockup messages from the guest console, AFAICT.  So it
> > looks like we have a real bug here, which I suspect has been
> > overlooked precisely because the download problems mean this test
> > isn't reliable.
> >=20
> > Any thoughts on how to improve the situation?
>=20
> Maybe we should disable this test and run it manually...

Until we can fix it better, I really think we should.  A test this
unreliable verges on worse than useless.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2CFuoACgkQbDjKyiDZ
s5KLOxAAvnXc2Bg5O45jgSAMBgr3jGD+S+O9qCB5WEtHdfCu5CUKvy0I3MYwkeDK
oe1WLeHoU3krGt0brhNwh9K0+Sg0KP+skfYfF80deyNe0lOL4afeYNYTHf/xfdET
MSNi3V+yMZcB7DrJn9eac4Pz1rfDuhjWQDg9uJx1Gbir+AkpNmhZnMfV9Hy6n/WB
BzQHQGth2EGYxPHah9gAL7xP+yG6p697tYn0LpB4swlKsqqO6AsEFd3r2niB/914
vHen5YxqCCUQDa4XU0UNHoVkxkzvkMEl0dk4ibioQpzO7pyaYTfCnylS4+cAe8HQ
YF04BrW/wmtIebvvY7zCB5nJ79JDX2U5I/4MeaeddnEj2+M3t0YkVe6R8EWK2Amt
tR+dc9w0vmRGhCxBkSnl5ZvtZB5CFga0E9w3hea5nao/exqh0Dw3kSNBtI/bO5E8
XPz0gh/9SWdSQmrwHPea3kSSc2nCigvRyrllqUzCIfk5/wMHkWoY3iIW6+vfEi+P
lmlrT8CxlTZmSIkfyVPC7eVkAKzEGMuRntZrTy7hujTJGkSaNFgaDxfdvUPcprXA
snCmKM0YXB7z4FoBX7vQ6PkyJkgi/aXd0Waq9zpVeCTUlPhu22Rc4/XTFiycBsnY
JZDAI9NPY/Hh9fvYygWEMfm79V/UFTRFQaCNOtdw4S8UeJeThxA=
=I3V/
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--

