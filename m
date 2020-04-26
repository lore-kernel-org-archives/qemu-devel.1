Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB602C54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 21:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E3DF206BF
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 21:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Dn3dtIDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3DF206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSooV-0007KU-Ht
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 17:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSofy-0004Cr-AQ
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 17:19:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSofx-0005JO-Mi
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 17:18:58 -0400
Received: from mout.web.de ([212.227.17.11]:55101)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jSofx-0005D7-1A
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 17:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587935920;
 bh=ZJuhJ2Q2XeuxLAMR1BZJjm9ycQkkW/TjS8lrUoFFGK4=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=Dn3dtIDJXTOR/wAVTXeDI+I+JOlt8UCcV6zJXqdHJjIPDCl87LkJpbtW1jJycb/Sf
 VbbDAnJCvox9UMluPO9YtzdRYCcQkEERGaaE1VB3BZTHSfLbabA/cOSfqgurXTDI0d
 AoLVDDOrFe+CmN7GKUErxW8ib+uShr5S4gmxNc/w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.69]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LhNjo-1ip1rU1bo8-00mcAX; Sun, 26
 Apr 2020 23:18:40 +0200
Date: Sun, 26 Apr 2020 23:18:30 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v3 0/6] colo-compare bugfixes
Message-ID: <cover.1587935686.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9ntpUWXp.kxJyJh9KqZ4VCt";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:Jhv+erNBotfrQJoZWjoLJH3IVrNT5ZS7Lftf0oNKUNXj8P9UrZu
 lMEaKnoPqRXmuDbnPg8IGml4kEdTkLso2jt08cW3rWs58+S2k4A1+MyEVifoOB2WbfwF1Kk
 S0+qSsi7jYuOWjW/XpqZYiGYS5xsIn84ECnnrx12F0HHbGbgsP89neM2QbdMXcvb9koSmR8
 ndoEKgov9y/08eSvmvBwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7ugBNKRbooQ=:M1BJl6W0E4Htn7PKQ2BilN
 WGCCBF1s+jkIi95MSaWtGycrUwGM8JG+Fkuds5cnREV5/Q+U63eZgdSKGx65Ae0Zxmr5cuqSd
 XFYBOwLXkDDD8q0pfAZko1djS2k4CvcBO28gyTzRknTPgRcqjKXt7bieRFAZLTXa9ttBcAE0c
 VjYNlyohXppVC//x/5EVlDdHJU4ce5Od9wCRiz/KI4Aq1wVxnPNYSfA8maRUKJPu1VvcJMjgG
 R8GURTOCB2sS2c2HvlvvEcxlhwk4yDlLDyVR8Fj8puJoAtEnCeLAkRJQl4/dxFv5JDBv/c+V9
 wHh2AvfxGoRWAUUFfZdYlkfCo85fq8QsBaD6BRT9WUjMUHlffXABtRKWc7v84FLlL6cT8fQua
 szdC/LW5hN3v81vy4NO/MK8Ai6NxzCLJWpGeRhzLFPZRIZ2fwbPhD//J13J1msT8pD2lvi7Eq
 FO86bQimzzwT2yR5Oq4PV4AI+jK+gQ03SyH+lzmO0Jb87KNwFjNAWGQGEOINxakDCUCohzJ5O
 C0C9imDSCag+vdzQCypAiu6inWH5TKCXqJMpItwQWFSmGh1RFSYhh0ZxtWX/BHzUdZxm2aSWB
 1T1RQF/3GKTXGxrtUA4MPULzOJucggqNMqoLse4jImTQlgdLOsXWb7gTyiUZFm5DdWCNTT1cu
 65jMUQcn6U9oAtuFhG7u6yw690bg/IhlBjafEx3D7mm0pjhmtv4UPiJ8SxYikGapXEauqhA4D
 I5K2X0GRrGEJB36cU7CPg1cKZly/QEi8TUFuTFec8p/UzqrxJxbI9yBYN+TVrgWHJWnHdU0Pr
 ED/GrBW599erEH5O3acDsliTez/EFTVQkthUBJ7MB8mopam9Zssvb5BdR90UuYvfyqW0TvzZQ
 f//DNyPQLu3j8jtblDc5O+6kOS6i+TOpMOUjLw5cynqT3yAyrvBJCEIOaytIuP/p73eOG4+xy
 bw4Z3GOjmG0ieKlogpFkV5Z8CJqgat00pFyA1tqOddTfY3RtmOOi8h6cQO8aKvm5j2eCSlOL9
 6bn1ULtx/G6Gp/jzx2zM1pxrPbh7uQvLVxhpWUKF6tVinwnZuOwY9ah9i9wuuhzi7ZL3czj6G
 2+uCIxVdvnieIS9BtVYtwxJJ5k9V+Wmqu7SIVCgSooMXZqDhdyFfwrZJXuxbMbklcag1enaux
 yucVpF3LcI5dXKut9MxuaIGDgno8bKsthfe+/kTxzpFwTcsg8xn4YKPDHnZFKpdY8gaIA2OBi
 x/XpUfhDYBuIT7IOr
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 17:18:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.11
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/9ntpUWXp.kxJyJh9KqZ4VCt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Everyone,
The performance-regression in patch 3 "net/colo-compare.c: Fix deadlock in
compare_chr_send", has been fixed in this version by putting the packets in=
 a
queue instead of returning error. I also found and fixed some more bugs.

Benchmark results:
Client-to-server tcp:
without patch: ~63 Mbit/s
with patch: ~66 Mbit/s
Server-to-client tcp:
without patch: ~771 Kbit/s
with patch: ~702 Kbit/s

Regards,
Lukas Straub

Version changes:
v3:
 -fix checkpatch.pl error

v2:
 -better wording
 -fix performance-regression in patch 3 "net/colo-compare.c: Fix deadlock i=
n compare_chr_send"
 -add more bugfixes


Lukas Straub (6):
  net/colo-compare.c: Create event_bh with the right AioContext
  chardev/char.c: Use qemu_co_sleep_ns if in coroutine
  net/colo-compare.c: Fix deadlock in compare_chr_send
  net/colo-compare.c: Only hexdump packets if tracing is enabled
  net/colo-compare.c, softmmu/vl.c: Check that colo-compare is active
  net/colo-compare.c: Correct ordering in complete and finalize

 chardev/char.c     |   7 +-
 net/colo-compare.c | 238 +++++++++++++++++++++++++++++++++------------
 net/colo-compare.h |   1 +
 softmmu/vl.c       |   2 +
 4 files changed, 185 insertions(+), 63 deletions(-)

--=20
2.20.1

--Sig_/9ntpUWXp.kxJyJh9KqZ4VCt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6l+qYACgkQNasLKJxd
sliVbw/+MnDCBx1o7cY3PUoEimfAUNw4cVocFvepnAvjkf/uQ6iJfbeqsCMl7KXb
F9Vedt/kUdg99azUz5mx2ODjTKX06MP8bXVPZf02L9tYihtDtDIcYM1qMqMF/Gej
5mwF/Q5MnUyICeZe+9jZk+ig+Ka0lsQlR607z2bdvkNy3b6EjsYQF2eC8qKOQeqx
Aq76+abzh2yoYD7Xxz+TOx5FJJDWyyTbm01hoKlSdHGi4apq6MbC6Ph9d1laYKP9
6m3qVVT11ytChTNtCWoJM6pOk6kOW99erkjhj+QMQ5El/OO9S6roY0M8Ic8nJk2q
jngbVmPebKlGlTMgoIJ4BKHFm4LAThMYZKN4eoyARFejv3HeXBoI2z0TkTi1yJpk
O8PaDWhFhPbSz2IIn1SrNmES6+bvPZsva3CwgKP0uCgwhJoUAYeqR1A3WqFyDCdD
x2wxVB7R9Hh0MA3jnPA2/pvHFv/ClYXG4H05ykpJpeD2erEeiKBDnHLECwifMQE+
xveyMYsmXLhviX54Ih3aNvmC1exSYlkqlr4zj4X1zrgaiatdopDVPFjoFkLympsm
DN5YqKKi/dpk6NFdPOJc270rbVs466gu2uwXm+7qRnO1Pr8YgkFrsOPrTJIQO0TV
o0r59KRedup9lTP3hLT9RZQD8t2hxZFp2xBOVZoZVfjrRhomKqw=
=MqYf
-----END PGP SIGNATURE-----

--Sig_/9ntpUWXp.kxJyJh9KqZ4VCt--

