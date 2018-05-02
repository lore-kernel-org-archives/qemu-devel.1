Received: from eggs.gnu.org ([2001:4830:134:3::10]:45981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDvUa-0002rx-4C
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:24:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDvUW-00029L-RH
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:24:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59244 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fDvUW-00029F-Mj
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:24:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D711406C798
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 17:24:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  2 May 2018 19:24:25 +0200
Message-Id: <1525281868-24747-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1525281868-24747-1-git-send-email-thuth@redhat.com>
References: <1525281868-24747-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] qemu-options: Remove remainders of the
 -tdf option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The -tdf options has been removed with d07aa197c5a1556449361a0cbb5108e2,
but apparently I forgot to remove the corresponding two lines from
qemu-options.hx.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-options.hx | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index c611766..44daa10 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3924,9 +3924,6 @@ DEF("no-kvm-pit-reinjection", 0, QEMU_OPTION_no_kvm_pit_reinjection,
 HXCOMM Deprecated by -machine kernel_irqchip=on|off property
 DEF("no-kvm-irqchip", 0, QEMU_OPTION_no_kvm_irqchip, "", QEMU_ARCH_I386)
 
-HXCOMM Deprecated (ignored)
-DEF("tdf", 0, QEMU_OPTION_tdf,"", QEMU_ARCH_ALL)
-
 DEF("msg", HAS_ARG, QEMU_OPTION_msg,
     "-msg timestamp[=on|off]\n"
     "                change the format of messages\n"
-- 
1.8.3.1
