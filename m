Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7812BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 07:25:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE492080D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 07:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vxQIXuef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE492080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyVbK-00046U-IL
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 03:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyVaE-0003Cx-7j; Thu, 23 Jul 2020 03:24:02 -0400
Received: from mail-eopbgr70120.outbound.protection.outlook.com
 ([40.107.7.120]:40324 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyVaB-0007Jy-DF; Thu, 23 Jul 2020 03:24:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBVEu4+vBeYfv21EARhHPMZVOcKgnSi0r165qVyKzIJjLEtrjqJ6QM7PrwnRvFwlrgO+S8Vfsf2wo3UrfjU9ZyojPzgWVcp8ca1I+zYTZNBXIigjL+UUS9woRZsX0t+1+9u2+qewTnpFC5W1RG41fyXRClkH9rvjikj6C1ZNaCoT8xv+uTyEf1a6TykMw8JvOtZP0C/c6JE+MRYn2jxHBf/XocPH64/G7wCzA0dQBhgAGcW+wRNq+hj5+CB9cn1qeB4dYLTMt1OyenQ9ABLMXqvv51n1jvSTMRFdwwTK2AeEgJV+83S9tRBcfz1OUS2o0oIaFVPALDlOBqIMCdJdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQlotNphQV0nzM0KC248iO3ylescq5q1Tu0Vw5ZAPbU=;
 b=de0BA6E+TF0cxnQE13ekNQjuXnGvHyv7ynddbDwOWnZBIpXetKeDC6d1L1/pZyhtBQlYK9Nk3WIYz9ZVAonWrlWVkM1QbF5vrsB0yR/vzkzPZP/PaLU8rI3nTj9+0JlncGJ7xy5kzk2kZ59547azR4QlDV6ktMvgReDyDzYPooQ7hm0nqUAUoIobyvPTNjj4GoFRSy54WV/OA+AWfmZcn7iHi8KSMhnzUZhraqqfUBcJ3HlM5bPY1dt5q/GJEdfTGb2xymTM0vMCG3ZNYkx+pA770WGkQOlxKattJTE4PUCR4NEuASxTDjy2V6CPhR4BgsFk2QiQUjr6EpUVr4QwTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQlotNphQV0nzM0KC248iO3ylescq5q1Tu0Vw5ZAPbU=;
 b=vxQIXuefWySNn66mr3+YQGZm/CMTxNK80KGW0xW1fIH9T0/jdsBaOMy4t+/HPiuIhcZpyQf47Q53QwpoqHzfqYjPleMJaRleFCpgqlPjTz/p8AlqHD6Z8yxv03xxmwLf6gCn1N+vKtxPTVy4pe7zuYrskjUZyO5ltA+b3GgybUk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4916.eurprd08.prod.outlook.com (2603:10a6:20b:ca::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Thu, 23 Jul
 2020 07:23:54 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.026; Thu, 23 Jul 2020
 07:23:54 +0000
Subject: Re: [PATCH for-5.1] nbd: Fix large trim/zero requests
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200722212231.535072-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e7b8151d-b9d3-b5c5-9bc4-661a045d4ff9@virtuozzo.com>
Date: Thu, 23 Jul 2020 10:23:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200722212231.535072-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0079.eurprd07.prod.outlook.com
 (2603:10a6:207:6::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.141) by
 AM3PR07CA0079.eurprd07.prod.outlook.com (2603:10a6:207:6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.16 via Frontend Transport; Thu, 23 Jul 2020 07:23:54 +0000
X-Originating-IP: [185.215.60.141]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08b66e3e-960a-4cc2-e939-08d82ed95b28
X-MS-TrafficTypeDiagnostic: AM6PR08MB4916:
X-Microsoft-Antispam-PRVS: <AM6PR08MB49166905B8E819DCC79B90ECC1760@AM6PR08MB4916.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6zHXSrKf/lekjjfjPmM7ixnBJkZL9qiMORdBgu9RbntlDupFq+WrcxsjFo4qCGkjBJoZYgrDnQuoiR88ambBZ6gE6eimwR5QqaWJ4Fxj6wcU5L5TpLYYZ2M2vwzfTdmj11iEFkkFi0NAR6pQ+wyNfAd1QK66odWp6OJgYLE1c/N83UDJ3SWRD40QDfeFQ4t3iB78Dh6lLfmevfQhtvaw+hz6e/b6Oybxqu3o/mPC0eEPJBc90F2euOZZkJV0K2Vp/BjOOLQww9xTjHe8VnBA/PjIK9EqeF7D7vMSkSXVHeiAe3BXq/gv52qBzX5onshgcolmHgz4SHkUUywBpUC+GrzkLLfMFoy171c7B+Bgj7elq2xqMZsYKhpXA7+ppQHLT5slc+WOIBFiPydAMKw0f2vZyShgkhhnOh5Pnnd2/8GrqIUtQycmkUL23iHumaDBPQeA/PqyvWwQPQxcubv6+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(346002)(366004)(396003)(376002)(2906002)(52116002)(6486002)(31686004)(83380400001)(26005)(8676002)(16526019)(186003)(956004)(316002)(16576012)(5660300002)(66556008)(66946007)(66476007)(4326008)(478600001)(36756003)(86362001)(8936002)(31696002)(966005)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: aGiEe7v/6H5oniMZmsCliOP1NZXrCWyoV2pTQIQVGMdIIbdaivYRyc352HstaThWpa6YOPJ2GraIEmFAt1rgVy66QL8iZQggO4aEOfDuVHVtlwfoT+W1j0PNAuEQT/72EAPFGUHw0Bh9msvlESOAi8fIhthgQNb54WNpIQn62rr2fIHMDOTrlWEYXSmXrAqZ7myx+OmFHepqD40QrLKrQ89LwYRe8BjBl3r/GIsisPCV2+frGjDpFRC7aMb1F/AFYbrZiZeDNVaF8ZiXE+M/4d6qgKPObE3QAwdfmXQJkmS9w+NK2xxqoGHLxOTQ6DH6fzoP1h/voC5VPutG6n5zy0qCu79Cv1ovIi64YIF4KcQ09l6Ve/ZG5VBuis5+L2UP7Xoe3JWfSe5o3HCb5ro9MUeuCHwhJe8mofgbkIgAFlQd7V5Vr1Dxb6vcYqdkHY4NfqbxjxAWeeQETruQ0O+avntFAtnEVIK4WPg93IAMIIzdonBI/YnwREpkPU0S5V3u
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b66e3e-960a-4cc2-e939-08d82ed95b28
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 07:23:54.6597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkxBoMC2Srj/qahAn5Kn2J/CC+knZF3yGiY71diJ2Qv7B9BITnOq8gvd6nu72Yi6L0yrTY3qE+rlEctHZMZc7TSRW/9IrF0JsNY0nDq3upM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4916
Received-SPF: pass client-ip=40.107.7.120;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 03:23:56
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
Cc: qemu-stable@nongnu.org,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.07.2020 00:22, Eric Blake wrote:
> Although qemu as NBD client limits requests to <2G, the NBD protocol
> allows clients to send requests almost all the way up to 4G.  But
> because our block layer is not yet 64-bit clean, we accidentally wrap
> such requests into a negative size, and fail with EIO instead of
> performing the intended operation.
> 
> The bug is visible in modern systems with something as simple as:
> 
> $ qemu-img create -f qcow2 /tmp/image.img 5G
> $ sudo qemu-nbd --connect=/dev/nbd0 /tmp/image.img
> $ sudo blkdiscard /dev/nbd0
> 
> or with user-space only:
> 
> $ truncate --size=3G file
> $ qemu-nbd -f raw file
> $ nbdsh -u nbd://localhost:10809 -c 'h.trim(3*1024*1024*1024,0)'
> 
> Alas, our iotests do not currently make it easy to add external
> dependencies on blkdiscard or nbdsh, so we have to rely on manual
> testing for now.
> 
> This patch can be reverted when we later improve the overall block
> layer to be 64-bit clean, but for now, a minimal fix was deemed less
> risky prior to release.
> 
> CC: qemu-stable@nongnu.org
> Fixes: 1f4d6d18ed
> Fixes: 1c6c4bb7f0
> Fixes: https://github.com/systemd/systemd/issues/16242
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   nbd/server.c | 26 ++++++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 4752a6c8bc07..029618017c90 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -2378,8 +2378,17 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>           if (request->flags & NBD_CMD_FLAG_FAST_ZERO) {
>               flags |= BDRV_REQ_NO_FALLBACK;
>           }
> -        ret = blk_pwrite_zeroes(exp->blk, request->from + exp->dev_offset,
> -                                request->len, flags);
> +        ret = 0;
> +        /* FIXME simplify this when blk_pwrite_zeroes switches to 64-bit */
> +        while (ret == 0 && request->len) {
> +            int align = client->check_align ?: 1;
> +            int len = MIN(request->len, QEMU_ALIGN_DOWN(BDRV_REQUEST_MAX_BYTES,
> +                                                        align));
> +            ret = blk_pwrite_zeroes(exp->blk, request->from + exp->dev_offset,
> +                                    len, flags);
> +            request->len -= len;
> +            request->from += len;
> +        }
>           return nbd_send_generic_reply(client, request->handle, ret,
>                                         "writing to file failed", errp);
> 
> @@ -2393,8 +2402,17 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>                                         "flush failed", errp);
> 
>       case NBD_CMD_TRIM:
> -        ret = blk_co_pdiscard(exp->blk, request->from + exp->dev_offset,
> -                              request->len);
> +        ret = 0;
> +        /* FIXME simplify this when blk_co_pdiscard switches to 64-bit */
> +        while (ret == 0 && request->len) {

Did you check all the paths not to return positive ret on success? I'd prefer to compare ret >= 0 for this temporary code to not care of it

> +            int align = client->check_align ?: 1;
> +            int len = MIN(request->len, QEMU_ALIGN_DOWN(BDRV_REQUEST_MAX_BYTES,
> +                                                        align));
> +            ret = blk_co_pdiscard(exp->blk, request->from + exp->dev_offset,
> +                                  len);
> +            request->len -= len;
> +            request->from += len;

Hmm.. Modifying the function parameter. Safe now, as nbd_handle_request() call is the last usage of request in nbd_trip().

> +        }
>           if (ret == 0 && request->flags & NBD_CMD_FLAG_FUA) {
>               ret = blk_co_flush(exp->blk);
>           }
> 


-- 
Best regards,
Vladimir

