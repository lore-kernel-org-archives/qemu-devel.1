Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D78C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB0820879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB0820879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52504 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQcQC-0006qU-T2
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 14:45:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQcHF-00073Z-9s
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQcHE-0001YK-BI
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:35:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hQcHE-0001Xa-6c
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:35:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E9FE3019880;
	Tue, 14 May 2019 18:35:47 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-232.ams2.redhat.com
	[10.36.117.232])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 85A2A608A6;
	Tue, 14 May 2019 18:35:33 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com,
	ehabkost@redhat.com, richardw.yang@linux.intel.com,
	yury-kotov@yandex-team.ru, chen.zhang@intel.com
Date: Tue, 14 May 2019 19:34:44 +0100
Message-Id: <20190514183454.12758-7-dgilbert@redhat.com>
In-Reply-To: <20190514183454.12758-1-dgilbert@redhat.com>
References: <20190514183454.12758-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Tue, 14 May 2019 18:35:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 06/16] migration/colo.c: Remove redundant input
 parameter
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

The colo_do_failover no need the input parameter.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Message-Id: <20190426090730.2691-2-chen.zhang@intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/colo.h  | 2 +-
 migration/colo-failover.c | 2 +-
 migration/colo.c          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index 99ce17aca7..ddebe0ad27 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -37,7 +37,7 @@ bool migration_incoming_in_colo_state(void);
 COLOMode get_colo_mode(void);
=20
 /* failover */
-void colo_do_failover(MigrationState *s);
+void colo_do_failover(void);
=20
 void colo_checkpoint_notify(void *opaque);
 #endif
diff --git a/migration/colo-failover.c b/migration/colo-failover.c
index 4854a96c92..e9ca0b4774 100644
--- a/migration/colo-failover.c
+++ b/migration/colo-failover.c
@@ -39,7 +39,7 @@ static void colo_failover_bh(void *opaque)
         return;
     }
=20
-    colo_do_failover(NULL);
+    colo_do_failover();
 }
=20
 void failover_request_active(Error **errp)
diff --git a/migration/colo.c b/migration/colo.c
index 238a6d62c7..8c1644091f 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -193,7 +193,7 @@ COLOMode get_colo_mode(void)
     }
 }
=20
-void colo_do_failover(MigrationState *s)
+void colo_do_failover(void)
 {
     /* Make sure VM stopped while failover happened. */
     if (!colo_runstate_is_stopped()) {
--=20
2.21.0


