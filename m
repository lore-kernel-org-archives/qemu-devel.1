Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E28C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:44:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 893E620880
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="anZemNQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893E620880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iao3f-0002Ow-9Z
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 16:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1ianuc-00005A-Mt
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1ianuZ-0002oH-NE
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:48 -0500
Received: from mail-eopbgr740102.outbound.protection.outlook.com
 ([40.107.74.102]:45028 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1ianuZ-0002ik-IZ
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hhzc3KTUwbVNRmzu9JJHifUa7gTHDAJV2vBto3wSrSu5mfkMIIM5IPQhW3SHpmawspjsbPYLqDsho4J6qHfBADkwn9yuqa9bRYL514XFjSSKFNzkwELhbyp668jAak1yJJY//KkKPnLzFUnKf2PVNDvl1sjOFNsQzUXQsEYEiZlpmi3Wfk5Xas6+QWcxMiC5Hyus635Iu3MwY5LZii/4yuvhpD85eTpPA0YTcvCsr7i7USRPfjNm6zFkKP5Brk6YQ9h60z0x4w/1CXVSnKVo9My6dgK7m/HHQplTAyJSKpqVW4E+wklqwKT3Qr0pX4U/ESf/4Baylz1+RmUTgot8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxyYtCnh0jDMGD5U4MNPFhzgI9cNRH1r64lIbKgyztQ=;
 b=Qz1gc3TT41FkCsDxbGUFkenkrGGz1uWltxKqUtbfKiiyJk0WjghHg3NBO3wxA5wjbd9y6cdhp1qyVzK2N7eFnLbRVcRFutgzujUZ/+NPS2aaHXttcNSf7Xkk4wDcMB6Om4ojbeTVGlJ8ITPV5aa/uO3lg/a+LGG+d7HvufAPOZHhNc/4BJv50PRRf11E6D5SAscM5MjHkApMz8U9tbfJYcTUVCPRw0tjTqml4KqQ4lo70eEmRHOJgRNO5RYEZSxlip+6QUkqEat+FsFxdM27DKyhvsKX6GvBIHlgqxfvkabfVNAU8J4tg6St+DbxEWxfgvi1BeADfmEZHdb1IO/GCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxyYtCnh0jDMGD5U4MNPFhzgI9cNRH1r64lIbKgyztQ=;
 b=anZemNQcFsAZ4ZDWa9jIKZYoAJ3IydxrNyd+joPnpnNGdjbHgj4VTnO1r8USwFfzjYKL4097SiKnishXsS8ciGobpEqoxOHT3VOvIvcNnLT4yATPlkZHE586MMte1ikSgWeyu/KfM40juTUpqvV0MMq/0LwCPO6ZJpDSjRRSZFE=
Received: from DM6PR03MB4795.namprd03.prod.outlook.com (20.179.107.22) by
 DM6PR03MB5050.namprd03.prod.outlook.com (10.141.161.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 21:34:41 +0000
Received: from DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74]) by DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74%2]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 21:34:41 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v6 04/21] qtest: add qtest_server_send abstraction
Thread-Topic: [PATCH v6 04/21] qtest: add qtest_server_send abstraction
Thread-Index: AQHVpvzO30Syr3majEG6oA4HcTycLw==
Date: Fri, 29 Nov 2019 21:34:40 +0000
Message-ID: <20191129213424.6290-5-alxndr@bu.edu>
References: <20191129213424.6290-1-alxndr@bu.edu>
In-Reply-To: <20191129213424.6290-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR1501CA0025.namprd15.prod.outlook.com
 (2603:10b6:207:17::38) To DM6PR03MB4795.namprd03.prod.outlook.com
 (2603:10b6:5:18c::22)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20543cbd-3be4-46e6-1908-08d77513f110
x-ms-traffictypediagnostic: DM6PR03MB5050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB5050AB73282387D10971FE8BBA460@DM6PR03MB5050.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(54906003)(81156014)(81166006)(66066001)(6436002)(3846002)(8936002)(66946007)(6116002)(1076003)(66446008)(64756008)(66476007)(256004)(66556008)(316002)(786003)(8676002)(6512007)(102836004)(6486002)(478600001)(71190400001)(71200400001)(2351001)(86362001)(6506007)(14454004)(2501003)(75432002)(386003)(5640700003)(2906002)(6916009)(7736002)(2616005)(25786009)(26005)(52116002)(88552002)(99286004)(5660300002)(76176011)(186003)(446003)(11346002)(305945005)(50226002)(36756003)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR03MB5050;
 H:DM6PR03MB4795.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lvjqVulXNywI2pNK8b+x/Vh3OusE5HmlDFqRgubGQFJ027GlAK7QaXee9NlgwfEzsGHN6raZcsOytytgSAviTwoH1Bm/VNh1+Pi3RFjYrkV8Ad8WcJ/G76aj8DHUhzf5bdWZK3ZZnk7301jreyrC0i0ycRz+EShRbTgVJ0w3fNgNTh+rpClSKKIlEc9KWQmJjrC2UrJTGNAeNROa/d7+TEXxpNCqrWiMBkiuo8jwdhgSuOKJliYcXj8Lq22QE0E9CCrnUuZb8xab5VRv17XzsfuAzPWQPcf3id1tHnEIJwPXiKP1nJ7pEqWx14SV3a7V4pd+IxTWVMsdJs79NlLqeFoEmEsgJuXmvFtBCfeqW4kO1BuyrC578HNRT9hnFVPMmFyAzb3WbzSVjOTAuJCc3B4H/027sUUPMmMqMocXS8tokeGmmT5iqRczm7scfN3Y
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 20543cbd-3be4-46e6-1908-08d77513f110
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 21:34:40.8285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eTm79x8Rs7v3Fy7tZjZJ6X9wlG596WYIi6edrpQuKwtjUFkjorUrMgGiyaYgI/uH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5050
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.102
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
 "Oleinik, Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
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
index 8b50e2783e..58d7e2a6fb 100644
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
2.23.0


