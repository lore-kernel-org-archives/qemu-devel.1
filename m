Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF0FC41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C8412168B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Sc+JZgZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C8412168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQDFY-0005q1-6H
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 13:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kQDEd-0005L2-8K; Wed, 07 Oct 2020 13:28:15 -0400
Received: from mail-db8eur05on2093.outbound.protection.outlook.com
 ([40.107.20.93]:39393 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kQDEY-0008Ss-DY; Wed, 07 Oct 2020 13:28:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dH/2Ll7x9/ge31zXxtSzA0Dkd+vkhTTsJ6aVNyWuZBA7DoD0TnpzqiZn/T9NuFbxEt9UTqI7eVy4z+IFrx2YS4R3g+JBaF0MpIW2HGFjguHatI08pe06RRdFzknAa5HqIQ4sMAw1HxRorlW+n+eIQYPULjJXrzPtDYfG4pB2Q+uIe2VxCxTWlxAFDaV6uWzaEp9f+l0NdSGLlPgZGK0LYBrqAkyfOi2CqkGAZjjGE6gO8RZ/ZtGAVLTv9RorJiXMpb9E43EZkzUIcEQr68YU/ZRG8AnLsB8ubVsIpPMykalRXtfJM1del0OTDrVP35QSipaVsR+XxdvAJkoEkRNIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpxEi1RXu58fw5yvZ+tFW/DYQoRmKTqoXFYCEC8/sCg=;
 b=iwB1yQCYfCV0HBqzm9z8h/mlgsnG8lxtYu4OZfCkw0hC5zTFCfTfLfAD5gcsC7VXlszLJIzRdbzGhHmaSfb4ynzUe6XqflmEpwYOGPMfkZh21RBAfECFvhyqeZJsxcIMqq2Ahn1auSFmjZZdqdOLv7fYRY6eOkePhUWXPlm5Ed9HHYTRL2g2coebxFFqM8UISGfoNiMCgxvOTV50fcn/xCgNYQg+9G3iEIEmD19oaVqh5CwAdrAw0J1ESKGSCGwapjvF+bPyp36jvAyqId5MAhYAVZHaGjnG93FLTCYVdlZWDowfPbHBwG6f0W14Ji5ckfLuxNrPMebz4i2HBIvzQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpxEi1RXu58fw5yvZ+tFW/DYQoRmKTqoXFYCEC8/sCg=;
 b=Sc+JZgZN+13X6uMHC74DlldkenWvaul+FUeRZHDFRuhHrDj6wtrYBeJyOVP2fNFCy49bqGJCRY+E/3QQmfMH0X1gQc8DledJ1Ix7hKJZTpc0ZE04WSx4JeGvmqG9uEh2iKGKSrjECnxniLO3yvzJL1yYCBOFfGKOMm8guoK7aj0=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0802MB2410.eurprd08.prod.outlook.com (2603:10a6:3:dd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39; Wed, 7 Oct
 2020 17:28:02 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 17:28:02 +0000
Subject: Re: [PATCH v10 9/9] block: apply COR-filter to block-stream jobs
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com,
 eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com
References: <1601383109-110988-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1601383109-110988-10-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <9fdba83b-4f78-9cce-afbb-9d38525ab969@virtuozzo.com>
Date: Wed, 7 Oct 2020 20:27:58 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <1601383109-110988-10-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::13) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11 via Frontend Transport; Wed, 7 Oct 2020 17:28:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afb59d5e-9fd8-4ee0-59f7-08d86ae6579d
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2410:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2410EA1A29087E31EBF5B61AF40A0@HE1PR0802MB2410.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KgqmbrSZkxK3aETbfinSVkphKR6IMImyAtRF7e+BJmiaelNlLcLz68NIHp1ZrljcqryIKnbvjVIVsT2cwmK2rPEqCZ6weVn58SO9OBNjHRxI3ic7tgIzq805F2ozDeP9Z6FmdtXRxQMzygV3+84j4FhLWtZL5JKS6vFXSXbmeOn0YolptMB/SoSU2TDVuheZfo5/hrWQCGU8ILr/35t5VL583isgEQmfNDJc2T1r/TGPMCIeUZAloFbeLsQSmbq4KdLYK6kpNcaLJuof8t/CJgCFmsAvGuPrkgRHpkQwkvy4qYbtCNpWq0lVBMpL4jEh49M6mgv4E3ixDncvklKRaFK64ihFBWbOYHrKNRP9A/x68IuPrzz/YbfpoCvfUHzb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39840400004)(376002)(346002)(366004)(52116002)(26005)(4326008)(107886003)(6506007)(53546011)(478600001)(66556008)(66476007)(66946007)(5660300002)(186003)(16526019)(44832011)(956004)(2616005)(83380400001)(6512007)(31696002)(31686004)(2906002)(8676002)(36756003)(6916009)(8936002)(6486002)(316002)(86362001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: YM8Pu0TM2CUfYKWNdqqoXKxyodsamZhH4ZtgNws+MaL4TEsfhCpsg+AF65k1aP8r4uprNPv8ohmLMa6uSKz7v3UVECMUkXNcj34Cv4dWlLOiT0hMDP3pcEWE7mhyBvYo/7aH7claEYeU0lZhhbaoTh+ICI08AkpyI7gczLVl1FcR+/xTQfw1wqhEM/k41m00le4BrLHPrd1+g+INqa73ilxmnMH2pPQGV3xn0p3QzOj+Fkjbgo1wy1Oj5LmMugbHp7tj89lFxDfFEq2boKus8dqhi4jbo/S9qQ6UofziQ45mw5L5o2/Ackl9Owlmfb17p2IyZsgL5ZTFdXyiCvDkI8XKbAhipldkwZEijmzHLaEjIje4kUWFd+upWyHRX3vHZGDwcXhO7kL5FjDSV1UXyQD0eD3ZiKT4OqS0WLpM7OcXt8yCK2NM6uQOw/Sa1YrAYran154XI+OIQKpYBCp8B2Uls0YtzRoM8q2DwdmX7I203N9hGfZJhM5e4sj+EieCSack1J8VgLLqf8twO0aEY/lbeMB27Pgax//SZ+DPT9qi9PSGyZBopG6uj5ZuftAYDYzELfV5a2YkG9qbwBJysw/qqFVu1JhbTdqAQZ4J1zFCPm4VJOanhkFrt3U0J/4qokgGKTUIzZ+7LmArDJIOng==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb59d5e-9fd8-4ee0-59f7-08d86ae6579d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 17:28:02.4854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BwYpUJ8ayMYnxWvaovLUGCoNJB3VNwMWcCZI2PC+oLIhfYMa/RclGBB20P0yOq1DtosqcYbP3uV8sPdhisRpDjEEOiiwqzkHEDxUYqQfeWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2410
Received-SPF: pass client-ip=40.107.20.93;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 13:28:05
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 29.09.2020 15:38, Andrey Shinkevich wrote:
> This patch completes the series with the COR-filter insertion for
> block-stream operations. Adding the filter makes it possible for copied
> regions to be discarded in backing files during the block-stream job,
> what will reduce the disk overuse.
> The COR-filter insertion incurs changes in the iotests case
> 245:test_block_stream_4 that reopens the backing chain during a
> block-stream job. There are changes in the iotests #030 as well.
> The iotests case 030:test_stream_parallel was deleted due to multiple
> conflicts between the concurrent job operations over the same backing
> chain. The base backing node for one job is the top node for another
> job. It may change due to the filter node inserted into the backing
> chain while both jobs are running. Another issue is that the parts of
> the backing chain are being frozen by the running job and may not be
> changed by the concurrent job when needed. The concept of the parallel
> jobs with common nodes is considered vital no more.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   block/stream.c             | 93 ++++++++++++++++++++++++++++++----------------
>   tests/qemu-iotests/030     | 51 +++----------------------
>   tests/qemu-iotests/030.out |  4 +-
>   tests/qemu-iotests/141.out |  2 +-
>   tests/qemu-iotests/245     | 19 +++++++---
>   5 files changed, 83 insertions(+), 86 deletions(-)
> 
> diff --git a/block/stream.c b/block/stream.c
> index fe2663f..240b3dc 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -17,8 +17,10 @@


One more change missed, as we use the COR-filter:

@@ -47,8 +47,7 @@ static int coroutine_fn stream_populate(BlockBackend *blk,
  {
      assert(bytes < SIZE_MAX);

-    return blk_co_preadv(blk, offset, bytes, NULL,
-                         BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH);
+    return blk_co_preadv(blk, offset, bytes, NULL, 0);
  }

Andrey

