Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EBFC32750
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22AA20657
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="EbZOk+bF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22AA20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huX9q-0004ia-SG
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 03:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37203)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1huX98-00039y-Du
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1huX97-0001rT-CX
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:06 -0400
Received: from mail-eopbgr790111.outbound.protection.outlook.com
 ([40.107.79.111]:12064 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1huX97-0001qn-6z
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmeVWoRyrTS5zHlFwdWoQELBFaSnnzVMQlwBrsaptIGe7KfFX5HZyht3PRcwAWfbaiCN8AyJq7kUVPC6CqHWsHx5URPh7ghw0j7keEwV/7RflAvoBGxpQHwc7WaRZH28jumi4DkbM03CN0DXHOOa1wRSTFU6mkgfuQCnwS/cwXEVznSvG5jlry6bZhVyw08Atos0jcjSqYvwKZZULzCmMT/zYlUGFwizFU3RUqsXcXC88AyCmxpwYQk9mNzTYcmzRt0ONs5Gijpa3h+clCZ3TvjtyyKm3lYZA/+br/nseHkcs9s2wPXuXNNE+jhL3PEZaLrW+oaYvutrgIvDavHreA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xc2Nz4P+llAvkrm00k9L/WRKVfsUvVyJ5b/Y143C/8=;
 b=B67/nqGX7WyPSwtHrhxmru4jLI1Qm1UOiEMoMfhEGvCqyem+t5Avk7QC6tETmG/svzJckDmPCIscfl4rwejNv8jqzGeqwmcBJKetMIKgseNHINAzO8L7HGzJQuqihhzgBoFlnzwsEMDEBUKhH5bhBarcX2a557ZbaXAY+l1vf+7bBRKTcJNAwAt5qLc8jb0E+TkVGfcPtqGA9DUFSG9R3PrlC3Ydq1Qx244O8zfIrgTIXKhYxa5H4RIb6cJsSf+Owx8N14lZTYyjXNPVxOP+7mTrLSZU+NUwVb/PSYLjwY+59UBb+UXVeY3K2TLVWn7IrtLS7MGJ30KOst8bTz4zGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xc2Nz4P+llAvkrm00k9L/WRKVfsUvVyJ5b/Y143C/8=;
 b=EbZOk+bFBYowLEtE7xBWy3ue34T+eNWCYJAHGYiUByNE8vsZj301c/hfUZ3QAm662PSmqpz2Ch2ntVGDIcUn3KLU4TKX60Ym6tIy5ZVCKofldABMpbDFhwWP9VIJcuPT82A4MhrEr+KE0sfHWAjKPe3TEgHcVi0f+sf0p7SiTFQ=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2646.namprd03.prod.outlook.com (10.173.43.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 07:11:03 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:11:03 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC PATCH v2 01/17] fuzz: Move initialization from main to
 qemu_init
Thread-Index: AQHVS1zwoeA2FT8J9UWtfdO35keS4Q==
Date: Mon, 5 Aug 2019 07:11:02 +0000
Message-ID: <20190805071038.32146-2-alxndr@bu.edu>
References: <20190805071038.32146-1-alxndr@bu.edu>
In-Reply-To: <20190805071038.32146-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0068.namprd02.prod.outlook.com
 (2603:10b6:207:3d::45) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27c5d9f2-1018-46ef-74c0-08d71974134f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2646; 
x-ms-traffictypediagnostic: CY4PR03MB2646:
x-microsoft-antispam-prvs: <CY4PR03MB2646E23395FF45FAB69C6CD9BADA0@CY4PR03MB2646.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(71200400001)(71190400001)(6916009)(186003)(2351001)(1076003)(76176011)(6436002)(53936002)(86362001)(5640700003)(52116002)(6512007)(26005)(5660300002)(102836004)(386003)(6506007)(2501003)(66066001)(75432002)(6486002)(66476007)(2906002)(88552002)(4326008)(8676002)(316002)(786003)(50226002)(54906003)(81166006)(14454004)(81156014)(68736007)(476003)(2616005)(11346002)(446003)(486006)(36756003)(66446008)(66946007)(256004)(64756008)(25786009)(99286004)(478600001)(6116002)(3846002)(7736002)(305945005)(66556008)(8936002)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2646;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: d4j2ZdRKUJbygTAKcMNh9bgPgVQgFKoWY4zPnCJZ7nx1SOHxejQE8AF0KcbHGQlCYv9/1omeXh5Cw2eRdNjKyFwF73hcYrsoxopjRIZX9MMa1NCM9XI5zmNFPVi3hr4HYkOP8elTzkbaQ9pz5eMXUEP7bK8DSTSf/r0nmi7PVKOqnLMi1Oc6xu3s5TabslGO12NCjkOtJvH7+QViXu5/cBDkGgoOowTFgbVlqAI8HiDNniwxvv2wINoN5ZCIKl3obY3Ia51JG+tBnlhMWGMbpAGnxro7hzCiFukB4JkvycvPRElZ0XEBi+3dTwKtv5Ifgk8UMuxkTQNSkvGGC4qYdcY3LB3VH2wUy1e9W76MGG2IBxdXzQkIOAdT/Z8vLhBgimKs0sYlIloXKqUOqqfCzjW6jVZWPKmaWoOq28/pR1w=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c5d9f2-1018-46ef-74c0-08d71974134f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:11:03.0208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2646
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.111
Subject: [Qemu-devel] [RFC PATCH v2 01/17] fuzz: Move initialization from
 main to qemu_init
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "Oleinik, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using this, we avoid needing a special case to break out of main(),
early, when initializing the fuzzer, as we can just call qemu_init.
There is still a #define around main(), since it otherwise conflicts
with the libfuzzer main().

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 include/sysemu/sysemu.h |  5 +++++
 vl.c                    | 25 +++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 984c439ac9..a63d5ccce3 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -184,6 +184,8 @@ QemuOpts *qemu_get_machine_opts(void);
=20
 bool defaults_enabled(void);
=20
+int qemu_init(int argc, char **argv, char **envp);
+
 extern QemuOptsList qemu_legacy_drive_opts;
 extern QemuOptsList qemu_common_drive_opts;
 extern QemuOptsList qemu_drive_opts;
@@ -197,4 +199,7 @@ extern QemuOptsList qemu_global_opts;
 extern QemuOptsList qemu_mon_opts;
 extern QemuOptsList qemu_semihosting_config_opts;
=20
+#ifdef CONFIG_FUZZ
+int real_main(int argc, char **argv, char **envp);
+#endif
 #endif
diff --git a/vl.c b/vl.c
index 130a389712..914bb9b2de 100644
--- a/vl.c
+++ b/vl.c
@@ -130,6 +130,10 @@ int main(int argc, char **argv)
 #include "sysemu/iothread.h"
 #include "qemu/guest-random.h"
=20
+#ifdef CONFIG_FUZZ
+#include "tests/libqtest.h"
+#endif
+
 #define MAX_VIRTIO_CONSOLES 1
=20
 static const char *data_dir[16];
@@ -2854,7 +2858,7 @@ static void user_register_global_props(void)
                       global_init_func, NULL, NULL);
 }
=20
-int main(int argc, char **argv, char **envp)
+int qemu_init(int argc, char **argv, char **envp)
 {
     int i;
     int snapshot, linux_boot;
@@ -4453,7 +4457,7 @@ int main(int argc, char **argv, char **envp)
     if (vmstate_dump_file) {
         /* dump and exit */
         dump_vmstate_json_to_file(vmstate_dump_file);
-        return 0;
+        exit(0);
     }
=20
     if (incoming) {
@@ -4470,6 +4474,23 @@ int main(int argc, char **argv, char **envp)
     accel_setup_post(current_machine);
     os_setup_post();
=20
+    return 0;
+}
+#ifdef CONFIG_FUZZ
+/*
+ * Without this, the compiler complains about all of the unused
+ * cleanup and shutdown() functions
+ */
+int real_main(int argc, char **argv, char **envp)
+#else
+int main(int argc, char **argv, char **envp)
+#endif
+{
+    int ret =3D qemu_init(argc, argv, envp);
+    if (ret !=3D 0) {
+        return ret;
+    }
+
     main_loop();
=20
     gdbserver_cleanup();
--=20
2.20.1


