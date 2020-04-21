Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D56C55182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E372070B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KSVt1Egn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E372070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQs3z-0003IE-H9
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQrwc-0000bv-Bl
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQrwa-0004Sf-EM
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:24:05 -0400
Received: from mail-eopbgr150115.outbound.protection.outlook.com
 ([40.107.15.115]:23622 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQrwZ-0004ME-LN; Tue, 21 Apr 2020 08:24:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCAsxRW+c+DqIq8Z9r24uRs+qM8Q9KE/MK+vGmibSBs3H1enzAW1wzh75rgCYbLB8QacU1BWGiYuLUYOaKTeGYHT/hMjt0S+lVVOxpc+oO9T8vJ6aYrdY6Dwjy7ZSKTfdRhhpZKKN4En5OngLkct9vXjz4A9Q44Fh1rfVVReYrlfGI3HPbwZ2FwUmocR/gHxQE65sM46JxPjCDLp8v9GJZS0odKHRrC5qOKwms/7tIpNietCErGpoY7ha+agTKh8BftL81EIKW+FJ0fsxv8SLJvjpskUBZdrGpTz8CJ/X7PcrzSFADMpxrCtRfppfWjA+Je0qUcfNzphzyPTW0H/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBJ6n8iXupBZzmuyukL4fQPOqMSN7ysBKlubMgJDE/M=;
 b=dlldABSBupLI1tNOnuldMklXcgTu1mJ9QsAdkQVSeI4SGE8QTsV9/wdxKbGJEps1VvILU/IVhivYXUFy5P8uf3Vh1ewWxbHvg90PUwSUPEth1rNvMtZO1hgZ6W6CujG2A0K0BqqlLVcvvMup7Pno3re76yJdrPe0DJ1onWBmHew20z8uW+zoowKp0lUlhj8rVwvmqWjv4myd7AmBJpNYzPcrUMRMLrsSt69bF/4mKFvZU3xgEOUP+nGNM/6vqM0jxQF9woDbCTAMVfQRrrWebsFYB9mIJtAW8px5ySudlG4j7U4Of0W3grQKk3e+NXYTv4IE9QF3c5pScR31TWtEsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBJ6n8iXupBZzmuyukL4fQPOqMSN7ysBKlubMgJDE/M=;
 b=KSVt1Egn1rWX9v+4vL6bBlK/EEPY9GD1fxT7i+JItzGf1WneXDrA8HV/4aCaihy0h7ZAhYnJ1FfxhuKv6Oa6kpyYfpRMZygybxdpw1KnXHB3P5z8EvOslt/9ue7wIZZDsi8Y2u5/cRLS6FfTIpCSl+X/fb4DpA2UCPZGQooo60U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5368.eurprd08.prod.outlook.com (2603:10a6:20b:103::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Tue, 21 Apr
 2020 12:24:00 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 12:24:00 +0000
Subject: Re: [PATCH 1/7] block: prepare block-stream for using COR-filter
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1587407806-109784-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1587407806-109784-2-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200421152358360
Message-ID: <52386567-045e-5e8f-8287-ee8a3edfae72@virtuozzo.com>
Date: Tue, 21 Apr 2020 15:23:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <1587407806-109784-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0130.eurprd05.prod.outlook.com
 (2603:10a6:207:2::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.142) by
 AM3PR05CA0130.eurprd05.prod.outlook.com (2603:10a6:207:2::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29 via Frontend Transport; Tue, 21 Apr 2020 12:23:59 +0000
X-Tagtoolbar-Keys: D20200421152358360
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad9c7559-e614-4ad8-7695-08d7e5eedeff
X-MS-TrafficTypeDiagnostic: AM7PR08MB5368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53688B080A2621FF3BACF1D8C1D50@AM7PR08MB5368.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(39850400004)(136003)(366004)(346002)(376002)(16526019)(2616005)(956004)(31696002)(478600001)(66946007)(186003)(2906002)(26005)(36756003)(4326008)(86362001)(66556008)(66476007)(52116002)(107886003)(16576012)(8936002)(8676002)(31686004)(81156014)(5660300002)(316002)(6486002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kU7kIR604j4SMo3PMtFGEX8XrFLmlIsLjOunEDuT9FcKlGFqDmxH2UUANIxRnsv9b42EoiBeSr/Jh6pJ/JmpBGdCfL/eBmetcoFkNUdwJyeR+c/Q+by2+bpv8FGoXATeGzyZOzfEkFPRZjdJvaodiPfogYY1m8QgvJkDXQPBhLeo1gV4k9/JHIH/c+Xafgk2KfTVcWVnB4Gl6Pp3ttvuzkhvqRkLleYALO5K1Sr4cJdI0RU20SZO8KKr53loUU540GVsM68jdlvBpZPPJzu6opRYTjQW/w3/3VENguUaRrDRkYW0U1ZEJcPPgwP6FjDR00jut0lTgzKOpS+qpRT1Vt4LvP4HG6HsEtWSJYLiHh/12xy/VZIgsMB4hkGzRyDs4aBs/hf9c51C0XzRBBxOZfsMHjVrxVIacUHTKSrkuC4YFawgWPmpEFw40GK4+mUT
X-MS-Exchange-AntiSpam-MessageData: G8mtN8yXxW41QbOmOpYTqkn21bfvG/kb66f1XS2CddlYFCWo1tpq9Vz6gA/hLiXvQzeI9CbhXG++V5IRPThqtdAssoqMjR+7Vt96rI00EjzBWPg87Txao20xHzPy2v1NypQHWLYzIOlb+SVUdV6oKQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9c7559-e614-4ad8-7695-08d7e5eedeff
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 12:24:00.5363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmGbxPGBmbk78pEqQROCDjIwqsuIm8nittfPFzlY1WLM7SMwiHZuL0Cma2bvYqFRFJFHUPX0hbazDK1FlRXlIszbPEcqem1dj7/x6UzEqG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5368
Received-SPF: pass client-ip=40.107.15.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 08:24:01
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.15.115
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.04.2020 21:36, Andrey Shinkevich wrote:
> This patch is the first one in the series where the COR-filter node
> will be hard-coded for using in the block-stream job. The job may
> be run with a block-commit job in parallel. Set the condition to
> avoid the job conflicts.

I think, just skipping all filters from checking is wrong.

What is the problem, exactly?

As I understand, we just need the following logic:

stream job, being started with top and base parameters should:

1. calculate bottom-node = non-filter-overlay(base), which assumes finding
last non-filter in a chain from top to base, excluding base

2. I think, we should leave top as is, even if it is filter, it's up to user.

3. add stream-filter above top

4. Take any locks (freeze, op-blockers, etc) on the chain from stream-filter to bottom-node (including both ends), so nobody should touch these nodes. Do not lock any other nodes.

Similarly, commit job, being started with top and base parameters should:

1. I think, if base is a filter, we should set base = non-filter-overlay(base).

2. I think, we should leave top as is, even if it is filter, it's up to user. (hmm, so, commit may be used to remove filters ?)

3. Add commit-filter above top

4. Take any locks (freeze, op-blockers, etc) on the chain from commit-filter to base (including both ends), so nobody should touch these nodes. Do not lock any other nodes.

====

If we make it behave as such, is there still a problem?

> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   blockdev.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index 758e0b5..72d28ce 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3297,7 +3297,9 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>       }
>   
>       /* Check for op blockers in the whole chain between bs and base */
> -    for (iter = bs; iter && iter != base_bs; iter = bdrv_filtered_bs(iter)) {
> +    for (iter = bdrv_skip_rw_filters(bs);
> +        iter && iter != bdrv_skip_rw_filters(base_bs);
> +        iter = bdrv_backing_chain_next(iter)) {
>           if (bdrv_op_is_blocked(iter, BLOCK_OP_TYPE_STREAM, errp)) {
>               goto out;
>           }
> @@ -3455,7 +3457,8 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
>   
>       assert(bdrv_get_aio_context(base_bs) == aio_context);
>   
> -    for (iter = top_bs; iter != bdrv_filtered_bs(base_bs);
> +    for (iter = bdrv_skip_rw_filters(top_bs);
> +         iter != bdrv_filtered_bs(base_bs);
>            iter = bdrv_filtered_bs(iter))
>       {
>           if (bdrv_op_is_blocked(iter, BLOCK_OP_TYPE_COMMIT_TARGET, errp)) {
> 


-- 
Best regards,
Vladimir

