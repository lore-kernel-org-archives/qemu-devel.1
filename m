Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A67C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 05:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D40D8206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 05:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ud9kmGZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40D8206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35005 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMRDk-0001Br-3U
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 01:58:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR9a-0005oY-4K
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR9Z-0003Sq-7O
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:38 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
	id 1hMR9Z-0003Sd-1t; Fri, 03 May 2019 01:54:37 -0400
Received: by mail-pf1-x444.google.com with SMTP id 10so2350712pfo.5;
	Thu, 02 May 2019 22:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=PRRyyHPMZqJcq6mFtbX00mmQicMI/diLMW9xGgUxrSg=;
	b=ud9kmGZbKa7dfS2B58RkF+XraKDxgZYjM5EM54Qor7TJioEcSFgOpPQ0nqvIY1fGpa
	m9PQmb7BESi7M6PSVFEbGsNyX5g94NVzGRhPRYFjd3KSZQ9Rp+k0iw94Jr6vNx7h0FX8
	9DGxDE5aHX3Rryu60nYckKrtHdVX2D8HFDLkFV6PSQrey+ZyfPl60EAqiCsUFcgrnd3w
	ItAqBpVjr/gubwdF18TCDUCSn2OtTi0jo0sBFxSWc8PdA4jS9q4TjEppbUI0Q2MIsm48
	fOfZkQ/1NgNGRecd3o6EJvaf0kKfFY1LQM7DMP8h30fmcXGaz1pZKNtniZuT6JZYBgj/
	u5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=PRRyyHPMZqJcq6mFtbX00mmQicMI/diLMW9xGgUxrSg=;
	b=fst1pb4HW5vscCJG/dRpfRNs9gVNh2Uz+w7CQ4jdGcSKEKlGXMeDXJLf076bEXdJiR
	3EGHlsj+yIwpxbrUduEZ0QJ52sayfB7LjXeB8nLUlt3Q6YrZNY1MDWj0uEwSH8OaxP73
	gUZd3Co1hpkANDVeOaTGI5Cy365AwR3/WcJGz9Igem8Rr8DHVoYh3mqrbVBFE6mwBw2V
	sNpW4B4HuPwZfZUf7/phTw2xbj7p5r5I8sAweThnBhpwqQJKxIW1OU3GgBj6m24j9NuF
	uA5vfSsvtpRV5qjHz3Bcp3NcUTjmdjpGhJbwaCwcVBm086fjgV6mTRqL3LYe8gCZkYos
	2KsQ==
X-Gm-Message-State: APjAAAXvCZvagq0fnOTmFyEU0UKm34JHRwCmcUQIVVv4l7huVQ2AwvdW
	FEe+3KloQnAVfjqPpvvKD9DeNvKduOU=
X-Google-Smtp-Source: APXvYqy6Nh/VwdZ+tSpaHJgSes/MFeGOhabe3zf2d4zfs2kMxncBOXt5eeEctAvIng9hv2bcNTqmKg==
X-Received: by 2002:a63:f809:: with SMTP id n9mr7941670pgh.201.1556862875973; 
	Thu, 02 May 2019 22:54:35 -0700 (PDT)
Received: from localhost.ibm.com ([1.129.142.217])
	by smtp.gmail.com with ESMTPSA id
	h187sm1292983pfc.52.2019.05.02.22.54.32
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 22:54:35 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 15:53:15 +1000
Message-Id: <20190503055316.6441-13-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190503055316.6441-1-sjitindarsingh@gmail.com>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 12/13] target/ppc: Introduce POWER9
 DD2.2 cpu type
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
Cc: groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
	Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503055315.E-88thSWHPrnoHAz_c-oJJGw2o8bo5Iw3IbJdqIn4_w@z>

Introduce a POWER9 DD2.2 cpu type with pvr 0x004E1202.

A DD2.2 POWER9 cpu type is needed to enable kvm for pseries tcg guests
since it means they will use the H_ENTER_NESTED hcall to run a guest
rather than trying the generic entry path which will fail.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr_cpu_core.c | 1 +
 target/ppc/cpu-models.c | 2 ++
 target/ppc/cpu-models.h | 1 +
 3 files changed, 4 insertions(+)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 40e7010cf0..98d46c6edb 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -399,6 +399,7 @@ static const TypeInfo spapr_cpu_core_type_infos[] = {
     DEFINE_SPAPR_CPU_CORE_TYPE("power8nvl_v1.0"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power9_v1.0"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.0"),
+    DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.2"),
 #ifdef CONFIG_KVM
     DEFINE_SPAPR_CPU_CORE_TYPE("host"),
 #endif
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 7c75963e3c..603ae7f5b4 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -773,6 +773,8 @@
                 "POWER9 v1.0")
     POWERPC_DEF("power9_v2.0",   CPU_POWERPC_POWER9_DD20,            POWER9,
                 "POWER9 v2.0")
+    POWERPC_DEF("power9_v2.2",   CPU_POWERPC_POWER9_DD22,            POWER9,
+                "POWER9 v2.2")
 #endif /* defined (TARGET_PPC64) */
 
 /***************************************************************************/
diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index efdb2fa53c..820e94b0c8 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -373,6 +373,7 @@ enum {
     CPU_POWERPC_POWER9_BASE        = 0x004E0000,
     CPU_POWERPC_POWER9_DD1         = 0x004E0100,
     CPU_POWERPC_POWER9_DD20        = 0x004E1200,
+    CPU_POWERPC_POWER9_DD22        = 0x004E1202,
     CPU_POWERPC_970_v22            = 0x00390202,
     CPU_POWERPC_970FX_v10          = 0x00391100,
     CPU_POWERPC_970FX_v20          = 0x003C0200,
-- 
2.13.6


