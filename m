Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE449C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 18:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F7A2098B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 18:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QdTZWkWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F7A2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRK44-00034M-OV
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 14:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRK3A-0001fl-JL
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRK38-0000yd-CL
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:24:43 -0400
Received: from mail-eopbgr00107.outbound.protection.outlook.com
 ([40.107.0.107]:1798 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jRK36-0000rI-T2; Wed, 22 Apr 2020 14:24:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlW4HA7J94907gRbBXQhFkjMDadyImwQnW/+4LddoK/j8VQlOBUEImY3WImx72Oq7A7/DsK12Ch2V7CCqnpwf2tum2uQwQeXfn23pD9eef2rRca2lKaVs9nTseUVeTve6/0Cj/UpVO3sqKaFfmaCyICXfNPeQek2TsL2bUKPGnXvU1wQAk0cnifxOTdmBf2XYu8XMKo1SHjq7POPK289jzml3V+Z0CI8B/0PhKUOIj9TaoWgFksjfDRdsgGGduV+mSA8vfxVLBc4lTpdMMZBUV6sQkucM8DFbgTjt/HU/U7l/CWEs+P8b0ZtllqyAofw53QSLyQ7MIztDDAG9U17+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hChnAuFoZSoV09LP6q5DcGXY5jJrqlIPcacyE1nLLgo=;
 b=JrA1Zg1GY2ZmZBlyZZr9bEJgWG8DxcLv5RqB4D5wTpc2w8fJhFjeelw5IrXNJj7hQxbR0iLW3Itx4QltM2a5QuhiQBD+ZxzA9sPgmrArg3CMLETi/qlbPosb396TA4Ni27b7Xx249Vrwm2dUggviugPbdhH2lWAf12xmH2NudIKDuInNWGjBnl6pvewF0YZYStfHfy7iWiBf0K1RzVoEnRd7uig4TJ92Vj1xyFFeI20YKN29EIs3swVl8uu2MV6Kv3nDHhnl4bpld3dkKHFWFqeh/zJCKvlEigZLKa3WJild6n7vpU/EFLYK2cZSsBmBHRRj3/5HFyT1Y/Ec7yvdiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hChnAuFoZSoV09LP6q5DcGXY5jJrqlIPcacyE1nLLgo=;
 b=QdTZWkWAeimlya3s+wx6r2IxJWx3YRQS2peXtxDG4ciz9HtUSGTqPCOvp7R56HLZGdPKEQqGaoUblWYrelk02YINUf+dYFQbk4ZtYans1VyrDWEulB+p4q849fDkvgaA7x03HIHndyiZez4RHIu5o9I225ZAGKOvIvJZNVeN06I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5447.eurprd08.prod.outlook.com (2603:10a6:20b:10b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 18:24:35 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Wed, 22 Apr 2020
 18:24:35 +0000
Subject: Re: [RFC 0/3] 64bit block-layer part I
To: qemu-block@nongnu.org
References: <20200330141818.31294-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200422212433451
Message-ID: <2f3d6f44-0e1c-0999-7e22-752262f5a735@virtuozzo.com>
Date: Wed, 22 Apr 2020 21:24:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200330141818.31294-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0087.eurprd05.prod.outlook.com
 (2603:10a6:208:136::27) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.157) by
 AM0PR05CA0087.eurprd05.prod.outlook.com (2603:10a6:208:136::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 18:24:34 +0000
X-Tagtoolbar-Keys: D20200422212433451
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42236b5f-9bba-4aca-72a8-08d7e6ea6925
X-MS-TrafficTypeDiagnostic: AM7PR08MB5447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5447985291D86C8CC5844E53C1D20@AM7PR08MB5447.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39840400004)(136003)(396003)(376002)(366004)(346002)(36756003)(186003)(8676002)(16526019)(6916009)(8936002)(2616005)(26005)(956004)(16576012)(7416002)(6486002)(107886003)(4326008)(2906002)(52116002)(31696002)(86362001)(31686004)(81156014)(478600001)(66946007)(66476007)(5660300002)(66556008)(316002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +TsIi7HBus9NsEYd5aovHNBMYdTpVWgXUiJanzzRq95lV022BeAyHzcnRjI8jenc03YJI6sw4oBQ6YLaiZ/wEX3FLvGkvyLPfLtcqbq5Xo5jahCh1r+QvQ8RG9j7O+YENKrwYR/+rAgCVv2T0egcj6LYdLKyCGEI8oAT/xxuI/FSNGsGtu8HwghtNJOAFpBIND3GHrO3zh65zGjFWbGXEoEOPJpQqikTHtEQTwz7P5oul0XWixxTVp3k9ve+7UfljnfPJry9w1OeHKOIfpnJEMoHa1xCovsRaVuNXMzODGajZtFgDjM9lvhf1zX0r/W6JoDjyB9rIPsVLbi8EWvaFN7+uTywBD4p67TfwkeZPY7k8RFIJczuE8zLdRTYWKmBvzAVeBTCCDDRRnnFDtEQwGw2ewcmLQ2QgKClSbXiAKuLOXrBZ7gs69l2bqXQsc1C
X-MS-Exchange-AntiSpam-MessageData: NJaNNhuYvcxTZFyMVEF1N0VJETZU7w6bGFu8LGuQRzulWFOlCMa3DzJ6w1Xl4vbZIwPu7VY8D77VTXrktVh6d74L2PLXkg7XewPlsuM5hQcNZJbT395g2xqnj4MbkJZfM87UMzgR4PM/1hTypgZaVQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42236b5f-9bba-4aca-72a8-08d7e6ea6925
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 18:24:35.8296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRLdSNAbVkjsWtOF18Xpqg7uJG4gwexOyO5ZL5YDmCNzLAdpeuIE2KZklTA/qrmM5SqRjfhjtnJfLBaA/nmQzMpNEnzus0HpGVF/JPLA8T0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5447
Received-SPF: pass client-ip=40.107.0.107;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 14:24:37
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.0.107
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
Cc: fam@euphon.net, kwolf@redhat.com, berto@igalia.com, stefanha@redhat.com,
 pavel.dovgaluk@ispras.ru, sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org,
 mreitz@redhat.com, jsnow@redhat.com, ronniesahlberg@gmail.com, den@openvz.org,
 pbonzini@redhat.com, dillaman@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

30.03.2020 17:18, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> There is an idea to make NBD protocol extension to support 64bit
> write-zero/discard/block-status commands (commands, which doesn't
> transfer user data). It's needed to increase performance of zeroing
> large ranges (up to the whole image). Zeroing of the whole image is used
> as first step of mirror job, qemu-img convert, it should be also used at
> start of backup actually..
> 
> We need to support it in block-layer, so we want 64bit write_zeros.
> Currently driver handler now have int bytes parameter.
> 
> write_zeros path goes through normal pwritev, so we need 64bit write,
> and then we need 64bit read for symmetry, and better, let's make all io
> path work with 64bit bytes parameter.
> 
> Actually most of block-layer already have 64bit parameters: offset is
> sometimes int64_t and sometimes uint64_t. bytes parameter is one of
> int64_t, uint64_t, int, unsigned int...
> 
> I think we need one type for all of this, and this one type is int64_t.
> Signed int64_t is a bit better than uint64_t: you can use same variable
> to get some result (including error < 0) and than reuse it as an
> argument without any type conversion.
> 
> So, I propose, as a first step, convert all uint64_t parameters to
> int64_t.
> 
> Still, I don't have good idea of how to split this into more than 3
> patches, so, this is an RFC.
> 
> What's next?
> 
> Converting write_zero and discard is not as simple: we can't just
> s/int/uint64_t/, as some functions may use some int variables for
> calculations and this will be broken by something larger than int.
> 
> So, I think the simplest way is to add .bdrv_co_pwritev_zeros64 and
> .bdrv_co_pdiscard64 and update drivers one-by-one. If at some point all
> drivers updated - drop unused 32bit functions, and then drop "64" suffix
> from API. If not - we'll live with both APIs.

Hmm. Or, maybe nothing dangerous if we convert it to 64bit, and add comment,
that function is not actually prepared for 64bit bytes and depends on
max_transfer/max_zeroes being <= INT_MAX ?

Or, maybe better, keep old functions as is and add 64bit wrappers, which
assert that bytes < INT_MAX, and call old function? This is clean, driver
maybe updated later on demand, and we don't need extra API. If no objections,
I'll try this way in the next version.

> 
> Another thing to do is updating default limiting of request (currently
> they are limited to INT_MAX).
> 
> Then we may move some drivers to 64bit discard/write_zero: I think about
> qcow2, file-posix and nbd (as a proof-of-concept for already proposed
> NBD extension).
> 
> Any ideas?
> 
> Vladimir Sementsov-Ogievskiy (3):
>    block: use int64_t as bytes type in tracked requests
>    block/io: convert generic io path to use int64_t parameters
>    block: use int64_t instead of uint64_t in driver handlers
> 
>   include/block/block.h     |  8 ++--
>   include/block/block_int.h | 52 ++++++++++-----------
>   block/backup-top.c        |  5 +-
>   block/blkdebug.c          |  4 +-
>   block/blklogwrites.c      |  4 +-
>   block/blkreplay.c         |  4 +-
>   block/blkverify.c         |  6 +--
>   block/bochs.c             |  2 +-
>   block/cloop.c             |  2 +-
>   block/commit.c            |  2 +-
>   block/copy-on-read.c      |  4 +-
>   block/crypto.c            |  4 +-
>   block/curl.c              |  2 +-
>   block/dmg.c               |  2 +-
>   block/file-posix.c        | 18 ++++----
>   block/filter-compress.c   |  6 +--
>   block/io.c                | 97 ++++++++++++++++++++-------------------
>   block/iscsi.c             | 12 ++---
>   block/mirror.c            |  4 +-
>   block/nbd.c               |  8 ++--
>   block/nfs.c               |  8 ++--
>   block/null.c              |  8 ++--
>   block/nvme.c              |  4 +-
>   block/qcow.c              | 12 ++---
>   block/qcow2.c             | 18 ++++----
>   block/quorum.c            |  8 ++--
>   block/raw-format.c        | 28 +++++------
>   block/rbd.c               |  4 +-
>   block/throttle.c          |  4 +-
>   block/vdi.c               |  4 +-
>   block/vmdk.c              |  8 ++--
>   block/vpc.c               |  4 +-
>   block/vvfat.c             |  6 +--
>   tests/test-bdrv-drain.c   |  8 ++--
>   block/trace-events        | 14 +++---
>   35 files changed, 192 insertions(+), 192 deletions(-)
> 


-- 
Best regards,
Vladimir

