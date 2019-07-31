Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AA3C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 23:21:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07DBA20659
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 23:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SSNJMk+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DBA20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsxui-0000I0-9d
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 19:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50844)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Babu.Moger@amd.com>) id 1hsxtv-0006zg-Lc
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 19:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1hsxtu-0008R6-2X
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 19:20:55 -0400
Received: from mail-eopbgr720053.outbound.protection.outlook.com
 ([40.107.72.53]:30923 helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1hsxtt-0008P5-PC
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 19:20:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PngItcifDRi5l8sUtacs7MfSNn1tHA6Yz6sxOLyaNn9Zhq5XaTLVgB97hsjeZOyRtm0KmrsT8cdnKytwYZ2Wgvd21EO4xazQwor/2y9/jnL9zoPS5qLjOjYxOTtj5p86fcu+VVm6Cb8wGmXoD+4bgN9Z70s7XLkF91qxPo68gdlXd5Nbj1ImW21VPijZrfwx7mI91bihjqSR8/x3GI23yw+W46J09ZJK/waHIrn4L010JydJZ+dFaf/BgqTG3DKcpFtK/KGUBgEQPXxcvub5zufLb7emwIIcv9o+WEc6pYPThl1j36MMssFU41aQOISI88+7cnGfTttLzw9nYDYFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnDxsRvroJRPcCLozpmbXk4usK3uhc1+r25Diea4d2I=;
 b=c0HQJZQe8/m2pafNFqB+8V1wO34iDEtUAtp8djUt3JiTd5HbZ62q+TgBTrLYVZhSZ+hJtR25B0MflkHpgWdRWWAw1KY79f4haAO+xnsib4cLrpAoELf/5q04JdKivaItEDY2aHxHtIdOeByKAvDoyLvvM7NB0piR1UMhB7zaEiA8wkcnuItwKxD6OWdNVYpyjaJyo7WaqH4uQuJvjNZJg+nS7Vmy0JIVwi8yqSUdmODx3G+RV0Tv0p1B248cmPf9N5RcthPAVaXvLOjotF6vq1a/mWxZJ/osoZf0JXy+LtO33/OzaLLtq/wXinFUM8gbHYR+RkQcfvIe4Fz29mk7nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnDxsRvroJRPcCLozpmbXk4usK3uhc1+r25Diea4d2I=;
 b=SSNJMk+t/+RVggw5MFE4N8zGzt47ZotMQcwCAoL+JI2P1gw3J7N084VvZLCYZqJpojPwF2EinpYCNIHzmkp9imZ2ud2bjKU2bygd508GrINtY4h/itbQZB3C/CfqvcQm0DFfH4sHk/WXig7fAp4Fe8XMlFYJQ3cFR3HTeZKBJNM=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1657.namprd12.prod.outlook.com (10.172.38.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 23:20:50 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::ecb0:375b:9347:fe67]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::ecb0:375b:9347:fe67%7]) with mapi id 15.20.2136.010; Wed, 31 Jul 2019
 23:20:50 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: "ehabkost@redhat.com" <ehabkost@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net"
 <rth@twiddle.net>, "imammedo@redhat.com" <imammedo@redhat.com>
Thread-Topic: [RFC PATCH 4/5] hw/i386: Generate apicid based on cpu_type
Thread-Index: AQHVR/aXbkLSW+hCAEaO8Uc/WmhXTw==
Date: Wed, 31 Jul 2019 23:20:50 +0000
Message-ID: <20190731232032.51786-5-babu.moger@amd.com>
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
x-ms-office365-filtering-correlation-id: bcd9c1e5-0831-4207-afd3-08d7160db9ab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM5PR12MB1657; 
x-ms-traffictypediagnostic: DM5PR12MB1657:
x-microsoft-antispam-prvs: <DM5PR12MB1657B032AA2C15C9FD57406395DF0@DM5PR12MB1657.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(199004)(189003)(50226002)(7736002)(316002)(14444005)(256004)(102836004)(2201001)(66446008)(66556008)(6506007)(54906003)(2616005)(66476007)(76176011)(66066001)(1076003)(2906002)(8676002)(446003)(26005)(66946007)(53936002)(476003)(2501003)(305945005)(110136005)(64756008)(52116002)(4326008)(81156014)(68736007)(86362001)(14454004)(6512007)(386003)(99286004)(25786009)(11346002)(3846002)(6436002)(71200400001)(71190400001)(36756003)(6116002)(81166006)(8936002)(6486002)(478600001)(486006)(186003)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1657;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: daOIdJK4L8Ue4waZFU6hO0FgYUDv0xPgvbEQ8+QQcizO6FDF+5pcBrTKzX/dpcSrQ7KtRUsoVQAyP/yJsVrL9rX3ebqAXkNnfGVUJ0vPiBYwusRhDfq7k/kc/u+1QwdVzkFHYnMlpIv94qSB+aJaAmJs7XPsbX+4jR6IYUGDpTVkOEOSuW4A60H4Mn6nX4mj6i06a2hWEhE61gvNkFkwexEt3GWjGAVJ2xQ7KUCGlBaRqsSMoyJRYxZjQbGkAlP3yvo284fLLIKVOOS3+ifgBO7xk4rCiPqSO5YOKJzPhNOSEpVEwuzg2F6e8kZgPL/ZfN+Z46XLc1ZJTYfemtuNa0ITMEuiDQPzh07rhxETTi9zct1dUUlZ8Vhj6xRy9LWuKlnTpiPosZGq++6Ec9vtNjHlVeFAPGuLtlMAAZ45l+0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd9c1e5-0831-4207-afd3-08d7160db9ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 23:20:50.4315 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmoger@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1657
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.72.53
Subject: [Qemu-devel] [RFC PATCH 4/5] hw/i386: Generate apicid based on
 cpu_type
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

Check the cpu_type before calling the apicid functions
from topology.h.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/pc.c | 81 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 70 insertions(+), 11 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ef39463fd5..dad55c940f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -947,6 +947,36 @@ static uint32_t x86_cpu_apic_id_from_index(PCMachineSt=
ate *pcms,
     }
 }
=20
+/* Calculates initial APIC ID for a specific CPU index
+ *
+ * Currently we need to be able to calculate the APIC ID from the CPU inde=
x
+ * alone (without requiring a CPU object), as the QEMU<->Seabios interface=
s have
+ * no concept of "CPU index", and the NUMA tables on fw_cfg need the APIC =
ID of
+ * all CPUs up to max_cpus.
+ */
+static uint32_t x86_cpu_apic_id_from_index_epyc(PCMachineState *pcms,
+                                                unsigned int cpu_index)
+{
+    MachineState *ms =3D MACHINE(pcms);
+    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
+    uint32_t correct_id;
+    static bool warned;
+
+    correct_id =3D x86_apicid_from_cpu_idx_epyc(nb_numa_nodes, ms->smp.soc=
kets,
+		                              ms->smp.cores, ms->smp.threads,
+					      cpu_index);
+    if (pcmc->compat_apic_id_mode) {
+        if (cpu_index !=3D correct_id && !warned && !qtest_enabled()) {
+            error_report("APIC IDs set in compatibility mode, "
+                         "CPU topology won't match the configuration");
+            warned =3D true;
+        }
+        return cpu_index;
+    } else {
+        return correct_id;
+    }
+}
+
 static void pc_build_smbios(PCMachineState *pcms)
 {
     uint8_t *smbios_tables, *smbios_anchor;
@@ -1619,7 +1649,7 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
 void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)
 {
     PCMachineState *pcms =3D PC_MACHINE(ms);
-    int64_t apic_id =3D x86_cpu_apic_id_from_index(pcms, id);
+    int64_t apic_id;
     Error *local_err =3D NULL;
=20
     if (id < 0) {
@@ -1627,6 +1657,11 @@ void pc_hot_add_cpu(MachineState *ms, const int64_t =
id, Error **errp)
         return;
     }
=20
+    if(!strncmp(ms->cpu_type, "EPYC", 4))
+        apic_id =3D x86_cpu_apic_id_from_index_epyc(pcms, id);
+    else
+        apic_id =3D x86_cpu_apic_id_from_index(pcms, id);
+
     if (apic_id >=3D ACPI_CPU_HOTPLUG_ID_LIMIT) {
         error_setg(errp, "Unable to add CPU: %" PRIi64
                    ", resulting APIC ID (%" PRIi64 ") is too large",
@@ -1658,8 +1693,13 @@ void pc_cpus_init(PCMachineState *pcms)
      *
      * This is used for FW_CFG_MAX_CPUS. See comments on bochs_bios_init()=
.
      */
-    pcms->apic_id_limit =3D x86_cpu_apic_id_from_index(pcms,
-                                                     ms->smp.max_cpus - 1)=
 + 1;
+    if(!strncmp(ms->cpu_type, "EPYC", 4))
+        pcms->apic_id_limit =3D x86_cpu_apic_id_from_index_epyc(pcms,
+                                                              ms->smp.max_=
cpus - 1) + 1;
+    else
+        pcms->apic_id_limit =3D x86_cpu_apic_id_from_index(pcms,
+                                                         ms->smp.max_cpus =
- 1) + 1;
+
     possible_cpus =3D mc->possible_cpu_arch_ids(ms);
     for (i =3D 0; i < ms->smp.cpus; i++) {
         pc_new_cpu(pcms, possible_cpus->cpus[i].arch_id, &error_fatal);
@@ -2387,6 +2427,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_d=
ev,
     PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
     unsigned int smp_cores =3D ms->smp.cores;
     unsigned int smp_threads =3D ms->smp.threads;
+    unsigned int smp_sockets =3D ms->smp.sockets;
=20
     if(!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
         error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
@@ -2437,16 +2478,26 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug=
_dev,
         topo.die_id =3D cpu->die_id;
         topo.core_id =3D cpu->core_id;
         topo.smt_id =3D cpu->thread_id;
-        cpu->apic_id =3D apicid_from_topo_ids(pcms->smp_dies, smp_cores,
-                                            smp_threads, &topo);
+	if (!strncmp(ms->cpu_type, "EPYC", 4)) {
+            x86_topo_ids_from_idx_epyc(nb_numa_nodes, smp_sockets, smp_cor=
es,
+                                       smp_threads, idx, &topo);
+            cpu->apic_id =3D apicid_from_topo_ids_epyc(smp_cores, smp_thre=
ads,
+                                                     &topo);
+	} else
+            cpu->apic_id =3D apicid_from_topo_ids(pcms->smp_dies, smp_core=
s,
+                                                smp_threads, &topo);
     }
=20
     cpu_slot =3D pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
     if (!cpu_slot) {
         MachineState *ms =3D MACHINE(pcms);
=20
-        x86_topo_ids_from_apicid(cpu->apic_id, pcms->smp_dies,
-                                 smp_cores, smp_threads, &topo);
+        if(!strncmp(ms->cpu_type, "EPYC", 4))
+            x86_topo_ids_from_apicid_epyc(cpu->apic_id, pcms->smp_dies,
+                                          smp_cores, smp_threads, &topo);
+        else
+            x86_topo_ids_from_apicid(cpu->apic_id, pcms->smp_dies,
+                                     smp_cores, smp_threads, &topo);
         error_setg(errp,
             "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
             " APIC ID %" PRIu32 ", valid index range 0:%d",
@@ -2874,10 +2925,18 @@ static const CPUArchIdList *pc_possible_cpu_arch_id=
s(MachineState *ms)
=20
         ms->possible_cpus->cpus[i].type =3D ms->cpu_type;
         ms->possible_cpus->cpus[i].vcpus_count =3D 1;
-        ms->possible_cpus->cpus[i].arch_id =3D x86_cpu_apic_id_from_index(=
pcms, i);
-        x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
-                                 pcms->smp_dies, ms->smp.cores,
-                                 ms->smp.threads, &topo);
+	if(!strncmp(ms->cpu_type, "EPYC", 4)) {
+            ms->possible_cpus->cpus[i].arch_id =3D
+                            x86_cpu_apic_id_from_index_epyc(pcms, i);
+            x86_topo_ids_from_apicid_epyc(ms->possible_cpus->cpus[i].arch_=
id,
+                                          pcms->smp_dies, ms->smp.cores,
+					  ms->smp.threads, &topo);
+	} else {
+            ms->possible_cpus->cpus[i].arch_id =3D x86_cpu_apic_id_from_in=
dex(pcms, i);
+            x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
+                                     pcms->smp_dies, ms->smp.cores,
+                                     ms->smp.threads, &topo);
+	}
         ms->possible_cpus->cpus[i].props.has_socket_id =3D true;
         ms->possible_cpus->cpus[i].props.socket_id =3D topo.pkg_id;
         ms->possible_cpus->cpus[i].props.has_die_id =3D true;
--=20
2.20.1


