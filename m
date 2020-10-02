Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83198C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2070206A1
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EXbwckKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2070206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOMnR-0001Dk-22
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Wei.Huang2@amd.com>)
 id 1kOMlJ-0007hu-I2
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:14:21 -0400
Received: from mail-eopbgr760050.outbound.protection.outlook.com
 ([40.107.76.50]:56724 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Wei.Huang2@amd.com>)
 id 1kOMlH-0000YW-PR
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:14:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmDOmMzjc9wnvcCAXcb22WnSZD5bJcIJsuiagnBODLd8yZQbNznFE27eVr1G+e9KfBR6xm3XfyR9++dON4QJH+kqeO4zXLkTfnLG1BFumDrjy6hUCgBEZnHbOccf6DgcogbWu+HzgZFVL4uCoqeUty7DvUyBeFwZHjal0zxFtYWv33fOy5f/9F1ZU8ffDTM5tpdffi4vYhEWDbSHnfKeyWZCaKYuvg3If8bUfhJUC8kQMPgF785hf2aJkD5dZhEo5p4Q86+/rwyqDRUD14+NS2bOSnZu6O9JNoJJrY5fODG0++kzDXMkCMGAZgWKwHib8Iusf9vZIehjqsR0ESNZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x79xrtU3Ls9lT/cuxa8oVXbUHFhrJWyup/zQn5stInA=;
 b=Nez1adtj8ro4eiacPvUt8LwRU0HVC4PvcVP0ue29s2XJRBZIzX3z/xjmbXUit4WlPFfZkgAO2q0AvvzseAjS2yJGVUdwUKvYJA0CPVwmWIMaUBSBaZrOVjE3UA0gkyArImwHAlb7bSCTDt+BR4I/SexP0s8e+pg0tyru1a9QEAOPvNBJ5cZY5Pb/3K7LPidGw7BwIMsvY/RdaSyQkgCwQMGWYd5B7+yPD2LKn6GZThRLQQQmDht8mhP2O0RALopD5dIjq6fERfnwyblYdTRD1IzmxSXeEZ/9pGrQewKlkDsC0bo8h2dneme4ge2tz/RrgrctiOFTNovKi75CbSTPXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x79xrtU3Ls9lT/cuxa8oVXbUHFhrJWyup/zQn5stInA=;
 b=EXbwckKvedpwTAWUlMKY2OE/6jIP4Rt06gczUNsaVKhtd+qmuNjBdoojvjk6dwrQfFhZBxaihAdq/G02dGc+9Wj9w1u+TPVa17np5TJkyYAuzkZsZkFlPyh9TYGt0Tr3DVqnXq97oXPv2s1FC9Nskjg11ceQQ8tWynX9xqNyPKk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22)
 by CY4PR1201MB2485.namprd12.prod.outlook.com (2603:10b6:903:d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Fri, 2 Oct
 2020 14:59:14 +0000
Received: from CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::11f9:59c8:16c0:7718]) by CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::11f9:59c8:16c0:7718%8]) with mapi id 15.20.3433.038; Fri, 2 Oct 2020
 14:59:14 +0000
From: Wei Huang <wei.huang2@amd.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V2 0/3] Passthru device support under emulated amd-iommu
Date: Fri,  2 Oct 2020 09:59:04 -0500
Message-Id: <20201002145907.1294353-1-wei.huang2@amd.com>
X-Mailer: git-send-email 2.25.2
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SA9PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:806:a7::32) To CY4PR12MB1494.namprd12.prod.outlook.com
 (2603:10b6:910:f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx56bbhost.amd.com (165.204.78.2) by
 SA9PR10CA0027.namprd10.prod.outlook.com (2603:10b6:806:a7::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.35 via Frontend Transport; Fri, 2 Oct 2020 14:59:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ed2121fe-9c58-437e-2926-08d866e3ba61
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2485:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB248500C5E922645FFB3C04F4CF310@CY4PR1201MB2485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RJYyqHvofR2cM3L26rGk6kEhxoZk8vhV1aeK+/yoO/XQ+GGSfPPq7VrQJg+NZlpByyWAvjohtWw9y77r9V9U7uahSJq4mdOvWXZHOyWR2/UcUyXf32wkQEO/0Px3DGM6qJjVX4xlf3a5PoSW7knvME34Tzi3311DUxAMvc4F72Ys3XnHdDQdEdecFHkEWhoLt5BIiS450OVsCrRy4iDft9THP8FIfBsNYsVAvBH1KPvuHZI0osaQZ0gbcygeRArzGVRxHP3eB/TnjXF0vPeguwRYOH+zDHdyh0ul2j2lT3MZNgfVEcQ12gi8m11IPxnNWm0ZgrIr0mHzw/IrmTYy1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1494.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(8936002)(6916009)(7696005)(6486002)(186003)(8676002)(478600001)(4326008)(26005)(316002)(2616005)(956004)(6666004)(83380400001)(1076003)(52116002)(5660300002)(2906002)(36756003)(16526019)(86362001)(4744005)(66946007)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: HKBa21GMEDYfjg2I/bDQgJMhZvWUpgLHpXD+KNkg1219/n7HUfyLDXbtUMgBM80SS20TRkghFtGWxeYMWjJuW9JCAKOHe5OwILIkSIl3kWMano9x3eLcTxGt1FeHvinsq8Qjrntc+JSI4lTKy6B+KC8gaLQmSrKBC9bT3sUCy9C77L5Rm3VEcWIiDUICnCSKhbNO/HK1GzkVxoxNQSShUCQ4trNzVTEAo+EH7BYYgrFxVqJQQ6oyYTXvtgnOX6YgysWXCxvI1M/qb+e4ipJ/T5CT8T0AJn467q2sYe7JzZGuGe9gXTSiNZdwhlS5ZZJFsC9sJU4ZD7irO2q8M2AdURKwQMnt4XxjT55/wiNiXr5vMrcS89u0WgYrTQlMa5vaxFx9eWvMfSe+BjKfmT3Sj3Yl6hpLtjS+WxMyEDq5P+ueM1luPp5UfqkbTnElcPHK98g/BvRNok33vxCn+sU9ZG9OzZ8PvgVr5EuRGGfhKeI+X0e46dUmv4gRGJmw3kSX79SBHqL9leO3Q/5kyXHibHo+cd4XbKiViLGuE5G/NJcVioQnAdDvwak2R9uOP/BO1wjPldb8lXW1ZzLPQGST/XSvaxLBfo8g39ACiCtGU4ZSGPflpYJwCkge3qnjICW8lqG3ljFWWOLDgkge+bUEtw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2121fe-9c58-437e-2926-08d866e3ba61
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 14:59:14.6292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxyG7le4FR1zBudTC3gUEZPx6F26D2HMOn4GEVgjRCqV9iUz7nOd1lsrEOqp1dVY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2485
Received-SPF: none client-ip=40.107.76.50; envelope-from=Wei.Huang2@amd.com;
 helo=NAM02-CY1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 11:14:18
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: ehabkost@redhat.com, mst@redhat.com, wei.huang2@amd.com, peterx@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, Suravee.Suthikulpanit@amd.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset adds support for passthru devices to run inside VMs under
the management of an emulated amd-iommu device (vIOMMU). This feature
has a variety of benefits, including enhanced I/O security and user-mode
driver support, for guest VMs.

This patchset has been tested with various 1G and 10G (SR-IOV) NICs on
AMD boxes.

V1->V2:
 * Remove unnecessary VFIO_IOMMU_MAP_DMA errno check (Alex Williamson)

Thanks,
-Wei

Wei Huang (3):
  amd-iommu: Add address space notifier and replay support
  amd-iommu: Sync IOVA-to-GPA translation during page invalidation
  amd-iommu: Fix amdvi_mmio_trace() to differentiate MMIO R/W

 hw/i386/amd_iommu.c | 243 ++++++++++++++++++++++++++++++++++++++++++--
 hw/i386/amd_iommu.h |  13 +++
 2 files changed, 245 insertions(+), 11 deletions(-)

-- 
2.25.2


