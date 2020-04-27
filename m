Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE63EC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76515205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="f7Uw1Jco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76515205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT1wJ-0004aJ-Gi
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 07:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT1uX-0002cm-2Q
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:26:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT1uV-0006W6-Hm
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:26:51 -0400
Received: from mail-eopbgr80108.outbound.protection.outlook.com
 ([40.107.8.108]:1511 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jT1uV-0006Mc-4q; Mon, 27 Apr 2020 07:26:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iqn2YOFHQUu0NsqqBWH/SyLShWPmVW4ldHswIFf7+awK0Hd+Axd9Yep5tFt7WPb+dOhzo99xICsb3O6ue7MV5nnHY8roSxkJCovMu0uTeENEAvO7zDyfzpWMjotfC5c4FUZPLe3vwtRLQwr99I7n5BZwa6lkfScI2gmP9VYX5sycSzacR66RMi58v7LQsT7kjhySr0zxjAB/Le5NmBJ4+0uzErjsqSMWaXdCBgwut3b57aVRZrTs675NGUnJWI3F6YLaISyK+RGa5bU1S+mKg8lmV+nNPzpxPIcveibKNlgj0SYDeFAgezYveAACwjP7HgrXbCDU2N53XdOIMq4a6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9PibjwoWUpNdYymMCF8mtNA0L7nAxa39228NTCEm88=;
 b=Y94lB9Al8EMhYTo3+H3hV49gvRXRa8JWU1N//SyR7ma9bbk4h16lHY8z+tPqH2sWbuC7CMnqIewXHLvp366KFHo8HVJ/4YYg+SWo+73tYAhPmJaVslwmrRxl6n4wxdAIKy5Z9v8XrABo2cW+63Lt6uz8bLH1z9uUkm4cmPHeExJnr07sTdegMo65tFt+W05gQwvpghMMT3qSrCCCsrP23sDLoVl6RAZuEouP021uqi7pHf4t8ev1EmUqwHni/Mta2BuC2OGIrQwsIq4fEpt+yVQDOJHiAsFgXGPs86bBHN3DiZAORL10ltP4d8rLwenYUM/TLrYfEPcCNJjQp3lx/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9PibjwoWUpNdYymMCF8mtNA0L7nAxa39228NTCEm88=;
 b=f7Uw1JcoiKG5A7qUNK/GoD52+jRbkBL6hbmmkqXcBeoLL3xBuL3pswaSYXw/cSZQca0/rHQ0FGMzpJS6xTSjKROlNjoqs3zP733l8ob47dCBDPlCzo7yH4JZEiwNuq8jVPWXk7SyjNTqheN5mxEshEyZO0++bRfnuh0LB3eqNMk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5350.eurprd08.prod.outlook.com (2603:10a6:20b:101::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 11:26:48 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 11:26:48 +0000
Subject: Re: [PATCH v2 02/17] block: use int64_t as bytes type in tracked
 requests
To: qemu-block@nongnu.org
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
 <20200427082325.10414-3-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200427142646288
Message-ID: <6cc80abd-47aa-db37-61cc-f4f336c29801@virtuozzo.com>
Date: Mon, 27 Apr 2020 14:26:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200427082325.10414-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::17)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.182) by
 FRYP281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 11:26:47 +0000
X-Tagtoolbar-Keys: D20200427142646288
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2f19acd-3120-497c-073c-08d7ea9ddfe7
X-MS-TrafficTypeDiagnostic: AM7PR08MB5350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5350D863B7BA7D40CCEB56C5C1AF0@AM7PR08MB5350.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:486;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39840400004)(186003)(16576012)(6486002)(86362001)(16526019)(31696002)(26005)(107886003)(2906002)(36756003)(66476007)(4326008)(7416002)(81156014)(31686004)(66556008)(316002)(66946007)(8936002)(5660300002)(52116002)(8676002)(6916009)(478600001)(956004)(2616005);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tmRdskM1UUyGnZXMoSXqeZXDu4xVGzFINsZofbD0xwEyT18nEpmC9DghjHyQe+wYz/5+n+aIzbkYSWjyak5oAITv4ud+30ZtHTMGlW2L0tAP+FZCGXP+BBSy03A/APRcWjI+9Nr0W80pBrXKwvzsolr4tZ/GWKEdC2k4FznzyNDOtnhIWGGuD22j9g+4e1S6YJYvqQusAsmRFRyrJilAb1Z4fr+jtuEUkzcEbbMtMnXqJJ8uEtJd/Izs9/84k7Vv7uqPujzZAEgIPJVmZ5CpxThw1j872gPq2RN/b/GkT1xd+arnAks7XhTFP0XNND3khJoYBgGOkjRzAyKOwexM9vJyOfd4FCsU7QYkcEtvshxeBuPZBJB20nM/NOwhIQ9o5GL/cxQxm71Lx8JFoptMX8WMnw+pAvilN9yoZJjH+C8Yb7oF0OFFPPJYC4tZNZdf
X-MS-Exchange-AntiSpam-MessageData: +zc2oVrtmpWnCVk1eHxasCnwE6+fki49rkbx3lzkyjhHNl8e6OEGU+rFhoyqHRrRGRJTwLANVHOPWlvrlNUGvcH59y6sQ4eLgRp9L8CtFbMiW06hKKhw6ySvB34whIO9hgcROwBt9xyWNQWWujTdkn+4k5L6UwtnhSgE0edYTZwmuty1E6btDYPpskjY4CRucDNhGFNWZ3chBnVL3NNvPdI37wt4CVXpCjPV+0QxfHSD42BzSf07Cbx29Vl12S5fgY4Cclb9R8hnBS7ndGkqy27pZKmaef4HVoBqMmK+hpd7ICbk8+3b9tmGxvVqVlgZmlZjsOkgkvr1daRzMr+aY+tcfK9JWQbEFqvIOKUTS2phxqeNM7mAuMYcFvgvm25IUCwyEluwEN6KRvV8ZQ7ewxIyKJthXNHjUzMaMq46ZbVzBH8jZDIAA0y3nNGXauvXB5iZ3yzajWSisfFK2EZ2E/35Jq6+ykfxoL8n0enKmlRqqfEZ6hJQFZGDlGqlZW91EpgbZ7kZIFNbxs7UnQXYKA++kTScJsfPN4rp+dJhiXtCnBJqf4W2XxW6AI0UaQyyiTFY7VJ1T1WBmU+YvfI04COnYjsPDarm8/tT6sKlUREe6xVdK/zC4M4T9RoG8aHfPLVlPH+7TQzS/o1SLQotAHbcEormuLFi9eCGFo7JDvoDqniDXVobVLqlO5236lEXeGM7mZEI+Lmokm+KBH3RkuEzEq/4FHnRVZos9fom89NlGW2QYIZynWw2h0kQtcJWOme2m7+tHDdYxxmPLUaZ0UDOvMs16TB37KxR7jVv7jo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f19acd-3120-497c-073c-08d7ea9ddfe7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 11:26:48.5211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fl/8uoPfM+TW0LtGrDQRZFcU0ylkO0vfPjHqlVxd1ONw19TPZ4w3NsH0ih5QGiv1+gPTRtywvVEVAQXAajOTlrG98JzIBqUUWuKMqznUPBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5350
Received-SPF: pass client-ip=40.107.8.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 07:26:49
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.8.108
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, dillaman@redhat.com, qemu-devel@nongnu.org,
 pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com, den@openvz.org,
 sheepdog@lists.wpkg.org, stefanha@redhat.com, namei.unix@gmail.com,
 pbonzini@redhat.com, sw@weilnetz.de, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.04.2020 11:23, Vladimir Sementsov-Ogievskiy wrote:
> We are generally moving to int64_t for both offset and bytes parameters
> on all io paths. Convert tracked requests now.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   include/block/block_int.h |  4 ++--
>   block/io.c                | 11 ++++++-----
>   2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 4c3587ea19..c8daba608b 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -70,12 +70,12 @@ enum BdrvTrackedRequestType {
>   typedef struct BdrvTrackedRequest {
>       BlockDriverState *bs;
>       int64_t offset;
> -    uint64_t bytes;
> +    int64_t bytes;
>       enum BdrvTrackedRequestType type;
>   
>       bool serialising;
>       int64_t overlap_offset;
> -    uint64_t overlap_bytes;
> +    int64_t overlap_bytes;
>   
>       QLIST_ENTRY(BdrvTrackedRequest) list;
>       Coroutine *co; /* owner, used for deadlock detection */
> diff --git a/block/io.c b/block/io.c
> index aba67f66b9..7cbb80bd24 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -692,10 +692,11 @@ static void tracked_request_end(BdrvTrackedRequest *req)
>   static void tracked_request_begin(BdrvTrackedRequest *req,
>                                     BlockDriverState *bs,
>                                     int64_t offset,
> -                                  uint64_t bytes,
> +                                  int64_t bytes,
>                                     enum BdrvTrackedRequestType type)
>   {
> -    assert(bytes <= INT64_MAX && offset <= INT64_MAX - bytes);
> +    assert(offset >= 0 && bytes >= 0 &&
> +           bytes <= INT64_MAX && offset <= INT64_MAX - bytes);
>   
>       *req = (BdrvTrackedRequest){
>           .bs = bs,
> @@ -716,7 +717,7 @@ static void tracked_request_begin(BdrvTrackedRequest *req,
>   }
>   
>   static bool tracked_request_overlaps(BdrvTrackedRequest *req,
> -                                     int64_t offset, uint64_t bytes)
> +                                     int64_t offset, int64_t bytes)
>   {
>       /*        aaaa   bbbb */
>       if (offset >= req->overlap_offset + req->overlap_bytes) {
> @@ -773,8 +774,8 @@ bool bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
>   {
>       BlockDriverState *bs = req->bs;
>       int64_t overlap_offset = req->offset & ~(align - 1);
> -    uint64_t overlap_bytes = ROUND_UP(req->offset + req->bytes, align)
> -                               - overlap_offset;
> +    int64_t overlap_bytes =
> +            ROUND_UP(req->offset + req->bytes, align) - overlap_offset;

sorry, I forget to fix indentation

>       bool waited;
>   
>       qemu_co_mutex_lock(&bs->reqs_lock);
> 


-- 
Best regards,
Vladimir

