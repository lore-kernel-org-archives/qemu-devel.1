Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4CCC31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D212075B
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CHjTinZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D212075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv2kY-0005ic-O9
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 12:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50867)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2jd-0003zW-8r
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2jb-0003hk-RW
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:53 -0400
Received: from mail-eopbgr710055.outbound.protection.outlook.com
 ([40.107.71.55]:41284 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hv2jb-0003ei-KX
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVR+o9Ijzi033iKkdagUa7bNpf369XvhMOyYFsU32TMQNb6nHQATR0UOH2f5XVrqLZsHVDObfuTQkj7Dno2+MTeIXs/YS5BDD7wMT5J9XRxUXO9E55RJWbIg348NBYOFf++Bian2wJn+HrYNj2eBUxZL+ftddPP7Odwr9EjKM5+rbz291LLhYJ/i3Ae0I342xlbDpQFmCntfvyvPVEouAqckSbeTUHzo9/pMCR1pVGQ4JpB4Q8gADBEV56qjK5bLXmHUyTQChBy3SjuuhFF7Ak5ZWFOyx8Krkiwn1wMyeNrGb9E08tjXtGqKTYm8QRzwAF3L5aPV/Pg9JrfAnbUfSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLZyMSP6ZsQ/etSgcRdFs5I9oCCNDMrZtuVbnRNKJzg=;
 b=lq/VvRbwLAhDWNS86j7TrWuQQ9WCjCSUwLvW6WUle2DuyEeWjzQgFtnUwIFzP6OupcAucTKI/uhXOInTMsxoUTrvQYksafQNPg1iL6xPvzatH6rT3y/C1LAxFM6iyjWGCnoLCHaWTk3vHNHSk3LmbQ0U0ddQZSFVkrxxywmFs+vXutkcCuYOR+1F74u5UYpn+BRDIJ7f4LxZh+nmfc1Udr1oIYL9HfDo2jWyGkTSDAqhpPnunPY1v4v8pYGKwduhZ7UDOtD+cfNKS+pKq6sts12/NXnOdFDZErVHwVLEgx9UOYPGsJ31fsQKhFUSpC0CEalDv7OT6GUJuGkUbNwDIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLZyMSP6ZsQ/etSgcRdFs5I9oCCNDMrZtuVbnRNKJzg=;
 b=CHjTinZG8Beg3Zo7HwAWG6qtV+yjjSPGV9YtT8NX0Bi+LvDhnioKQTuvSx5LhQurLNSYNG81lashJZg/wpSWWUe6HTBGOetKVFVPMYM08zkNro8X+0vsls94Yp+4fbBjpuvJXV5J+PQnC52/0v0iRQWeYxKM9go9TmoCSjs6Z9w=
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
Thread-Topic: [PATCH v3 02/14] doc: update AMD SEV to include Live migration
 flow
Thread-Index: AQHVTHen3F1mgv5cv0WeCKaa+G3INw==
Date: Tue, 6 Aug 2019 16:54:47 +0000
Message-ID: <20190806165429.19327-3-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: 9881d971-c230-47ec-15a3-08d71a8ec9f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB4233; 
x-ms-traffictypediagnostic: DM6PR12MB4233:
x-microsoft-antispam-prvs: <DM6PR12MB4233507149C07E83DE52E890E5D50@DM6PR12MB4233.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(2501003)(71200400001)(36756003)(81166006)(71190400001)(81156014)(54906003)(5660300002)(1076003)(25786009)(7736002)(6116002)(305945005)(8676002)(76176011)(6916009)(68736007)(3846002)(8936002)(2351001)(99286004)(478600001)(102836004)(64756008)(66946007)(66446008)(66476007)(386003)(6506007)(66556008)(26005)(4326008)(50226002)(2616005)(186003)(476003)(6512007)(6486002)(15650500001)(486006)(86362001)(5640700003)(53936002)(66066001)(316002)(14454004)(11346002)(2906002)(446003)(256004)(14444005)(6436002)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4233;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gPO1kM+6ZGMCVO9Tfe41djbhR8Q3D2vtLBPnxUTeZKeYoGdxXr5q56oLsUBQRXVUFU3E62+ACENuDq9i9bpEj8YOUjKPEYLGG2gIvIp07vptmURbxGgnRCQ2gx4jP8Ks+g6JGXVXvl274KaqlY98Q6bJQ6tuuFyJhFexaaS9kw+D3E2DE5i3pk9lMR4QhAvgKJ8VfQPYVXZKiAmvqKFBkNaRmWsy1llmL70S2iK09FFDwO74Xc6e3ycm1KLM+vMgmzXcNkPkLX1AZqA5HS+9u7RTkZLqJTGQb+YO6pdszMUEcgx2l0SL2CPDUJDn5Ty9d/nmm67OzEQ6jb+HXIDxFs1Z3nbYjeB+X2WsgVhmR+1xHyyFu916qXEc//jIUYrWmT3lJ2eybKvZyFES7IwdYl1/bleCWVyvTa/0EXNoyxw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9881d971-c230-47ec-15a3-08d71a8ec9f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 16:54:47.5246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.55
Subject: [Qemu-devel] [PATCH v3 02/14] doc: update AMD SEV to include Live
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
 docs/amd-memory-encryption.txt | 40 +++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/docs/amd-memory-encryption.txt b/docs/amd-memory-encryption.tx=
t
index 8822cadda1..01d95089a8 100644
--- a/docs/amd-memory-encryption.txt
+++ b/docs/amd-memory-encryption.txt
@@ -89,7 +89,45 @@ TODO
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
+migrate-set-parameter can be used to pass the target machine's PDH and
+certificate chain.
+
+During the migration flow, the SEND_START is called on the source hypervis=
or
+to create an outgoing encryption context. The SEV guest policy dictates wh=
ether
+the certificate passed through the migrate-sev-set-info command will be
+validated. SEND_UPDATE_DATA is called to encrypt the guest private pages.
+After migration is completed, SEND_FINISH is called to destroy the encrypt=
ion
+context and make the VM non-runnable to protect it against cloning.
+
+On the target machine, RECEIVE_START is called first to create an
+incoming encryption context. The RECEIVE_UPDATE_DATA is called to copy
+the received encrypted page into guest memory. After migration has
+completed, RECEIVE_FINISH is called to make the VM runnable.
+
+For more information about the migration see SEV API Appendix A
+Usage flow (Live migration section).
+
+NOTE:
+To protect against the memory clone SEV APIs are designed to make the VM
+unrunnable in case of the migration failure.
=20
 References
 -----------------
--=20
2.17.1


