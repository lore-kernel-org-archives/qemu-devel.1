Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411C7C54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C09206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QugORl2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C09206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT4aW-000160-4E
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 10:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT4Zb-0000MD-Fq
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT4Za-0003Kk-GU
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:17:27 -0400
Received: from mail-eopbgr30114.outbound.protection.outlook.com
 ([40.107.3.114]:39943 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jT4Za-0003II-3Q; Mon, 27 Apr 2020 10:17:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6e7KMaRfWKWm5Wp67G+9Lv1CaT8v90UtujXYTDWP698Dif/yT4paRooECW2JdNZ3T7dz5Ck+qWfIOLfEhUZFjl+cmkhOzWVENRJYpCTr+GbQA1QSBA8+fSp4CPHuEq+YE8/uaUDJksGqk4zlj9KaMAso4mMx4rbEUEsEDZ4JLgbpNzJImdmrUcic/bh9mq3i9vKmtjc7WM/5Kstvc7Tmhtp0Q6kk7PqBXkaDtdkDb8bkeI1UuyfVPheQPRuWrj57X4eo8q9Bpaew2xs7ZVP6g9ozLQYZQR0dkyTRr3tFQ+ntZz8zOjpBW9ktr6UXk7eogZjovnyxLRB5ysml1WY9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GrzonbUJEFjas75igrb0571nER+Hujszf160KiyILg=;
 b=M3C2y2tBsnhz3cBkSb29fogUmajKGrzCSrA+EUtrCRuz53wEVccNKz2/hlBrpt/rCVOC0WmXtGWdNirD/T0SbjNXSNkZYj7WjtyRJo/e+AcDCRwro9DTVdPr1JlrPAzbsAjGQA4eZlh3++1bauwa8HataPun6101//hF+PxPssn4N/1uCC9JdjQDZrlcVm4fP7iYA4y20QHWXe7nxUonqos09kKcUoUXOr+ZazFJ8lNVR7aP4NGnIBMGpHn4j3OAXfcB39pmGgBYYcMtnt++tHJoVf6XSbBStzGJ/isO+4kNJDvTV9crr8HWHJ5srJCKPF3OEf02KgtCLiDWX81V6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GrzonbUJEFjas75igrb0571nER+Hujszf160KiyILg=;
 b=QugORl2YzQJMr8hHQuKdwTnTLlffad3tsPQXWiQEKj3bZmNww3W/N5x7ZRwhxyzUGFfoBjVAWU7YR6T2i4A8SkD+Uww0jx0NQ2mP2WKuSNeInAiTLJwCiBqsaBPYF4+NthElJxPTnZ2j3VTpcYhaQTWGWYIULN8Qm0GC+s/agv0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 14:17:22 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 14:17:22 +0000
Subject: Re: [PATCH v2 00/17] 64bit block-layer
To: qemu-block@nongnu.org
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200427171720125
Message-ID: <ad462d24-e1a9-da6a-1494-be9784b4606f@virtuozzo.com>
Date: Mon, 27 Apr 2020 17:17:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200427082325.10414-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.182) by
 FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 14:17:21 +0000
X-Tagtoolbar-Keys: D20200427171720125
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e252643-1a68-4c0d-4419-08d7eab5b3ec
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5381A1B5C33B41609B85692CC1AF0@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(366004)(396003)(346002)(376002)(31686004)(2616005)(956004)(66476007)(966005)(478600001)(16576012)(66556008)(66946007)(52116002)(31696002)(81156014)(186003)(16526019)(26005)(86362001)(316002)(8676002)(8936002)(7416002)(5660300002)(2906002)(4326008)(36756003)(6916009)(107886003)(6486002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bsg/W7u0GM5yGLfMpdDqWWdpt7Qi/a9BabuXk52bHX25hC0yYKcx7beKFMu89nq9GpH0NFjCFsSYohDCKV/AHbvhus6OxSyAZCS7PBQ9tDNAzwMSBoccKX80eTCQAgUAc1yA50lwHkmKpdrwt4mORVYtn9bXWS2OZGDBBXgUH2vI1g9YXWXHFG5EJlCiI8m9uQVVaVtUpddJ9hB+FgySnDK1C7ii1U9fyyZMoflYIIH6Vx6qlQShYJtUQrwuAyOSCq0yLGZVPAIy0SW+Vo1enoIc2K0O5FkoW8QyQpccGlxLX1ssP/1UdV2yZVMq50wyfIXR0Si5L78oBXi91Jj1RNyWkhsYy8lSV8R2osmM+DSp88W7P9D/2UD6CFKs9RF3WrmD1LC7k6yP/hy4dej4CTQE6l07bzQn/if9DlvmhDXo9w6REAt1AkxJpLc4WJbM4NAQi7y5muAqDLNxC7l3VSeToxsyTbrwmwAtetkUqksiqxJ/72qUKGbJxtXHuSxXINTRww8jvAZL3CmsdWu44A==
X-MS-Exchange-AntiSpam-MessageData: pKoiHO9cclUn0kVxgrqauQZXsHufJ9bLd4LlaZfdvSFPSGAN7CrNtoYJGuj75G/m4Vc9n6J4pZDIOA/RkW+5BFp/8fKDoZrXPxC5qIpE6UBGwgJUfKJgqo7PECecYx4X4QICzMmEwRjuVr8gGs2h/q51r3eXZ3T91/gVZ5apm0PqqVlnrbxUbM+lUTRKlOs39iHxnAe1mBB1fFi9Ab+THhcnwOomVFV8MQ8LzZSi4qVd75zZyBMpUCXT5vDbCySgacDRokR6G/CJhBomShjNRuOEg0wz8crJNHEMOdZd6KQCgkVRvqQ8DsGh/vpL6rsKqmu5bho3ZUvPxj1wIjzxnbMGXFExpOT3BylQ/jC7836EuiJd7SaPRabZuN9TNlN1IdLXGw4JK3FsbitX/FYj9W6ERI91hj4hmK1ILXHXxNxhqm5D65LNXj5V/lP4ydo4FlhIm+cPicizxJIyEuEZM9/Zu+3yV1Q5/VNx4O9ZqGeNzrOjxsElFVQdglX0KFEo7F9YGsoMPD9KLPPH/Yu7SgULqhMYy5i/1nPZv85EFB0/v5HugzpNuv3FkdCNWVGJmKT33C+bTfvlh5Q1ADjlaa2z0APnxfja+VZb19swzSeKWoIY6B5mjusTZlff6uInGwossNRFSXMuK2MUDB+gp8m+7P/AO4f3cB/L1rKrWglH5McM0Z8GpUE0bZcg117f7pKzDVtbwAZNPOR7B50jenMSpYg1z2BCRr/Vwcpiy0S2kEGyLoOOvck47FGRYIA4Pr4vomYsMjsRzE1NE24WYerd20/1nJ2Keb76Fm0RcR8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e252643-1a68-4c0d-4419-08d7eab5b3ec
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 14:17:22.6711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLoKcDNZYv5pfIzd3F+CmwPJH5rMh3XqJMIhLpXJCRA9HDdX25tOX9RnIJax8K9hshuLpvq7+gI+dYiaUHdUJsjzrwHGF5tw2qKmfjOL5IY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
Received-SPF: pass client-ip=40.107.3.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 10:17:23
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.3.114
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

Hmm. I definitely should rebase it onto "[PATCH for-5.0? 0/9] block/io: safer inc/dec in_flight sections"...


27.04.2020 11:23, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> v1 was "[RFC 0/3] 64bit block-layer part I", please refer to initial
> cover-letter
>   https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg08723.html
> for motivation.
> 
> v2:
> patch 02 is unchanged, add Stefan's r-b. Everything other is changed a
> lot. What's new:
> 
> - conversion of block/io.c is now done step-by-step, to make careful
>    review possible as well as future bisecting
> 
> - converting of driver handlers split by io type
> 
> - convert write_zeroes and discard (so the series is not called "part I"
>    any more). I decided to convert most of things alltogether, leaving
>    simple wrappers only in unobvious places. Still, if you consider it
>    risky, I can refactor it to use only wrappers as a first patch and
>    then update driver-by-driver, but it would be lot more patches, I'm
>    not sure it worth doing.
> 
> Vladimir Sementsov-Ogievskiy (17):
>    block/throttle-groups: throttle_group_co_io_limits_intercept(): 64bit
>      bytes
>    block: use int64_t as bytes type in tracked requests
>    block/io: use int64_t bytes parameter in bdrv_check_byte_request()
>    block/io: use int64_t bytes in driver wrappers
>    block/io: support int64_t bytes in bdrv_co_do_pwrite_zeroes()
>    block/io: support int64_t bytes in bdrv_aligned_pwritev()
>    block/io: support int64_t bytes in bdrv_co_do_copy_on_readv()
>    block/io: support int64_t bytes in bdrv_aligned_preadv()
>    block/io: support int64_t bytes in bdrv_co_p{read,write}v_part()
>    block/io: support int64_t bytes in read/write wrappers
>    block/io: use int64_t bytes in copy_range
>    block/block-backend: convert blk io path to use int64_t parameters
>    block: use int64_t instead of uint64_t in driver read handlers
>    block: use int64_t instead of uint64_t in driver write handlers
>    block: use int64_t instead of uint64_t in copy_range driver handlers
>    block: use int64_t instead of int in driver write_zeroes handlers
>    block: use int64_t instead of int in driver discard handlers
> 
>   include/block/block.h           |  16 ++---
>   include/block/block_int.h       |  56 ++++++++--------
>   include/block/throttle-groups.h |   2 +-
>   include/sysemu/block-backend.h  |  26 ++++----
>   block/backup-top.c              |   9 ++-
>   block/blkdebug.c                |   8 +--
>   block/blklogwrites.c            |  12 ++--
>   block/blkreplay.c               |   8 +--
>   block/blkverify.c               |   6 +-
>   block/block-backend.c           |  60 +++++++++---------
>   block/bochs.c                   |   2 +-
>   block/cloop.c                   |   2 +-
>   block/commit.c                  |   2 +-
>   block/copy-on-read.c            |   8 +--
>   block/crypto.c                  |   4 +-
>   block/curl.c                    |   2 +-
>   block/dmg.c                     |   2 +-
>   block/file-posix.c              |  42 ++++++++----
>   block/filter-compress.c         |  10 +--
>   block/gluster.c                 |  14 ++--
>   block/io.c                      | 109 +++++++++++++++++---------------
>   block/iscsi.c                   |  34 +++++++---
>   block/mirror.c                  |   8 +--
>   block/nbd.c                     |  16 +++--
>   block/nfs.c                     |   8 +--
>   block/null.c                    |   8 +--
>   block/nvme.c                    |  33 +++++++---
>   block/qcow.c                    |  12 ++--
>   block/qcow2.c                   |  29 +++++----
>   block/qed.c                     |  17 +++--
>   block/quorum.c                  |   8 +--
>   block/raw-format.c              |  32 +++++-----
>   block/rbd.c                     |   4 +-
>   block/sheepdog.c                |  11 +++-
>   block/throttle-groups.c         |   2 +-
>   block/throttle.c                |   8 +--
>   block/vdi.c                     |   4 +-
>   block/vmdk.c                    |  10 +--
>   block/vpc.c                     |   4 +-
>   block/vvfat.c                   |   6 +-
>   tests/test-bdrv-drain.c         |   8 +--
>   block/trace-events              |  14 ++--
>   42 files changed, 379 insertions(+), 297 deletions(-)
> 


-- 
Best regards,
Vladimir

