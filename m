Received: from eggs.gnu.org ([2001:4830:134:3::10]:34017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gH9Kw-0007sL-6g
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gH9Kr-00033X-Kx
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gH9Kr-00032a-7V
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:09 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9TFJHQG016737
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 11:20:08 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ne2dyyx36-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 11:20:07 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Mon, 29 Oct 2018 11:20:06 -0400
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Mon, 29 Oct 2018 11:19:56 -0400
In-Reply-To: <20181029151956.2164336-1-stefanb@linux.ibm.com>
References: <20181029151956.2164336-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20181029151956.2164336-6-stefanb@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 5/5] tpm: Zero-init structure to avoid
 uninitialized variables in valgrind log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>

From: Stefan Berger <stefanb@linux.vnet.ibm.com>

Zero-init the ptm_loc structure so that we don't have fields that
are not initialised.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/tpm/tpm_emulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 10bc20dbec..968f06ae3b 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -158,7 +158,7 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm=
_emu,
 static int tpm_emulator_set_locality(TPMEmulator *tpm_emu, uint8_t locty=
_number,
                                      Error **errp)
 {
-    ptm_loc loc;
+    ptm_loc loc =3D { 0 };
=20
     if (tpm_emu->cur_locty_number =3D=3D locty_number) {
         return 0;
--=20
2.17.1
