Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D0DC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 23:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D5420679
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 23:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YQff77a7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D5420679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsxvw-0002jP-Be
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 19:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50842)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Babu.Moger@amd.com>) id 1hsxtv-0006z9-Gi
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 19:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1hsxtu-0008Rb-Hp
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 19:20:55 -0400
Received: from mail-eopbgr720053.outbound.protection.outlook.com
 ([40.107.72.53]:30923 helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1hsxtu-0008P5-Aj
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 19:20:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y73Ck/yayK1/E+08z6qo/p7mJ0/uo/AClfROdsv+xBw4praazterN9krVBjv3P2duby1Datg47ZLTtvh75BXRpp/l0WDcyBkyxCe0Or9EpIcdGRn8rCtoSTctVH2E1c3Mpdk+37kUzOyb8e2Z8ISItvdNYLdoyRE9Atlwa2TrNAvam5nHHn6Mia8q1E9zLuNxuVcxEMgONqMRQddo2W8yP4aRxwBER7QrMaIDu7KDZvGw5iDH7NJdrhmH1mHMWU4vAjtJuMkH2n049hXwufLA3A6qxM8K8RGgdz8fuJfrg8f6m9cQcdaUOWDUHNbUUYqqSdBh4KB7wgYAIadOnh0zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jb2oLu/YXMn8C8zTSuCIbXvWmCyUHcgsH19ILPn+fo=;
 b=TdJ0mDBmFyLhSWkcu5mZzWhVIkdofuAhAEKXMAlvmuYyBzmkjNhWg19p7I/WL0c8+tFhZAoODJRwZC7nCWoUziNeQmEIYJdQguojRz1DEbfFM+jet2TDuNpHf2Ikx2CmyDV1aDOwuELZdwwzxTLWxUZDHIxWp9WzH58MGMwvPeEwWNi+kLWHwmuZBdkon1Jy5EIMU2y+AZ1C9BoFXTtUmlRlAQ5voErhVx7mZ6IM/o3Nna+uzGpTZF7DQyrjhyCeUO/p57RYdOJegxK4BhSsdPW2W0F0w0/AGqCiD0y9SCG8iYO3lBLD/Fja91n0S9JRfzGg9jyyHGjUefnlK9WFeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jb2oLu/YXMn8C8zTSuCIbXvWmCyUHcgsH19ILPn+fo=;
 b=YQff77a7d844Qe9lkUJNoOVui44Xku39RPgmIkH+HrmIguWTLlaaoLA4h6v90Zv6fUYylVWm7RH+a1arAcKPz2WRchByv/Dq/kCPssIu1e5PEnnlhxP4xZGCeFkvNvXGGPa4/lKoZPVXdO/gSCK194LnBHtJ2GGTwMHrzJsVy3Y=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1657.namprd12.prod.outlook.com (10.172.38.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 23:20:51 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::ecb0:375b:9347:fe67]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::ecb0:375b:9347:fe67%7]) with mapi id 15.20.2136.010; Wed, 31 Jul 2019
 23:20:51 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: "ehabkost@redhat.com" <ehabkost@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net"
 <rth@twiddle.net>, "imammedo@redhat.com" <imammedo@redhat.com>
Thread-Topic: [RFC PATCH 5/5] i386: Fix pkg_id offset EPYC
Thread-Index: AQHVR/aXpDsOnsB4hUqhnkMdXogqLw==
Date: Wed, 31 Jul 2019 23:20:51 +0000
Message-ID: <20190731232032.51786-6-babu.moger@amd.com>
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
x-ms-office365-filtering-correlation-id: 89f0f405-669a-460d-c6f3-08d7160dba4f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM5PR12MB1657; 
x-ms-traffictypediagnostic: DM5PR12MB1657:
x-microsoft-antispam-prvs: <DM5PR12MB1657DA95535A1AA970B5BD2195DF0@DM5PR12MB1657.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(199004)(189003)(50226002)(7736002)(316002)(14444005)(256004)(102836004)(2201001)(66446008)(66556008)(6506007)(54906003)(2616005)(66476007)(76176011)(66066001)(1076003)(2906002)(8676002)(446003)(26005)(66946007)(53936002)(476003)(2501003)(305945005)(110136005)(64756008)(52116002)(4326008)(81156014)(68736007)(86362001)(14454004)(6512007)(386003)(99286004)(25786009)(11346002)(3846002)(6436002)(71200400001)(71190400001)(36756003)(6116002)(81166006)(8936002)(6486002)(478600001)(486006)(186003)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1657;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8RFhaqRb3BPlTowAHVq0Avww/zg94SrNddEaMS9rXpL4UEUPwSNjOGOsUjHr2QTAztNMmb5TTv7CJ0UQOUxjbtQMrt3m880NxHMdMaeSby9qXIZwbriGcuEU7+W5LgMWnVLLStUcRhHeHiQ1Y+6Wlnnkmg9TEwA/14JoP5zGygFKWPwOxdyjWQPLfB69/UXMzob872AijmbLRMqPoTCN7XPnMVBzkyYhRNBF2cZPQsFVrP2sncvNTM7VqVkqbxC0eJUTk0CBxKGQuRCJM4LVnXvg/frW3NytZ0rwGbBT69Q4DuerftOU0i/LGtUsWA0kwMW+zYj5VBBDmAuELNlWuLnGJbkw+MiillGHyCHyExbZzLN5RTaA5UbBbBTKNQE7Ir/L6zR7C5lqKOpp8BYpf6ZVuyz1SJlwEqQ+gKjHj3U=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f0f405-669a-460d-c6f3-08d7160dba4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 23:20:51.4929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmoger@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1657
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.72.53
Subject: [Qemu-devel] [RFC PATCH 5/5] i386: Fix pkg_id offset EPYC
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

Per Processor Programming Reference (PPR) for AMD Family 17h Models,
the pkg_id offset in apicid is 6. Fix the offset based on EPYC models.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index be4583068c..235496a9c1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4079,7 +4079,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, =
uint32_t count,
     MachineState *ms =3D MACHINE(qdev_get_machine());
     X86CPU *cpu =3D env_archcpu(env);
     CPUState *cs =3D env_cpu(env);
-    uint32_t die_offset;
+    uint32_t die_offset, pkg_offset;
     uint32_t limit;
     uint32_t signature[3];
=20
@@ -4102,6 +4102,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index,=
 uint32_t count,
         index =3D env->cpuid_level;
     }
=20
+    if (!strncmp(ms->cpu_type, "EPYC", 4))
+        pkg_offset =3D PKG_OFFSET_EPYC;
+    else
+        pkg_offset =3D apicid_pkg_offset(env->nr_dies, cs->nr_cores,
+                                       cs->nr_threads);
+
     switch(index) {
     case 0:
         *eax =3D env->cpuid_level;
@@ -4260,8 +4266,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, =
uint32_t count,
             *ecx |=3D CPUID_TOPOLOGY_LEVEL_SMT;
             break;
         case 1:
-            *eax =3D apicid_pkg_offset(env->nr_dies,
-                                     cs->nr_cores, cs->nr_threads);
+            *eax =3D pkg_offset;
             *ebx =3D cs->nr_cores * cs->nr_threads;
             *ecx |=3D CPUID_TOPOLOGY_LEVEL_CORE;
             break;
@@ -4297,8 +4302,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, =
uint32_t count,
             *ecx |=3D CPUID_TOPOLOGY_LEVEL_CORE;
             break;
         case 2:
-            *eax =3D apicid_pkg_offset(env->nr_dies, cs->nr_cores,
-                                                   cs->nr_threads);
+            *eax =3D pkg_offset;
             *ebx =3D env->nr_dies * cs->nr_cores * cs->nr_threads;
             *ecx |=3D CPUID_TOPOLOGY_LEVEL_DIE;
             break;
--=20
2.20.1


