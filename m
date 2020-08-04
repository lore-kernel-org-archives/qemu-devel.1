Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB75FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9857B2076C
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="J8DTQxc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9857B2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2s5h-00059L-Fs
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 04:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2s2u-0003Sd-6e; Tue, 04 Aug 2020 04:11:40 -0400
Received: from mout.web.de ([212.227.17.11]:48711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2s2s-0006Xq-61; Tue, 04 Aug 2020 04:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596528691;
 bh=tt4CfBrPqNa4STCvlVrUvCXyhJU664diuChsO9HDeW0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=J8DTQxc9XNeAkEg/mSoMj/p25XpOduZVpT5me6XNVWm/t+3QmvySScGjB5eWFfz0U
 qZ3dZImoMxkqPAjKiZ6WOlTwo+Kb7TpmpleBsRIM81sWHBjtB3NsKKvrbmA9WXFTHp
 o9IfGALahYgmx1ClZYiTrnTP71CxTXiF7444JsIc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.220]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHmqC-1k090W44so-00EuSA; Tue, 04
 Aug 2020 10:11:31 +0200
Date: Tue, 4 Aug 2020 10:11:22 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v7 0/8] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <cover.1596528468.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/R7aGbvbXJu4tr47udY85KCC";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:P09tMGEmfo0Kpsda+maBBA0CBgciK0j5XQYuNSG/98uesAvu2cj
 EH4TPTHRLYTzacnvcMrj0/wc8Fv2bredjR+3WwZ/1brygQljlQ40JljGdfe4YiS/FoPhHcd
 3p5jhOfomVTL27J3i6fiD1kw3j1pl7Ld+AozNibhEJ0FByw0X8GlaLfhzVZZkY26PCQM+7/
 xX3H1y2vX5ytVryHhJFwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nlUIZ+bTqR0=:aT6Kuk4JfOrQ/ew7ZjKdnZ
 d4gblTFq27u5jrTd4INzPXNig9h155gWiD8vSeMsnHNgKBW8KdSCAnKlO1Lccyb8KHrIfQRKD
 uhY1MlGoX6QplatM174D8qkgfwo4GHTpVFrfdUNobbba4svDvfcADMMkABo653I/mQYahkT60
 WMycYfIIgedeEXZ8AbbP8rxRbFyBmozt0/hdFunspuZZUun9FAG1JNLIijGrNqo9q6ZAbOK2w
 pmlREksbVRzcGvDh0jlUwnnttGV39tjLWpNu3EbnO/jDCCYaQy8pfL5HpdylEPglB6vtzvUkv
 yWLe+Rc7Svl6ccE5iAtRh3p44IZVJWS+uoGwAwrfyXjFYDp5jWLQAMns+Gmwwx9WCX9TeYPdd
 oS/5mKGjQT8u7C7+E+3qyE5GIovfxfMm0TcDywlMS1HqWF3dn5rgDHdqen46yF1+9REHwuPVz
 bKg23Xrj51iG4myO3Hvi1g1PmJXpvl/YywRLdIjpbvpfZUwcQtAyNZLBm4RiMQPJeSroaAM6z
 g93QWU1zNJRB8Tgw6gpr1GmKNnNgAih81K2GkFyGUcvnpkwfMYVVKGdgPSWNDpv26dmvjwmZL
 UZpB5KffuYwfjBuqxeBI21W0uaacxdyWjRsP/6zpNrYbrJSfxju6KeUt4Vt/mNOweLxdg7d5i
 Fk1QPevBA/ictwcdKhva3K3grOFifXOr3TUJ9UKLh5x3vDzRzykWqCvQTnAAqlNF+23TPTfLG
 JQBP8sWr7jSD9axuisx84D4JUOx9vJy21sg8znzMW4GkLpCXGKU0WzeM3naT0AcnUxEddivVu
 bdUBF6R+UKksDY97Y+nb8+7isIJG0JI5vYA2FirSPGtoaLckChmeElScUyx9SzBQ0YyeD0fbh
 FSkt6/fY2p61HVSWDvC6B2McZuzcoO+r7EpgI5A+4RgQYNlDojNctX2rDL0GWOMuyukJYIUyZ
 HFqI2XXg7q+FRfbVrePVOtqk5Z/RLCkEJJrn9lmTMWHM/CTuZTJssYwFjiSljQXYqi8EF8WfI
 MZY5nPI+r70hPWfxBEsZD14ng7t/Iwcu0MlfCVwj8+uU1tSFiYDSWTPwXQ+vMJbb9AQMAl3r8
 pTuwqgtZHIru3GXo/T3GniXArsCVhFtW+t4bSLxGAU/EZbOayncRTWH5XKVYosVykPA6G/QY6
 ZtKBtouKy+RBwHtln6R9mBB4KjeY8MZtdk61NuUh9LFCzmiJf8kK+sEYinvKKq1PHWr0Ud83E
 3OCkXZd60BbL870OSUuf3LbZ4D58kozBJdqd34w==
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 04:11:34
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

--Sig_/R7aGbvbXJu4tr47udY85KCC
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

Lukas Straub (8):
  Introduce yank feature
  block/nbd.c: Add yank feature
  chardev/char-socket.c: Add yank feature
  migration: Add yank feature
  io/channel-tls.c: make qio_channel_tls_shutdown thread-safe
  io: Document thread-safety of qio_channel_shutdown
  MAINTAINERS: Add myself as maintainer for yank feature
  tests/test-char.c: Wait for the chardev to connect in
    char_socket_client_dupid_test

 MAINTAINERS                   |   6 ++
 block/nbd.c                   | 129 +++++++++++++++---------
 chardev/char-socket.c         |  31 ++++++
 include/io/channel.h          |   2 +
 include/qemu/yank.h           |  80 +++++++++++++++
 io/channel-tls.c              |   6 +-
 migration/channel.c           |  12 +++
 migration/migration.c         |  25 ++++-
 migration/multifd.c           |  10 ++
 migration/qemu-file-channel.c |   6 ++
 migration/savevm.c            |   6 ++
 qapi/misc.json                |  45 +++++++++
 tests/Makefile.include        |   2 +-
 tests/test-char.c             |   1 +
 util/Makefile.objs            |   1 +
 util/yank.c                   | 184 ++++++++++++++++++++++++++++++++++
 16 files changed, 493 insertions(+), 53 deletions(-)
 create mode 100644 include/qemu/yank.h
 create mode 100644 util/yank.c

--
2.20.1

--Sig_/R7aGbvbXJu4tr47udY85KCC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8pGCoACgkQNasLKJxd
sliozg/+NslN18tHJh1syoYtAQxSJZTp3vspJw0OI76Jb3MqFM2S0+dhLUa3Ru2M
YwyFvXtrknKjq5H7nQlprD/Q0B2u9yw95tIdnOZvb2H/kZAiVlg9f/S8Qpox7s1d
PLcsTnqF+rmb905rNKzknkfQRYYaMbDLWPeqHJaYwE5c9AqzP8QGEdV/TIoUYbi8
HEDhnSaBxP63s0CdaN/mkB/uXWECtP5jHlvOJEaqbOIzD4WhbLUF5hTwygASLCWc
+L4BcFwN6sttVjiXvGpqYv2SlZzYFCBHcj/jP7DlfivVsk0pIaGyrlhPnVYLd3Qq
JHvRTEPTgG7KLcFMo3ndNaes9yBCmCyp01lbtLfB+Wt8dj513Rh3UK75lCf6p2Kj
I38UpMYlLMzdyOmmfwOv3rdXVTmu3B74YZHZK/pEqr6lWDvzKeA6W8SE9oua9D2i
zk7L/WweIpaq102Sw30JtE5zVK53ikCR7bGZzlxX8fX8M9MZrLLW7cPGLag/KHnp
u9UEbl+Q7jfIQCiXhJIuNr1jEWm2Bg8NroTCWbV3biBCgHLP+zcCwE0bwVsZy8tL
8xtRBVz5Q4YiIgTP1xaQ4whov17QnCLl777OBb5tNzToSdYnP/5VsnSyjkDVen6+
/e9Uk+PJLAbufYK6QW5kqxuUhpaEqfOPFEiEwNLJJtqTdrrN8Vg=
=nOg8
-----END PGP SIGNATURE-----

--Sig_/R7aGbvbXJu4tr47udY85KCC--

