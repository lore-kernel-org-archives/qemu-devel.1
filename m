Received: from eggs.gnu.org ([209.51.188.92]:43315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB47g-0004KF-BB
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB47e-0005Tk-Lm
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB47c-00052T-CC
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:37 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4wW3140336
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:05:06 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksqasrg1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:05:05 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:03:06 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:57 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190401210011.16009-84-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 83/97] tpm: Zero-init structure to avoid
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
Cc: qemu-stable@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>

From: Stefan Berger <stefanb@linux.ibm.com>

Zero-init the ptm_loc structure so that we don't have fields that
are not initialised.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
(cherry picked from commit eff1fe9fd0cebe2293eea9597616f792b6b5ad18)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/tpm/tpm_emulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 10bc20dbec..70f4b10284 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -166,6 +166,7 @@ static int tpm_emulator_set_locality(TPMEmulator *tpm=
_emu, uint8_t locty_number,
=20
     trace_tpm_emulator_set_locality(locty_number);
=20
+    memset(&loc, 0, sizeof(loc));
     loc.u.req.loc =3D locty_number;
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_LOCALITY, &loc,
                              sizeof(loc), sizeof(loc)) < 0) {
--=20
2.17.1
