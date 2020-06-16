Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0362BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:20:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C23AD20707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFL9dDk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23AD20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCRV-0004oX-Us
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPB-00010V-2A; Tue, 16 Jun 2020 10:17:37 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:37383)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCP9-0006WQ-4R; Tue, 16 Jun 2020 10:17:36 -0400
Received: by mail-ot1-x336.google.com with SMTP id v13so16026841otp.4;
 Tue, 16 Jun 2020 07:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2om/n6j/KN2TdtxPEqFhJaW70WBM2nI5WC5aQncvJV0=;
 b=XFL9dDk2CaS4A3U39+X98CzI2K3xIGEETWv1IbKp7ztJWxXUsQ/RIpQjMQnnqFeOn+
 tqTX12tWh7WhH+p0zPogEcqOliWPUQsfWah0ddiupmmKFoHxYh+zGkqa75El+fkI8Rj9
 LMGVjx/RwvMQb0exilEhBnFugjuzDvL99iu12PK3ho5cWK1LUS1sz+f9Uh5AZ6zMeA8X
 2+lWmzUNOZbVVM2YeQ9F4f5rP8WM2ftmfFOM0B3XdTYKPJ4p7WXGyV7K2rE7673gsXnV
 14Cf9GKtBoAagrOJUas8p4Hqy3Rzik2tAloRp2Hs6PkCHuyLa+haqQ7JZThG/5uKqDw+
 3FSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=2om/n6j/KN2TdtxPEqFhJaW70WBM2nI5WC5aQncvJV0=;
 b=R19yEkyx+YoAUnwrGQcMFvVVX48vimZa3fi/WoTe+X3KSlqBIHbVodyY/N9s92rvBo
 AtJfGzGMsh3MBB+bVS7Da3k04aodcgN5gMLDR2dLvpLG7BBeojKyk679CyC4uD5gBcOO
 UhxRGk/NxsSdlQHreMMc6nrNR3dsf+mubMgQFar7ws4Y45fLJQGvnqlqXQ22+ZqKmdUo
 iyC0/eygSi4N/tdICzgc1qHqevLYsq4i+jzhPrvJ2FMJJMUC23hfNg0FHxyitQXaQI5o
 bhXPt1UPnevDafA7Z+sHFD9ATqif7s0Ue7BBZRWXQVIiNZ4Gwx90L8px8FOa8Wd638qq
 CPJA==
X-Gm-Message-State: AOAM533rrthXP1mIeC/fLwiRwhG62pZxrySKUDNps6XbPViaE7Jydrtk
 tWohFliLJL5aw5B1KuzQlwv1JtUM
X-Google-Smtp-Source: ABdhPJzNerOYN9Do4YP5TfJx+zNt7p5YI/XAgAnO0IYKLeweCtQb6UJoF073i+1uCbVazmIC869ghQ==
X-Received: by 2002:a9d:3a24:: with SMTP id j33mr2505701otc.271.1592317052511; 
 Tue, 16 Jun 2020 07:17:32 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id g10sm4072699otn.34.2020.06.16.07.17.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:17:31 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/78] numa: properly check if numa is supported
Date: Tue, 16 Jun 2020 09:14:38 -0500
Message-Id: <20200616141547.24664-10-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x336.google.com
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

Commit aa57020774b, by mistake used MachineClass::numa_mem_supported
to check if NUMA is supported by machine and also as unrelated change
set it to true for sbsa-ref board.

Luckily change didn't break machines that support NUMA, as the field
is set to true for them.

But the field is not intended for checking if NUMA is supported and
will be flipped to false within this release for new machine types.

Fix it:
 - by using previously used condition
      !mc->cpu_index_to_instance_props || !mc->get_default_cpu_node_id
   the first time and then use MachineState::numa_state down the road
   to check if NUMA is supported
 - dropping stray sbsa-ref chunk

Fixes: aa57020774b690a22be72453b8e91c9b5a68c516
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1576154936-178362-3-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
(cherry picked from commit fcd3f2cc124600385dba46c69a80626985c15b50)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/arm/sbsa-ref.c | 1 -
 hw/core/machine.c | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 27046cc284..c6261d44a4 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -791,7 +791,6 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
     mc->possible_cpu_arch_ids = sbsa_ref_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = sbsa_ref_cpu_index_to_props;
     mc->get_default_cpu_node_id = sbsa_ref_get_default_cpu_node_id;
-    mc->numa_mem_supported = true;
 }
 
 static const TypeInfo sbsa_ref_info = {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1689ad3bf8..aa63231f31 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -958,7 +958,7 @@ static void machine_initfn(Object *obj)
                                         NULL);
     }
 
-    if (mc->numa_mem_supported) {
+    if (mc->cpu_index_to_instance_props && mc->get_default_cpu_node_id) {
         ms->numa_state = g_new0(NumaState, 1);
     }
 
@@ -1102,7 +1102,7 @@ void machine_run_board_init(MachineState *machine)
 {
     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
 
-    if (machine_class->numa_mem_supported) {
+    if (machine->numa_state) {
         numa_complete_configuration(machine);
         if (machine->numa_state->num_nodes) {
             machine_numa_finish_cpu_init(machine);
-- 
2.17.1


