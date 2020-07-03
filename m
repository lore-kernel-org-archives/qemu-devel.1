Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D8DC433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 367CC207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xj7l8D4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367CC207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHeJ-0003P9-DV
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHc8-0007Au-40
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:04:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40745
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHc5-0004Q0-PC
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rnwhkibuuryD3VaVsetE4dEaQSFYlxZxsA4QPNf181w=;
 b=Xj7l8D4u3VhP8Tjlii1PypY3HvAtpxwvUtuftOb1UZ5SaQ9NoCCghR3zRRSe/nr5fclFW4
 6/H13Vjbl2/byrVxV8XlIiqhLhtdF+itzdJRQyG0zPly0mNw3hfhS0Fzaf82uAtsM5TxY7
 cFM/AfqCFqaJf38gxtrBvbLzujPoBog=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-302NP6nFOmatqi4d9xgkTQ-1; Fri, 03 Jul 2020 05:04:03 -0400
X-MC-Unique: 302NP6nFOmatqi4d9xgkTQ-1
Received: by mail-wr1-f72.google.com with SMTP id o12so30996158wrj.23
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rnwhkibuuryD3VaVsetE4dEaQSFYlxZxsA4QPNf181w=;
 b=XwifsuSxPfgOSLnv9ZLm5LlQJM3f2YPtioL6ghnQle5ZWDRyjXYXR4ecTTd2syjnBs
 YdZmdAtAiFJevoyXpH8UCPMIlGt4z3y7X4M3KWNO9DqBTddS2qMazaH8LHZ60tGmKxvy
 4hOK9JSxtTHc1OdO4AA8os5Z/iPN/HoBi9s9zDn9BpsJDC/RR1oj8cYPHenIbA5ByGag
 iibhNoY2h8VCfSuHfg4mM6iZJTrwyA+cuAOyXC+66R1DfHPqnzzD4UcMTunmddOoFX+x
 1qtqyfELsRAMtnHEC3Ogv8243HEzRYu698wVPHeZgX87J0KoUtfwHISEnw4CuvvP2Z+A
 32Bg==
X-Gm-Message-State: AOAM533JRRQ/KGf7GaArXmSmAeBw5P8pLYI8ge1dOOiDS+RqGfzolTmN
 ewEUGC58RJINxNYOryOrDAw61QBkLDUulwDzqTa7+ILa1p1jX7ovNq2vPfg8cPlfHEsL7SldrmF
 MMwSRXUfrWEcajNA=
X-Received: by 2002:a1c:8117:: with SMTP id c23mr34101336wmd.157.1593767041866; 
 Fri, 03 Jul 2020 02:04:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOB+uxXEgl2dQNx7bkwmysvny+NE4Cr1joxpCN8CulWI2eXMmPmxTBel5s32ijgBWWgEbDJw==
X-Received: by 2002:a1c:8117:: with SMTP id c23mr34101328wmd.157.1593767041706; 
 Fri, 03 Jul 2020 02:04:01 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 h84sm13810740wme.22.2020.07.03.02.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:04:01 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:03:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/41] migration/rdma: Use ram_block_discard_disable()
Message-ID: <20200703090252.368694-12-mst@redhat.com>
References: <20200703090252.368694-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703090252.368694-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

RDMA will pin all guest memory (as documented in docs/rdma.txt). We want
to disable RAM block discards - however, to keep it simple use
ram_block_discard_is_required() instead of inhibiting.

Note: It is not sufficient to limit disabling to pin_all. Even when only
conditionally pinning 1 MB chunks, as soon as one page within such a
chunk was discarded and one page not, the discarded pages will be pinned
as well.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200626072248.78761-9-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 migration/rdma.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index ec45d33ba3..bbe6f36627 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -29,6 +29,7 @@
 #include "qemu/sockets.h"
 #include "qemu/bitmap.h"
 #include "qemu/coroutine.h"
+#include "exec/memory.h"
 #include <sys/socket.h>
 #include <netdb.h>
 #include <arpa/inet.h>
@@ -4017,8 +4018,14 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
     Error *local_err = NULL;
 
     trace_rdma_start_incoming_migration();
-    rdma = qemu_rdma_data_init(host_port, &local_err);
 
+    /* Avoid ram_block_discard_disable(), cannot change during migration. */
+    if (ram_block_discard_is_required()) {
+        error_setg(errp, "RDMA: cannot disable RAM discard");
+        return;
+    }
+
+    rdma = qemu_rdma_data_init(host_port, &local_err);
     if (rdma == NULL) {
         goto err;
     }
@@ -4067,10 +4074,17 @@ void rdma_start_outgoing_migration(void *opaque,
                             const char *host_port, Error **errp)
 {
     MigrationState *s = opaque;
-    RDMAContext *rdma = qemu_rdma_data_init(host_port, errp);
     RDMAContext *rdma_return_path = NULL;
+    RDMAContext *rdma;
     int ret = 0;
 
+    /* Avoid ram_block_discard_disable(), cannot change during migration. */
+    if (ram_block_discard_is_required()) {
+        error_setg(errp, "RDMA: cannot disable RAM discard");
+        return;
+    }
+
+    rdma = qemu_rdma_data_init(host_port, errp);
     if (rdma == NULL) {
         goto err;
     }
-- 
MST


