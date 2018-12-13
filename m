Received: from eggs.gnu.org ([2001:4830:134:3::10]:48817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gXQKA-0004hI-03
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:42:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gXQK9-0002z0-Ak
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:42:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:21351)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1gXQK9-0002u2-3u
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:42:41 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 78822306B661
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 12:42:40 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
Date: Thu, 13 Dec 2018 13:42:23 +0100
Message-Id: <20181213124224.31585-3-kchamart@redhat.com>
In-Reply-To: <20181213124224.31585-1-kchamart@redhat.com>
References: <20181213124224.31585-1-kchamart@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] Update that HMP 'cpu_add' is deprecated in
 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, imammedo@redhat.com, thuth@redhat.com, Kashyap Chamarthy <kchamart@redhat.com>

Also fix the wrong spelling of it: s/cpu-add/cpu_add/

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
 qemu-deprecated.texi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 46bec688db..79743ab8bd 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -121,9 +121,9 @@ replaced by the ``target'' output member.
 The @option{[hub_id name]} parameter tuple of the 'hostfwd_add' and
 'hostfwd_remove' HMP commands has been replaced by @option{netdev_id}.
 
-@subsection cpu-add (since 3.1)
+@subsection cpu_add (since 4.0)
 
-Use ``device_add'' for hotplugging vCPUs instead of ``cpu-add''.  See
+Use ``device_add'' for hotplugging vCPUs instead of ``cpu_add''.  See
 documentation of ``query-hotpluggable-cpus'' for additional details.
 
 @section System emulator devices
-- 
2.17.2
