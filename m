Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68124C282DD
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 00:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F10218DA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 00:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F10218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33595 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ6CP-0004c0-6X
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 20:55:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJ6Ac-0003Pg-4S
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJ64U-0008UA-FJ
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:47:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:22526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJ64U-0008SK-6q
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:47:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 Apr 2019 17:47:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,387,1549958400"; d="scan'208";a="318410819"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga005.jf.intel.com with ESMTP; 23 Apr 2019 17:47:30 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 08:46:56 +0800
Message-Id: <20190424004700.12766-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.115
Subject: [Qemu-devel] [PATCH 0/4] cleanup savevm
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
Cc: Wei Yang <richardw.yang@linux.intel.com>, dgilbert@redhat.com,
	quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190424004656.4ILF1m99JuXdgbtq1rRI7ySQB-f0wMFlbiORg78qDz0@z>

There are several trivial cleanup for savevm.

  * remove duplicate check
  * more restrict check
  * reorder load sequence
  * wrap several steps into qemu_loadvm_state_header

Wei Yang (4):
  migration/savevm: remove duplicate check of migration_is_blocked
  migration/savevm: use migration_is_blocked to validate
  migration/savevm: load_header before load_setup
  migration/savevm: wrap into qemu_loadvm_state_header()

 migration/savevm.c | 75 +++++++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 34 deletions(-)

-- 
2.19.1


