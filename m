Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5A4C74A35
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:28:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5E7208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oS6EWmBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5E7208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlJCp-0000EY-VF
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 16:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57338)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7Z-0001gf-PG
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7Y-0002hM-3Z
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:21 -0400
Received: from mail-eopbgr790080.outbound.protection.outlook.com
 ([40.107.79.80]:1472 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hlJ7W-0002MZ-5Q
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9gVZ6RztduKXnvjS5igCjoaS50ZrP1TTzubVxiPikA=;
 b=oS6EWmBhQDn5xw+8lXl/vHtkkm5Gz3Ej4xaTBwtFQ4YynG6DoUCIDh0hwvM9paFyvgKAZ3f5t3HubIaEdGDC/UtWJctWyp9TIbjAJInSwU/L+zBgDIhNaTd3iY3Ljk6BbnzanzL1SpMX9PIlHWMjIWCkl1mdbPFFZs6oBVX6JzI=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB3820.namprd12.prod.outlook.com (10.255.173.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Wed, 10 Jul 2019 20:23:11 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd%6]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 20:23:11 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 13/13] target/i386: sev: remove migration blocker
Thread-Index: AQHVN11KSpt0eCtFYEaoi78d5RGioQ==
Date: Wed, 10 Jul 2019 20:23:09 +0000
Message-ID: <20190710202219.25939-14-brijesh.singh@amd.com>
References: <20190710202219.25939-1-brijesh.singh@amd.com>
In-Reply-To: <20190710202219.25939-1-brijesh.singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM3PR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:0:54::30) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59c5c7b3-bee3-4afe-ff8d-08d705746ca7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB3820; 
x-ms-traffictypediagnostic: DM6PR12MB3820:
x-microsoft-antispam-prvs: <DM6PR12MB382072A24A4917BD34CA52CDE5F00@DM6PR12MB3820.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:124;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(256004)(8936002)(2616005)(1076003)(316002)(476003)(81166006)(478600001)(54906003)(81156014)(2351001)(8676002)(486006)(25786009)(6436002)(6486002)(4326008)(66476007)(66946007)(4744005)(446003)(53936002)(50226002)(71190400001)(66446008)(68736007)(6506007)(14454004)(386003)(5660300002)(36756003)(66066001)(186003)(6512007)(99286004)(305945005)(102836004)(26005)(2501003)(11346002)(64756008)(52116002)(5640700003)(66556008)(76176011)(86362001)(6116002)(6916009)(3846002)(7736002)(71200400001)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3820;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eIpOvBVansTOdzrRV+Gvybajc8l11qaDTULCX1dKrHWdrxLJO6UU4uMVdfrFBFEiTdXZAq7XhnmnLvoDuL7ilDxFTbfU+mZrDUMnSgSefPpQiBF5fA435pJgTtONmVBJzGSMgEootirMVdj4V4JNMQoJnVlNhiSRVo5dyK6DQKiuwMKputTIVCPdD31Kve10ds/SdAEQAvi/LHy8mUcbyL5sHc0Oe4Hyda3Khitvz4Y7kdz/hsEltpKbUXJC2bk36bsyi9+9OF8NW00RZBFy9ruBGZ3LjvYw/IX89hWgmRHDmH8VACDmA5+mXFcN7kpbfi51qRcdhTKUI5ZS0VJjVC0p2pAlww0Tfjd4y2ZiYPFqwyegyy/P5kAX3gClFeZf544pJithYPiM5Lissi6NVeIwVdm7fTbI/oRiN6WOpoU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c5c7b3-bee3-4afe-ff8d-08d705746ca7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 20:23:09.5238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3820
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.80
Subject: [Qemu-devel] [PATCH v2 13/13] target/i386: sev: remove migration
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

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 target/i386/sev.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 93c6a90806..48336515a2 100644
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
@@ -686,7 +685,6 @@ static void
 sev_launch_finish(SEVState *s)
 {
     int ret, error;
-    Error *local_err =3D NULL;
=20
     trace_kvm_sev_launch_finish();
     ret =3D sev_ioctl(sev_state->sev_fd, KVM_SEV_LAUNCH_FINISH, 0, &error)=
;
@@ -697,16 +695,6 @@ sev_launch_finish(SEVState *s)
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


