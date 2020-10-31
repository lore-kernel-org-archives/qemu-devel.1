Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D46C388F7
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 13:24:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB9D920723
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 13:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="W00FwDDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9D920723
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYqs6-0006A5-4B
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 09:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kYqrU-0005kG-MQ; Sat, 31 Oct 2020 09:24:04 -0400
Received: from mail-eopbgr50094.outbound.protection.outlook.com
 ([40.107.5.94]:50662 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kYqrP-0001Eg-Th; Sat, 31 Oct 2020 09:24:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iis2R+g05eYSd0i23edDvrO35hJmGK4PaoJFglsmOPxYFKiyjW8qsEcJ6heYuEcFjrQt1ywiI8qxJ0KiKYKFy9JFyNSxSGIuTOPF7s1O1DbMsQrHUsZ+yaC/2DvtSxBfpoPixwHsX6PDEobwHx951cAEyFFl1How4IEs+3Ws5BqpeJbUywZN6/CKkBjqJjqL79U8kmRxiD+21q5I5WUvavn/gJ/yFCneO31y/y8jpWddVWW3VzSQTajXgUBNRQSOYHQ8pnQwRLIrx9QttN1ZQePwILSzwvC0GgI6dM0Hrgf3RBZNMvatopskwnvfxXFePDG97UlM9bgZxjvFJTmLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeZaKwG5kEiAScwRL03S8rI7HnPu8afYF5T3Crc/vTo=;
 b=SrV7BL53AeyTipy200aAjq4VBXyWOxK6n2JXOynTB8/eR62/z8+aLqgxqfalwSVRslxdrgrnw++lrVZ2oLevHpLhVz90iPFF9enVZua42ijQ9iwQ1AmDRWvThN1EjouELqPB6WiHRyNqmgnrXBp14rjpDYaXjWrXfwid/Klg8mHa5vrHbgxRskr6BjJ7lR+fw6QUdu24ZNnrH+Sl41cQf5F8VZE9tMatJuDYQSxEiGZjMBo+WwhIx2J970uugdA7mvXiQ1uOaqoubpkcQk/pFWCrpBlLnt+pI+y4tIQub5uU9AAePnI9kLSLyiU4F4n2CsEqEAvhvAYvXVxRCAzVaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeZaKwG5kEiAScwRL03S8rI7HnPu8afYF5T3Crc/vTo=;
 b=W00FwDDdjvHJ4N7OGdqR53kTkuh/62gRorV4gZSIEctDscF8koiQsbvJE/67GV9yPA28ENhoD19f8MF3C6oCrlD/cwdw7nZu+qnkF0EY00Syrmer/IBVT6Q4XIMQ9juBVTcQ4YDAu2Gy8kTf4pDZO0ClCpfmq6gus+UVKVFw1tk=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4849.eurprd08.prod.outlook.com (2603:10a6:20b:c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Sat, 31 Oct
 2020 13:23:52 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.029; Sat, 31 Oct 2020
 13:23:46 +0000
Subject: Re: [PATCH 2/2] block: assert that permission commit sets same
 permissions
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
References: <20201031123502.4558-1-vsementsov@virtuozzo.com>
 <20201031123502.4558-3-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <12a20c72-8ed3-d20d-eba5-6bc2bd0eb7d0@virtuozzo.com>
Date: Sat, 31 Oct 2020 16:23:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20201031123502.4558-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.113]
X-ClientProxiedBy: AM8P191CA0026.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.113) by
 AM8P191CA0026.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19 via Frontend Transport; Sat, 31 Oct 2020 13:23:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0942a0d-4f32-4682-0d41-08d87da03248
X-MS-TrafficTypeDiagnostic: AM6PR08MB4849:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB48499C2F36BA868D0F9D2028C1120@AM6PR08MB4849.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:165;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fQtxNGN3VnVSKd4iZsEkJrD9oDSGeyLFbzDZUCY2dBRkR7eg+2JqTOr72MRpSSRjOUuYghYf735aoGjbYnXJZ4eFvQZUNGZIV6q+L8ufXJ/QRQ+kaQ6Ud/lO8GG9h0prYQZoHv8b2IZSsPxnEIwqbN+MWoH+17phqAemUgYRnXi443RghrtcSm4zEmg0u5U6aK/B8rNaYm45d/FFn6zoccN66uun7GDSlb0wdNwIRijBbHII6XhHc8OdRyeQvxUG+kktCyUTOCjNNPNA9S93cIwCWdvFFdHhi9/nHS71ldOb01ile8LoVfDyJUjsZ07e1q9FEi5dF+vrwsLzHfJutajvKn33LuTLjuoKKovFerZE9hbk5+hYFigMk/tpt5yz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39830400003)(346002)(396003)(136003)(366004)(8936002)(8676002)(6486002)(956004)(31686004)(6916009)(2616005)(4326008)(2906002)(186003)(16526019)(478600001)(86362001)(107886003)(66556008)(16576012)(66476007)(66946007)(316002)(36756003)(83380400001)(52116002)(31696002)(26005)(5660300002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: pWlYJ2Epl7boih5YpxzyfaId2x++1HvtS1aeJrYGCoqhbwsBsZBZvleAvB4kL6AaNARZdyA7R9Fwyt3B76p01Qylo86cbwkBwTqzXjsylDqoeeCMW9j4EhMlGesXP6px5RFznWNm+emIjJEXkREmEzqDC36hSk2yeiTBHvH1xRfIzOHN2QGhaRB4cGn2jVcS97J6FHF3y8bw79of+2v1Kcog2Xk7qRKQSIUsYRKZWN45/9L3XbKiUkOp92iG6JN8368xex/1efOZ4gKqZDMEEEtZwAPRgZxn73hljlr+uVCMLon3As/bpwZYWIEA1xdUKOxICybmCKotzCXY6S2Q02UHiq2V8t6Xo3fdKNxn2GNls+RtR+UnxpXS5uX7aVGUwsMmdlC2ZSJflMqhyyFcIbwulwD/XvPhcMebfQLo4utmFMoH7XIofS5HrNztXA6tkoFtrq0yTq45IZw5QfkjbRVmADyIDzMVVa5vCJYxmnmRdw6heT3aV/yu+VdHuyKR3OXKBI7fIzg6/3Q1RF9Q9wU/eC0g5E4jvSGwfEQKgFl6ce4kMyBfLDBG57mSdbR5yOR8LOKiGrIwOqFuef0+Pij1EWYtypI1aRBWO/cZ6erk48BmXNEN8OJ+bxx3yQX9dub1VXgGjJKcS4YhwVZkWA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0942a0d-4f32-4682-0d41-08d87da03248
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2020 13:23:46.6161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2q/wcIT7NZQrqStSxpbQBI0GXewXlz/mPWDr07ohBJDapQNYSgH9wzSS4Xs3oI1DoiFmADt7Pv42q/5F5fqvx2J31D3qM+yLnDh/ExmvRjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4849
Received-SPF: pass client-ip=40.107.5.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/31 09:23:55
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.257, RCVD_IN_DNSWL_NONE=-0.0001,
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

31.10.2020 15:35, Vladimir Sementsov-Ogievskiy wrote:
> On permission update commit we must set same permissions as on _check_.
> Let's add assertions. Next step may be to drop permission parameters
> from _set_.
> 
> Note that prior to previous commit, fixing bdrv_drop_intermediate(),
> new assertion in bdrv_child_set_perm() crashes on iotests 30 and 40.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/block.c b/block.c
> index bd9f4e534b..0f4da59a6c 100644
> --- a/block.c
> +++ b/block.c
> @@ -2105,9 +2105,10 @@ static void bdrv_abort_perm_update(BlockDriverState *bs)
>       }
>   }
>   
> -static void bdrv_set_perm(BlockDriverState *bs, uint64_t cumulative_perms,
> -                          uint64_t cumulative_shared_perms)
> +static void bdrv_set_perm(BlockDriverState *bs, uint64_t _cumulative_perms,
> +                          uint64_t _cumulative_shared_perms)
>   {
> +    uint64_t cumulative_perms, cumulative_shared_perms;
>       BlockDriver *drv = bs->drv;
>       BdrvChild *c;
>   
> @@ -2115,6 +2116,10 @@ static void bdrv_set_perm(BlockDriverState *bs, uint64_t cumulative_perms,
>           return;
>       }
>   
> +    bdrv_get_cumulative_perm(bs, &cumulative_perms, &cumulative_shared_perms);
> +    assert(_cumulative_perms == cumulative_perms);
> +    assert(_cumulative_shared_perms == cumulative_shared_perms);
> +
>       /* Update this node */
>       if (drv->bdrv_set_perm) {
>           drv->bdrv_set_perm(bs, cumulative_perms, cumulative_shared_perms);
> @@ -2301,6 +2306,8 @@ static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared)
>   
>       c->has_backup_perm = false;
>   
> +    assert(c->perm == perm);
> +    assert(c->shared_perm == shared);
>       c->perm = perm;
>       c->shared_perm = shared;
>   
> 

squash:

@@ -2308,8 +2308,6 @@ static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared)
  
      assert(c->perm == perm);
      assert(c->shared_perm == shared);
-    c->perm = perm;
-    c->shared_perm = shared;
  
      bdrv_get_cumulative_perm(c->bs, &cumulative_perms,
                               &cumulative_shared_perms);



-- 
Best regards,
Vladimir

