Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41A4C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F48620657
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="Vp5u/Oh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F48620657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huXB4-0008B9-SJ
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 03:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37286)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1huX9D-0003Gy-1f
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1huX9B-0001vJ-Q7
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:10 -0400
Received: from mail-eopbgr680100.outbound.protection.outlook.com
 ([40.107.68.100]:57008 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1huX9B-0001v1-KX
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSDfuTi2n5QaEz8XMFtpFnY8eBTPdjJwRdm+BN6zFUQX9bM5v30Rbq72qhPZxuL3ntL4xLip3Za9SzUXAErbBP++u9OqNz6Ene/yj4C1WxD0F/19DXZ5CQ9dFYvcAbTJgA3rRzGsOIhu+nP3iguxEaFbHuOg1A/xiEm1STvuWYO7TGuxPb298VY2y0mASf1pk4fjcBPdrfk00nk+1mK8ddxeu+cyageYVDNMpzznDzrqFL+we8diGM8yTuotkcUt86CkZMz6/CF6MWESvuqycDE82neeVbjv6EIQjCPqcpW6m/H5UdP8gATJ3v7yuof748MZhNvPSvr41wmTYSwGCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EU7gs5QffdX7d5MJ7y1usFyd3t46hrol6CsTtt9cYoI=;
 b=k6AwHLj6hxxaNCeD5NPcELVamuzeJxYQGMJ6PRn8Ld77FMaOKAXvUQJnYBRFpvtE6eADR3rso6opfd1f9SpsPoMrznlLpQH4xoOcjkGWJw/W2MusDUIztpO/zgUiUOi+NV4Rih+e2vpU76KXs/fOVe5WxNjoNMmh/nuT45/ExObQ+BMma+i9uEp0V/l2RSxolvdoypT3XCpriOtIgvjVPHXMTg+TD+6phh+NbXVnJXITkqtQpvj/pkwaU7VplzVU7TXhPvFWGRyXWwlIReZwHyudYUC56uyFfq2rXtEkDTNjMZVOF6n37hjHY4XOfNpnUeHpcPrIHSzNmWuQvB25kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EU7gs5QffdX7d5MJ7y1usFyd3t46hrol6CsTtt9cYoI=;
 b=Vp5u/Oh2Ys5r8IVymozxhfoiLBRfS4YzMRzAdVTL9ES5JMrjjvXyU11zCvY1wZVhp1Jv+MD9Ajm9Me61u1fNyRMaRun5FNZuZIyMae4KP4IFs4RXOSO7W3aCXMkzObU0s/Zf5vOl4TTWrG08duGqHwOqwwzaihHnSo+5FyV+NjE=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2646.namprd03.prod.outlook.com (10.173.43.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 07:11:08 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:11:08 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC PATCH v2 07/17] fuzz: Add ramfile qemu-file type
Thread-Index: AQHVS1z0M6I8kPBbMEK/bIzQlgUatg==
Date: Mon, 5 Aug 2019 07:11:08 +0000
Message-ID: <20190805071038.32146-8-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: f9c87969-e265-4891-bda6-08d7197416ac
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2646; 
x-ms-traffictypediagnostic: CY4PR03MB2646:
x-microsoft-antispam-prvs: <CY4PR03MB264612B2A2C50CC16DDA3764BADA0@CY4PR03MB2646.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(71200400001)(71190400001)(6916009)(186003)(2351001)(1076003)(76176011)(6436002)(53936002)(86362001)(5640700003)(52116002)(6512007)(26005)(5660300002)(102836004)(386003)(6506007)(2501003)(66066001)(75432002)(6486002)(66476007)(2906002)(88552002)(4326008)(8676002)(316002)(786003)(50226002)(54906003)(81166006)(14454004)(81156014)(68736007)(476003)(2616005)(11346002)(446003)(486006)(36756003)(66446008)(66946007)(256004)(64756008)(25786009)(99286004)(478600001)(6116002)(3846002)(7736002)(305945005)(66556008)(8936002)(14444005)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2646;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iwMkTOxEWy/ZADiVja8WIsf1JneZ6pPQkrVNTAh7vG9Y2Z6D8Ix+WTuccmVc595F6EP77BgClDGYrbjwXCQ7cs/+BS0dPegm64MDIYbAxm5Gm9ipXULb0r+lqVa/9M2WWAhr+f6w2oScwqftOPuArHbmTziQN03HHz1YKLUpR7QcGSkkvTLpTWadKoUlw6U4VBLc73ypJI4rlKDsZ4ccI90NaDezq6RLo8pPqTi+jD6lFSidx0MLRrizqI/bR8Qb8P6ia6vnn+/L5j0VYdsMzgV6wxLC4f7EbKVZlZG3Z5+8LbwYpCHwT0Lz40LMYvM/kwb1tFPYRsaoVptNpuNkZlzYAPTYbB19bpy3zBtXatWxiHaZl5YB8r4zcMeC7VvqD2ORYhEbW8rtxtGhlJHIIIazyf4uDnMesukTLNu/3q8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c87969-e265-4891-bda6-08d7197416ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:11:08.5513 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2646
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.100
Subject: [Qemu-devel] [RFC PATCH v2 07/17] fuzz: Add ramfile qemu-file type
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
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, "Oleinik,
 Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 migration/qemu-file.c | 84 +++++++++++++++++++++++++++++++++++++++++++
 migration/qemu-file.h | 11 ++++++
 2 files changed, 95 insertions(+)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 0431585502..453e2897d5 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -786,3 +786,87 @@ void qemu_file_set_blocking(QEMUFile *f, bool block)
         f->ops->set_blocking(f->opaque, block);
     }
 }
+
+#ifdef CONFIG_FUZZ
+#define INCREMENT 10240
+static ssize_t ram_writev_buffer(void *opaque, struct iovec *iov, int iovc=
nt,
+        int64_t pos)
+{
+    ram_disk *rd =3D (ram_disk *)opaque;
+    gsize newsize;
+    ssize_t total_size =3D 0;
+    int i;
+    if (!rd->base) {
+        rd->base =3D g_malloc(INCREMENT);
+        rd->len =3D INCREMENT;
+    }
+    for (i =3D 0; i < iovcnt; i++) {
+        if (pos + iov[i].iov_len >=3D rd->len) {
+            newsize =3D ((pos + iov[i].iov_len) / INCREMENT + 1) * INCREME=
NT;
+            rd->base =3D g_realloc(rd->base, newsize);
+            rd->len =3D newsize;
+        }
+        memcpy(rd->base + pos, iov[i].iov_base, iov[i].iov_len);
+        pos +=3D iov[i].iov_len;
+        total_size +=3D iov[i].iov_len;
+    }
+    return total_size;
+}
+
+static ssize_t ram_get_buffer(void *opaque, uint8_t *buf, int64_t pos,
+        size_t size)
+{
+    ram_disk *rd =3D (ram_disk *)opaque;
+    if (pos + size > rd->len) {
+        if (rd->len - pos >=3D 0) {
+            memcpy(buf, rd->base + pos, rd->len - pos);
+            size =3D rd->len - pos;
+        }
+    } else {
+        memcpy(buf, rd->base + pos, size);
+    }
+    return size;
+}
+
+static int ram_fclose(void *opaque)
+{
+    return 0;
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
+QEMUFile *qemu_fopen_ram(ram_disk **return_rd)
+{
+    ram_disk *rd =3D g_new0(ram_disk, 1);
+    *return_rd =3D rd;
+    return qemu_fopen_ops(rd, &ram_write_ops);
+}
+
+QEMUFile *qemu_fopen_ro_ram(ram_disk* rd)
+{
+    return qemu_fopen_ops(rd, &ram_read_ops);
+}
+
+void qemu_freopen_ro_ram(QEMUFile *f)
+{
+    void *rd =3D f->opaque;
+    f->bytes_xfer =3D 0;
+    f->xfer_limit =3D 0;
+    f->last_error =3D 0;
+    f->iovcnt =3D 0;
+    f->buf_index =3D 0;
+    f->buf_size =3D 0;
+    f->pos =3D 0;
+    f->ops =3D &ram_read_ops;
+    f->opaque =3D rd;
+    return;
+}
+#endif
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 13baf896bd..7048674f1b 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -177,4 +177,15 @@ size_t ram_control_save_page(QEMUFile *f, ram_addr_t b=
lock_offset,
=20
 void qemu_put_counted_string(QEMUFile *f, const char *name);
=20
+#ifdef CONFIG_FUZZ
+typedef struct ram_disk {
+    void *base;
+    gsize len;
+} ram_disk;
+
+QEMUFile *qemu_fopen_ram(ram_disk **rd);
+QEMUFile *qemu_fopen_ro_ram(ram_disk* rd);
+void qemu_freopen_ro_ram(QEMUFile *f);
+#endif
+
 #endif
--=20
2.20.1


