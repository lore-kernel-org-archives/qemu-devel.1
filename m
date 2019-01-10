Received: from eggs.gnu.org ([209.51.188.92]:35814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghbLN-0003m0-F7
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:30:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghbLM-0005iF-Ha
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:30:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ghbLM-0005ho-6t
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:30:00 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 10 Jan 2019 12:29:46 -0200
Message-Id: <20190110142955.23254-2-ehabkost@redhat.com>
In-Reply-To: <20190110142955.23254-1-ehabkost@redhat.com>
References: <20190110142955.23254-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 01/10] qemu-deprecated.texi: Rename the HMP
 section
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

So that it is consistent with the naming of QMP's

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
Message-Id: <20181213124224.31585-2-kchamart@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qemu-deprecated.texi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index c3735b698e..3f30f05a61 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -106,7 +106,7 @@ The ``query-cpus'' command is replaced by the ``query-cpus-fast'' command.
 The ``arch'' output member of the ``query-cpus-fast'' command is
 replaced by the ``target'' output member.
 
-@section System emulator human monitor commands
+@section Human Monitor Protocol (HMP) commands
 
 @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (since 3.1)
 
-- 
2.18.0.rc1.1.g3f1ff2140
