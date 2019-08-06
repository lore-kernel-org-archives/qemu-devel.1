Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42979C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 17:04:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CBAD20717
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 17:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jSS2GYUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CBAD20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv2sa-0002Bh-9G
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 13:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51021)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2jk-0004E0-7T
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2jj-0003vq-8g
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:55:00 -0400
Received: from mail-eopbgr680056.outbound.protection.outlook.com
 ([40.107.68.56]:9534 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hv2jj-0003vH-45
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWxTuDNS2cPhZpgWLpNPH5xZPA/qMsG9h1TwiE1uNM40850YyHEY49d9Uwd+81AWWQPzBzsKll/6bN9VEkvrccqST8agj2eGFQ6CEj22nIgbRBSEQ39eaCdhs7Jw1pUPA1D63FXI+9y7zLCwZ4vSyJgRWz6Bf/qdBiD9bzObUX5fZ0Y7kRMQrz4M58Y2gH0gI8NGP7N/ob2SkMrZfORmsJdGpdsapFEn9fu+pd6oV0Z5SKe6uPxhdP6GZa6HiaJG2mynTMbkFG9zrukMWuFadGPIeyn2CZoKiHaRmZJmsDbcdfcgfAWAsuO77foPtmWfUjeiSaVTovZ+Q1iqB99Amw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uejz4+svlRVi0qnndRC3NfpS5tl1lPdx+mY80R7ZbaQ=;
 b=GhLW/QhI9GiysSE9YoVVF9/DLcIztA8qveC2cxLRpAD5V4pQuDfC/AGTwKCyg8kNRoipqsQy3+ttX8pWtxjwYxFNWHFxx0pVp/jjdu/x7x7gs7cmXZfoXIxXr7/2SOnX0hiYO5DDRS22DZTA0D01gQuDrzDtMWRggldPjBPCcfC+acZnmHGwEdtdCo+avcjgTQgxQfWkk+ybISL3z/fObO/rMKUrEcmnXB8vuzjpj6yTvR7LMjr7iT2wXBGEjNtJlu8X97nqGz0GXGJtPIs+2fG2HXE8h3jEs1FZXW+4nOKcch6gwFoC+Srl/+GYTGJH7rcc/RrKHULE5IzdLZG1Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uejz4+svlRVi0qnndRC3NfpS5tl1lPdx+mY80R7ZbaQ=;
 b=jSS2GYUECDXc2gpWnQPHPoZhk3jjA0PRLKz6X7pvp22l7XNbPADoJIm0h7ZOC2g5PCQ5Gq1jKsSTscAG3xLM6/SyUGFVz9TnDSxse1w7z89gWcg/qO7w8JAyRQGQKbZzWql/+6G+d+vgdl+TH5ayJPgbbawWdEkpq08rgsZDHUU=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.118.13) by
 DM6PR12MB4233.namprd12.prod.outlook.com (10.141.184.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Tue, 6 Aug 2019 16:54:57 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71%7]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 16:54:57 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 14/14] target/i386: sev: remove migration blocker
Thread-Index: AQHVTHetdKLSX/Auc027lh3NqFxWjw==
Date: Tue, 6 Aug 2019 16:54:57 +0000
Message-ID: <20190806165429.19327-15-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: 1c00ec95-1542-4fb5-6470-08d71a8ed01d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB4233; 
x-ms-traffictypediagnostic: DM6PR12MB4233:
x-microsoft-antispam-prvs: <DM6PR12MB423399BD9460EC499495ED2EE5D50@DM6PR12MB4233.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:124;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(2501003)(71200400001)(36756003)(81166006)(71190400001)(81156014)(54906003)(5660300002)(1076003)(25786009)(7736002)(6116002)(305945005)(8676002)(76176011)(6916009)(68736007)(3846002)(8936002)(2351001)(99286004)(478600001)(102836004)(64756008)(66946007)(66446008)(66476007)(386003)(6506007)(66556008)(26005)(4326008)(50226002)(2616005)(186003)(476003)(6512007)(6486002)(486006)(86362001)(5640700003)(53936002)(66066001)(316002)(14454004)(11346002)(2906002)(446003)(256004)(6436002)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4233;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QvqWYXZznhIuc5Uk+AeCP8Ho7o1z4oiB7Wm78uITghOoFdZfm+dcZmMrN5vFOOO27bvq29G0DWrbSlumiv4JgZsM7Th2TPBrWHTEqcjOX8x4pCmx6zCA18y9aD0RS/KAVK5QEnQDqPIrWx+iXdf9eN0RU+mSAx4qLvBQpfGJ+3bHn8jrdMpN4l20SrJ5NyEgcFMOcIiE/sCVGCpb6ju4LYlGJpwuEZpiY0ndeOc2r75swgBAIGYCNj31CC9DOnXUsyDr6/tUJ72grxQzzHpzwNjiYYPpMFgqhP6nmHRMQLHA5bQdG+CY0jDswJBIkVeZHgxo0RAuFLbv8pBtJ7GC6SLtqKuoTJgkplnkFwHJslzX/PcWypYiYd8rMMbWvaPHfjmkI1z2cpDICwNE/jjrgR4br/6c3XaS4knDvrWO5Z8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c00ec95-1542-4fb5-6470-08d71a8ed01d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 16:54:57.8038 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.56
Subject: [Qemu-devel] [PATCH v3 14/14] target/i386: sev: remove migration
 blocker
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

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 target/i386/sev.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 9d643e720c..72b841a458 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -34,7 +34,6 @@
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
=20
 static SEVState *sev_state;
-static Error *sev_mig_blocker;
=20
 static const char *const sev_fw_errlist[] =3D {
     "",
@@ -700,7 +699,6 @@ static void
 sev_launch_finish(SEVState *s)
 {
     int ret, error;
-    Error *local_err =3D NULL;
=20
     trace_kvm_sev_launch_finish();
     ret =3D sev_ioctl(sev_state->sev_fd, KVM_SEV_LAUNCH_FINISH, 0, &error)=
;
@@ -711,16 +709,6 @@ sev_launch_finish(SEVState *s)
     }
=20
     sev_set_guest_state(SEV_STATE_RUNNING);
-
-    /* add migration blocker */
-    error_setg(&sev_mig_blocker,
-               "SEV: Migration is not implemented");
-    ret =3D migrate_add_blocker(sev_mig_blocker, &local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        error_free(sev_mig_blocker);
-        exit(1);
-    }
 }
=20
 static int
--=20
2.17.1


