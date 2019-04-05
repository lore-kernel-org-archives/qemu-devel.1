Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0356EC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 06:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1FFD206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 06:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FFD206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36973 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCIZk-0004Se-Uv
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 02:43:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hCIY3-0003cW-1q
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hCIY2-0004Nn-9L
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:41:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:33225)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hCIY2-0004Lx-0H
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:41:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	04 Apr 2019 23:41:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,310,1549958400"; d="scan'208";a="288952742"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga004.jf.intel.com with ESMTP; 04 Apr 2019 23:41:54 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Apr 2019 14:41:17 +0800
Message-Id: <20190405064121.23662-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.31
Subject: [Qemu-devel] [PATCH v2 0/4] cleanup select_machine
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
Cc: pbonzini@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
	ehabkost@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190405064117.MWVU5rSyqHFKYL87rcxtU_5CedQywBOQ1s5c-cBmTug@z>

Here is two simple change related to select_machine()

[1]: make find_default_machine() local since no one outside file use it
[2]: allocate TYPE_MACHINE list only once to select machine type
[3]: cleanup after previous commit
[4]: Simplify machine_parse()

---
v2:
  * adjust changelog in [1]
  * Markus provides [3-4]

Markus Armbruster (2):
  vl: Clean up after previous commit
  vl: Simplify machine_parse()

Wei Yang (2):
  vl.c: make find_default_machine() local
  vl.c: allocate TYPE_MACHINE list once during bootup

 include/hw/boards.h |  1 -
 vl.c                | 69 ++++++++++++++++++---------------------------
 2 files changed, 28 insertions(+), 42 deletions(-)

-- 
2.19.1


