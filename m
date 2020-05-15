Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1047AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:15:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC7B204EF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="n0a9+qe+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC7B204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZYJ9-0004kc-RW
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 07:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jZYFs-0001iP-E4
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:11:52 -0400
Received: from mout.web.de ([212.227.15.14]:54817)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jZYFr-0008Dy-75
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589541095;
 bh=6wKFvILC/i7tZeoYXB6gsC5xpQEL7/lU5BhuowIrN0o=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=n0a9+qe+0pZhUG0e8+W9gk2Z8/uSU53a03tSEJ3WDY9QZ/T2blGshkGTeEQ5i1U2a
 AuY71Zs4RoklFy11LMNFIi1QY4mRo1+QtD/Ik10T7NizOiJgsFP0795OaZstJMG0cx
 sihrxLZvHHp092ATpeW+5LoU/VftIvJA1dDBp4e8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.164]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MeBZO-1jioRN1K0M-00Ps3z; Fri, 15
 May 2020 13:11:35 +0200
Date: Fri, 15 May 2020 13:11:18 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v5 0/6] colo-compare bugfixes
Message-ID: <cover.1589540787.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/f4EwakdEjLo+1jmxXnUr6TA";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:53y1AI+ODEegrAfskT3B5l18/EuawRnGSqI0mYjHNAYUKT6fkYF
 tTCzDxFyisyJ7FFbrh+Lqi6FCbinBujh2R7ZC0o9E/1Qt2Qy0GLEDqrrCxSkyKjJOIN/Bei
 R0WQSAmvFamjchvG+hralA2HLodqHNmnIEnaz+B3CyS02MOqiSoVZSFgPXPPYeoIajek3BU
 KzYKLGmCxIBWZK+1q24Tg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7CdXT/oRDVg=:Ae99K1ylYWNzXssUHvKKyf
 kWSLbyUskXmEWLyWyMQG8wVqUNs+g2kOTsdXWHXzIE3QXd28ZfG9tkx4QwVPmLKMpLJ16Q5Vk
 cjJXuDVnUL+btzSAJIlHTRlfKh6fSRscnrp7i5S72SvdyCuqb7ekUNCYEr0da97WZP+oJyChC
 G6zCrR6zCvfi51I5/XFzDzWiLt64CV6B4bLL5fxt5N6cqcIwQJrO9sWQ8xosqNHaLfYoK+8ns
 xaqY54Fn1BaJbKoQ+V9DOUZJ7CWA83H3XoRfYqKvtyKQ3I4RWocJESY9auJjBfAs+y5eH+sJX
 UK1/UK+FVZngbtx5+RGu5k2Wwhu2iz0ocGktU7oPKryXzEfzZvr/P+Nq2PyjA8zflhpN4KkgL
 4EcK9AUAQyhxnSjJ8bbJXiIajYPcD7+dcE1BRVBY32VeblxhPbWUDSCrvnn33Z2ZeSR6nKI39
 stvTsYiKaOyYMZP3CbFUtATkJg5lHyqv0vV+EUf/Uej8axa7Pn203HsurLEvGZ12CpHxUZUcw
 DDnorG6PlyObcsPRiq/IWROvy8EHz5mvj9MZ+j+913kWO68QVeNNTVYN6DTvWoGqYAosb5DWl
 hADukRB4TeWtj55tXlgQ59r4FtpNXIpS3cvPMp7qY2LGK3iaSlg9VSmd2KgUfcAwTC+om+Zte
 ND67Yf0QGN8TBAWnnXjtljMQ/JtOck6LAWYfoRliNFkeDUHNJZNjtoRh3KTC2Y2XzCPRPz7TY
 TDHHoPCso8lqSaO6inigF1JL6Cw60k9j7nCe9934i6WNVT1vKqz1yvBfJ9wzvXpF4nibo5AUd
 nn0l8YJBu1a2uNkirqY3iqtTgoDfCASus48+xPEu5V4+EMWMFoyp3R0/9cjKGJk0UhU56tTRt
 QqBsMawD+19MHRAg8s3BbW5NJyD6YWdwMFoqq24aLOVekz4u+Jbs+xglnOELLG/rGQWlHrwcV
 rjKlvdUOIpIZe75Lwkd+wDLQZJe3ZLGcIJRZEi9GKJtoqHGnIKwY2lAmdDqFez3lA/0Loj4sq
 CMjvGnlcbH7ssIMn6U52M6f9EN/iTUC2Fv3B62otHQkBMw2oOckqKNNkY8z8vfkRCwtZrrpz5
 I0nIKE3kTrUMDZig0uXa0uKsbhkhjJHQ9ezslq46hAVv8Bk0tI+aPDB7y/wNRTNaRI3UoZWch
 7C1pk0WDmOWd1THphYCQwEr0CYOT0k50Y67hxo4muHJx6sqXVz/L3igY0YMOzyWSVATTp8mQn
 MLp0r43oZ8JSzcuOO
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 07:11:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

--Sig_/f4EwakdEjLo+1jmxXnUr6TA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Everyone,
Here are fixes for bugs that I found in my tests.

Regards,
Lukas Straub

Version changes:
v5:
 -initialize and use notify_sendco only if notify_dev is set

v4:
 -fix potential deadlock with notify_remote_frame
 -avoid malloc and memcpy in many cases

v3:
 -fix checkpatch.pl error

v2:
 -better wording
 -fix performance-regression in patch 3 "net/colo-compare.c: Fix deadlock i=
n compare_chr_send"
 -add more bugfixes


Lukas Straub (6):
  net/colo-compare.c: Create event_bh with the right AioContext
  chardev/char.c: Use qemu_co_sleep_ns if in coroutine
  net/colo-compare.c: Fix deadlock in compare_chr_send
  net/colo-compare.c: Only hexdump packets if tracing is enabled
  net/colo-compare.c, softmmu/vl.c: Check that colo-compare is active
  net/colo-compare.c: Correct ordering in complete and finalize

 chardev/char.c     |   7 +-
 net/colo-compare.c | 254 ++++++++++++++++++++++++++++++++++-----------
 net/colo-compare.h |   1 +
 net/colo.c         |   7 ++
 net/colo.h         |   1 +
 softmmu/vl.c       |   2 +
 6 files changed, 209 insertions(+), 63 deletions(-)

--=20
2.20.1

--Sig_/f4EwakdEjLo+1jmxXnUr6TA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6+eNYACgkQNasLKJxd
slisyRAAlJfYH0VOAgX3gc2ddiYlS29PZOjxYUTew6yx8qKbq9021xtpHH9c0Ugl
243pC66bOEF3vJTphJvfL/ggl80x9wA3EVFbFZ7/23OU5uiX1a4njftr+Y4Ey2s5
qn84HrlX8yVewmeumR5NDDPsNKFirSrvEh1eOpZffVrGRSWTv0OjfaOhdumAz/bU
6XccIU0GQmMvu7WlonJ6UARkj1W7vN69fWNmMeKhu2ejA1R7aPGTbxg6RwjVI2ie
KLRDQ9YjEmyoR4/waSs2XLJpahaua534Es396oGjxh2cf67Hv96TZDGgxu6niqMF
bCv1CifmaoPPAVqZDMDkC4VwI4iOMyXRLPzNiqXZQ1KFpJNLwsUiPKlrV20GJN/+
n5ign5CPIsCtOKboT1ugl1rdt571gd0rPgGG5my1IBaDNmzRC9nq5QPLulFmH/nZ
ygbrobTrEhNmMfqq5MVa2cGaINUg7cgmAJNyXFsEpo6wQXwDKbdFcty3Uy5BYOwX
wI41OpvN+81NN0fDaus+71jaOdcEKZJv/FEydg1d9Nn0/BkIoHI+HtoMpfTK2nMy
85YdcUgGlELDY2HpYRPfp8jvzvvu0QZDmblrHhDLVsz9mV7jtJOr45gLWgl3H+/U
KHfc+aLlthkdlh4LPjLJUfEvVeR6TSyVd7HmR7MSc80Yb5EndM4=
=miHH
-----END PGP SIGNATURE-----

--Sig_/f4EwakdEjLo+1jmxXnUr6TA--

