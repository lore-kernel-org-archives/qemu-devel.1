Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81BEC282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 08:38:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88DCA20880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 08:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88DCA20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49346 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDPnL-0000w1-OD
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 04:38:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDPlZ-000890-L0
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDPlY-0003dT-OO
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48963)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hDPlY-0003ce-EN
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A1EBB3086229
	for <qemu-devel@nongnu.org>; Mon,  8 Apr 2019 08:36:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6388C5D71B;
	Mon,  8 Apr 2019 08:36:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id D7A401132B6C; Mon,  8 Apr 2019 10:36:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 10:36:15 +0200
Message-Id: <20190408083627.7479-4-armbru@redhat.com>
In-Reply-To: <20190408083627.7479-1-armbru@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Mon, 08 Apr 2019 08:36:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 03/15] char-pty: Drop "char device redirected
 to" message
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408083615.GlxGFmAZq06GgtYl4aklaRTYp_rp-c4uexhzHKNUDjo@z>

char_pty_open() prints a "char device redirected to PTY_NAME (label
LABEL)" message to the current monitor or else to stderr.  No other
ChardevClass::open() prints anything on success.  Drop the message.

Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 chardev/char-pty.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index b034332edd..a48d3e5d20 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -211,8 +211,6 @@ static void char_pty_open(Chardev *chr,
     qemu_set_nonblock(master_fd);
=20
     chr->filename =3D g_strdup_printf("pty:%s", pty_name);
-    error_printf("char device redirected to %s (label %s)\n",
-                 pty_name, chr->label);
=20
     s =3D PTY_CHARDEV(chr);
     s->ioc =3D QIO_CHANNEL(qio_channel_file_new_fd(master_fd));
--=20
2.17.2


