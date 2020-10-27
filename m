Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84ADC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:13:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E2E521D41
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cXffG+5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2E521D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQfQ-0003TS-Vu
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 11:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXQFi-0004e6-Uz; Tue, 27 Oct 2020 10:47:11 -0400
Received: from mail-vi1eur05on2104.outbound.protection.outlook.com
 ([40.107.21.104]:18727 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXQFg-0003Qb-Mg; Tue, 27 Oct 2020 10:47:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vq81W6kg+OssARbYj2CoKO/YtC9LG4eDsWIDOLsvMIku1oEzBBk/1EP1d8O+LfPMw/7fOiAFbQG3R1GwxixNlWPNzWsWdBzcnTP46JbHzAsZ+4D5CM0XPBW4Q7khfFRBztt2OPpdDIdQBrIj5TlL2fRkTawVjBtC5IdV8+N1syb9Y0eWIHrm821ZRq9xRgbl8aArPpqZNWBqHdA4AUxqjLHUF/Mh4nz3dqi2Aw66LtD9LztbcxiARPnbF0KK56n0fGvTe9SOuz82s3RD/bjWKQGobP54F9i21cuozCobtrm/Fe/ZLmpaEktxHdvn/eHtYcU7lgMRsFb5EX/9RACa4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecTTnR0pD1GxqaJa+pzxoe0guAbueny2YGwMzg6B7us=;
 b=Rk7RsXdbGtyWYGSON75HCAH9oAiBSo9FMaDP3CH9mqCwlv+7po2TlQD3wABuYr2FTJZmgNcevlF26nOMvrJBEoLsKGL+pjYACQgYvqRLR+VFQQoEtEyQ6N8RxRt11FUez+h1b1sVRO90rw8+es+hOdyzLoP3YLQ9kIyBuY3TYEhp5vJmzxwZRwe8uk4XGMRe6a46UgbL63D+Ln9rEhGyIbWHKylWXyqx+klbyKelF55dhQqR+nNOyMatpJBMZHoohbHBaYzAJwAzelWRRjgGjhaBT8ultjWRnQyGYcKSHsrVU5FZxTjFzSbOg2aGtX2v5Pj8OAmEj5iwzNikirgQ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecTTnR0pD1GxqaJa+pzxoe0guAbueny2YGwMzg6B7us=;
 b=cXffG+5d0jH+p1cRKAbvr4qjIi1vV0zlwHYDUxjsIHvbI7fFre4LtF0SEr/BCG8FbEPfQ5N5XyB+YoV0/2wgVGhYIkylLuGWg8AbXVk/VPWZlhXPmAzCdaX4QZCBB4ng/CpVaPlZg9H5+3+U/96Mpmq4qQujXiTXijVua7Uk6l8=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB3310.eurprd08.prod.outlook.com (2603:10a6:803:4c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Tue, 27 Oct
 2020 14:46:43 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c%9]) with mapi id 15.20.3455.037; Tue, 27 Oct 2020
 14:46:43 +0000
Subject: Re: [PATCH v12 11/14] copy-on-read: add support for read flags to
 COR-filter
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1603390423-980205-12-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <919b7722-f424-8213-f36a-1a64187e5004@virtuozzo.com>
Date: Tue, 27 Oct 2020 17:46:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <1603390423-980205-12-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.93]
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.93) by
 FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.6 via Frontend Transport; Tue, 27 Oct 2020 14:46:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e82957ef-4bb5-48a4-8920-08d87a871f4e
X-MS-TrafficTypeDiagnostic: VI1PR08MB3310:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB331081E9BB7A3DF05C43D72BC1160@VI1PR08MB3310.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 19l1C5WISdfegsSAj4O4voKaax8vzd58b5n0AAcfFEmOjJP4MIX0v+qGW460p8hHv3eCeqwXs/w6teiH0e/V/hRMxS26lME+oitV0xVLb5mFO/fVVUTnusKSf6zDJV5sWsdPZYO6wKBN5RMwKcMUQZ0qymunV6MEVKP3Breq4E0ePABQlsdfLeubmXdUMfz2JOA+okHiPxo3B62EjLyYs72rq019Ma2hRQDMny3ZGMSC4wM1e+lLcS8DeRSh5xSjnPhdAX6cP8uQrFS5GbLwwKob+s9Qmg2mz+cQzdVkvSva9Wy3xLjJrQp5PQdRbvFCB2PN4DMrgnPxF9ZUW26Om4Fhox6kwxSTrWotIRPNNG2EjLKM7n+PaO4sr8S6O04y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(39840400004)(136003)(346002)(16576012)(31696002)(36756003)(26005)(8936002)(956004)(2616005)(66946007)(66556008)(66476007)(186003)(16526019)(316002)(4326008)(52116002)(107886003)(2906002)(83380400001)(4744005)(5660300002)(31686004)(478600001)(86362001)(6486002)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: j8WXp46TvP0ZzdtC1F8St0LNdYjawCERxf/ugTAozXrGm8wZoPQAAZr95D3c50TliO4hx1b1Irj96rYGUUPDB0JmQWbwmpbtry/Z07AtF+dau8x6VwoaFU3YT2pvzR98Y5KWpZ71HZJJCjHbyAf5Uh0/xSjfiN6TuBIx968sh8pedGL1nZof5Ab0OB9+9PJ7LK+xOA3mo6FCwkf1IYwSANBKtjw7qiD7IBcDAi7u0Yu6jXiYDW1/Bh8+CanFCD/o0/C1HHEVXOgNN1ouJDqTFqJivHUCZhmABtolDqWcV1k6mrL4cK5KXymizA24RPWEbqsDOdlqQiphn/uQ76L4yhLuOUaOARx3y4UghSK5/RwXxpiw2aXdsfGJIAaPErubB53GnFwvLCOeAMTHIe3Fczva4M/5YUnxaWbwxZ1xR0oZXBbqV+qcb+K24YCrOu5C/Hep6iZOyYfltTR6BvTHvIoiVUvzGtPTXkd8jVM/pgqC8MbTfHHyJtBqYM16EBIfMtn5WWrY7i3/jdPaMZwxYQhWjKKIJcYcSpZAY/68vT9FRAS9wmX5pybv5Lz9qtLu0LgFHYWwXl+91pz4/LBoC9Ctra0wJdS1OlrewU+WE9eroao6B6Rq8GlE8WvNnUdmqRdY30lB6XSQ65Kbke/YGQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e82957ef-4bb5-48a4-8920-08d87a871f4e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB5503.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 14:46:43.8315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtkrfYRk2S6QHbVs4CFScAi2qYITog/FYKhbmXl9j7zLmt7O/IrPL93LRkczaAeke6nNXx0BWKATQ3aCqoUjXaMPEqzPnw1nwwvnBD7/RBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3310
Received-SPF: pass client-ip=40.107.21.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 10:47:05
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001,
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

22.10.2020 21:13, Andrey Shinkevich wrote:
> Add the BDRV_REQ_COPY_ON_READ and BDRV_REQ_PREFETCH flags to the
> supported_read_flags of the COR-filter.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   block/copy-on-read.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
> index 8178a91..a2b180a 100644
> --- a/block/copy-on-read.c
> +++ b/block/copy-on-read.c
> @@ -50,6 +50,8 @@ static int cor_open(BlockDriverState *bs, QDict *options, int flags,
>           return -EINVAL;
>       }
>   
> +    bs->supported_read_flags = BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH;
> +
>       bs->supported_write_flags = BDRV_REQ_WRITE_UNCHANGED |
>           (BDRV_REQ_FUA & bs->file->bs->supported_write_flags);
>   
> 

This should be merged with the following patch, otherwise it doesn't make sense. You mark filter as supporting PREFETCH, but actually it just ignores it (and may crash on trying to read into qiov=NULL).

-- 
Best regards,
Vladimir

