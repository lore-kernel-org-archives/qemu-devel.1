Received: from eggs.gnu.org ([2001:4830:134:3::10]:48827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkxa5-0006Sf-1D
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:14:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkxa2-00049a-BS
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:14:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkxa2-000495-5n
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:14:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 209FD13AAC
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 19:14:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Aug 2017 21:13:55 +0200
Message-Id: <1503602048-12268-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1503602048-12268-1-git-send-email-armbru@redhat.com>
References: <1503602048-12268-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 03/16] qapi-schema: Rocker doc section
 contains unrelated stuff, fix
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
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi-schema.json | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 3db3d19..add4777 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -81,6 +81,7 @@
 { 'include': 'qapi/common.json' }
 { 'include': 'qapi/crypto.json' }
 { 'include': 'qapi/block.json' }
+{ 'include': 'qapi/rocker.json' }
 { 'include': 'qapi/event.json' }
 { 'include': 'qapi/trace.json' }
 { 'include': 'qapi/introspect.json' }
@@ -6273,9 +6274,6 @@
 ##
 { 'command': 'rtc-reset-reinjection' }
=20
-# Rocker ethernet network switch
-{ 'include': 'qapi/rocker.json' }
-
 ##
 # @ReplayMode:
 #
--=20
2.7.5
