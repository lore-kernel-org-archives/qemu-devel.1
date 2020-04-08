Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DEFC2D0F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 18:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DB2C2075E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 18:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="EDWevXdz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB2C2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMFpR-0003ql-HN
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 14:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jMFWg-0006el-9Z
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 14:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1jMFWf-0004Xm-Cj
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 14:34:14 -0400
Received: from mout.web.de ([212.227.17.12]:41759)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1jMFWe-0004WJ-Op
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 14:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586370827;
 bh=TvyattrdAKBCkJMD7BJvExJBBGqSEEGXTDA2sU7+vMU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=EDWevXdzvbw/bKaH5maPXXNn5hWTxFRK9YEYCV3xdmnGBfbLRAELxoxDPvNVmpyrY
 6uC0ovvLZgeDbS+bA/1sq7Kus9bthM0rEyIf4pZNmF0Khx1aD5IA6UGZ1fr7qK3/RF
 Hjpc/3+UdnqZze4C+aQGmA62yZdbXy9IwpMmLMNo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.62]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MTy1N-1jn1cA1ZOD-00QhVq; Wed, 08
 Apr 2020 20:33:47 +0200
Date: Wed, 8 Apr 2020 20:33:45 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 0/3] colo-compare bugfixes
Message-ID: <cover.1586370737.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ur7ZzUgrhXsCZeUkHdBc=m5";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:7NydQP/OCWBbvWliATqh6q+wsPDBZRKEy3ga0GBywA1H+olHm2t
 MRiWQLO7T3QEGAEIQksZR9vTAG2/LaZwjtOHnqqBaUSoKYYpOTw3QyrSajHlBaiZ20nCThj
 zJH6cib2B72ISC9pEpsnC9HLwkbAvy7qTOwDDu4+P5P9RxWucP+q3wBUXCKMMAuxpWLPegP
 L3xeWQ8orEAD8W9IaUi7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0hz6aO4Qy2I=:Sm+PLN6AF3NQ/npT8tR/yW
 tCDFLo9arMor4Hdio/bkIt5WGDztr2R6NAXq5O7APGRrBQuxBsFvvGpTxoKZFvkkpA6GyyVJW
 /zWEVyU/VjkulXlO2FJmay2sx6e0S1goRIHlE+m8LGy89zleYvMOLpqWr5uKeKREij9gWqCg7
 aw8WiaIvfEugWDwz2ssWrhLjIzXP1NXRKsp03VqMTVysXUlJFo19iw6MU54iSKnU4U0I+dNMq
 SdL1wsZqBJSWlFzMPLFTjyYsKE9iD97TmtE5xaZq/IrAJq5X3a2Yg5bI0Tepue1VROP4ALhAo
 jWDQJtOn+mZnhZWV952mcg0VfG4vmwAn88YFGsVgR91hFxnzpO3E2sW9I2s43J/1DZ/g/pgTN
 HLkiipODJs0Bf61/ZvEd1wWiSWBKoVDqrHNq/RoofRNfp2Vd54cBwkqsZpXUZNu61tk6y5QMC
 adfEvwdZehTEKLwZcT/iCVsk72G4sSJV3MHK++A23j504lm0b/RchYha5oFuPtW1SRXC3KMAg
 l4UZ3fZ1tsCDFiwazvQxFxu4qr6hqOzTGCsxI2yWaiOXpnUgtcg6AJ2av8sPQtz3zjVp41yYV
 bFXY7WbVXhJg49KWtCd23u36Ii7jHECKtXbHCI8MSlJwHFpJcrcJX13SqDaWopXrbbWvxHZIX
 93MDbG9KpZAG+vEM7P32a12HKmSLajRy6kqDx7QvgTJA3cH/f3ehQiJTrVlfR2bx6XEzSqH1t
 OCzgD7y0z1JXbqUwq6oDYdXOUnAj++nIk7S/sNxBkEdAjjaCt8h7JIOYxcIxcVa2750dkojT3
 FKymLZw1kwVwGeDtX0V665A3welelvB25fV6uc52pgN2tBaMZOsIQ09hhyKaEFlJVBGKOo649
 G9hkH8MFJrIj0tmSfoQCEyeCZpRvcRytBJvfvrHaZQ1FCMIiDljb1ca7nrEvUakGjqIYMQ9OD
 Fj7AwPTbJnmSxUjajNnvsY83/u5q3K9zGtxWJPAf+PVqXwnoqGx9jeMzOfn2wV7pvZSsXq0Cw
 ntSvh14dNaSkifp+et0F+J4QF1PVSeaA6DwMeDlw59TCNYYQC6X3+TmZJi2DN7Ynsx0UMzyxn
 l9/YJ5EBaO9T7YHaJq4cprkxQMCeIH0uuoSGNIPaq3lIh3z7vYdqzjAjfT+3BCHgU6PGc0wac
 h3D8OF/iTE0hi2aFIJaPEsSUG4vVyUry+PmoC+OkxLtZoCXCC5lD5YEVOqZmoESH5ZtLwgd86
 OLN2GPIHpvQphw1+6
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.12
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/Ur7ZzUgrhXsCZeUkHdBc=m5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Everyone,
Here are fixes for bugs that I found in my tests.

Regards,
Lukas Straub

Lukas Straub (3):
  net/colo-compare.c: Create event_bh with the right AioContext
  chardev/char.c: Use qemu_co_sleep_ns if in coroutine
  net/colo-compare.c: Fix deadlock

 chardev/char.c     |  7 +++-
 net/colo-compare.c | 85 +++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 79 insertions(+), 13 deletions(-)

--=20
2.20.1

--Sig_/Ur7ZzUgrhXsCZeUkHdBc=m5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6OGQkACgkQNasLKJxd
slhckRAAkFPOwzT/k7qXh1YHCvk9Ita8egwqjcM39o9Sx7ogww9gwj7Ra9k9NHZw
3VyJGYbfZqahPJlsPO9WxXOwcbEXKHV0XhsmEVJ9UGrIUrnyVubIpzkkZeLvsil1
1mRcGl84ZXq27lK7vm/ev7SSF7I2SDYlbgZjPkrtc2lLwqigjWNNFFc8Al6OAm1V
pnW9OaGcswkg3dwaKttJE7DJWi2HHhh2obr0fpOre7eWKqcKAH2uJ8gqmIXsvQwU
h8rsE9w/5C58YJVz4OMoPoooVw2zQeXHjp+OBwvgUqBW6RenqCN66R6RAMDJKxHl
w/ainbzoZp1ZPnUJQQe9BNg3sLazJzGgzOAheGBbKGI8aIlIjxu1t6SQegG9MUVW
lgjmc7GhDpz9IOaWGQnLxt9Orr/DpCdIwaaPiaJOLAu92BFu4NarIat/2x0yAlwn
+KFda6gzp9i4BIu2c2RYpFNW8KTs1TonDjVmbiiMzaIQ9hvvSV4Qw6BzgkUvsjzc
vn3dTvBLTmMr/lpkYiKTkMdzrIe2RexZnShC/nQYTowC03cI7NJgMtEWEObGmuO1
5O5cy4jhAu/IZVCnUSsY6FTjPW3csKrXSUBpowOFnEX2oMUkErl8gPqIyOBJkIWY
23pbINmtBItmCSo8IwLwS+51bGg008SOYLW6OxrJJHdzAwz7AbI=
=t1Mr
-----END PGP SIGNATURE-----

--Sig_/Ur7ZzUgrhXsCZeUkHdBc=m5--

