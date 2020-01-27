Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB91C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 22:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E1224656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 22:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GEXiro9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E1224656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwD5f-0006f8-8x
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 17:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iwCxS-0000k7-Fx
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:34:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iwCxR-0003an-HA
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:34:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23781
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iwCxR-0003ZT-DA
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580164452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vyfBHsaYxKD/5ADqREOC9ThWFXY8oIV+MoppHtCLdqw=;
 b=GEXiro9vc89hUuV/GCf47aoSf7dOnOWosTWXYYRXkBTelx6rFTkfDtB93nShedxF3/Ztp/
 afdElXYM+uHz2BS8L8GSeOjBX2sSBYCQsire0t0q8ClWUZmqu+N7ElUOL8jowBVPfhQIGX
 jKaDyuWkT/7sHCcnhUgqxKpm6X/mNzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-xvD1u72ZN9aGZyMgpyHvnA-1; Mon, 27 Jan 2020 17:34:10 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4C0B801E6C
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 22:34:09 +0000 (UTC)
Received: from secure.mitica (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7356C165D3;
 Mon, 27 Jan 2020 22:34:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/19] migration: Make checkpatch happy with comments
Date: Mon, 27 Jan 2020 23:33:15 +0100
Message-Id: <20200127223321.2742-14-quintela@redhat.com>
In-Reply-To: <20200127223321.2742-1-quintela@redhat.com>
References: <20200127223321.2742-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: xvD1u72ZN9aGZyMgpyHvnA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 8f04b5ab3a..12b76b7841 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1320,10 +1320,12 @@ static void multifd_recv_terminate_threads(Error *e=
rr)
=20
         qemu_mutex_lock(&p->mutex);
         p->quit =3D true;
-        /* We could arrive here for two reasons:
-           - normal quit, i.e. everything went fine, just finished
-           - error quit: We close the channels so the channel threads
-             finish the qio_channel_read_all_eof() */
+        /*
+         * We could arrive here for two reasons:
+         *  - normal quit, i.e. everything went fine, just finished
+         *  - error quit: We close the channels so the channel threads
+         *    finish the qio_channel_read_all_eof()
+         */
         if (p->c) {
             qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
         }
--=20
2.24.1


