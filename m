Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C18C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 23:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E30E120679
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 23:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sZ4SZqV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30E120679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsxwC-0003LS-91
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 19:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50783)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Babu.Moger@amd.com>) id 1hsxtr-0006qI-J0
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 19:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1hsxtq-0008LC-E5
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 19:20:51 -0400
Received: from mail-eopbgr760058.outbound.protection.outlook.com
 ([40.107.76.58]:41104 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1hsxtq-0008JS-97
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 19:20:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJWvKKkoK7Ni6rhi5lro38yANCdDXrw8prpruevS0FbTTQdVrT2igKISQlOFiMDTcVd1ufHCuiw3YtnNqHPqWYCFVrpojamN1OusMxuFz/PfUkmKb0rKMgUyB8zEsNn0ptteuK0E1A4j+BYXnVKBNSwBL7IYY3MnpWsFG1ev/JqnL0dzxr3LhWUFxJugV/Lmw8XHEpkd9e8DLtE3dc7Si3SxvE8VAPfkrNOI87uYtOXaM18YSzlOV/6G8tlB1aCmhMOGcV4ZsavILcRvefP7gC0OEqAw7OcAvKW9xLPl/NdqmufxPPiPpzkA2LlTd8wr70cKPshD3FjGtzt/SDearA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6sFDgWbAq8TJDAg7wykmL5vrYP49jvqWhrlVCwSXwk=;
 b=TeDSb3Y6gM+bigz4d6sHrnwBtzzIKYLR3gyV3UhpoaVtQg6n/ItSSuWRsi3Ujdi/ixOlWrx1zV5Hn7lV8eUmRgKsyCEZ7xNGH5whJL04nubUA7HvTPXhGQ7BdBVfTlHHiuOEVjC59+UMD3cgyaDaKYs6ugis3PNkIuG4BhkmRW11y6sFyS3Ku3myFP5VSSQUhGiXGNvvSDxfguusmxe7lHvreymMNd7BSMiOnCMaC3TKeVyqv6sMs2jRWJYmDKcXLoKJHvU5VEZODU36ZLw5E8hyx+nJxtLpG+HJmCJsjDm1XAPo68WvbeDM60KCBl3IcJOLOfR4SrdJJlI3Qrot+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6sFDgWbAq8TJDAg7wykmL5vrYP49jvqWhrlVCwSXwk=;
 b=sZ4SZqV6dTI3UT73NY+c0SONuFxQXSSUdC7savJOfRQ7nXBWpr5Oz0PNuXqBrguWYVZcmnjlt6AcpN51omK3MjZTB8k/KExbUXw2abRA0H7jXkPbj/EKNlPymj6PBuFDTFGoKCB8kVJAtK9RF8ztrRRn7YFNGIDlY8JeRxTK3yI=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2550.namprd12.prod.outlook.com (52.132.141.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 23:20:47 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::ecb0:375b:9347:fe67]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::ecb0:375b:9347:fe67%7]) with mapi id 15.20.2136.010; Wed, 31 Jul 2019
 23:20:47 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: "ehabkost@redhat.com" <ehabkost@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net"
 <rth@twiddle.net>, "imammedo@redhat.com" <imammedo@redhat.com>
Thread-Topic: [RFC PATCH 1/5] hw/boards: Add sockets in CpuTopology structure
Thread-Index: AQHVR/aVBapKuUuGJEu2eneWm/XN9Q==
Date: Wed, 31 Jul 2019 23:20:46 +0000
Message-ID: <20190731232032.51786-2-babu.moger@amd.com>
References: <20190731232032.51786-1-babu.moger@amd.com>
In-Reply-To: <20190731232032.51786-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0050.namprd12.prod.outlook.com
 (2603:10b6:802:20::21) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 733e30e4-3113-4b40-7eff-08d7160db793
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM5PR12MB2550; 
x-ms-traffictypediagnostic: DM5PR12MB2550:
x-microsoft-antispam-prvs: <DM5PR12MB25504EA2B2EBAE72A92A8F1995DF0@DM5PR12MB2550.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(199004)(189003)(8936002)(7736002)(2501003)(50226002)(36756003)(1076003)(11346002)(8676002)(6436002)(81166006)(81156014)(305945005)(68736007)(54906003)(110136005)(53936002)(6486002)(66066001)(478600001)(64756008)(2906002)(316002)(5660300002)(14454004)(66556008)(102836004)(386003)(256004)(71200400001)(6506007)(71190400001)(86362001)(486006)(26005)(99286004)(76176011)(186003)(66476007)(3846002)(66946007)(4326008)(6512007)(66446008)(6116002)(2201001)(25786009)(2616005)(476003)(52116002)(446003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2550;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2Pdz3eTAKr2RauXl+VnD3iM18EvCnhAk46McAdkjcZ5QCR63FcxSz6jIMiUdl2qhsfqD6p3zP0QskZluqXvzCvPu7b0CuInz4FmFo/R6TbEVWKV/Jz1+zED2BATGmiEgjRBmYdETXDqpASKG+V6a074LC9YNbpeKu2h2LIBupCYTFzgLktlmkExpn6XEyxHHC3RfSsqM7FyAGtsXx89aANPNYQamANL5AJc39dlom7OlmbJp4jrwOPs2wjepMZ9HZcJvmE/fi0/z1fQ9vZvJCZhhBuhdRUz0tEEiflUZSHbffyb+3WIXK/aeOh0gVZZfX/MaRV8/BHL62lmAFt0WLwV5y4GLDc6PgS10JgkPe4dyT3WkE+oMuVgUbvYmKxSNEgjfBENFkrGXuVjYKqfgZ54VZn/BB9BqiCGR8bzCSbo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733e30e4-3113-4b40-7eff-08d7160db793
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 23:20:46.9935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmoger@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2550
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.76.58
Subject: [Qemu-devel] [RFC PATCH 1/5] hw/boards: Add sockets in CpuTopology
 structure
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
Cc: "Moger, Babu" <Babu.Moger@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add sockets in CpuTopology. This is required when building
the CPU topology.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/core/machine.c   | 1 +
 hw/i386/pc.c        | 1 +
 include/hw/boards.h | 2 ++
 vl.c                | 1 +
 4 files changed, 5 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index c58a8e594e..4034b7e903 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -795,6 +795,7 @@ static void smp_parse(MachineState *ms, QemuOpts *opts)
         ms->smp.cpus =3D cpus;
         ms->smp.cores =3D cores;
         ms->smp.threads =3D threads;
+        ms->smp.sockets =3D sockets;
     }
=20
     if (ms->smp.cpus > 1) {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 549c437050..ef39463fd5 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1605,6 +1605,7 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
         ms->smp.cpus =3D cpus;
         ms->smp.cores =3D cores;
         ms->smp.threads =3D threads;
+        ms->smp.sockets =3D sockets;
         pcms->smp_dies =3D dies;
     }
=20
diff --git a/include/hw/boards.h b/include/hw/boards.h
index a71d1a53a5..12eb5032a5 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -245,12 +245,14 @@ typedef struct DeviceMemoryState {
  * @cpus: the number of present logical processors on the machine
  * @cores: the number of cores in one package
  * @threads: the number of threads in one core
+ * @sockets: the number of sockets on the machine
  * @max_cpus: the maximum number of logical processors on the machine
  */
 typedef struct CpuTopology {
     unsigned int cpus;
     unsigned int cores;
     unsigned int threads;
+    unsigned int sockets;
     unsigned int max_cpus;
 } CpuTopology;
=20
diff --git a/vl.c b/vl.c
index b426b32134..d8faf5ab43 100644
--- a/vl.c
+++ b/vl.c
@@ -3981,6 +3981,7 @@ int main(int argc, char **argv, char **envp)
     current_machine->smp.max_cpus =3D machine_class->default_cpus;
     current_machine->smp.cores =3D 1;
     current_machine->smp.threads =3D 1;
+    current_machine->smp.sockets =3D 1;
=20
     machine_class->smp_parse(current_machine,
         qemu_opts_find(qemu_find_opts("smp-opts"), NULL));
--=20
2.20.1


