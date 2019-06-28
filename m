Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79EBC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 00:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D4AB208CB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 00:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4AB208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgeq2-0005Kd-FK
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 20:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36257)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hgelB-0000Bo-Bp
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 20:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hgelA-0006qV-05
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 20:29:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40454)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hgel9-0006pp-N9
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 20:28:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0F34737F46
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 00:28:59 +0000 (UTC)
Received: from localhost (ovpn-116-7.gru2.redhat.com [10.97.116.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 755EF5D9D2;
 Fri, 28 Jun 2019 00:28:58 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 21:28:40 -0300
Message-Id: <20190628002844.24894-6-ehabkost@redhat.com>
In-Reply-To: <20190628002844.24894-1-ehabkost@redhat.com>
References: <20190628002844.24894-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 28 Jun 2019 00:28:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 5/9] i386: Define -IBRS, -noTSX,
 -IBRS versions of CPU models
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
Cc: Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add versions of CPU models that are equivalent to their -IBRS,
-noTSX and -IBRS variants.

The separate variants will eventually be removed and become
aliases for these CPU versions.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
(New patch, added to series in v2)
---
 target/i386/cpu.c | 186 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b304c87b0f..5d33e75890 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1851,6 +1851,20 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT3_LAHF_LM,
         .xlevel = 0x80000008,
         .model_id = "Intel Core i7 9xx (Nehalem Class Core i7)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                /* Equivalent to Nehalem-IBRS */
+                .props = (PropValue[]) {
+                    { "spec-ctrl", "on" },
+                    { "model-id",
+                      "Intel Core i7 9xx (Nehalem Core i7, IBRS update)" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name = "Nehalem-IBRS",
@@ -1907,6 +1921,20 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_6_EAX_ARAT,
         .xlevel = 0x80000008,
         .model_id = "Westmere E56xx/L56xx/X56xx (Nehalem-C)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                /* Equivalent to Westmere-IBRS */
+                .props = (PropValue[]) {
+                    { "spec-ctrl", "on" },
+                    { "model-id",
+                      "Westmere E56xx/L56xx/X56xx (IBRS update)" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name = "Westmere-IBRS",
@@ -1971,6 +1999,20 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_6_EAX_ARAT,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon E312xx (Sandy Bridge)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                /* Equivalent to SandyBridge-IBRS */
+                .props = (PropValue[]) {
+                    { "spec-ctrl", "on" },
+                    { "model-id",
+                      "Intel Xeon E312xx (Sandy Bridge, IBRS update)" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name = "SandyBridge-IBRS",
@@ -2043,6 +2085,20 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_6_EAX_ARAT,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon E3-12xx v2 (Ivy Bridge)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                /* Equivalent to IvyBridge-IBRS */
+                .props = (PropValue[]) {
+                    { "spec-ctrl", "on" },
+                    { "model-id",
+                      "Intel Xeon E3-12xx v2 (Ivy Bridge, IBRS)" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name = "IvyBridge-IBRS",
@@ -2205,6 +2261,52 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_6_EAX_ARAT,
         .xlevel = 0x80000008,
         .model_id = "Intel Core Processor (Haswell)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                /* Equivalent to Haswell-noTSX */
+                .props = (PropValue[]) {
+                    { "hle", "off" },
+                    { "rtm", "off" },
+                    { "stepping", "1" },
+                    { "model-id", "Intel Core Processor (Haswell, no TSX)", },
+                    { /* end of list */ }
+                },
+            },
+            {
+                .version = 3,
+                /* Equivalent to Haswell-IBRS */
+                .props = (PropValue[]) {
+                    /* Restore TSX features removed by -v2 above */
+                    { "hle", "on" },
+                    { "rtm", "on" },
+                    /*
+                     * Haswell and Haswell-IBRS had stepping=4 in
+                     * QEMU 4.0 and older
+                     */
+                    { "stepping", "4" },
+                    { "spec-ctrl", "on" },
+                    { "model-id",
+                      "Intel Core Processor (Haswell, IBRS)" },
+                    { /* end of list */ }
+                }
+            },
+            {
+                .version = 4,
+                /* Equivalent to Haswell-noTSX-IBRS */
+                .props = (PropValue[]) {
+                    { "hle", "off" },
+                    { "rtm", "off" },
+                    /* spec-ctrl was already enabled by -v3 above */
+                    { "stepping", "1" },
+                    { "model-id",
+                      "Intel Core Processor (Haswell, no TSX, IBRS)" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name = "Haswell-IBRS",
@@ -2375,6 +2477,45 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_6_EAX_ARAT,
         .xlevel = 0x80000008,
         .model_id = "Intel Core Processor (Broadwell)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                /* Equivalent to Broadwell-noTSX */
+                .props = (PropValue[]) {
+                    { "hle", "off" },
+                    { "rtm", "off" },
+                    { "model-id", "Intel Core Processor (Broadwell, no TSX)", },
+                    { /* end of list */ }
+                },
+            },
+            {
+                .version = 3,
+                /* Equivalent to Broadwell-IBRS */
+                .props = (PropValue[]) {
+                    /* Restore TSX features removed by -v2 above */
+                    { "hle", "on" },
+                    { "rtm", "on" },
+                    { "spec-ctrl", "on" },
+                    { "model-id",
+                      "Intel Core Processor (Broadwell, IBRS)" },
+                    { /* end of list */ }
+                }
+            },
+            {
+                .version = 4,
+                /* Equivalent to Broadwell-noTSX-IBRS */
+                .props = (PropValue[]) {
+                    { "hle", "off" },
+                    { "rtm", "off" },
+                    /* spec-ctrl was already enabled by -v3 above */
+                    { "model-id",
+                      "Intel Core Processor (Broadwell, no TSX, IBRS)" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name = "Broadwell-IBRS",
@@ -2465,6 +2606,20 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_6_EAX_ARAT,
         .xlevel = 0x80000008,
         .model_id = "Intel Core Processor (Skylake)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                /* Equivalent to Skylake-Client-IBRS */
+                .props = (PropValue[]) {
+                    { "spec-ctrl", "on" },
+                    { "model-id",
+                      "Intel Core Processor (Skylake, IBRS)" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name = "Skylake-Client-IBRS",
@@ -2567,6 +2722,23 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_6_EAX_ARAT,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (Skylake)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                /* Equivalent to Skylake-Server-IBRS */
+                .props = (PropValue[]) {
+                    /* clflushopt was not added to Skylake-Server-IBRS */
+                    /* TODO: add -v3 including clflushopt */
+                    { "clflushopt", "off" },
+                    { "spec-ctrl", "on" },
+                    { "model-id",
+                      "Intel Xeon Processor (Skylake, IBRS)" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name = "Skylake-Server-IBRS",
@@ -3011,6 +3183,20 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .xlevel = 0x8000001E,
         .model_id = "AMD EPYC Processor",
         .cache_info = &epyc_cache_info,
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                /* Equivalent to EPYC-IBPB */
+                .props = (PropValue[]) {
+                    { "ibpb", "on" },
+                    { "model-id",
+                      "AMD EPYC Processor (with IBPB)" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name = "EPYC-IBPB",
-- 
2.18.0.rc1.1.g3f1ff2140


