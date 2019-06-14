Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0763BC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:17:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D314B20850
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D314B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51950 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbn1G-00077T-VF
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 10:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47571)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ptoscano@redhat.com>) id 1hbmUU-0003AS-NV
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ptoscano@redhat.com>) id 1hbmUT-0007zo-Lw
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:43:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42768)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ptoscano@redhat.com>)
 id 1hbmUR-0007uz-Cl; Fri, 14 Jun 2019 09:43:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7035A307D850;
 Fri, 14 Jun 2019 13:43:32 +0000 (UTC)
Received: from lindworm.usersys.redhat.com (ovpn-200-20.brq.redhat.com
 [10.40.200.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 07CC52CE56;
 Fri, 14 Jun 2019 13:43:25 +0000 (UTC)
From: Pino Toscano <ptoscano@redhat.com>
To: Stefan Weil <sw@weilnetz.de>
Date: Fri, 14 Jun 2019 15:43:19 +0200
Message-ID: <8260953.zmGaFXgfj1@lindworm.usersys.redhat.com>
Organization: Red Hat
In-Reply-To: <c4376dbb-d755-f05f-fb93-ed212bf30bb0@weilnetz.de>
References: <20190605213654.9785-1-ptoscano@redhat.com>
 <a8797829-a5c6-24a3-647f-14872bc2f951@redhat.com>
 <c4376dbb-d755-f05f-fb93-ed212bf30bb0@weilnetz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3058089.XZViZUk8uN";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 14 Jun 2019 13:43:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6] ssh: switch from libssh2 to libssh
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
Cc: kwolf@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>,
 qemu-block@nongnu.org, rjones@redhat.com,
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 mreitz@redhat.com,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--nextPart3058089.XZViZUk8uN
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday, 13 June 2019 21:41:58 CEST Stefan Weil wrote:
> On 12.06.19 15:27, Philippe Mathieu-Daud=E9 wrote:
> > Cc'ing Alex (Docker, Travis) and Stefan (MinGW)
> [...]
> > Note, libssh is not available on MinGW.
>=20
> Nor is it available for Mingw64:
>=20
> https://cygwin.com/cgi-bin2/package-grep.cgi?grep=3Dmingw64-x86_64-libssh=
&arch=3Dx86_64
>=20
> That makes building for Windows more difficult because there is an
> additional dependency which must be built from source.

Yes, sorry for that.  However this can be fixed easily by creating
Mingw packages of libssh (not volunteering myself, sorry).

=2D-=20
Pino Toscano
--nextPart3058089.XZViZUk8uN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbjdOQa52nq0tQalew9FMLZhkN80FAl0DpHcACgkQw9FMLZhk
N82BzQ/+L73So/o/Gr7iGxJ//A8PffrV4CwTdrcHUJi015WwiDsIFz6hiDB1id7e
S/Kle5Y//vugR8UPeBRW4ckvZjtl6neUZ5aex4+Ns39EDQ+WfD+YYNuVxZZrJjg7
lsj+iDgYsYM5996yi7zXxSAwGWZ56KIebt+WBmxjZR8mVqC1xN7Xzf7Bsw4KMbhG
xrgYWxY6sKA7dovHflc5sJ8ztieHVK48ep+UbWgcBCXEsOHF7fhOE3jT+5H08rY4
3hhTAzSQeXYRYz3fD4m/QVo/W28hIzu20dEBZJkUEro1aCHNF77dGHo9CxPOXqkm
45scvcdRAhx0GaAZzbjByI3ngbFHLZs4FI6pdBoeuk6DHcW/rVxGtzmWSm6zZsNk
GxRMCZCuiWadEVumdbJqUd+FeUSjOgl6TqPnMdT9TXRdwwUwedzjb6n4q7CTE5IW
J7yxkF2960J/uPJ9UdNt4AGpK2TZeFfrIju8/P0vltorTF2n1B/ODAOILqmu/4Dy
Of18YQk5H6pRJfDHPgCvrhMaOXDgZg6LbSG+knv74rD1IrvuHaShH3I6m51ef+t5
5Ef15HSxTFjuT45We7IuD+VO/ccsmBxbT0YS/CFaK79AaU1RU6AiLmwQmq3AKQ5l
7lDUMcWrmQ+4rP6bMRjbScEeYI+EeebnSvNAv01nYcPV5xViZso=
=jdne
-----END PGP SIGNATURE-----

--nextPart3058089.XZViZUk8uN--




