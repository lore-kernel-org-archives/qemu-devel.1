Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A15EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E79542071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="AP1PWVxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79542071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdFN8-0007k0-Sl
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 11:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jdFH9-0004vA-Px; Mon, 25 May 2020 11:44:27 -0400
Received: from mout.web.de ([212.227.17.11]:44687)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jdFH8-0006ca-Hp; Mon, 25 May 2020 11:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590421461;
 bh=7l8UDSTdzyHaeQBjUvlzWesvyPNzew2oEjteVv+RyzU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=AP1PWVxRzVn6iwFnBMWPwtdyJiej3qEZ8Trvuw1uD+ugvHBFIr2EP9xBOUY9tejk9
 dcAHAEsDPdXT3PnfIcx2YmY44wzuZzLD3GG/q2WhYd3EcuO0ZN1iPp6Eol2oBftORf
 jrluOKy2d4iBE4/9uG6KSMtMKPi3JA4awA6YdDpY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.22]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlbHE-1jC7fS42eA-00im1p; Mon, 25
 May 2020 17:44:21 +0200
Date: Mon, 25 May 2020 17:44:12 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v4 0/4] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <cover.1590421341.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/phtN7D_PkqiSCtORxrJa0VZ";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:NV87t6E6YkeAwS5rDo0MTgaIDclUMjMb9YUzLCdQhKb/QbN2PGe
 8n3B1d8XYKOEDX0ztXq4xqSmHMXfnax/8iyAPQqJLYh6zKRUrdV2b1kjerJRUpBsmpTgcHU
 2opkIpxeOnIguoPowg2X6ya6wesMIBRpMvcYrIckTbI9C74HbnrU6lN/bRiIrw5fG//mvXC
 GoVGsoK5YIALYWpxvbU/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6/nIx4o8zck=:QZvHcXJCXA2eCoT3ofpO71
 d5lroxjUkSiAEP79a8uqMnVwvnDuVidKk87wlSKgIOX1RhZiLX9UPfOd58aelj9kErvO/rZ1h
 OTZAycVJ5R103fHg8qSTIC9LIiiPlmyJZjdRAOvX1771qZoFUj+jWnoFwaeNCML5YzhedZZSK
 4yAG3LTq2dv5rUrvnKvhT5P1ES+3uhPoZsApQFnt10zlF1PoFda6O0/wY+6WCiT414G9WMZJ4
 a6tIWL+kCo3sXp++8Xpf9od68kHxEUMoS1B2h7QkNW27ICj1STNNNvwlZ9+W0t4UQcFPkz7xN
 3z2teLxfhQ+NrCrco2duyKJBGVbwxyXQcw0k4tbSgEtyIU4CfXhPntc/8p+VwBp1WZGpAkszo
 ohJV/eZqxNRNCrB1X42NFyiydQqmK9ZgySsOoJlQOjxlUjhHiQeGZOgD0+n3kVv//J8Behjfi
 d57ds1uW7Oml4wcwcR2XeEAV2qqDMGVQkdlGnNwtrnXA1/ZustMckYhmxVNQJWWa8jQNJBajw
 lGrPw1McWq/P7xr+17m+d5Qywg49b3pm27WNihiiG5HcnvIMDcwLAUbolTSW0f3gyB4rfi0ov
 5k966IsZT4XIv7c0ezR7jCvCOLkzQ85BVybxJs54stTFOm6yTRR6p+CSKz61pQNxlJeXjb6id
 GOzRuKauzfzVhjI7Xh3/ApwSEFs2AR1qEW4bK4UhsDI3DkO4372J5qlisz9pXvffqvP7jcJVf
 CKuhZx1uDSeQKdUYH4933dpgeT0D8KoRqrrzsDzVh4ST+y0pQcCAwmgPr7svPme3sCFx9qu+G
 lTn+nxvZmu5uLo+DMema6i0KaD5clmQ6xVTY2gEudHFT/wocMiHFQWqX9SWXHwU7O6ozzOF9d
 rneM3gOqV72/lQ+iL6bC5RtKwg896KBJ91BbV7Aeea1OXMb3nDi6jpnvWo+tRZyeLqAQ5IEof
 7oCocCf2Rk7/nlcEE644gbRGpjeSid6OvaMS7EP3Tse67djT3gFCqthxViGp0Ims778QCvLSC
 EFlUOnzH3ur0Ybwfo6RUAGToMnSaeZFQHuORy2UiY3cycFkV9lS0KgYZfa+6ZUFzcINdoMeJh
 GXfChFm0Mum1hSAedvnH9YO4W/TO4omw/ywcaGKVYVRrA+ByOpFgW97Yzs5k2zEh521pHwdYe
 mWTxD50V1FM3HCn36YEucQx1QiaDSwMEg3LsHkk3uVmoZOPkFSZ/N6l7yMJBRg0jh7NI73Vbp
 CFTnuAsI0X/hKEnPK
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 11:44:24
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

--Sig_/phtN7D_PkqiSCtORxrJa0VZ
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


Lukas Straub (4):
  Introduce yank feature
  block/nbd.c: Add yank feature
  chardev/char-socket.c: Add yank feature
  migration: Add yank feature

 Makefile.objs                 |   3 +
 block/nbd.c                   | 101 ++++++++++++--------
 chardev/char-socket.c         |  24 +++++
 migration/channel.c           |  12 +++
 migration/migration.c         |  18 +++-
 migration/multifd.c           |  10 ++
 migration/qemu-file-channel.c |   6 ++
 migration/savevm.c            |   2 +
 qapi/misc.json                |  45 +++++++++
 tests/Makefile.include        |   2 +-
 yank.c                        | 174 ++++++++++++++++++++++++++++++++++
 yank.h                        |  67 +++++++++++++
 12 files changed, 425 insertions(+), 39 deletions(-)
 create mode 100644 yank.c
 create mode 100644 yank.h

--
2.20.1

--Sig_/phtN7D_PkqiSCtORxrJa0VZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7L58wACgkQNasLKJxd
sli8mA/7BhPMvBQouH3esjIdgh0zhEjWCPd3iQNX08SOvoLQhMN/mo14U++L+ocj
4h13L4tlf015AAol3r9Eij8wNPdYMbP4g9Zgw/m9DqW7wt1/BGrkt4/JVFPism6I
+sxaPmC97tXQgjljri6uGGbMTnh/SMVztZV0GfzY5rT+JTSBWG0nnTWX4bzO1YDG
o3AM3Hu9Y/AdmJ4vFJZcXo1UD3sNxbE0FTBZveS4NqbsAvTMf5eN4S/V731IZr7t
VFBUKm1nxAoqxK5f50rIC62f3B+CW0Y7aVtZqsW1murlrq7vKHToQqBTOLgh54ZE
XW+Ju+1l9hTYRLXzYXfNhc1WN/Y+VbIwe7bRqPmXfnjcP+S9uU5Qqxv2eYF6ZdwS
ALdBG4Zao/qX2ayk7E79ewRBu9K+9YyC3wzg2mFjaQaw1i3hwrsF+iZ+1PXQrisP
LwK9rsK8B+mHW195XQ4uM460bVVtCxaF+Xj4GLH3crxajb6qwuPp1fen771z9jsd
ztvBvcB5oMyyVaPqx0U7r3zszSDZIMaNW1G08k4JRi/sN/co/wYnogUe5V9qFCMf
ANlkgSFFaBxb8uHyhMQ6/qLhDfSjcXqxuNk/VQO2kn6mMptqX8WZmBX0anZePCzi
lHmVUMGfR7KDw1P/crkrqPy4gtdkv5mx4qd10lUsz8+kXKP9aNY=
=X+II
-----END PGP SIGNATURE-----

--Sig_/phtN7D_PkqiSCtORxrJa0VZ--

