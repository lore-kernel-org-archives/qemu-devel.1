Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C519EC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 16:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9430A2469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 16:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LvrfRnVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9430A2469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Ljs-0006nk-OJ
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 11:10:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j7Lj4-0006KR-Br
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:09:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j7Lj2-0000T0-GS
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:09:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59526
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j7Lj2-0000Sk-CU
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:09:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582819763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eVCebUrnqNI4WTmnTSwgWCcoiRzlddQuYvQxJ8xZ1NE=;
 b=LvrfRnVmpbTLr/fS8hDrTEQFGynvgkxwFk7CG1MYp1wWzm25x+HYshKBWrlP2Xc87rkqaP
 PBTXY8X8NtnfgdjeMAuAhAgwDydkp0ROhn6frT7vxxjAC99/z6B/JpE6TsVF/iQDwBNkpF
 yRdel72sqjrJkR1JznnAdRCOaYge0Pk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-qdVpEFwqNzmUj-ki5hn6rg-1; Thu, 27 Feb 2020 11:09:17 -0500
X-MC-Unique: qdVpEFwqNzmUj-ki5hn6rg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65C3218B9FCE;
 Thu, 27 Feb 2020 16:09:16 +0000 (UTC)
Received: from localhost (ovpn-117-38.ams2.redhat.com [10.36.117.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D753D92988;
 Thu, 27 Feb 2020 16:09:15 +0000 (UTC)
Date: Thu, 27 Feb 2020 16:09:14 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH v2 0/2] Fix spelling/formatting in fuzzing patches
Message-ID: <20200227160914.GB315098@stefanha-x1.localdomain>
References: <20200227031439.31386-1-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20200227031439.31386-1-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2020 at 10:14:37PM -0500, Alexander Bulekov wrote:
> These patches fix some spelling and line-length violations introduced by
> the device-fuzzing changes:
> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg05965.html
>=20
> v2: fixes comment style in the fork_fuzz.ld linker script
>=20
> Alexander Bulekov (2):
>   fuzz: fix style/typos in linker-script comments
>   qtest: fix fuzzer-related 80-char limit violations
>=20
>  qtest.c                       |  3 ++-
>  tests/qtest/fuzz/fork_fuzz.ld | 16 ++++++++++------
>  tests/qtest/fuzz/qos_fuzz.c   |  5 ++++-
>  3 files changed, 16 insertions(+), 8 deletions(-)
>=20
> --=20
> 2.25.0
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5X6aoACgkQnKSrs4Gr
c8gLtAgAw7pMpjLgYc8ngMlXPpykEmdCIZJf2FGwHz732BTYoXrQOxwZdTJgbN3H
v7Kn7Fu9mDWBbI3QSR62K9kABIzQQsMh9ORRl0PyBbMcWDUcV1olEbggiuYO/pJv
CGWBysacXcBtVJuuwFZ2H1Jcvo+OQdB4WAxd1YP2YP1RquQ4P/j0j8z222nVtEd9
Aba/2JhJBhQPf0dUNClf7aOVPK2Tiq1ilXANXALAxdq9WKzgGvlP3o14d19mUp5r
H6jvUc48miI/Mx+vIeRtQiv9gpY1xb/2NIFHDeoez8g/t1ie7BkgftBxOGJwHwnz
0OIZ23e9XmyBLr6fQ/FWTsjXQNTnTQ==
=xCar
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--


