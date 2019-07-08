Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D30C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 07:26:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F4062084A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 07:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4062084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkO2c-0003Zc-LI
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 03:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45414)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hkO1A-00021G-JA
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 03:24:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hkO18-0000oq-NS
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 03:24:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44594)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1hkO18-0000o2-Hg
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 03:24:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 78A9730821A0
 for <qemu-devel@nongnu.org>; Mon,  8 Jul 2019 07:24:53 +0000 (UTC)
Received: from localhost (ovpn-112-17.ams2.redhat.com [10.36.112.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 339FD19C77;
 Mon,  8 Jul 2019 07:24:49 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  8 Jul 2019 11:24:35 +0400
Message-Id: <20190708072437.3339-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190708072437.3339-1-marcandre.lureau@redhat.com>
References: <20190708072437.3339-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 08 Jul 2019 07:24:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/3] qemu-file: move qemu_{get,
 put}_counted_string() declarations
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
 berrange@redhat.com, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move migration helpers for strings under include/, so they can be used
outside of migration/

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/migration/qemu-file-types.h | 4 ++++
 migration/qemu-file.h               | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/migration/qemu-file-types.h b/include/migration/qemu=
-file-types.h
index c0a1988155..2867e3da84 100644
--- a/include/migration/qemu-file-types.h
+++ b/include/migration/qemu-file-types.h
@@ -161,6 +161,10 @@ static inline void qemu_get_sbe64s(QEMUFile *f, int6=
4_t *pv)
     qemu_get_be64s(f, (uint64_t *)pv);
 }
=20
+size_t qemu_get_counted_string(QEMUFile *f, char buf[256]);
+
+void qemu_put_counted_string(QEMUFile *f, const char *name);
+
 int qemu_file_rate_limit(QEMUFile *f);
=20
 #endif
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 13baf896bd..185d3de505 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -155,8 +155,6 @@ QEMUFile *qemu_file_get_return_path(QEMUFile *f);
 void qemu_fflush(QEMUFile *f);
 void qemu_file_set_blocking(QEMUFile *f, bool block);
=20
-size_t qemu_get_counted_string(QEMUFile *f, char buf[256]);
-
 void ram_control_before_iterate(QEMUFile *f, uint64_t flags);
 void ram_control_after_iterate(QEMUFile *f, uint64_t flags);
 void ram_control_load_hook(QEMUFile *f, uint64_t flags, void *data);
@@ -175,6 +173,4 @@ size_t ram_control_save_page(QEMUFile *f, ram_addr_t =
block_offset,
                              ram_addr_t offset, size_t size,
                              uint64_t *bytes_sent);
=20
-void qemu_put_counted_string(QEMUFile *f, const char *name);
-
 #endif
--=20
2.22.0.214.g8dca754b1e


