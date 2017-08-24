Received: from eggs.gnu.org ([2001:4830:134:3::10]:49225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkqrT-0004IJ-BR
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkqrO-00026z-Bf
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:03:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkqrO-00026n-5c
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:03:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2709F5F7AD
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 12:03:41 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Aug 2017 14:02:58 +0200
Message-Id: <1503576178-23966-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1503576178-23966-1-git-send-email-armbru@redhat.com>
References: <1503576178-23966-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] qapi-schema: Rocker doc section contains
 unrelated stuff, fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

Bug: section "Rocker switch device" starts with the rocker stuff, but
then has unrelated stuff, like ReplayMode, xen-load-devices-state, ...

Cause: rocker.json is included in the middle of section "QMP commands".

Fix: include it in a sane place, namely next to the other sub-schemas.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi-schema.json | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 76b5888..81cef23 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -82,6 +82,7 @@
 { 'include': 'qapi/crypto.json' }
 { 'include': 'qapi/block.json' }
 { 'include': 'qapi/event.json' }
+{ 'include': 'qapi/rocker.json' }
 { 'include': 'qapi/trace.json' }
 { 'include': 'qapi/introspect.json' }
 
@@ -6273,9 +6274,6 @@
 ##
 { 'command': 'rtc-reset-reinjection' }
 
-# Rocker ethernet network switch
-{ 'include': 'qapi/rocker.json' }
-
 ##
 # @ReplayMode:
 #
-- 
2.7.5
