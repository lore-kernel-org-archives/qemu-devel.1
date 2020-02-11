Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C22C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:45:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B05D20659
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="EnVYpwM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B05D20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1cPh-0005Gt-MO
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 15:45:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j1cFx-0006WK-Qz
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j1cFu-0008KV-UY
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:40 -0500
Received: from mail-bn8nam11on2135.outbound.protection.outlook.com
 ([40.107.236.135]:55392 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j1cFu-0008Dh-Og
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHFGqdZY8cAd76aAXbthK57aUcrN7aJY9mML3SZFVhUTkwIbGagoLdmwSajOMfdZrRzWCSJx0kkbHt0ZygDQOMJ3Luh+aqeXYco3MWGAFZrEXV737wCBzPxoxroAxuNNX1KVYXbrSUKFhWjCumX8M/3RJTt8COoEDn4Jc0aTLE6f7kEhDVUL+v6yHscNnfgAXTgwRfvH2xSbsFzZ1861kBeHALQ01/V0n7dMbZGQzS3EKBOABHXOhz+KTu8bCQJV0kjCqJSKzm8X9H7y+5+r9XDjgx3pUXMCcr+2lVjpF7k38p2R7jj+8RAZ4le643gozh89di/RAuApXmxJeuqLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goly2KFe2NOHvsA91zydmIJwU8zGRnCN1dYcNEwsMPM=;
 b=K0seHL/7pS5xgg/vjsrU1/d+vCo1xgX/C3ySUvvzHM6WManbLfW4lVCQwpCJ3DsHauiykg6zQb9vh1TAdFWi50GzzdRU2PKOyuvCROxvJFKlFFo4edAmhSPORppiLaSTeh2Tl5LfQrWVtc4CjiiTpcnH/VImdTECvNZMTfuv/GoRbCjZ1STn4CMOmdbi6h7TbLqgms70GFgc1n6jLjKoGuRZST+pcAsY974s+03jXAVphn1c3DGmbhTNUs/tPTHhvNkyMkMoWGFT0NBsqWZPkQoblRjvYWePO91EbtzICrp6k2Ecn1U49kryrJCPUDG5F0uFbuh+j8444a9Rc9KFsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goly2KFe2NOHvsA91zydmIJwU8zGRnCN1dYcNEwsMPM=;
 b=EnVYpwM69I+4EdXfjfppma1twdJTrvBHPxctLJTXssKpeyzNDpEStEiP4Og8Ddv+5MZwW/nOh/hw3bwUDeHIJ+eA2zOQZTQJq5JSuwt3Xc4qdXlZXcRMQCuyEa6BJus5KwmwEW86BCa+LCvvUzBWMARGtuFpq73mukOv691RgSY=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB3599.namprd03.prod.outlook.com (52.135.87.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 20:35:29 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 20:35:29 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 08/23] libqtest: make bufwrite rely on the TransportOps
Date: Tue, 11 Feb 2020 15:34:55 -0500
Message-ID: <20200211203510.3534-9-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211203510.3534-1-alxndr@bu.edu>
References: <20200211203510.3534-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0124.namprd02.prod.outlook.com (2603:10b6:208:35::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 20:35:28 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee8c8e73-3548-4f5e-9cba-08d7af31eebf
X-MS-TrafficTypeDiagnostic: SN6PR03MB3599:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB35995B01A7FFE55A7CD78B84BA180@SN6PR03MB3599.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(199004)(189003)(36756003)(52116002)(7696005)(478600001)(6666004)(54906003)(316002)(786003)(8676002)(8936002)(956004)(2616005)(4326008)(81156014)(5660300002)(75432002)(1076003)(81166006)(2906002)(66556008)(66476007)(66946007)(6486002)(26005)(186003)(16526019)(86362001)(6916009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3599;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZZEZlrK/ciLNg5KfqlXGNI8fmoZa65YQEcXJUNv478L/B4PmKrOFDHbYnUWMcpx7hM8ry0b/3QgeltD4nazLTuJCkjEz1twNlsFUWi352TuNoaqmW7wNW2RFKsTmdAzLdrVGRhiWo7ME8P9mrijTAHBiOA//s63PmNanYJyJAwqp9XYmEsqekw/TscmGK54/JhSazucG5SqlTNpOfMWvkfl/64OzxPNCW6x/j7maHAavsW4xEF7EjRDLO7zLjexv4PCnS+lgYj/gMc4R5YM6Pmv2iZ3lnmdb9+LUWgrPA2eIDuiFqLuNGrtRMlyUCibB0K59PCu6z7oDqvaU9FR/1S020h4FHW4aL/fkkgp0cGdSm9NfDSNj5HvObFMxI4xwj5+I9nZVx6mfSxXQB6Hxs0y/CkYx9CD9Y+effjMHaClL826ffRwAtclICMBq9A4j
X-MS-Exchange-AntiSpam-MessageData: tQeVi3xNeD61mhUG2CPDPBIIcjKl7S0iXoJMftIy9msO+6qj2yupL3Re1/olVRtr/QkQeaXqIfqDqQ4/ZzVjSj0iB0YBMYoP7xp4/bWxT9IbtqbXaYAvwgHSTi105zT2tr1dJNbu0Z0OWy9G4Wmgvg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8c8e73-3548-4f5e-9cba-08d7af31eebf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 20:35:29.1846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvMTeKNbdhxQJh5YapghNIUVOSU8d7w52jf4L3KKujgaxN7CPZweXjSWCw4eIJrT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3599
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Received-From: 40.107.236.135
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 darren.kenny@oracle.com, Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When using qtest "in-process" communication, qtest_sendf directly calls
a function in the server (qtest.c). Previously, bufwrite used
socket_send, which bypasses the TransportOps enabling the call into
qtest.c. This change replaces the socket_send calls with ops->send,
maintaining the benefits of the direct socket_send call, while adding
support for in-process qtest calls.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 tests/qtest/libqtest.c | 71 ++++++++++++++++++++++++++++++++++++++++--
 tests/qtest/libqtest.h |  4 +++
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index e5056a1d0f..49075b55a1 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -37,10 +37,18 @@
=20
=20
 typedef void (*QTestSendFn)(QTestState *s, const char *buf);
+typedef void (*ExternalSendFn)(void *s, const char *buf);
 typedef GString* (*QTestRecvFn)(QTestState *);
=20
 typedef struct QTestClientTransportOps {
     QTestSendFn     send;      /* for sending qtest commands */
+
+    /*
+     * use external_send to send qtest command strings through functions w=
hich
+     * do not accept a QTestState as the first parameter.
+     */
+    ExternalSendFn  external_send;
+
     QTestRecvFn     recv_line; /* for receiving qtest command responses */
 } QTestTransportOps;
=20
@@ -1078,8 +1086,8 @@ void qtest_bufwrite(QTestState *s, uint64_t addr, con=
st void *data, size_t size)
=20
     bdata =3D g_base64_encode(data, size);
     qtest_sendf(s, "b64write 0x%" PRIx64 " 0x%zx ", addr, size);
-    socket_send(s->fd, bdata, strlen(bdata));
-    socket_send(s->fd, "\n", 1);
+    s->ops.send(s, bdata);
+    s->ops.send(s, "\n");
     qtest_rsp(s, 0);
     g_free(bdata);
 }
@@ -1367,3 +1375,62 @@ static void qtest_client_set_rx_handler(QTestState *=
s, QTestRecvFn recv)
 {
     s->ops.recv_line =3D recv;
 }
+/* A type-safe wrapper for s->send() */
+static void send_wrapper(QTestState *s, const char *buf)
+{
+    s->ops.external_send(s, buf);
+}
+
+static GString *qtest_client_inproc_recv_line(QTestState *s)
+{
+    GString *line;
+    size_t offset;
+    char *eol;
+
+    eol =3D strchr(s->rx->str, '\n');
+    offset =3D eol - s->rx->str;
+    line =3D g_string_new_len(s->rx->str, offset);
+    g_string_erase(s->rx, 0, offset + 1);
+    return line;
+}
+
+QTestState *qtest_inproc_init(QTestState **s, bool log, const char* arch,
+                    void (*send)(void*, const char*))
+{
+    QTestState *qts;
+    qts =3D g_new0(QTestState, 1);
+    *s =3D qts; /* Expose qts early on, since the query endianness relies =
on it */
+    qts->wstatus =3D 0;
+    for (int i =3D 0; i < MAX_IRQ; i++) {
+        qts->irq_level[i] =3D false;
+    }
+
+    qtest_client_set_rx_handler(qts, qtest_client_inproc_recv_line);
+
+    /* send() may not have a matching protoype, so use a type-safe wrapper=
 */
+    qts->ops.external_send =3D send;
+    qtest_client_set_tx_handler(qts, send_wrapper);
+
+    qts->big_endian =3D qtest_query_target_endianness(qts);
+
+    /*
+     * Set a dummy path for QTEST_QEMU_BINARY. Doesn't need to exist, but =
this
+     * way, qtest_get_arch works for inproc qtest.
+     */
+    gchar *bin_path =3D g_strconcat("/qemu-system-", arch, NULL);
+    setenv("QTEST_QEMU_BINARY", bin_path, 0);
+    g_free(bin_path);
+
+    return qts;
+}
+
+void qtest_client_inproc_recv(void *opaque, const char *str)
+{
+    QTestState *qts =3D *(QTestState **)opaque;
+
+    if (!qts->rx) {
+        qts->rx =3D g_string_new(NULL);
+    }
+    g_string_append(qts->rx, str);
+    return;
+}
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index c9e21e05b3..f5cf93c386 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -729,4 +729,8 @@ bool qtest_probe_child(QTestState *s);
  */
 void qtest_set_expected_status(QTestState *s, int status);
=20
+QTestState *qtest_inproc_init(QTestState **s, bool log, const char* arch,
+                    void (*send)(void*, const char*));
+
+void qtest_client_inproc_recv(void *opaque, const char *str);
 #endif
--=20
2.25.0


