Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349A4C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED7A123B18
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W32Mdrbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7A123B18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6zVk-00083Q-92
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 12:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k6zV6-0007Um-73; Sat, 15 Aug 2020 12:57:48 -0400
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44]:41246)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k6zV4-0000Qv-KZ; Sat, 15 Aug 2020 12:57:47 -0400
Received: by mail-vs1-xe44.google.com with SMTP id y8so6207844vsq.8;
 Sat, 15 Aug 2020 09:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QhUbY4D4iyRK40TzD9Y23365Paz8ar+9JQzeCK3jAbI=;
 b=W32MdrbsOEQev3So74vDtyL6MuBhOlGqrcpDqSgXcdFOacc2hM3wUh9iQM734pwC7l
 iQRYObiVZz04q2Sb2vew4IGr7knyLwwtRwIK1jUZ28JuptPM6ifHX97sonv+ZKeDP5MA
 e5Lm2PVjOncm505Er76Oi5w8ViKfamQHU4UNLfiac+mL+fA9E9pCk27mO1H1WLPfYOXG
 AVnbdUuSkbhM7alcsyv0zehtLqzHYhKhjB5xv6OcpSwWHXv1FENDWI5uHsn2zPpHam2c
 M5N+VcqGIS5NkSQNlEJAswpN9Ag9I/EJKLJfNQbdV0Sc1nePFYNhEOxjfMoojpUbGGa3
 U9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QhUbY4D4iyRK40TzD9Y23365Paz8ar+9JQzeCK3jAbI=;
 b=GtCUaS+qOb5LpJvxZhIDM+zdPslN4TzOK1p3qLGN4VaZvOnxyJ+sm5RFiglTAPyhs7
 BFY/InGnsBTGJy0KYPMnbYwEH8frUSOdCAonMXtokHY5u0D1/mcH6MzMRGkXqyeYqdFk
 RBZeyo0OppqRLSpl/sJoGJoLv7niMkqcueL+ORd9LbcK0x8a0bNRLeIWyJnvVmvEoXTA
 Hu//K46uKUq4ZwTmXdJm9UylXGnstAVLIQ1fVUC+x08cTPvLGunwrBd9G3e4mIolfnlr
 cdfYbF4sJK6LiJzrwY69hCfqP/rLZkFu8wMTERp5qjYLCAtWzg6Y1vpWgmxcF5UtduS6
 ErpQ==
X-Gm-Message-State: AOAM532tt3Jpj1LXkoyzjH5VvgCpfu5AVaC9QGlI5InjYGHc1zZHVIKQ
 ujUCbolEkma5lsgY7uPichmveywEaIGsoA==
X-Google-Smtp-Source: ABdhPJwQKPZyG6C+NjbJvTmmEOV3QDDLSpN3z5ZBpp4cCh3YkIrGX8qKLgg5wzPURhYCXqXm1jSEkw==
X-Received: by 2002:a05:6214:12b4:: with SMTP id
 w20mr4421242qvu.32.1597438486131; 
 Fri, 14 Aug 2020 13:54:46 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:303f:d1dc:35d8:e9f6:c8b])
 by smtp.gmail.com with ESMTPSA id p33sm12301018qtp.49.2020.08.14.13.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 13:54:45 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/10] spapr: make ibm,
 max-associativity-domains scale with user input
Date: Fri, 14 Aug 2020 17:54:19 -0300
Message-Id: <20200814205424.543857-6-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200814205424.543857-1-danielhb413@gmail.com>
References: <20200814205424.543857-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e44;
 envelope-from=danielhb413@gmail.com; helo=mail-vs1-xe44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ibm,max-associativity-domains is considering that only a single
associativity domain can exist in the same NUMA level. This is true
today because we do not support any type of NUMA distance user
customization, and all nodes are in the same distance to each other.

To enhance NUMA distance support in the pSeries machine we need to
make this limit flexible. This patch rewrites the max-associativity
logic to consider that multiple associativity domains can co-exist
in the same NUMA level. We're using the legacy_numa() helper to
avoid leaking unneeded guest changes.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 073a59c47d..b0c4b80a23 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -919,13 +919,20 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
         cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE & 0xffffffff),
         cpu_to_be32(ms->smp.max_cpus / ms->smp.threads),
     };
-    uint32_t maxdomain = cpu_to_be32(spapr->extra_numa_nodes > 1 ? 1 : 0);
+
+    /* The maximum domains for a given NUMA level, supposing that every
+     * additional NUMA node belongs to the same domain (aside from the
+     * 4th level, where we must support all available NUMA domains), is
+     * total number of domains - 1. */
+    uint32_t total_nodes_number = ms->numa_state->num_nodes +
+                                  spapr->extra_numa_nodes;
+    uint32_t maxdomain = cpu_to_be32(total_nodes_number - 1);
     uint32_t maxdomains[] = {
         cpu_to_be32(4),
         maxdomain,
         maxdomain,
         maxdomain,
-        cpu_to_be32(ms->numa_state->num_nodes + spapr->extra_numa_nodes),
+        cpu_to_be32(total_nodes_number),
     };
 
     _FDT(rtas = fdt_add_subnode(fdt, 0, "rtas"));
@@ -962,6 +969,13 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
                      qemu_hypertas->str, qemu_hypertas->len));
     g_string_free(qemu_hypertas, TRUE);
 
+    if (spapr_machine_using_legacy_numa(spapr)) {
+        maxdomain = cpu_to_be32(spapr->extra_numa_nodes > 1 ? 1 : 0);
+        maxdomains[1] = maxdomain;
+        maxdomains[2] = maxdomain;
+        maxdomains[3] = maxdomain;
+    }
+
     if (smc->pre_5_1_assoc_refpoints) {
         nr_refpoints = 2;
     }
-- 
2.26.2


