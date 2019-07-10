Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5F4C74A36
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5A4520693
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Dun06QnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A4520693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlJAn-0005k7-Kn
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 16:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57050)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7H-0001UJ-UN
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7G-0002H2-Tu
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:03 -0400
Received: from mail-eopbgr710059.outbound.protection.outlook.com
 ([40.107.71.59]:24298 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hlJ7G-0002Ap-MZ
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4FQhedDI2J/9O6at+OtRsW2z1M94UnOeJHXHRF+rtw=;
 b=Dun06QnXwX/c9zRaAQii9qNCLsV0kE3r7dfcq/n7qyXi9viQzpxNyJ6grx+Vugc7iDx8XwBbDBy9wqlYakDaPOggPXok3s1yQWcl/LFXOMzpmXdd6C56dF5MJzPGJBa5Ja1jX0YW8HNZ38GgBGlF5hB4EHA0JChop75ynNJH9hY=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB2618.namprd12.prod.outlook.com (20.176.116.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Wed, 10 Jul 2019 20:22:59 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd%6]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 20:22:59 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 01/13] linux-headers: update kernel header to include
 SEV migration commands
Thread-Index: AQHVN11EMkFIntZma0SStKtaLoP2zw==
Date: Wed, 10 Jul 2019 20:22:59 +0000
Message-ID: <20190710202219.25939-2-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: c2e25255-81a9-47e9-2858-08d7057466a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB2618; 
x-ms-traffictypediagnostic: DM6PR12MB2618:
x-microsoft-antispam-prvs: <DM6PR12MB2618F15A63A4C4C107FFBBDAE5F00@DM6PR12MB2618.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:21;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(189003)(199004)(5640700003)(14444005)(8676002)(99286004)(66066001)(53936002)(2351001)(6116002)(3846002)(6436002)(6486002)(305945005)(7736002)(76176011)(52116002)(6916009)(6512007)(81166006)(5660300002)(8936002)(66946007)(66476007)(81156014)(386003)(6506007)(2501003)(2906002)(486006)(476003)(50226002)(68736007)(2616005)(446003)(86362001)(478600001)(25786009)(316002)(11346002)(54906003)(66446008)(64756008)(256004)(71200400001)(71190400001)(66556008)(14454004)(102836004)(1076003)(26005)(36756003)(4326008)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2618;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ro+x98rfVNk6WONi6kGQTY2KglXpbNfhhvB+WX+cS2sOe5U+zpBX2dIFQjtStYV3B54UGq1a8un7jqq4X4LclZCLZE+ZvJNZHkspFZzMkQiVL17qc/iMxavKPrfPXosKVfEYDHgAClKOTyoFM9YujK7tCeYgjJbNdBRJ1WYtAhulb3kAE0audJr10pHuiRNE54dROMoHrh/9pngk8gH9FKWATNOlp7arvR3VHUCDzbvy3gw1ivG7hEQTGOe8oVDGBX4PtUsX91VqUXhsVKSHrVi1194xiOxKNN1Y+nQfgVgT9jwWlI6tU1F5iTZGkrhRIKS8iYGuMnvjsxlS5NQ0j5laTcC9aowiiLoCkefTtxpBM1wc9xtwH3nKP/r4pxHxnsKXVsYpra/uuJSIpMJWLu2pZn967vZXDRe1rA+ejjk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e25255-81a9-47e9-2858-08d7057466a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 20:22:59.4405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2618
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.59
Subject: [Qemu-devel] [PATCH v2 01/13] linux-headers: update kernel header
 to include SEV migration commands
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
 linux-headers/linux/kvm.h | 53 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index c8423e760c..2b0a2a97b8 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -492,6 +492,16 @@ struct kvm_dirty_log {
 	};
 };
=20
+/* for KVM_GET_PAGE_ENC_BITMAP */
+struct kvm_page_enc_bitmap {
+        __u64 start_gfn;
+        __u64 num_pages;
+	union {
+		void *enc_bitmap; /* one bit per page */
+		__u64 padding2;
+	};
+};
+
 /* for KVM_CLEAR_DIRTY_LOG */
 struct kvm_clear_dirty_log {
 	__u32 slot;
@@ -1451,6 +1461,9 @@ struct kvm_enc_region {
 /* Available with KVM_CAP_ARM_SVE */
 #define KVM_ARM_VCPU_FINALIZE	  _IOW(KVMIO,  0xc2, int)
=20
+#define KVM_GET_PAGE_ENC_BITMAP  	 _IOW(KVMIO, 0xc2, struct kvm_page_enc_b=
itmap)
+#define KVM_SET_PAGE_ENC_BITMAP  	 _IOW(KVMIO, 0xc3, struct kvm_page_enc_b=
itmap)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
@@ -1531,6 +1544,46 @@ struct kvm_sev_dbg {
 	__u32 len;
 };
=20
+struct kvm_sev_send_start {
+	__u32 policy;
+	__u64 pdh_cert_uaddr;
+	__u32 pdh_cert_len;
+	__u64 plat_cert_uaddr;
+	__u32 plat_cert_len;
+	__u64 amd_cert_uaddr;
+	__u32 amd_cert_len;
+	__u64 session_uaddr;
+	__u32 session_len;
+};
+
+struct kvm_sev_send_update_data {
+	__u64 hdr_uaddr;
+	__u32 hdr_len;
+	__u64 guest_uaddr;
+	__u32 guest_len;
+	__u64 trans_uaddr;
+	__u32 trans_len;
+};
+
+struct kvm_sev_receive_start {
+	__u32 handle;
+	__u32 policy;
+	__u64 pdh_uaddr;
+	__u32 pdh_len;
+	__u64 session_uaddr;
+	__u32 session_len;
+};
+
+struct kvm_sev_receive_update_data {
+	__u64 hdr_uaddr;
+	__u32 hdr_len;
+	__u64 guest_uaddr;
+	__u32 guest_len;
+	__u64 trans_uaddr;
+	__u32 trans_len;
+};
+
+
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
 #define KVM_DEV_ASSIGN_MASK_INTX	(1 << 2)
--=20
2.17.1


