Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D600C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 14:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC2862068D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 14:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TIbo0s5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2862068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg8B2-0002R5-7s
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 10:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jg88p-0008EL-Tv; Tue, 02 Jun 2020 10:43:47 -0400
Received: from mail-eopbgr150100.outbound.protection.outlook.com
 ([40.107.15.100]:8833 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jg88j-0006ae-EP; Tue, 02 Jun 2020 10:43:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iS32aqUE06PMLas7vJJgiwgxgm96ET8ExeFFPzXjPGWCA7d/lBodcyVjajYUEvuU3HiPKx1v/NM6WzCJE1g2nFKhLCQDJAccpTEQabB/QL8JPrPtzuWy8RO0c2WibV0bZTbaPlqvKKNSOpwsiCJVWnyGZYWURKPDve6q8qBGUNh2TIVG+W0mympwiWyUlz3TLsfe3/v2KZT1nFRS6mb0qhn6wzvmqQeApXeMkFH29uHH09hgSngnBChL/yhgjo9wcZygmRBf8Q4AW1NKNbUvSNCkK+O0lW5GkTVx84tBT1ptT3wQz+0TO0leP2IwNHS7P+cINsUJLl+89zY/Az/2bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dR/d0LyTMpIV0TFKZEhYBJBuIxuGIxHvmDHYQtcuGMM=;
 b=aIVObvSQsGfseuUqATL73atkXzDdEpBXHjabPu7y1mVtxuQD0Tj/8AmRYwbIU54Jcjr1Ml8cBFilvqWHN/iwLJ/yxP8Gi/RBgtvr4y3Kb1SHII8c3bf4kcKeaTfbtXkhOeGi5MvFfZh4uhmoJaD4ttmo5/hyxAdiMB0Y5OO8IITNmU/yVe/CMgSNWGCmEU2ZXnCC8wr73S9W//DgEJBlksHEN5rjFtP8/vl90xsB5GMX6AbVGJZvK/Tp4eoJL5/n8vLmnsUpnPxYmGdcgt6ENVEi5PqYAxv1C24ixSxNIuz1fwUf7a/lkE7LoUSnYpYwvtyaw66GeQkMaj67iAFDOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dR/d0LyTMpIV0TFKZEhYBJBuIxuGIxHvmDHYQtcuGMM=;
 b=TIbo0s5JTt+1vTg7KeY4H/TMkIaZbTbNIFt4QbUckvx0NfGjW3R3h9J/TNp5YAfRP7ZED2GDmywm1MjYhNlqmvrJMhutPlWWzRI7M+lW5VpCz+h46IkOszW70B7Uf1fE/UNMkMos+pA83wq3tmddwsmDn+FCKXrnZ3a6lVhfO4A=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5336.eurprd08.prod.outlook.com (2603:10a6:20b:105::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 14:43:37 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 14:43:37 +0000
Subject: Re: [PATCH for-4.2 v2 3/3] block/file-posix: Let post-EOF fallocate
 serialize
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191101152510.11719-1-mreitz@redhat.com>
 <20191101152510.11719-4-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <dfe5fbff-ce04-504e-542b-11095a57fd78@virtuozzo.com>
Date: Tue, 2 Jun 2020 17:43:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20191101152510.11719-4-mreitz@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0063.eurprd03.prod.outlook.com (2603:10a6:208::40)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.153) by
 AM0PR03CA0063.eurprd03.prod.outlook.com (2603:10a6:208::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Tue, 2 Jun 2020 14:43:37 +0000
X-Originating-IP: [185.215.60.153]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8850f6a3-72c5-4dac-f669-08d8070355a2
X-MS-TrafficTypeDiagnostic: AM7PR08MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5336305BA51CAD9383260130C18B0@AM7PR08MB5336.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PJ6hlIYXosNe/0yS7gOIb1dcW/oVwXeUJnWqATLkS5XhpemyJkz55f7m1oLZp7qXdR+qwMSUCrBmTXQgBlXfn0RqWoBECaDyITEEuPAKboR14QUvAj7qOKmxGcmmCw3BNjVSyAuM0grDs21MSfeZoiwPhzOBQ27HsXNioNn9cxYvYfadt6hdxLn86BBcwDhxLkFD8006H4/vfbBiyZVBsBFJVEOQLn7sILCrZAZcnPL4WL6F9pn+ia0ejPmrr0S/F6Lfgf5q2sNeFUjye+ev86O8KvG8ZHUB3UYx9yjRVg3N4emjCZooNQds9Ywwuro9NlOzKmP5oCPjDKYfvBr6g2Nh2hxUes/uNIhfxKRUVHteR3Eg7gnb+1sbW32fTe4d
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(136003)(346002)(39850400004)(376002)(5660300002)(86362001)(2906002)(8676002)(16526019)(66476007)(66556008)(66946007)(52116002)(186003)(8936002)(26005)(2616005)(54906003)(31686004)(31696002)(478600001)(36756003)(4326008)(316002)(6486002)(83380400001)(107886003)(16576012)(956004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: VuAfmulS4HmcPNJ6wQVdMtd6sZ9JJlJypt+OAGcoBwEdL16/nO2g+YqLCGejt1gkTDExZvrB76XEXTcLvJu64diq6ysIFT/XFCE42RzNaKTsC4vuLGWZzlSBjFh+FYdmTDDGQ8Fs3qh5VnIQlW6QxYvqeqDbZ/HV+WvjV9sdXUuCq5NKsJWF0+8NUaNR4/o9sL9feQvxWl8Q4Q7MPbQnQD7NhLEhGgbCULptpmVx7AAvIJ0CzkHEcrNC2ZQkbph+ybTA1Bu9qT1C0xc05OdXibsQnhUywPVuEh8hG5zWKTY0ZKjG3Y4VfTZRGMIL4es5L4CePw7e/rMFFn5nr2g+bxpjFRZYf4vRl3wOWbLAAXCV9gWSkP9kC53uBo2qmsYWNT9EBlpnNQlgY9n4no5/E5FA6Xikaitk4FrfBGSXlHTN37n9i4tpcgXa1I9Y92MsP6C31tPhH27FhgXo6mUdQskRYdj5M/q1N1RjQ/EwCkxFCG5eAfaAxx1312hyLFzY
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8850f6a3-72c5-4dac-f669-08d8070355a2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 14:43:37.7254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCF7Fl4zw8/ANuyXoIIAgPIozP+yrvonhvrUjxgI7v95nrwqU0d1D99FTsU7+OhoBgr6ynYV5bxJQOyUYRnjFuf4oPbSjkr3m7AFKw5M/LM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
Received-SPF: pass client-ip=40.107.15.100;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 10:43:38
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

01.11.2019 18:25, Max Reitz wrote:

Sorry for being late, I have some comments

> The XFS kernel driver has a bug that may cause data corruption for qcow2
> images as of qemu commit c8bb23cbdbe32f.  We can work around it by
> treating post-EOF fallocates as serializing up until infinity (INT64_MAX
> in practice).
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/file-posix.c | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 0b7e904d48..1f0f61a02b 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2721,6 +2721,42 @@ raw_do_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int bytes,
>       RawPosixAIOData acb;
>       ThreadPoolFunc *handler;
>   
> +#ifdef CONFIG_FALLOCATE
> +    if (offset + bytes > bs->total_sectors * BDRV_SECTOR_SIZE) {
> +        BdrvTrackedRequest *req;
> +        uint64_t end;
> +
> +        /*
> +         * This is a workaround for a bug in the Linux XFS driver,
> +         * where writes submitted through the AIO interface will be
> +         * discarded if they happen beyond a concurrently running
> +         * fallocate() that increases the file length (i.e., both the
> +         * write and the fallocate() happen beyond the EOF).
> +         *
> +         * To work around it, we extend the tracked request for this
> +         * zero write until INT64_MAX (effectively infinity), and mark
> +         * it as serializing.
> +         *
> +         * We have to enable this workaround for all filesystems and
> +         * AIO modes (not just XFS with aio=native), because for
> +         * remote filesystems we do not know the host configuration.
> +         */
> +
> +        req = bdrv_co_get_self_request(bs);
> +        assert(req);
> +        assert(req->type == BDRV_TRACKED_WRITE);
> +        assert(req->offset <= offset);
> +        assert(req->offset + req->bytes >= offset + bytes);

Why these assertions? TrackedRequest offset and bytes fields correspond to the original request. When request is being expanded to satisfy request_alignment, these fields are not updated.
So, maybe, we should assert overlap_offset and overlap_bytes?

> +
> +        end = INT64_MAX & -(uint64_t)bs->bl.request_alignment;
> +        req->bytes = end - req->offset;

And I doubt that we should update req->bytes. We never updated it in other places, it corresponds to original request. It's enough to update overlap_bytes to achieve corresponding serialising.

> +        req->overlap_bytes = req->bytes;
> +
> +        bdrv_mark_request_serialising(req, bs->bl.request_alignment);

Not sure, how much should we care about request_alignment here, I think, it's enough to just set req->overlap_bytes = INT64_MAX - req->overlap_offest, but it doesn't really matter.

> +        bdrv_wait_serialising_requests(req);
> +    }
> +#endif
> +
>       acb = (RawPosixAIOData) {
>           .bs             = bs,
>           .aio_fildes     = s->fd,
> 


-- 
Best regards,
Vladimir

