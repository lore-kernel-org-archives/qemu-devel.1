Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F54C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:12:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0749233A2
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LrImMJ3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0749233A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jppqE-0000fm-4j
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 05:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jpppO-0008CX-7T; Mon, 29 Jun 2020 05:11:50 -0400
Received: from mail-eopbgr70114.outbound.protection.outlook.com
 ([40.107.7.114]:51768 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jpppL-0004S0-Kf; Mon, 29 Jun 2020 05:11:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYgXwE368yBXltjI9RvL9gPp3qM3y4LAos7YoVMdHQejCV5EVM84ZDNGd41p+eSAJZB9zUvOl+Xl5jgOS7wt1NA+8VoT8/zCA/pusMdzajTqzF9vTQIgQm0w3B9n1vk7stclXWa2GQKCuBep7LZlrkKyMrsNvYRdnqm/NybD3QZcpqhVkbT+6v+raF1DCNiYKGqbA3Wp0ZyjB4PXYAYI07DpzcEv1RyQ6nGyEjJpuh6qDzD79VRXH9Fg7ALkwU2FzIdz6uzDRQwol8pHDmyUOSIkvHFhKa+98ySkR3rEG906hH9o6+W0+H+uBDAFm6d638M0nNSVFIV9BeiYS7NqXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9CknoeUlfTJPdxiAsrrvxN5uNitvPtRMqrEVvo4mZ4=;
 b=OdmSe2XHpvK54Xg3S5ZzmblGTW6f2/1hxaFNCZxvxbHdKo/TbD5EqOhsvhshrstMf2LsZgrOug3oMiPY1zklPoZyT5poeE5giYs6ndqNtIye7MB5KVIeDg6f2h6/9EgMBciAOCHTr3ctq01CbK+WzlAKi07dodyuw4J/CHgs8nCLrTwgGDvB4yvwZg3zBbbpKihj92gf99Yr9AY3/ypkoVTk7qJcfzZe/NUyBQ9S1FcFi2vf2Gwo7CcpLa1fmPpzRIiS0JLve9Bntq79SXPEjiohAFUmsEfukuDAHs68fT1aqWxfBiZ2Eu8DPhktCI9grlH+qKwYMUhkZQjQmZbAzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9CknoeUlfTJPdxiAsrrvxN5uNitvPtRMqrEVvo4mZ4=;
 b=LrImMJ3HWsuPPu0XmlfZZetdaCPQ5sP7TorAWxX3GruVxa5T3h4AzgbdJZs1i83ewA2/ZUwKcmt0nR+cFr11tLB9mSl8ZDHe/2bek8ljPgeMkGGQFPwwbP4ziGuYelVLHBauvuzkPd2hYpCrhD226XBPL8WVEjJaNiuhametKGc=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2420.eurprd08.prod.outlook.com (2603:10a6:203:9e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Mon, 29 Jun
 2020 09:11:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 09:11:44 +0000
Subject: Re: [PATCH 10/46] qemu-option: Check return value instead of @err
 where convenient
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-11-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f8e32618-ff39-d505-9d49-1eddf71d364e@virtuozzo.com>
Date: Mon, 29 Jun 2020 12:11:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200624164344.3778251-11-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.28) by
 FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21 via Frontend Transport; Mon, 29 Jun 2020 09:11:43 +0000
X-Originating-IP: [185.215.60.28]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a78d9fa6-8228-4fde-e9dd-08d81c0c7172
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2420:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB24202DF3168744D9DE2FABF0C16E0@AM5PR0802MB2420.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S7VURj6iM21mEhkspzMFbxQU8bOh2bm9vzZT4WTvKU4TRptXqZJWesRxmIzStjfPOAxtZ7lxNsZp6wwvmxB2M5rhDEddVQ6eeAk4yIBovEkbCnczUnseeAyLeXrhIlmh6hszVlYqLjrhFmYBf6Cj31Hbo8+DKY741ZUp6Jq59V+xnOxOMy0KUUrffpqzuSJ/j/8Ho59+fveBG4VG1H5O3Z1zOCT27MB6iJ82jbXD606yNzYqpREPNhF6m9mywPInvr1RGDh8hNAirUjFFwsc11sLk6cUBMg/1JOEY/xwaIaPDIqwLGBHUa9KjnAiobEecofSkwLUjfUuBKJXlPo/V3Yad18QzbwWiCrKpBEqF7tKGBKrS+lJwmYj1BRlpoR5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39840400004)(136003)(346002)(376002)(36756003)(31686004)(8676002)(66946007)(8936002)(31696002)(66476007)(66556008)(956004)(2616005)(186003)(16526019)(26005)(83380400001)(5660300002)(52116002)(2906002)(86362001)(478600001)(4326008)(16576012)(316002)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4OwbMkXNQCQ3XSUN/KErFzp3yI4i4w/w0PFh7LyDkQCehQt7bU364Oh1VlyLI21GmmUl2sbSEdnLHxlKouFO5mAuP0iU/UCnxXCp03Lh5+KSGtLMAysqJbBmGBYUmg6c/jl7eAQaT7Vd0LqWUj2h0g6FkpMmebefacKUgA3ELojkpkJglwPMBvVI92DCz2F3bxS+086M4Yirq15f4gTP9+WwXR7Km34GdMvx3F0T9kcOlwV9iS9Aea4RSJtnzTX9ndCJI9d30y0ReNnSXvP4ChcPTHTByQscqGoCpI9v5Kgm7NMHv4QSfKCdx4gASrpg3du7IBR/PkTeeI5YjfJ0c5QiF3OIpMAiN4kICLEqi82aAAFuK1YMzu3ofyXcNf8URRhzm99nYnzWNuMFZskWauXcHiJ9kt/OYgrGKLEfW827TSo8UbEqBlnFl4gkyObFiAt/t3lrd4fOZ2APwNCqGBR6UTu790xT5RjoGUyaR4k=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78d9fa6-8228-4fde-e9dd-08d81c0c7172
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 09:11:44.2950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hdtDjzwjPHQk/5UnPaoppcpqIXrmmST72RnisWqtfl4dReEijWFBrHiKo1vnE724S1D+bR84ytw/q+3xiKc2I/PuN8NU2wbMMIQUp4Alr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2420
Received-SPF: pass client-ip=40.107.7.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 05:11:45
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.06.2020 19:43, Markus Armbruster wrote:
> Convert uses like
> 
>      opts = qemu_opts_create(..., &err);
>      if (err) {
>          ...
>      }
> 
> to
> 
>      opts = qemu_opts_create(..., &err);
>      if (!opts) {
>          ...
>      }
> 
> Eliminate error_propagate() that are now unnecessary.  Delete @err
> that are now unused.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   block/parallels.c  |  4 ++--
>   blockdev.c         |  5 ++---
>   qdev-monitor.c     |  6 ++----
>   util/qemu-config.c | 10 ++++------
>   util/qemu-option.c | 12 ++++--------
>   5 files changed, 14 insertions(+), 23 deletions(-)
> 
> diff --git a/block/parallels.c b/block/parallels.c
> index 860dbb80a2..b15c9ac28d 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -823,8 +823,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>           }
>       }
>   
> -    opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0, &local_err);
> -    if (local_err != NULL) {
> +    opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0, errp);
> +    if (!opts) {
>           goto fail_options;
>       }

Honestly, I don't like this hunk. as already complicated code (crossing gotos) becomes more
complicated (add one more pattern to fail_options path: no-op error_propagate).

At least, we'll need a follow-up patch, refactoring parallels_open() to drop "fail_options"
label completely.

Still, it should work and the rest is fine, so:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

