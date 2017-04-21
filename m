Received: from eggs.gnu.org ([2001:4830:134:3::10]:40761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d1TBg-00018F-4w
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d1TBc-0000ga-VL
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:41:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47939
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d1TBc-0000gO-NO
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:41:00 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3L7crLi128260
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 03:41:00 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29xwu7f097-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 03:40:59 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 21 Apr 2017 08:40:58 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Fri, 21 Apr 2017 09:40:38 +0200
In-Reply-To: <20170421074038.774-1-cornelia.huck@de.ibm.com>
References: <20170421074038.774-1-cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20170421074038.774-12-cornelia.huck@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/11] s390x: Drop useless casts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Eric Blake <eblake@redhat.com>

An upcoming Coccinelle cleanup script wanted to reformat the casts
present in this file - but on closer look, we don't need the casts
at all because C automatically converts void* to any other pointer.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170405194741.18956-4-eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 target/s390x/cpu_models.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 1434d15315..ce461cc905 100644
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
2.11.0
