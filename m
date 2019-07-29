Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E889EC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 08:01:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C7A20693
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 08:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C7A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs0ao-0003fC-4H
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 04:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41780)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ptoscano@redhat.com>) id 1hs0aB-0003Ap-60
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ptoscano@redhat.com>) id 1hs0aA-0005PP-7Z
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:00:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12783)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ptoscano@redhat.com>)
 id 1hs0a8-0005Mf-4o; Mon, 29 Jul 2019 04:00:32 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7BA2B85541;
 Mon, 29 Jul 2019 08:00:30 +0000 (UTC)
Received: from lindworm.usersys.redhat.com (unknown [10.43.2.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C553119C79;
 Mon, 29 Jul 2019 08:00:28 +0000 (UTC)
From: Pino Toscano <ptoscano@redhat.com>
To: Eric Blake <eblake@redhat.com>
Date: Mon, 29 Jul 2019 10:00:08 +0200
Message-ID: <28464409.aSG18riZGY@lindworm.usersys.redhat.com>
Organization: Red Hat
In-Reply-To: <549f94df-5d31-3dfe-0693-72a2861ddd7f@redhat.com>
References: <20190726140954.31921-1-ptoscano@redhat.com>
 <20190726140954.31921-3-ptoscano@redhat.com>
 <549f94df-5d31-3dfe-0693-72a2861ddd7f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4052931.PULZXL3B20";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 29 Jul 2019 08:00:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] ssh: implement private key
 authentication
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 rjones@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--nextPart4052931.PULZXL3B20
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 26 July 2019 16:24:34 CEST Eric Blake wrote:
> On 7/26/19 9:09 AM, Pino Toscano wrote:
> > Add a 'private-key' option which represents the path of a private key
> > to use for authentication, and 'private-key-secret' as the name of an
> > object with its passphrase.
> > 
> > Signed-off-by: Pino Toscano <ptoscano@redhat.com>
> 
> > +++ b/qapi/block-core.json
> > @@ -3226,6 +3226,11 @@
> >  # @password-secret:     ID of a QCryptoSecret object providing a password
> >  #                       for authentication (since 4.2)
> >  #
> > +# @private-key:         path to the private key (since 4.2)
> > +#
> > +# @private-key-secret:  ID of a QCryptoSecret object providing the passphrase
> > +#                       for 'private-key' (since 4.2)
> 
> Is password-secret intended to be mutually-exclusive with
> private-key/private-key-secret?

My initial thought was to allow users to specify data for all the
authentication methods possible.  Either ways (all of them, or a single
one) are fine for me.

-- 
Pino Toscano
--nextPart4052931.PULZXL3B20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbjdOQa52nq0tQalew9FMLZhkN80FAl0+p4gACgkQw9FMLZhk
N83vsA//c2dUx+X7nmoc+sFjw7xRr4ua1il6JLXVLLvDu3BPPOB71laTiUQFGYE2
6xCVU9VP00aCuBBXXfsibfEr+h0p0vwc6PvM44UPbI3DIiUjHGVRKTKYg47alZbO
jvdIS5MsV4jwHObzYhT4sbbVYjKkCqS1LBqDZ9PLZybEDBxEvPKuQfr+25y08VKl
b46F0pnLwmONrOFtmHkzdxUBz1HPSyZ34bCqJbJ18ImFioPbUnB2VkEDnckWlGw3
f194V1qNJ0CFwomsOJxP/cEpEaHDt1Lyo82bMzhx5RkkvmfIOWwgad7N0F6DeISR
n2XHNJFQSdR7Xl0iTj/7YVQD9AS9E37sUAVNp15x2Aet+pG6pNSk21iI/EYn0IJL
gcNwq96AKKdHwux9SGo61alOW/TaOfjJooj5rRWnhEjI3paqMcNrKkhOWokhAG5m
8V78VJtkNqVO88jmhOc6xf9dy5juEwmTZTzyVOveRpd6uJr8zukS/b6inlGTc/qW
j2vYKQNjRDqMtVA0LFvudmHvMrHmcA8kOeDIzM+H7OAHJw+S1HZy36x2XEVA4bY6
NmG4cXPSE/oB2Q1dmWeqkwGhoOGvmFWIf2yY9UupsWyl49ADEsjKKxDaubiZaxKU
Xh47V9khb6TziCKn+2qQtZQ14Tvv530Tv5w3ebtyh5FGdgsyBU4=
=0axj
-----END PGP SIGNATURE-----

--nextPart4052931.PULZXL3B20--




