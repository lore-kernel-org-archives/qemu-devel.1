Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D77C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 07:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4752071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 07:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FbdYL2o4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4752071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd7ui-0003Fo-8k
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 03:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jd7tv-0002UO-KA; Mon, 25 May 2020 03:51:59 -0400
Received: from mail-eopbgr30131.outbound.protection.outlook.com
 ([40.107.3.131]:56066 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jd7ts-0005ja-Vn; Mon, 25 May 2020 03:51:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+323GhPMFT1tFvxpJ3SsPZFnvguvg8dtfFp5f2p5GVhCQKzWiw5kmWvcFzRWiEUa39unXTVtAvDdXKVzmdENN8wqKRT6CNaj7iyZykt8t1CagIyxAPdCM38ddRRzwgrwPum9DlLQVrVuaI82Hz6tUSVLJXkkL8RKlT+0L5PRyofWKSnw/eyqoKJ3k+1BUTKE7zsMilPVX8xOtWuCzspjVQ4PGQpby4/cVdQXtZlrw2FwOtar7ozSA6aoabJO6XA2NQz5ZSSHvPkBOeZEpFSGIFXw70BjppMPySrgH14NoWSPBCC1Bt+kkc+0NdVaMsCQiNSf3YiJgl3WRWtlJD0Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+p7PhvKNOSbEf8icfs30whsyBoI9bl0HT+DpEt9MVdk=;
 b=A0/I9DZAotxNSBq27tyFsbTDsB5gW+R3O6qi9C7yWz1WBP3ponNpVCJOh8IwInpOQQmMWHW9+fXt/YZPAiElhFLDWRYRBam458DFY2U4V3Zgose/y+67z1v4Fp9973EivXchY/Ch4ksPQ2T2b8EXoe6KDaJ3jB7sjOosaR/BdZ8CCVsKV81/decEdy1e9ND6cCQLP4P04/21DRhvQu7SVvsvCIZAFZF7kjWqmonY/dWfhzrnPTNxVchJyDYdt+4oiQrvtg6cPusGjWXTWuQOXWquo+dK10qf6NeTVbzjwE5yw0hHqQ6zOuuD6DA2Fw9ZuaSm2EOytBnNcS5anSZKWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+p7PhvKNOSbEf8icfs30whsyBoI9bl0HT+DpEt9MVdk=;
 b=FbdYL2o4TQXTCzPYNfkcQADNcJn9jDiAI+MxbrHwNj9d4qIhD93jLghGpL85w+oSqj/9pUgIgntD7K52pTFkcwW5EufMimxnCmw7yU6mC9V8wZ6qFmipB41GsoFeiVivzTrZ5ngpo0MmL44IAcnTn8sur5TNjfwwZhi4C6s1e8k=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5415.eurprd08.prod.outlook.com (2603:10a6:20b:10d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Mon, 25 May
 2020 07:51:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 07:51:53 +0000
Subject: Re: [PATCH v6 4/5] qemu-img: Add convert --bitmaps option
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200521192137.1120211-1-eblake@redhat.com>
 <20200521192137.1120211-5-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <365251de-7e67-afcb-475c-98a57fdc2568@virtuozzo.com>
Date: Mon, 25 May 2020 10:51:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200521192137.1120211-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0073.eurprd02.prod.outlook.com
 (2603:10a6:208:154::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.147) by
 AM0PR02CA0073.eurprd02.prod.outlook.com (2603:10a6:208:154::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Mon, 25 May 2020 07:51:52 +0000
X-Originating-IP: [185.215.60.147]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb18f4b5-414a-478c-1361-08d800807d30
X-MS-TrafficTypeDiagnostic: AM7PR08MB5415:
X-Microsoft-Antispam-PRVS: <AM7PR08MB54154FE41B749D667A81A3E9C1B30@AM7PR08MB5415.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:51;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q3App6w0amYYmh67tNZcP6qshKzdm7m6O1WgcBoOZ+t3UqaBPHhccq+s5KVkbicKHWPJcGZE9x7UleWkkBNuWi8viSObpbYgFgXA4yDKNAG28batZ3KJu8IDACkVQe1sWzp5MJQEk/C/1xkLEDcZlen9xsdo470qDkQW7FwZcREgSEEJLvyPs2WarfdAwx6C3m+Qer1xwR76g5XrptNFvhuohwcj5VmfxZ5lw0rEG55xCoWkpnjvLUiY82g4SenbSImIAR6sR38V0o4YkJmeyw7kTSRV9sX70n4BOf+dX4xdwrgxBW7BMu49PF6hys0EUS9+c6V2xaK21tl4BDjCxOvfos1N9+J5cPKiZxFH2t4YtNBZmqU9VAQCAwY368+BjgBhwfDotBSwEQrI/nBLFmrNgbo6AzOO8cC+9uLeV7X52hYPQ76DU4Ji8D/WFK+BQHeSC2DwLaaw4R3RlTdWJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(396003)(39840400004)(376002)(136003)(5660300002)(2616005)(956004)(66946007)(66476007)(66556008)(966005)(8676002)(6486002)(16576012)(478600001)(316002)(31686004)(8936002)(16526019)(186003)(52116002)(26005)(2906002)(31696002)(4326008)(86362001)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: xxOlaLY7cfzEc6r+dRcYpjBkXuUBUrFwTQpAjB++tlLFoWiJVAsR+XdORAQthYXdQ9LduwcSsDyEKyNQ4FScz2jEIombB1i7uLgrfHue/uq0Fr+687/OMxcAYXL9Y7oUpzGSmQ7Fyu5Pvl+/0SwLSAreskgZSWnsLbKRtf+K9EHB/tzHMKK4tyxdgBthQ21ANBIJzqW9eI4C+/xUSdZX5wZWJb00zy+AoLXN2kCOZnm1pDX0FUdJWaNquPFTRrnHcR4oNrfBH19exvH9JjC2PkTcYDn2oRgnyriZbuiv2FgJNDwVAVZo7cFIVxnDiZzhrjoVOhf1YiSGMOxV4qqxQ5Wy2EEJirKwNjUoj2xwHxr56RcVzkOHBxLOWtGssS9pZIDjlhGjVmJE54gi6eMiFjOWtKMAbb9hob2Gkm69ec0lP0LAJKr7UGyh6H5tseS86ZARUhngI4wHHDccXJMy9xKBLFVtKMpB1XXUdYipOPxcz4XjnzqUyyvcYlUjvuNF
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb18f4b5-414a-478c-1361-08d800807d30
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 07:51:52.9967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANkdiNbgjqV4Sz9WwNdsRkW9talTxp/DMb8coPdLFYSb3ziqNK6pLMOvy59uALpox4c52YW3pYmX2knap4zGBB1dBVh2YxYL1BNRquU0A0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5415
Received-SPF: pass client-ip=40.107.3.131;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 03:51:54
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.05.2020 22:21, Eric Blake wrote:
> Make it easier to copy all the persistent bitmaps of (the top layer
> of) a source image along with its guest-visible contents, by adding a
> boolean flag for use with qemu-img convert.  This is basically
> shorthand, as the same effect could be accomplished with a series of
> 'qemu-img bitmap --add' and 'qemu-img bitmap --merge -b source'
> commands, or by their corresponding QMP commands.
> 
> Note that this command will fail in the same scenarios where 'qemu-img
> measure' omits a 'bitmaps size:' line, namely, when either the source
> or the destination lacks persistent bitmap support altogether.
> 
> See also https://bugzilla.redhat.com/show_bug.cgi?id=1779893
> 
> While touching this, clean up a couple coding issues spotted in the
> same function: an extra blank line, and merging back-to-back 'if
> (!skip_create)' blocks.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---

[..]

> diff --git a/qemu-img.c b/qemu-img.c
> index 0778d8f56614..8ecebe178890 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -78,6 +78,7 @@ enum {
>       OPTION_ENABLE = 272,
>       OPTION_DISABLE = 273,
>       OPTION_MERGE = 274,

[..]

> 
>   static int img_convert(int argc, char **argv)
> @@ -2160,6 +2195,8 @@ static int img_convert(int argc, char **argv)
>       int64_t ret = -EINVAL;
>       bool force_share = false;
>       bool explict_min_sparse = false;
> +    bool bitmaps = false;
> +    size_t nbitmaps = 0;
> 
>       ImgConvertState s = (ImgConvertState) {
>           /* Need at least 4k of zeros for sparse detection */
> @@ -2179,6 +2216,7 @@ static int img_convert(int argc, char **argv)
>               {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS},
>               {"salvage", no_argument, 0, OPTION_SALVAGE},
>               {"target-is-zero", no_argument, 0, OPTION_TARGET_IS_ZERO},
> +            {"bitmaps", no_argument, 0, OPTION_BITMAPS},
>               {0, 0, 0, 0}
>           };
>           c = getopt_long(argc, argv, ":hf:O:B:Cco:l:S:pt:T:qnm:WU",
> @@ -2304,6 +2342,9 @@ static int img_convert(int argc, char **argv)
>                */
>               s.has_zero_init = true;
>               break;
> +        case OPTION_BITMAPS:
> +            bitmaps = true;
> +            break;
>           }
>       }
> 
> @@ -2365,7 +2406,6 @@ static int img_convert(int argc, char **argv)
>           goto fail_getopt;
>       }
> 
> -
>       /* ret is still -EINVAL until here */
>       ret = bdrv_parse_cache_mode(src_cache, &src_flags, &src_writethrough);
>       if (ret < 0) {
> @@ -2525,6 +2565,27 @@ static int img_convert(int argc, char **argv)
>           }
>       }
> 
> +    /* Determine how many bitmaps need copying */
> +    if (bitmaps) {
> +        BdrvDirtyBitmap *bm;
> +
> +        if (s.src_num > 1) {
> +            error_report("Copying bitmaps only possible with single source");
> +            ret = -1;
> +            goto out;
> +        }
> +        if (!bdrv_supports_persistent_dirty_bitmap(blk_bs(s.src[0]))) {
> +            error_report("Source lacks bitmap support");
> +            ret = -1;
> +            goto out;
> +        }
> +        FOR_EACH_DIRTY_BITMAP(blk_bs(s.src[0]), bm) {
> +            if (bdrv_dirty_bitmap_get_persistence(bm)) {
> +                nbitmaps++;
> +            }
> +        }
> +    }
> +
>       /*
>        * The later open call will need any decryption secrets, and
>        * bdrv_create() will purge "opts", so extract them now before
> @@ -2533,9 +2594,7 @@ static int img_convert(int argc, char **argv)
>       if (!skip_create) {
>           open_opts = qdict_new();
>           qemu_opt_foreach(opts, img_add_key_secrets, open_opts, &error_abort);
> -    }
> 
> -    if (!skip_create) {
>           /* Create the new image */
>           ret = bdrv_create(drv, out_filename, opts, &local_err);
>           if (ret < 0) {
> @@ -2573,6 +2632,13 @@ static int img_convert(int argc, char **argv)
>       }
>       out_bs = blk_bs(s.target);
> 
> +    if (nbitmaps > 0 && !bdrv_supports_persistent_dirty_bitmap(out_bs)) {

We will not fail, if target doesn't support bitmaps, source supports them but has no bitmaps? Doesn't seem to be a problem, but a bit less strict than you write in commit message.

So, maybe, s/nbitmaps > 0/bitmaps/

> +        error_report("Format driver '%s' does not support bitmaps",
> +                     out_fmt);

Hmm seems, out_fmt may be NULL at this point, consider the path:
const char *out_fmt = NULL
...
[no -O option]
--target-image-opts, so out_fmt doesn't default to "raw" but remains NULL
...

So, with s/out_fmt/out_bs->drv->format_name/ (and with or without s/nbitmaps > 0/bitmaps/):


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir

