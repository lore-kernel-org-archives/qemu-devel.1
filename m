Received: from eggs.gnu.org ([209.51.188.92]:35837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghbLP-0003np-89
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:30:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghbLO-0005kc-EQ
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:30:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ghbLO-0005j0-7c
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:30:02 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 10 Jan 2019 12:29:47 -0200
Message-Id: <20190110142955.23254-3-ehabkost@redhat.com>
In-Reply-To: <20190110142955.23254-1-ehabkost@redhat.com>
References: <20190110142955.23254-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 02/10] Update that HMP 'cpu-add' is deprecated
 in 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Kashyap Chamarthy <kchamart@redhat.com>

From: Kashyap Chamarthy <kchamart@redhat.com>

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
Message-Id: <20181213124224.31585-3-kchamart@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
[ehabkost: revert back to 'cpu-add' spelling]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qemu-deprecated.texi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 3f30f05a61..f4a5cea62b 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -113,7 +113,7 @@ replaced by the ``target'' output member.
 The @option{[hub_id name]} parameter tuple of the 'hostfwd_add' and
 'hostfwd_remove' HMP commands has been replaced by @option{netdev_id}.
 
-@subsection cpu-add (since 3.1)
+@subsection cpu-add (since 4.0)
 
 Use ``device_add'' for hotplugging vCPUs instead of ``cpu-add''.  See
 documentation of ``query-hotpluggable-cpus'' for additional details.
-- 
2.18.0.rc1.1.g3f1ff2140
