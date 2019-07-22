Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCEAC76194
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BADE218DA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="q+DYBhQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BADE218DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpYJe-0000GZ-T0
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 09:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50024)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hpYJF-0007Ub-2L
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hpYJD-0003sO-9G
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:24:57 -0400
Received: from mail-eopbgr710112.outbound.protection.outlook.com
 ([40.107.71.112]:26272 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hpYJC-0003nE-I4
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:24:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cr5bwF0d11UalUZ0egDm5+pe2QctAcDYnsVr7GGrjO0Eg0lDqyHswE4njuJwzMd//XwuT88rwI51HxW6v9dSpZOmueo5FcoH873Yx6M+n9upmK5k1c9gWaDbho6ouKRSkYkDfRdRCuGwSc4lk+1e8FqMqwrr2NuQn3mICl3qlCZW2fDetzPDLrlybcb/SlBSDKGpaLFaM3f+ynuFfAW4a7c4X8HWJbA4lTRherwr7AYQqTiiZGBPpoltTvK1UQtPs72rJpQLpgrgTBpJ+VrO7qYN0R80U1HweoQgN2UynH0N+sq45FaE1LlLWa38on2btAPOECNgqZk/S/6rHV0uyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myA7iWQ2TtHlhGDHyUCyhouxeVXMtA/7+hPJnDKpTNI=;
 b=AhJUGK3TlvqULSVV8nzdg6F42aQjs4dF4Wxe2FwMH8xcqgS3GFqlcmU+oKOmHPg3/l0RF2c8EK7AvDcg5YoBJz2BdVurXLVG3wenI2jwoFRmGeO/OLOpiuLdERo4ROCg/UOBxQZl6H8fo3LohxOtTZYLDDO61U4B/u1EHbJ/Ez0TKVTVqiF18I4GthVaSF0OwTleb8+UaIVp/TPnWzIuNnGTLwmS9kkGYE65STM82+QY9Z7IS9INqOrpOUqvc2jEhrSbGXL2o5Z7R7IXSCZHzXPbUtFtBkRHxBKDDoiTBvJ1kUhSYrQdRWiU2uHxFJ2AdA1/GGRlSgcYQZDiIJFxjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myA7iWQ2TtHlhGDHyUCyhouxeVXMtA/7+hPJnDKpTNI=;
 b=q+DYBhQ31toVpGnulUJAagDp0290kTNM4vl1IDkoqkW6vgeoxrbar9xPiss/DfmGMMCQwdGHi7q3oT1LBZoN83juJk/EG7XZqNeBeEbo4G5Jhl/PvKNMGDCCfAldiR7jDlZ2Hyl1KoE2zLg1mgvrcU/AxfKqjK1A8XvYt168AMQ=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB3271.namprd03.prod.outlook.com (10.171.246.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Mon, 22 Jul 2019 13:24:47 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2094.013; Mon, 22 Jul 2019
 13:24:47 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 1/2] net: assert that tx packets have nonzero size
Thread-Index: AQHVQJDVev5Tqr//HkGF9a/5kASLxg==
Date: Mon, 22 Jul 2019 13:24:47 +0000
Message-ID: <20190722132344.30798-2-alxndr@bu.edu>
References: <20190722132344.30798-1-alxndr@bu.edu>
In-Reply-To: <20190722132344.30798-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR01CA0030.prod.exchangelabs.com (2603:10b6:208:10c::43)
 To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca7dfd70-d28b-4bc6-9f24-08d70ea7f784
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB3271; 
x-ms-traffictypediagnostic: CY4PR03MB3271:
x-microsoft-antispam-prvs: <CY4PR03MB3271DF09B0AECE3508521235BAC40@CY4PR03MB3271.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(189003)(199004)(86362001)(1076003)(75432002)(478600001)(446003)(11346002)(6916009)(486006)(476003)(2616005)(4744005)(52116002)(66066001)(76176011)(26005)(2351001)(186003)(102836004)(6506007)(386003)(3846002)(6116002)(66946007)(88552002)(66476007)(66556008)(64756008)(66446008)(2906002)(5660300002)(99286004)(8936002)(6486002)(4326008)(25786009)(81156014)(81166006)(6512007)(53936002)(7736002)(6436002)(8676002)(50226002)(68736007)(5640700003)(2501003)(36756003)(54906003)(71190400001)(71200400001)(14454004)(256004)(305945005)(786003)(316002)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB3271;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KjGy7fZpk8x7wZQcpRyK2ARps7lAQ3rpkuK0SaqH2+CdIsqassI7jZvEPvvKCpCPfgLVoabWl14oawVkUxVCZKZAJNSkVGHgaU41lqEKBfADPbQbxER/hPP/PPEatluJzaOQf9uEKS0hJGfi1POijq8awXgrkOySPU4hhQFL0reRiS8WdyqBKViyD1VELsJ7agfxU/V4Nh7QZUmdf88eJ2sqDMY/EnjF5hVQpIzO32HgM0NzPRo5D7pUhUum5s81k5CmdmOS90kBa6MkRYLEI3gKLDgVGbiUL7jzdJ8u+G6wExrih/zb9iFGpLovyzUmUWXBZG94Er1QFjyAuzq/Nw2xCZ5Nvo+xAKstas18aku1lou6we065JW542WhfiqsYelBBMH/LpYNuXO4SnhgmcR4ZdCuXtPVKeUPtSpR/6Q=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7dfd70-d28b-4bc6-9f24-08d70ea7f784
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 13:24:47.3014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3271
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.112
Subject: [Qemu-devel] [PATCH v2 1/2] net: assert that tx packets have
 nonzero size
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
 "bsd@redhat.com" <bsd@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "Oleinik, 
 Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Virtual devices should not try to send zero-sized packets. The caller
should check the size prior to calling qemu_sendv_packet_async.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
v2:
  * Improve the comment to explain the rationale for adding the assert.
 net/net.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/net.c b/net/net.c
index 7d4098254f..4ad21df36f 100644
--- a/net/net.c
+++ b/net/net.c
@@ -741,6 +741,15 @@ ssize_t qemu_sendv_packet_async(NetClientState *sender=
,
     size_t size =3D iov_size(iov, iovcnt);
     int ret;
=20
+    /*
+     * Since this function returns the size of the sent packets, and a ret=
urn
+     * value of zero indicates that the packet will be sent asynchronously=
,
+     * there is currently no way to report that a 0-sized packet has been =
sent
+     * successfully. Forbid it for now, and if someone needs this function=
ality
+     * later, the API will require a change.
+     */
+    assert(size);
+
     if (size > NET_BUFSIZE) {
         return size;
     }
--=20
2.20.1


