Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DD8C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 20:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80167206E5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 20:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Gze7BgCR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80167206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMzeY-0004Gg-E2
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 16:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Wei.Huang2@amd.com>)
 id 1kMzdP-0003p7-MR
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 16:20:32 -0400
Received: from mail-co1nam11on2041.outbound.protection.outlook.com
 ([40.107.220.41]:7040 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Wei.Huang2@amd.com>)
 id 1kMzdK-0000QR-6t
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 16:20:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfikRbiDENHAlDnJWDW9XoPXe1w4CSEMN2dMXtiBSSpsbEATF/JPb0xa6CTkBTCglHYhSsl1giii7roFn1XrNVF5haUJNZfv38XY0fBNAvDq0G65O6Llj2kt0h7jdwDSQ0wHZJ+cQnKMOiSle3p+/BOmMZLNBbrwWB5MfO+ARqonC/jD8VBJmqVzGDPLSG+FlqEaFM6v65u9EaiuQW5Ktc2eNQ/Ohcqix6/WlQN5ZKD9Ro4yLh71YzufANq1yl2SRs3XpVVHzGVt8nWjop0VkTYlVDCFzZ1TSDqtJoUUIx2Yo8xKKzoZH1CSVZPRLmy7lpsj8tbJZ9FMgDsknY+ZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bfu5gvPSJleXMGxtvvjKZJGXXpS7+4jcMiKOU6XgrLs=;
 b=kkQfyGAzQ6gDt8BzHBDTLIOQFHSaaiMutOHrGXw4/c+WJYTG54FRpwf65YVGgl8+O9MitVWPlXUzYbNUrJY0ErY4P9/RCCcMfAtrm38oHf5ENd7lOSCvxcs2YPZZ9BN+T92MgiMfmgC3MQAepeOXAEFt/gtTxNO3/2FjtwBg2LAAyvQSm2Zu8G3YYIDdf6ygJLwGcKjjraSEvsV95n/IlhfeFEQFtPltzoT9UJUD2hn9c4HsE8Lfodht4BRwxrIUoxKQEVN3oGuKDN3ivjq7iE8lpo8mIFuOTvgzrvsRojwcmNYEmq0V+xZnT9fCMepq3tGegKyPLsOL+Ylrerq1ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bfu5gvPSJleXMGxtvvjKZJGXXpS7+4jcMiKOU6XgrLs=;
 b=Gze7BgCR0OavRnJN4XX+8RXpIxJdJGBD1r9WWdmdAyMZizESQ0xo5Z7LZV0eqU/1UK7GW4k2x6aBwmBHlTT/ELJS724kreLO3GbT9HxZvkffrfhxToeea734ZVRgWeGkkLUZrxwu2F16gQRRp/zswAqWwoGyJ03d7eoLZkZjjkw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22)
 by CY4PR1201MB0023.namprd12.prod.outlook.com (2603:10b6:910:1f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Mon, 28 Sep
 2020 20:05:14 +0000
Received: from CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::11f9:59c8:16c0:7718]) by CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::11f9:59c8:16c0:7718%8]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 20:05:14 +0000
From: Wei Huang <wei.huang2@amd.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 0/3] Passthru device support under emulated amd-iommu
Date: Mon, 28 Sep 2020 15:05:03 -0500
Message-Id: <20200928200506.75441-1-wei.huang2@amd.com>
X-Mailer: git-send-email 2.25.2
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: DM3PR11CA0017.namprd11.prod.outlook.com
 (2603:10b6:0:54::27) To CY4PR12MB1494.namprd12.prod.outlook.com
 (2603:10b6:910:f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx56bbhost.amd.com (165.204.78.2) by
 DM3PR11CA0017.namprd11.prod.outlook.com (2603:10b6:0:54::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Mon, 28 Sep 2020 20:05:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5501c452-7c73-4e2c-0eee-08d863e9cfad
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0023:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00236A053095ACDC48422C07CF350@CY4PR1201MB0023.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pokUtKDw1iGZ7k8FElW+AVadzs+gqa/saGe1HZu1wxVXAGmPUacox2PUTjAy3FbqUkBO7xc9P1h5pK5nSg0ijIl/+dirAU6rIjhwVD4YREwaEkBUoe7nRK2LxGQhZn1bL7G9zoOSM34Xw92SaaDY0S+Jw3TEGWsBNY/wHaE+Jm8sh2mUP8VppaGPFCfei23CGkawo99ocNaHRBXdi+4C9xeyKBj2cKUVgPSC4Bmy3dR+VwHJMUkzfd5YHILPgjelBvpyslIzOIWrYjnAhBBS8nK2A3GzBag2Ig3Owik5v2EpzHMOKDCmpJ5bVI9L0rGYUTmiVe9Is12anJdgWDXzdlp/OK8pCrCjHW2+oQA8GOeWl08FOUjsv0AJJZZp+62P
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1494.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(6486002)(4326008)(316002)(2906002)(8676002)(86362001)(8936002)(6666004)(4744005)(478600001)(16526019)(5660300002)(186003)(26005)(1076003)(6916009)(83380400001)(66946007)(2616005)(52116002)(7696005)(66476007)(956004)(36756003)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: XaHFa5xrP83s40TS2n6/NuRzz9qXfCMnSoBdmRHGYs0wNlnatMPRpcREn1lRer+xu7yIQKxyAH83Wc+vvyLKWCgbslQW2RJ/myyoi3a6CTks0ZhfmCtCIhnrjOk+05xoimMj3sEq8ZvKMTGlwVc4SNpsYf40vftdJXzuIQFywFnMxX3YH2Qr9t2qJyv8gienHRZilQm0rDEXhSFQ+sWzAwCWC2gQywoLvAqzS4izmK+tp6pOr1hyirPJb8RgvQnPqyTmk79PXCJN5JNLJAyIryW2fgcjiDk8Yalvb9Y5bZonHwqZmpDgfNV3t4KZm2FTbfZpBv/mEqN+XGM4g30SqYSOa1u3//Bz0KQhWtzbdpK+/44NuTBcEnpicuhcom1pjeWJmr+0Gcv2V4wLmLlPinyec8tEXt+aewCY0bYtI68eqnCgH2U62lHCQn4KeqGwOvLaZRFcgodFnWb550485YVNVe1BDQHVTatUUHeDvNH92VyBgrvmSO+rujQs2KvE/kOeoBablPsl+MZ/JxZZTBFw8mvitspc8F8M6ZTYSFW4/YviT961GVcudmUG4ZCqK3/ueNKCGSRDS1xhiTEHT/r7kzlUjJqnPW3IehNO/iM0TLFOSRHwJjNeLiNSwLTpsHRNaIpf3BKExPZ/SeUOag==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5501c452-7c73-4e2c-0eee-08d863e9cfad
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 20:05:13.8618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pykm0Iklkqs4LyK53ocCIO775aqwX1asEIzEC+KcrKoZVEjU5hnuwlylCXVIxvjb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0023
Received-SPF: none client-ip=40.107.220.41; envelope-from=Wei.Huang2@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 16:20:18
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.614, SPF_HELO_PASS=-0.001,
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

This patchset has been tested with both 1G and 10G NICs on AMD boxes.

Thanks,
-Wei

Wei Huang (3):
  amd-iommu: Add address space notifier and replay support
  amd-iommu: Sync IOVA-to-GPA translation during page invalidation
  amd-iommu: Fix up amdvi_mmio_trace() to differentiate MMIO R/W

 hw/i386/amd_iommu.c | 243 ++++++++++++++++++++++++++++++++++++++++++--
 hw/i386/amd_iommu.h |  13 +++
 hw/vfio/common.c    |   3 +-
 3 files changed, 247 insertions(+), 12 deletions(-)

-- 
2.25.2


