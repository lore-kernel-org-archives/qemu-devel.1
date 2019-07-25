Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4267AC76186
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FC9822AED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="IPe6CyUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC9822AED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqUOC-0003SN-8V
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 23:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40206)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hqUME-00048v-Vt
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hqUMD-0001qH-UE
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:54 -0400
Received: from mail-eopbgr810110.outbound.protection.outlook.com
 ([40.107.81.110]:60544 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hqUMD-0001pn-Nx
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMgYxt2bT9RnAbdT2RHt9/IXL7TMPtic8N+YqHKb3V/jt3hp07GAG5WBlKuSs/6dt/e2aBiBrIOutdFlNIiQiNIFowOYgXSaFszmI6mcbesmsEw3iUk9IfSsyidW4lvJNycmQ4Z9CrmspklAuZ/0tEirIvV7oNxMtObS7DCyq2n/IazQfSQV9bc25qHhc7LIP98/fpYwJO2qc3yQONvNrEFupVkOejdMi53HANqEaic7thDapW9cF63YwiJEdoak9YkhO5LUdrvCMtI9l5qS61Gya3IkEHA0lsYKC0xpP3U4QGOetgAG9GrkKusIPcz4EO9RFj740NJnVloNHiPMhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fJuvSA/j47yDGngl+9YT0F7WUnhEMH488mha91RQ+0=;
 b=Lac//Lrio+PgsF0k3YAyfMQxkIAwN31btdGj3mPM67Z3+oP23K+XuC2AwaEuerl3R1Lp69OZ01icR81ovnIypkx42q3ivksyUskkEGbcBeWg2uImsJDA3wNOdpUBlnsBjip/ondBGNJOgIGdoYfprs6GTEU8AAGiJwOG6yhOCFE1VbCPxQVAV/3zhDhzPCnwcfpoen4ljvg+OoMGlpx9Obiwr4FZXKPoPKqZ2aTLoTlo0AGWGXWss8+lHQwjA9Xr4HegV+QOUMIXp9V0PGM/vpMq7Me5rYULtKLaW+tiWbRB6sC6KpkQ7BMwW87qPLK5i/jF2nE7+YsCGLaak1Bu2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fJuvSA/j47yDGngl+9YT0F7WUnhEMH488mha91RQ+0=;
 b=IPe6CyUGO4oHkcyVfANluraV+IelkT5raIif3tMbKsMci85c5XTDWJj0hVUJoT5OkJLm3fdJgJTdqvmBPb+eM2LHPBiCPafH+5HGUZTGXNk1kG+vFflgQ1DbmxREaLS8EnPrjSgwqGPNqWg6dQi86pZtZ1gM29nM0EWgfek9KYk=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2726.namprd03.prod.outlook.com (10.173.40.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 03:23:52 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 03:23:52 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC 10/19] fuzz: expose real_main (aka regular vl.c:main)
Thread-Index: AQHVQphi/ap9MbiEUkiHsVqYQtC80A==
Date: Thu, 25 Jul 2019 03:23:52 +0000
Message-ID: <20190725032321.12721-11-alxndr@bu.edu>
References: <20190725032321.12721-1-alxndr@bu.edu>
In-Reply-To: <20190725032321.12721-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:207:3d::16) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a05376b-14af-4408-b752-08d710af8481
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2726; 
x-ms-traffictypediagnostic: CY4PR03MB2726:
x-microsoft-antispam-prvs: <CY4PR03MB27264606291DA53B950E9E87BAC10@CY4PR03MB2726.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(50226002)(3846002)(53936002)(6512007)(14454004)(66066001)(5660300002)(6116002)(25786009)(68736007)(316002)(99286004)(54906003)(1076003)(2351001)(2501003)(2616005)(75432002)(7736002)(76176011)(52116002)(305945005)(14444005)(6436002)(71200400001)(6506007)(26005)(6916009)(478600001)(8936002)(5640700003)(786003)(86362001)(4326008)(256004)(88552002)(71190400001)(386003)(2906002)(476003)(66946007)(446003)(11346002)(8676002)(81156014)(81166006)(66476007)(66446008)(36756003)(6486002)(66556008)(64756008)(486006)(186003)(102836004)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2726;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a3Q0nUSnzkFA6Cg8w78J0RVwelENSJelAj81rBNPbqh4DHwmostcL1N+g7lPwVvCliGRV66Xtkmdf13cXZVpEMRQwg8C8CjmuVXyYKMjhmcnCbABYPqRikKrh/7FUof/q0+kbsjmqC8sygZIy3HeN87oz+sehbic/X+iNZwHU9jsjrzHfuYfkUdlWOo/rTB/UlpTOftm8ggsCMsViJ3YD5heKAiPHj6DNLwDlLGKmLiM8R66MKicEUSPwfSGoG81AGQHEl1r2gJaVogFegAW3g4ftQ7z0wseh2Vn229zZ10Fknq8JJ82AjClbOxCwiseYM6F8/fms/kgpefmILDBwaoWDw/Z+RAZIzsKhnwxBjbVNHK5U1gLYKUnRLaZqmej9zYVsSogXebuurAnQJhSge5L67mFpFSJgiZ8TZhB04w=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a05376b-14af-4408-b752-08d710af8481
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 03:23:52.6088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2726
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.110
Subject: [Qemu-devel] [RFC 10/19] fuzz: expose real_main (aka regular
 vl.c:main)
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
 "bsd@redhat.com" <bsd@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "Oleinik, 
 Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Export normal qemu-system main so it can be called from tests/fuzz/fuzz.c

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 include/sysemu/sysemu.h |  4 ++++
 vl.c                    | 21 ++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 984c439ac9..1bb8cf184c 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -184,6 +184,10 @@ QemuOpts *qemu_get_machine_opts(void);
=20
 bool defaults_enabled(void);
=20
+#ifdef CONFIG_FUZZ
+int real_main(int argc, char **argv, char **envp);
+#endif
+
 extern QemuOptsList qemu_legacy_drive_opts;
 extern QemuOptsList qemu_common_drive_opts;
 extern QemuOptsList qemu_drive_opts;
diff --git a/vl.c b/vl.c
index b426b32134..b71b99b6f8 100644
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
@@ -2853,8 +2857,11 @@ static void user_register_global_props(void)
     qemu_opts_foreach(qemu_find_opts("global"),
                       global_init_func, NULL, NULL);
 }
-
+#ifdef CONFIG_FUZZ
+int real_main(int argc, char **argv, char **envp)
+#else
 int main(int argc, char **argv, char **envp)
+#endif
 {
     int i;
     int snapshot, linux_boot;
@@ -2903,7 +2910,9 @@ int main(int argc, char **argv, char **envp)
     atexit(qemu_run_exit_notifiers);
     qemu_init_exec_dir(argv[0]);
=20
+#ifndef CONFIG_FUZZ // QOM is already set up by the fuzzer.
     module_call_init(MODULE_INIT_QOM);
+#endif
=20
     qemu_add_opts(&qemu_drive_opts);
     qemu_add_drive_opts(&qemu_legacy_drive_opts);
@@ -4196,9 +4205,11 @@ int main(int argc, char **argv, char **envp)
      */
     migration_object_init();
=20
+#ifndef CONFIG_FUZZ // Already set up by the fuzzer
     if (qtest_chrdev) {
         qtest_init(qtest_chrdev, qtest_log, &error_fatal);
     }
+#endif
=20
     machine_opts =3D qemu_get_machine_opts();
     kernel_filename =3D qemu_opt_get(machine_opts, "kernel");
@@ -4470,6 +4481,14 @@ int main(int argc, char **argv, char **envp)
     accel_setup_post(current_machine);
     os_setup_post();
=20
+/*
+ * Return to the fuzzer since it will run qtest programs and run the
+ * main_loop
+*/
+#ifdef CONFIG_FUZZ
+    return 0;
+#endif
+
     main_loop();
=20
     gdbserver_cleanup();
--=20
2.20.1


