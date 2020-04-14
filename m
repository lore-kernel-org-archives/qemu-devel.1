Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C38C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B5A8206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aKsYy4zI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5A8206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOKjj-0006g8-CQ
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 08:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jOKi5-0005ME-R2
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jOKi4-00008a-KH
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:30:37 -0400
Received: from mail-eopbgr60125.outbound.protection.outlook.com
 ([40.107.6.125]:20128 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jOKi1-00006z-Vh; Tue, 14 Apr 2020 08:30:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3HqN2A3N68vQSWvDqBs8tisbXkMMM/PBtVgQl+uEQXCT83a44cbMAPNlbL+k++n0Gclg+3mq8lG7NX1pWF7J/pzC+oPnXC2J+t1i1N2lGR6NvkMzTkGvj6qnBnwSVJ3MlIkeRD85eglxEOZrz9NtKM6hzkiaNF/A0RuigxXmzmcc3owj8DvlIi6+fXQlTLQ0HYpxMXx+1en2lJr5Rj6Gzj/cZD5GpPQpwXd5UoTGebZeARyDWLChTtiN4cqpvHoQc0e51MR5Ouivgf5naz7b051/k73w6kdg4JfbnG0BRZM4qpV1r0kzu2M2CTGAqEqTsVnMyAyFSsS39gcin8HCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yfdxGS2onUM0lP77u0GGGzf6WDIWApqBmoHhqZ1aiA=;
 b=b3+3dOsYrMQjnf3uHVHH3eHMhgNmEhecEEBlXKdN+Xs7ATWOEyh9YBZGtUNKBhfFANCa6qE338VgRDJi6lMqwFLXo7Cj5sGdMJbRW2BVLEmNlAj5AKVdqlwZeB35rrWS7SB05KwoBCOBDzdC71xCsM23TZ6oxZuPYOkFbBfDIEhFoToe+v0E8aeei8NWEsuHI24qQVoNnhScJe/81KwRhTzSvLxujgouPe1Ch61m2/Nsmg35RXVx37xT7BBkyVST4rXOnTypdwo8BPR0nuaatF84m1csk4cRql9rEQZqXWMtg37YD2QkK+YE7YrzGLTRw6lM92FDRLD4ARdGz1AJDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yfdxGS2onUM0lP77u0GGGzf6WDIWApqBmoHhqZ1aiA=;
 b=aKsYy4zI415FasjaYZeP4GKhrdj7E6O/5iRcXLbe7nZHO3uVPk0om4DfvHaDiq2pf2dIEwlJezEMeGiVNhCeSO2gbvtINHtlw04hT+ae1lDYdWE9hE6oyDVUx/htXdDJJZyR6UaLFzn8IG7+QlSJ0A066N/Frk1cx2Vhds/lIn8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5367.eurprd08.prod.outlook.com (2603:10a6:20b:dd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Tue, 14 Apr
 2020 12:30:32 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 12:30:32 +0000
Subject: Re: [PATCH v4 14/30] qcow2: Add cluster type parameter to
 qcow2_get_host_offset()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <348c0b057802b5b35eefe3dc7cc8ef2964024ed5.1584468723.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200414153030110
Message-ID: <ec5d4b90-b491-4173-a080-7e607a7b9f82@virtuozzo.com>
Date: Tue, 14 Apr 2020 15:30:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <348c0b057802b5b35eefe3dc7cc8ef2964024ed5.1584468723.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0107.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::48) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.131) by
 AM0PR06CA0107.eurprd06.prod.outlook.com (2603:10a6:208:fa::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.17 via Frontend Transport; Tue, 14 Apr 2020 12:30:31 +0000
X-Tagtoolbar-Keys: D20200414153030110
X-Originating-IP: [185.215.60.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83709e35-908c-4ae4-26e7-08d7e06f9f80
X-MS-TrafficTypeDiagnostic: AM7PR08MB5367:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5367B697E1FABBAB2768BB71C1DA0@AM7PR08MB5367.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:486;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(39830400003)(376002)(396003)(366004)(346002)(66946007)(6486002)(478600001)(5660300002)(31686004)(31696002)(8676002)(66556008)(8936002)(81156014)(2906002)(66476007)(16526019)(86362001)(54906003)(52116002)(4326008)(186003)(16576012)(956004)(2616005)(107886003)(316002)(26005)(36756003);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oFfEzKoWvCCK23mdD+QxBllqCgM3RWeks+8FJYPqzcg7nK0TSLatNu8A63w30wvorsMmitPi2fJfCQHGOcVvu1EIxySlxs7z6hQEVp6GujL5UkmdhpsDeV7Mlz4IG80+COFVXQAIFPbTTFyqLjmCXnWIrw7ychTL0/cZcTOHMXCkpmHt4lwu0MHhGcpSihz1AEnirK7WrJcei5IftpX301yhiH1Vrn+EeXBut9DyDn7cf4z7aywwBATQr9FSIyMZQiGmyQWAYzWnS24x9Ljk1RN/rIwVdfCCvJXnS46AHFSB5AHRL+C7RRDW6uj2XiLjpp/GaJpXtfgzovEtDT/VwfGfgDv1UiDLZRt2hlKEZOak/qj3aiOxnY3Oxq6zja3OQWGhfgc7DIsFDe85cZfQEDtOfk8+G8qCNCSMgwLdESK1iSA/4WsL8Ts22ACWn4Jo
X-MS-Exchange-AntiSpam-MessageData: XknxvFLvOrpeqIBstlrrGnfQd8r769npcwg8edIHF2VLnZrPDvYuNyqm8wAhbFFm/AnnWVFEJolGKLZnmzL/tNoxVPB3Dj+l9p/QA86AQvLL+lp0dXvRx36YeqXm/ldIvyrNiB5NJCUEoBsS2lpK9g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83709e35-908c-4ae4-26e7-08d7e06f9f80
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 12:30:31.9327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WczUL4nVvMEDX6aPhz9Yn+arr04/4HuPcvmFddLtCmI79hMzLCHE+v4jVYS64+IRrqo9aA6kaX4LPD1PCBmjaY5VVkv8zVjeZ8WtTTq200A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5367
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.125
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.03.2020 21:16, Alberto Garcia wrote:
> This function returns an integer that can be either an error code or a
> cluster type (a value from the QCow2ClusterType enum).
> 
> We are going to start using subcluster types instead of cluster types
> in some functions so it's better to use the exact data types instead
> of integers for clarity and in order to detect errors more easily.
> 
> This patch makes qcow2_get_host_offset() return 0 on success and
> puts the returned cluster type in a separate parameter. There are no
> semantic changes.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2.h         |  3 ++-
>   block/qcow2-cluster.c | 11 +++++++----
>   block/qcow2.c         | 37 ++++++++++++++++++++++---------------
>   3 files changed, 31 insertions(+), 20 deletions(-)
> 
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 52865787ee..6b7b286b91 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h


[..]

> @@ -3716,6 +3719,7 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
>       if (head || tail) {
>           uint64_t off;
>           unsigned int nr;
> +        QCow2ClusterType type;
>   
>           assert(head + bytes <= s->cluster_size);
>   
> @@ -3731,10 +3735,11 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
>           offset = QEMU_ALIGN_DOWN(offset, s->cluster_size);
>           bytes = s->cluster_size;
>           nr = s->cluster_size;
> -        ret = qcow2_get_host_offset(bs, offset, &nr, &off);
> -        if (ret != QCOW2_CLUSTER_UNALLOCATED &&
> -            ret != QCOW2_CLUSTER_ZERO_PLAIN &&
> -            ret != QCOW2_CLUSTER_ZERO_ALLOC) {
> +        ret = qcow2_get_host_offset(bs, offset, &nr, &off, &type);

pre-patch, but probably better to return original errno on qcow2_get_host_offset failure, instead of masking it.

> +        if (ret < 0 ||
> +            (type != QCOW2_CLUSTER_UNALLOCATED &&
> +             type != QCOW2_CLUSTER_ZERO_PLAIN &&
> +             type != QCOW2_CLUSTER_ZERO_ALLOC)) {
>               qemu_co_mutex_unlock(&s->lock);
>               return -ENOTSUP;
>           }
> @@ -3792,16 +3797,18 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
>   
>       while (bytes != 0) {
>           uint64_t copy_offset = 0;
> +        QCow2ClusterType type;
>           /* prepare next request */
>           cur_bytes = MIN(bytes, INT_MAX);
>           cur_write_flags = write_flags;
>   
> -        ret = qcow2_get_host_offset(bs, src_offset, &cur_bytes, &copy_offset);
> +        ret = qcow2_get_host_offset(bs, src_offset, &cur_bytes,
> +                                    &copy_offset, &type);
>           if (ret < 0) {
>               goto out;
>           }
>   
> -        switch (ret) {
> +        switch (type) {
>           case QCOW2_CLUSTER_UNALLOCATED:
>               if (bs->backing && bs->backing->bs) {
>                   int64_t backing_length = bdrv_getlength(bs->backing->bs);
> 
Hmm, just noted that in case of bdrv_co_copy_range_from failure below, we do mutex lock/unlock for nothing.

I think, we want mutex lock/unlock just around qcow2_co_preadv_part() call, like in  qcow2_co_preadv_part above().

I can send a refactoring patch..

Anyway, patch itself is OK:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

