Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B198C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 17:00:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1693F20578
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 17:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j+Vzo0Lj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1693F20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv2pD-0006I7-2v
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 13:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50921)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2jf-000405-32
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2jd-0003ky-WA
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:55 -0400
Received: from mail-eopbgr710055.outbound.protection.outlook.com
 ([40.107.71.55]:41284 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hv2jd-0003ei-Oy
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyQhMhvYkv72Y8JXGmcuCFqlY1whjV8A7ZyvKOK3PR/5JeZ9lqHdnXYzJNe4O6hs6miyN2xB4kG6KNKC7JJE71/kWFTfq1D96ocQE20GA6pLqmftfjEkEfPm+FlUqT2Ls+fhKRnR5l5U2BS4iAKA73I6UPt1wJGuljazIWDQYtjta7fO68HJ7eGsZOtOp1PlaHmSAIFXseDN4JXLBUCVZi5raLcsNkhktTLct3UqYpBAjrbgycjByJz6iAadIBMm3CVI9Rd8Swz15d86VEYopBhja0x3YmzoXhW8f+1OP8qZ+qbhMm9cxNpfDMUUkkts/vodVgvcB0l04kVzAHt2fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCl+XzLEh3Xu/noBwM3zUeVk8Df9M4mxrPQD/esT0vo=;
 b=ZQK7iVJoNQ3ZYirJKhlGKZKYI59vxYYYdAHcWC5FP76i6oa7ytyZi2tbW9mPvwntVMAWG0PkzNHH5390hmKTulVt7HvHdDkYZa15b6LZM9LOS9djmYf5NeMLD/A3L7Apg/pVjZEElxfVoxJy7HRnAPebddb0rsuYrbp0RrV5IORdHuojktPVU+YZ6T2paq8TIbPchmTwolf4bQSacT5V34F03AojzEoxBN4C4sthQ+zRV1hfZ+MdmLb+HfvaHc0qbFW4f3tel92OLv0f30R9XnmVE/n/+LCvqVHBE2g8Aeudng4ygn4rch5s23HSWMuEUThTLPUL1pYi1JyLnY6Tbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCl+XzLEh3Xu/noBwM3zUeVk8Df9M4mxrPQD/esT0vo=;
 b=j+Vzo0LjBUPVNrmOU+icAfPjfwIbjf4Kg/6JAJftS4t3TCSvKvdaqX0G1LEGa/ek9zCKGBd9qs9D7kQAaTsAesI3lCQWizCciZ1i7sKZVqLBPfi2dARrMi/bvuPB5iKEokIIvTZBXjIwM+7kvL3QIXY78M4ViZ2y6SNl66avDb8=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.118.13) by
 DM6PR12MB4233.namprd12.prod.outlook.com (10.141.184.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Tue, 6 Aug 2019 16:54:52 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71%7]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 16:54:52 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 06/14] hw/machine: introduce
 MachineMemoryEncryptionOps for encrypted VMs
Thread-Index: AQHVTHepBg1HCJ7gekK1RIXJjcG4zQ==
Date: Tue, 6 Aug 2019 16:54:51 +0000
Message-ID: <20190806165429.19327-7-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: 4b4821e3-4d05-4c09-5a88-08d71a8ecc36
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB4233; 
x-ms-traffictypediagnostic: DM6PR12MB4233:
x-microsoft-antispam-prvs: <DM6PR12MB4233B2CD989452ADD537E160E5D50@DM6PR12MB4233.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(2501003)(71200400001)(36756003)(81166006)(71190400001)(81156014)(54906003)(5660300002)(1076003)(25786009)(7736002)(6116002)(305945005)(8676002)(76176011)(6916009)(68736007)(3846002)(8936002)(2351001)(99286004)(478600001)(102836004)(64756008)(66946007)(66446008)(66476007)(386003)(6506007)(66556008)(26005)(4326008)(50226002)(2616005)(186003)(476003)(6512007)(6486002)(486006)(86362001)(5640700003)(53936002)(66066001)(316002)(14454004)(11346002)(2906002)(446003)(256004)(6436002)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4233;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rFb32e/ZTzPovpxzFDDoY3/wPQkcH8NksjZBF7Ba2Xur2BNQa9ox2+8iUZpu8MTAophXPcPwAG0NtpZnQT0c/AIltlyJPisVKCOL7F0KyerIoJaV8f8PEsoeO4pxmNg1zG34PSIYVZ76wm+mtPabvSyQtxvpOZlcWpbGfXnHSp8DsBCzPYLqdmc7di95jrqTjOqbGcuRMSYz9ojrVD7AMAppolt4/mP3nTbk94EGXu4IT3KeQtHmTDKWsxlzGQWRPdmv8oWGyR9S1NQy3o5ehOYHE192Ll8KNwFcGHfgvoVCfmJ5B9YLycPeyzHpNtIjM8kxNdI1Gz4lxcScRXPM274UlWBT1RvQCyaLgPZ/8mCA4SXW9oTppBzNCTbPpux4wG66PjW5xydb820sW2wutTwLLaSFQgV9AACMuWsVLOw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4821e3-4d05-4c09-5a88-08d71a8ecc36
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 16:54:51.3125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.55
Subject: [Qemu-devel] [PATCH v3 06/14] hw/machine: introduce
 MachineMemoryEncryptionOps for encrypted VMs
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

When memory encryption is enabled in VM, the guest RAM will be encrypted
with the guest-specific key, to protect the confidentiality of data while
in transit we need to platform specific hooks to save or migrate the
guest RAM. The MemoryEncryptionOps introduced in this patch will be later
used by the migration.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 include/hw/boards.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index c5446a39cf..ba80c236fe 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -105,6 +105,29 @@ typedef struct {
     CPUArchId cpus[0];
 } CPUArchIdList;
=20
+/**
+ * The functions registers with MachineMemoryEncryptionOps will be used du=
ring
+ * the encrypted guest migration.
+ */
+struct MachineMemoryEncryptionOps {
+    /* Initialize the platform specific state before starting the migratio=
n */
+    int (*save_setup)(const char *pdh, const char *plat_cert,
+                      const char *amd_cert);
+
+    /* Write the encrypted page and metadata associated with it */
+    int (*save_outgoing_page)(QEMUFile *f, uint8_t *ptr, uint32_t size,
+                              uint64_t *bytes_sent);
+
+    /* Load the incoming encrypted page into guest memory */
+    int (*load_incoming_page)(QEMUFile *f, uint8_t *ptr);
+
+    /* Write the page encryption state bitmap */
+    int (*save_outgoing_bitmap)(QEMUFile *f);
+
+    /* Load the incoming page encryption bitmap */
+    int (*load_incoming_bitmap)(QEMUFile *f);
+};
+
 /**
  * MachineClass:
  * @deprecation_reason: If set, the machine is marked as deprecated. The
@@ -228,6 +251,7 @@ struct MachineClass {
                                                          unsigned cpu_inde=
x);
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
     int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
+    struct MachineMemoryEncryptionOps *memory_encryption_ops;
 };
=20
 /**
--=20
2.17.1


