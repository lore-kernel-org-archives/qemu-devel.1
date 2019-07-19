Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B81C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 03:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B7CD2173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 03:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bfHKbe9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7CD2173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42151 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoJob-0005fy-Ib
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 23:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33982)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hoJoQ-0005BU-As
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 23:44:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hoJoP-0001JH-5q
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 23:44:02 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:47077 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hoJoN-0001G8-TG; Thu, 18 Jul 2019 23:44:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45qcLL6hLJz9s7T; Fri, 19 Jul 2019 13:43:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563507834;
 bh=Xtp7tS4rYrL8fuu+9hMe1AQVLw5TpfCLxI5mhUUUyOQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bfHKbe9uToAFoWjPzHDDVg5esPLZ/vgedqGW0/+yM28ILh8249k2oaS6jDZYBI4qd
 Ctlp5DnvHeeTLTBGK7iSwbVnthP8VEhHYD66cQZg7J4jJ1ZBquSkSW6Kesh+gANsAk
 fGUnhbQGm/FhN6Z6nxg1RQJwxKHWssGRbMPrP+ZM=
Date: Fri, 19 Jul 2019 13:19:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190719031935.GR8468@umbus.fritz.box>
References: <20190719024555.18845-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2z7AKWNQ4hR/M4ga"
Content-Disposition: inline
In-Reply-To: <20190719024555.18845-1-aik@ozlabs.ru>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [GIT PULL for qemu-pseries REPOST] pseries: Update
 SLOF firmware image
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2z7AKWNQ4hR/M4ga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2019 at 12:45:55PM +1000, Alexey Kardashevskiy wrote:
> I messed up with my local git so reposting.
>=20
> The following changes since commit 216965b20b04fbf74e0ce3a3175a9171dba210=
de:
>=20
>   ppc/pnv: update skiboot to v6.4 (2019-07-18 16:49:57 +1000)
>=20
> are available in the Git repository at:
>=20
>   git@github.com:aik/qemu.git tags/qemu-slof-20190719
>=20
> for you to fetch changes up to 300118db53cc454b049d64418c7b2588165a1c35:
>=20
>   pseries: Update SLOF firmware image (2019-07-19 12:43:27 +1000)
>=20
> ----------------------------------------------------------------
> Alexey Kardashevskiy (1):
>       pseries: Update SLOF firmware image
>=20
>  pc-bios/README   |   2 +-
>  pc-bios/slof.bin | Bin 926432 -> 926784 bytes
>  roms/SLOF        |   2 +-
>  3 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2z7AKWNQ4hR/M4ga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0xNsQACgkQbDjKyiDZ
s5Id8Q/+I2z94GIyHoXMas0GxKOSkgPwlGeDlnXW1VCKyU263r2QDpz4/ED42X+4
7xoCi/TnTBTCI8HEon4t4HE8Q+LRTxtoivk48lfT+oyYye4VMpoRajSYFoZEyd4z
vr2TXZNoWCtIcSeFJf9gM0ltYMG5PQcX4KgYdeUBjYZ7k9sXQwWo4FS1fr6WaGWg
GKIDxufLpNtcsSQrq2FsqFTrrZZH1ShBX775cuJQn0Hv4tWewS9QAUlv0mJqZMCU
gHbFyKXVEZ1aEI5d1DTDkGIaIGGJMrWptAJRWUInAizPSv+g4rb4C5il4+Vi0d5e
170Ih1wM5h1T4yvCg3xSMhUCOxc3AEbVVP7tXi0iZzWaHQPkNhCV/kqDQgQWsPKO
1EC2VD6rowyz3XV6kvwLeNheGJm4L+Qd8WBqe84nCbprfQQwLT+dWFCvZfUMcwUE
Wdo9y2KqopZojW2Dc5GuywQn2C4pOwaGv1gYnETvotlexFwl5a/wNIghxZ+A5Oqu
A7LGZqv0SRIUaNjQeGXfPJasC5ljNynEeuZPzTPHg+eEw9mrpqXWou28p7F6jxQC
FlqYcL8PpZbNDwl7NPb1X8r3jctO999lVSgkIj3BgL+I1HfkgsQbAlz4nN9BRbM0
pvl/Ert4jNoYdBarYXCbdx2aRz85BBQ9+RwgXm+vFvowCykli7A=
=kEIx
-----END PGP SIGNATURE-----

--2z7AKWNQ4hR/M4ga--

