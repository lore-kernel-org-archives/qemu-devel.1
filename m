Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40523C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 06:19:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 040492070E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 06:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040492070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip4gR-0000cf-2m
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 01:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1ip4ca-0003jX-R8
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 01:15:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1ip4cZ-0006A7-Ao
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 01:15:12 -0500
Received: from mga17.intel.com ([192.55.52.151]:12862)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1ip4cZ-00063A-2J
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 01:15:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Jan 2020 22:15:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,408,1571727600"; d="scan'208";a="254121013"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by fmsmga002.fm.intel.com with ESMTP; 07 Jan 2020 22:15:04 -0800
From: Tao Xu <tao3.xu@intel.com>
To: pbonzini@redhat.com,
	rth@twiddle.net,
	ehabkost@redhat.com
Subject: [PATCH RESEND v2 4/4] target/i386: Add notes for versioned CPU models
Date: Wed,  8 Jan 2020 14:14:58 +0800
Message-Id: <20200108061458.8080-5-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108061458.8080-1-tao3.xu@intel.com>
References: <20200108061458.8080-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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
changed model-id in versioned CPU models.

Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

Changes in v2:
    - correct the note of Cascadelake v3 (Xiaoyao)
---
 target/i386/cpu.c | 50 +++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 736b4c7326..4daa153bfa 100644
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
@@ -2893,17 +2885,17 @@ static X86CPUDefinition builtin_x86_defs[] = {
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
@@ -3014,19 +3006,19 @@ static X86CPUDefinition builtin_x86_defs[] = {
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
@@ -3138,6 +3130,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .versions = (X86CPUVersionDefinition[]) {
             { .version = 1 },
             { .version = 2,
+              .note = "ARCH_CAPABILITIES",
               .props = (PropValue[]) {
                   { "arch-capabilities", "on" },
                   { "rdctl-no", "on" },
@@ -3149,6 +3142,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             },
             { .version = 3,
               .alias = "Cascadelake-Server-noTSX",
+              .note = "ARCH_CAPABILITIES, no TSX",
               .props = (PropValue[]) {
                   { "hle", "off" },
                   { "rtm", "off" },
@@ -3321,6 +3315,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
+                .note = "no TSX",
                 .alias = "Icelake-Client-noTSX",
                 .props = (PropValue[]) {
                     { "hle", "off" },
@@ -3438,6 +3433,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
+                .note = "no TSX",
                 .alias = "Icelake-Server-noTSX",
                 .props = (PropValue[]) {
                     { "hle", "off" },
@@ -3545,6 +3541,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
+                .note = "no MPX, no MONITOR",
                 .props = (PropValue[]) {
                     { "monitor", "off" },
                     { "mpx", "off" },
@@ -3674,14 +3671,15 @@ static X86CPUDefinition builtin_x86_defs[] = {
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
@@ -3803,6 +3801,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
+                .note = "no MONITOR",
                 .props = (PropValue[]) {
                     { "monitor", "off" },
                     { /* end of list */ },
@@ -3927,15 +3926,15 @@ static X86CPUDefinition builtin_x86_defs[] = {
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
@@ -3998,6 +3997,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
+                .note = "no MONITOR",
                 .props = (PropValue[]) {
                     { "monitor", "off" },
                     { /* end of list */ },
-- 
2.20.1


