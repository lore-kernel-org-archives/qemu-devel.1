Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,PI_IMPORTANCE_HIGH,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121D3C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 21:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36D4220759
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 21:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TqVHypUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D4220759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNjME-0007g7-5I
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 17:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Wei.Huang2@amd.com>)
 id 1kNjBT-0005or-Ue
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 16:58:46 -0400
Received: from mail-eopbgr690052.outbound.protection.outlook.com
 ([40.107.69.52]:36746 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Wei.Huang2@amd.com>)
 id 1kNjBN-0007fA-DI
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 16:58:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adZXIg/ekdy/CC6LVI/tcn/KSIsaO+x+5hDJw1ZfmNmDlT60APVDBJw3Dpk+Euaxjfw6HC2BG+B8XqZPKbaxzxOsMcuwzKnoF0ixpoGxUOM31661MJ8ZtyYaUUs6KjXAmAPqq3opYH52iwo1QWEUtClATLrCsanaUzeRBVTI+qxSZBZ+MAElRWLqX2zozukp0ag1ryGhQLQ8ADh6L6MjNNSKCByDxSWeILbJLPEJmiKXVFzD4ZtK2OxSF35x38Pb3yRNivEaTOZz8OP82BANTmI5u4iSJNWTklD6Gaagy26jpeozJbX12MuiGADOJH0Ui5w/4IKu1ADRAo2YdOdHUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UFXVc8aHXdKRtpaXN2Qgmo61VtaGWwY4A7Z19EmO0s=;
 b=QH+ej8oJ0aDP2KyLOL6H6uX9DluMk9P4e2KDiUQVc9SneU22XSsuDZpFJ44+2VZrgDf9eS2lRioKazJj4zIDEPW/y0lyZash5wDBWenbaFl9luWFOAipTQJKxhQdTZ61OxL1QiHdMATV1iJXPrnB0KQrZy/71+T66x9OLeVpNeYhFgOPVWvn061Edu6N6gFjpfKSHg05li4PcmAL4LOUmZE806qFAABWxZAmy10pvx9jpr6ZWFJV33tacjANT89kXtIGkndXkB80MhVFZSXzrzRlJfSYMGNwfVKWBiCUtVUZl/qtro62FuWuXmvUt+qoIDhRVEgUk2eu0XVFDEchGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UFXVc8aHXdKRtpaXN2Qgmo61VtaGWwY4A7Z19EmO0s=;
 b=TqVHypUhpfPtZveE5mv8tcnnpKdbl2P7Lh06o3PtLjj65ZTnhLkGV6tF0QMrFYANnPo8RzufYjrdQhnK9cmMHEYrF/KS8iAFMv1fPOl3GOa1F9JfYIk8FKREsGhtLxgRo8iaVCNaO90dFqlhR1MTHLHzuFzE4BhkY8d47j5LY14=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22)
 by CY4PR1201MB0022.namprd12.prod.outlook.com (2603:10b6:910:1e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Wed, 30 Sep
 2020 20:43:29 +0000
Received: from CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::11f9:59c8:16c0:7718]) by CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::11f9:59c8:16c0:7718%8]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 20:43:29 +0000
Date: Wed, 30 Sep 2020 15:43:26 -0500
From: Wei Huang <wei.huang2@amd.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V1 2/3] amd-iommu: Sync IOVA-to-GPA translation during
 page invalidation
Message-ID: <20200930204326.GA1024738@weilap>
References: <20200928200506.75441-1-wei.huang2@amd.com>
 <20200928200506.75441-3-wei.huang2@amd.com>
 <20200929133414.41982c53@x1.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929133414.41982c53@x1.home>
X-Originating-IP: [24.55.15.93]
X-ClientProxiedBy: MN2PR14CA0026.namprd14.prod.outlook.com
 (2603:10b6:208:23e::31) To CY4PR12MB1494.namprd12.prod.outlook.com
 (2603:10b6:910:f::22)
Importance: high
X-Priority: 1
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (24.55.15.93) by
 MN2PR14CA0026.namprd14.prod.outlook.com (2603:10b6:208:23e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36 via Frontend
 Transport; Wed, 30 Sep 2020 20:43:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 85370383-001c-44c6-2897-08d865817cce
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0022:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00221EDA47EC71351858BBA7CF330@CY4PR1201MB0022.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k6btmSrwY/K0/+WRpjOkBuxnkeZBHrxhoLRPPzh51SEHYmHILQ8hB7C3BktgKmW99cwmPCI/X926di2v4V3HwpfRGe+rsArwU/XlddUcv8H2Iqc93q2m5QQwM11PkrFQDGCey1j1dnyGJmRF0fwVvhDUtqib96lFMmEY9Qiu1TIPcfD2+y+4eoqmCYp9vXEuLMYfy7ZwNvPasNK7AzYhMD+Bmlb+eaVz9VUXo0rL4r1T2E3gZ+28smZHbx+LbwMxPX4kUnTNCoH3XCDZBboZ4FefwS9vzmQZZbfprE9IbyUr2fapRyaNQopoiIOJAicMgGV+I+khUzW4JIjrqW5ILw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1494.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(7916004)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(6916009)(33716001)(6496006)(52116002)(1076003)(66946007)(66556008)(4326008)(83380400001)(478600001)(956004)(33656002)(316002)(66476007)(86362001)(5660300002)(26005)(8936002)(8676002)(186003)(16526019)(6486002)(2906002)(9686003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1/I+My+wCc8bmYpTI1zUMOiwADIKPw62g/H2CCMQBhSTc1VPWQ9Ku9YAowPlY+Go8oAGblB5ajKJEH/K2NsJz1/UMVy+ilRAfGKR01KovD8GDeUQck8Ad0ZqVN2NfsMhuwQe5FcdAxZlcE0AbLTYstPd33BPA7gWC2wHuNf25T0uO8LhNE48QGS3rM1VcKx9aUWGu8DxELEOoHRbrLsuiANq69MIK6dY3M4n2GiSAB7WLhknEA/vdAe6LaKSuOd6j+9X/4MVtPBKnR1S+HwmQvuywbNzo6vaDUmuW3yC7zYwe5wJJ9GvtxsxqlMM8J08ahW6ulyETNY0UNRqHUdj4e5QsOkyworKplFbHABrjjqRo2S/qJPY0ADTbFPTtXGztU3usdbw9m6ZRYmetZEoCrNsKF7vKx81iUK27oLqj3ECWb3AASzyyf9QsqDpjdWTxZ3lWvbJVqo215h8o3fW5lDrv9eFiWhpQz0uCoMFcrEzHzq9h/Yw1fLUa0J4bDCkEg8ptHXkS0UQ0ABWtH8xxR89T1FWoWXMb7bdgRcY1YcMRUZ9x77bFDq9P1nMZL4RaYL7RC5Zd4r/mvZsNk4GlOCP6WtM8jmfmHGaH9QgpTggXxBnKddfGzzOZdjUfbRGZPKRA8Heq4H4K9F2vswskg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85370383-001c-44c6-2897-08d865817cce
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2020 20:43:29.5105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qIobociy7+K+u/buw/wNFWFpNczMyHaLX9AYLGWf+DAl+YwtemeKub3HCi2bhfdc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0022
Received-SPF: none client-ip=40.107.69.52; envelope-from=Wei.Huang2@amd.com;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 16:58:34
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.373, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 peterx@redhat.com, pbonzini@redhat.com, Suravee.Suthikulpanit@amd.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/29 01:34, Alex Williamson wrote:
> On Mon, 28 Sep 2020 15:05:05 -0500
> Wei Huang <wei.huang2@amd.com> wrote:
> 
> > Add support to sync the IOVA-to-GPA translation at the time of IOMMU
> > page invalidation. This function is called when two IOMMU commands,
> > AMDVI_CMD_INVAL_AMDVI_PAGES and AMDVI_CMD_INVAL_AMDVI_ALL, are
> > intercepted. Address space notifiers are called accordingly.
> > 
> > Co-developed-by: Wei Huang <wei.huang2@amd.com>
> > Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> > ---
> >  hw/i386/amd_iommu.c | 177 ++++++++++++++++++++++++++++++++++++++++++++
> >  hw/i386/amd_iommu.h |  10 +++
> >  hw/vfio/common.c    |   3 +-
> >  3 files changed, 189 insertions(+), 1 deletion(-)
> ...
> > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > index 13471ae29436..243216499ce0 100644
> > --- a/hw/vfio/common.c
> > +++ b/hw/vfio/common.c
> > @@ -346,7 +346,8 @@ static int vfio_dma_map(VFIOContainer *container, hwaddr iova,
> >       * the VGA ROM space.
> >       */
> >      if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
> > -        (errno == EBUSY && vfio_dma_unmap(container, iova, size) == 0 &&
> > +        ((errno == EEXIST || errno == EBUSY) &&
> > +         vfio_dma_unmap(container, iova, size) == 0 &&
> >           ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
> >          return 0;
> >      }
> 
> 
> This seems like it should be a separate patch.  AFAICT the commit log
> doesn't even hint at why this change is necessary.  I think the -EBUSY
> error pre-dates vIOMMU as well.  Responding the same for an -EEXIST
> almost suggests a coherency issue between QEMU and the kernel, or a
> direct mapping replacement without an invalidation, which doesn't seem
> to be what this patch is implementing.  Thanks,

I went back to check it. Removing this checking code (original code) didn't
trigger any issues with Intel 10G passthru NIC. I think this was from the
residual debugging code when we started to implement it. Sorry for the
confusion. I will remove this code in V2 with more tests.

-Wei

> 
> Alex
> 

