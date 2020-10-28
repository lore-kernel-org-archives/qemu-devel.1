Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3715FC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5357D24810
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="RajHddji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5357D24810
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXqUw-0001t8-3Z
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 14:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kXqRl-0008PH-SD; Wed, 28 Oct 2020 14:45:24 -0400
Received: from mout.web.de ([217.72.192.78]:60595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kXqRj-0003BN-J9; Wed, 28 Oct 2020 14:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1603910711;
 bh=gY7i10TEaU2/eOKJP/udGrOIdMye9+sBU1/d7gcanJc=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=RajHddjiiFG3l6G6PUkgKOXYYbCkeE6WrbzYcUJBeRuo51ZkbPXdkpnd3tulE3wOE
 qM7T3cLVcK2ldZ9Lnkg66GLwR3MHLd+4c+JG0QQuFAoPXwLlAfU2MDVpqUHx6B5ZFR
 bptrNNvgTpf9+p3O1KcdwSKTVsoEe4nDhswakUw4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.124]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLzit-1kpEs22E0P-00Hx9d; Wed, 28
 Oct 2020 19:45:11 +0100
Date: Wed, 28 Oct 2020 19:45:09 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v9 0/8] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <cover.1603909658.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_oPfq+.m_5Lj0FzweqS5Yxi";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:/s/RacI4fl1qMJ0VaH2npnWHP0WTk0xRU27MrMq7WvDDpBnPdwj
 ipjzzceEokmZ4poXMwLeoAKZku2R7IKcslCPygYLFea2FMw+rgwQDNjQ6R3rXDWZOfQx2mo
 UaewMn13jRSWX6Aq0adsSJ8U9sRPVYzMMgE8Hv2otJAXK/vFiZY3dpkmrv/UChEZrPh7RlN
 1Tl2rX7qTy9bOA0eguLDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qSohH+QEI9I=:TOyVKACfAr4zd7CK3NGN4i
 l9jE6R534yNQUpFcTAD61cKBm3V7hRETLMabXpFZBep9XPj0c+LuCKgH9OWDF5WtG9YkLAc+K
 JEuWgML94u8kesdb7hbwWUxsUY+cfdudsb9dMbavWY5waYJ2/ChvL6sRVrzd65nLBqoBnWffJ
 cnfXCEq3Vw6hKD/cD82E/gLaVlMNG87KDjVuiA/TIZjq9llz90whWx7oBTNpQWjTVB14P06jm
 fbvSIrjbBMaCrYeABjZwVZv1soHzgvyrJeBDJHCnPd6tKXmSKgihbZ0a+ak7/bV77tbYGaM6c
 6/3HxrUzmpDNP1aKaVitiF2zwBAEQ40YeEnqurLf5Pi7/sdWPxpG6x4cg9rLRD9/17rYbmynM
 NwKTpsTIi//yabGAxRjZ1cLNQO4QmVOvUbYXFrXELIW3VzbtH8pNhmq0GkseYz/uPgW6+LjO/
 aXUmt3Gx33B+srIWvGS6i0ugLl87Krdly+SBASBDVHS3pDr4AERqc6UxWW8ZN/HB3uL+mX96p
 X3o/nElJ76jVQti8C6+sDwqG7e/QTnCRGlE8aKUDROqnwMcHXUeAkpQYIgKfcLRVm2DnxbZHS
 6ppInP6NGCgaYm7h7Z3wMguZnfXDu+3Nk1GxS/dit2dkUD0KXqv/K0iU3hltY82R8Ifpi0PxG
 R4cQvVr+mojJXA2B7PzmuXcSFtsQH5VLmQp3LXSz3tFYlnJmK5BKpvDd+H0sW4/Bksjr4d9a3
 kGrpgbjkEMH4nwcu/SmIixsx6G2u8rHHl4Y9LbX6GgOguNUvGkPDfuWRa12K/qjRKlcwI5Ox2
 n+fknuUEFT3nGZoDHXOkF735fjeneuR+jSw6gAK9WKZxG2DeTPIw51040CyHPnRoU8ezTzDn/
 5v59fvD5LFRrxy1cGAVw==
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 13:12:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

--Sig_/_oPfq+.m_5Lj0FzweqS5Yxi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Everyone,
I finally found time again to work on this, so here is v9 with the new qmp =
api.
We still need ACKs from NBD and chardev maintainers.

Changes:

v9:
 -rebase onto master
 -implemented new qmp api as proposed by Markus

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

 MAINTAINERS                   |   6 +
 block/nbd.c                   | 154 ++++++++++++++----------
 chardev/char-socket.c         |  35 ++++++
 include/io/channel.h          |   5 +-
 include/qemu/yank.h           |  95 +++++++++++++++
 io/channel-tls.c              |   6 +-
 migration/channel.c           |  13 +++
 migration/migration.c         |  25 ++++
 migration/multifd.c           |  10 ++
 migration/qemu-file-channel.c |   7 ++
 migration/savevm.c            |   6 +
 qapi/misc.json                | 106 +++++++++++++++++
 tests/test-char.c             |   1 +
 util/meson.build              |   1 +
 util/yank.c                   | 213 ++++++++++++++++++++++++++++++++++
 15 files changed, 619 insertions(+), 64 deletions(-)
 create mode 100644 include/qemu/yank.h
 create mode 100644 util/yank.c

--
2.20.1

--Sig_/_oPfq+.m_5Lj0FzweqS5Yxi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl+ZvDUACgkQNasLKJxd
sljedRAAqKeVF32TpQoDDDz7a1z2pKzwH+Gj3AgoerwA+Pny0qmwnI/pOttBIuYi
LpTArSjsq/jlL2iAaaZjK/pRLzWV2l//3E8Q9w2/v4TY3PFR0I1qUB1XB5fdhCQW
0l9LiLJhxb3lQE5q34MumL/McDyFlMEo+ouF8CiAzWZxkotkHYdzy1peYMTH54Nw
y14sIorH8jPP7LPfCvcKKIglzpE6zyAqWCX6UI2yYO4d+3/vP+kQMDnd9pBb6bGk
wUzKY86rC/Dj27BEh2XXKBOJw6PPh8QHQyW/PdgHOB87bihi9Q2QllGgxQ2u/ljB
L7/Re+gYkHpXYTkHbIv6AtWUby1dC0EHG+l1ERot8JLTVcqJHbtuQKZyFOEfi0UE
V8HogptyjXlwpBzobebAOK5E57mmEmNGBAfcnt+Bd+T7+XJjB9mGoKtii4iKv1q4
W/rX8Z7xnxAILQA7D5DSLHUKxJsPAZVS4So09anszIkOO2IbAdAeKHPWCJ1lBM7q
JBVvZkzELjzmfXBXEu9l91l9T49kYCjrmUNQSMngm75C5goBSu54pKSIEOYvXWux
Fg1FGDo4yDw30IUFUAt+i/f3Vt9G7oIBMq13/6iLJFmLx24K7qTttT6n3izMg/RS
BIzJX7NKTizLVa66bJF8Kzw7PvVCRnG5lenMqLCbA43LmvlCX40=
=FaIK
-----END PGP SIGNATURE-----

--Sig_/_oPfq+.m_5Lj0FzweqS5Yxi--

