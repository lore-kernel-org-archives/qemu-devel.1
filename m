Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE07C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E897B20773
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PPkpxZ+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E897B20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juvEj-0007sp-83
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juvDd-0006T2-Tp; Mon, 13 Jul 2020 05:57:54 -0400
Received: from mail-db8eur05on2112.outbound.protection.outlook.com
 ([40.107.20.112]:28001 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juvDb-0002Xp-7A; Mon, 13 Jul 2020 05:57:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVO9n7iABBz3n7DFKUNdOIw1i5VT9XgCDEJswzeNFl9dYDaJb98MPp4IEbtHOBvb7kAYgoTfnBE6/doIisG/DXI9LLy83akjt+F96Q3pMHxs72N1QktlGVE/hH4o2RbasZ48sqwPHGIxhCYXYOOTbpTGQfpVqPbvKroTh1wezxumfd2nH5WPUueH3/GVuqtsnbrYlxIa8DQfrYtcyyz2cuPDNCOhn5KCRxNyK5PfN+0arH/r2tNV+84imCCwVyCls2nXG96qa5Dlqjc40SlEkEK5pKZAUC3u9gzrnKbFDCBFYaajHw9tNWznCjDNh/jK7IPWA9X6rOmHgCRuVyhzyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qT7MrGKnRWrwSJQYmeNNX97No2Bw9oyHsC+T3fcNwU=;
 b=Meq7/CvMjVgrPxXOJpUIM5QAP2VV3VQbJmVL0mkFFJcXTxvG6tqH417kQ4TEzyp+9UsWhTO/EReVUBmZoayWU6IRl95ftMu/0YMGLMgCnOOJWpQUZ6dQz4coesTdL0GANTGVgcCZ9jo6i1P4k0LoiZIL+mj7xLQQUUKby9v9SP0DsKbQebueca4GAjH4SMEke+6YCaGUMI0RFe7gtVBGFyCW54F9F+zzbjK4LIDKkpjWG+AFf5xd1ia2xAo15hEfxBdz0+rGB7E5MSfuCPD/HqW/tsRQmiHm5nXMtTQSVDs9CoFM78grq+oMAx0upfnjfbpAtVVD85Kear+16WKoAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qT7MrGKnRWrwSJQYmeNNX97No2Bw9oyHsC+T3fcNwU=;
 b=PPkpxZ+Itab7G9//jRpM9AQCXXBVT9aH1u6FW4B2iLf0nf4XaTGv57WHQ+HcGYsTwVhoDiIbWX1Sxq+TSKQ7NS5AE7JBg7gJ2ckH1D8ItyEvT5jj6a7CW6rp12xgaUuSAKmtxIAcHTXd2w0uyHU6o/Mi0jQJR4FNCcliABGP0fg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4849.eurprd08.prod.outlook.com (2603:10a6:20b:c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Mon, 13 Jul
 2020 09:57:48 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 09:57:48 +0000
Subject: Re: [PATCH v7 01/47] block: Add child access functions
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-2-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <dbc9a0d1-0e65-0552-e665-d20c059f37e6@virtuozzo.com>
Date: Mon, 13 Jul 2020 12:57:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200625152215.941773-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0202CA0007.eurprd02.prod.outlook.com
 (2603:10a6:200:89::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.167) by
 AM4PR0202CA0007.eurprd02.prod.outlook.com (2603:10a6:200:89::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Mon, 13 Jul 2020 09:57:48 +0000
X-Originating-IP: [185.215.60.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: febb7393-ffdd-4f87-58ba-08d8271332ca
X-MS-TrafficTypeDiagnostic: AM6PR08MB4849:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4849791E411D2BBA2F9C705BC1600@AM6PR08MB4849.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NhQhdhWYUOu9C4tfudBe7qdxoxylqSyw9a+vooCx7/ArY4s9SvRQT6XV5arqE8vUquITasIqr5xf6++RdXVIy1O5T4K2NzBDI0i1Tnrxim2e4Vq3JRBp1PDU/chCr9y6DMn3Y1vahvkT/LEXjpWFRLdhLvM2/QBKInvl0Ffyg+03CfIIW1brxNfaVW4PnVqnbdopCYLZ04s4h/S1w5GWv7a6v3r6B5R9QllnEAvWT+ddik+45aE5yLqNAHLHtAClEteDjjKtdV4vj8RQHBAwjurqqgeJUVsbsU9JOxcI2kmEbp1mttmSaU3t8r4S+N8OWObGli/a+l4AOudPhzRlduM5N7ay0jpN17J6KwalG/mS/Zqfvtalfo6AD8PbHoUo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39840400004)(136003)(346002)(376002)(396003)(2906002)(2616005)(16526019)(52116002)(26005)(16576012)(5660300002)(31696002)(6486002)(478600001)(8676002)(316002)(956004)(186003)(66946007)(66476007)(66556008)(4326008)(8936002)(83380400001)(31686004)(86362001)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: njerpq+6in6V6f0FmfCD5xGF+LWuCk417Bj3cXUrqugZQBGF+t3I1q7hDTD9S3vDC8Mj2yZXeVDvVb+h5Fq5hmqLRz+uUuDXrR+eSKG9ztXBQ/XMuhxgE6+uYe4ZLh1r8eaGg4dIdBduxkCuTmzHx8xZjOQzgCUEm71A0WXpCvcoDsDiYArhKVtRF6lPBg36vSG0mcqiBAjB5cnt63x4ZnMVicVYKVVhmXdY3ErbLeecGTXVYVBK8pIp9jM2ez3dQYxIntHdA8tIVzmPetJZ1JudVy96Kt7Orw5Zz7WH5ZfPWD0UUuBhd9MF7j+Y5yt8fWbxojJ2bKRyVCvILUopXmYYMEP3v0bqYI+K0Qa+H+KzryyCoLbt/TwHlSe13IVxTY/njuLFNMe7A3963IszpYGfLGn+/9IMlmeFsq1NxWugWWUv84cQaT2i2Qho2osysdXFnOx1pY8qK2+rixMLZdM9Pv5bqR4hNkQ/qQBfhF6KZd6C/ivMAtbLITukI/09
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: febb7393-ffdd-4f87-58ba-08d8271332ca
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 09:57:48.4282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozvrnGbHThvqaTQsGsNM/YMHZm4FKErwKHw0mGxxwrE3FeyOOzsg0LAZQQqEdUPvzAIMXW4ZJRAhs1CWzpK03VHB70ys4dsHsN1azf93mQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4849
Received-SPF: pass client-ip=40.107.20.112;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 05:57:49
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

25.06.2020 18:21, Max Reitz wrote:
> There are BDS children that the general block layer code can access,
> namely bs->file and bs->backing.  Since the introduction of filters and
> external data files, their meaning is not quite clear.  bs->backing can
> be a COW source, or it can be a filtered child; bs->file can be a
> filtered child, it can be data and metadata storage, or it can be just
> metadata storage.
> 
> This overloading really is not helpful.  This patch adds functions that
> retrieve the correct child for each exact purpose.  Later patches in
> this series will make use of them.  Doing so will allow us to handle
> filter nodes in a meaningful way.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   include/block/block_int.h | 44 +++++++++++++++++--
>   block.c                   | 90 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 131 insertions(+), 3 deletions(-)
> 
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 1b86b59af1..bb3457c5e8 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h

[..]

> +/*
> + * If @bs acts as a filter for exactly one of its children, return
> + * that child.
> + */
> +BdrvChild *bdrv_filter_child(BlockDriverState *bs)

Hmm you called it filter_child instead of filterED_child..

> +{
> +    BdrvChild *c;
> +
> +    if (!bs || !bs->drv) {
> +        return NULL;
> +    }
> +
> +    if (!bs->drv->is_filter) {
> +        return NULL;
> +    }
> +
> +    /* Only one of @backing or @file may be used */
> +    assert(!(bs->backing && bs->file));
> +
> +    c = bs->backing ?: bs->file;
> +    if (!c) {
> +        return NULL;
> +    }
> +
> +    assert(c->role & BDRV_CHILD_FILTERED);

But the role is still called CHILD_FILTERED

> +    return c;
> +}

(just note that it's a bit inconsistent, keep my r-b anyway)


-- 
Best regards,
Vladimir

