Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDC9C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:23:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9626420708
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHk+YGQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9626420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwlR0-0004fs-RT
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 06:23:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iwlKr-0002M2-41
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:16:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iwlKq-0006cp-3u
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:16:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40505
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iwlKc-0006ZH-4Y
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580296585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vyfBHsaYxKD/5ADqREOC9ThWFXY8oIV+MoppHtCLdqw=;
 b=CHk+YGQbAmG18alNjQs/fCcVWvr+476Qezu+akFvWduPUG/PnK0ubb76VdQJBDDflnACzj
 Tp8AnGdcy7YI46jungPSMBFt1l2OQMGEN7zqaV4WGxRkz/p6OIyNZl6/MIIyWGPii4926c
 AvLZBUdBicUQcKlL/ZbQqkO2blWeox8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-4IRQ6Sz5MNOHZL1GiRLvWQ-1; Wed, 29 Jan 2020 06:16:24 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6BCD107ACC7
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 11:16:23 +0000 (UTC)
Received: from secure.mitica (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 368738E612;
 Wed, 29 Jan 2020 11:16:22 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/18] migration: Make checkpatch happy with comments
Date: Wed, 29 Jan 2020 12:15:31 +0100
Message-Id: <20200129111536.9497-14-quintela@redhat.com>
In-Reply-To: <20200129111536.9497-1-quintela@redhat.com>
References: <20200129111536.9497-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 4IRQ6Sz5MNOHZL1GiRLvWQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
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


