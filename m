Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46AAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F59F20702
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LTcKIWwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F59F20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv5hR-0006J3-PX
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 15:37:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1iv5gS-0005Be-Qt
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:36:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1iv5gR-00010W-NW
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:36:04 -0500
Received: from mail-mw2nam10on2056.outbound.protection.outlook.com
 ([40.107.94.56]:48388 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1iv5gR-0000yZ-Dy
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:36:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+CUKV/SCgJPGS1YB4NbVx8zUumXL9uydUsHnA35rh4iqGJDepOUaj9i/iw0TfUx07iqnaALxxk3cWIBMkOCFzD+O+ZdaE65JIPJAFRHQcrhUq0YM518d0bssXm9KjhfJDfYNOietmWkq1zasgQ5/zcztZVNCmWmXdiVTB/Kh9FkTn/7LQ5cKIw2YpfisgIzjpllZczM8ON+olO1ob0q6/VwHLpg0A9r8EluDlwF49ZuMm4dHMmIALbiP/6+5fmSoPu2/c0c+JP3hS8YDbhzMmVN/qthsMG4LTaxnM8Nc6yHmzwub4IPg9/d4xu3a8QLdxHNnUZm+dkB026YQGqImA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKyQGit5A6vr62a/T+vq9oIfbUk32PTIwD810Rzty5Y=;
 b=R7H5qVlql5cpHUiMK3iyoIBbZ2SXvwxPNkVMexghBFLbR3KaHtg56fmoZwYfjcnQ5WJiVdZ79XWhx1qF3O4Xn0YOdtaKoLgEOAoRduyUNMQMlpkECai32jK9HzoR01H82uN9VjjLObR6IduI2hk33iJA4WYdc0vtFEfDo+VxgRckSDGEDU9+ugZ93z5++Fn3Q+oudb3oDKAcE3EanA4m59qAuufwc35CJno+843X1FlIzq7OqkoUOSgM2FZYmrLVOGJhRjsRiimI5R9zaafMucWOmh0+avoPZ+iEvJHnJ31jCHyziRDltO+JL7yrbqyPa8/CHZ7YQTG58qfr3lynXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKyQGit5A6vr62a/T+vq9oIfbUk32PTIwD810Rzty5Y=;
 b=LTcKIWwON1gHb4YjFi2Vt9zpa8QC9d+6V7o5HfI5AqTU7u7ihEN1KbXlbytkZ4I8wX0OFuaIv5wUplXL4JrKXj96TM/pflR9dylVEvADjpAXkW3nfdo5zRP9IckN2Bj1uvtxZyYZoyo8PXriE8oyqnGfkJIhTCe17e0OFWlukdE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1142.namprd12.prod.outlook.com (10.168.168.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.21; Fri, 24 Jan 2020 20:36:00 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd%7]) with mapi id 15.20.2665.017; Fri, 24 Jan 2020
 20:36:00 +0000
Subject: Re: [PATCH v2 0/2] Add support for 2nd generation AMD EPYC processors
To: "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
References: <157314957337.23828.3860599077487615762.stgit@naples-babu.amd.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <d69d6c10-9b37-075b-7dd4-1f0a6dd46dc4@amd.com>
Date: Fri, 24 Jan 2020 14:35:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <157314957337.23828.3860599077487615762.stgit@naples-babu.amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0701CA0003.namprd07.prod.outlook.com
 (2603:10b6:803:28::13) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from [10.236.30.87] (165.204.77.1) by
 SN4PR0701CA0003.namprd07.prod.outlook.com (2603:10b6:803:28::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend
 Transport; Fri, 24 Jan 2020 20:35:59 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd6f94ce-4685-4cea-7a41-08d7a10d05f1
X-MS-TrafficTypeDiagnostic: CY4PR12MB1142:
X-Microsoft-Antispam-PRVS: <CY4PR12MB11423072573421E906252B05950E0@CY4PR12MB1142.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02929ECF07
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(199004)(189003)(8676002)(5660300002)(8936002)(81156014)(4326008)(6486002)(81166006)(4744005)(52116002)(26005)(53546011)(186003)(16526019)(31686004)(966005)(36756003)(956004)(2616005)(44832011)(478600001)(66946007)(2906002)(31696002)(16576012)(316002)(66476007)(86362001)(66556008)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1142;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RxqAorO9Lcah6fsZrhuWNLTU/TorAlsPsnvv+nPXFMlIFR2UiKurFh5tYAAfktrjXFKfqCk5LA5O3X9eiJnNecYAL56VczdcLDGNVDQxHC8xokMvT2m2ejCkDf7YvpsaE6TOEkggfeegdAu2SsJ9hTPRUbFfwCvnPT/74Yp3L423n2CNWGSm5gmmRkL/rgzff+930aznYT9R6f7+xwwZKsg+EMcD1sB+KREkPJyVEMTfyoZZ8sQ/1qpb+qnTFDJw9p/VkPu1/Thk79cs6HHKa/prGZnrTms/HeFjFbpLsz0tQg4cQRiNy3hGj4D9Tlbco+zRHhEc+uOc5qERzP9SMmfC+G8QIyJ2FOoG2agwwXZ4CfQpQz2tRKoWujM9KhnulEqMOD9pDuQOEuf1tCoUc2PkeQ9KN5nOzIUmaJuIOroUma9rrYSTST8lDqTneCZcSNId3z5NBaeITNvMZfbnZ6wlVua+KxGGpuaYb0KMTWM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6f94ce-4685-4cea-7a41-08d7a10d05f1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2020 20:36:00.6631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFEIMlepwhQQ2LNYL3lj7UCdis8GXm9f27kePf8KocJEJyx6MGDqHVZ3NbWxJ5T9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1142
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.56
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Its been a while. Pinging again.  Please review.

On 11/7/19 12:00 PM, Moger, Babu wrote:
> The following series adds the support for 2nd generation AMD EPYC Processors
> on qemu guests. The model display name for 2nd generation will be EPYC-Rome.
> 
> Also fixes few missed cpu feature bits in 1st generation EPYC models.
> 
> The Reference documents are available at
> https://developer.amd.com/wp-content/resources/55803_0.54-PUB.pdf
> https://www.amd.com/system/files/TechDocs/24594.pdf
> 
> ---
> v2: Used the versioned CPU models instead of machine-type-based CPU
>     compatibility (commented by Eduardo).
> 
> Babu Moger (2):
>       i386: Add missing cpu feature bits in EPYC model
>       i386: Add 2nd Generation AMD EPYC processors
> 
> 
>  target/i386/cpu.c |  119 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  target/i386/cpu.h |    2 +
>  2 files changed, 116 insertions(+), 5 deletions(-)
> 
> --
> 

