Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC393C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 08:15:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A034A20714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 08:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A034A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1nBU-0001KJ-TE
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 03:15:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1j1n9R-0005uU-Nw
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 03:13:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1j1n9Q-0008QE-A1
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 03:13:41 -0500
Received: from mga07.intel.com ([134.134.136.100]:37424)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1j1n9Q-0008Fq-1d
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 03:13:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Feb 2020 00:13:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; d="scan'208";a="233718913"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by orsmga003.jf.intel.com with ESMTP; 12 Feb 2020 00:13:36 -0800
From: Tao Xu <tao3.xu@intel.com>
To: pbonzini@redhat.com,
	rth@twiddle.net,
	ehabkost@redhat.com
Subject: [PATCH v3 4/4] target/i386: Add notes for versioned CPU models
Date: Wed, 12 Feb 2020 16:13:28 +0800
Message-Id: <20200212081328.7385-5-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200212081328.7385-1-tao3.xu@intel.com>
References: <20200212081328.7385-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
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
Cc: tao3.xu@intel.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add which features are added or removed in this version. Remove the
changed model-id in versioned CPU models, to keep the model name
unchanged at /proc/cpuinfo inside the VM.

Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

Changes in v2:
    - correct the note of Cascadelake v3 (Xiaoyao)
---
 target/i386/cpu.c | 54 ++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 81a039beb6..739ef4ce91 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2278,10 +2278,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
             {
                 .version = 2,
                 .alias = "Nehalem-IBRS",
+                .note = "IBRS",
                 .props = (PropValue[]) {
                     { "spec-ctrl", "on" },
-                    { "model-id",
-                      "Intel Core i7 9xx (Nehalem Core i7, IBRS update)" },
                     { /* end of list */ }
                 }
             },
@@ -2359,10 +2358,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
             {
                 .version = 2,
                 .alias = "Westmere-IBRS",
+                .note = "IBRS",
                 .props = (PropValue[]) {
                     { "spec-ctrl", "on" },
-                    { "model-id",
-                      "Westmere E56xx/L56xx/X56xx (IBRS update)" },
                     { /* end of list */ }
                 }
             },
@@ -2445,10 +2443,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
             {
                 .version = 2,
                 .alias = "SandyBridge-IBRS",
+                .note = "IBRS",
                 .props = (PropValue[]) {
                     { "spec-ctrl", "on" },
-                    { "model-id",
-                      "Intel Xeon E312xx (Sandy Bridge, IBRS update)" },
                     { /* end of list */ }
                 }
             },
@@ -2537,10 +2534,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
             {
                 .version = 2,
                 .alias = "IvyBridge-IBRS",
+                .note = "IBRS",
                 .props = (PropValue[]) {
                     { "spec-ctrl", "on" },
-                    { "model-id",
-                      "Intel Xeon E3-12xx v2 (Ivy Bridge, IBRS)" },
                     { /* end of list */ }
                 }
             },
@@ -2634,17 +2630,18 @@ static X86CPUDefinition builtin_x86_defs[] = {
             {
                 .version = 2,
                 .alias = "Haswell-noTSX",
+                .note = "no TSX",
                 .props = (PropValue[]) {
                     { "hle", "off" },
                     { "rtm", "off" },
                     { "stepping", "1" },
-                    { "model-id", "Intel Core Processor (Haswell, no TSX)", },
                     { /* end of list */ }
                 },
             },
             {
                 .version = 3,
                 .alias = "Haswell-IBRS",
+                .note = "IBRS",
                 .props = (PropValue[]) {
                     /* Restore TSX features removed by -v2 above */
                     { "hle", "on" },
@@ -2655,21 +2652,18 @@ static X86CPUDefinition builtin_x86_defs[] = {
                      */
                     { "stepping", "4" },
                     { "spec-ctrl", "on" },
-                    { "model-id",
-                      "Intel Core Processor (Haswell, IBRS)" },
                     { /* end of list */ }
                 }
             },
             {
                 .version = 4,
                 .alias = "Haswell-noTSX-IBRS",
+                .note = "no TSX, IBRS",
                 .props = (PropValue[]) {
                     { "hle", "off" },
                     { "rtm", "off" },
                     /* spec-ctrl was already enabled by -v3 above */
                     { "stepping", "1" },
-                    { "model-id",
-                      "Intel Core Processor (Haswell, no TSX, IBRS)" },
                     { /* end of list */ }
                 }
             },
@@ -2765,35 +2759,33 @@ static X86CPUDefinition builtin_x86_defs[] = {
             {
                 .version = 2,
                 .alias = "Broadwell-noTSX",
+                .note = "no TSX",
                 .props = (PropValue[]) {
                     { "hle", "off" },
                     { "rtm", "off" },
-                    { "model-id", "Intel Core Processor (Broadwell, no TSX)", },
                     { /* end of list */ }
                 },
             },
             {
                 .version = 3,
                 .alias = "Broadwell-IBRS",
+                .note = "IBRS",
                 .props = (PropValue[]) {
                     /* Restore TSX features removed by -v2 above */
                     { "hle", "on" },
                     { "rtm", "on" },
                     { "spec-ctrl", "on" },
-                    { "model-id",
-                      "Intel Core Processor (Broadwell, IBRS)" },
                     { /* end of list */ }
                 }
             },
             {
                 .version = 4,
                 .alias = "Broadwell-noTSX-IBRS",
+                .note = "no TSX, IBRS",
                 .props = (PropValue[]) {
                     { "hle", "off" },
                     { "rtm", "off" },
                     /* spec-ctrl was already enabled by -v3 above */
-                    { "model-id",
-                      "Intel Core Processor (Broadwell, no TSX, IBRS)" },
                     { /* end of list */ }
                 }
             },
@@ -2893,22 +2885,20 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
+                .note = "IBRS",
                 .alias = "Skylake-Client-IBRS",
                 .props = (PropValue[]) {
                     { "spec-ctrl", "on" },
-                    { "model-id",
-                      "Intel Core Processor (Skylake, IBRS)" },
                     { /* end of list */ }
                 }
             },
             {
                 .version = 3,
                 .alias = "Skylake-Client-noTSX-IBRS",
+                .note = "no TSX, IBRS",
                 .props = (PropValue[]) {
                     { "hle", "off" },
                     { "rtm", "off" },
-                    { "model-id",
-                      "Intel Core Processor (Skylake, IBRS, no TSX)" },
                     { /* end of list */ }
                 }
             },
@@ -3016,24 +3006,22 @@ static X86CPUDefinition builtin_x86_defs[] = {
             {
                 .version = 2,
                 .alias = "Skylake-Server-IBRS",
+                .note = "IBRS",
                 .props = (PropValue[]) {
                     /* clflushopt was not added to Skylake-Server-IBRS */
                     /* TODO: add -v3 including clflushopt */
                     { "clflushopt", "off" },
                     { "spec-ctrl", "on" },
-                    { "model-id",
-                      "Intel Xeon Processor (Skylake, IBRS)" },
                     { /* end of list */ }
                 }
             },
             {
                 .version = 3,
                 .alias = "Skylake-Server-noTSX-IBRS",
+                .note = "no TSX, IBRS",
                 .props = (PropValue[]) {
                     { "hle", "off" },
                     { "rtm", "off" },
-                    { "model-id",
-                      "Intel Xeon Processor (Skylake, IBRS, no TSX)" },
                     { /* end of list */ }
                 }
             },
@@ -3142,6 +3130,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .versions = (X86CPUVersionDefinition[]) {
             { .version = 1 },
             { .version = 2,
+              .note = "ARCH_CAPABILITIES",
               .props = (PropValue[]) {
                   { "arch-capabilities", "on" },
                   { "rdctl-no", "on" },
@@ -3153,6 +3142,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             },
             { .version = 3,
               .alias = "Cascadelake-Server-noTSX",
+              .note = "ARCH_CAPABILITIES, no TSX",
               .props = (PropValue[]) {
                   { "hle", "off" },
                   { "rtm", "off" },
@@ -3374,6 +3364,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
+                .note = "no TSX",
                 .alias = "Icelake-Client-noTSX",
                 .props = (PropValue[]) {
                     { "hle", "off" },
@@ -3491,6 +3482,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
+                .note = "no TSX",
                 .alias = "Icelake-Server-noTSX",
                 .props = (PropValue[]) {
                     { "hle", "off" },
@@ -3598,6 +3590,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
+                .note = "no MPX, no MONITOR",
                 .props = (PropValue[]) {
                     { "monitor", "off" },
                     { "mpx", "off" },
@@ -3727,14 +3720,15 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
+                .note = "no MPX",
                 .props = (PropValue[]) {
                     { "mpx", "off" },
-                    { "model-id", "Intel Atom Processor (Snowridge, no MPX)" },
                     { /* end of list */ },
                 },
             },
             {
                 .version = 3,
+                .note = "no MPX, no MONITOR",
                 .props = (PropValue[]) {
                     /* mpx was already removed by -v2 above */
                     { "monitor", "off" },
@@ -3856,6 +3850,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
+                .note = "no MONITOR",
                 .props = (PropValue[]) {
                     { "monitor", "off" },
                     { /* end of list */ },
@@ -3980,15 +3975,15 @@ static X86CPUDefinition builtin_x86_defs[] = {
             {
                 .version = 2,
                 .alias = "EPYC-IBPB",
+                .note = "IBPB",
                 .props = (PropValue[]) {
                     { "ibpb", "on" },
-                    { "model-id",
-                      "AMD EPYC Processor (with IBPB)" },
                     { /* end of list */ }
                 }
             },
             {
                 .version = 3,
+                .note = "IBPB, no MONITOR",
                 .props = (PropValue[]) {
                     /* ibpb was already enabled by -v2 above */
                     { "monitor", "off" },
@@ -4051,6 +4046,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
+                .note = "no MONITOR",
                 .props = (PropValue[]) {
                     { "monitor", "off" },
                     { /* end of list */ },
-- 
2.20.1


