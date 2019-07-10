Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972D2C74A36
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:28:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632D7208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OVh8bqW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632D7208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlJCc-00006Z-6X
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 16:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57171)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7P-0001aJ-9I
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7M-0002RU-NW
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:11 -0400
Received: from mail-eopbgr790080.outbound.protection.outlook.com
 ([40.107.79.80]:1472 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hlJ7M-0002MZ-G8
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VFhbhSUUfHPJ3xcCQhWIsLPNFiovMczV1q4Ej8/iIc=;
 b=OVh8bqW4JXZ3Q1hilJ2yuTan9OZhCI8WPcHSTQdx6iYItY14fEbJYtOqj6NmWzATs0hq/6eUbx4q3u/j3WhISVKEe++IuMX9mZdjq/enbtHimyBJUFmNG4l+gtN9h7q/mrToN67XGqwKek4GSzJoEf2QB2DHIdkQWG6RmPCjI30=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB3820.namprd12.prod.outlook.com (10.255.173.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Wed, 10 Jul 2019 20:23:07 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd%6]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 20:23:07 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 06/13] doc: update AMD SEV to include Live migration
 flow
Thread-Index: AQHVN11GoaOgtO+6VkC360S37Y86xw==
Date: Wed, 10 Jul 2019 20:23:03 +0000
Message-ID: <20190710202219.25939-7-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: cc27c6de-7ba6-4b72-32a5-08d705746906
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB3820; 
x-ms-traffictypediagnostic: DM6PR12MB3820:
x-microsoft-antispam-prvs: <DM6PR12MB3820222B0E3B835152238F20E5F00@DM6PR12MB3820.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(256004)(8936002)(2616005)(1076003)(316002)(14444005)(476003)(81166006)(478600001)(54906003)(81156014)(2351001)(8676002)(486006)(25786009)(6436002)(6486002)(6666004)(4326008)(66476007)(66946007)(446003)(53936002)(50226002)(71190400001)(66446008)(68736007)(6506007)(14454004)(386003)(5660300002)(36756003)(66066001)(186003)(6512007)(99286004)(305945005)(102836004)(26005)(2501003)(11346002)(64756008)(52116002)(5640700003)(66556008)(76176011)(86362001)(6116002)(15650500001)(6916009)(3846002)(7736002)(71200400001)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3820;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TzEetSjmESHtmv7YN9XEOS/ixBFtutJTSRMujh2C3aq5HZHox6hsyswmD+IM2qXF1eyYIwuszgYlXRZ281vi8rg8MUVUlJeb3O9186FpkSG+PHhw7zxCR7bowsx2tVADzTiW2b5JzyAPztSNO1nQ0h1eU6n8Vc0kHJ5fquqjZlkP7wZM+WLScFepH7oc5/YWMk80KZPE/rX6pef/Ar3gxr7Aco/TTW3bdZhSA7JIkm/gUcRIPLhRopuvJtBTHE0rZ0kAa2vSRMTi6B1jepYJXSZP8xjKHs7O8gmPKDPWjalSQfVT0hauKRmuT7CMy/VlJG3qPbgYnB4JIpEFHPP/qf5CPZzFCdLfSnDVe6luhoeBPxjjt0GRUGsXtreol95hOEvbDbX3bgI43AoV4ycXpNF2h/Jse9p89ozDIOnx6Uk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc27c6de-7ba6-4b72-32a5-08d705746906
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 20:23:03.5991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3820
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.80
Subject: [Qemu-devel] [PATCH v2 06/13] doc: update AMD SEV to include Live
 migration flow
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
 docs/amd-memory-encryption.txt | 42 +++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/docs/amd-memory-encryption.txt b/docs/amd-memory-encryption.tx=
t
index abb9a976f5..374f4b0a94 100644
--- a/docs/amd-memory-encryption.txt
+++ b/docs/amd-memory-encryption.txt
@@ -89,7 +89,47 @@ TODO
=20
 Live Migration
 ----------------
-TODO
+AMD SEV encrypts the memory of VMs and because a different key is used
+in each VM, the hypervisor will be unable to simply copy the
+ciphertext from one VM to another to migrate the VM. Instead the AMD SEV K=
ey
+Management API provides sets of function which the hypervisor can use
+to package a guest page for migration, while maintaining the confidentiali=
ty
+provided by AMD SEV.
+
+SEV guest VMs have the concept of private and shared memory. The private
+memory is encrypted with the guest-specific key, while shared memory may
+be encrypted with the hypervisor key. The migration APIs provided by the
+SEV API spec should be used for migrating the private pages. The
+KVM_GET_PAGE_ENC_BITMAP ioctl can be used to get the guest page encryption
+bitmap. The bitmap can be used to check if the given guest page is
+private or shared.
+
+Before initiating the migration, we need to know the targets machine's pub=
lic
+Diffie-Hellman key (PDH) and certificate chain. It can be retrieved
+with the 'query-sev-capabilities' QMP command or using the sev-tool. The
+migrate-set-sev-info object can be used to pass the target machine's PDH a=
nd
+certificate chain.
+
+e.g
+(QMP) migrate-sev-set-info pdh=3D<target_pdh> plat-cert=3D<target_cert_cha=
in> \
+       amd-cert=3D<amd_cert>
+(QMP) migrate tcp:0:4444
+
+
+During the migration flow, the SEND_START is called on the source hypervis=
or
+to create outgoing encryption context. The SEV guest policy dectates wheth=
er
+the certificate passed through the migrate-sev-set-info command will be
+validate. SEND_UPDATE_DATA is called to encrypt the guest private pages.
+After migration is completed, SEND_FINISH is called to destroy the encrypt=
ion
+context and make the VM non-runnable to protect it against the cloning.
+
+On the target machine, RECEIVE_START is called first to create an
+incoming encryption context. The RECEIVE_UPDATE_DATA is called to copy
+the receieved encrypted page into guest memory. After migration has
+completed, RECEIVE_FINISH is called to make the VM runnable.
+
+For more information about the migration see SEV API Appendix A
+Usage flow (Live migration section).
=20
 References
 -----------------
--=20
2.17.1


