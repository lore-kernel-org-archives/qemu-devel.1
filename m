Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EB1C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE06205CB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="nIiUSeou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE06205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2az-00045Q-Rw
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kD2Nm-0001uG-4M; Tue, 01 Sep 2020 05:15:14 -0400
Received: from mout.web.de ([217.72.192.78]:36267)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kD2Nj-00079G-PP; Tue, 01 Sep 2020 05:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1598951704;
 bh=wtMDis1BYzeS7drdCGqGv2ljKzWp8Uzppju5xOiz3tI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=nIiUSeouw48NPAOtv0ejiGKtUzSBqIid7RMrlXHPMGrSbkhrxqd4O+Qn/vvF/TD5R
 F2h90AfTH4Dr33hbSZFmlaFuwMFdNwx5BmAo6DwhGSU79ojJQiwnsnPsPzRahqviJJ
 EHRIM+vVpQ5d5e1fPLY2rAd0ZuYlB/3O2MMVbScc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.220]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MRl5x-1k2QM52LLF-00Sxx9; Tue, 01
 Sep 2020 11:15:04 +0200
Date: Tue, 1 Sep 2020 11:14:54 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v8 0/8] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <cover.1598951375.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/r.UulW6sXzDyeTyrh07oD1X";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:oJZxiroF7OjdWI5zsz0WgbtBrhb6EcVB5FPdRxc8kmw06U0cACU
 TYbv4Q+W+nXdBTQKx3RzAw9Eokaji2XV39LfVD1hvSbUNUAE/gj/ecb/C57quTtvgTKhJAT
 MMabr01CVi26K3xABnBUPYkgTXL5KCiuJ9jB3/mMqPH2iEa8SVlrJFdC0o6qHSVM02OXTAk
 cCa4PKozpmeJZT8CQOhnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FOf89QtXRr8=:PWHo4zm+kIOn/Kla9tiIlb
 a+RtP2oe9CX9Fg4F6j6+5JR9VvyKxPeMxZyr+DMM/yJS1DJvNFotCteKEAXU6lknmKoLzYn/7
 M6bWcFiiVPCp9yQj2kwCY8bB02CHw+XXbID5Kb0SsDcb+r9yOS9DjgmpSuRfqm660/tJjtzML
 9qdQv7z6z/v5jE2JVdj7qwAZbISOlYwR6+BG/kwlsum0uZ8uvr7zznI8IZn97ppEN+2438Mnp
 dk9RMrtEIFjDcHI7EpqDbMr66yCtPOlO1cxqzrdXQRaqk8YvDPR0xgTbCkztGEjWTG/3K6XoA
 N3o5VxorVwXbJRRmpFacfeKjHY2V+3Jw1qcjBy+VXFGz10mgnpM9x1SeugI2ItH8ExH6i2B0H
 3gm2qfPT+K/3lp49Fu+rN9EktJs4x7QUkftmms66FA6qYoiyZtrpbmOlGwskh8L/2EOzib17b
 2xTDZpVM4lfQE73g8I2IVx2RvbHLCZDxTiMfdeFoR0fyNhXIVaWFVBQKo7gz4u8LCA5BE6KBK
 /356WNVNWGdmsbV3MgWVGevbt79Nv6gckkT/pXqvNed038/ZZI6FnqxeSec5m8Dv1sLqh+QFB
 tLBbypTzbiSMZ64PYuvqims51Fx0R0wSSVeBj2yhXlvSiSrM7+RyTk03MUKBZVSOeQPBXxf7i
 Izj3yD0IegKJPJ/WzVSi2Zh+wydedONEsliaJ7LNr6TpyHSnogko0+hlfslu8E7HIc0Lse1jy
 L7cE4OL2vT7X/bpDmO/LtEo3IAj3Y7MEqaHQ0uOsEAwKOSIlhKZXco+GQ0thcZ0ceGUqTrUwC
 V4091llLgpzkujRmGjLpiMpvJf408hCGkv1zSPdRJhYesa2vJDgqkUoUWMCR6hwbvxeMlEBX2
 7ULz8M0OnhrBW88LYk7LI5oBtZ5t/e9WihuEiei3YeXYzD7rIHLPZkbeBD+0xZkpwXkkDqQ3Q
 9jU17HNOhBe5Dv5yvgJNQW5KfpxwhAHh9eMnScLFPAFZNXPEk+Q359rvDWXcm+lliiICXbOGt
 5V3l9HbsHzBDeSYqhq/qIzL84YEvgLly58tY8tjXy/6t9gCx82YxV7KyYecQNM06Nv4wnDBqM
 Appu9w0/pNBm5d6u50fzyolmAZ8T+zEGJ3p02a+IXi4NKtNO1nfUSrHr/3mi8qBqkPbRSFiFN
 5ec2JTwDVSv1+rdfQhjOQbcUkGAR9YdmGLv6nCmKWxlWewsr3Q2oHTJYJGkOubTdNiMzFygZS
 T/Eor0l7J0RVGRngZSOSnYec8iKPKArEk2VEj+Q==
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:15:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/r.UulW6sXzDyeTyrh07oD1X
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Everyone,
So here is v8. We still need ACKs from NBD and chardev maintainers.

Changes:

v8:
 -add Reviewed-by and Acked-by tags
 -rebase onto master
  -minor change to migration
  -convert to meson
 -change "Since:" to 5.2
 -varios code style fixes (Markus Armbruster)
 -point to oob restrictions in comment to yank_register_function
  (Markus Armbruster)
 -improve qmp documentation (Markus Armbruster)
 -document oob suitability of qio_channel and io_shutdown (Markus Armbruste=
r)

v7:
 -yank_register_instance now returns error via Error **errp instead of abor=
ting
 -dropped "chardev/char.c: Check for duplicate id before  creating chardev"

v6:
 -add Reviewed-by and Acked-by tags
 -rebase on master
 -lots of changes in nbd due to rebase
 -only take maintainership of util/yank.c and include/qemu/yank.h (Daniel P=
. Berrang=C3=A9)
 -fix a crash discovered by the newly added chardev test
 -fix the test itself

v5:
 -move yank.c to util/
 -move yank.h to include/qemu/
 -add license to yank.h
 -use const char*
 -nbd: use atomic_store_release and atomic_load_aqcuire
 -io-channel: ensure thread-safety and document it
 -add myself as maintainer for yank

v4:
 -fix build errors...

v3:
 -don't touch softmmu/vl.c, use __contructor__ attribute instead (Paolo Bon=
zini)
 -fix build errors
 -rewrite migration patch so it actually passes all tests

v2:
 -don't touch io/ code anymore
 -always register yank functions
 -'yank' now takes a list of instances to yank
 -'query-yank' returns a list of yankable instances

Overview:
Hello Everyone,
In many cases, if qemu has a network connection (qmp, migration, chardev, e=
tc.)
to some other server and that server dies or hangs, qemu hangs too.
These patches introduce the new 'yank' out-of-band qmp command to recover f=
rom
these kinds of hangs. The different subsystems register callbacks which get
executed with the yank command. For example the callback can shutdown() a
socket. This is intended for the colo use-case, but it can be used for other
things too of course.

Regards,
Lukas Straub

Lukas Straub (8):
  Introduce yank feature
  block/nbd.c: Add yank feature
  chardev/char-socket.c: Add yank feature
  migration: Add yank feature
  io/channel-tls.c: make qio_channel_tls_shutdown thread-safe
  io: Document qmp oob suitability of qio_channel_shutdown and
    io_shutdown
  MAINTAINERS: Add myself as maintainer for yank feature
  tests/test-char.c: Wait for the chardev to connect in
    char_socket_client_dupid_test

 MAINTAINERS                   |   6 ++
 block/nbd.c                   | 129 ++++++++++++++---------
 chardev/char-socket.c         |  31 ++++++
 include/io/channel.h          |   5 +-
 include/qemu/yank.h           |  81 +++++++++++++++
 io/channel-tls.c              |   6 +-
 migration/channel.c           |  12 +++
 migration/migration.c         |  25 +++++
 migration/multifd.c           |  10 ++
 migration/qemu-file-channel.c |   6 ++
 migration/savevm.c            |   6 ++
 qapi/misc.json                |  62 +++++++++++
 tests/test-char.c             |   1 +
 util/meson.build              |   1 +
 util/yank.c                   | 187 ++++++++++++++++++++++++++++++++++
 15 files changed, 516 insertions(+), 52 deletions(-)
 create mode 100644 include/qemu/yank.h
 create mode 100644 util/yank.c

--
2.20.1

--Sig_/r.UulW6sXzDyeTyrh07oD1X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl9OEQ4ACgkQNasLKJxd
sliKThAAlPcdYuFEqEPNtBvvSx5lNIwhhABpXZbwtGE1u0FhRHcV0J9s1kRn7Ane
n67CW8gv4Ud6AH8uvyMUQL2fqwuM/TiNfdxvZrzD0D+3N+j0fOEC65IK+1UhOAqy
j7n/YTZvS5CpsPzNjZbmLoE3Lnfd119DudaePszqS3B+fzl2oqM6DjIwd+MzvEha
cEwfD3IJZHBdyHbhfCmkAi7cSycobsk/pAY+bjrKoz6VYgk/5ZcwL2aA6xoWmKjk
oEaD9os351T0KbX+oeOb4gv6SlZLTiXAd7StEBIQFGwqkFCzHhwDd68RfBOVWcIw
pcFGKxXpXfz9hRog8Ic6E/5xkhpzFJB+v5kLQWen696dyQFTJLScv884qhkeG/Dd
G20F61luS4E5rADDP9Ng8YuL7hwyQMCUfjTGCTbsa/F5JWHfdoM720m067weBXcT
IuPaLPMCx+/7TJA/vihLTaVDVfhF4T2sJmWCye44oAtDFDI0onFeSp1fj8+md7tE
OqEqP5c5cifwpFDt0CnOspZTqoOvgjERFnUIY99vYsHe8vhkb2aU6N8Jz7VmwEe7
LfwR1w1Yusb0YejhyygTlT0CQ60YSnQhlOmxZcEySIR+33yw7i5CIGwFeQa3yMf0
hD/u4EO5ENcgse5XinRRKeQuOR+nHPQfu1PtEcq/xB62ebywHeU=
=KM+s
-----END PGP SIGNATURE-----

--Sig_/r.UulW6sXzDyeTyrh07oD1X--

