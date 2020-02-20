Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DF3C34031
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:14:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0DDD24658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="EhyQSqgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DDD24658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4dDs-00014e-3T
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 23:14:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j4dBf-0004I2-1b
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j4dBd-0005w0-T3
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:42 -0500
Received: from mail-co1nam11on2123.outbound.protection.outlook.com
 ([40.107.220.123]:19041 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j4dBd-0005uk-MS
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/+rSyJsFoO/0BzD9GwPqRV/hFNRywWRe4gxlPsQWbseK6AhieqfSFV+Cci+6OkH2V1v/YkFYNBSPidk++v0qDcOv+yTzx4M/lXDwvPamlHy4hoLS2YE5i3tUnGScuR/1fzkTa1PCQHaR3gHdnZtR6i6wFikzJDyn5/ttpl9GmpaHaKuJMHp/S7PUJJeDF0daaYq4qyC27w2gzSqFwJgf67Yt2YBT7KbPXEM85+meECZiSg7bE4rOULVqxIXwbt0jmghm6vaLEfURtDD0OD7rv3eSOrslTM+rGdY6slfwn8tLHOE68xmjufqXbjgb+O1R6K3w0jvqkhY/o2vBY4eaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBiT+0qsUNVdCJeGAm7aVIBl9MNXqasktQGcxSWQ3oM=;
 b=fZhFIMxxUqp4GzAItIESw6yL5UYKCajwcwZZg8mEUSlTIEfVKdhw4OydR2QS2Bxuu2jg3g4RDH4jd2Zp74iZv9X3reeyNfgKvnvRB/yocJBH40j+pn5SoDepBy9bYxi5vGREcRDPKNOJRnp9Jzr9yA0vGyBLIfE0qfxmyZ3kHCjIIypEtAM7fT1CWBgKWQ6LDthbp/yIvocPz1u261y0UzTJhvCd5FvoWNLUHvbdPi4rji0jq5MZSMuTtlCNMyGi0zN8Zg3NgqtiaU2615vI3nydYUnqf33UZpzkQDXZY/HP+DQ+L2nSPYXhJY4+0WW0apQVb8ZXKMGszyz0BLxk7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBiT+0qsUNVdCJeGAm7aVIBl9MNXqasktQGcxSWQ3oM=;
 b=EhyQSqgY25FIeJ9Ss5fiDwNY0iXfc9nSS7lnxMC4kZlRIz4UU3mjy1uxA2iaZ1dydGo8zllxp4JImp+urosUXYFoONhEgP0kwgS41jyk4yG7z4Fe3B1Fd6hFOiHfwfQWsavbioTPPSslBBjRkQMi0YgJqhrRINQ9TIxkuRZysag=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3807.namprd03.prod.outlook.com (2603:10b6:805:6a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Thu, 20 Feb
 2020 04:11:40 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 04:11:40 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 05/22] qtest: add qtest_server_send abstraction
Date: Wed, 19 Feb 2020 23:11:01 -0500
Message-ID: <20200220041118.23264-6-alxndr@bu.edu>
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
 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 04:11:39 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ace2543c-16d0-4212-ce1f-08d7b5bafc61
X-MS-TrafficTypeDiagnostic: SN6PR03MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB380731DC32E0314336CE0AF6BA130@SN6PR03MB3807.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
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
X-Microsoft-Antispam-Message-Info: tjwzZDNw5i3AcbGbryRHW+gfCalrsACY2pJNetXZus+wbWZM096rTclYPlvXaGDNDf7S5FDtMAasWAXXPNuW2xOdxkJ2jc8m7dsM/qMzl/Z4911gvreWmCllBWp2ZCT7k3Db9K4P4sMPa0BimMvq3yrD6ok/T2DXkqn4GwosL30rNM7ta3S9ZkLvkOOoSabReahBZ+ny4FofB5t8KgK/Uqu3jjrulwUGCbhfEA/tQWyauW/pyloQsux0bEZdoVkzD5V3o0Nb/mtZwvZ8Au4UiPs6zFmTszVEqoeTp3SaXN8Gq7f0JMMH6Z2lBvNLGRVReIdpLWJMvclloLyLcYrOmMQe1rVeU4zMDJDpNtZ1swub53S8q/yWSeSgP3nyGEXoJXZ4HfZ/e+uLBu9GRjTwT22fc5mTQsG2nWU8Thc5+u7azqdAnnzTX5toK7QWzMkd
X-MS-Exchange-AntiSpam-MessageData: IV5sMpPxiDVrx0I3tv7wZqW+v7FUNtxRVihmMa+i9gyFDy9r32pBAtvb5C+YXE4iQNyUbIpx9fi213VnIiE3EUKaoOQsj6nj270V3s4TGkbOOPdXAin9IV7wti6WaZFi8rV6w0JdmsNgciUx7hZ2Dw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ace2543c-16d0-4212-ce1f-08d7b5bafc61
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 04:11:40.1006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOQ370vmzdDJ0tzuwcS/R6/lk+4NZ2j0aghPAeO+iiAlwPwj1kd28i/SVslo36WY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3807
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.123
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

qtest_server_send is a function pointer specifying the handler used to
transmit data to the qtest client. In the standard configuration, this
calls the CharBackend handler, but now it is possible for other types of
handlers, e.g direct-function calls if the qtest client and server
exist within the same process (inproc)

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 include/sysemu/qtest.h |  3 +++
 qtest.c                | 18 ++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index 5ed09c80b1..e2f1047fd7 100644
--- a/include/sysemu/qtest.h
+++ b/include/sysemu/qtest.h
@@ -26,4 +26,7 @@ bool qtest_driver(void);
=20
 void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Er=
ror **errp);
=20
+void qtest_server_set_send_handler(void (*send)(void *, const char *),
+                                 void *opaque);
+
 #endif
diff --git a/qtest.c b/qtest.c
index 12432f99cf..938c3746d6 100644
--- a/qtest.c
+++ b/qtest.c
@@ -42,6 +42,8 @@ static GString *inbuf;
 static int irq_levels[MAX_IRQ];
 static qemu_timeval start_time;
 static bool qtest_opened;
+static void (*qtest_server_send)(void*, const char*);
+static void *qtest_server_send_opaque;
=20
 #define FMT_timeval "%ld.%06ld"
=20
@@ -228,8 +230,10 @@ static void GCC_FMT_ATTR(1, 2) qtest_log_send(const ch=
ar *fmt, ...)
     va_end(ap);
 }
=20
-static void do_qtest_send(CharBackend *chr, const char *str, size_t len)
+static void qtest_server_char_be_send(void *opaque, const char *str)
 {
+    size_t len =3D strlen(str);
+    CharBackend* chr =3D (CharBackend *)opaque;
     qemu_chr_fe_write_all(chr, (uint8_t *)str, len);
     if (qtest_log_fp && qtest_opened) {
         fprintf(qtest_log_fp, "%s", str);
@@ -238,7 +242,7 @@ static void do_qtest_send(CharBackend *chr, const char =
*str, size_t len)
=20
 static void qtest_send(CharBackend *chr, const char *str)
 {
-    do_qtest_send(chr, str, strlen(str));
+    qtest_server_send(qtest_server_send_opaque, str);
 }
=20
 static void GCC_FMT_ATTR(2, 3) qtest_sendf(CharBackend *chr,
@@ -783,6 +787,16 @@ void qtest_server_init(const char *qtest_chrdev, const=
 char *qtest_log, Error **
     qemu_chr_fe_set_echo(&qtest_chr, true);
=20
     inbuf =3D g_string_new("");
+
+    if (!qtest_server_send) {
+        qtest_server_set_send_handler(qtest_server_char_be_send, &qtest_ch=
r);
+    }
+}
+
+void qtest_server_set_send_handler(void (*send)(void*, const char*), void =
*opaque)
+{
+    qtest_server_send =3D send;
+    qtest_server_send_opaque =3D opaque;
 }
=20
 bool qtest_driver(void)
--=20
2.25.0


