Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE22FC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A2A2073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="LUS1vhgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A2A2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itQAM-0008Bb-00
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 01:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1itQ1P-0006ow-Ar
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1itQ1N-0006Fx-6b
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:47 -0500
Received: from mail-bn7nam10on2115.outbound.protection.outlook.com
 ([40.107.92.115]:59757 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1itQ1N-0006Fc-2K
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNBpxbS7ZrctVDxE81gTX2gMOkZWLn9SSaOSZzA9FRVbT+JytFlTccsBT0ThianycX4LYevoGPi2nnwle2PXiHOT1f3cjiVjePb/qvpGf2OIEpnEICKP3AyEcd34w+kr8F0JyBy8LP3wiWmEgzPeMeIa4FHrtdRAGdUGGdDvXD429Q3SFFHzPsqMxsJUnumyIl4SqMRwXYMjejgUqOJvuz75dynvLSCjfwr31H7dWXOvvTOmnngqKMncM1/BUGOg2kGTf6PZacAr1R6OGs5rnyBowEH+CKwnEtEvOaOSy56b5OCJwM3uSk2/6Z53FLLrigyQCMWMeawsZgLkRklCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDcyKBGnhfVKL9MV14vCpp1u3vtovcs2UihQKuSPZwg=;
 b=dBhOgNrjaCELR+YFroUY7uV+T7e0CwqLP4fmTZlKgUCqQFljEv7oMxi8Ke+wS2CyTLwHY7pRDxCtbYeGNLtjBNG8PDDuVg6S2FAYiX4gb7rCbn7LMR0rMfVTFYjdJdkip6Qscc1kezNN/ewaClAIxJaWgt54p1P8OSf8y4+rGfkatDXkbtaPvnoL0ids0iiSdWePgGQh4hSbm8DCbmubPMnstssmec0rqbw74yc1fdw1MWiyk6Wd734cCaT6OMV0ng3hYEe6E47VRmeKvqK1J81fmGjw2qRBLr0LItfq5qillTZNO36K7cEZKum839vgRkWAbxx/1lYSSQBCFW0e0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDcyKBGnhfVKL9MV14vCpp1u3vtovcs2UihQKuSPZwg=;
 b=LUS1vhgXF4ztdBXucAcpDvzDaygEaM9pa1ENtRdWSLN4VCPKTdR0KU/pBQbWOSn2eqhgJG8t11dHnjeqXFVfXX/mlYXcn9H2rGGchalP5oeBMuXfhc4+OsADC7jepLjCP+G8lcHdcvgT6oPUfYhoYKItLwA2+pShIkq4KwkoRTA=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4399.namprd03.prod.outlook.com (20.178.6.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 05:54:44 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 05:54:44 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR20CA0032.namprd20.prod.outlook.com (2603:10b6:208:e8::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Mon, 20 Jan 2020 05:54:43 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v7 03/20] fuzz: add FUZZ_TARGET module type
Thread-Topic: [PATCH v7 03/20] fuzz: add FUZZ_TARGET module type
Thread-Index: AQHVz1YcpvhXbPp/Y0+K3YHEi9Rxiw==
Date: Mon, 20 Jan 2020 05:54:43 +0000
Message-ID: <20200120055410.22322-5-alxndr@bu.edu>
References: <20200120055410.22322-1-alxndr@bu.edu>
In-Reply-To: <20200120055410.22322-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:208:e8::45) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57aad507-e68a-4680-632b-08d79d6d3f55
x-ms-traffictypediagnostic: SN6PR03MB4399:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB4399E3C1251EEE4DF02EEFE6BA320@SN6PR03MB4399.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:229;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(5660300002)(956004)(2616005)(8936002)(86362001)(6916009)(6486002)(7696005)(4744005)(1076003)(52116002)(316002)(71200400001)(16526019)(186003)(786003)(478600001)(2906002)(26005)(81166006)(66946007)(66476007)(64756008)(36756003)(8676002)(75432002)(81156014)(66446008)(4326008)(66556008)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4399;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ErgJBw/XTsOxJbI7hTMnC3LcatxN2AW98ot1xohKEa6eYf0s0VjdmsfGg1Arta4GLj3cMQY8iJsC7FKR9aRhOaaWmoWFs2paPe/XuOyuP+Zng4cdi2meoHUu2UAzS5t8XPhzY3+0nT35AoGzASnyd99zRYzJbj+AFG/by49sOsjsezKRLHCKZlsdKHJR1klN+B3PIMUWQvoIjR2DaNN7DrAlT+iwQHMVZixADbnTBimN4MkVmruy7fxfsCoF6kkoG/s//GK5D/WycjEHHfAJE5e3/7hz2bkjEO0Hm5NpqX9IVuxwheDypPZdd33ZY3Eqjinr3Z6tNMy1GAupJApnVQPx1h3Gn/WMHYSnU3Nglp2j63L/u9NTSkquQSPgBg41E9SbRFlbg/bik0evfmVbvGZ5mS/H1DOqqR3mYW9PRAUhu09mRyjpEWiAKdDt7Iyj
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 57aad507-e68a-4680-632b-08d79d6d3f55
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 05:54:43.9029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3s60BPWYf/bcWq2pMfsSJE1I9gfrpPM56tBSr3ZzWGaTMzOHUC/uzR3QwsIFTRJp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4399
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.115
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
 "Bulekov, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/module.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/qemu/module.h b/include/qemu/module.h
index 65ba596e46..684753d808 100644
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
2.23.0


