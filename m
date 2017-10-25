Received: from eggs.gnu.org ([2001:4830:134:3::10]:50481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e7MyX-0004cV-3s
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 10:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e7MyT-0002sq-4O
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 10:48:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43896
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e7MyS-0002sH-Un
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 10:48:05 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9PEfO09001793
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 10:48:03 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dtua6d56m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 10:48:03 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 25 Oct 2017 08:48:02 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 25 Oct 2017 10:47:53 -0400
In-Reply-To: <1508942875-21557-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1508942875-21557-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1508942875-21557-4-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 3/5] tpm: remove unnecessary #ifdef CONFIG_TPM
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

Makefile.objs now checks for $(CONFIG_TPM).

Suggested-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 tpm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tpm.c b/tpm.c
index 45520f5..ab5d29e 100644
--- a/tpm.c
+++ b/tpm.c
@@ -30,8 +30,6 @@ void tpm_register_model(enum TpmModel model)
     tpm_models[model] =3D true;
 }
=20
-#ifdef CONFIG_TPM
-
 static const TPMBackendClass *
 tpm_be_find_by_type(enum TpmType type)
 {
@@ -192,8 +190,6 @@ int tpm_config_parse(QemuOptsList *opts_list, const c=
har *optarg)
     return 0;
 }
=20
-#endif /* CONFIG_TPM */
-
 /*
  * Walk the list of active TPM backends and collect information about th=
em
  * following the schema description in qapi-schema.json.
--=20
2.5.5
