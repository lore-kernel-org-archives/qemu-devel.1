Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84679C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 06:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 490C520881
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 06:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490C520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibfHH-0007om-8i
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 01:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1ibfCn-0003Dg-IV
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 01:29:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1ibfCm-0007cn-3p
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 01:29:09 -0500
Received: from mga05.intel.com ([192.55.52.43]:35652)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1ibfCl-0007b8-MO
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 01:29:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Dec 2019 22:29:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,268,1571727600"; d="scan'208";a="360703507"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by orsmga004.jf.intel.com with ESMTP; 01 Dec 2019 22:29:01 -0800
From: Tao Xu <tao3.xu@intel.com>
To: pbonzini@redhat.com,
	rth@twiddle.net,
	ehabkost@redhat.com
Subject: [PATCH 4/4] target/i386: Add notes for versioned CPU models
Date: Mon,  2 Dec 2019 14:28:51 +0800
Message-Id: <20191202062852.27948-5-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191202062852.27948-2-tao3.xu@intel.com>
References: <20191202062852.27948-2-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
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
 target/i386/cpu.c | 50 +++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7b3bd6d4db..c82fbfd02e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2281,10 +2281,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
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
@@ -2362,10 +2361,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
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
@@ -2448,10 +2446,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
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
@@ -2540,10 +2537,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
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
@@ -2637,17 +2633,18 @@ static X86CPUDefinition builtin_x86_defs[] = {
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
@@ -2658,21 +2655,18 @@ static X86CPUDefinition builtin_x86_defs[] = {
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
@@ -2768,35 +2762,33 @@ static X86CPUDefinition builtin_x86_defs[] = {
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
@@ -2896,17 +2888,17 @@ static X86CPUDefinition builtin_x86_defs[] = {
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
@@ -3017,19 +3009,19 @@ static X86CPUDefinition builtin_x86_defs[] = {
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
@@ -3141,6 +3133,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .versions = (X86CPUVersionDefinition[]) {
             { .version = 1 },
             { .version = 2,
+              .note = "ARCH_CAPABILITIES",
               .props = (PropValue[]) {
                   { "arch-capabilities", "on" },
                   { "rdctl-no", "on" },
@@ -3152,6 +3145,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             },
             { .version = 3,
               .alias = "Cascadelake-Server-noTSX",
+              .note = "no TSX",
               .props = (PropValue[]) {
                   { "hle", "off" },
                   { "rtm", "off" },
@@ -3264,6 +3258,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
+                .note = "no TSX",
                 .alias = "Icelake-Client-noTSX",
                 .props = (PropValue[]) {
                     { "hle", "off" },
@@ -3381,6 +3376,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
+                .note = "no TSX",
                 .alias = "Icelake-Server-noTSX",
                 .props = (PropValue[]) {
                     { "hle", "off" },
@@ -3488,6 +3484,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
+                .note = "no MPX, no MONITOR",
                 .props = (PropValue[]) {
                     { "monitor", "off" },
                     { "mpx", "off" },
@@ -3617,14 +3614,15 @@ static X86CPUDefinition builtin_x86_defs[] = {
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
@@ -3746,6 +3744,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
+                .note = "no MONITOR",
                 .props = (PropValue[]) {
                     { "monitor", "off" },
                     { /* end of list */ },
@@ -3870,15 +3869,15 @@ static X86CPUDefinition builtin_x86_defs[] = {
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
@@ -3941,6 +3940,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
+                .note = "no MONITOR",
                 .props = (PropValue[]) {
                     { "monitor", "off" },
                     { /* end of list */ },
-- 
2.20.1


