Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390D9CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AEB420679
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AEB420679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOz5G-0002is-8p
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 03:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iOz1J-0006q4-DL
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iOz1E-0006fv-EB
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:00:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61668
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iOz1E-0006Zk-97
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:00:48 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9S6qgjo122463
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 03:00:41 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vwpep7chm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 03:00:41 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@kaod.org>;
 Mon, 28 Oct 2019 07:00:39 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 28 Oct 2019 07:00:35 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x9S70YP442664312
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Oct 2019 07:00:34 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24AE6AE063;
 Mon, 28 Oct 2019 07:00:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07335AE04D;
 Mon, 28 Oct 2019 07:00:34 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 28 Oct 2019 07:00:33 +0000 (GMT)
Received: from yukon.kaod.org.com (sig-9-145-44-156.uk.ibm.com [9.145.44.156])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id 63FA12201D3;
 Mon, 28 Oct 2019 08:00:33 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v2 1/2] ipmi: Add support to customize OEM functions
Date: Mon, 28 Oct 2019 08:00:26 +0100
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028070027.22752-1-clg@kaod.org>
References: <20191028070027.22752-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19102807-0008-0000-0000-000003284411
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102807-0009-0000-0000-00004A47807C
Message-Id: <20191028070027.22752-2-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-28_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910280068
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x9S6qgjo122463
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: Corey Minyard <cminyard@mvista.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The routine ipmi_register_oem_netfn() lets external modules register
command handlers for OEM functions. Required for the PowerNV machine.

Cc: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

Changed in v2:

 - export IPMI_BMC_SIMULATOR()
 - export ipmi_register_netfn as ipmi_sim_register_netfn=20

 include/hw/ipmi/ipmi.h | 42 +++++++++++++++++++++++++++++++++++
 hw/ipmi/ipmi_bmc_sim.c | 50 +++++-------------------------------------
 2 files changed, 48 insertions(+), 44 deletions(-)

diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index 6f2413b39b4a..8a99d958bbc3 100644
--- a/include/hw/ipmi/ipmi.h
+++ b/include/hw/ipmi/ipmi.h
@@ -55,6 +55,7 @@ enum ipmi_op {
 #define IPMI_CC_COMMAND_NOT_SUPPORTED                    0xd5
=20
 #define IPMI_NETFN_APP                0x06
+#define IPMI_NETFN_OEM                0x3a
=20
 #define IPMI_DEBUG 1
=20
@@ -265,4 +266,45 @@ int ipmi_bmc_sdr_find(IPMIBmc *b, uint16_t recid,
                       const struct ipmi_sdr_compact **sdr, uint16_t *nex=
trec);
 void ipmi_bmc_gen_event(IPMIBmc *b, uint8_t *evt, bool log);
=20
+#define TYPE_IPMI_BMC_SIMULATOR "ipmi-bmc-sim"
+#define IPMI_BMC_SIMULATOR(obj) OBJECT_CHECK(IPMIBmcSim, (obj), \
+                                        TYPE_IPMI_BMC_SIMULATOR)
+
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
+int ipmi_sim_register_netfn(IPMIBmcSim *s, unsigned int netfn,
+                            const IPMINetfn *netfnd);
+
 #endif
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 71e56f3b13d1..6670cf039d1a 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -167,32 +167,14 @@ typedef struct IPMISensor {
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
     uint8_t buf[MAX_IPMI_MSG_SIZE];
 } IPMIRcvBufEntry;
=20
-#define TYPE_IPMI_BMC_SIMULATOR "ipmi-bmc-sim"
-#define IPMI_BMC_SIMULATOR(obj) OBJECT_CHECK(IPMIBmcSim, (obj), \
-                                        TYPE_IPMI_BMC_SIMULATOR)
 struct IPMIBmcSim {
     IPMIBmc parent;
=20
@@ -279,28 +261,8 @@ struct IPMIBmcSim {
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
@@ -630,8 +592,8 @@ static void ipmi_init_sensors_from_sdrs(IPMIBmcSim *s=
)
     }
 }
=20
-static int ipmi_register_netfn(IPMIBmcSim *s, unsigned int netfn,
-                               const IPMINetfn *netfnd)
+int ipmi_sim_register_netfn(IPMIBmcSim *s, unsigned int netfn,
+                        const IPMINetfn *netfnd)
 {
     if ((netfn & 1) || (netfn >=3D MAX_NETFNS) || (s->netfns[netfn / 2])=
) {
         return -1;
@@ -1860,10 +1822,10 @@ static const IPMINetfn storage_netfn =3D {
=20
 static void register_cmds(IPMIBmcSim *s)
 {
-    ipmi_register_netfn(s, IPMI_NETFN_CHASSIS, &chassis_netfn);
-    ipmi_register_netfn(s, IPMI_NETFN_SENSOR_EVENT, &sensor_event_netfn)=
;
-    ipmi_register_netfn(s, IPMI_NETFN_APP, &app_netfn);
-    ipmi_register_netfn(s, IPMI_NETFN_STORAGE, &storage_netfn);
+    ipmi_sim_register_netfn(s, IPMI_NETFN_CHASSIS, &chassis_netfn);
+    ipmi_sim_register_netfn(s, IPMI_NETFN_SENSOR_EVENT, &sensor_event_ne=
tfn);
+    ipmi_sim_register_netfn(s, IPMI_NETFN_APP, &app_netfn);
+    ipmi_sim_register_netfn(s, IPMI_NETFN_STORAGE, &storage_netfn);
 }
=20
 static uint8_t init_sdrs[] =3D {
--=20
2.21.0


