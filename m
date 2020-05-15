Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCF9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 16:36:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7125C206C0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 16:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NwLvfw0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7125C206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZdJd-0005b5-IV
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 12:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <figlesia@xilinx.com>)
 id 1jZbdS-0000Xs-OR
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:48:26 -0400
Received: from mail-mw2nam10on2047.outbound.protection.outlook.com
 ([40.107.94.47]:14560 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <figlesia@xilinx.com>)
 id 1jZbdR-0001ci-HD
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:48:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqgJpe8xB72rvTtKv3l628g2Xl35PNJb5dCpcZLWuSh+EO+9zegKRygj3a9riosmmPBLJqD0LaOEFUHEL81dPowimAiNAY/msS2s7zw9eARBvlGj0ez66sNsMu20oyuoXFkJdWDbMofUEFveP1pAneD6U86/Pjwu5mfUl1AcEHpSeZSicKlwHUHgNwcDIcbEsDf6SWwxy6EPIN+QRMslq2Kcc83VYc4E/442u+Hs8J6qwVnDS3AUXoW4b5tu6EenRZPb9ZmXFlX2ZshJ5LB1EODRKTQxIFbNw+um4yqGvJF3QTX3aFuGlnXyts7vdEoUVLhacF5WMAZrCXwYktE3eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IJYBlu/hGOiwWcwUOuMDnfvyRXPb8U+6PLLqLfqYY4=;
 b=iIHl0BfhVRXqdI236yrei7Swko3A3+C9HOonJAuVornyHzZf/4q1t3Jn10Px/N/O6c6nanHwOUn7XF12a/BEykTsC5tOinL/wf2flIzCNGhk/auQUQ+rgG8OiC+aUuGCfJQCp+5aF3puCiWfwxSavltObysPkW8QpwcLEZag4JhNzei89HDovrj/LV6ioAMY5WOz5VZwZXsHMURRUqlZkeBqShBB1IMoOJnAQ/hTZsboKjvUlhUnE1AboBmKMpLOZe6ssqqQyS7WiGsy3WnEPbeGi5ej8dFu6TreXz+hob2bxpdXGRD8Bi/r2oHd9ceOz4zvfeetjE8n2qCBHXY2MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IJYBlu/hGOiwWcwUOuMDnfvyRXPb8U+6PLLqLfqYY4=;
 b=NwLvfw0ZvBFngVk+CPKlOaDd5UD4CNFI3PIQDnUoiFhBwx8RQBhLRc7pChpEkqMIUzDbf28b63FxcmlQisHWdLzR4WW0i4/nWkMmetI/I1gJ9Ty1dsn6S85gww+R092el9q6YsDYXVBHOa/4Y//okYpve0iMriR+SQhuhwPHVAk=
Received: from SN4PR0201CA0046.namprd02.prod.outlook.com
 (2603:10b6:803:2e::32) by BYAPR02MB4775.namprd02.prod.outlook.com
 (2603:10b6:a03:41::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Fri, 15 May
 2020 14:48:23 +0000
Received: from SN1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2e:cafe::60) by SN4PR0201CA0046.outlook.office365.com
 (2603:10b6:803:2e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend
 Transport; Fri, 15 May 2020 14:48:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT023.mail.protection.outlook.com (10.152.72.156) with Microsoft SMTP
 Server id 15.20.3000.19 via Frontend Transport; Fri, 15 May 2020 14:48:22
 +0000
Received: from [149.199.38.66] (port=53865 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <francisco.iglesias@xilinx.com>) id 1jZbd3-0005C4-Gl
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:48:01 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <francisco.iglesias@xilinx.com>) id 1jZbdN-00081k-Rh
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:48:21 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04FEmK8P019077; 
 Fri, 15 May 2020 07:48:20 -0700
Received: from [10.23.123.155] (helo=debian)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <francisco.iglesias@xilinx.com>)
 id 1jZbdM-00081d-Bf; Fri, 15 May 2020 07:48:20 -0700
Date: Fri, 15 May 2020 15:48:18 +0100
From: Francisco Iglesias <francisco.iglesias@xilinx.com>
To: Vikram Garhwal <fnu.vikram@xilinx.com>
Subject: Re: [PATCH v4 4/4] MAINTAINERS: Add maintainer entry for Xilinx
 ZynqMP CAN controller
Message-ID: <20200515144817.autpx5nibkmqmsqr@debian>
References: <1589314552-1375-1-git-send-email-fnu.vikram@xilinx.com>
 <1589314552-1375-5-git-send-email-fnu.vikram@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589314552-1375-5-git-send-email-fnu.vikram@xilinx.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(136003)(376002)(346002)(39850400004)(396003)(46966005)(186003)(82740400003)(316002)(44832011)(26005)(9576002)(4744005)(8936002)(478600001)(33716001)(82310400002)(9786002)(2906002)(6862004)(426003)(356005)(70586007)(70206006)(81166007)(9686003)(47076004)(8676002)(1076003)(6636002)(5660300002)(4326008)(336012);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd65510b-dbb6-4e0c-e3ae-08d7f8df03cf
X-MS-TrafficTypeDiagnostic: BYAPR02MB4775:
X-Microsoft-Antispam-PRVS: <BYAPR02MB4775BCC6265ED3F1CD72597CADBD0@BYAPR02MB4775.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:513;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8K5JLCj5YnEzulNV6QzlKRVFUfn6yHJDhjxk3DXQdito/QjwrXLd4dBhnCnz6+7SnLphTfzUNNfEwOYGf11QPeIs94ZKHXRG1zkWim5qhrM66dcW2gLCdc/sIqhXsv1GIgDg/KhUOpnjrHEHRa/c24IFH+b21DLydJTML/V+uxCV20kAzyLeA9UMdZdnNHOXakxuZapW641aKYlSogPv2S4LFURZd3SB0sPjcXGRN/AIc2gkW/gBxeJVgLXTLtUQSsjyb2Rl8bqO4MJM/48tJ8b5pfVdEIuua78REV0DXzCpZM4Y1lcfPBFlZZ/Az5qgBTasxaJdq/gd6EuBEdflXZ6onqaUytRHMIbSzTdiUaB+fvIeRLuPD1HElxm6zVkAUofKVddVDV2UxWzxoVUmTe3Da3/4wD1ia/jQglYCZM5I/qgUS6YvKIoLnxWAArrEtbNYidxuGHug4pMNA176QJcK6aD/jZMWu2sftJX1uPgpzBUn1vY/EwcFAxf8wtl/A678uaxola/gnBLnosR5zA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 14:48:22.1535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd65510b-dbb6-4e0c-e3ae-08d7f8df03cf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4775
Received-SPF: pass client-ip=40.107.94.47; envelope-from=figlesia@xilinx.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 10:48:24
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 15 May 2020 12:32:36 -0400
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

On Tue, May 12, 2020 at 01:15:52PM -0700, Vikram Garhwal wrote:
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@xilinx.com>

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8cbc1fa..b53d75e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1433,6 +1433,14 @@ F: hw/net/opencores_eth.c
>  
>  Devices
>  -------
> +Xilinx CAN
> +M: Vikram Garhwal <fnu.vikram@xilinx.com>
> +M: Francisco Iglesias <francisco.iglesias@xilinx.com>
> +S: Maintained
> +F: hw/net/can/xlnx-*
> +F: include/hw/net/xlnx-*
> +F: tests/qtest/xlnx-can-test*
> +
>  EDU
>  M: Jiri Slaby <jslaby@suse.cz>
>  S: Maintained
> -- 
> 2.7.4
> 

