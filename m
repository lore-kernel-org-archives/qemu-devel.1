Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74185C83009
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:20:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B9B82082E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9B82082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTTuK-0005kH-3F
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 13:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jTTt3-00042B-2x
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:19:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jTTt2-0003aO-Cz
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:19:12 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:37229
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frederic.konrad@adacore.com>)
 id 1jTTt1-0003a3-Oj
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:19:12 -0400
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id F009681368;
 Tue, 28 Apr 2020 19:19:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3zGTUQVAmWZJ; Tue, 28 Apr 2020 19:19:09 +0200 (CEST)
Received: from localhost.localdomain.localdomain
 (lfbn-tou-1-1471-22.w90-89.abo.wanadoo.fr [90.89.4.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id A558B81343;
 Tue, 28 Apr 2020 19:19:09 +0200 (CEST)
From: KONRAD Frederic <frederic.konrad@adacore.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] m68k fpu fixes
Date: Tue, 28 Apr 2020 19:17:56 +0200
Message-Id: <1588094279-17913-1-git-send-email-frederic.konrad@adacore.com>
X-Mailer: git-send-email 1.8.3.1
Received-SPF: pass client-ip=194.98.77.210;
 envelope-from=frederic.konrad@adacore.com; helo=smtp.eu.adacore.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 12:46:33
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Received-From: 194.98.77.210
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
Cc: philmd@redhat.com, frederic.konrad@adacore.com, alex.bennee@linaro.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here are two fixes for the m68k targets:
  - the first one implements a fix about infinity handling when converting
    it from extended format to double or single format.
  - the second fixes the length of the floating points registers for GDB.

Changes:
  * target/m68k/cpu.c: created DEFINE_M68K_CPU_TYPE_CF and dropped
                       DEFINE_M68K_CPU_TYPE_WITH_CLASS (Suggested by Laurent)
  * target/m68k/cpu.c: reworked DEFINE_M68K_CPU_TYPE_* to guess the
                       cpu_initfn from the cpu_model (Suggested by Laurent).

Cheers,
Fred

KONRAD Frederic (2):
  softfloat: m68k: infinity is a valid encoding
  target/m68k: fix gdb for m68xxx

 configure               |  2 +-
 gdb-xml/m68k-core.xml   | 29 +++++++++++++++++++++++++++
 include/fpu/softfloat.h |  5 +++++
 target/m68k/cpu.c       | 52 +++++++++++++++++++++++++++++++++++--------------
 4 files changed, 72 insertions(+), 16 deletions(-)
 create mode 100644 gdb-xml/m68k-core.xml

-- 
1.8.3.1


