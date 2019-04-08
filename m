Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080AFC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 02:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1AF820880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 02:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oaoOe4X/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1AF820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46158 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDJwT-0000FW-M9
	for qemu-devel@archiver.kernel.org; Sun, 07 Apr 2019 22:23:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hDJtv-0007Dn-3r
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 22:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hDJtu-0003Vb-3q
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 22:20:47 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:32960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
	id 1hDJtt-0003VF-RV
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 22:20:46 -0400
Received: by mail-qt1-x843.google.com with SMTP id k14so13743158qtb.0
	for <qemu-devel@nongnu.org>; Sun, 07 Apr 2019 19:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=1vHiXAg79l9IJh/5FNvQ5ujKHABrFFpNaP9piWBe8tQ=;
	b=oaoOe4X/UNWoaDlDAR+vVa22fOxrQIog0Za3y9MwkeAnyj8CXE/cof8ZPrvF9Wq6PJ
	NWRuy1iLRhg8tjoToThwwskURvR/m8nfoJ8CDD+cglHIrWbmNECgfNqXW2c8iAiTaNx7
	Hf1sxrA71jO2iiASLONT23oLtrsGE/5V5jod3RexITl1DF69lEVCZ+cZaP/Lk9IvdCFR
	bsHjnblfk0Nx1JNOtdd7hH8+ZBzMvhTnwxFeZlT3/ANaka0Brugg+Fx9CNKwLOQmUa45
	VfKQ87OUEwi7WrgG8shyaMU5f+RHeeL6c203as2Epw8KVw18fS81U1jQoJdLGVtuPh8l
	iH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=1vHiXAg79l9IJh/5FNvQ5ujKHABrFFpNaP9piWBe8tQ=;
	b=QmcSIr+euRWr3r72++ml57oeFtCzN0qmfovfNw+evQ/AGKfkm69Ig5U4nBa7kapc4q
	cSGFBId+zXcau/2Fere0xPjZsRt1qhGVbYTHDRrxurpfMivwCiBm9m8mFZ4VCGANNhvJ
	Cpn5HI7XJ37/TWB5PpGIixdf8YWPvyCtWu3BwdSnktDrSO6DAPXKuyA398XkJdIEHbkm
	mqrMMQozlYGIBMwISthRKrs2g49Ifh8zl4ZfHTMEUVMswvMtZ/sV3ZASocMzAdMW2Fk4
	ja5svNCrracSKxU5BP/MpHNo98KIpSr7sUv4y9xS/0FqUWxVZmeMK8Xv0uicBOIktgor
	PIVA==
X-Gm-Message-State: APjAAAVfrgTyEkCz4WMuhtrSZhjjIFhfesMAQkhmBkPlBoi0f70Bbbmz
	kn9KPZRLhVNf9l4SSX8zrQM=
X-Google-Smtp-Source: APXvYqyXXZgc83JFOOopLjTmkmycz9wmRT6YL3u/XHxCzFJaPDRMEUXLdd+nG6RxOzA/sV3v4YiDjQ==
X-Received: by 2002:ac8:950:: with SMTP id z16mr21962675qth.16.1554690045211; 
	Sun, 07 Apr 2019 19:20:45 -0700 (PDT)
Received: from localhost.localdomain (104.129.187.94.16clouds.com.
	[104.129.187.94]) by smtp.gmail.com with ESMTPSA id
	v6sm16201450qkd.46.2019.04.07.19.20.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 07 Apr 2019 19:20:44 -0700 (PDT)
From: Catherine Ho <catherine.hecx@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Date: Sun,  7 Apr 2019 22:19:05 -0400
Message-Id: <1554689945-18619-1-git-send-email-catherine.hecx@gmail.com>
X-Mailer: git-send-email 1.7.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::843
Subject: [Qemu-devel] [PATCH] hostmem-file: warn when memory-backend-file,
 share=on and in incoming migration
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
Cc: qemu-devel@nongnu.org, Catherine Ho <catherine.hecx@gmail.com>,
	Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408021905.8YMTkOdnR_cXu3VUewKyxmgZXdv5maiQXLMmf-zdfzY@z>

Currently it is not forbidden to use "-object memory-backend-file,share=on"
and together with "-incoming". But after incoming migration is finished,
the memory-backend-file will be definitely written if share=on. So the
memory-backend-file can only be used once, but failed in the 2nd time
incoming.

Thus it gives a warning and the users can run the qemu if they really
want to do it.

Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
---
 backends/hostmem-file.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 37ac6445d2..59429ee0b4 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -16,6 +16,7 @@
 #include "sysemu/hostmem.h"
 #include "sysemu/sysemu.h"
 #include "qom/object_interfaces.h"
+#include "migration/migration.h"
 
 /* hostmem-file.c */
 /**
@@ -79,6 +80,16 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         }
     }
 
+    /*
+     * In ignore shared case, if share=on for host memory backend file,
+     * the ram might be written after incoming process is finished. Thus
+     * the memory backend can't be reused for 2nd/3rd... incoming
+     */
+    if (backend->share && migrate_ignore_shared()
+                       && runstate_check(RUN_STATE_INMIGRATE))
+        warn_report("share=on for memory backend file might be "
+                        "conflicted with incoming in ignore shared case");
+
     backend->force_prealloc = mem_prealloc;
     name = host_memory_backend_get_name(backend);
     memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
-- 
2.17.1


