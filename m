Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1564EC35240
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3BFD2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="DZnEqKEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BFD2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwg7b-0006Jv-1b
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 00:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iwfze-00080K-Cz
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iwfzd-00025U-Ac
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:26 -0500
Received: from mail-mw2nam10on2098.outbound.protection.outlook.com
 ([40.107.94.98]:3168 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iwfzd-0001yv-3h
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hh9ooGr5ft70q9n/j1wqlssJNgcYNWCr424tVfQ03qwt6+dmwzhR0uX1Y4f7bOpT59umOBt3eXpNTXeJ95ZYTlpWzEbYT34GhYbLu2K4NMgU3cKGoNa2ZkpriVNoM9unJmK6HQ9/x8cU/kRMv5o1F5RXszw0ysAGxkE7cjRrxhIrNudbvCJGcapt8JtlkMj6VVp1VWs1QoYr3Lva9rlYSh9DKXq+/+mnJ8umB0uj9wlwjwf7FWreYd7hZQJ1qPhKQpvO0Ze62XNGCrQWBHm6HzQkHxLYYEWyA7DJJ5mHYhwHfjE5GsTh/m45j3n4k5/j8ryQ0k8S9qUD0F5EV9kjjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSRiX7Iqr0XGgElbFjbFwnDm2n/o2jF2k/868jK3+dg=;
 b=IXe+LpAmj1v2vk6e0Qccniue6KCnvYKt69EyYpXevUU7vI3d9V2hgipru+bnd9CHjAyBpBqM5OQ17x6zhG96lyZtDI1QNf432lDTCtrbsMKDnqRX813FoLwJbFevstyqgYxygrsPQpXYOsMnnAK8hVxcQeREfWiUtRV0wTMn27sPWVWR9gA2i3NR42dyTsm9dZOyQ6wc73tJFSAckLqkCJyafpfnXeFPUymSe5IR9H+g1/NLFgsF9yfF8kAhoInmavAIGirqE5fwK2XNxeMXvWfEYhU4Hx/QvH+QfWbr0fRsKeZHm4UQRVCJBL9EgoeQeyvGM5gOPcm8uN76ubljCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSRiX7Iqr0XGgElbFjbFwnDm2n/o2jF2k/868jK3+dg=;
 b=DZnEqKEvYGLQYeMRPxhVsr6+vFKXcmfAUM+PLB2VCbd1VI1b7oRIjOoKyPbxoFclb7SLKfg2l71iu70wn1PwZkp9k5HKUbF+8Ah55Y01ZLxhwLYEbGKpb8TmXam31YHSz965GM4Fk5N7xfTeck03nKO10vjlkUitrWTx5bOxMlA=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4206.namprd03.prod.outlook.com (52.135.110.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Wed, 29 Jan 2020 05:34:23 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 05:34:23 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:c0::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.19 via Frontend Transport; Wed, 29 Jan 2020 05:34:21 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v8 12/21] exec: keep ram block across fork when using qtest
Thread-Topic: [PATCH v8 12/21] exec: keep ram block across fork when using
 qtest
Thread-Index: AQHV1mXC3G4gWTOQDUaVZGhdrRfl7Q==
Date: Wed, 29 Jan 2020 05:34:21 +0000
Message-ID: <20200129053357.27454-13-alxndr@bu.edu>
References: <20200129053357.27454-1-alxndr@bu.edu>
In-Reply-To: <20200129053357.27454-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:c0::42) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b61fc5f4-517b-4767-4167-08d7a47ce490
x-ms-traffictypediagnostic: SN6PR03MB4206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB4206C59FDA6825DECC13D314BA050@SN6PR03MB4206.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(189003)(199004)(478600001)(75432002)(36756003)(316002)(6916009)(2906002)(786003)(4326008)(54906003)(26005)(186003)(956004)(2616005)(6486002)(7696005)(52116002)(16526019)(1076003)(5660300002)(71200400001)(86362001)(66446008)(66556008)(66946007)(66476007)(8936002)(81156014)(81166006)(64756008)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4206;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1D1ks+LelUWxshlEgjoyxM8Y6/GRY7243hwM/mHd0cRGbt8Nyx9pxffkEX/MVtHj2Ct7KiAozmP/J7JzNxxdKID8TQEyGJAG1XqWBmP5ODZmulYoHHWUdEpCnQ8cZJSPtJEJftZI0L9OZu5iuHwqdP4vt1cm7+4JotMudPzJZastxm4HmH/ULpLrx2gZRlmbD94MbnXi2Ha78TEyN4GTYoNaEaIHYNEl8osmoSNbVcwdTatK5sjnZCC7UhBQmKrlt/2i+l2czmObniccxTToCMdQLVc8i8t7559kSkZzfY5PVWF6BYyci5ZNvgkQ9rGdeV3kFPtU4NQejqTrGAlDeS/5OzIvTKwKIQeXNZ6TefE69ZcS4HmjlMcSWw3rfdy/Z18mjWxA4L7j+UoAFSBAqd324sralsVTkwOso5tXf6ToONOz5Ae9H8BCQRmbXEZv
x-ms-exchange-antispam-messagedata: StWA5d/YS9MEURqoHHUkVQ/XuWN/w9blGt254NfnVW4J87dOuOF0Fx0MH8P6ttwKD9FY48eiV20Y+CJlzUof3rFmf7zcURbJLTaPVTCPHVWkxvrtgb3157K12yoOQ9nxQ2y/euhNCjfn2sgEV1l/sA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b61fc5f4-517b-4767-4167-08d7a47ce490
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 05:34:21.5442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w6oStuu50Ed2Kt1KDhVd6kzkYNtsThzFnykE9BWIPcO5S2LWQRVo663BpGv+KUcO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4206
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.98
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
 "bsd@redhat.com" <bsd@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "Bulekov, 
 Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ram blocks were marked MADV_DONTFORK breaking fuzzing-tests which
execute each test-input in a forked process.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 exec.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/exec.c b/exec.c
index d4b769d0d4..99368f175b 100644
--- a/exec.c
+++ b/exec.c
@@ -35,6 +35,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/tcg.h"
+#include "sysemu/qtest.h"
 #include "qemu/timer.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
@@ -2306,8 +2307,15 @@ static void ram_block_add(RAMBlock *new_block, Error=
 **errp, bool shared)
     if (new_block->host) {
         qemu_ram_setup_dump(new_block->host, new_block->max_length);
         qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_HUG=
EPAGE);
-        /* MADV_DONTFORK is also needed by KVM in absence of synchronous M=
MU */
-        qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_DON=
TFORK);
+        /*
+         * MADV_DONTFORK is also needed by KVM in absence of synchronous M=
MU
+         * Configure it unless the machine is a qtest server, in which cas=
e
+         * KVM is not used and it may be forked (eg for fuzzing purposes).
+         */
+        if (!qtest_enabled()) {
+            qemu_madvise(new_block->host, new_block->max_length,
+                         QEMU_MADV_DONTFORK);
+        }
         ram_block_notify_add(new_block->host, new_block->max_length);
     }
 }
--=20
2.23.0


