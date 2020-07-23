Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8907C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 722A820737
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="l1ZDBJhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722A820737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyb07-000841-NL
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 09:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyaxx-0005Fb-GZ; Thu, 23 Jul 2020 09:08:53 -0400
Received: from mail-db8eur05on2095.outbound.protection.outlook.com
 ([40.107.20.95]:28688 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyaxu-00023L-IE; Thu, 23 Jul 2020 09:08:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GX4FrJ0QMQ3eSdVz9HQSv2sGN+xnqc2JQDPlvd3hPhCxrRySYnGNcNpb5nhspRuf8Gf8tZqXCTPZhBKv0QpOiRI0dT6m7TmJ63RwpsDlrxx3txdhw+ds1eqyc7EFzkxhw3qU7R85T8nuOXr0xMMMVqVMxpvJAQaacXKaNc3mN4D8qAIHLp3WNvy22DM2B9zGohb3l6PO03UmYaYelBidYNTbyWHLQq+vYK3aaLG3EHJQvIDkWMLWPUfHQnOCrQigfm1kmKhXNWFyY37EarLs/18lyCdzVkWmcno/s4ckfI8Fq54wig12CHTicSIJqoVyOFwZlQnYg+IdlG25C9DYtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEhS/K4Z2Z+goLA3sZ0ejVeQMWgDotB+22ydbBKJqak=;
 b=bXGiUlnNHnPfRAT5fZEHTR3AAAGyRhWiYJVELB1e3+zdrLHhF9xxrWTs571OhRMLXjLqR0IRGl7VMZd8uJQGkEj/+ytXuVwTk0KiijtOI923/ldu1+MjrJXt40S4GQSJTywXEkHUVcYfGJ+VkcqoIG5+JgYIbT4PT39BULJYaSuscPtDbFiHkWHx+meIbLFzI4ZVe7fHeVhlk+uQwJ3Xx5FEU/sr70VOcp8M0uAwKPtCito5F09Gw1/DEcmzSa7pjcVN8vzweZ6Bnhs2rjIcpBWt5l9tfa5N+YB7Vpor9LMFiFpPisYjwobpxVS3sQN7/lXjpn+eYM6T4/NNX6tvHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEhS/K4Z2Z+goLA3sZ0ejVeQMWgDotB+22ydbBKJqak=;
 b=l1ZDBJhTUnjnVHwuftX2lobkr/nM4qCX8o0LI85z7JNoL1Snt5eRyoowFgGkfYLblgZqmvuevjVhBHoefL9XtjAQXFi/f/wxQgYOrXFicfJFVnVYJybm5t0urQdRgWYv6syvr9a0AgjrT8WVO+GXSVc7qSwAsfbhRZHGGxBRSi0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VE1PR08MB4944.eurprd08.prod.outlook.com (2603:10a6:803:116::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Thu, 23 Jul
 2020 13:08:45 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::ed6f:fa6e:70c9:be54]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::ed6f:fa6e:70c9:be54%3]) with mapi id 15.20.3216.023; Thu, 23 Jul 2020
 13:08:45 +0000
Subject: Re: [PATCH for-5.1] nbd: Fix large trim/zero requests
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200722212231.535072-1-eblake@redhat.com>
 <e7b8151d-b9d3-b5c5-9bc4-661a045d4ff9@virtuozzo.com>
 <b72d8646-4ad5-be76-dca9-72bfb203d18f@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6245f93c-03ae-1d77-49e0-7ecba214d8da@virtuozzo.com>
Date: Thu, 23 Jul 2020 16:08:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <b72d8646-4ad5-be76-dca9-72bfb203d18f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0302CA0031.eurprd03.prod.outlook.com
 (2603:10a6:205:2::44) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.141) by
 AM4PR0302CA0031.eurprd03.prod.outlook.com (2603:10a6:205:2::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Thu, 23 Jul 2020 13:08:44 +0000
X-Originating-IP: [185.215.60.141]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 906f081f-a7ed-4bdf-7a95-08d82f0987d5
X-MS-TrafficTypeDiagnostic: VE1PR08MB4944:
X-Microsoft-Antispam-PRVS: <VE1PR08MB494460800BA5C3BFD351A533C1760@VE1PR08MB4944.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zKkpDAs+mp2+U4Vds4RQbIGX3Mm8GNxre/gzhmX2XLIjwGdgQ49maE6QEXSpOxoYBcQaCpLpPLIO0mN90DxauyLe1s/ZviX7RtMr/WA9p8eifMLBr21U65GpAmtzEFbIF3X90Y5sws7whAgZl89qtNfK29OZmvPRqPJ9t0JPoPV7a9iCz3NUxcTCb8SIDMhcLPtotnpxNyL+XZILrOZ14Q2DDCbOeMlEMIJ4xzxg2TmUGLTXTCyzZMmO8fKMnctf8PLWg4eyckefVhlVHPsdPkJugN3zaQ2Jo/RfusqYkaZdfdvM4pLNYustvrkT6OZX0cX50tDGeh7MKgydOmW9WInZHWRIAUeSQ37x/3rPnCbq3cxNSGN8BeNH+ZbXaJDv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(39840400004)(376002)(396003)(136003)(83380400001)(36756003)(6666004)(186003)(66476007)(66946007)(26005)(66556008)(16526019)(2616005)(956004)(86362001)(52116002)(316002)(8936002)(478600001)(8676002)(5660300002)(4326008)(6486002)(31696002)(16576012)(53546011)(2906002)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 754e80e+zucee0yD1Ph9TcucnimCP2htYvqHepcCou1EmsrAkrY6Gj0DokLLB6885FPYLF6eFMweZK3rEJQegoREipZViGxA7NDTGNCFejEqSrsdoiUJOqCxhDzRxoZXLrSekjAMWtuEwkX5alJUWsRi5j1aNelD1r5Ya2JNmVNHpC96ThUF0jhosVR2PFkm/5lb6mG982Kw6yqmqHMdkGGL3CH5LuSlAZ1ubNIqn8M6FsHKRzDnOJsRlOx91nS7fN+PTX0tAR3O/LwFk6HtLQrhffSK49r7H4U9H9uCNgkgVFrokOU7rYs7GGhLdTv9beoY3mpV11zISCXi9SqDxCYYOUwlf1fie+/CeK18/fjqn9qdTY0cJssS9XzJLGiPwbGD7bB3tCoDvUjDenISElvl0w0OHyBBTDgwpQ5irExXxSPD4MQD+EyukHiIahdzW3dmVFiBhzPxuRlPL/zj+orDyCgxj2HCc8g5GPaXXuPp5nc69XUNq0zhb3BLntrp
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906f081f-a7ed-4bdf-7a95-08d82f0987d5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB5503.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 13:08:45.5002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yQdzg24hOAOfwKlrBu3qdbmwZ6zcQJ1ZvNNn9x15qQjRpK5XqODbncHul3kcmq6cPUiuuFkdQd6XgZj9Blmw00+kUmroNZL+eg/0X6bX2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4944
Received-SPF: pass client-ip=40.107.20.95;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 09:08:47
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

23.07.2020 14:47, Eric Blake wrote:
> On 7/23/20 2:23 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 23.07.2020 00:22, Eric Blake wrote:
>>> Although qemu as NBD client limits requests to <2G, the NBD protocol
>>> allows clients to send requests almost all the way up to 4G.  But
>>> because our block layer is not yet 64-bit clean, we accidentally wrap
>>> such requests into a negative size, and fail with EIO instead of
>>> performing the intended operation.
>>>
> 
>>> @@ -2378,8 +2378,17 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>>>           if (request->flags & NBD_CMD_FLAG_FAST_ZERO) {
>>>               flags |= BDRV_REQ_NO_FALLBACK;
>>>           }
>>> -        ret = blk_pwrite_zeroes(exp->blk, request->from + exp->dev_offset,
>>> -                                request->len, flags);
>>> +        ret = 0;
>>> +        /* FIXME simplify this when blk_pwrite_zeroes switches to 64-bit */
>>> +        while (ret == 0 && request->len) {
>>> +            int align = client->check_align ?: 1;
>>> +            int len = MIN(request->len, QEMU_ALIGN_DOWN(BDRV_REQUEST_MAX_BYTES,
>>> +                                                        align));
>>> +            ret = blk_pwrite_zeroes(exp->blk, request->from + exp->dev_offset,
>>> +                                    len, flags);
>>> +            request->len -= len;
>>> +            request->from += len;
>>> +        }
>>>           return nbd_send_generic_reply(client, request->handle, ret,
>>>                                         "writing to file failed", errp);
> 
> It's easy enough to audit that blk_pwrite_zeroes returns 0 (and not arbitrary positive) on success.

Yes, that's why I've posted my commend to blk_co_pdiscard :)

> 
>>>
>>> @@ -2393,8 +2402,17 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>>>                                         "flush failed", errp);
>>>
>>>       case NBD_CMD_TRIM:
>>> -        ret = blk_co_pdiscard(exp->blk, request->from + exp->dev_offset,
>>> -                              request->len);
>>> +        ret = 0;
>>> +        /* FIXME simplify this when blk_co_pdiscard switches to 64-bit */
>>> +        while (ret == 0 && request->len) {
>>
>> Did you check all the paths not to return positive ret on success? I'd prefer to compare ret >= 0 for this temporary code to not care of it
> 
> And for blk_co_pdiscard, the audit is already right here in the patch: pre-patch, ret = blk_co_pdiscard, followed by...
> 
>>
>>> +            int align = client->check_align ?: 1;
>>> +            int len = MIN(request->len, QEMU_ALIGN_DOWN(BDRV_REQUEST_MAX_BYTES,
>>> +                                                        align));
>>> +            ret = blk_co_pdiscard(exp->blk, request->from + exp->dev_offset,
>>> +                                  len);
>>> +            request->len -= len;
>>> +            request->from += len;
>>
>> Hmm.. Modifying the function parameter. Safe now, as nbd_handle_request() call is the last usage of request in nbd_trip().
>>
>>> +        }
>>>           if (ret == 0 && request->flags & NBD_CMD_FLAG_FUA) {
> 
> ...a check for ret == 0.

Hmm. Is it a bug or not? Anyway, bdrv_co_pdiscard() does "if (ret && .." as well, so if some driver return positive ret,
it may fail earlier..

> 
>>>               ret = blk_co_flush(exp->blk);
>>>           }
>>>
>>
>>
> 
> Yes, I can respin the patch to use >= 0 as the check for success in both functions, but it doesn't change the behavior.
> 

OK. Anyway:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

