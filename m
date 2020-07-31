Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB9CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:30:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16526208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="JEw/kOqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16526208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1RMe-00011D-3I
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 05:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1RJI-0007aN-Ae; Fri, 31 Jul 2020 05:26:40 -0400
Received: from mout.web.de ([212.227.17.12]:33799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1RJG-0003FT-5p; Fri, 31 Jul 2020 05:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596187591;
 bh=6iMVISeNf/a8F1CLRILWmWekUb18QBn8w3n1uied6b4=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=JEw/kOqrJStkJn4qmJnj6NqZkuuoNkbSMXfJW/Wk43k14mVbCQFg+wxlHKqabjQcz
 gZDadOyYKtSP3rDlrc0KqfWXYDqjd+ayZeIsB+Vxb/dsiKvSFjEa9XKvvlhnpik150
 Aic9twv4yzYzeBP55r7jW24K78ZQj3RZbqPtrlwY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.42]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIL0Q-1jy7vu3TvA-00Enp8; Fri, 31
 Jul 2020 11:26:30 +0200
Date: Fri, 31 Jul 2020 11:26:21 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v6 0/9] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <cover.1596184200.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5Vu23TWvf86BJFdZE9wMLR/";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:aLzRWyVXOlBHhQF4VqSBe6oO5uGEQnDOpk0AdlM8zf90FK1v22b
 HIMD56npIWnFVTPbZIys5tfgZXtNxFmiEIG5mEULKsdbTfy2AzY3oSnTRZs/721IAs08HQZ
 HEpyH+hP/nRGgQP56eQ4kiXIpHDNkhz5cmd5+ZL/LOG3026pbRm2q0OIq3pLX/pmC4bWycd
 i5OGnJzqkQ9q+YSzwGjzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lXfGxIKOFu4=:3TjAN3kBV3obWS/WrjAkNg
 9Mq9khdi8RM4dk+Gth/OlL9e45STAy8s5d8l7twOK/Yt60J7qHUZZWZ0H2oxgOFaM+UyWogF3
 YaYEPhDrHED9DPMMuMR5i1xOC39Bls+L+dbhNZhnV6weHaaWJxMMEYE63O2wLU7y3eYrstKOh
 5/Spp84UraqGgtF/GFmXly9B0MM1C4jh/kaVDVhpWA8PTdAcvKXkkORKRI0jBQdrSjQtMIL67
 BYQErgOXYcTqlmSK9qNhdAwIMzr4p0oHdvRtn+esnm8MAt5XmMxHPOXNLyKDwhIkGaEekgksK
 F9XqeFXV3J3qfy0QyP7FPIGRNUgGXHy27IUP6R3j98NMW7z3Kjx/iAh/dlNTkMPOKuwYQO+OU
 W8X4+ZKmbyt76G+I7NEDnyNxGexCvlRWqUSe9npBAkoDdMgLrVo/sIPuX4x9No/4J1T7GeNxF
 mSayLcYdUg1tPR4j70pnUYf6hOv4qWfP97aa7InNdwf2+BeyzPPIfCdGBsmPb8/As1JrqFoI+
 Xk25/S+ki/eIFPnV6ElknMOd3hUdwNvxhL1OrVhMnZz2TPfErToHZGUR9X39i2hNmVehwOwus
 yeiBliLLzC2HaC7j5Jcb0T8+k+N1hnQkjky7w0/PhG6/7qqz6Z+k+usg+a2h0d8gLsQ46o/ya
 0Paup3wLaqGX4BfZZsqrOYC7FUps5aWTSwlg9/XEGXGj7JxatYLIdAxC3y5jnxITjd7GelNyO
 ZinF5dppNdX4EGtdexSogyQ9q34a1gh1l4o26hUIAuSXVkTx2ACSUbjCnh+YbU3LYTQ7C10bi
 WlmFT4VW44uKm+uAGGIJ87nc9k6KMcRkrDhF+ghFV2TNw6Mg+BED0Css0SqEmZVTWb1GgyW0k
 ywqTaLZ0Lb5PKOCmFsNaJsummq+rHTsX59jtTw4IBNOgdBNkiWauu80qb1JI9y7hWGXuB0Afc
 0RAt/x9wePsNrRLX0t3lUGvhULnPjKj0UAUzFWP1EEqmhx7TlKiaEekUCtV8v+8Ot2G0S0cnb
 tAQ8h7zccoOygwN2yBNBWkmGf0jPSH/zRIMLLrsGiHODmtwurDEnVdxZIofJBBDsRyibSu2ZJ
 A0RiRCdw+yb6mXISUaowa67eYr9VrAvgCJ2octHp/Hyige3rzl5EjjEPoB9qIblKENLIjLV9C
 vvxJqtf/a9g+Jtxdtaeaoz4r2zHdJenvlM0fzjra9RAk/Y6BPnDUmW6CmVgycdKW6W3vpKq96
 9r4hRIhuCHIr0RSpJe5jPat/mHf2tEXOuz0U9Bw==
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 05:26:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
 "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/5Vu23TWvf86BJFdZE9wMLR/
Content-Type: text/plain; charset=UTF-8
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

Lukas Straub (9):
  Introduce yank feature
  block/nbd.c: Add yank feature
  chardev/char-socket.c: Add yank feature
  migration: Add yank feature
  io/channel-tls.c: make qio_channel_tls_shutdown thread-safe
  io: Document thread-safety of qio_channel_shutdown
  MAINTAINERS: Add myself as maintainer for yank feature
  chardev/char.c: Check for duplicate id before creating chardev
  tests/test-char.c: Wait for the chardev to connect in
    char_socket_client_dupid_test

 MAINTAINERS                   |   6 ++
 block/nbd.c                   | 123 +++++++++++++----------
 chardev/char-socket.c         |  24 +++++
 chardev/char.c                |  11 ++-
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
 tests/test-char.c             |   1 +
 util/Makefile.objs            |   1 +
 util/yank.c                   | 179 ++++++++++++++++++++++++++++++++++
 17 files changed, 469 insertions(+), 58 deletions(-)
 create mode 100644 include/qemu/yank.h
 create mode 100644 util/yank.c

--
2.20.1

--Sig_/5Vu23TWvf86BJFdZE9wMLR/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8j470ACgkQNasLKJxd
slhT3BAAimstLOsl9weJ5kab03+8Q2bh5UTZiryXQxROXoHEn/3nACMn5hUs9Dp0
sgSjcAU1wph5yWw7ut84hy0XcXBZKHK/L6coCL5epyEQvdD8VHDmijOHcgOZgdM3
2dl+afpPfwe+PgzJCNOG3mRpmlwc1UVn9L8Q0Qc49wpg8QsuRKp1cz2X3neuFrNb
r/85sTP98FQNO90AE7oWo9QDsSx+JCEQ8I4kt4R2UUDNf68VY6Jz05bpryi6IJcn
JMTwNs0Q/1gnhvOyT7sAK2TaWuNfIO+XtkybUFbZu4qW8YaUsQjUJLx6TbRyC8nj
P09Ex7A2KFCSjmiNx3hIvvN/zq+1lLjztajXnwGNbkYmtiCOt9FVmu+4yNan/TNV
SVKtkqsgrrlS6jVgodwG6oRVftjdTof3UExuqPmu1HfHuAowfN5LVT0TtSVXVFhy
7ni9JBjTNNYf/g8e6Kp0d66r+EYHo5NmGiAXwFKB4N1YuyWpwUN5P6XHYx+ZUvN5
sEr0/F1cJzUD7GT0yLv2kX1Bq+VMPm7dCd0uMrgXSX9a93pRo94NKauX6LbLWeCs
ozcPVGC24PRjfbpPAXnjK+I4QrFFx2QI/KG1gf9KSeIdgcRh8Rpl0iptf8ijep/E
mVsghYEifPbzp4lC4AJ8h5vY+groqJR8Kqcuy6/0hs/VJNfWI/Q=
=4wGH
-----END PGP SIGNATURE-----

--Sig_/5Vu23TWvf86BJFdZE9wMLR/--

