Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C15BC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7EAB20714
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Hw9ALC3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7EAB20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyeuv-0006v3-3z
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 13:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jyeu6-0006NR-3M; Thu, 23 Jul 2020 13:21:10 -0400
Received: from mail-eopbgr140102.outbound.protection.outlook.com
 ([40.107.14.102]:10629 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jyeu4-0000gj-E5; Thu, 23 Jul 2020 13:21:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BV+YfcGKBHTpiJU4YBq4xeq2Ql+SEv2/XK2s6QAIbEY/Oeho0Gl5HmXdFxUuQN7usB1CEALSEZ9MtCCF4OATPGEkSoKLgQvORuJYf6VVWaRsVLzRbFWin9p/t20KfRkmEPaeMC/fCGV+saIiQz/uEADxkBUUA1VmKb0GgjZ9kgvPY/u4pPeH0x3MvfCysVPHT7nLz96efS0F6Upc4OVGm2Gr26QhqtmNeaeemDSQZ3A6PcBFCt4jX0RUUrbQFtj64E4hkZIQ66JkDsHI21SSixhSwjWQyDNPNK9ZMNCVCvpBt79jYwzFc3w8JsNuX6wXunNuoerQoo6a2N+M69mDfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkATKVRu6MErgKEb0RFGDuVUXn0foOnRLRaGowDncHE=;
 b=RdiS+Q0Q83W1A6qvAFlmSzGvCgfkWNcmF8C6GrkbwfZxjlf/AawkLtYyuzVmMA1OWiJrNZsWWzC2KLjPiALw3hr1BEF/JERkPwQQ78tIOhYSqxcrOA4ebvIGgvioFATA3Qctn2xRAS586wAT4aQ/hsaahlsuj0N68hDrjmQLO2qXSPuKBQgA8+dGAzde9ZPpDzNEsCBXxjYU6zJ8UCU7y3h7LgwJytaKR/1xZYTsz6lx4orm6j6GrwJJN7HIHOAeUxg2vpQpsnTU1Hi8WjRnuzEXqwxNu5lsuOXxyr2zaySAN6TQ7YXTZRjnLPiF9esPeJ3tlwgf+UBxAG82CuDm8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkATKVRu6MErgKEb0RFGDuVUXn0foOnRLRaGowDncHE=;
 b=Hw9ALC3sYGb17k8SemjvANgkjtpKbIfQVY4jKUoX1gCZ0v1Ts9wGp9lKgpqPRLC8GyZ3fPQgKI7uUx9ZMhrK4d0m4au7f+xjjVzwQdJKx7huqrzU1CR/3IHxC82cW5/gP62KXtbS5f12oBpTe5rMD8U1+WdqR1gz6z3/1CKyy70=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM5PR0801MB1907.eurprd08.prod.outlook.com (2603:10a6:203:4a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Thu, 23 Jul
 2020 17:21:05 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.028; Thu, 23 Jul 2020
 17:21:05 +0000
Subject: Re: [PATCH v7 36/47] nbd: Use CAF when looking for dirty bitmap
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-37-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <4f5ef9db-2f79-7010-4626-e2497382c003@virtuozzo.com>
Date: Thu, 23 Jul 2020 20:21:01 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-37-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM4PR0501CA0051.eurprd05.prod.outlook.com
 (2603:10a6:200:68::19) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 AM4PR0501CA0051.eurprd05.prod.outlook.com (2603:10a6:200:68::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Thu, 23 Jul 2020 17:21:03 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e3a0614-e56a-4563-9332-08d82f2cc7fa
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1907:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1907CF96796EB57D645C8F18F4760@AM5PR0801MB1907.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:267;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sin5ZswGtHN//MKyqqU8c8/+pU3CyROVxcgO0jyf5pdZzycXBdFyncib1ToncSZh8AOsH7pugHUUBLzk14qXCk3Tlf4GPuvAK24ZZs3u7U0qvki9u02UmazTHmtMjEBwjYhHbhPv07fECNzqFTan8p052URwo58rv+N3c6Xwu4X2OAPXalAJHxp2E/HNb6sod7GoDASm5vFCeRU0neWk0VPGZJ+LhP4lTsleumEdSODy1lbofPNvPaj1ZOHVsFRqEm5nQHcY+DEq0mjtTZlzvrxLYEpzK5ynZancEJytTG43o0uTa2+7A7hhECHzhBjztdBjzS75ou9R5ArQFFISZ93e4HzxGZY4n8Ew6OHU6iWfafNaYXy22LRGBhcCCBObl+A1TrN4DADttV5idbIlDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(39840400004)(366004)(346002)(136003)(31686004)(86362001)(16526019)(6512007)(26005)(36756003)(8936002)(53546011)(52116002)(6506007)(31696002)(66946007)(4326008)(186003)(6486002)(8676002)(83380400001)(5660300002)(2906002)(956004)(44832011)(316002)(2616005)(4744005)(66556008)(66476007)(478600001)(54906003)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: fNLo+0HrdjG0nGR4gy0wIGavgwmzy/h5Kwf7YTwc2zZKtPySRr0CZl66FkHTRaiBQd2Q6z9OMOk3DipOUUh1ZIqISLo2/3Kp/vETFhzxyBG+9ZSz5elSGnkAu81I3Na4wxqtPPGPhsplf4PQU51u9dMQQIACQKtnsq1xOvZWLRLbNu00FgkPhQ1yooDzjFMLirVPYiuxzOSrzc45ldLRGbz3VZ+YIuBpkbmVcqaHayeUcfL14RLh/CxKMZqGt0f4rTYyN+K93aMjlGkCWPzKqV9jzWx4SdzEGKKN0Oo0ZFNba82j3gpRnhvYR5MKNnhewMfLwsvNRAkcJQfeg+lEFj2wZyLlELbkEssYELWtSzxIFV/hoZZb6qkbWmAoqjsTwg2aVPMkLSJtvTiZprO9P2sDTNLgS5h/l2a2CKN6Pv+NTcRryjjSyOLO4WFO8sdLwYuIBRPbHq5x0XX2XxuqQxZ/q8jyz94ZKCh3uB0klyUvZcWNuzW4c2A8uJIudTjO
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3a0614-e56a-4563-9332-08d82f2cc7fa
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 17:21:05.5288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XD5KIyfiY2pd0rMqdftVwlycO6RGRc6w0pSg57D1BzSSFkaFaHUZpqePAyOATa2V1oAL7yZA4sm3eTH4Wdp0OxbN50AqYeYn4S7HNgPY6As=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1907
Received-SPF: pass client-ip=40.107.14.102;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 13:21:06
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25.06.2020 18:22, Max Reitz wrote:
> When looking for a dirty bitmap to share, we should handle filters by
> just including them in the search (so they do not break backing chains).
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   nbd/server.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/nbd/server.c b/nbd/server.c
> index 20754e9ebc..b504a79435 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1561,13 +1561,13 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
>       if (bitmap) {
>           BdrvDirtyBitmap *bm = NULL;
>   
> -        while (true) {
> +        while (bs) {
>               bm = bdrv_find_dirty_bitmap(bs, bitmap);
> -            if (bm != NULL || bs->backing == NULL) {
> +            if (bm != NULL) {
>                   break;
>               }
>   
> -            bs = bs->backing->bs;
> +            bs = bdrv_filter_or_cow_bs(bs);
>           }
>   
>           if (bm == NULL) {


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>



