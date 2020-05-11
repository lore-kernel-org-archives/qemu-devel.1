Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300FDC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:19:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E957220722
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="pInkQOOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E957220722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY6SZ-0002du-VQ
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 07:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6OS-0000LJ-D7; Mon, 11 May 2020 07:14:44 -0400
Received: from mout.web.de ([212.227.15.4]:55247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6OR-0006pA-Hm; Mon, 11 May 2020 07:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589195675;
 bh=humdI/22fGDkxx2xF+0v4LcfHfCCcq0p3L3ORQdAD7g=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=pInkQOOTMVzmBpxt0ZNcMjV6lPnjiQZZ3QrnzEJHsiBbw/jj7qdBKjMyagLVC6NAL
 fnT4frnhhgv+FNFCqDzgLqT86nePBiaz1mIIPpWgJk4TBgDOyGYO1vVeuJBqd+LKGQ
 6+zw+XWVJN1oy6ZBp58KeKszQenFf+4fR5PSH4Qs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.192]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mg1Nl-1jmBIM1olp-00NTI9; Mon, 11
 May 2020 13:14:35 +0200
Date: Mon, 11 May 2020 13:14:34 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 0/5] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <cover.1589193717.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fMdxexITl0+PoIdGC8dHkWa";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:6elkNXNr4kWfEFTrZ3gagqstdgKNhVOyO0SqbBkIjdy4hgrq4p+
 mdUaHHD8Bt+nHFAoZNPKFoRsWGklP2I7hnZ/lWGGnD5y7R6z+LKXG85pJPdB0gAV+7B2vBU
 x+Q3Sb9ndhvZYSqI4ArrcDbKPYa7NJkiUy50Lhhb9SGxKbKEvCNxQW1NaNOhzyLxaAyJc64
 eNpHrbgS6zoavmkQZ/xUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aF49x4xSdsw=:jye6um4kS5q8sE6+LkjlzF
 jw5+fCTMCTePzp686y3DsAeL6Ac7bHN0K7h673T9djzGoslatbPmYylJJc8x0aVPQUi0ZE7S5
 5JYO+RYS9WWNNcAtrbf/MD5Qx53xERlgEcCRMHy0hldkehpwlOvJx+nYbKNusPHkJLCqwc5NJ
 0rmyQ3wmxEbPr3/ezEiGljQvxog2izilSc9PkSxm89fYSHcYuUU3pUu8DgzuLm7EtnstSvjJ6
 x9MepwdhzTct1ACGRUlfbn0AXeGISfCUNx8AgXNAwVkFkvapNQVo8iPbN6qhdR32Kq3NgE/Y9
 rmIvcTYNyJ1rzYR6N5BGtZdJsghk7mKteKxZZL3sUUMaxGzsWKaXdQRVHOw68oHhgtbidmPMZ
 W++ipZrYXpjzHTKmuQ4Zq5xCAHljytvCAkPFnOA2j6a8iwlrrE48ksShDljAlS0fHZqVA5cJ7
 dX4KmgO5MgckaRC1rbHTilCt5vvWX6EP+4KjUfT7H1V4ACVgokG9y+7/bgCxqdQkZhWO0+KBx
 os329HyqyfuYxurz9TLft0dd99VsfSYr5K4hdDmwF1/gStejRYYZaiPLXu5yJjxdIPJ/sThaX
 jDFnZ65rxbAOmrG/K0R6766K2TyMAbwCNQq1Ri9fc25iYXXLhR+3hvhHvQzq5SysYomOcF7Ys
 zmYO31Wy6ovfNENsULZHp5B1LOLcscMrnuj4gCLM/TJ+sDb8/02JgXRojQafM0aT2r9vyyZXG
 3d2oqb1aZVRJWZ03E09T8FnCs9hXfxyqibktqnxF6jwMPcZ4Xt/F9Pwnk86IBQB/ZDs8HNnO6
 48suFFa1IuAQ27nmAu6Z89FcOmkjL4IhE4rcxBz9t55/lpwydSKulI50xo0rjeeGQRQNCLBNh
 p6uv51EcMCcJ1Si0yzMNXPhY2zz5xeyEhHQn1PwSEcYKAEsjcWvuZ6+yJLz1A7leLQ5CcC/on
 Civ9XZ/kHG+x9HGSC4xAfWWKYJZ9USpOgdvCbsO9f/DNbW79I4DizSuE03uNFog+HYka47OJB
 1ELICu4+5nJYFLrMXXtAzhCFwmojIeoGvG2ZMVUtdqYu+Md3Ph6Bqym2KQ2kc+/kfqJRyjHdG
 K/6FYxYhSMio7XupVVe4pMHLGEgrR6SW68rfPLSTzWKKcV59rcSpoDgNWLFky/NbL8x/NYKLz
 Mcfvzbm7mNdZyiM3JBWDhf1kJdC3Hi4mVzme7MnXtAunWiRMPt6IKCYhgvEOandu2zlNAZd93
 JtiVbaDkK+SxMDCoN
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 07:14:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/fMdxexITl0+PoIdGC8dHkWa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

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

Lukas Straub (5):
  Introduce yank feature
  io/channel.c,io/channel-socket.c: Add yank feature
  block/nbd.c: Add yank feature
  chardev/char-socket.c: Add yank feature
  migration: Add yank feature

 Makefile.objs               |  2 +
 block/nbd.c                 | 68 ++++++++++++++++++++++++---------
 chardev/char-socket.c       |  8 ++++
 chardev/char.c              |  3 ++
 include/io/channel-socket.h |  1 +
 include/io/channel.h        | 12 ++++++
 io/channel-socket.c         | 29 ++++++++++++++
 io/channel.c                |  9 +++++
 migration/channel.c         |  2 +
 migration/migration.c       | 11 ++++++
 qapi/block-core.json        |  5 ++-
 qapi/char.json              |  5 ++-
 qapi/migration.json         | 17 +++++++--
 qapi/misc.json              | 15 ++++++++
 softmmu/vl.c                |  2 +
 yank.c                      | 75 +++++++++++++++++++++++++++++++++++++
 yank.h                      | 12 ++++++
 17 files changed, 254 insertions(+), 22 deletions(-)
 create mode 100644 yank.c
 create mode 100644 yank.h

--=20
2.20.1

--Sig_/fMdxexITl0+PoIdGC8dHkWa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl65M5oACgkQNasLKJxd
slgLVw//RrE0dxe7099otWYb0fLRtBKW/pknxHtMLHH5VrhumzeW2Bz+yJlg7kZa
axZkYRILyfZH0xMmL92dI51rMuSUBz+xlzzBSH3yp4lIuK2PqpQYvUOq02nwvggU
NdKanbPVUGw0FuKgRUO3X1UDBSsJ9Nc1mvfPwtJl+ZjxkfPwdfemuDibJ9Fzagn6
iI2rBdSnSDumSw6TL5m9JYWx8OlHWonwrBntr/HZUL6CoOKcH9xiY/Nv4dtdNgfy
FIdChCrE/gpVAwsF0VOrOEhzX4Epgc7rcvgJfopxou6Jrh5PcrS43sqoDufrVuQx
QSCYyGzmkKLbAJNtq20IIbxXiejDY+6ASc8rRVq1S9FtXKzlYyu7RJyXYKiKoR2H
uflSfMZ0AgS9lBFg/DNfDoeL4bhOBObaZpD6Mq2kL1AzdiTRdlMu1uLEPl1EC+RK
bjfn14Sk3teNtPuuScc9hqLwSqEier0iI3OF+7MAo70E3HGctYIIKhN9/sXye0DX
gFqY0n4piqwjPmlPVAcz6XtxxBfehWocRI3alK7PEj/0cFFNwRYp5WSWfYkqWeDJ
keHPvCF/v4xxEQWSE8hXLHkMf7lOttT7P4uSDocYDxx94EK5OHog4FwFvbt/1kGG
0j0m3pJqanNy4dIuq8MnzBAAaEiY6VtVNjl926S5EVI+Q+TM0Jg=
=b9EB
-----END PGP SIGNATURE-----

--Sig_/fMdxexITl0+PoIdGC8dHkWa--

