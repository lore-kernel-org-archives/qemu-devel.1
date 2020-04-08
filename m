Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CE0C2D0F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 18:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE502072F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 18:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="WyesaHeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE502072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMFe6-0008G4-PO
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 14:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jMFWa-0006dy-QT
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 14:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1jMFWZ-0004TB-PI
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 14:34:08 -0400
Received: from mout.web.de ([212.227.15.4]:38207)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1jMFWZ-0004Qz-B7
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 14:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586370831;
 bh=w3iV2InOTr+OaFsy3Tv/Ld/RwwZF35icTcq2qLOoinc=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=WyesaHeA3VGLUr2X3l/h/2sFEdSpARmEoLQWh/6j9QmPifbdSzV5J5Fd0iRWJjbwr
 hOwND/EplZQe2O0XU7pPR1WQ5FwPqZGhnQ/pLOQlGs1Bef/nbNd6j3xFXnqnfa5/G7
 PlLg5DlZiMr+zK+UoBh04xKdKnk8xYrqlfvK/MNg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.62]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LdmgV-1ivkXU29pr-00j2Rc; Wed, 08
 Apr 2020 20:33:51 +0200
Date: Wed, 8 Apr 2020 20:33:49 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 1/3] net/colo-compare.c: Create event_bh with the right
 AioContext
Message-ID: <b86f80bb47ac66b73b2afe80218c9913722c606a.1586370737.git.lukasstraub2@web.de>
In-Reply-To: <cover.1586370737.git.lukasstraub2@web.de>
References: <cover.1586370737.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gJox=Qwe7=7KJydb8QH+p0D";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:a9zfYhdq6WD3p57xVTNR97ZmTuwTC78GUI//Eu+/9hozsshzWdH
 Z6XRQbkOWu9SyFw0HSHDwp3PbaSuiPlckgmXwzi1BAklnudNovtyHOBty699Qj6ZRk8ge/H
 TLubcIXZnfBkGu4ynQIZcNuiDx+IMnjjOHtkuB9lWeUnzLt2c81FkqA2W0WbSPeAw12SP6x
 n9+Ulzm9NiRgJ/rvz9a1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yllrF+KxOW4=:GSiDFyfxRFgVKhlWsMVzWY
 B0JY4dl+W4RSvQ2AIPycUWjyJvAgxjbaX1CUZxVLYvYd5EriNIvDai6Nx5hW58VpNixhYhzBq
 tFqgq7CgxN/xNJXpN9hxMkJm0dzUb0ebiYUlrhP0AcFTCH+/u84gqxrGtQxHQV2XlaOC9x5AM
 /K/fJ22sEUAWBAumRTKX6hEa7MaU1qjRq15UReqT/P9jHs3DCUDgEa6rdNMxgXcrtpv8TQvpM
 7GZahOLjviGKPJ0oOS20ESbmD7OPyGJf6GqdNLHtYZNcYNIgFSH0FE2tMGwnI92nPuK7rUIJr
 jbVWFuIq8l0yQMFe63gbP2N9PnB5rY8mC+sH0CINW6cspr7SjBbkkGEyAGM86U2XPhcCVcsDN
 fjvH/4xSrbb0NjGXmflcgOKuiGTHAi+mKOBVxjAoHozjScuSFkFU2tjEI4yerMdOOy6jOfakZ
 NkQ72en8Us6ADvk/b2wiJG0hxq5lbHUa/Uu3JqEM5lBoqk6h/D329igTv2zEQ6qHtZ3zsoEoJ
 juV52dXeDo0S2AdA7tjVPsg8taQS0yupRWD+1yGnQCUhb9Q3st8x8Wf/fwjRFuGoF3vddKkcT
 SnT81j/3ZGnOyspD4qbTrbFj7RZG/nXJNlzePxGW6rCewFVr3QfeyCsn0YjXbi4LUNb+cFj4B
 000L7/0+oQWKWby8emUST7Icg5PypzO2UlkUfrLupgqqwkfq7pq0paZ0xfebRtzbBzPMTwbHR
 7v29hDSl4oJqVq4vBueB9eLMMjlvMUPZJ93I1SilCPezeRlnmwV3PED1XKU/QbAuTlKrTf/d3
 DQMmv1yAPTwaD8nBp003tubWcrhLsEchekAJrsq5BcHC5zbwghZKwoBRNOz1pQ/kzvZ5ZlV2q
 pfUlqsX9QDkkM7qDonjGtgOqOo3VRu3RU09oRdV+kLpu4BLPogTK/B/cW2iUt7FPlgqY/msob
 GoS0wHf1CAs3WQK7ENNGO/3Y/mzpIIR9tsoZKIeXi9AWeeZFguN1SxCEUJelpjBGkUC0FK/We
 44PD7gx5+HWcLZWIcozyVmmGdiXfGea+jOv6BqZRocuQSkJ8ubV8emo/HIqB9pcjS0WoVgm4n
 J+Ogul3LyMsjMJN3BvRt2kZunU2F5jV57Bz3rF8/HgGz3ZIVy2yVr5WKKOtMxz60nmlXVzzJx
 2ovU4eA83z3Hla0YWM9pQWLjEWOQ9XRRdTLyK6ZB5i45m/yydB8e9XBqPZUUz+Fs0DqNNOhJG
 FgrO9LmZ48HrhZ8/T
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.4
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

--Sig_/gJox=Qwe7=7KJydb8QH+p0D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

qemu_bh_new will set the bh to be executed in the main
loop. This causes problems as colo_compare_handle_event assumes
that it has exclusive access the queues, which are also
accessed in the iothread. It also assumes that it runs in a
different thread than the caller and takes the appropriate
locks.

Create the bh with the AioContext of the iothread to fulfill
these assumptions.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 net/colo-compare.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 10c0239f9d..1de4220fe2 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -890,6 +890,7 @@ static void colo_compare_handle_event(void *opaque)
=20
 static void colo_compare_iothread(CompareState *s)
 {
+    AioContext *ctx =3D iothread_get_aio_context(s->iothread);
     object_ref(OBJECT(s->iothread));
     s->worker_context =3D iothread_get_g_main_context(s->iothread);
=20
@@ -906,7 +907,7 @@ static void colo_compare_iothread(CompareState *s)
     }
=20
     colo_compare_timer_init(s);
-    s->event_bh =3D qemu_bh_new(colo_compare_handle_event, s);
+    s->event_bh =3D aio_bh_new(ctx, colo_compare_handle_event, s);
 }
=20
 static char *compare_get_pri_indev(Object *obj, Error **errp)
--=20
2.20.1


--Sig_/gJox=Qwe7=7KJydb8QH+p0D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6OGQ0ACgkQNasLKJxd
slivIBAAkR0gFmbZqoX0iumAopzcoTmqQXl4eiNqECHlHGV0Abkz8bkvAoZEIZh+
3q8C5rg2FX4hqV1oQU9yJGd/ZIR/1AnqQ8UBmJ1HnOLwT5wuMil672o40bN3Jsmo
kzxGjVkXOx3PO69+UoIYrk7Bp9ZcPqXtTsc3D875JUPC/Ew4RpU3XePc07DPaUGv
BbRFpTxhg9uj7d+FIUenj88kSXcd7431fkWHONOn0BLvICr/VjggZrQFqiDL6V5W
1OPDkyZJ/MPTvicRPRiROlq4WU0177+7fn0SrVnLQTi+bSw/3S1VNE/0eJAHgXk+
Zgt08g8xLqLdTnSMZ38HzwiR/XssL0I0Vc5LUstaIEE3e6RReRce309AfjDMpWgP
BU83qpg/si0nMNaubT/1TdZv5+xIQYj/mQ1l7lGTYgnyiaNCDukYCXuReOamBy5q
KCmwizmgJhsUguhonxlIflMudqSiov4UmIdHjxEK7dR9YGhg4tDXiTCbVCSX3Hh8
kmQyXw/+kkY4H0JgNeMTUzwbWbg0FFEQjtdVavqRVKNwS5VcC7NQlKLSTRgdI4sZ
Qrxl5DharptNxHwuB55out9x+WP7Tr2v6wpWTM+YEb1SAclXzOHKi/P4eC+zePxj
8BcGSXM9iPhJbQtVyQb0gn37mAK6GOWeEM3hcNCFhtPoJi90tWg=
=r0Ay
-----END PGP SIGNATURE-----

--Sig_/gJox=Qwe7=7KJydb8QH+p0D--

