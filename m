Received: from eggs.gnu.org ([2001:4830:134:3::10]:44699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fGHbs-0003a7-3V
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fGHbp-0000LN-FE
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:25:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58684 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fGHbp-0000KD-B8
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:25:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DADDB430A693
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 05:20:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  9 May 2018 07:20:12 +0200
Message-Id: <1525843212-31922-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Add an entry for qemu-options*
 files in main directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

The file "qemu-options.h", "qemu-options.hx" and "qemu-options-wrapper.h"
in the main directory are currently without maintainer according to our
get_maintainers.pl script. Considering that the command line options are
a public interface and thus quite important, this is quite a bad state.
So I'd like to suggest to add these files to the "Command line option
argument parsing" section now.

And since I'm interested in the command line interface of QEMU, add
myself as reviewer here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e187b1f..6aa19dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1413,7 +1413,9 @@ F: chardev/baum.c
 
 Command line option argument parsing
 M: Markus Armbruster <armbru@redhat.com>
+R: Thomas Huth <thuth@redhat.com>
 S: Supported
+F: qemu-options*
 F: include/qemu/option.h
 F: tests/test-keyval.c
 F: tests/test-qemu-opts.c
-- 
1.8.3.1
