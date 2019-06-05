Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B9AC28CC6
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 11:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40DA02075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 11:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DA02075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39866 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYUVy-0004od-D8
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 07:55:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hYUU5-0003kx-SW
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 07:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hYUU4-0002TD-78
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 07:53:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hYUU4-0002SN-28
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 07:53:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9F943086217;
	Wed,  5 Jun 2019 11:53:29 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-241.ams2.redhat.com
	[10.36.116.241])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4E4AB5B683;
	Wed,  5 Jun 2019 11:53:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 13:53:14 +0200
Message-Id: <20190605115318.9972-2-quintela@redhat.com>
In-Reply-To: <20190605115318.9972-1-quintela@redhat.com>
References: <20190605115318.9972-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Wed, 05 Jun 2019 11:53:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/5] migration/ram.c: MultiFDSendParams.sem_sync
 is not really used
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	zhanghailiang <zhang.zhanghailiang@huawei.com>,
	Juan Quintela <quintela@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

Besides init and destroy, MultiFDSendParams.sem_sync is not really used.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 4c60869226..4c15f6fda1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -661,8 +661,6 @@ typedef struct {
     uint64_t num_packets;
     /* pages sent through this channel */
     uint64_t num_pages;
-    /* syncs main thread and channels */
-    QemuSemaphore sem_sync;
 }  MultiFDSendParams;
=20
 typedef struct {
@@ -1027,7 +1025,6 @@ void multifd_save_cleanup(void)
         p->c =3D NULL;
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
-        qemu_sem_destroy(&p->sem_sync);
         g_free(p->name);
         p->name =3D NULL;
         multifd_pages_clear(p->pages);
@@ -1201,7 +1198,6 @@ int multifd_save_setup(void)
=20
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
-        qemu_sem_init(&p->sem_sync, 0);
         p->quit =3D false;
         p->pending_job =3D 0;
         p->id =3D i;
--=20
2.21.0


