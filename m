Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB3EC433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E2220578
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="C1a7rcIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E2220578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv2m9-0000jH-4l
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 12:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50893)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2je-0003zg-3E
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2jc-0003if-S3
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:54 -0400
Received: from mail-eopbgr710055.outbound.protection.outlook.com
 ([40.107.71.55]:41284 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hv2jc-0003ei-Ky
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsJtafZd9oB4TG7madxuOxuOnO45GLrYPyuz9eDNt+qvAxu0skQtwuqt4QxhJLN4IOJUl18umLB1vuoMaOMQI31w6fKnjAA6Z9xhJkE37QInwGjDp5GL2tOefCiWIH6D8fzDPLn3RfrWqB1OI+3V6BYyVemSDRsHoFvy93eSElckh0MjEUYrOqte3NcCrDoL/mjj0EERv2PJXIsiXUB9HGiWb6tOcrbLIrgpY84q/09GmcIu1u3v/nvEFdBnRMuh51q1XFOaNrG0ir7ycVbUdVvE9mWILG1PCQNCiBKbXoaVaIFIhFBjU3ECYaQyt/qBzPnyBnPM5xXIAMOmlzGXdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4FQhedDI2J/9O6at+OtRsW2z1M94UnOeJHXHRF+rtw=;
 b=j3sYTXtm3bT/D+zSjHMk3God3GdLQjnehIVsgGpEj/P7r++PGKOqxHrQ37LktPBjckipA3zy5g8n2WZOOAr9bx6zHyJ9ZERYV13/2Lr7VZG9qvhm2dI2DR9IGnZXVNXDLFD99h87os8CoO9AI0EcUtx37LCFLvVsIiWwBQuj68VCjnvsHwgMeA81/z/9vXR8pHQxWqx3XJYIdtN3d+VakocvecEswBrFdzhnkw45TYq9Kkr8+O5QyFZoz/82xaOud3etj1+AdcNfUwCULogyB3FcU4FNaACM9DFswuEhz2AlDzJimN4otl8XRXVsAcMunn8Nnj0b05E8gJ1ArP4sXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4FQhedDI2J/9O6at+OtRsW2z1M94UnOeJHXHRF+rtw=;
 b=C1a7rcIk1dnjSlpiOZxK1x8IXtzDsSEiuDwaDnFNHdbuBl/7OS1bY1eUNJEmsjNQO9NOH25UYvkm9U6C3epbWwvNvw7kMB+BAhVt62xOmVn9VDXenxkpPunSPeHyx4xyJTcfDRfZTBneBp3lGQTFrKfV8BlC31VNEDW5gFT5ydQ=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.118.13) by
 DM6PR12MB4233.namprd12.prod.outlook.com (10.141.184.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Tue, 6 Aug 2019 16:54:50 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71%7]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 16:54:49 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 04/14] linux-headers: update kernel header to include
 SEV migration commands
Thread-Index: AQHVTHeobj2aRBtSo0WJ01dEZyjOUQ==
Date: Tue, 6 Aug 2019 16:54:49 +0000
Message-ID: <20190806165429.19327-5-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: a2eca161-c491-475d-d164-08d71a8ecb1e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB4233; 
x-ms-traffictypediagnostic: DM6PR12MB4233:
x-microsoft-antispam-prvs: <DM6PR12MB42331CC5B22B74B3DCD5ADC3E5D50@DM6PR12MB4233.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:21;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(2501003)(71200400001)(36756003)(81166006)(71190400001)(81156014)(54906003)(5660300002)(1076003)(25786009)(7736002)(6116002)(305945005)(8676002)(76176011)(6916009)(68736007)(3846002)(8936002)(2351001)(99286004)(478600001)(102836004)(64756008)(66946007)(66446008)(66476007)(386003)(6506007)(66556008)(26005)(4326008)(50226002)(2616005)(186003)(476003)(6512007)(6486002)(486006)(86362001)(5640700003)(53936002)(66066001)(316002)(14454004)(11346002)(2906002)(446003)(256004)(14444005)(6436002)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4233;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cGz7hYDWaNGjremTW6IEStEOOxNEeA3J3q/GHUQ9dF5Ps1WZ3+55Ec5VUwKR8Jedsf4H7erTifKqFXIPsMfjmx2H77lWJ2OAdShUOAUtYYE6YZD7e+JbVs54EteohgbP4U/Qb4H/PWhQ0qzmMwx7QybHzC1IRnD6W3Z1SRxnODxI/MyXTUt923YBgAOFIH6VXwXuHc74M+GaCYFlNzLeh1K62uRRngVvM8vABoQSH+2Nn+UTsbmM9REEktfQhXynecGBgIeBPLvPt0qtrLh79HffMKL9y9rfQGPi/q08dAA5rNVz2VffoNSJckUTbMwds2d2JTmYsQcYA/wsoH7gxniwJ5AamOThgEOLLVEOVqvs01HwGNc1oBDRQbAiiRh7qYfMUicgEP7BKGHYyIYyjCmgBeluaKWlvZZ6u3V7qmo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2eca161-c491-475d-d164-08d71a8ecb1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 16:54:49.5115 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.55
Subject: [Qemu-devel] [PATCH v3 04/14] linux-headers: update kernel header
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


