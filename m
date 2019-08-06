Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB29C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CBF12075B
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RUpJviFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CBF12075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv2kZ-0005ls-TU
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 12:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50914)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2je-0003zm-Pn
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2jd-0003jK-Fz
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:54 -0400
Received: from mail-eopbgr710055.outbound.protection.outlook.com
 ([40.107.71.55]:41284 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hv2jd-0003ei-8m
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L173UNSmQf66xqIbcb5/2SwghOcN//5TW9azIzKopXgT/f5QzbW93NTYhJy4s3uZbvmsUcaCjDPx7HCwh7EFS5u9lh2eHBqeuiU+Hv/GFDUAR5/YMkEPxfQt3ApDsKAceoUmnY0Ick5pff/JrOAsb8YuOsfQqoQUKjr5Yc9wQqICiUcbCsXirXeri2fPhEbXcqAr4fotaboa7q9SWvTr9D4KPPMp2RhAh3H+QuwLaYd6H6OK1V8n3Cvm8WQnvr5UMLt9pcjHW1I25LVEbqyTQaaZ6MPKfeiIapg74MTnVPR7sUevME03wpMfH5TloYFUF6NCwUDWWKn8v9yhy4j0OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6soHEA5gB8MdOevNrVmlDVZlyMRavhxxrbrgoJuGuRc=;
 b=L/TJeZOtQ1ujR9K4ZO5cBdC2plZPkldbRX7d3A0YXW1/OK8+aSlWPYwEm8NKXj30Ab0PTrn6ocmGDgUdsxzzBZU+zXb526byrxRk1+O+3V1ZUhZyTuj1SBscfNZsyTdwbwohz3Vnv9oYBTaSlAosmZamcdSMx5wOBx9pCQ4+tAEM0s/t+7xpfLcwIv6VcsVxQETM1LQmAIjAcvwMJ0ft3cAEdGrExXusXSh7g0AFlQWqTe1O0aiL2YUL8TywomsPy453K1XoIY2TzQBgE2/QrOU8zF1tvR6azFfFU5vksGynShyuga51/peibiQ742d7XuZDJbLXBin3t4Rse9mNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6soHEA5gB8MdOevNrVmlDVZlyMRavhxxrbrgoJuGuRc=;
 b=RUpJviFnZNISLFykaYVQd3FavLXgaAOggNKJbLyJbhS2oQqWHaSTGB0FJNjkEAoKLTOsmrhjg20B3GPdRy+5Lj0Z4ILocB+S9gHVFctri5Kp6IT3bw78hQfsOu4GTa1pAhJVKpPnogPa0aGCqq14VAA+cqNopLUU+5nLE1htJsQ=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.118.13) by
 DM6PR12MB4233.namprd12.prod.outlook.com (10.141.184.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Tue, 6 Aug 2019 16:54:51 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71%7]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 16:54:51 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 05/14] hw/machine: add helper to query the memory
 encryption state
Thread-Index: AQHVTHepbE/4ZRGpG0qc0vVAe0/C4g==
Date: Tue, 6 Aug 2019 16:54:50 +0000
Message-ID: <20190806165429.19327-6-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: 8974d773-adde-493a-5653-08d71a8ecbb5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB4233; 
x-ms-traffictypediagnostic: DM6PR12MB4233:
x-microsoft-antispam-prvs: <DM6PR12MB4233574E052CDFB5EE47FFB7E5D50@DM6PR12MB4233.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(2501003)(71200400001)(36756003)(81166006)(71190400001)(81156014)(54906003)(5660300002)(1076003)(25786009)(7736002)(6116002)(305945005)(8676002)(76176011)(6916009)(68736007)(3846002)(8936002)(2351001)(99286004)(478600001)(102836004)(64756008)(66946007)(66446008)(66476007)(386003)(6506007)(66556008)(26005)(4326008)(50226002)(2616005)(186003)(476003)(6512007)(6486002)(486006)(86362001)(5640700003)(53936002)(66066001)(316002)(14454004)(11346002)(2906002)(446003)(256004)(6436002)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4233;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZzNfX3lhTBIKSpUkSNAK5Dp4OMYPvO0+3pd8I+pi9IM0uFkZ7Rb06VrTMqloR3gG8tusAgSmbzHsrkQMM4rK/g9FEhd7ErG97OHlTjTMKIYkA09c8jR6JxA0BYW1F4R3/aTkHbuHvEBfD3y2diWOHAfQnnqHnrYkvGAD4c9heM45HSDFE/5iChRTWXSvgl+nOuIcwk1IfVOU8zne/mMD2EJ7UYZ8zVCKxFXfVSYF7K+4IggZdanKa9NgM1AQGyooWA89sEzkg1KwmE6D0UY+1OHs63WWGEPiQ9p2HiyhWGfK+E1xt5JcbI09FyzA0m5R3QBZh7Sf7vYxuKcBVP2rDi3CyfL20CbKfuRnFkgQYHWepI0K4laOhu3Yp0557TFeTA8UXJX3O/VJzzhBMJEvvpDYcyi0Y148S7bto7SI/es=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8974d773-adde-493a-5653-08d71a8ecbb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 16:54:50.4320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.55
Subject: [Qemu-devel] [PATCH v3 05/14] hw/machine: add helper to query the
 memory encryption state
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

To enable a memory encryption inside a VM, user must pass the object
name used for the encryption in command line parameter as shown below.

# $(QEMU) \
  -machine memory-encryption=3D<object_name>

Add a helper machine_memory_encryption_enabled() which will return a bool
indicating whether the encryption object has been specified in the command
line parameter.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 hw/core/machine.c   | 5 +++++
 include/hw/boards.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index c58a8e594e..f1e1b3661f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1031,6 +1031,11 @@ bool machine_mem_merge(MachineState *machine)
     return machine->mem_merge;
 }
=20
+bool machine_memory_encryption_enabled(MachineState *machine)
+{
+    return machine->memory_encryption ? true : false;
+}
+
 static char *cpu_slot_to_string(const CPUArchId *cpu)
 {
     GString *s =3D g_string_new(NULL);
diff --git a/include/hw/boards.h b/include/hw/boards.h
index a71d1a53a5..c5446a39cf 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -76,6 +76,7 @@ void machine_set_cpu_numa_node(MachineState *machine,
                                Error **errp);
=20
 void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const char *=
type);
+bool machine_memory_encryption_enabled(MachineState *machine);
=20
=20
 /**
--=20
2.17.1


