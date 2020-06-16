Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6137FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:54:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32B02208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtJggvb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B02208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCyT-0001FA-GC
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCRL-00054N-Jh; Tue, 16 Jun 2020 10:19:51 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:35796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCRJ-00074e-Vu; Tue, 16 Jun 2020 10:19:51 -0400
Received: by mail-oi1-x234.google.com with SMTP id k4so19389344oik.2;
 Tue, 16 Jun 2020 07:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=T0nZx/piA2xOnjj6Pt8s+fwsT7brwJJgsCHLxedaAr4=;
 b=LtJggvb3hRlpd9yNL4y7qgfhSULxRu8xMAHg9OQiQYFvE2deCSoWovE+KrNkhLtFgK
 g1Uzalyku6KhWPpi/xg31x2JP5XM3QN1n1cixwMqWKLItkNr1YImCH6oiHGt+YchsNlD
 F+Tgv66b0jaWt4t41XbtyDgJrnZGYAOztuRIT28AosSm8ELqbDgf5TbZnWbYyajRCf9j
 8X792lEobbHC0l0Mhx4h6CAu44HPQMbfymDkSA/lNOVYWRAyNdeycACymjMS8aj6+M7j
 gewljXzxP0LKiqHMpcEenCc6OAJ+jvKXMxOvFyVturt7ZwPPCJCTseLHX6x7VOOA8fZM
 LCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=T0nZx/piA2xOnjj6Pt8s+fwsT7brwJJgsCHLxedaAr4=;
 b=kyPcVAsSnl/CFZGoD+sZqy2DQdqveo6R+Y9u0bEHpQGxaA+59bC3DFGzQlTug3pYZm
 1GUuGjYDiLxNB4zZgtZnkQKfsTdk1xD7pfya6z0SO6VhzVZq1jFAfAqtqXpANpztto7g
 GJMZJSJj5V7jd7BRUYDkNxdSWW2+n/MGoOuUOcH1DaE1/3/MUQCpbf+Lty/A4kkNBBW5
 nzmNHi5EanAKpVn3xRROGftkcJIi96uVuLjJ4NsPX13xB2xSSCezwTPYeARoI2AwRWby
 K9YzBpkW//E0kUxEBWIfYzGoYt/DLknm/Zd8lArEoM+k0nCy6E/Iul58lQ8VLEQKOGdi
 fS5g==
X-Gm-Message-State: AOAM533z9FjApJFWSY09uYE5kPcxvT+Lt6E5/BtTGmzMF18bR63/u3aq
 ImsoHZz8IaKDjchvNx6Vu5cMe9hjti4=
X-Google-Smtp-Source: ABdhPJyc91p4dToSg/uUtVelxH5IvXu13kgzSqTdC4BOVk2g1cQQg1ozCvculUYOvBnX/F70eQI+6A==
X-Received: by 2002:aca:f455:: with SMTP id s82mr1185364oih.178.1592317188154; 
 Tue, 16 Jun 2020 07:19:48 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id c9sm4032034oov.35.2020.06.16.07.19.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:19:47 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/78] numa: remove not needed check
Date: Tue, 16 Jun 2020 09:14:37 -0500
Message-Id: <20200616141547.24664-9-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x234.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-stable@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Currently parse_numa_node() is always called from already numa
enabled context.
Drop unnecessary check if numa is supported.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1576154936-178362-2-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
(cherry picked from commit 5275db59aa7ff8a26bd6aa5d07cb4d53de5cfab5)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/core/numa.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index e3332a984f..19f082de12 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -83,10 +83,6 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
         return;
     }
 
-    if (!mc->cpu_index_to_instance_props || !mc->get_default_cpu_node_id) {
-        error_setg(errp, "NUMA is not supported by this machine-type");
-        return;
-    }
     for (cpus = node->cpus; cpus; cpus = cpus->next) {
         CpuInstanceProperties props;
         if (cpus->value >= max_cpus) {
@@ -178,9 +174,8 @@ void parse_numa_distance(MachineState *ms, NumaDistOptions *dist, Error **errp)
 void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
 {
     Error *err = NULL;
-    MachineClass *mc = MACHINE_GET_CLASS(ms);
 
-    if (!mc->numa_mem_supported) {
+    if (!ms->numa_state) {
         error_setg(errp, "NUMA is not supported by this machine-type");
         goto end;
     }
-- 
2.17.1


