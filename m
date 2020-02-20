Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38849C3404C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:17:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 026E52465D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="bo12wa0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026E52465D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4dHf-00081c-7d
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 23:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j4dBg-0004JU-Up
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j4dBf-0005wb-PG
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:44 -0500
Received: from mail-co1nam11on2100.outbound.protection.outlook.com
 ([40.107.220.100]:28052 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j4dBf-0005wA-Ia
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2lOCpZbsnHYt/f7pV+tBHZCafFywvcwfg16VYKcrokf27L/owHK472yclZRXHmX1st+72xZtcrIsdfdzh8ijjjF/MWRpcepjt2+WQdC7AMyp6vEhsHDVT7nA/KQr1kvFNJVc93wiLLRjOB0SY3RVm+ThIwppofLC3uE+cDTJp+vQMnV/DScT0FLEVvd+HByeT6YJXF3j9ytWp7TU5Q4dWWV4snqBxcR2wGidz5Jj6fADxedNrzKob3IN6F5MG6se/uW1knIL1leSRaOWLNhGcaWDegL3SDck5XTMLI8kWwTndgpA8NHwZ9IF33uuQAJpNeShvflDYri7TgQyh7QQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goly2KFe2NOHvsA91zydmIJwU8zGRnCN1dYcNEwsMPM=;
 b=ZAuOGveLo6fGjvcCztysCwdrEgGTM8JIKpziuqy7/tqIy7GbMGNseu8vsVCc9YgOnynG02ZmPO0oR3C3iTkLO81NgjGtMvB9/I4XKAQoDyzzWuNQQYO+H0slE/6EYBQiaIiYALwo6s/hsvdvIA5JtmZsIhxaCY7MFpojpgZF/+CFN/sqs5BPya0ZL7Q85p1XY+Sos7gFRo6nhWDpiNeteSxoH6vwWn6Qe7Dbg8+rkp89BLQiw90l322bpX5OobGoDTxfvpMegEZ4VzvlOHOmtHfGNuSvMpv9pqZGeQn00+QzBMaJC4Uvh9LNiArLeXjpaFLCU5mWNgfbwQ5q2Twdxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goly2KFe2NOHvsA91zydmIJwU8zGRnCN1dYcNEwsMPM=;
 b=bo12wa0+eBAYi9QeV12v5JBFeIMF7f6kC6Aa39PSUFrbNdaVjG4sJ1zZ7mnsHD+THFH2qBg1CSN2vgFFFbsacCWZSlJI8KDZl4Y6Zv0qbobX8/NfwkQ+1Fgw0iW3Uwhj47kQC47XezNYzUC9ULXrISNHFad6d6KXV6FWRnfy4E4=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3807.namprd03.prod.outlook.com (2603:10b6:805:6a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Thu, 20 Feb
 2020 04:11:42 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 04:11:42 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 07/22] libqtest: make bufwrite rely on the TransportOps
Date: Wed, 19 Feb 2020 23:11:03 -0500
Message-ID: <20200220041118.23264-8-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220041118.23264-1-alxndr@bu.edu>
References: <20200220041118.23264-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0048.prod.exchangelabs.com
 (2603:10b6:208:25::25) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR0102CA0048.prod.exchangelabs.com (2603:10b6:208:25::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 04:11:41 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a4ffea2-24de-47a9-a293-08d7b5bafdaf
X-MS-TrafficTypeDiagnostic: SN6PR03MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB38076A117B803778AD70868BBA130@SN6PR03MB3807.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(36756003)(86362001)(81166006)(75432002)(8676002)(2616005)(478600001)(81156014)(8936002)(66476007)(5660300002)(6916009)(66556008)(66946007)(54906003)(956004)(316002)(786003)(6486002)(6666004)(7696005)(16526019)(186003)(26005)(4326008)(1076003)(2906002)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3807;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yDZt2m0HQujQ0S9oAvk+6UN97KVZyGK14Z0p7FCMU+qt8UmSLM0GYumTWHHOrjanNEe8PtEiifDn0mnYlJgeNzAx3x4ta7iAAcaFlEa57f86zUvqEnylWeoD3Z0RtfySRxPTyeeif9Y3Zwdz+EDvOcGjwPvXvtPcTFzAWCE5x21LPITSlPQBvsSjOvjS9LCvsL5g5YprtrIHC0aToj8+JDbLJ+6t3sor2ZrUkHzIPcfXiPQG8Pb3X+MthtueE81hcz9gR7dqJPIwOSfBUZ58EunpLS4BctltUPCMmkcKD8uvPT0mRrVsEeslsFQP7bNj9iS5G2FHkQjR4xFkkmjjvtK3hcO1mhZw+GJJecu/OnfWm1b7cax+7BZ4erGYhdYwpg3AFy2ViH+bnIgWIK46tgGHtLcOKFW3PLNAwmM/bkTeXJXPZW5Siewnm5fL4Rbg
X-MS-Exchange-AntiSpam-MessageData: /3XKUdfwdoXf3erWnYhSBHQFl8F1pPCjfqeOft0+WEGNKCnepQtLOVaNJVzW2AA/rRLO52C4ZNBTLKLdbWf/9q4U/fbZVaWq9BC6LEUUtxaUUIXsMqjvPr9pNZMwyWUfvbMDkz06UfLN6/93nR6gEQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4ffea2-24de-47a9-a293-08d7b5bafdaf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 04:11:42.3083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHWDImXva3CaUHGfEklS8hrAU20FUkG4dsbLMofQcU8WWPjC5Hw0PNBGV/kvjNku
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3807
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.100
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


