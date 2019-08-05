Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CE6C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F2E820657
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="mWA6Rg7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2E820657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huXBU-00017k-9V
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 03:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37264)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1huX9B-0003Er-UP
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1huX9B-0001uq-0X
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:09 -0400
Received: from mail-eopbgr680128.outbound.protection.outlook.com
 ([40.107.68.128]:48202 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1huX9A-0001uV-Re
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEn+A8itS6ypyTQO8KD3ytCQxMB2gYc7r5IA4tNnyvCjswhRU5UmsAWdvxcRLRh/ismUQfQsJYia0OrNOSE53PvCprSMZ3mJcrCKSSUVZQa7m7/enCZO078NUE3t049C42Ru/5Z5Zn5ymJKy1p0OiVORs7lR52UcTLP79GJ98nRDKFkh7paiyodDXHOn3DEbZVNI/VEXsZ4GbjNh8fRBhiXCYiCBOoq4+ltlgMwlvCttU2PpVO19Mi8M37dDMAY8pko7cjLoR9GezGVYgPPmKgPY5bRsFHhhQOeFWuOIKQeQQX8/Xy2Qa8ORB+Xb438JzP8Jtrtrkj4pQu/LMmYO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJA8k8KZN+CTSP6/8II3yoUXAHUk1/7rTwNy0gYqvBk=;
 b=EqJiF0eb78m+BNTVniqhw+qPkC7Q+/OOwb0DvvbgxFqoHQ5wykWoBSLAYG2hJsUTU3wyeZpK7ZxtD521aW+0LTW0S4s2rUsTLHtD71X63ycNMb+S+emWMHoqK2yuL7sAjCcfeF0T4KdA3LnIWfZjbVTz2QAh73yItB7q0HFA+GMPuacr4EuRZdd/bHUudu6JQBnYAd05K/SGK95vwNXVw7trqZvoyuIXtsZggGB+Qy8nTosk/fpnp+ofRZnmUbMxBywJEiRjsUqvFssUGtS+mIWHjlBhL43GnTqyXWMHazTvh6EZEXnSibNxO8h2t4pNXbncIASrh9489CrTAxK4Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJA8k8KZN+CTSP6/8II3yoUXAHUk1/7rTwNy0gYqvBk=;
 b=mWA6Rg7u83kyUgkrDRzrWYYVq7J/H2G+fEkfEK75Qjpl9mYWZ8+b1MSDssoMqQcxeU7toK2Me3EPlGDXXuLhFlwvBZi1aGSMAyIFTtDe77IlnNWL5SP5sixoHgi975QfFc9LymnB4p4DOL0/wWCPB+fXVzBAN1QKgr6nTHwh2Yg=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2646.namprd03.prod.outlook.com (10.173.43.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 07:11:07 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:11:07 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC PATCH v2 06/17] fuzz: Add FUZZ_TARGET module type
Thread-Index: AQHVS1zzWhY9OVnIKUuBi37gLJyZaA==
Date: Mon, 5 Aug 2019 07:11:07 +0000
Message-ID: <20190805071038.32146-7-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: b200421c-9218-4ea3-40d8-08d719741619
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2646; 
x-ms-traffictypediagnostic: CY4PR03MB2646:
x-microsoft-antispam-prvs: <CY4PR03MB264602755A2792D23456FEE6BADA0@CY4PR03MB2646.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:229;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(71200400001)(71190400001)(4744005)(6916009)(186003)(2351001)(1076003)(76176011)(6436002)(53936002)(86362001)(5640700003)(52116002)(6512007)(26005)(5660300002)(102836004)(386003)(6506007)(2501003)(66066001)(75432002)(6486002)(66476007)(2906002)(88552002)(4326008)(8676002)(316002)(786003)(50226002)(54906003)(81166006)(14454004)(81156014)(68736007)(476003)(2616005)(11346002)(446003)(486006)(36756003)(66446008)(66946007)(256004)(64756008)(25786009)(99286004)(478600001)(6116002)(3846002)(7736002)(305945005)(66556008)(8936002)(14444005)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2646;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Bz/538wLvw51L7tXnRdLOezmub83+geLjjNAxAW3vWHgEJPNSZxzpSvrk2eGqp192ce9Pxlov0mXIJfSr84gtxqedEge9F7qV57k5+AKXSGoEfBXGSIKD/9DQOKq0A5owQGelhsxdpjTYp7Mrc0bZxTyBSNdL1i2NB4ABURRP/IewTR62NVtX33xpnmdf+jN82dyq0qjhvcWuO4gWNtJmeG2WQM3gnNYbbuU/+/CbOnKEmykNeO+6DMl08FvL4siZ63DAwz0xrv7Rno7wrIgNlvDMuYbYwEVFkU5dehouYkI+HLdyxNAAyxafgCfC/uIEIMawX3FjIElQnZiqBbetnhuGDGX3EC1v3av1g0DHU6VGTBuuI+qfGPpSFUfUuXaa85Q5hR2wnKnes/CBlhbs1j2sq5SZE0eJzIEZLmAEhY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b200421c-9218-4ea3-40d8-08d719741619
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:11:07.6407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2646
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.128
Subject: [Qemu-devel] [RFC PATCH v2 06/17] fuzz: Add FUZZ_TARGET module type
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

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 include/qemu/module.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/qemu/module.h b/include/qemu/module.h
index db3065381d..cb37ef647e 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -46,6 +46,7 @@ typedef enum {
     MODULE_INIT_TRACE,
     MODULE_INIT_XEN_BACKEND,
     MODULE_INIT_LIBQOS,
+    MODULE_INIT_FUZZ_TARGET,
     MODULE_INIT_MAX
 } module_init_type;
=20
@@ -56,7 +57,8 @@ typedef enum {
 #define xen_backend_init(function) module_init(function, \
                                                MODULE_INIT_XEN_BACKEND)
 #define libqos_init(function) module_init(function, MODULE_INIT_LIBQOS)
-
+#define fuzz_target_init(function) module_init(function, \
+                                               MODULE_INIT_FUZZ_TARGET)
 #define block_module_load_one(lib) module_load_one("block-", lib)
 #define ui_module_load_one(lib) module_load_one("ui-", lib)
 #define audio_module_load_one(lib) module_load_one("audio-", lib)
--=20
2.20.1


