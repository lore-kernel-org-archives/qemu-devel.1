Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38194C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:28:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC36E206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBD+bl9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC36E206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwmJ-00074S-3W
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwL4-0003Zx-6Z; Thu, 03 Sep 2020 17:00:10 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwL2-0007Q5-8u; Thu, 03 Sep 2020 17:00:09 -0400
Received: by mail-ot1-x343.google.com with SMTP id h17so3207585otr.1;
 Thu, 03 Sep 2020 14:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jbZUzUuJIhTs9gFdFE43wolgbeVB484D+UVnVZjxmoY=;
 b=hBD+bl9ZoakJP/g1P3Lzv1o6HuvcT6OA0hbTBJwBg3+wGcfZ6Qq/dr8rxT6ZhLOdbx
 rX616KSvkR7Vag0Oji7ynTCHSaqWKXLaMO/I2l94ZLPpTlVOp7Shz3Tmn+2dnjks+9BA
 8O8SWUBr5nxuwBUKlgIaP2kJS808JeOSIafTugP6S75/8qv6IuzkVIEduk6H8ccFaAhZ
 8fOTwTOol7Vg3NH1QzU+5hX9S4R+yEPWs4+vva8glghAqKNy2NukdwR4aPte4BGk5RqP
 Ej4TdIfFAte4558f8FvCXcclaISqdWY2iWzoE3ac8Cxczpr8mrwoxrnefhnDfaegiXv0
 A6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jbZUzUuJIhTs9gFdFE43wolgbeVB484D+UVnVZjxmoY=;
 b=OAKc6WVS2AludjdNGqXKm8v3hhpjWiX2Udv+q4qnH/1dn+kpZt/lDJZ7JhXLW6u7DS
 Izo0dk0oENjcQBoJQY0khdHtSlzcX6O8pp2XBkYTK3oyPuJSpYDrSZInX59me6flYSJV
 5iqGKmpQpogqVYeR1XXKvfL/9NcnGidXlcGEiYONb9mW/Dx4gZ8F6Tetg/Jip04fBmAx
 0VNXbc5TzFmtzuifHb7Hbx40OJHlJkKfky69bzK0gfhHHwi3TX0hPJoItkoZH9hgvbUN
 BeUA9JABlVCkDe+tNKpdJb6gx7PMNsM0PAHIiEMO1d60WQUiEPgTJ5QOzEhbhbpIlYEl
 D6nA==
X-Gm-Message-State: AOAM531EVrP3egDd0xBAGfFKLSIQKUc2H0PjgtYE6av1UMJBuGqRRWNC
 xMhfBnI3X8vCLhl6M7brmPA2+KWJ7ZI=
X-Google-Smtp-Source: ABdhPJxOEa4HeMaORqyd/A/vpdsSgLJ/3XWzo3WDhX8/x+4TwWvZI+j9avwQEjG5BSLj9dNxInpENg==
X-Received: by 2002:a9d:6b8b:: with SMTP id b11mr2777318otq.357.1599166806349; 
 Thu, 03 Sep 2020 14:00:06 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id t84sm294132oif.32.2020.09.03.14.00.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:05 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/77] hostmem: don't use mbind() if host-nodes is empty
Date: Thu,  3 Sep 2020 15:58:19 -0500
Message-Id: <20200903205935.27832-2-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-stable@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Since 5.0 QEMU uses hostmem backend for allocating main guest RAM.
The backend however calls mbind() which is typically NOP
in case of default policy/absent host-nodes bitmap.
However when runing in container with black-listed mbind()
syscall, QEMU fails to start with error
 "cannot bind memory to host NUMA nodes: Operation not permitted"
even when user hasn't provided host-nodes to pin to explictly
(which is the case with -m option)

To fix issue, call mbind() only in case when user has provided
host-nodes explicitly (i.e. host_nodes bitmap is not empty).
That should allow to run QEMU in containers with black-listed
mbind() without memory pinning. If QEMU provided memory-pinning
is required user still has to white-list mbind() in container
configuration.

Reported-by: Manuel Hohmann <mhohmann@physnet.uni-hamburg.de>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200430154606.6421-1-imammedo@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
(cherry picked from commit 70b6d525dfb51d5e523d568d1139fc051bc223c5)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 backends/hostmem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 327f9eebc3..0efd7b7bd6 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -383,8 +383,10 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
         assert(sizeof(backend->host_nodes) >=
                BITS_TO_LONGS(MAX_NODES + 1) * sizeof(unsigned long));
         assert(maxnode <= MAX_NODES);
-        if (mbind(ptr, sz, backend->policy,
-                  maxnode ? backend->host_nodes : NULL, maxnode + 1, flags)) {
+
+        if (maxnode &&
+            mbind(ptr, sz, backend->policy, backend->host_nodes, maxnode + 1,
+                  flags)) {
             if (backend->policy != MPOL_DEFAULT || errno != ENOSYS) {
                 error_setg_errno(errp, errno,
                                  "cannot bind memory to host NUMA nodes");
-- 
2.17.1


