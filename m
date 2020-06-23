Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D1DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:46:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60DF420720
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Ch8QBjXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60DF420720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkCG-0006vu-EA
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 10:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jnk8Q-0003q4-J5; Tue, 23 Jun 2020 10:42:50 -0400
Received: from mout.web.de ([217.72.192.78]:38165)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jnk8O-0002OR-Fk; Tue, 23 Jun 2020 10:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1592923359;
 bh=zU3tUlcfEiS1VRl2HTIV2XY+CU7mnQK3zvjyq4JYrQU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=Ch8QBjXAoiwoBUnSpR+b19FjnCtys6Fe6FfI48UIC5yWbkU1vgEa5xZ9QL+2C6X4z
 NsnRgo/sOme90SdZamHOyxllaHaFrCWX5S9VdLAK0n82bVLalE8qFsspQilFFZpWdS
 AFGOOuQ0kbf3E5sc3ErZhV/fpQmFTIy4O8Gv+hOU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.8]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MSJKJ-1jPNtU1Dwp-00TXTJ; Tue, 23
 Jun 2020 16:42:39 +0200
Date: Tue, 23 Jun 2020 16:42:30 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v5 0/7] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <cover.1592923201.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/N/R.2eE6kswghgwr2nzQ.Wi";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:6NcYVHB39GveGzmUOrXYEBaxnK3d0/z+GR+MsokDIvZCjes2KRO
 1wFy0sHFldU/9sZmbHGbvlkd2++YLmvFjuyVDdzguHnJCMT2e8h/b9wqakVtsooU9BOct4X
 NEOIsxJrC3jZh2+pmIjBvNPqK/Hn4pSc0sRSO6pgGmukYUQGcCyj4LzAhIMDk9LQIqSrN4O
 PV8dmqtQ7SSVeM2OQ7Z/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xqIwGPV2rt0=:mHggX/GeUCjrE8SDnVLKBd
 jDkwhdUF7xYS/s0kmimQ77Jt2m1PYR113SwZp3pZBfx4J3Y+iZXInFoe7AQMQtra+7tSeKnm7
 gQ/OhhYYIzyaan3V2ogmjmvW4lrdxOHHW5TSPq2JzJiIGG3OYk6UqfVQZWbUbhq8c3p5mrRt7
 RjFVzkZDS3HKq7cGKTXgxgbcQdBBzEquM2jIQenxfV+Mo+ErrIyJxWQhEIEd/N8d2Y63ME72U
 o+N0Pr1+QTdWRYPyp7gtrTCl8w22GIqWEIpAUjz9QNNycMdWlOVUUCEbkMKX47RocGG/k7sZh
 nCwN/RE9u6Prq2dgXRhjHD0UPoFuj3eSe7Jufh5ueid1/K/VQnffLTGFxHtdTfcUqdvgfyCcf
 Y+J5h5E3/MhLcDLXzXl6cvuzx7GM2THwg02QerFZRiuOWOK4bD32miN4Ta9zp3ELLfapABTOe
 yoOrbMrSNpdxXw4WJhPPCtwpqjU/O3chtZG2e2ncJ6/q46uyGaC8p84gG+8YtAKgk1eGXTY9I
 M7q9albop0C/OcG7hFKcPToUBAasYZnvGBP5uNgVS/z9Y1auaOhvfbFBaHv1N45iyUblhBxrp
 85pLqMBlrcRmCSUTa3hCHBBOOeStfOUqkdt/DBXzoYEI3tg7+sk+76DlMKi/hVMxugnw0DhU2
 3fLn9sUouvnn2W8qS6+eOIJg0ePA5fkxv4l0fORFNnF0ph1Y/TIIXnnTkHOj81LkDSimC+Bua
 OZxa6SQDaxsevY/vEsL8iEu0+xz22mLpLS4zsX4Bk7wVS8pyFso4PWI43U6avvaGVZSCvwE/7
 oedNyHRhjAXvx93do694YN2YPbUN6daSgPCN5SOKKriEVfHGpqxvmF1b2UhkaUvFsoy9vaXMy
 GlA5vTDtfCs5uJyapF7/RzlJ2e4jD1b8AHcMPB43IswkdDwew7thPNZmouRKCL+ArgcYB+RcP
 7HAR50aafvjC51rB3wvAHP61JSdS77vvShbjLkcz/yKgdg9Hraqj/ef2tFOsYgzHN/sUKuG2Z
 ArG0NpUZ/dcv0IjWTeoA8q1mLxnNqoyGPSFFXhTSIarjiAgoECL51Kr9SJrFiiY0qAS6LIegx
 wE0vY6srHgxnMzZEcTcDjxHActhYhXbUwv6d9Clhzze2d0MEwUPjsaXrOQQMsO3VnqGyWGL4/
 PuRxSy+IY6Ana+IpQj+oHf7ZFB803eZYI5QGbWOVl8WzvpeSsMh8a3+tQZd0cP8YdFsOPZieS
 VBgsU4tdkgY9eEiC8
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 10:42:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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

--Sig_/N/R.2eE6kswghgwr2nzQ.Wi
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

Lukas Straub (7):
  Introduce yank feature
  block/nbd.c: Add yank feature
  chardev/char-socket.c: Add yank feature
  migration: Add yank feature
  io/channel-tls.c: make qio_channel_tls_shutdown thread-safe
  io: Document thread-safety of qio_channel_shutdown
  MAINTAINERS: Add myself as maintainer for yank feature

 MAINTAINERS                   |  13 +++
 block/nbd.c                   | 101 ++++++++++++-------
 chardev/char-socket.c         |  24 +++++
 include/io/channel.h          |   2 +
 include/qemu/yank.h           |  79 +++++++++++++++
 io/channel-tls.c              |   6 +-
 migration/channel.c           |  12 +++
 migration/migration.c         |  18 +++-
 migration/multifd.c           |  10 ++
 migration/qemu-file-channel.c |   6 ++
 migration/savevm.c            |   2 +
 qapi/misc.json                |  45 +++++++++
 tests/Makefile.include        |   2 +-
 util/Makefile.objs            |   1 +
 util/yank.c                   | 179 ++++++++++++++++++++++++++++++++++
 15 files changed, 459 insertions(+), 41 deletions(-)
 create mode 100644 include/qemu/yank.h
 create mode 100644 util/yank.c

--
2.20.1

--Sig_/N/R.2eE6kswghgwr2nzQ.Wi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7yFNYACgkQNasLKJxd
sliHtQ//cP9QUtEGNcYM1F40s/TLFDVLOWSIHSYgVOyU4YJUiSitxHvPGe2EsfoO
vMvySjIqJQgjKkZBOpwoJd3GgwtX24Ih+9xxmNMMHePSKdtrBtfe7gg00fENxou9
1cNFq9pkE7RW5TXeruhUSPFPX1BBynMQM62oPcTHuiFwBPaCCcSrEsj+14Wpa92O
4gz0pL4jY5rV3LbR7/q9frBCLNGmYrLn5C2iZIs5TyRDVaum8gK2DGPfUDdXe+kN
kP0ieC4gCXCZxxDGgVauMnUSmwPCl1jpYVAW7lwwnFemtWs1DYMrPlVsKmsQZHeo
UHCPiLBP7aAyQxzyLB0Rir2V4fWhtfixr54Io0xwHQ4yGjpP3ii8WlZH6pxNl2Vn
8VYYP/e63coX2B8aut0e5UmPKWVbwe+vY1M4/vYOlomTgEsKTm4170ve76rhFqqd
SZxgB2c8uS4EAA101qU4J0s43LDGSXb4iiKODSDuJr0tZuBxXuWOo9WpTdipXEbq
9U8WIa0HxQg7A+GlyVXjVhDRsK8+ti0qNEfJkMNqPu1NYHwefDaARcoVRzyNLdBn
XBP95zuzj8nuIlEysZ77BRapdumdl2zt3P7KcDKBqVRpHgQugnu3nZxDU0k+4sbL
h88WJsT6rhekJEleduC4T2BDm5ST96NxWH0A3mxZh1M4uymZUqA=
=xMRA
-----END PGP SIGNATURE-----

--Sig_/N/R.2eE6kswghgwr2nzQ.Wi--

