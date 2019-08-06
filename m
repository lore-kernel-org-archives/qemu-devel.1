Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C769C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A6C520578
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jDCUln6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6C520578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv2mB-0000m2-Bq
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 12:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50946)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2jg-00041T-2c
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2jf-0003mm-0k
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:55 -0400
Received: from mail-eopbgr710055.outbound.protection.outlook.com
 ([40.107.71.55]:41284 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hv2je-0003ei-Px
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M07u1m4uTEBTdYMi2xgw0ii7Dj4Vvd3imNr4L4uAxbV9mq7qdOMFG6U6AyKIvpxSso3zLDLKcFAag39xZmYVE8rzwkJ1HqiCbte60C4VJK2fJsvI7uRPHBRugsnj4VAPpTU/58fBZTIERk4gq48cXecdJBp5PbR+OCUVq3/x9d3bs8bnfccMh7U2x2Zlr5Mn+Lx1PNpVahKL1B3H63toziGoLn/t8nRMIczWmoNH5UrA4cd66ssZ1OkaCZX4X3MUkbnXGvnrh+4Sa9vi6WZId5cK9uUXxkKof3ZDgO53vheGAUJhChhcoIs9rNKveswwf71G/4SS776sUmn4eWrjMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuSI/7smXWk0I/nQKJgMek432S8GtICVq+9mezI6wE0=;
 b=jfNqGJ1WeHWtjxzw3CfgeqV2Xnix0tUICQpRsm/4GEjkVnFMuwERUGGQBoIOkznzV6xjKmY7n1E+d3mv2xOUwkMu7EJdLgcPiOSbsgbE37aTj4cqvIO5CLLGldU5sFM7OqQKSRZU2rgGlHmzFXXhakkiGhMzGk2vWd14RCg9NPFxX+pHnuYNHUm37AkSKuodHox7oJkMNwBGAZkGdKl4wZQyVOmWg6+oNpwfDsl6lbgEOfwyEWU3EpUmfCT537j/ViOLrjQhl3Y3Igap4zWA2mJ/WrDW3rV0ntBkBrxBMfB02Sfb7sBMKV9k5mf5m/ayBL2wvQq6Yy1ZEz8EIVZkeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuSI/7smXWk0I/nQKJgMek432S8GtICVq+9mezI6wE0=;
 b=jDCUln6CwniuaivITR3b7fKQVYJFrHHI2vpOyR5yaPTVulUGWo0zwMKMTNfAQG207wy6cydU+hHj6TMXAhRAie/B0H1moGJOkwTkEb3crRjavFtuSDoscdynb6PX674U2z80+PtXCiQItP6QvGatKaH0LsY6hc/2maLFjMPV2bA=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.118.13) by
 DM6PR12MB4233.namprd12.prod.outlook.com (10.141.184.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Tue, 6 Aug 2019 16:54:53 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71%7]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 16:54:53 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 08/14] target/i386: sev: do not create launch context
 for an incoming guest
Thread-Index: AQHVTHeq+wGULWg76E2AvASsinjoSg==
Date: Tue, 6 Aug 2019 16:54:52 +0000
Message-ID: <20190806165429.19327-9-brijesh.singh@amd.com>
References: <20190806165429.19327-1-brijesh.singh@amd.com>
In-Reply-To: <20190806165429.19327-1-brijesh.singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0701CA0027.namprd07.prod.outlook.com
 (2603:10b6:803:2d::13) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:42::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83791dbd-5db6-411b-51a9-08d71a8ecd37
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB4233; 
x-ms-traffictypediagnostic: DM6PR12MB4233:
x-microsoft-antispam-prvs: <DM6PR12MB423324C22D17B0FD7F8684C9E5D50@DM6PR12MB4233.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:595;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(2501003)(71200400001)(36756003)(81166006)(71190400001)(81156014)(54906003)(5660300002)(1076003)(25786009)(7736002)(6116002)(305945005)(8676002)(76176011)(6916009)(68736007)(3846002)(8936002)(2351001)(99286004)(478600001)(102836004)(64756008)(66946007)(66446008)(66476007)(386003)(6506007)(66556008)(26005)(4326008)(50226002)(2616005)(186003)(476003)(6512007)(6486002)(486006)(86362001)(5640700003)(53936002)(66066001)(316002)(14454004)(11346002)(2906002)(446003)(256004)(6436002)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4233;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W9BYqXic6ZOshleqGns1imlKwOxuj8DI2++TNtkPBgqsM936Zu91dMN8/+5HMWn8OGOOjh9tmFTpzr+EW3FJvI03M0Rb3Sm07GfKvVhid7owbKtNPpXsh81MofWQbqslf3vfwKaMv5MDILSSmbXLn6Drauie0cR8aujsoVU9q5yVGMAi6badx3wswH+UxFXaGD8P9Yg+XaWgkhlQ3oldjF/pAiW1f1m2t13PuyA0ieW/JvO7LQOwfnTumMUb5G+nrTzPdIDMWDURzfEzXP8785YJS0iYiucEypX6WHJqjOtsuPYr2ViTSqNUEi7kX2TLU8s04Phq64VLy3Dpevj+hm74gCwPrAZcpnQrFbqSvqN2QbOfHlHiCmJQliVs6Bm4UreEVnHwNWs0UtXaCnmePBcjPeVd3+WQGTrb7HBQKSY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83791dbd-5db6-411b-51a9-08d71a8ecd37
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 16:54:52.9365 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.55
Subject: [Qemu-devel] [PATCH v3 08/14] target/i386: sev: do not create
 launch context for an incoming guest
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Lendacky,
 Thomas" <Thomas.Lendacky@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The LAUNCH_START is used for creating an encryption context to encrypt
newly created guest, for an incoming guest the RECEIVE_START should be
used.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 target/i386/sev.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 70e9d86815..483d9bb0fa 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -845,10 +845,16 @@ sev_guest_init(const char *id)
         goto err;
     }
=20
-    ret =3D sev_launch_start(s);
-    if (ret) {
-        error_report("%s: failed to create encryption context", __func__);
-        goto err;
+    /*
+     * The LAUNCH context is used for new guest, if its an incoming guest
+     * then RECEIVE context will be created after the connection is establ=
ished.
+     */
+    if (!runstate_check(RUN_STATE_INMIGRATE)) {
+        ret =3D sev_launch_start(s);
+        if (ret) {
+            error_report("%s: failed to create encryption context", __func=
__);
+            goto err;
+        }
     }
=20
     ram_block_notifier_add(&sev_ram_notifier);
--=20
2.17.1


