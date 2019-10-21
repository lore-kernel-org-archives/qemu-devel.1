Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C98FCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:20:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4D302089C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D302089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMXbw-0004s8-WD
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 09:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iMXUI-0005TA-Ow
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:12:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iMXUC-0003qC-EM
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:12:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iMXUA-0003oi-EO
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:12:36 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9LD8hTD132975
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:12:32 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vsd518q6c-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:12:32 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@kaod.org>;
 Mon, 21 Oct 2019 14:12:28 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 21 Oct 2019 14:12:25 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9LDCOPe42139832
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Oct 2019 13:12:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65E234203F;
 Mon, 21 Oct 2019 13:12:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 485EE4204C;
 Mon, 21 Oct 2019 13:12:24 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 21 Oct 2019 13:12:24 +0000 (GMT)
Received: from yukon.kaod.org.ibmuc.com (sig-9-145-86-58.uk.ibm.com
 [9.145.86.58])
 by smtp.tls.ibm.com (Postfix) with ESMTP id 8B53F22016B;
 Mon, 21 Oct 2019 15:12:23 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 2/5] ipmi: Add support to customize OEM functions
Date: Mon, 21 Oct 2019 15:12:12 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021131215.3693-1-clg@kaod.org>
References: <20191021131215.3693-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19102113-0012-0000-0000-0000035AF16C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102113-0013-0000-0000-0000219618A9
Message-Id: <20191021131215.3693-3-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-21_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910210128
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x9LD8hTD132975
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Corey Minyard <cminyard@mvista.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>,
 "Marty E . Plummer" <hanetzer@startmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The routine ipmi_register_oem_netfn() lets external modules register
command handlers for OEM functions. Required for the PowerNV machine.

Cc: Corey Minyard <cminyard@mvista.com>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ipmi/ipmi.h | 36 ++++++++++++++++++++++++++++++++++++
 hw/ipmi/ipmi_bmc_sim.c | 41 ++++++-----------------------------------
 2 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index 6f2413b39b4a..cb7203b06767 100644
--- a/include/hw/ipmi/ipmi.h
+++ b/include/hw/ipmi/ipmi.h
@@ -265,4 +265,40 @@ int ipmi_bmc_sdr_find(IPMIBmc *b, uint16_t recid,
                       const struct ipmi_sdr_compact **sdr, uint16_t *nex=
trec);
 void ipmi_bmc_gen_event(IPMIBmc *b, uint8_t *evt, bool log);
=20
+typedef struct IPMIBmcSim IPMIBmcSim;
+
+typedef struct RspBuffer {
+    uint8_t buffer[MAX_IPMI_MSG_SIZE];
+    unsigned int len;
+} RspBuffer;
+
+static inline void rsp_buffer_set_error(RspBuffer *rsp, uint8_t byte)
+{
+    rsp->buffer[2] =3D byte;
+}
+
+/* Add a byte to the response. */
+static inline void rsp_buffer_push(RspBuffer *rsp, uint8_t byte)
+{
+    if (rsp->len >=3D sizeof(rsp->buffer)) {
+        rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_TRUNCATED);
+        return;
+    }
+    rsp->buffer[rsp->len++] =3D byte;
+}
+
+typedef struct IPMICmdHandler {
+    void (*cmd_handler)(IPMIBmcSim *s,
+                        uint8_t *cmd, unsigned int cmd_len,
+                        RspBuffer *rsp);
+    unsigned int cmd_len_min;
+} IPMICmdHandler;
+
+typedef struct IPMINetfn {
+    unsigned int cmd_nums;
+    const IPMICmdHandler *cmd_handlers;
+} IPMINetfn;
+
+int ipmi_register_oem_netfn(IPMIBmc *b, const IPMINetfn *netfnd);
+
 #endif
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 71e56f3b13d1..770aace55b08 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -98,6 +98,7 @@
 #define IPMI_CMD_GET_SEL_TIME             0x48
 #define IPMI_CMD_SET_SEL_TIME             0x49
=20
+#define IPMI_NETFN_OEM                    0x3a
=20
 /* Same as a timespec struct. */
 struct ipmi_time {
@@ -167,23 +168,8 @@ typedef struct IPMISensor {
 #define MAX_SENSORS 20
 #define IPMI_WATCHDOG_SENSOR 0
=20
-typedef struct IPMIBmcSim IPMIBmcSim;
-typedef struct RspBuffer RspBuffer;
-
 #define MAX_NETFNS 64
=20
-typedef struct IPMICmdHandler {
-    void (*cmd_handler)(IPMIBmcSim *s,
-                        uint8_t *cmd, unsigned int cmd_len,
-                        RspBuffer *rsp);
-    unsigned int cmd_len_min;
-} IPMICmdHandler;
-
-typedef struct IPMINetfn {
-    unsigned int cmd_nums;
-    const IPMICmdHandler *cmd_handlers;
-} IPMINetfn;
-
 typedef struct IPMIRcvBufEntry {
     QTAILQ_ENTRY(IPMIRcvBufEntry) entry;
     uint8_t len;
@@ -279,28 +265,8 @@ struct IPMIBmcSim {
 #define IPMI_BMC_WATCHDOG_ACTION_POWER_DOWN      2
 #define IPMI_BMC_WATCHDOG_ACTION_POWER_CYCLE     3
=20
-struct RspBuffer {
-    uint8_t buffer[MAX_IPMI_MSG_SIZE];
-    unsigned int len;
-};
-
 #define RSP_BUFFER_INITIALIZER { }
=20
-static inline void rsp_buffer_set_error(RspBuffer *rsp, uint8_t byte)
-{
-    rsp->buffer[2] =3D byte;
-}
-
-/* Add a byte to the response. */
-static inline void rsp_buffer_push(RspBuffer *rsp, uint8_t byte)
-{
-    if (rsp->len >=3D sizeof(rsp->buffer)) {
-        rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_TRUNCATED);
-        return;
-    }
-    rsp->buffer[rsp->len++] =3D byte;
-}
-
 static inline void rsp_buffer_pushmore(RspBuffer *rsp, uint8_t *bytes,
                                        unsigned int n)
 {
@@ -640,6 +606,11 @@ static int ipmi_register_netfn(IPMIBmcSim *s, unsign=
ed int netfn,
     return 0;
 }
=20
+int ipmi_register_oem_netfn(IPMIBmc *b, const IPMINetfn *netfnd)
+{
+    return ipmi_register_netfn(IPMI_BMC_SIMULATOR(b), IPMI_NETFN_OEM, ne=
tfnd);
+}
+
 static const IPMICmdHandler *ipmi_get_handler(IPMIBmcSim *ibs,
                                               unsigned int netfn,
                                               unsigned int cmd)
--=20
2.21.0


