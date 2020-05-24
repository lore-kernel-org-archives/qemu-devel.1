Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAF7C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 18:35:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C0A920787
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 18:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="djuxIo4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C0A920787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcvTM-00024X-6v
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 14:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jcvP2-00085c-PQ; Sun, 24 May 2020 14:31:16 -0400
Received: from mout.web.de ([212.227.17.12]:54735)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jcvP1-0006TN-Ok; Sun, 24 May 2020 14:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590345068;
 bh=r1KbRB9L9Bd4dECIHUaPaMsHREfqNa2sCSTa4+/9/cc=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=djuxIo4ua3vooASFY7uCoqKxTkWCvWdtfrlr/wjchpQ8lXXwPZe5uiXOZbYA8ETf5
 Z7cgGeITWLT6h8fARoTghzxi9tfOj+YfyCwYlal524VfhvRglN/5hF3kOgQsJZkJXL
 b3UCcavBiMIL7dp8PrrQvKjotZeFtNp9Tn0/cE1Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.42]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M604f-1jepDL1np5-007ctk; Sun, 24
 May 2020 20:31:08 +0200
Date: Sun, 24 May 2020 20:30:59 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v3 0/4] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <cover.1590344541.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OaSgEtDE77Y=CDCpCsQ6YrR";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:EnStaY6+bHA4oulLIZdgnkllxVSoMIKE2on4tthqgTIaFvsf3Dd
 pKPr3ONaW7FLgxETI6Bc4aAAbQ7n7F3ICRBBDe876UmRAoZJFR4L5siFhz8gQHeSDZvHavd
 PUavyBU/phVRSjfiyewTGrlREP28SbDNv/UvbdoRYN9XgAWsLYmTBPhI2xoNTXF2h5x9tcU
 cc1X4cz4C+P2GDVpFF51w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2nRiBN4iS3E=:1JK3Jh8SBQOKoW2vWOWnpe
 yLITUioBqc1RoV/NTuA0USxDh/RNRAoeg60GDveV0KLi1r6YG6ZfRcUIgq3ghtQaxucrz2I5L
 M6OlTYYUgnKNahk7m0HIjKRl61McOgdErEEU7cX92fiZk3PUEldoTC/7a41ys8h3uTnphLWyo
 XzGZRQjb6V9rix7ENAN1V84tG23fV1+9Rvua1iQPeHS+QZCUeaDlqymE2EWWeR/8gxYOoHuE8
 9I6t3FeGtXxLXTNKHYOvLrtdbTYP2+UwhYSilRS77F4fs3xZW2Dpz48LkhidgJkkS/BTn1mol
 rfJjAZAP6QuZjwSo1Hh0cHZxtm9mabemBDxptwN1vq6FA2xgh9pJ5D0fUjTeCOzTEXrswg4//
 zQ6IErrKM5/UsG3CzMnaVfat9c8tlrRFTTcr3FdMKE4UdMTVOz9QQt3c4DGSNkPTe0W2rJTlH
 ifTREyoov+h7vk6p22moOnJNm0tci3NsWVE54HlmlOtKQCPymwl6JgpE9OyrkPqkf0piAjggS
 dkP8VVlEvAKIJpe1A3GyfAAXmHkps1mWg2VOKpU7JO4C4INeoZinfIhzssoIfWXo/gtxmk0d0
 DhD8Ktv0E+6Pc/Sm7a418UfiSlD0a5Q7fAApZR+NgOj4Vn9ifpTjGtdcwPdYboEZ11FLwhdyQ
 LfRF5xzoyxY04Cm43/fOK2/2AXgWznF6DM8zcJ/iyDRdFWRrx5N47GL+61blP8kz3CO7VyRvc
 SWG5CrM8Ntj6lH/ss/8N3s11zh0jGvL4ZWkpNbV4qn3ukhoxKaxK0+2cbKVEzxpNkVczxLs76
 PRc/HgPl9hvPSwWDWlmIeWcDN6cUuPvACDQIJ0rTS70L7EEAUKxumSLh8gDEllQhMEEae1Uw6
 rx1Gm71UhYdVbrUEAFG9WDPr2mHilPIKYLgkEudF/l2ttRbkx8N1yjSWcpJTeg3RbYW7dMcSo
 W1dbxdOihmlFj2xHzREHd1ktZG60K6ZemHsNxl6KHcqdCSWcPqnXcsAsB1N/n4B86qON0uTMk
 N8WohVt3v6kLyF2vdVsb3dvDtZzwoc1St2RdezcY4Rx9a1QiekI0lbben+9m7T49nsd5g7wXc
 0XWJPUSG/XwNugSb1uFrg3ZARF44Y3LRvA/0dhTv9eJKPXsXAzq4Tq7uUduraEQg2hP5iHEm7
 Pj+0IMNTgnQs/3fKRuAu+1iYsl7ETizcovrizFaJP2BKo3YQX+uy1rVVhYkJHT7W5hM8B6vdf
 /Rsnobed4LJqa+QPy
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 14:31:12
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

--Sig_/OaSgEtDE77Y=CDCpCsQ6YrR
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
 qapi/misc.json                |  45 +++++++++
 yank.c                        | 174 ++++++++++++++++++++++++++++++++++
 yank.h                        |  67 +++++++++++++
 10 files changed, 422 insertions(+), 38 deletions(-)
 create mode 100644 yank.c
 create mode 100644 yank.h

--
2.20.1

--Sig_/OaSgEtDE77Y=CDCpCsQ6YrR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7KvWMACgkQNasLKJxd
slhALQ/+MYs52Cyr8q4OnjYTf3PiEEHLM0pvaZP+QhviGzhLyuQUuKC+PBHfOl1V
sEGi5ZmnuVOJ88/wbpDyxMxoaKLNkMHYmkaBggMAxm9zKWV1ZivnKSAecrCLIbld
vwXcUcjCDu8nj+KrNOc+tczc+C73e0rT3XfnI/hv7i92aVCJxSgTNVC9tzYKJsnp
5dZTUN47f+MMeXWjiff0BYC8y1py5F/943VU1HzbW2m3A3RohkitEbmOz0GXK4ci
LIrIsCpGUlRUgqlTXlEzOU+9OsryjUgRYewAHz8BsH0JhAWdjyCNNVL6lX8a8NZT
GF7AWsVcZbBrUxiaRX0HKpQ7y1s1NRkY+YSSPRUDKFn9zDfATVBrfdndtQ44uxM5
FJv48TPNoXhwSYM+IQ/24GOJd5CP6Q5zQ+cWQ1e2AIOIxp7VbIgRcjUXcZJ4gc5Z
cLE+CeVS20VRTB02WK/dOUQPqGssYF1yAPnE+rN0ogXA2ERO/bKyREcOJEdwjtUJ
IJJm+FwgbTFpEy0HNgOwba3Naxs/520IHyyo/HO9qjo38A0HzElgFCI66Y8DHu8d
us+Oi9sJmWrQito4E+tHa1Ku+Cuk5m+Q2H0LuvjSVsqK1/3S7XDdm+pyIgAPCrrd
CAhKerzFwNhfAXGDNmiBmO612QyaTe1d0A55vWZZWXAW3W/s/zk=
=Fdo/
-----END PGP SIGNATURE-----

--Sig_/OaSgEtDE77Y=CDCpCsQ6YrR--

