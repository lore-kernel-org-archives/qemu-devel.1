Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46923C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 17:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19AFC206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 17:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AFC206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyJA3-0000iy-9m
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 13:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hyIk8-0003K7-TO
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hyIk5-0003YF-Cs
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41021)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hyIk5-0003Xs-7w
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8C0FC307D985;
 Thu, 15 Aug 2019 16:36:48 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-19.ams2.redhat.com
 [10.36.117.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F4EF3737;
 Thu, 15 Aug 2019 16:36:46 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 17:35:01 +0100
Message-Id: <20190815163504.18937-31-dgilbert@redhat.com>
In-Reply-To: <20190815163504.18937-1-dgilbert@redhat.com>
References: <20190815163504.18937-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 15 Aug 2019 16:36:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 30/33] qemu-file: move qemu_{get,
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
Cc: quintela@redhat.com, yury-kotov@yandex-team.ru,
 richardw.yang@linux.intel.com, marcandre.lureau@redhat.com,
 ivanren@tencent.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Move migration helpers for strings under include/, so they can be used
outside of migration/

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20190808150325.21939-2-marcandre.lureau@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
index d064940b8c..b6303dbeef 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -161,8 +161,6 @@ QEMUFile *qemu_file_get_return_path(QEMUFile *f);
 void qemu_fflush(QEMUFile *f);
 void qemu_file_set_blocking(QEMUFile *f, bool block);
=20
-size_t qemu_get_counted_string(QEMUFile *f, char buf[256]);
-
 void ram_control_before_iterate(QEMUFile *f, uint64_t flags);
 void ram_control_after_iterate(QEMUFile *f, uint64_t flags);
 void ram_control_load_hook(QEMUFile *f, uint64_t flags, void *data);
@@ -181,6 +179,4 @@ size_t ram_control_save_page(QEMUFile *f, ram_addr_t =
block_offset,
                              ram_addr_t offset, size_t size,
                              uint64_t *bytes_sent);
=20
-void qemu_put_counted_string(QEMUFile *f, const char *name);
-
 #endif
--=20
2.21.0


