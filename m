Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF514C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 08:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B568720880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 08:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heDviwCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B568720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49532 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDPyD-0001F4-Vr
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 04:49:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hDPtU-0006eb-Tu
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:44:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hDPtT-0000OT-TX
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:44:44 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:34604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
	id 1hDPtR-0000KS-MK
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:44:42 -0400
Received: by mail-qt1-x842.google.com with SMTP id k2so14481914qtm.1
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 01:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=b1J9lYUPkNvcX/DlYU4//A0TQE3hpTJXHwWt8zl3ydo=;
	b=heDviwCcDVEeXekma4oVO6+D5wn0KVET7UChwzBse4NHDN8KQY49jx3E3d1uYCshHV
	y6U5T+sTH1GAfz2wS/XANg4gF0IdkoCMEGs6cSQe8jjJNk8KrXzVLLSDPGmNefkT2uHx
	+miaHBhE+LbHeRfUJ4Mwv8+QJcHfLav4jhBkJKZStolkoSUKpZEsqyRBv3sW6F23f91Q
	It/ghBiDGOi8XBmHM9Sf1RjyMVMpqBxCdIU/Ph4QkzDu5cHvRjY1gahnUqlWM8/10Iv8
	POYtXRLfX99lRCXVqLayHXDVCWivCoAn1JZus46ctirWshAkhOR7P6RZ3ZdzYqCEL2KF
	Uazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=b1J9lYUPkNvcX/DlYU4//A0TQE3hpTJXHwWt8zl3ydo=;
	b=jMqll8oum8zTZWbF1h55OO8/L/X8rPAMCdeDk38220lfRkUmCH5HC8ux9v67KFARat
	867Id7wiFekSr/xiUYJuplYFXfp+3ATJTWQ8CABKBYys18xi7RzPcVbJNPE5tsTBwf6I
	Lrimj7KLRH2iQNz9RpuNJLFGbVYTpKSp5AVSDQeLlOCjfU+aanetgMY0kNXQhG5fXZQ0
	RNzNL3RgLqVXlYFGqaUbqDjz82d+lK4XHaiaeIHiKAFm4aQtnJaNlaOWYsnTsabaNOxy
	0ZjWEOYKExZSew+ruhIf4VxGR40gAlcg1JqoPL7cepfNP22SNagvxpq1D0isf+Ryg5nC
	nvIw==
X-Gm-Message-State: APjAAAWfr+jw9xSVhUHtku0jP0q2s2eCUBYzTPIpGC5AcUlDDfbfuP//
	nFlkk9YiEx6ryXidhf21Z8fyqR9CD2M=
X-Google-Smtp-Source: APXvYqxPLVCwfJKCbxpLWpT87sKB4qYwYC2r7qoBTY0Ti9I5RqbjIsTRCJ0ctdBiyAdaQkFmHyF0cQ==
X-Received: by 2002:ac8:355c:: with SMTP id z28mr21935767qtb.286.1554713079175;
	Mon, 08 Apr 2019 01:44:39 -0700 (PDT)
Received: from localhost.localdomain (104.129.187.94.16clouds.com.
	[104.129.187.94]) by smtp.gmail.com with ESMTPSA id
	o50sm19119115qtc.23.2019.04.08.01.44.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 01:44:38 -0700 (PDT)
From: Catherine Ho <catherine.hecx@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Date: Mon,  8 Apr 2019 04:43:00 -0400
Message-Id: <1554712980-18714-1-git-send-email-catherine.hecx@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1554689945-18619-1-git-send-email-catherine.hecx@gmail.com>
References: <1554689945-18619-1-git-send-email-catherine.hecx@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::842
Subject: [Qemu-devel] [PATCH v2] hostmem-file: warn when memory-backend-file,
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
Message-ID: <20190408084300.qcOGOD2BefCPvH4I3yQEwT4ORWCjPUIjenkaMMoTZrU@z>

Currently it is not forbidden to use "-object memory-backend-file,share=on"
and together with "-incoming". But after incoming migration is finished,
the memory-backend-file will be definitely written if share=on. So the
memory-backend-file can only be used once, but failed in the 2nd time
incoming.

Thus it gives a warning and the users can run the qemu if they really
want to do it.

Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
---
 backends/hostmem-file.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 37ac6445d2..ce03dc0a18 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -16,6 +16,7 @@
 #include "sysemu/hostmem.h"
 #include "sysemu/sysemu.h"
 #include "qom/object_interfaces.h"
+#include "migration/migration.h"
 
 /* hostmem-file.c */
 /**
@@ -79,6 +80,17 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         }
     }
 
+    /*
+     * In ignore shared incoming migration, if share=on for host memory
+     * backend file, the ram might be modified after incoming process.
+     * The user should know this potential risk.
+     */
+    if (backend->share && migrate_ignore_shared()
+                       && runstate_check(RUN_STATE_INMIGRATE))
+        warn_report("NOTE: Please make sure the data on the shared memory "
+                    "backend file and the data from the incoming migration"
+                    " stream contains matching contents, otherwise...");
+
     backend->force_prealloc = mem_prealloc;
     name = host_memory_backend_get_name(backend);
     memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
-- 
2.17.1


