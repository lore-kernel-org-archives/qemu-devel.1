Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A41C432C3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:16:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5AAB206E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="E+FE1dcP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AAB206E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icJGu-00054C-W1
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 20:16:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1icIuE-0005Y0-JC
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:52:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1icIfx-0002kr-AZ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:37:55 -0500
Received: from mail-mw2nam10on2073.outbound.protection.outlook.com
 ([40.107.94.73]:6181 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1icIfw-0002eK-Ct
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:37:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Swj29ePkLaZiyxpVbew4P5jmFXg0MOVWAPyiU3ek03b9PlU0NJt/p3kbRs7haMYaTpxBE64yNyH//Ov1zZTX34LNA8q6G2eNnhk6AtN8W0wYbEeHzGrry6Dh5xSHqfp0ei1VmnxCWD6m41hMZ97vQUpEYiYl5AtwNSQH+nstbb/SPXSJuDAWPHQc+wHfeyLLtTgcsaq75wqNgXy36nvHhtXNRFFIlIyI1PH08eUX/Hd0Rhb0+/3fqCMjG0bC1vXlFkvdKiAJ5i13vQ4mgcPt6oaMlY4an+g30HlzLNpHmplfHqibpJuMHS5dFeVrSZWOu4AYCDA3VZozZK9QicYABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix8c/PtEEOOwOANOssRCT/pBUdLDBw3u2WhLzpYRHIM=;
 b=ZUxiKHe0q6zyk82zaPac2WvB3aVn79FLQqIPa8mZv5RAuoj3RKza5UHJMUiECsQy/M9+uvO7SQrdEQHyh2dOBAzLHvV3TLntHmNlFeVp7j0VPwEdC/kDnlwTkTuGenbEE3l+2uIBuuMuNnqp/oS5F1FUxdtloLCxCkHI7gDn/5D0z8PTSPUKuZodyCVbXvWhK+5xurq1YmgA6kdGfTJfaZXRoryN3X816zDn6Byuw6l+fVRAgDKI0rjPIcTLhv3gqQb8Sp5DDEysVV+QIlWxF94Sw/4MEwTISuJWrhinSpcI4ywtrdud6nkIe+eOhw9dO+dTyeggXpfFw7PyUfTUtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix8c/PtEEOOwOANOssRCT/pBUdLDBw3u2WhLzpYRHIM=;
 b=E+FE1dcPShSMJl26lLUsj630PZicTIifeIhbOYKy5Iydpvq5veQ2gsf5rKfJFb1YO6TOqKvgbUuXqkpmXKcPRZivknujP5y9aHTf1bTW8C84jG3viju2ipMo4KuegImItLs+irLvuvcb0iuAeQFWuhVA57dXjQ7WuOt+RO+3wXg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1369.namprd12.prod.outlook.com (10.168.234.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 00:37:45 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 00:37:45 +0000
Subject: [PATCH v3 07/18] machine: Add a new function init_apicid_fn in
 MachineClass
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com, armbru@redhat.com,
 imammedo@redhat.com
Date: Tue, 03 Dec 2019 18:37:42 -0600
Message-ID: <157541986210.46157.5082551407581177819.stgit@naples-babu.amd.com>
In-Reply-To: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0152.namprd05.prod.outlook.com
 (2603:10b6:803:2c::30) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c3adbe13-a5ad-436d-e758-08d778522e60
X-MS-TrafficTypeDiagnostic: DM5PR12MB1369:|DM5PR12MB1369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1369E52F40248DE6BDD38424955D0@DM5PR12MB1369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(189003)(199004)(2906002)(25786009)(103116003)(50466002)(6116002)(5660300002)(498600001)(7736002)(3846002)(66476007)(230700001)(66556008)(6666004)(44832011)(4326008)(11346002)(99286004)(14454004)(446003)(6512007)(23676004)(58126008)(81166006)(76176011)(66946007)(386003)(6506007)(305945005)(6436002)(6486002)(81156014)(2486003)(86362001)(8936002)(52116002)(8676002)(26005)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1369;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ozAqyL4LtRboze/RED0946F157fFWMxmaNroemCvuu3YGr/T5bBtml97lYAtpvK8WiTJUIgucRmxj9TngW0uxDkNEZmI9CVo+H6T5W2AeAo/yz9hg5acD4rlCfmzSwg5I6RbcHHiIzD00wpFHs+4OJHSPYLKsRE1y7Sa9tIqNot94Qjq7q7TDLqkRF9EkMi2alhV/fyxTEXEEXxitXt9HYudqMybZjVU+DWxbuZUtmtb3z8m4b8vaC7oN2iwprapbVmhUQohRjDngx7pFBD2tub6sJYJt7NuG3Yw3tg1z8pcxxdQF6ynrJPTc52V3Apse+UXyC/aoJvKvPiYkSTkCm/9Wqkx9ouc0QypfCD9jHu34DFOtOFeVDEAvMc5STEeor0XELxo9zenX/QCgw+6hooDl6ojGT08qjwgojwKMWBoh5dfEq8XN9+v2X60y7qp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3adbe13-a5ad-436d-e758-08d778522e60
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 00:37:45.8717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cp3TE9NAKVmZWL2BebUVM62d/uqZFvV5Uzs+K1rdfT8DbHlxM432J3qxBhKLb5k5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1369
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.73
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
Cc: babu.moger@amd.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a new function init_apicid_fn in MachineClass to initialize the mode
specific handlers to decode the apic ids.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 include/hw/boards.h |    1 +
 vl.c                |    3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index d4fab218e6..ce5aa365cb 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -238,6 +238,7 @@ struct MachineClass {
                                                          unsigned cpu_index);
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
     int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
+    void (*init_apicid_fn)(MachineState *ms);
 };
 
 /**
diff --git a/vl.c b/vl.c
index a42c24a77f..b6af604e11 100644
--- a/vl.c
+++ b/vl.c
@@ -4318,6 +4318,9 @@ int main(int argc, char **argv, char **envp)
     current_machine->cpu_type = machine_class->default_cpu_type;
     if (cpu_option) {
         current_machine->cpu_type = parse_cpu_option(cpu_option);
+        if (machine_class->init_apicid_fn) {
+            machine_class->init_apicid_fn(current_machine);
+        }
     }
     parse_numa_opts(current_machine);
 


