Received: from eggs.gnu.org ([209.51.188.92]:35883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghbLe-0003yf-8a
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:30:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghbLT-0005m9-B4
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:30:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ghbLT-0005lp-5w
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:30:07 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 10 Jan 2019 12:29:48 -0200
Message-Id: <20190110142955.23254-4-ehabkost@redhat.com>
In-Reply-To: <20190110142955.23254-1-ehabkost@redhat.com>
References: <20190110142955.23254-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 03/10] Mention that QMP 'cpu-add' will be
 deprecated
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
Message-Id: <20181213124224.31585-4-kchamart@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qemu-deprecated.texi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index f4a5cea62b..81de5fc019 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -106,6 +106,12 @@ The ``query-cpus'' command is replaced by the ``query-cpus-fast'' command.
 The ``arch'' output member of the ``query-cpus-fast'' command is
 replaced by the ``target'' output member.
 
+@subsection cpu-add (since 4.0)
+
+Use ``device_add'' for hotplugging vCPUs instead of ``cpu-add''.  See
+documentation of ``query-hotpluggable-cpus'' for additional
+details.
+
 @section Human Monitor Protocol (HMP) commands
 
 @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (since 3.1)
-- 
2.18.0.rc1.1.g3f1ff2140
