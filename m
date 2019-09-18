Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44FFC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEEFA218AE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="zaIlNaeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEEFA218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAjVU-0001zO-UU
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 19:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAjEZ-0000Lt-D7
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAjEY-0002XF-62
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:39 -0400
Received: from mail-eopbgr710122.outbound.protection.outlook.com
 ([40.107.71.122]:60960 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAjEY-0002W9-07
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEcXUriOPOWyKbLNAjQIMk5VnwoDg7E55ZPC2/z9nQlkuzrxNu5wadTf1DvDVhygxI87N9ULfjeB98sF7303MU/a33bNjgNBPICAWLiMkTuJ559k4AB11L/VHpSZzy2S18cUo3rY4+86nAj2+BsA9S52dWVWUxdBybkarmZWrIViGHg2HxqbdWQ5P9rTjp1hyzuUmQGa18vKRds91BNKHhroab7ac9JSGL9dmBThQUJ4874VLMc5u9ZZusM2u4W+gWVv9zf9aKwIHny4yiVqO2uCxOhRCcradrBD1bCdYdj+6Ku87Ax8g8PNVoFSLZ3e+7mLi5c6b+kSMcEP8CVbWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qs2vUqlO63W35R2m/O8qs57+ehV/lp7PFr/ov71kVxk=;
 b=aj+A09g/BxUldwGnSSO468GYmsUP5uCrB3Py06wz2xMnnAcO46hLXe1IgwMucVHegTOihandiv4tppOyCvk2O4DdPWzulXFiqCihMeT+8X3VBJ4ayh1ZmgO6fYo0c1nmmpMipOwxstXNak24SZNMfdg7dvda+086V4PYGffKGMXAdheIo1lZ7+IN3bTRfk4WB4DZxSVocKj6wn1FgHB0c56mtzBun8+QS29tfr9TuTfX3pR0OrfvsdmRNvSOTLJlH6cxx1aeOtO2i845hGuCtGIqCz9sNOohojQePWPxhOT4DDnxNt17C+ZTDx/TGcHmg1ClDNndHjho8hmXZhIisA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qs2vUqlO63W35R2m/O8qs57+ehV/lp7PFr/ov71kVxk=;
 b=zaIlNaeWIi8OvLaYy+TbVsmsrjqSvt1w6nB8iS3DZcyt7ri/ZCybrm/Snvp4ZU8Okeozk9SaQlx05GsTyvsB2YsgqyQcGTtMeHAxsjoT0zAojuA9kI3YxN/vebTH39AqEqrQF6bdr3bP2E2xAOPHFqQA0lncuUEAtJNq78WwNX0=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB3016.namprd03.prod.outlook.com (10.175.117.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 23:19:36 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 23:19:36 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 09/22] qtest: add in-process incoming command handler
Thread-Index: AQHVbneJ6g+hm7m5kkefZGXqJWfgrg==
Date: Wed, 18 Sep 2019 23:19:36 +0000
Message-ID: <20190918231846.22538-10-alxndr@bu.edu>
References: <20190918231846.22538-1-alxndr@bu.edu>
In-Reply-To: <20190918231846.22538-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85cbcc6a-6042-4cb3-67e5-08d73c8eabd0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB3016; 
x-ms-traffictypediagnostic: CY4PR03MB3016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB3016A4D8F56C023C91934F04BA8E0@CY4PR03MB3016.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(66066001)(86362001)(52116002)(478600001)(2616005)(7736002)(71190400001)(8676002)(36756003)(71200400001)(14454004)(54906003)(316002)(786003)(6486002)(81156014)(75432002)(256004)(6436002)(305945005)(6916009)(6512007)(5640700003)(386003)(486006)(26005)(11346002)(186003)(102836004)(99286004)(76176011)(66946007)(446003)(476003)(66476007)(66556008)(64756008)(66446008)(6506007)(5660300002)(4326008)(2501003)(2351001)(6116002)(81166006)(50226002)(25786009)(1076003)(2906002)(88552002)(8936002)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB3016;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0YlgB73ZfATC3tssbe/fu7pBSVVo6/PDy25K1LmGymXDWl9rI+9RCQGPYpP6bjyt/nbp7knOPHUhgqxcojetl2AOEbpGq0sbGkzeVrly4C2bc1H/4rezz/JlHvp7jvE5sh+s/p3709XKxL+3JEEhcEkpoDt7RSW8zCLjKQ5dCRzkRASWGi0+IUxXN71KdjBs2daqkOEK/V+EhRF1FuWG152MHXPnsKcvyZEC9ZVEWQV8+ARj5AsF6BYmxMxrLtXahlUm/KzYcHg05YSLtMuIaVZ87dfdpWbimClQ6VXFDlyUuhK1MeYUzsvlDuAIWb89lGIDIsHXXDJonVtk5Dc3Id/7Ddvs/nRvkw27/keXmEtnsk4TZaACOxwDZA7fs2q8OG+uxampO2ei9E0hcDuTpFCXk8G3rxJwikjX/30v28U=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cbcc6a-6042-4cb3-67e5-08d73c8eabd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 23:19:36.5097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /3OM6nuzWFodOowKKntfBURVZ1Tv+i6zfslOOugx9FZjU7uuNVaCm5rCspncYFha
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3016
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.122
Subject: [Qemu-devel] [PATCH v3 09/22] qtest: add in-process incoming
 command handler
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

The handler allows a qtest client to send commands to the server by
directly calling a function, rather than using a file/CharBackend

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 include/sysemu/qtest.h | 1 +
 qtest.c                | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index fda7000d2c..3f365522d5 100644
--- a/include/sysemu/qtest.h
+++ b/include/sysemu/qtest.h
@@ -28,5 +28,6 @@ void qtest_server_init(const char *qtest_chrdev, const ch=
ar *qtest_log, Error **
=20
 void qtest_server_set_tx_handler(void (*send)(void *, const char *, size_t=
),
                                  void *opaque);
+void qtest_server_inproc_recv(void *opaque, const char *buf, size_t size);
=20
 #endif
diff --git a/qtest.c b/qtest.c
index ae7e6d779d..44a916485f 100644
--- a/qtest.c
+++ b/qtest.c
@@ -802,3 +802,10 @@ bool qtest_driver(void)
 {
     return qtest_chr.chr !=3D NULL;
 }
+
+void qtest_server_inproc_recv(void *opaque, const char *buf, size_t size)
+{
+    GString *gstr =3D g_string_new_len(buf, size);
+    qtest_process_inbuf(NULL, gstr);
+    g_string_free(gstr, true);
+}
--=20
2.23.0


