Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA7CC31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A54CD2075B
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jbvB9iDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54CD2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv2kV-0005YZ-Fp
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 12:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50850)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2jc-0003zU-I8
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2jb-0003hc-B4
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:52 -0400
Received: from mail-eopbgr710055.outbound.protection.outlook.com
 ([40.107.71.55]:41284 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hv2jb-0003ei-1H
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byW2TeIa0b0hnF4aLG+EdRkRsod/msvPfjVRxmTEjtwotKYNGY06r3I7ZmBKS/S0Zvg8vvlDcIWV3YVgTQhHbFq+w1Oi5SFkU20J/YLq41+OYl3mrLFYH0WQb8SHzN4uGBtS+IwsmF2hpzLc8kLTxidANH/tDGs5w/cT/MASr4WKZMNa+DnvKZM8dxhSP4csU9ESG2RQXOHS9KNaMeedZGpztmNqr6LC5X4YOcyk/Xa0pVvZIqFehrvb5F6SKxn4HrVfqEpySWLrjC3behCOYamJIC2XjjmMyLmZkSFoZyNPx7wOLe3mVQ43sBlUyay9X1pLkuOsSpckTxvfwIQK7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21sF05LyInfIb90Asv9ZsFtYhgwWJqZXz1er03jlqOE=;
 b=an9BD7Y7Sf/TS76G4ahSdHgH+dELIp9+vwyn4HHmwjf0Z4+jgk9BtTuSPDe17ksnjqSQVKhRnPUj61NIdLkkKXG9ueGgNoF8akjDXh15EZisjN6ApgwWvMGWCQL3ikhwR00qvk+yZ5xMlhHFVpTFb0pzVtvLclVfh1BDCjp8cV/g5GWMMgAWh0Fc4xPVOtZOgtpXXJzFKa1XQ+nq73JNvQoaGSyK33jRvqK44oMWfk6UQYZA3ARt9IANRESdlpaMzEEZIsonF9fJktzL8GRp+KSgE59p/4j4Ou82enO/9UObtb8V8yS9jYUn4HfCqk1rug414OqfgejMHyCSPbjj5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21sF05LyInfIb90Asv9ZsFtYhgwWJqZXz1er03jlqOE=;
 b=jbvB9iDqB9apAezGNcSPRf1hbrm9zyawl6qG/sDP1TYn/iuf4ilW4GL6acy1aJD6Vkic+dqmvrIE1QOQ6/zW+/7rxtIaqE1hrHzLVZV6bWCu1Z6x/CmIPuexVpIvAUqGfNEYqtWc3ZAUxMFV/FuwhYk1R/TKTTaQvzG0LNTBfTQ=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.118.13) by
 DM6PR12MB4233.namprd12.prod.outlook.com (10.141.184.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Tue, 6 Aug 2019 16:54:47 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71%7]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 16:54:47 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 01/14] doc: update AMD SEV API spec web link
Thread-Index: AQHVTHenNR6VmUYEGEm6ROL1YUusmg==
Date: Tue, 6 Aug 2019 16:54:46 +0000
Message-ID: <20190806165429.19327-2-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: 268acc8c-a0a1-4ae6-0915-08d71a8ec96c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB4233; 
x-ms-traffictypediagnostic: DM6PR12MB4233:
x-ms-exchange-purlcount: 4
x-microsoft-antispam-prvs: <DM6PR12MB4233B04AE6835E8CEE880D44E5D50@DM6PR12MB4233.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(2501003)(71200400001)(36756003)(81166006)(71190400001)(81156014)(54906003)(5660300002)(1076003)(25786009)(7736002)(6306002)(6116002)(305945005)(8676002)(76176011)(6916009)(68736007)(3846002)(8936002)(2351001)(99286004)(478600001)(102836004)(64756008)(66946007)(66446008)(66476007)(386003)(6506007)(66556008)(26005)(4326008)(50226002)(966005)(2616005)(186003)(476003)(6512007)(6486002)(486006)(86362001)(5640700003)(53936002)(66066001)(316002)(14454004)(11346002)(2906002)(446003)(256004)(6436002)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4233;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JmJ0Ww485nOPzy8hkzOwvKiVnswbWs1sTfcduGG7jdsHh7NqwTboTCcZRu/xfsC+DI9y1kqFLJD3wIlpK1v0kPrauOv8jF+T/oKPjnk5AHHU6DTl5JlnIpXKuqZuc/sp9JObQR8G/dZIqjhlMwJObR2L0+o5fTwbuq+hajmJRcT0byc1vw9iVRHoGvpK6nVmzxlOmPg+Wa9eNKq32X1FmJaY5Pfu3VBC9Hep2evAqv8XBgetN1gwras6Bhxip47UmQwGmRAc7vkUJDWQHbvGg63Uj5VRlzRJP7So+504XgQcWwD+OPRqJYP2bsq9Y+VRdyJQzcE6BRNCDYWfz73X5HuAWqIOdEWlMvSfvlHeoz+W8al39qFV7UBXJdqRxr9jRss34vgRaJ4lpSUwVyrzeIkTOOzjufHQ8cvlwoUMJCo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 268acc8c-a0a1-4ae6-0915-08d71a8ec96c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 16:54:46.5931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.55
Subject: [Qemu-devel] [PATCH v3 01/14] doc: update AMD SEV API spec web link
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
 docs/amd-memory-encryption.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/amd-memory-encryption.txt b/docs/amd-memory-encryption.tx=
t
index 43bf3ee6a5..8822cadda1 100644
--- a/docs/amd-memory-encryption.txt
+++ b/docs/amd-memory-encryption.txt
@@ -67,8 +67,8 @@ expects.
 LAUNCH_FINISH command finalizes the guest launch and destroy's the cryptog=
raphic
 context.
=20
-See SEV KM API Spec [1] 'Launching a guest' usage flow (Appendix A) for th=
e
-complete flow chart.
+See Secure Encrypted Virtualization Key Management API spec section
+'Launching a guest' usage flow  (Appendix A) for the complete flow chart.
=20
 To launch a SEV guest
=20
@@ -97,8 +97,8 @@ References
 AMD Memory Encryption whitepaper:
 http://amd-dev.wpengine.netdna-cdn.com/wordpress/media/2013/12/AMD_Memory_=
Encryption_Whitepaper_v7-Public.pdf
=20
-Secure Encrypted Virtualization Key Management:
-[1] http://support.amd.com/TechDocs/55766_SEV-KM API_Specification.pdf
+Secure Encrypted Virtualization Key Management API Spec:
+[1] https://developer.amd.com/sev/ (Secure Encrypted Virtualization API)
=20
 KVM Forum slides:
 http://www.linux-kvm.org/images/7/74/02x08A-Thomas_Lendacky-AMDs_Virtualiz=
atoin_Memory_Encryption_Technology.pdf
--=20
2.17.1


