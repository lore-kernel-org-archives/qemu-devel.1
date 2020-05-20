Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D639FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 21:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A149A20829
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 21:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="QsEb+/MF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A149A20829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbVxn-0004MD-NM
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 17:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbVuK-0002Dl-G3; Wed, 20 May 2020 17:05:44 -0400
Received: from mout.web.de ([212.227.15.3]:50145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbVuJ-0002Rb-JI; Wed, 20 May 2020 17:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590008737;
 bh=L7G8XxjG0NoxcFNUSt93wnRY5ibTk3fXbfaaNKPJnxY=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=QsEb+/MFft/hTnhd5G6zHDCYje4LViM0a8BBZpGKNO0NS7kqlMq34wt4skft0bySJ
 Yp+F1gzwyUiBwVSuAqcOFMjFWyZRMjHKO5ZxQ6BVvB0JKvqVVuNMEjNKff9IGgnT7f
 F/SvQStnfmrgSkxEi7av7rL9tiS3f3pO5gqGAhN0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.105]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M8A09-1iokqG0akT-00vdOw; Wed, 20
 May 2020 23:05:37 +0200
Date: Wed, 20 May 2020 23:05:27 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2 0/4] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <cover.1590008051.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Gv_CWkNiI/8nD2OzMv1YR+h";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:bYgdb7ZpTnsgkBtJz+VfMjSUetbTv35S4/8i1F/8LZyROcbMErv
 6MXdQFZB3MpaTKmO8AB0DdKqaJ1ZuVpDpl1qNJGkMbh6xFZwkGr+PD8liMhkVEcAWnMUVed
 cHbCPzlZLST6hbLrzPUhhiuCzPZqRTd5TEOWVkRb6cXZ4S2+j94XujLR49kdV7bx/bC7Al8
 zpE9AafAFb5f2B1ZgxSHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xqcc79j3tXg=:59Oc/m3fiUetJGuBH8OovJ
 6cPVhatDnyS4+0cID/bToppV6qZqyuxgM5sS46GrlUO23RaANrMUAP7J7kVBTwTFDsGGjvQ08
 YUYlA2BKRFhqpVjGyIAWH5NSmpRdz47Ag7lq0yyoH6svwc0EkZKLKqIAvrtUK/yXDNTtOltOf
 rR0Yaw/4RD95vrO0ZbFNsso1YERv5FZV5wjZJAFPpFlfuptv8DaWrhYh15eLmXU1ljZtqJ1of
 6f/Vb8oiHsU7jyCUbndIj0SUcjgS7ZnbrfjTqJAeV2rZ4YgTXmdTJF86SCSmwhWRAjM6Os+tS
 Xgyd2tN5Ot+YnNDBwkKqhMfUDeP2Gdr9Zty1Lu6q8sMZ61nzwdJX2g79FKl/5X+p7YOw3gdgi
 54bVz8AvoDlppDC9Y77MPm/aS+Rp/oO7WL/U7gLhfI5m0YUO1cQ3iZ6/mxlCtuL2iqd+1llWn
 MHAk+kywNHjOa2sCJJGXYmGx7zH/lmb2WIMRbPfvTMDOXYZ4UUU8Tc6UDCq9S/flsUj2djxg1
 ZJDP2f0acJyNfVGSOCjhXzdwXCWiNqRdeq1D3vb/nLJN508n8SH85lqIG3QD7mmZmjk50sLVn
 wG7DpNiulcMn/O4bkdLu4Pl9M1WiPU7GvTF+t9BKpNvqRIJp5msHt6KR77/EtRKM5h77zsHo/
 wRaEZ7BTtcsrub4EfXFLqjavSrhux4nofLwsZYku6Whcl70Z9D2liekpKEiMN4QSaIUNihhBh
 Pn2e6lvlTRO4aeOG/Viy/BIuaGfy554Wv6VDocl/Uz39svTdtscpDng/5m/2KKNS3/QPWhoyR
 fdGm8w/puRFJuaakQl81qcrwT66vrLjMcmjQunzYSaPV27rFx5rWM2YRLL1377mN0r/Sh3qT6
 htoAITN0fPdVazATvbggJ9iwK0pTj8fkb1mcYsrd9EkJvnfJSONaLdJbgjYzka6emzbyikxHN
 ELvRiXl/Uga1//bR4ybjnM3YO54/ldntB8Iw5wtdBvv8cOF681VMe8sqQLZ8RCJQUCOAE8jcH
 fBTX1WuJKzDcx3CxNBE8pWE97byRgtQn1D0AypEgq0QPcDODrsp80GV67TWJDKhQnJ9FTRnbg
 o+mAuYfy2S7zTb5vLdRx7Hn9+fWPfnyAQmd+dGTE23QXwlpF0vpJx3YLYHDi+/ercKYq2B6Be
 1Lx1jk9naD4ppeGXYDnXUpTEysdsrBJ88BkaankdLXu2gmIScx3NdNbT1eNfKxPUuQxcGYXiy
 myEF8uqdoHtsQtXMC
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 16:42:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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

--Sig_/Gv_CWkNiI/8nD2OzMv1YR+h
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

 Makefile.objs                 |   1 +
 block/nbd.c                   | 101 ++++++++++++--------
 chardev/char-socket.c         |  24 +++++
 migration/migration.c         |   9 ++
 migration/qemu-file-channel.c |   6 ++
 migration/socket.c            |  11 +++
 qapi/misc.json                |  45 +++++++++
 softmmu/vl.c                  |   2 +
 yank.c                        | 174 ++++++++++++++++++++++++++++++++++
 yank.h                        |  69 ++++++++++++++
 10 files changed, 405 insertions(+), 37 deletions(-)
 create mode 100644 yank.c
 create mode 100644 yank.h

--
2.20.1

--Sig_/Gv_CWkNiI/8nD2OzMv1YR+h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7Fm5cACgkQNasLKJxd
slgGKQ//YbV3xzDh3nDR8J4QvrEjdDccXvjYhj7ssxlfSzX16VCjVZo2y1jQrIoj
6IJNvwG4LnIG/137i/oKWERi9cWKwFYYsJxYag/gPScBFt3z0rFixbHuqaqfXenQ
+2sn892Y50h/xXIqZOFAVLvIQM5oW72XEGjH2+zpFk9/B1hUViEcTmWwfGlbzSXv
m43oZh33gpAVlkolhpew+D8kx8YnZ4+M0XpiH0Q75/xUliGWR2NTh9ysikZRsnVG
A0Gw3sLRf3Y6K3GoIzPCiqT0SQQRN964vyhEkbKzWwwhaaTNrt2zjMN1d5+NcvtB
hRkI1SbJc/GGI/8WBqtHgoBfK+z7t5xP8xDvcciHQDu+NdAnUZboKj2RN+thTVp9
jGkQSY9E11mEV3WM83BBC4fQAdwaDnG1LeF+hUvRmvWeRhixVEQPD8DQc6doQyTu
/O7HHlytjUEdgyRKM9kIJ5wEycGfk2nHVDtevtM7oIn1IoIwrL0qma9Se1FAM3zy
BuJe6bQWDxXLr1y7Zyr9dCDwMmZsY8Ikm1UGBcsThSAAKBvXS9dEZyIu7B6w/kPT
ieQc04vv29+5uw/Z9mFxPAjOPLgJXOTErC0QKd9n1ukalocyKKMA1Z0/CmOoPaW8
ATaQ0WI3RzqLcy/B0Z41ES+Jl4VZ2+JxZLlvgmh4y4AKnD8aGI0=
=p2ME
-----END PGP SIGNATURE-----

--Sig_/Gv_CWkNiI/8nD2OzMv1YR+h--

