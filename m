Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D02EC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 05:11:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55EB020724
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 05:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EB020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGbqu-00033h-Fg
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 01:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1jGbq6-0002Ke-TI
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1jGbq3-0008Rm-Rl
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:10:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:44267)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1jGbq3-0008Q2-JL
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:10:55 -0400
IronPort-SDR: toyFCi9dFKIZXWJmlCjjyIzU+PbuPQ6r55+IFHBeRjFQYoz8yN8Czwwk60Opta7PJ/HDza1Srn
 GEx1JCeoe3ZA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2020 22:10:47 -0700
IronPort-SDR: w9Na5totU11x2FYhWXxJ8GrCngXlbKZi5cLbTzKkdyrBa2crI9nx+VBseXyicn7baR7bZohp6X
 mTMoeQjqc0Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,299,1580803200"; d="scan'208";a="270216386"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.45])
 by fmsmga004.fm.intel.com with ESMTP; 23 Mar 2020 22:10:46 -0700
From: Tao Xu <tao3.xu@intel.com>
To: ehabkost@redhat.com
Subject: [PATCH v4] target/i386: Add notes for versioned CPU models
Date: Tue, 24 Mar 2020 13:10:34 +0800
Message-Id: <20200324051034.30541-1-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.93
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
Cc: pbonzini@redhat.com, tao3.xu@intel.com, qemu-devel@nongnu.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add which features are added or removed in this version.

Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

The output is as follows:
qemu-system-x86_64 -cpu help | grep "\["
x86 Cascadelake-Server-v2  Intel Xeon Processor (Cascadelake) [ARCH_CAPABILITIES]
x86 Cascadelake-Server-v3  Intel Xeon Processor (Cascadelake) [ARCH_CAPABILITIES, no TSX]
x86 Denverton-v2          Intel Atom Processor (Denverton) [no MPX, no MONITOR]
x86 Icelake-Client-v2     Intel Core Processor (Icelake) [no TSX]
x86 Icelake-Server-v2     Intel Xeon Processor (Icelake) [no TSX]

Changes in v3:
    - Keep the existing custom model-id (Eduardo)

Changes in v2:
    - correct the note of Cascadelake v3 (Xiaoyao)
---
 target/i386/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 34b511f078..1c7690baa0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3192,6 +3192,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .versions = (X86CPUVersionDefinition[]) {
             { .version = 1 },
             { .version = 2,
+              .note = "ARCH_CAPABILITIES",
               .props = (PropValue[]) {
                   { "arch-capabilities", "on" },
                   { "rdctl-no", "on" },
@@ -3203,6 +3204,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             },
             { .version = 3,
               .alias = "Cascadelake-Server-noTSX",
+              .note = "ARCH_CAPABILITIES, no TSX",
               .props = (PropValue[]) {
                   { "hle", "off" },
                   { "rtm", "off" },
@@ -3424,6 +3426,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
+                .note = "no TSX",
                 .alias = "Icelake-Client-noTSX",
                 .props = (PropValue[]) {
                     { "hle", "off" },
@@ -3541,6 +3544,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
+                .note = "no TSX",
                 .alias = "Icelake-Server-noTSX",
                 .props = (PropValue[]) {
                     { "hle", "off" },
@@ -3648,6 +3652,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
+                .note = "no MPX, no MONITOR",
                 .props = (PropValue[]) {
                     { "monitor", "off" },
                     { "mpx", "off" },
-- 
2.20.1


