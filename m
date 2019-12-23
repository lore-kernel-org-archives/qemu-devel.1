Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591B1C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 06:17:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB8D20663
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 06:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oRMvE/H8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB8D20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijH2L-0003NK-93
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 01:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ijH1Q-0002p9-UP
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 01:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ijH1P-00046f-Q4
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 01:16:52 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:52781)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ijH1P-0003nq-DV; Mon, 23 Dec 2019 01:16:51 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47h8JH1hHXz9sP3; Mon, 23 Dec 2019 17:16:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1577081807;
 bh=NqEHbTfchXCJd/ez5yIWwnDvmcpq9XC4tTXcOQqhgXM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oRMvE/H8iuaU2v0Nv7qE9NmlNfczMCunnPguwq7bF1kh7hfwgenWoRtZx/1DzdNZ+
 QbzX4LY0lZkv0QZqmqmCzM91blyf7/a+Pt+/ViQXluKtX3jfeBRW/YO57nwA7U2rBz
 SvJjgtLdp166e1OTOnms4YhxaAh3K9wc/PyMzfWA=
Date: Mon, 23 Dec 2019 17:16:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 00/13] ppc/pnv: remove the use of qdev_get_machine()
 and get_system_memory()
Message-ID: <20191223061640.GG38380@umbus.modem>
References: <20191219181155.32530-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
Content-Disposition: inline
In-Reply-To: <20191219181155.32530-1-clg@kaod.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 07:11:42PM +0100, C=E9dric Le Goater wrote:
> Hello,
>=20
> The PowerNV and sPAPR machine use qdev_get_machine() and
> get_system_memory() in some places. This is not a good modeling
> pratice and it should be avoided. This series replaces the uses of
> these routines with a set of QOM properties and aliases.

Remaining patches LGTM, but will need a rebase to account for the
changes suggested in some of the earlier ones.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4AW8cACgkQbDjKyiDZ
s5K7XhAAv0VYQNVLo5BLN4A/wNXyaj68xzeq5Arm5EPlgguMxwOfgGSje7PF9PMz
nfdvCtY4osqElXOmgLOvvjVZ+7o0wAD1YS5TKBhYfRwmzJFUsIj13LxfSqPm/3jI
44PfoI3wwAUWT3PZSgMSW7pxCuwOzjLJT8cnES+INHm10Al7xEH8CGcp2qUmo4rb
UegeEqnrPJ07cmsbjYFeRhlfl/G3rnrp5BBVxgUNNqHBHk0BUIK07jHXuspJN7oJ
rSQP6iKYjRx5LaMj+5l8f0nC+PX8/Ht8oTnNau5HKl5I8Rbp9E8YGHEjiJbGvsk5
ubrXfBOcqyA3Uz4B8wkUtIF8QyoB4UlZHZgyZzWLWhzLmhOUKdkuQ2cC6NsNCPB4
ttb/4qcFkYnLSoVSkOBSVOdDNMJHuoNp6k0KVZcay5xAQbxnCMzFrX7KluOcmLhA
2oY3DruT6ZkJNM48L2ShxxYhGBmWXET4hIuc4tZyi/DgZbWvnbbDZrsYCyhEZABR
not9apITRtPParJsvU60XIHmV4vxa75x6CPHULIg8QwVoDbtnw2D1e9oBbvXWIaj
KG96xW5qZ2fzhqAKO2rLv5/nB5eWwMfUpPdS307zPPhxiENFsCy85YoeCttb19mE
gukD6HxMWZJ42jicQ2Gy/rRoxlXMyluzMfo/8iUnq+/pdDNPB2Y=
=Ew8V
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--

