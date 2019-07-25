Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B43C76186
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:24:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D94DA22AED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="BFe+fdc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94DA22AED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqUMm-0005wr-P9
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 23:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40171)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hqUMC-0003y5-Fv
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hqUMB-0001oj-4V
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:52 -0400
Received: from mail-eopbgr810120.outbound.protection.outlook.com
 ([40.107.81.120]:6127 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hqUMA-0001mt-UM
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hh3+uIou8kcNeMOcumWOLUnydX2tD8JcIitTV/afkoHzGwOYAwVNj9KUWPC2ilAsc3PPbB0DEU1NlmOWSNEoqD4gmkebLdElTaNvWxQTfVmQTu3HH4G0mSi54pVj2SXzjJbZ5QGANaLZFvA/M0FUCnjGxomVkfdNXK8uIvhZqdPQDzorbhqBjA/X1lzA/vPyer8e+m+if0Ii8zeFxRe0qkYRYdAnlVGgw8KjnJHXXB3se7kdMjHck7BjEMOhESacojXMU3r9qzz8MYLcXBEeMD8vi6+ujMTWUVq8BfJ0jBZN67LgOOWj4RfUfnccwSm5WGSKpi3qsNbInTFc8YiJog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zT/a1I8FfcJ+SlA33/8Vk6Iw9ZKoCdcGurs5aoWCk3s=;
 b=QzfyYvtceT8tHFYVzegi34rcC5SR/xeiX0HZG5B6d07HCOOvAZ8cq34riG8ZuzVZf7YozFX0Nc0ZXnbbV7j3nYjQ5802FC9UzuLlFX6CKeKdCCe1sXeNANsS3bvzZvu3XaAClVU8b3Qo0mLnX65crIfpYCTa1/MsKUIHJB8lN0bqjOlJzinUubPBYAvIei4SXpfmJIEkK8uoZXMHVb4D64KUkCGc0g2j6lTFFbpU0ytZ5kaTHom5q5CfMCmnJkcd4XkptxeRB1W7XHp3cg51PvISFuaptC3nnKnmMygIM4cF1F0iuFES+YB39quZ4FyaS0bcEKGWvBov+Rb42/R1qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zT/a1I8FfcJ+SlA33/8Vk6Iw9ZKoCdcGurs5aoWCk3s=;
 b=BFe+fdc1N5AhCz99czk+kfGwOmo6hrP/2PlyxZ1+xJlzcEc8Ir2/Atn1kLnuEdZ0KDN8x8jEda/DT5oHPyq8+oHZT1MDilcdNOhA+MiAkxnNiGwz86FGLv+9PWKIiTVyA1XjypyCHJQjku6KI87XSwl+36fAuDmx3tSPxK6I46U=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2726.namprd03.prod.outlook.com (10.173.40.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 03:23:49 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 03:23:49 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC 06/19] fuzz: Add ramfile for fast vmstate/vmload
Thread-Index: AQHVQphfm5R9EtrmLUa21dtVrN4MJg==
Date: Thu, 25 Jul 2019 03:23:49 +0000
Message-ID: <20190725032321.12721-7-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 44bff88f-bc20-46b6-aafc-08d710af825a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2726; 
x-ms-traffictypediagnostic: CY4PR03MB2726:
x-microsoft-antispam-prvs: <CY4PR03MB2726275EA253929198DFC52EBAC10@CY4PR03MB2726.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(50226002)(3846002)(53936002)(6512007)(14454004)(66066001)(5660300002)(6116002)(25786009)(68736007)(316002)(99286004)(54906003)(1076003)(2351001)(2501003)(2616005)(75432002)(7736002)(76176011)(52116002)(305945005)(14444005)(6436002)(71200400001)(6506007)(26005)(6916009)(478600001)(8936002)(5640700003)(786003)(86362001)(4326008)(256004)(88552002)(71190400001)(386003)(2906002)(476003)(66946007)(446003)(11346002)(8676002)(81156014)(81166006)(66476007)(66446008)(36756003)(6486002)(66556008)(64756008)(486006)(186003)(102836004)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2726;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7kd5AG2PRCtfCgZBFI0sqrXJZ3k914woHRpmp585VIbxgVDUtNgar/8VtGMd+pgDQWUSBU0UEzeu35HR4FmMZxP/tTdbXXP155lSXcQOLF8CjvldkRTWo6aNhtQcKX8xd67xqVTTKKr4/Xp9nyWB0vd8v4Zt08ufo6gkyB99BhK+Nhd8S2J4au05zrFW554gD1HWJUEarHXuOZ5FvtaetbrMyyLPhUL9/lCLzQ+CmiNb0Hw6oW5ECZmzvIyGYyVGGR0Wov0TSi/UiNM4FYwhQ9NJ/z1N70oXO8SSR3rllPBA2KqxmOEGahKGap6+aLATlxlE8bo5SV+CGNakzs/sKE7GfOxkAqv1KWdxpFGfUMAKGamMGU8b4AaIejN2vTgTJ/i8Ox30f/XR9Vof1M7NyG1t7aCQSZxeFK7/zPHfBlA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 44bff88f-bc20-46b6-aafc-08d710af825a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 03:23:49.0394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2726
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.120
Subject: [Qemu-devel] [RFC 06/19] fuzz: Add ramfile for fast vmstate/vmload
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

The ramfile allows vmstate to be saved and restored directly onto the
heap.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/fuzz/ramfile.c | 127 +++++++++++++++++++++++++++++++++++++++++++
 tests/fuzz/ramfile.h |  20 +++++++
 2 files changed, 147 insertions(+)
 create mode 100644 tests/fuzz/ramfile.c
 create mode 100644 tests/fuzz/ramfile.h

diff --git a/tests/fuzz/ramfile.c b/tests/fuzz/ramfile.c
new file mode 100644
index 0000000000..8da242e9ee
--- /dev/null
+++ b/tests/fuzz/ramfile.c
@@ -0,0 +1,127 @@
+/*
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ *
+ *       Filename:  ramfile.c
+ *
+ *    Description:  QEMUFile stored in dynamically allocated RAM for fast =
VMRestore
+ *
+ *         Author:  Alexander Oleinik (), alxndr@bu.edu
+ *   Organization: =20
+ *
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+#include <stdlib.h>
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "exec/memory.h"
+#include "migration/qemu-file.h"
+#include "migration/migration.h"
+#include "migration/savevm.h"
+#include "ramfile.h"
+
+#define INCREMENT 10240
+#define IO_BUF_SIZE 32768
+#define MAX_IOV_SIZE MIN(IOV_MAX, 64)
+
+struct QEMUFile {
+    const QEMUFileOps *ops;
+    const QEMUFileHooks *hooks;
+    void *opaque;
+
+    int64_t bytes_xfer;
+    int64_t xfer_limit;
+
+    int64_t pos; /* start of buffer when writing, end of buffer
+                    when reading */
+    int buf_index;
+    int buf_size; /* 0 when writing */
+    uint8_t buf[IO_BUF_SIZE];
+
+    DECLARE_BITMAP(may_free, MAX_IOV_SIZE);
+    struct iovec iov[MAX_IOV_SIZE];
+    unsigned int iovcnt;
+
+    int last_error;
+};
+
+static ssize_t ram_writev_buffer(void *opaque, struct iovec *iov, int iovc=
nt,
+                                  int64_t pos)
+{
+	ram_disk *rd =3D (ram_disk*)opaque;
+	gsize newsize;
+	ssize_t total_size =3D 0;
+	int i;
+	if(!rd->base) {
+		rd->base =3D g_malloc(INCREMENT);
+		rd->len =3D INCREMENT;
+	}
+	for(i =3D 0; i< iovcnt; i++)
+	{
+		if(pos+iov[i].iov_len >=3D rd->len ){
+			newsize =3D ((pos + iov[i].iov_len)/INCREMENT + 1) * INCREMENT;
+			rd->base =3D g_realloc(rd->base, newsize);
+			rd->len =3D newsize;
+		}
+		/* for(int j =3D0; j<iov[i].iov_len; j++){ */
+		/* 	printf("%hhx",*((char*)iov[i].iov_base+j)); */
+		/* } */
+		memcpy(rd->base + pos, iov[i].iov_base, iov[i].iov_len);
+		pos +=3D iov[i].iov_len;
+		total_size +=3D iov[i].iov_len;
+	}
+	return total_size;
+}
+
+static ssize_t ram_get_buffer(void *opaque, uint8_t *buf, int64_t pos,
+                                   size_t size)
+{
+	ram_disk *rd =3D (ram_disk*)opaque;
+	if(pos+size>rd->len){
+		if(rd->len-pos>=3D0){
+			memcpy(buf, rd->base + pos, rd->len-pos);
+			size =3D rd->len-pos;
+		}
+	}
+	else
+		memcpy(buf, rd->base + pos, size);
+	return size;
+}
+
+static int ram_fclose(void *opaque)
+{
+	return 0;
+}
+
+static const QEMUFileOps ram_read_ops =3D {
+    .get_buffer =3D ram_get_buffer,
+    .close =3D      ram_fclose
+};
+
+static const QEMUFileOps ram_write_ops =3D {
+    .writev_buffer =3D ram_writev_buffer,
+    .close =3D      ram_fclose
+};
+
+QEMUFile *qemu_fopen_ram(ram_disk **return_rd) {
+	ram_disk *rd =3D g_new0(ram_disk, 1);
+	*return_rd=3Drd;
+	return qemu_fopen_ops(rd, &ram_write_ops);
+}
+
+QEMUFile *qemu_fopen_ro_ram(ram_disk* rd) {
+    return qemu_fopen_ops(rd, &ram_read_ops);
+}
+
+void qemu_freopen_ro_ram(QEMUFile* f) {
+	void *rd =3D f->opaque;
+	f->bytes_xfer=3D0;
+	f->xfer_limit=3D0;
+	f->last_error=3D0;
+	f->iovcnt=3D0;
+	f->buf_index=3D0;
+	f->buf_size=3D0;
+	f->pos=3D0;
+	f->ops =3D &ram_read_ops;
+	f->opaque =3D rd;
+	return;
+}
diff --git a/tests/fuzz/ramfile.h b/tests/fuzz/ramfile.h
new file mode 100644
index 0000000000..b51cc72950
--- /dev/null
+++ b/tests/fuzz/ramfile.h
@@ -0,0 +1,20 @@
+#ifndef RAMFILE_H
+#define RAMFILE_H
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/iov.h"
+#include "exec/memory.h"
+#include "exec/address-spaces.h"
+#include "migration/qemu-file.h"
+
+typedef struct ram_disk {
+	void *base;
+	gsize len;
+} ram_disk;
+
+QEMUFile *qemu_fopen_ram(ram_disk **rd);
+QEMUFile *qemu_fopen_ro_ram(ram_disk* rd);
+void qemu_freopen_ro_ram(QEMUFile* f);
+
+#endif
--=20
2.20.1


