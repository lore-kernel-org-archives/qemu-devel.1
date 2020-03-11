Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54572C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17EC521927
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TBlYy0xs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17EC521927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBrG9-0008Hc-7E
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 22:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jBrBt-0008LO-5x
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jBrBs-0006sm-57
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:33:49 -0400
Received: from mail-co1nam11on2074.outbound.protection.outlook.com
 ([40.107.220.74]:34631 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jBrBr-0006pV-T3
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:33:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCIbRqf7lcmjIpMilT0YK3U5YUEDZj8OJzCrec878tPBhAGgqvOfCxqvvUcqGeYVp+LQ7KEhIDygdULVIcNd4qXjccZUHPfACBqwO7KBsTB+4IYatY1rhoxnzDNuBHDZwLRasNQ8XW7bwlIdI3pXZHhBp/rqRE2BmR1Cy8c2CSUvp+Iyp2CPUDMNKqh/Ihl/G/gzuEr51KQIvwZPO7WL5ayGLhBl7nZfLYE87OgjreDmA18Wu5SZZxypkWEIOmnYa2PRLwN35seX/3Hff/kafwVSYmeWNVHPiwouVDC7j1mFtbLW7Qy69V2sodhKlkfr9KoTIFyd4z7TcL9oADjFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUEACMzjxBBMOrvSY6IyyV48F4VTD6Ww42kLfwPUHHE=;
 b=iqPvjXd5JFER5yBw+b6tr3jj5uSjAj8542YLG02o5rzOqnVAozkKbh2vcMgIz2gxAPhwCxeogmo7lHqsX8SQtzIoeEScLxSps6JjHfgVo4GOJRWVjloJxhiylAGxdrXdMe6vD5UhH2N8yaabii/GgqbWsO5KYQRhArUZiH7uwNukuYU0/6RRGLR7mmW0BH/1tWJQgXLAJlZA/vXWbGzsAo+REv7D3hpDBg3QZzQkW+tzg/m4KvO0wzz9/HNicAYsAZVJ+KOP8rmU+4OIZvQrAYQFtCR0mp171JI4IUYyoHt+PekBomu0UX3S6FLnOm/Hgt+Hk1JNXgqvlTMu2V9Cww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUEACMzjxBBMOrvSY6IyyV48F4VTD6Ww42kLfwPUHHE=;
 b=TBlYy0xsCuDoEvJyqUN4Y+Y3PzLZ/BJP2F7OM67e6sb9uXy0dfD/2Vq6fSk5Ug0IvN0DK548T00EV7XCjwJCPUFfK9v2sEfXnQ2ugQBaOBZqA/3CNMAhqK3cS6xI33ebYSYcMuw65scQVtUXGoimxVVGuXkgf35/GOX3VZXhsOY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2493.namprd12.prod.outlook.com (2603:10b6:802:2d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Wed, 11 Mar
 2020 02:33:46 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 02:33:46 +0000
Subject: [PATCH v6 04/13] hw/i386: Remove unnecessary initialization in
 x86_cpu_new
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 10 Mar 2020 21:33:44 -0500
Message-ID: <158389402482.22020.17707923191340692971.stgit@naples-babu.amd.com>
In-Reply-To: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
References: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0136.namprd05.prod.outlook.com
 (2603:10b6:803:2c::14) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 SN4PR0501CA0136.namprd05.prod.outlook.com (2603:10b6:803:2c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.6 via Frontend
 Transport; Wed, 11 Mar 2020 02:33:45 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f2e032a-2afe-44e7-0954-08d7c5649f65
X-MS-TrafficTypeDiagnostic: SN1PR12MB2493:|SN1PR12MB2493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2493AB8545BF886759EE520995FC0@SN1PR12MB2493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(199004)(86362001)(44832011)(55016002)(66946007)(4744005)(956004)(8936002)(316002)(8676002)(5660300002)(66476007)(52116002)(7696005)(103116003)(66556008)(81166006)(4326008)(478600001)(16526019)(2906002)(186003)(81156014)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2493;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rd8lh+q2Qp5fkffoE1lG4Q0wX95cqGQcznCi/PwJRpI6d/xb856ku9ekdf/0Um2Cv7gLzzRZQlciaJ308fJCq7ovV24qjsVg/qXCN4qMiBTysvK77QSE9aOH9Etdx+uysEGyoV9F/nOFQCJzSAZnPfgssQ9ZbdOxCHD2miJ6p81uDx96oijVME1iobUFuXI8Z+XFJRcVJZyUwJ1n03W5pdkVi0k811fkgtiPtekJOy6FRCwVBy1gnd3feZU1C8n8+05copMJ+fxqeH/MZ0kPsO3f4jHGUQRSFJTGyqRVNymu+hidqY2F3KBCBQ5ducMS7prEKOAxuB4L+zcKvrlXB5GRqjzFrrg6nej97OSLw8wCugz+3PnO7XWN4wo0pzsIwg1sYBo8JLqwdRY8cTTeZhf2nBBXX3SmymqkajuPJTdWwoE+cT7F5Mw4A+c4gbby
X-MS-Exchange-AntiSpam-MessageData: Xa3b9l9Q13fr1lptiP9txQTYAiLJ2rOXdiGhqOwcWAICvnU/rav03oUKhxHyHPu1Cfu4xa9Jn8DHf+PFE7rWWH2jZ4TOcxZHfNJDmifoGKKmGaNGRycmqfx2Pa+hrBtyxkHNnoqMcMlo1dK02FcY6w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2e032a-2afe-44e7-0954-08d7c5649f65
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 02:33:45.9274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3IHy9T7p8UNa0apAD4QVWBPdY8edd0DnrZyUjlGJvXFJvt30NFEFdqA2AcuNYpW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2493
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.74
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The function pc_cpu_pre_plug takes care of initialization of CPUX86State.
So, remove the initialization here.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/x86.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 03b8962c98..79badcc4ec 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -103,13 +103,9 @@ void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
 {
     Object *cpu = NULL;
     Error *local_err = NULL;
-    CPUX86State *env = NULL;
 
     cpu = object_new(MACHINE(x86ms)->cpu_type);
 
-    env = &X86_CPU(cpu)->env;
-    env->nr_dies = x86ms->smp_dies;
-
     object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
     object_property_set_bool(cpu, true, "realized", &local_err);
 


