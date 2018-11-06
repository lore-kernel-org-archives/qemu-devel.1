Received: from eggs.gnu.org ([2001:4830:134:3::10]:45129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gJtqG-0004FB-6s
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 00:23:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gJtqE-0006l3-EK
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 00:23:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gJtqE-0006ko-9L
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 00:23:54 -0500
From: P J P <ppandit@redhat.com>
Date: Tue,  6 Nov 2018 10:51:44 +0530
Message-Id: <20181106052144.31841-2-ppandit@redhat.com>
In-Reply-To: <20181106052144.31841-1-ppandit@redhat.com>
References: <20181106052144.31841-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] tpm: use loop iterator to set sts data
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

When TIS request is done, set 'sts' data field across all localities.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/tpm/tpm_tis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 20126dd838..58d90645bc 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -299,7 +299,7 @@ static void tpm_tis_request_completed(TPMIf *ti, int ret)
 
     if (s->cmd.selftest_done) {
         for (l = 0; l < TPM_TIS_NUM_LOCALITIES; l++) {
-            s->loc[locty].sts |= TPM_TIS_STS_SELFTEST_DONE;
+            s->loc[l].sts |= TPM_TIS_STS_SELFTEST_DONE;
         }
     }
 
-- 
2.17.2
