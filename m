Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1C1C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44BF8218DA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BF8218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqbS7-0002Yt-IZ
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 06:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41156)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hqbRL-0007Tr-OA
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hqbRK-0006Gq-OP
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:57:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50328)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hqbRK-0006GV-Iv
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:57:38 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D5CD92D1EEF;
 Thu, 25 Jul 2019 10:57:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-190.ams2.redhat.com
 [10.36.117.190])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EAE7B19C7F;
 Thu, 25 Jul 2019 10:57:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Jul 2019 12:57:23 +0200
Message-Id: <20190725105724.2562-4-quintela@redhat.com>
In-Reply-To: <20190725105724.2562-1-quintela@redhat.com>
References: <20190725105724.2562-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 25 Jul 2019 10:57:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/4] migration: Make explicit that we are
 quitting multifd
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
 kvm@vger.kernel.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We add a bool to indicate that.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 87bb7da8e2..eb6716710e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -677,6 +677,8 @@ typedef struct {
     QemuMutex mutex;
     /* is this channel thread running */
     bool running;
+    /* should this thread finish */
+    bool quit;
     /* array of pages to receive */
     MultiFDPages_t *pages;
     /* packet allocated len */
@@ -1266,6 +1268,7 @@ static void multifd_recv_terminate_threads(Error *e=
rr)
         MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
=20
         qemu_mutex_lock(&p->mutex);
+        p->quit =3D true;
         /* We could arrive here for two reasons:
            - normal quit, i.e. everything went fine, just finished
            - error quit: We close the channels so the channel threads
@@ -1288,6 +1291,7 @@ int multifd_load_cleanup(Error **errp)
         MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
=20
         if (p->running) {
+            p->quit =3D true;
             qemu_thread_join(&p->thread);
         }
         object_unref(OBJECT(p->c));
@@ -1351,6 +1355,10 @@ static void *multifd_recv_thread(void *opaque)
         uint32_t used;
         uint32_t flags;
=20
+        if (p->quit) {
+            break;
+        }
+
         ret =3D qio_channel_read_all_eof(p->c, (void *)p->packet,
                                        p->packet_len, &local_err);
         if (ret =3D=3D 0) {   /* EOF */
@@ -1422,6 +1430,7 @@ int multifd_load_setup(void)
=20
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem_sync, 0);
+        p->quit =3D false;
         p->id =3D i;
         p->pages =3D multifd_pages_init(page_count);
         p->packet_len =3D sizeof(MultiFDPacket_t)
--=20
2.21.0


