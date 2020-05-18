Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2448C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 11:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D5CB206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 11:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gdFO41+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5CB206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaeB7-00030b-GF
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 07:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jaeAP-0002Ub-2M; Mon, 18 May 2020 07:42:45 -0400
Received: from mail-db8eur05on2122.outbound.protection.outlook.com
 ([40.107.20.122]:31069 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jaeAK-0005P5-Rk; Mon, 18 May 2020 07:42:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaQHHnIYzWX5qpulkk2WQLkJEb3es2MVehwisUZgL0ky6U4uDv3O2rdVkhBXti4zJfQgkSiRU+Qi+tiRgv517yfwTeCZBqaNCRjUhV9pXj7ytCTnyX+1iheFzv82sKdudArgbl6GHbR1VovBADt25NMcU1epKF14f3AlE7bHjnFBtacqis68xzifisR4V8VeWXieoZJVf1aULNuMpPZMlByG1oGbANBd7iJQALEv5sxhZ4VysAlRijtAlR4MDevxkPvYxzEqS00HzTqnLbHBl3+mbVYxoZsNlQUqjsoFMDBRoB/9e1a3dyDvjWwIfFszJt65w+Dn+0UgiU4nqMCbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aeaa2QMlR+MMH/VQBPWmCimnflQVqf7n/z7ZukdHtxw=;
 b=eAJKMrActLyXA0l5CqmjCawiKeolAjyhG9YBioPkLLqBlOV1DOLIMjW6hi5AB0vaolWe0QJZPAuv5QJSeuX4t/GRW7SQrMMYonDgqp0OIJRicETqPNnkdjQlQ2c1ohB3gBft2Y75d3Fj6Qm95Irqy5BVolJSbpPLSkympNy/1/8oYGazyZ7f3n6+DsQCz4GzHwyjP4XnsYFuu5hBeMyMCNOjHd8qGUTDOieFbbcGxylH0kcJKuNLNWVfXwQ86/fhkboZk8Kfu2go/U79K5LOT1UY6yrssQ9ppG1GoHi3q6av+/nZws5eo8gLVQt1qUsOyKPkpTa+3FggwF0OVRLgJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aeaa2QMlR+MMH/VQBPWmCimnflQVqf7n/z7ZukdHtxw=;
 b=gdFO41+y15cUpryWRDHn9uPiM8ky6WNat0WiOdiPCPQvvtlT0lYUDuCY7eNDXWbVllNWqheo8ox5VWLOxz2qAYCX376siWutTuY3aGumxhWdCW7guQ1d3M4SCYdNZxUEDal2GhkWCpbHT4HJ1Lx/xLjBUyj4EvNw0eZI0qtX+u8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB4160.eurprd08.prod.outlook.com (2603:10a6:803:ea::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Mon, 18 May
 2020 11:42:34 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%7]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 11:42:34 +0000
Subject: Re: [PATCH v4 6/9] qemu-img: Add bitmap sub-command
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200513011648.166876-1-eblake@redhat.com>
 <20200513011648.166876-7-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <92016f3f-a7c1-5384-5968-b89de5f01ecb@virtuozzo.com>
Date: Mon, 18 May 2020 14:42:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200513011648.166876-7-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0067.eurprd07.prod.outlook.com
 (2603:10a6:207:4::25) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.187) by
 AM3PR07CA0067.eurprd07.prod.outlook.com (2603:10a6:207:4::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.11 via Frontend Transport; Mon, 18 May 2020 11:42:33 +0000
X-Originating-IP: [185.215.60.187]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0ae726a-b0a0-4d73-0a20-08d7fb208dfd
X-MS-TrafficTypeDiagnostic: VI1PR08MB4160:
X-Microsoft-Antispam-PRVS: <VI1PR08MB41603A6C11765309AF3D6550C1B80@VI1PR08MB4160.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: euyZgBhcNPNKAWglf5vdrjNaivXU2wiT0QpjQDsxsYa1Jv+QFkaeqv13Ch1sNGAmux5EWXatQr/qRjufPKeodX0WY/6C3Hv4DCa36RuL9VHceB91lbimxWZ/5Yt5ABDeHB1vZB7MHmhe1NsvPKuYbaTEWcv4+QVrw+A2mEHvoso4rKKIQFfa92fkkiePO70PPcJZZfT/7+wvZINxNzbdLwecOLLnTLDzo0tinsinImk3jBzdp1eDy+8NurOG2rseimYegFVQcR+A3Dlvk+I97KYZz0k/onROvZZomug2dhAVdUMxfdH0ivDP1LbelQLRH+Erkr353iPupF7w2cKEaNnzpWHJ/zaXDR9rt8JAnUe++k/LFG3fLzqc4GxWjGQLqne8Gw4jLN/2ZTYlTVYvIgAhO0MItgKYQRdHBzLkaSKgpicLFyFCK0YR1r85xX6lJcSKCTIlmOn3wkLHAE6Or5l+lX/MbXKWwm0MlRoB7lOL/EpOnErxJzuwwJ+bVaxVgteYvR4QHcQqAf4ag5parw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39840400004)(52116002)(26005)(30864003)(2906002)(6486002)(16526019)(186003)(5660300002)(86362001)(8676002)(16576012)(36756003)(316002)(31696002)(66556008)(478600001)(66476007)(2616005)(66946007)(956004)(8936002)(31686004)(4326008)(43740500002)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: PmGA+3HQL5PQoCkLKz/EJaWQLnOZf9NjPnJBz1A3ZAUmCdfx5BrdrYWdsZOeKoaSoiLwqXK5W0o0c6/rlE8845hn1XRDbJlWuxmKViXlqWd71u7BNnu6xa7UA6l5j9Nykt4M3P4P/yesDbBu7vjszX89x0o/Ge+2SQ8SmpOkkBFb9Rfc+3kPB//sjM2WTzeh8xQwygewbMzcjYPUn/bF3ls4SSsLA6p9FxrS8xGgMEBIrfBcV03IOyA/b1CkuYRBE6CRVy88xv1Ek4m7YUthtWKu6K1Cq4/44Nz3JliG7K+MUL8yqE87OKSevM9N9Nu3jNk3xkDA64JmvVjm5J6k66K/YuGuPR9uGVAPC2m0tzgmGynSP6FWZbK46HArylgEGg31f4EZHjTTTQ1pncglzMso74RR4VfgXp5cA2zgfe2+bJe8pz3tqrBODtzxb+0t5FqnIFsbWBUJuzu4BtYEAfKYov7LmqqEqlpOVJY3FMQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ae726a-b0a0-4d73-0a20-08d7fb208dfd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 11:42:33.9479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /poUpAx9hFxdkdbn0rwBjWWyIQv32iz/U0Rx8Pv6D35wha+w5U1cAhnGvOCLSZzlGtW9Q1xCLuLak1R911yUQRXJm+Vs3mXZ1gXA+leJTrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4160
Received-SPF: pass client-ip=40.107.20.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 07:42:35
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

13.05.2020 04:16, Eric Blake wrote:
> Include actions for --add, --remove, --clear, --enable, --disable, and
> --merge (note that --clear is a bit of fluff, because the same can be
> accomplished by removing a bitmap and then adding a new one in its
> place, but it matches what QMP commands exist).  Listing is omitted,
> because it does not require a bitmap name and because it was already
> possible with 'qemu-img info'.  A single command line can play one or
> more bitmap commands in sequence on the same bitmap name (although all
> added bitmaps share the same granularity, and and all merged bitmaps
> come from the same source file).  Merge defaults to other bitmaps in
> the primary image, but can also be told to merge bitmaps from a
> distinct image.
> 
> While this supports --image-opts for the file being modified, I did
> not think it worth the extra complexity to support that for the source
> file in a cross-file merges.  Likewise, I chose to have --merge only
> take a single source rather than following the QMP support for
> multiple merges in one go (although you can still use more than one
> --merge in the command line); in part because qemu-img is offline and
> therefore atomicity is not an issue.
> 
> Upcoming patches will add iotest coverage of these commands while
> also testing other features.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>   docs/tools/qemu-img.rst |  24 ++++
>   qemu-img.c              | 254 ++++++++++++++++++++++++++++++++++++++++
>   qemu-img-cmds.hx        |   7 ++
>   3 files changed, 285 insertions(+)
> 
> diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
> index 7d08c48d308f..219483cec279 100644
> --- a/docs/tools/qemu-img.rst
> +++ b/docs/tools/qemu-img.rst
> @@ -281,6 +281,30 @@ Command description:
>     For write tests, by default a buffer filled with zeros is written. This can be
>     overridden with a pattern byte specified by *PATTERN*.
> 
> +.. option:: bitmap (--merge SOURCE | --add | --remove | --clear | --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME BITMAP
> +
> +  Perform one or more modifications of the persistent bitmap *BITMAP*
> +  in the disk image *FILENAME*.  The various modifications are:
> +
> +  ``--add`` to create *BITMAP*, enabled to record future edits.
> +
> +  ``--remove`` to remove *BITMAP*.
> +
> +  ``--clear`` to clear *BITMAP*.
> +
> +  ``--enable`` to change *BITMAP* to start recording future edits.
> +
> +  ``--disable`` to change *BITMAP* to stop recording future edits.
> +
> +  ``--merge`` to merge the contents of *SOURCE_BITMAP* into *BITMAP*.
> +
> +  Additional options include ``-g`` which sets a non-default
> +  *GRANULARITY* for ``--add``, and ``-b`` and ``-F`` which select an
> +  alternative source file for all *SOURCE* bitmaps used by
> +  ``--merge``.
> +
> +  To see what bitmaps are present in an image, use ``qemu-img info``.
> +
>   .. option:: check [--object OBJECTDEF] [--image-opts] [-q] [-f FMT] [--output=OFMT] [-r [leaks | all]] [-T SRC_CACHE] [-U] FILENAME
> 
>     Perform a consistency check on the disk image *FILENAME*. The command can
> diff --git a/qemu-img.c b/qemu-img.c
> index b6e8af9202a5..8c99e68ba8aa 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -28,6 +28,7 @@
>   #include "qemu-common.h"
>   #include "qemu-version.h"
>   #include "qapi/error.h"
> +#include "qapi/qapi-commands-block-core.h"
>   #include "qapi/qapi-visit-block-core.h"
>   #include "qapi/qobject-output-visitor.h"
>   #include "qapi/qmp/qjson.h"
> @@ -71,6 +72,12 @@ enum {
>       OPTION_SHRINK = 266,
>       OPTION_SALVAGE = 267,
>       OPTION_TARGET_IS_ZERO = 268,
> +    OPTION_ADD = 269,
> +    OPTION_REMOVE = 270,
> +    OPTION_CLEAR = 271,
> +    OPTION_ENABLE = 272,
> +    OPTION_DISABLE = 273,
> +    OPTION_MERGE = 274,
>   };
> 
>   typedef enum OutputFormat {
> @@ -169,6 +176,14 @@ static void QEMU_NORETURN help(void)
>              "  '-n' skips the target volume creation (useful if the volume is created\n"
>              "       prior to running qemu-img)\n"
>              "\n"
> +           "Parameters to bitmap subcommand:\n"
> +           "  'bitmap' is the name of the bitmap to manipulate, through one or more\n"
> +           "       actions from '--add', '--remove', '--clear', '--enable', '--disable',\n"
> +           "       or '--merge source'\n"
> +           "  '-g granularity' sets the granularity for '--add' actions\n"
> +           "  '-b source' and '-F src_fmt' tell '--merge' actions to find the source\n"
> +           "       bitmaps from an alternative file\n"
> +           "\n"
>              "Parameters to check subcommand:\n"
>              "  '-r' tries to repair any inconsistencies that are found during the check.\n"
>              "       '-r leaks' repairs only cluster leaks, whereas '-r all' fixes all\n"
> @@ -4461,6 +4476,245 @@ out:
>       return 0;
>   }
> 
> +enum ImgBitmapAct {
> +    BITMAP_ADD,
> +    BITMAP_REMOVE,
> +    BITMAP_CLEAR,
> +    BITMAP_ENABLE,
> +    BITMAP_DISABLE,
> +    BITMAP_MERGE,
> +};
> +typedef struct ImgBitmapAction {
> +    enum ImgBitmapAct act;
> +    const char *src; /* only used for merge */
> +    QSIMPLEQ_ENTRY(ImgBitmapAction) next;
> +} ImgBitmapAction;
> +
> +static int img_bitmap(int argc, char **argv)
> +{
> +    Error *err = NULL;
> +    int c, ret = -1;
> +    QemuOpts *opts = NULL;
> +    const char *fmt = NULL, *src_fmt = NULL, *src_filename = NULL;
> +    const char *filename, *bitmap;
> +    BlockBackend *blk = NULL, *src = NULL;
> +    BlockDriverState *bs = NULL, *src_bs = NULL;
> +    bool image_opts = false;
> +    int64_t granularity = 0;
> +    bool add = false, merge = false;
> +    QSIMPLEQ_HEAD(, ImgBitmapAction) actions;
> +    ImgBitmapAction *act, *act_next;
> +    const char *op;
> +
> +    QSIMPLEQ_INIT(&actions);
> +
> +    for (;;) {
> +        static const struct option long_options[] = {
> +            {"help", no_argument, 0, 'h'},
> +            {"object", required_argument, 0, OPTION_OBJECT},
> +            {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
> +            {"add", no_argument, 0, OPTION_ADD},
> +            {"remove", no_argument, 0, OPTION_REMOVE},
> +            {"clear", no_argument, 0, OPTION_CLEAR},
> +            {"enable", no_argument, 0, OPTION_ENABLE},
> +            {"disable", no_argument, 0, OPTION_DISABLE},
> +            {"merge", required_argument, 0, OPTION_MERGE},
> +            {"granularity", required_argument, 0, 'g'},
> +            {"source-file", required_argument, 0, 'b'},
> +            {"source-format", required_argument, 0, 'F'},
> +            {0, 0, 0, 0}
> +        };
> +        c = getopt_long(argc, argv, ":b:f:F:g:h", long_options, NULL);
> +        if (c == -1) {
> +            break;
> +        }
> +
> +        switch (c) {
> +        case ':':
> +            missing_argument(argv[optind - 1]);
> +            break;
> +        case '?':
> +            unrecognized_option(argv[optind - 1]);
> +            break;
> +        case 'h':
> +            help();
> +            break;
> +        case 'b':
> +            src_filename = optarg;
> +            break;
> +        case 'f':
> +            fmt = optarg;
> +            break;
> +        case 'F':
> +            src_fmt = optarg;
> +            break;
> +        case 'g':
> +            granularity = cvtnum(optarg);
> +            if (granularity < 0) {
> +                error_report("Invalid granularity specified");
> +                return 1;
> +            }
> +            break;
> +        case OPTION_ADD:
> +            act = g_new0(ImgBitmapAction, 1);
> +            act->act = BITMAP_ADD;
> +            QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            add = true;
> +            break;
> +        case OPTION_REMOVE:
> +            act = g_new0(ImgBitmapAction, 1);
> +            act->act = BITMAP_REMOVE;
> +            QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            break;
> +        case OPTION_CLEAR:
> +            act = g_new0(ImgBitmapAction, 1);
> +            act->act = BITMAP_CLEAR;
> +            QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            break;
> +        case OPTION_ENABLE:
> +            act = g_new0(ImgBitmapAction, 1);
> +            act->act = BITMAP_ENABLE;
> +            QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            break;
> +        case OPTION_DISABLE:
> +            act = g_new0(ImgBitmapAction, 1);
> +            act->act = BITMAP_DISABLE;
> +            QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            break;
> +        case OPTION_MERGE:
> +            act = g_new0(ImgBitmapAction, 1);
> +            act->act = BITMAP_MERGE;
> +            act->src = optarg;
> +            QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            merge = true;
> +            break;
> +        case OPTION_OBJECT:
> +            opts = qemu_opts_parse_noisily(&qemu_object_opts, optarg, true);
> +            if (!opts) {
> +                goto out;
> +            }
> +            break;
> +        case OPTION_IMAGE_OPTS:
> +            image_opts = true;
> +            break;
> +        }
> +    }
> +
> +    if (qemu_opts_foreach(&qemu_object_opts,
> +                          user_creatable_add_opts_foreach,
> +                          qemu_img_object_print_help, &error_fatal)) {
> +        goto out;
> +    }
> +
> +    if (QSIMPLEQ_EMPTY(&actions)) {
> +        error_report("Need at least one of --add, --remove, --clear, "
> +                     "--enable, --disable, or --merge");
> +        goto out;
> +    }
> +
> +    if (granularity && !add) {
> +        error_report("granularity only supported with --add");
> +        goto out;
> +    }
> +    if (src_fmt && !src_filename) {
> +        error_report("-F only supported with -b");
> +        goto out;
> +    }
> +    if (src_filename && !merge) {
> +        error_report("Merge bitmap source file only supported with "
> +                     "--merge");
> +        goto out;
> +    }
> +
> +    if (optind != argc - 2) {
> +        error_report("Expecting filename and bitmap name");
> +        goto out;
> +    }
> +
> +    filename = argv[optind];
> +    bitmap = argv[optind + 1];
> +
> +    blk = img_open(image_opts, filename, fmt, BDRV_O_RDWR, false, false,
> +                   false);

fit in one line

> +    if (!blk) {
> +        goto out;
> +    }
> +    bs = blk_bs(blk);
> +    if (src_filename) {
> +        src = img_open(NULL, src_filename, src_fmt, 0, false, false,
> +                       false);

s/NULL/false/

also, fit in one line

> +        if (!src) {
> +            goto out;
> +        }
> +        src_bs = blk_bs(src);
> +    } else {
> +        src_bs = bs;
> +    }
> +
> +    QSIMPLEQ_FOREACH_SAFE(act, &actions, next, act_next) {
> +        switch (act->act) {
> +        case BITMAP_ADD:
> +            qmp_block_dirty_bitmap_add(bs->node_name, bitmap,
> +                                       !!granularity, granularity, true, true,
> +                                       false, false, &err);
> +            op = "add";
> +            break;
> +        case BITMAP_REMOVE:
> +            qmp_block_dirty_bitmap_remove(bs->node_name, bitmap, &err);
> +            op = "remove";
> +            break;
> +        case BITMAP_CLEAR:
> +            qmp_block_dirty_bitmap_clear(bs->node_name, bitmap, &err);
> +            op = "clear";
> +            break;
> +        case BITMAP_ENABLE:
> +            qmp_block_dirty_bitmap_enable(bs->node_name, bitmap, &err);
> +            op = "enable";
> +            break;
> +        case BITMAP_DISABLE:
> +            qmp_block_dirty_bitmap_disable(bs->node_name, bitmap, &err);
> +            op = "disable";
> +            break;
> +        case BITMAP_MERGE: {
> +            BlockDirtyBitmapMergeSource *merge_src;
> +            BlockDirtyBitmapMergeSourceList *list;
> +
> +            merge_src = g_new0(BlockDirtyBitmapMergeSource, 1);
> +            merge_src->type = QTYPE_QDICT;
> +            merge_src->u.external.node = g_strdup(src_bs->node_name);
> +            merge_src->u.external.name = g_strdup(act->src);
> +            list = g_new0(BlockDirtyBitmapMergeSourceList, 1);
> +            list->value = merge_src;
> +            qmp_block_dirty_bitmap_merge(bs->node_name, bitmap, list, &err);
> +            qapi_free_BlockDirtyBitmapMergeSourceList(list);
> +            op = "merge";
> +            break;
> +        }
> +        default:
> +            g_assert_not_reached();
> +        }
> +
> +        if (err) {
> +            error_reportf_err(err, "Operation %s on bitmap %s failed",

s/failed/failed: /

> +                              op, bitmap);
> +            ret = -1;

dead assignment: you never set ret after first initialization to -1.

> +            goto out;
> +        }
> +        g_free(act);
> +    }
> +
> +    ret = 0;
> +
> + out:
> +    blk_unref(src);
> +    blk_unref(blk);
> +    qemu_opts_del(opts);
> +    if (ret) {
> +        return 1;
> +    }
> +    return 0;

Hmm, as it's the only usage of ret, you may initialize it to 1 at function start, and here just "return ret;"

> +}
> +
>   #define C_BS      01
>   #define C_COUNT   02
>   #define C_IF      04
> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index e0886437b1f2..011688245668 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx
> @@ -20,6 +20,13 @@ DEF("bench", img_bench,
>   SRST
>   .. option:: bench [-c COUNT] [-d DEPTH] [-f FMT] [--flush-interval=FLUSH_INTERVAL] [-i AIO] [-n] [--no-drain] [-o OFFSET] [--pattern=PATTERN] [-q] [-s BUFFER_SIZE] [-S STEP_SIZE] [-t CACHE] [-w] [-U] FILENAME
>   ERST
> +
> +DEF("bitmap", img_bitmap,
> +    "bitmap (--merge SOURCE | --add | --remove | --clear | --enable | --disable)... [-b source_file [-F source_fmt]] [-g granularity] [--object objectdef] [--image-opts | -f fmt] filename bitmap")
> +SRST
> +.. option:: bitmap (--merge SOURCE | --add | --remove | --clear | --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME BITMAP

Not about this patch, but it's a pity that we have triple duplications (triplications ?) of such lines..

> +ERST
> +
>   DEF("check", img_check,
>       "check [--object objectdef] [--image-opts] [-q] [-f fmt] [--output=ofmt] [-r [leaks | all]] [-T src_cache] [-U] filename")
>   SRST
> 

With at least s/NULL/false/ and s/failed/failed: / (or with all my tiny suggestions):
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir

