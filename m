Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9CFC43215
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18784206B5
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="tDpLUAmO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18784206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ianwd-0001r3-TB
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 16:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1ianud-00005Z-LW
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1ianuc-0002rL-Mb
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:51 -0500
Received: from mail-eopbgr740102.outbound.protection.outlook.com
 ([40.107.74.102]:45028 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1ianua-0002ik-Pe
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BN/xqIWy2G2gCA0dEqZ3rjCQgzlgxA1BuipHHBrdvsIJ5qbyQuYZ35PElZh7ThTdn1HRdTAkstLeXmKlIzHPPvcOzgdyhVplmMZmaRh7x7gfELU+A6VBCDJCihc0q+cmjnbcVIdd7s6jeoowzl175mXBCf07+kmo8/WA99eN1TfGSdZv+D0ZuW5Zzy1pEyzmL30fXKHNlwaoX7XE3U8hDXPLMmbLymxbbTA3nB/3v55R1X5HsdrXKflDA/AIGB9JWr+pluvRwXBek/ejoyIn/vg1OJPDUz8bPw6npZ1Px3soQ2lY/hGa7fqJwmEtuk9TfPRZ5nqcz28mscxhc3SU+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihqINwu4V2wZhAZ4DETD6SjZu9hxy9MTSDqXcph16q4=;
 b=U46bgkks0P1bORireXFQ2thXOXmNbZjiZgARzIQIG9K/RrcfGbfq0dbWq8o3SgKBSZIaWSI0B9Q9vFCt5RZkBn6MRfatEet4mO6bzODKtQggLul7bgpzvtlDUaGFwYCIJBUZBNSvds9zGVF+DUzc63mvEcdDpHbbdRNHg1qtxlSHHeRuzVyfQ9dsQU5ekSLbCA0hKhfH0PQz0hAmXnWK9QurnRmOQJBWSPy++1/UWJ7fYcSgh5BgBzi8BbIGbYKuUsZLO3eyya7m4p2sZOa/oM7IkOZHD0Tsan5jwX8J7y+zHMrlNVOHkg/PyZU9lA4vO2ICJ+ZLNLZKV7Ee6C3bdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihqINwu4V2wZhAZ4DETD6SjZu9hxy9MTSDqXcph16q4=;
 b=tDpLUAmOoCwFhy7XvsI7bh727qm3WqeYPJ+BbteO5OGFe3+Di1ZD3DFjFG0bsEgqnGP0EGj8VjoG/zNrdsAUIjICi5cbvPdJlXqvno8CsZh/H8Wc9l6ZLwLDlGLRVzb2Moianu9bqqJn6SUYHbRj9Lfx80n22cbU6kcS17N0WEc=
Received: from DM6PR03MB4795.namprd03.prod.outlook.com (20.179.107.22) by
 DM6PR03MB5050.namprd03.prod.outlook.com (10.141.161.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 21:34:42 +0000
Received: from DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74]) by DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74%2]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 21:34:42 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v6 06/21] module: check module wasn't already initialized
Thread-Topic: [PATCH v6 06/21] module: check module wasn't already initialized
Thread-Index: AQHVpvzPVVunpMxg40Kd69JjlNBLRg==
Date: Fri, 29 Nov 2019 21:34:42 +0000
Message-ID: <20191129213424.6290-7-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 08f9760e-785d-44db-bed7-08d77513f22b
x-ms-traffictypediagnostic: DM6PR03MB5050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB505008EEC25B83777EC2C725BA460@DM6PR03MB5050.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
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
x-microsoft-antispam-message-info: eqB0NsJhiB5d1XQWm5QVxB6Ki/q6As/wT0HuyHun06BJjaJXbDL/sxn+knfu2DMKsBJrVmMz05QSWqB6FcdZ/B52bI3xjm/n65jG4qtQICtGUgpkAloJgnTxiFX92FVQZYGcye4+77S73jvOFyqpz3rIMrcBvqWQsaAO539fYi1mkcOourMD071/fVhlZvQeBKOZmktgDL2uhJauiMjGLjG6Qrd9Itlp67Hi72z5LhcEr/YH8uLYF3+/IfG+3vwMLlW+ZUXEIQp5yPysjYCDJrngcL7SYnzDYltK19G4N1mxg5xwNWZVbKd+IYfQX++gVY9cvMM7gR31jYRWo8uNTJq3gb6QUBb5qw3QCBQPutfNhINlMd3aOfNYESGMRrz0xxHKXTLB2663G/5gU186E18jpIKYQGWKw6NSXIA9ugjEuB2+ySodO/uaGbCwtXNg
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f9760e-785d-44db-bed7-08d77513f22b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 21:34:42.6064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OEpjVA24zAum9kkVtDwYgh3IGLQunX0VmBb6z8azODdO8m+N58VemlKrmXLCK//S
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, Darren Kenny <darren.kenny@oracle.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "Oleinik, 
 Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The virtual-device fuzzer must initialize QOM, prior to running
vl:qemu_init, so that it can use the qos_graph to identify the arguments
required to initialize a guest for libqos-assisted fuzzing. This change
prevents errors when vl:qemu_init tries to (re)initialize the previously
initialized QOM module.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 util/module.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/util/module.c b/util/module.c
index e9fe3e5422..841e490e06 100644
--- a/util/module.c
+++ b/util/module.c
@@ -30,6 +30,7 @@ typedef struct ModuleEntry
 typedef QTAILQ_HEAD(, ModuleEntry) ModuleTypeList;
=20
 static ModuleTypeList init_type_list[MODULE_INIT_MAX];
+static bool modules_init_done[MODULE_INIT_MAX];
=20
 static ModuleTypeList dso_init_list;
=20
@@ -91,11 +92,17 @@ void module_call_init(module_init_type type)
     ModuleTypeList *l;
     ModuleEntry *e;
=20
+    if (modules_init_done[type]) {
+        return;
+    }
+
     l =3D find_type(type);
=20
     QTAILQ_FOREACH(e, l, node) {
         e->init();
     }
+
+    modules_init_done[type] =3D true;
 }
=20
 #ifdef CONFIG_MODULES
--=20
2.23.0


