Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86FAC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71CEB206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=online.net header.i=@online.net header.b="Jz0eNdTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CEB206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=online.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJAO-000685-DS
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:22:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fflorensa@online.net>) id 1iiJ0W-0008Ph-OI
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:11:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fflorensa@online.net>) id 1iiJ0U-0007gr-22
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:11:55 -0500
Received: from mail.online.net ([62.210.16.11]:40652)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fflorensa@online.net>)
 id 1iiJ0T-0007DW-Cn
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:11:53 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.online.net (Postfix) with ESMTP id 0F5C9F2B8EE7;
 Fri, 20 Dec 2019 15:11:44 +0100 (CET)
Received: from mail.online.net ([127.0.0.1])
 by localhost (mail.online.net [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id pBWjTJF8EUsn; Fri, 20 Dec 2019 15:11:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by mail.online.net (Postfix) with ESMTP id DDDC8F2B8EF4;
 Fri, 20 Dec 2019 15:11:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.online.net DDDC8F2B8EF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.net;
 s=4EC61654-9574-11E8-870F-3D38CA7095BF; t=1576851103;
 bh=uQKTz+m17UgmuM1riCjXzfNLa6yToMAbxf5Xpz7d5rE=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=Jz0eNdTsCOA5RX8nyJLb9sMSSCr/bSPaXSE5kHBB+mEpzgNwgi5WWhZC3cgiF+DNg
 ZWIT6Ipibw4lyXvDASH6tKrCx847BDZYLjrNtoY7I5FsfqYETyrTNlu3PLbrH5xXDA
 gPrs9kBszq8zpP8Nv5iihf2goyo99NWUszk9Z5fH1+9UZ2nkX5Y0Uojn9YrY2GoJhf
 cqD5XXk6pRl6Wf6442BvK4yauC5YZr5UeK9vyBSbfLG0w4n6ipBI//8jNLZz9MoyHa
 5camiwHxnwbzSJHrHr/18vDU9eBGwuD3Tr85bkyBIMM62GVBgcs/RG+3+Bx+LTmzhn
 LQp/iVvZQcQKA==
X-Virus-Scanned: amavisd-new at mail.online.net
Received: from mail.online.net ([127.0.0.1])
 by localhost (mail.online.net [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id wmm2gbK6O5CN; Fri, 20 Dec 2019 15:11:43 +0100 (CET)
Received: from localhost (unknown [195.154.229.35])
 by mail.online.net (Postfix) with ESMTPSA id AFD9AF2B8EE7;
 Fri, 20 Dec 2019 15:11:43 +0100 (CET)
Date: Fri, 20 Dec 2019 15:11:43 +0100
From: Florian Florensa <fflorensa@online.net>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] block/rbd: Add support for ceph namespaces
Message-ID: <20191220141125.wxlm4eizbwie6522@flash.localdomain>
References: <20191219133416.671431-1-fflorensa@online.net>
 <20191219145125.iwhxhzmt5mow5pea@steredhat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gjof4rc3co56ykfg"
Content-Disposition: inline
In-Reply-To: <20191219145125.iwhxhzmt5mow5pea@steredhat>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 62.210.16.11
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
Cc: kwolf@redhat.com, mreitz@redhat.com, dillaman@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--gjof4rc3co56ykfg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Stefano and Jason,

First of all thanks for the quick reply,
Response inline belowe
> Hi Florian,
>=20
> I think we need to add (Since: 5.0).

Are you implying by that (Since: 5.0) that we need to specify its
availability target is qemu 5.0 ?
I guess that maybe a version check would be better ? Like try to do
namespaces stuff only if we have a recent enough librbd in the system ?
Using something like :

int rbd_major;

rbd_version(&rbd_major, NULL, NULL);
/*
 * Target only nautilus+ librbd for namespace support
*/
if (rbd_major >=3D 14) // tar
 <process namespace>

>=20
> The patch LGTM, but I'd like to use 'namespace' instead of cryptic
> 'nspace'. (as BlockdevOptionsNVMe did)
> What do you think?
>=20
Yes no worries, I can rename it to 'rbd_namespace' to avoid any possible
confusion, is this Ok for you ?
>=20
> With those fixed:
>=20
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>=20
> Thanks,
> Stefano

Regards,
Florian

--gjof4rc3co56ykfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEENMOcO22p59MYDr5mpFTgAOO+N4gFAl381p8ACgkQpFTgAOO+
N4jBphAAq9AvF8GjSzoqmFWJb5HmhKkIPHFsGVFTwF+xHq9P+hOlyFY1zfMEPKF9
jJQTqI128+runAtVaZhTYn7EEvBlESMUqGvSFrhhPl52w8Z9c1VJfKoQ33uhjjC2
s81fAH5ZXGKIraZb0YO9xi8gB37/bRUZF25w6VX5yUJF7EWrDS2/7vE5mt+ybtKA
JqczOOHVfYszEcG267x/Y1g284E7BXESH/asq7FvP3eoFqAupHxMqU8qwXYBc8qK
vUQHXFBi7l5GmmNHCpW6ThtKbMLrYrW0p70v2zBE14kADBlmILCHhgVWockcCAnB
sNlLtYAdK3ikKt9p1nCARchU+sVCEBgFieF5UF6ZVFsleRYVIenQV3WKk6z7idLq
xCL9KCwSP3JvwO8B8AZK4Che69VZSve1DoBlOEA6Relnj6JVeVbQkGoW8axt9ZE+
pXY6f3eCi7Zv+aTRfwQ87utCjWmB/aCe2ItPHNbrUiomx1WehQKfnNjxhLe+i3og
nZ0P7xGWGfAB0hj6oSwc7ONL1BIgmR+A10BRJk9vjrN9UPpdzKjFPWudCVvnMUzx
oPIzwhj+JoZeOaoKCeIhF8U3b+P/ahj5zCA7/RV35vETUIdM6N4NsDy4JnfkOyax
/Lhm2kgvyVDNQ1EhK09AIRf9QZfdq6nOAHpAxDzGyIUSFT/ei5Y=
=hCeZ
-----END PGP SIGNATURE-----

--gjof4rc3co56ykfg--

