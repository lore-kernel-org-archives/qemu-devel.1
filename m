Received: from eggs.gnu.org ([2001:4830:134:3::10]:42484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBr-0002pu-Sf
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBo-0001H8-Om
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54330
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBo-0001GX-II
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:28 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hbSu084814
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:28 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdme914v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:27 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:26 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:22 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1481762701-4587-29-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 28/67] migrate: Fix cpu-throttle-increment
 regression in HMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>

From: Eric Blake <eblake@redhat.com>

Commit 69ef1f3 accidentally broke migrate_set_parameter's ability
to set the cpu-throttle-increment to anything other than the
default, because it forgot to parse the user's string into an
integer.

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
(cherry picked from commit bb2b777cf9a2862fe31a40256659ff49ae3d2006)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hmp.c b/hmp.c
index cc2056e..bb45f7f 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1284,6 +1284,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const =
QDict *qdict)
                 break;
             case MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT:
                 has_cpu_throttle_increment =3D true;
+                use_int_value =3D true;
                 break;
             case MIGRATION_PARAMETER_TLS_CREDS:
                 has_tls_creds =3D true;
--=20
1.9.1
