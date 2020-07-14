Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884F7C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:53:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5165222464
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="I7AxUsPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5165222464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvKRG-00081l-KV
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 08:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jvKQ8-0006Lf-OE; Tue, 14 Jul 2020 08:52:28 -0400
Received: from mail-eopbgr60090.outbound.protection.outlook.com
 ([40.107.6.90]:55011 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jvKQ4-0002sB-Gm; Tue, 14 Jul 2020 08:52:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVG7ECgTXS8JTS3PS9UiZFzB+GudxgI7SQ/HPbLjfHOO8o4yz7t452YnxOFKBYukb3WApLiaX0LPGZzWmWjiZt4vReji4eLfZL+lz9uE+AWQxfd1o+e7SZsUAl+eYHEKsmmHxzDiTX/3tb9jl+fJgv7gVIxfa4lILY6R4wI/BSMxcJqQvV6d9M1M1Pb7ENPW+1P2+YEuSmtgMGsX1XgMK+7A8x++zyOtugiHXckd0q5hRK5uIp1gs2fEyMDQB3lgqlOLMY8F3J1uUbtnUHxbZdiwtami/3FH96Nx8LUxliHFlTbLQC55XpCC7xOURQ8WsyC1duFKCJuLU5BWF8zCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFIZRhr5FX1EWGKjM4EWRk3snoixupNzS2nwBVZ380g=;
 b=Z4SAPb/B7I0Wnu1cn/hEnPuvRblUskg52Svw37z2I9ouwG45W6SOnpxg65UB7taw0p4IIfm1MEPpR8n8O9JzjGdhFsFs+VtcICkgm9NbIcHQXVGly+Doj6g62v3V8XOHrCXfEsltod1kVT54prwn3i8DAtVwMmj82gtvQf3N6W3/7exazT6TZ0QVlBilUkxnpe0JJIGIi5pivA3/cvCeI/alN+p16CDIm6s3TMlOCAdRBwrB5yRkQjMg5yAyMA3OX6iKJfnDa686HGvhSX4egwShROR0FjfK4SMcjI+1wWD9/hW7wP70lMoUavUygTOGTEbkwckSvS7GaXuRBuIzIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFIZRhr5FX1EWGKjM4EWRk3snoixupNzS2nwBVZ380g=;
 b=I7AxUsPmYL0K0zPd0eafk4y5idluLT8rqXRM3VuUaotGc+djMjGOMlidqc/NEEZoa3OtvCYYMR5GdOWMUhi2VfgMvmnsJhafcn116kWkr8lJRG/TK3GvcfnQejLKVi1YlIb68egZzR8vYSXbc717iRJq1T0mq71FPIpXp56FI0o=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4279.eurprd08.prod.outlook.com (2603:10a6:20b:bb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 12:52:21 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 12:52:21 +0000
Subject: Re: [PATCH v7 18/47] block: Flush all children in generic code
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-19-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <ba61506d-35a4-01f5-da09-b5055acdc460@virtuozzo.com>
Date: Tue, 14 Jul 2020 15:52:18 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-19-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR01CA0127.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::32) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR01CA0127.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Tue, 14 Jul 2020 12:52:20 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 308fa048-4d70-4fca-46d5-08d827f4bf46
X-MS-TrafficTypeDiagnostic: AM6PR08MB4279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB42796E01F21C8767E2E451BAF4610@AM6PR08MB4279.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8725/DPQTIdorwHKhUfw41yp4qsWiFrs46ta+S58cM+EXovizjiurhSN5QnMiOQaHfrCaOXwymPWabS8z4BdlKeV4XEIXKp05ThlRj8vaTezq9RP/0xp6P9eNG8ncAQ4DAClnLnagPrXYZZzKToyGdAH0wi0zB0eCrGNlYVxqAnZxu0b2U0JLx7/foJs14JHvYV2Zyflzyg4W62/7i40K6DDOBTjk+vY9dlzuaUbaUA1IPaDA0GdV7Usa3/idKHF023GW5VfVOjqLzbDB97WWs2gxZ3Wkckqk0qsdrxFD0FWBH0VuEZnhR2DottqgqEgzCvGux/dMUBU3zXeYsUZqFGziAubA6mbXx4K7iCUs1AElRF+YZUDO1Wc1tKN4DluhH+l9KDR8B7JxpF55XO66w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(366004)(346002)(376002)(396003)(8676002)(8936002)(6512007)(83380400001)(66556008)(16526019)(26005)(186003)(5660300002)(31686004)(2616005)(53546011)(6506007)(6486002)(316002)(956004)(44832011)(54906003)(36756003)(31696002)(86362001)(2906002)(66476007)(478600001)(4326008)(52116002)(66946007)(41533002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: bTayYNQ2mQ83vQDu6Lp7DBI/fN1T1o8+uLWAcTWKP2KPkA9vWvXi0UKxl2aD7r1HAh9QFCFrqiqoYspFH8yB5sovA8zunvlysWGqGevRz2LddRRzPxsXXJpZrsvTsweiVkZoqMmyfuenlk6roxs+J8wE+EmYIwQb3Z59IRk0xo66/ZYYhJ+GsQEaEK7sT0xnprdRYNuDBeegGC8MH2/z0uFulMfZClK1NCj6Nwx5oQpko5q0epZr0cYx3ebkLco7mq5h/RusyNk6QnRgT7G2kBi9ny9zs0dQvIt+c5EnhXATiETPscbN1bLNyFvFmzFlhHzZ6YO/R97oIF0XSAvEamce0rfY+/G4IgJGnfcBwGtmbqT0OC6GwZtYZInqurAStfaXhaJngZ1aCvzQT6zSxUzZZSa66gJO866VuhQ+GmPp4ccvIL0902sx8wwp2W1K4DX1pOE+Gkvn65eS24XVZDL1mDSg6KvLPQNcEP9Bk1yOCRRhfJJjGWnI6ISlpg/A
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308fa048-4d70-4fca-46d5-08d827f4bf46
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 12:52:21.0720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7A+XTYHe6N2Ecidh39Ql/ccUT1vrE5M9pTg0MIwqxVr1xucOxbYMXqLNAu/RIlqdoyhAA8SRlYxP26ts2iYqvMNa0SKiHYntA5Sog3p8TiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4279
Received-SPF: pass client-ip=40.107.6.90;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 08:52:21
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

On 25.06.2020 18:21, Max Reitz wrote:
> If the driver does not support .bdrv_co_flush() so bdrv_co_flush()
> itself has to flush the children of the given node, it should not flush
> just bs->file->bs, but in fact all children that might have been written
> to (judging from the permissions taken on them).
>
> This is a bug fix for qcow2 images with an external data file, as they
> so far did not flush that data_file node.
>
> In any case, the BLKDBG_EVENT() should be emitted on the primary child,
> because that is where a blkdebug node would be if there is any.
>
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/io.c | 23 +++++++++++++++++------
>   1 file changed, 17 insertions(+), 6 deletions(-)
...
> @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
>       /* Now flush the underlying protocol.  It will also have BDRV_O_NO_FLUSH
>        * in the case of cache=unsafe, so there are no useless flushes.
>        */
> -flush_parent:
> -    ret = bs->file ? bdrv_co_flush(bs->file->bs) : 0;
> +flush_children:
> +    ret = 0;
> +    QLIST_FOREACH(child, &bs->children, next) {
> +        if (child->perm & (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED)) {
> +            int this_child_ret = bdrv_co_flush(child->bs);
> +            if (!ret) {
> +                ret = this_child_ret;
> +            }
> +        }
> +    }
> +
>   out:
>       /* Notify any pending flushes that we have completed */
>       if (ret == 0) {


I have not tested if the running application do reaches the flush_parent 
point to flush the data_file but with the code it looks OK.

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>


