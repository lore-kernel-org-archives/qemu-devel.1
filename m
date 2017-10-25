Received: from eggs.gnu.org ([2001:4830:134:3::10]:50478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e7MyX-0004cS-32
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 10:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e7MyT-0002sg-2l
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 10:48:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46262
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e7MyS-0002s7-TN
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 10:48:05 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9PElGCC058636
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 10:48:01 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dtv2st5ws-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 10:48:01 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 25 Oct 2017 08:48:01 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 25 Oct 2017 10:47:51 -0400
In-Reply-To: <1508942875-21557-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1508942875-21557-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1508942875-21557-2-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 1/5] tpm: add missing include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

else file including "sysemu/tpm.h" fails to compile:

  In file included from qemu/stubs/tpm.c:2:0:
  qemu/include/sysemu/tpm.h:36:19: error: implicit declaration of functio=
n =E2=80=98object_resolve_path_type=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]
       Object *obj =3D object_resolve_path_type("", TYPE_TPM_TIS, NULL);
                     ^~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 include/sysemu/tpm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index c8afa17..d7a2bd8 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -13,6 +13,7 @@
 #define QEMU_TPM_H
=20
 #include "qemu/option.h"
+#include "qom/object.h"
=20
 typedef struct TPMState TPMState;
=20
--=20
2.5.5
