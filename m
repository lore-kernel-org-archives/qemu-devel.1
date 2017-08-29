Received: from eggs.gnu.org ([2001:4830:134:3::10]:47479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCA-0000sv-Fh
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUC7-00058n-7D
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52440
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUC6-000585-Sp
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:51 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E9l5081535
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:50 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmurncr6b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:50 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:15:49 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:13:52 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1503965694-10794-18-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 17/79] s390x: Drop useless casts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Eric Blake <eblake@redhat.com>

An upcoming Coccinelle cleanup script wanted to reformat the casts
present in this file - but on closer look, we don't need the casts
at all because C automatically converts void* to any other pointer.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170405194741.18956-4-eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
(cherry picked from commit cb55c19a26d6928b445f1bd9394843c9eb60f8ab)
* prereq for 46f5ac2
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/s390x/cpu_models.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 1434d15..ce461cc 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -376,12 +376,12 @@ static void cpu_model_from_info(S390CPUModel *model=
, const CpuModelInfo *info,
=20
 static void qdict_add_disabled_feat(const char *name, void *opaque)
 {
-    qdict_put((QDict *) opaque, name, qbool_from_bool(false));
+    qdict_put(opaque, name, qbool_from_bool(false));
 }
=20
 static void qdict_add_enabled_feat(const char *name, void *opaque)
 {
-    qdict_put((QDict *) opaque, name, qbool_from_bool(true));
+    qdict_put(opaque, name, qbool_from_bool(true));
 }
=20
 /* convert S390CPUDef into a static CpuModelInfo */
--=20
2.7.4
