Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3452FC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:43:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D0E620704
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="GzhocY6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0E620704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYXUS-00067C-E6
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 12:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kYXSj-0004LS-OR; Fri, 30 Oct 2020 12:41:13 -0400
Received: from mout.web.de ([217.72.192.78]:58891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kYXSh-0002yb-Cr; Fri, 30 Oct 2020 12:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1604076064;
 bh=cEnGF3z6JFjp1yKe9fS8Lol1ng9vUZxbZH5HFD9YxDA=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=GzhocY6JF+zto9WG1czesanHdb51mogKmFHCia9Vl4a3KkuAFolJfo3WXCgIeUcrv
 86qzdviwtyPjJF+APwD8KXwV2NyEyX3qv+BvwOY7jjKgykbXVfDjATi+5W2IqRjDnb
 JwfaARMG0qBTLBTtg6kiJ1bL2hkw3UCg740WiQr8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.100]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3ouw-1kPqKW2WA4-00zpVR; Fri, 30
 Oct 2020 17:41:04 +0100
Date: Fri, 30 Oct 2020 17:40:43 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v10 0/8] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20201030174043.35300683@luklap>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SljIgE9jACeVLidWv1OjmJp";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:KTfO22uQAZN7z/LBxV4S0befgY5ocDWtUyTNm7kslt5mxh149UN
 NQxCjKXpRhBA6cqxEKHbdCBM+13MwVuJtjy4xA6ruA/OizjFHUfwvGP+Wo4Re7l60WPsGF3
 4c97z1WF+uyqsZaUGIa8yFPlU6HeQosFcHx02JYQdRel+TOWwcIsS8P/xNPZqDP7BzR7At6
 mhhkslwl5GYTNbNFqoPuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4ji+KlfLjdk=:z13t2zrx3JWhdHwqNxSRH0
 otXGgP4reyTtgUxDUu0kgkR9bGHhn406xp1vo8OBu9Cgz5YkZdlbWWvWJe89Ng3PoPGQ7Ro47
 HKwAmdcEH1fhKR3hhG7UxvIF7fjhmzjb57TwF/0fHqoa/3rGp8CoWQSuZjg72aj0ynl3sVu8G
 97RKnUdvf1iXHK3sKCs9FBrm6HSdXfSQVGah4s9fVhHvo6yVFOQw0VvOlhPhA60xP+CvLZO7W
 RcUxnAIQMvcmIAYsHBle4QOEbOKgKX6Ghagh1EwOmFVMvnxf0rTV2qj/Ux8BE2rbklZXMmJ28
 CIgOwKfueHYRlGKmM6lvBTublV8Pw1c3x+dN/oab4Ci48PVuK0NbZ34Apxu9CktD2DLwOdanu
 VmVHZY8NiVgXrkUE7Cii60tdqJYIfRBPTW588Dvqo4hLOtUqb6HZa5aTNgSiq7on4fuM25XmP
 f1oeobgSXeU0FVol8H9YDprsNRHRZ1S5eTqDojJJt+/mVqqL0hXGwAjkjzh8WowzzGXwdxiY0
 DdOumA43rsFFeqss57BbyTMc9w5pGA+K2zR2St/2pQxgaMaObQ+Rv7GIJMzQ2Cfo1iVNtRsdv
 RYWqPOJtnjPQ3qzq63w+8zrg7k2NnSTEMVKV9Hr0z2d0ZvcRWSJDfcNrB4TaO8UblihJUGOiu
 E68X7r+7w+N4DzJT4rWBTWhCgGqne+x6NA4owandhjZ+8DxAVBfIK6eZioQgwHQpK02WBkct4
 lvx5NRxweBtAZXu/pcqoQxgMDMGQC8Cz/TBcEfd2SavhIj8UnijKnZb1AZfsw+gzVZNIt4nkD
 917HgZ4RXKBAkfnyGHnCr7NOKY+x7qpEBpM8GGpZKn/fv0uKtgaOVEI7NcTNTlSUHYNv69gmD
 Qd6ov40G4GEzN029sF6A==
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 12:41:09
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

--Sig_/SljIgE9jACeVLidWv1OjmJp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Everyone,
So here is v10.
We still need ACKs from NBD and chardev maintainers.

Changes:

v10:
 -moved from qapi/misc.json to qapi/yank.json
 -rename 'blockdev' -> 'block-node'
 -document difference betwen migration yank instance and migrate_cancel
 -better document return values of yank command
 -beter document yank_lock
 -minor style and spelling fixes

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

 MAINTAINERS                   |   7 ++
 block/nbd.c                   | 154 ++++++++++++++----------
 chardev/char-socket.c         |  35 ++++++
 include/io/channel.h          |   5 +-
 include/qemu/yank.h           |  95 +++++++++++++++
 io/channel-tls.c              |   6 +-
 migration/channel.c           |  13 ++
 migration/migration.c         |  25 ++++
 migration/multifd.c           |  10 ++
 migration/qemu-file-channel.c |   7 ++
 migration/savevm.c            |   6 +
 qapi/meson.build              |   1 +
 qapi/qapi-schema.json         |   1 +
 qapi/yank.json                | 115 ++++++++++++++++++
 tests/test-char.c             |   1 +
 util/meson.build              |   1 +
 util/yank.c                   | 216 ++++++++++++++++++++++++++++++++++
 17 files changed, 634 insertions(+), 64 deletions(-)
 create mode 100644 include/qemu/yank.h
 create mode 100644 qapi/yank.json
 create mode 100644 util/yank.c

--
2.20.1

--Sig_/SljIgE9jACeVLidWv1OjmJp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl+cQgsACgkQNasLKJxd
sljDjhAAip7hPuvUgMoadFGdeZpyr0Ey+p/Nflab0xXU2xGkvg2LVt2iwsJztgQk
5cUGkql78ehjH7LphD2+GhEWj7DILyYEiVE1ixU2FGjk49bUzianODuGLzxzcHn0
fpFCAE93LBmk1Z/D6JfyC68GJ4367Y+vC7IQtX0oerrr6gS/l08SeP8tpNSVgFpN
+IfJVRH4vq4KpO/EUC7HiarcvZUR7sMdaT7cac0taWEusweWA0SN8Gtmhk31kh8X
Ha5JZUDRAS1YaLbxMXu9sdQOjsiPXu+gw1fpodhEgOqDAF1g7kPEMOff61yiHRKE
cRXJ4S60L75XFPoNNSkMRlfAB+5UB0Z8dq7druq1lva4jnECZZ4xUqPv1O8smyQ7
hHTSg4q6jSkshjTGvk9Hy1/fer3wcSzJL/qEVVxkEuiEWMlFonRaHMOIJcctCgib
vODrmkfU1cfIf6nOZZzwQIkknogqO7TXQyx+bbbrNk1e6rJwFRqzljEN/LKp40yI
xxkFN9fW59ssVyHqEC/gJO145vzMM9mHEma4oyWVcOWeBP5LJFuMMvgwBtbuGPKZ
ae7BY6wy52NKXRNXjOGcEmWeh0epQXvRLE+7cdYRKH5vULMbFH8TamdLbPltTpVL
nPZNQmGJ1fP7ivCXC45mvza6LNRI+7sdFbAYMc+jafKt8FPKCJ4=
=Sla2
-----END PGP SIGNATURE-----

--Sig_/SljIgE9jACeVLidWv1OjmJp--

