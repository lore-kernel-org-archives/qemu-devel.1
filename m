Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4B9C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 06:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16FAF2098B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 06:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nA8AP0mP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16FAF2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRs70-0004a5-4V
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 02:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRs67-0003vD-0B
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 02:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRs64-0007wV-GO
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 02:46:01 -0400
Received: from mail-eopbgr40105.outbound.protection.outlook.com
 ([40.107.4.105]:18830 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jRs63-0007rE-PF; Fri, 24 Apr 2020 02:46:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxLJ4yx4M4YanGeYDV0ZUxcMjoG1gQCHp+K4pJ5kIhP2d+wclX0VrIg/GkC6kC0Y18NowlmVps3he9Tr00weaXhbP1aJQBMru555rol+2bdpjygGVKqbaa5fAQgbdvPgjVql98gpa0NUVOdyByUoofZCsktbWFULXjWDlOuuRr2LJuCjHlWU7kRv2hF/8SqSQQud69cQ3/JeRmfuPHMntVhPPFaW84RX+QWehXCU+Lcr+dWMWyGfIifttzHBOtvIMUElumL+GDDTAm8XFGbMXv4Y3WeKYdJmmIS142UhCSV3icYNaucWrID+rElvW77/TloWw0l4J5fRf86uzmh7Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdhC/S0ghQe5R2Y5J+mUbBj3CbzR96Xa1zNHZYZ1gGI=;
 b=c/Lou6R8PDzGBv1HszHYl7jEHid0mqc/wy0lYE3JKLAAYa6zvCUWTJakHB4zH3krv4FWf+41DUdv9xv1jB4KrQTPi7jRJZuc9X5bwWFWSPoQ/7rzD4S6rf7A5WsytSzOf5tdL8MvnmR++1qdoPopSXZlZfLPqXFYfXTqFjscQBwHTWx42soQCt6xRivsTWwlLWnVWE6K3ZSIMK9oSjHY1k/jE8smVPwedk7UdW4+XJ3pYJ+c5Wwsc25/Ex+1GzihS2ZPNfI6bqoUiY/vIXpWPYIUIE6HLqtbrHxJGW4iAuidICq0tEfHxdPWZezSv9zCk3yH9RHEe2bRUNeuZ1qduw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdhC/S0ghQe5R2Y5J+mUbBj3CbzR96Xa1zNHZYZ1gGI=;
 b=nA8AP0mPdf+sWsJ4brJ7lv8jl/9qg6yIVA77sxilxG5v6FsEi5B7O+oPIYQgHYdDf29ozRsLX2j2r24YogxSjqIXp651yxcXgi7o+p5d5/tyCdcEfKrW8LR0ziBCmtpwTt/ySXHr+c5NnFkFAch5XZRrdq7F2DKHqI5bl9siaeU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5526.eurprd08.prod.outlook.com (2603:10a6:20b:108::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 24 Apr
 2020 06:45:56 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 06:45:56 +0000
Subject: Re: [PATCH v6 07/10] block: truncate: Don't make backing file data
 visible
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200423150127.142609-1-kwolf@redhat.com>
 <20200423150127.142609-8-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200424094554409
Message-ID: <f978903a-964e-06c9-3369-d1684c92be63@virtuozzo.com>
Date: Fri, 24 Apr 2020 09:45:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200423150127.142609-8-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0101CA0044.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.145) by
 AM4PR0101CA0044.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Fri, 24 Apr 2020 06:45:55 +0000
X-Tagtoolbar-Keys: D20200424094554409
X-Originating-IP: [185.215.60.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c83a0011-11ef-4505-e958-08d7e81b23f7
X-MS-TrafficTypeDiagnostic: AM7PR08MB5526:
X-Microsoft-Antispam-PRVS: <AM7PR08MB552660C17B8519343A8036CCC1D00@AM7PR08MB5526.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(376002)(346002)(39840400004)(136003)(366004)(66476007)(66946007)(6486002)(316002)(16576012)(31686004)(52116002)(186003)(4326008)(16526019)(26005)(2616005)(956004)(5660300002)(86362001)(2906002)(478600001)(31696002)(66556008)(8676002)(81156014)(8936002)(36756003);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Y4Un42kV+DtDrw/ud3//0Avc1niRRPwogH5FfVMkEaEf0X8GyZ9Hj9yIT1ZTPMUxP7wOh82R9nSMZw2jbobEpA9yZMLxbpQ7NHRneoSUBz7M4qOkNGSfcOVdzVtJk6IULFEUzXMs6I+KqLqfrt615qKOHuAmDOCi4AF+2QYAiT22AP84oxtCmCwU4Z/s2ar5JIbtIPyHi3epgahLw57Ly7i0+fFPxggAz4xHpUAufkQ785rC+NY7UNISuh3Io5Rcm+5KsfvTamzFasG5WKq4twtZ38lKJzbqLc22RyGY6QCmZa8Z/DMsH2IfqXYY/6zJKcKitY4C8aP5M2izZunkUT7CCXExiUCpaicXv+rm0Ms0pfP/ESjcBQeVDMdVlnbhTcRvNYYzgOaPZYk9A/9PGEpzcYHl0Ou5UiarkVoaXhExp+96HV4Ifv6tDc228F/
X-MS-Exchange-AntiSpam-MessageData: /NNhXsQFaNl5OX6ZwnsndZIdSwgzT312ehWC0EsPIh3aboVbddolGjUcN8xwxKfDyH7EO0RrqBdkHNX/2+SyfHqF2nWQyN75nP5xCwDNZmS13yFl2JR2jGJ8qW7+VaFJlJzj2pKsdZPmQM1OHyW22g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c83a0011-11ef-4505-e958-08d7e81b23f7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 06:45:56.2241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LRs2O6y2iPCeRvAVZ1XfHajhV0ubpJNWlKLNxS/OaoKg5IVlo7vUlnFAQuZIgqoY7nFppj1fsmQCjpvj9S85eBfd05HWWysd/51p+MDeqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5526
Received-SPF: pass client-ip=40.107.4.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 02:45:57
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.4.105
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
Cc: berto@igalia.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.04.2020 18:01, Kevin Wolf wrote:
> When extending the size of an image that has a backing file larger than
> its old size, make sure that the backing file data doesn't become
> visible in the guest, but the added area is properly zeroed out.
> 
> Consider the following scenario where the overlay is shorter than its
> backing file:
> 
>      base.qcow2:     AAAAAAAA
>      overlay.qcow2:  BBBB
> 
> When resizing (extending) overlay.qcow2, the new blocks should not stay
> unallocated and make the additional As from base.qcow2 visible like
> before this patch, but zeros should be read.
> 
> A similar case happens with the various variants of a commit job when an
> intermediate file is short (- for unallocated):
> 
>      base.qcow2:     A-A-AAAA
>      mid.qcow2:      BB-B
>      top.qcow2:      C--C--C-
> 
> After commit top.qcow2 to mid.qcow2, the following happens:
> 
>      mid.qcow2:      CB-C00C0 (correct result)
>      mid.qcow2:      CB-C--C- (before this fix)
> 
> Without the fix, blocks that previously read as zeros on top.qcow2
> suddenly turn into A.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/io.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/block/io.c b/block/io.c
> index 795075954e..f618db3499 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -3394,6 +3394,30 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
>           goto out;
>       }
>   
> +    /*
> +     * If the image has a backing file that is large enough that it would
> +     * provide data for the new area, we cannot leave it unallocated because
> +     * then the backing file content would become visible. Instead, zero-fill
> +     * the new area.
> +     *
> +     * Note that if the image has a backing file, but was opened without the
> +     * backing file, taking care of keeping things consistent with that backing
> +     * file is the user's responsibility.
> +     */
> +    if (new_bytes && bs->backing) {
> +        int64_t backing_len;
> +
> +        backing_len = bdrv_getlength(backing_bs(bs));

this fit in one line with backing_len definition

> +        if (backing_len < 0) {
> +            ret = backing_len;

with errp set, as noted by Max:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> +            goto out;
> +        }
> +
> +        if (backing_len > old_size) {
> +            flags |= BDRV_REQ_ZERO_WRITE;
> +        }
> +    }
> +
>       if (drv->bdrv_co_truncate) {
>           if (flags & ~bs->supported_truncate_flags) {
>               error_setg(errp, "Block driver does not support requested flags");
> 


-- 
Best regards,
Vladimir

