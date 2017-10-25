Received: from eggs.gnu.org ([2001:4830:134:3::10]:50562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e7Myb-0004fC-TF
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 10:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e7MyX-0002xd-UJ
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 10:48:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e7MyX-0002wV-Ld
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 10:48:09 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9PElp2G004338
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 10:48:06 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dtsf7u5p4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 10:48:06 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 25 Oct 2017 08:48:05 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 25 Oct 2017 10:47:54 -0400
In-Reply-To: <1508942875-21557-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1508942875-21557-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1508942875-21557-5-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 4/5] vl: remove unnecessary #ifdef CONFIG_TPM
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

a stub is now provided.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 vl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/vl.c b/vl.c
index 0723835..ec29909 100644
--- a/vl.c
+++ b/vl.c
@@ -4624,11 +4624,9 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
=20
-#ifdef CONFIG_TPM
     if (tpm_init() < 0) {
         exit(1);
     }
-#endif
=20
     /* init the bluetooth world */
     if (foreach_device_config(DEV_BT, bt_parse))
--=20
2.5.5
