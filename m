Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B878AC38BE1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 18:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93E4020838
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 18:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E4020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6IQk-0003Pu-PM
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 13:26:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sebastien.boeuf@intel.com>) id 1j6IQ6-0002yF-W6
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:25:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sebastien.boeuf@intel.com>) id 1j6IQ5-0006Mc-2g
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:25:30 -0500
Received: from mga06.intel.com ([134.134.136.31]:8901)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sebastien.boeuf@intel.com>)
 id 1j6IQ4-00063n-Ou
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:25:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Feb 2020 10:25:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,481,1574150400"; d="scan'208";a="229914978"
Received: from tjnagler-mobl.ger.corp.intel.com (HELO localhost.localdomain)
 ([10.252.27.40])
 by fmsmga007.fm.intel.com with ESMTP; 24 Feb 2020 10:25:17 -0800
From: Sebastien Boeuf <sebastien.boeuf@intel.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] docs: Update vhost-user spec regarding backend program
 conventions
Date: Mon, 24 Feb 2020 19:24:54 +0100
Message-Id: <20200224182454.24610-1-sebastien.boeuf@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
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
Cc: marcandre.lureau@redhat.com, sebastien.boeuf@intel.com, berrange@redhat.com,
 stefanha@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The vhost-user specification is not clearly stating the expected
behavior from a backend program whenever the client disconnects.

This patch addresses the issue by defining the default behavior and
proposing an alternative through a command line option.

By default, a backend program will terminate whenever the client
disconnects, unless told otherwise through the newly introduced
option --keep-listening.

Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/interop/vhost-user.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 5f8b3a456b..078f8e2e57 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -1323,6 +1323,10 @@ The backend program must end (as quickly and cleanly as possible) when
 the SIGTERM signal is received. Eventually, it may receive SIGKILL by
 the management layer after a few seconds.
 
+By default, the backend program terminates after the client disconnects.
+This is useful to keep the backend program's lifetime synchronized with
+its client process.
+
 The following command line options have an expected behaviour. They
 are mandatory, unless explicitly said differently:
 
@@ -1337,6 +1341,14 @@ are mandatory, unless explicitly said differently:
   vhost-user socket as file descriptor FDNUM. It is incompatible with
   --socket-path.
 
+--keep-listening
+
+  When this option is provided, the backend program must keep listening
+  after the client disconnects. It accepts only 1 connection at a time
+  on each UNIX domain socket. This prevents the management layer from
+  having to spawn a new backend program each and every time the client
+  disconnects.
+
 --print-capabilities
 
   Output to stdout the backend capabilities in JSON format, and then
-- 
2.20.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


