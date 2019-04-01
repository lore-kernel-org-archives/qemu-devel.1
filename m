Received: from eggs.gnu.org ([209.51.188.92]:41345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB455-0001oy-Ca
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB454-0003kJ-EY
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33542
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB454-0003ee-8E
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:58 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1pFq095672
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:47 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkswegyax-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:47 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:47 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:39 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190401210011.16009-66-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 65/97] fmops: fix off-by-one in AR_TABLE and
 DR_TABLE array size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, P J P <ppandit@redhat.com>

From: Gerd Hoffmann <kraxel@redhat.com>

Cc: P J P <ppandit@redhat.com>
Reported-by: Wangjunqing <wangjunqing@huawei.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20181030082340.17170-1-kraxel@redhat.com
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit 57ac4a7a28fef81b80b547c64d26681edc4a2cda)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/audio/fmopl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index e7e578a48e..e008e72d7a 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -72,8 +72,8 @@ typedef struct fm_opl_f {
 	/* Rhythm sention */
 	uint8_t rhythm;		/* Rhythm mode , key flag */
 	/* time tables */
-	int32_t AR_TABLE[75];	/* atttack rate tables */
-	int32_t DR_TABLE[75];	/* decay rate tables   */
+	int32_t AR_TABLE[76];	/* attack rate tables  */
+	int32_t DR_TABLE[76];	/* decay rate tables   */
 	uint32_t FN_TABLE[1024];  /* fnumber -> increment counter */
 	/* LFO */
 	int32_t *ams_table;
--=20
2.17.1
