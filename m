Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B673C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 13:09:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C7020674
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 13:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BGX5ddK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C7020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jafWY-0003kA-G1
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 09:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jafUe-0002iT-Rm; Mon, 18 May 2020 09:07:44 -0400
Received: from mail-vi1eur05on2090.outbound.protection.outlook.com
 ([40.107.21.90]:10049 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jafUb-0003nB-7e; Mon, 18 May 2020 09:07:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5gUKvPW9SXXYZQWhwTRoxLtM1GEkHTGx5988JrUFvOlqnvTEpkDefeZYnzDe3mNSzK2TOD17+14gJ2B/eik9Uy0ZDCjYT/cgJNMGY/Kw2LD4ahVOjoxpLNG7jAI87K9XWPKK7yUR+1DC+sfuNTgGh9ApViLysEC4pul1vEUv5axmCDY6fYz8xuJuKaiT2SSzcvI6C6+FCOZ2e7T/cqx76mKiiTtpqgWxO2wJtWDhjMFzAEm8VEan+V8YZ1+yBrOWDyAjYJ7XaVjCp2GAAcBCCjLbA96byHvhWUttCjRRt8XOtWyJxJdLq4Cx1BnY2BAf3KskIeI3Qfn8iSfhcDY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60qjOT/coi4qyAV9guGhN6j5bKGMgYtXp9ZW5XTLkZY=;
 b=XHKx5cznGsDR53ot/H7q7QaDawSOTXP8zJfk1hCDABVtOKCfD7VhXD6sAtUAVAgoF5wtuFj7q4FTpTOtvep6KHpgoWpj44lmMJVlmm670KG8WYVBtlqQbvSjLwvCg6SYHXvAjZzWawnLVxAiREgAl2GrL22oUc7+7PcOH92WiWqYVJOavxt8aYzTEQrxVvX7yZOgIwPodOPJz4GMfRq56IH9F1RvXQo8N4fRug+JfeSDyer3eulusjgd72ceIIbQC0DLbT0phpvr833i038sHc4lOYOZcVEyZFsvNjB1Dm9vPM/3N8w2BS2gce7THuawdZxGYpni9R/9+oqaHICk1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60qjOT/coi4qyAV9guGhN6j5bKGMgYtXp9ZW5XTLkZY=;
 b=BGX5ddK+2MC4k+fW2QfTtraBcXdtw0of8ZPzosehY4PT/HWYGvhDLFXDGJi84exOlxIx7O3DCxPUw3PCctITPm2lOOmfwpv8y6qfm9GavWwWWLBGfYbJUhdJ4qxqRgXb99K8DJ7l9hS27YX0xz67DP/39hagnH8ztsEblMKxhTw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB5535.eurprd08.prod.outlook.com (2603:10a6:803:13e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Mon, 18 May
 2020 13:07:36 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%7]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 13:07:36 +0000
Subject: Re: [PATCH v4 7/9] qcow2: Expose bitmaps' size during measure
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200513011648.166876-1-eblake@redhat.com>
 <20200513011648.166876-8-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <dcca62f0-3960-a9df-61d1-a6b9c2b1cf17@virtuozzo.com>
Date: Mon, 18 May 2020 16:07:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200513011648.166876-8-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0041.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::21) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.187) by
 AM0PR10CA0041.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Mon, 18 May 2020 13:07:35 +0000
X-Originating-IP: [185.215.60.187]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9febfbbd-9fc8-422f-0603-08d7fb2c6f75
X-MS-TrafficTypeDiagnostic: VI1PR08MB5535:
X-Microsoft-Antispam-PRVS: <VI1PR08MB5535983223E2DCD673769C6BC1B80@VI1PR08MB5535.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EEkW70LT5SUCFAM6pcHUkhRWvBL/isKAFaqRncl0Hnd4bQLm4vWL3Ze7XvkCH9PgSDG1ycNmg1TF/Gk+8I0wmaTH/O06JTc58rzm7Q7MsuTZ/bjf3rBdp0LD/iFBbCYjePy+3+SKGk9oMwPe9dDEa6aJ0z03+6gKtQgQgKia0zqbkQbTB2WpanMfVE3LOcl2YWVC+xcgmGtLwUDDF6KBaj6ILfhDwyiNWKoZSMiNJzxQU/55C51Uf1RsCSqGVswxvr1CAcAc5BQqTEr7a8RTT9injKqv08c/JB0kV/OKg+J1We74NsQlTG62TjqGeI13nCK1M4rO8BEt6LMn1WfiqKaKGyY4XcW1kqHf3Zc/Knz7qQNKk1E+iDBU86oE8+/Lso82Wu9wWIZCeBdvRE1n7sWxybhOaRVar6yOEWyIVv8keT+NX0dkRgAF/rWLNQOLBHuKMQnD1uPku8QWiCgBCkBzZZRpUcyjWK4HfzBDKB7VbqkHEHVeuhRCYB6klEHMqE4BfB8/Xlc+oqRibhIVxnoDupS3e5HMXZhFaOjdsA0tUAdGRcJqlWv37T4qSJytU28PZZDzJWZID1QBSkQ0r/4keZR87+1H+djIbCS6QtI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(366004)(136003)(376002)(346002)(396003)(5660300002)(966005)(86362001)(36756003)(66946007)(4326008)(16576012)(316002)(6486002)(31686004)(2906002)(30864003)(956004)(52116002)(2616005)(8676002)(478600001)(31696002)(186003)(16526019)(8936002)(66556008)(26005)(66476007)(2004002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: w6WCx7DiPhziRObyyu8RdesbjOmr6ycrXlJZfUzBYPrhiI7wZb4Ldk9R6+qz2FhWKU15b+rRVWDossf+THKwcSzri9oOREr/o8gb687ZnOgjJf2/chjN8hlwk6e4xOuB7v/8HXt50tpGlEPrApsedEjbAoGW2eCNd9FUoipWX6eVfcQhg3krJL7+Qo8jXg1xniso9GrNTP3X0pzBnFRgQoGwyn/u6coeCriEwfndzttt3KP1BC+E6GZ2Dxq1KhvzVOXBvazRJ+1wCOV48D6BlsY3WnmeaJtnGhGvSzBA2L2g8Di63rfB5HFUoukN+cvcG9A6aUxWHObHGEQ8m5PSo73axIR7SgAq2eixwsdOMl3MUxpfyvLUIE0XbRE3/eA060/3HMK+s7EjZI4Bpq3aiyUWwsVvpZ+GDhpkjmA5Aejm2JCWU5e1AKKSw4v2IPfRrD1zhomSqyWEnd5W+hHg7eAWpSrYG/l/2FTYjf2N3BYICeKxNjsMkKZvm55wdsou
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9febfbbd-9fc8-422f-0603-08d7fb2c6f75
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 13:07:36.5776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2tkYxbVvs/R9tEuG6G0/e7YJxH/s/ov/MK7j8ZaPxc8ihwPcHU7JngulmpURZLiqVHaNPyjye4IKH9asDJwhqRrRTLW/MTmH0z/TEufoHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5535
Received-SPF: pass client-ip=40.107.21.90;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 09:07:38
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.05.2020 04:16, Eric Blake wrote:
> It's useful to know how much space can be occupied by qcow2 persistent
> bitmaps, even though such metadata is unrelated to the guest-visible
> data.  Report this value as an additional QMP field, present when
> measuring an existing image and output format that both support
> bitmaps.  Update iotest 178 and 190 to updated output, as well as new
> coverage in 190 demonstrating non-zero values made possible with the
> recently-added qemu-img bitmap command.
> 
> On the command-line side, 'qemu-img measure' gains a new --bitmaps
> flag.  When present, the bitmap size is rolled into the two existing
> measures (or errors if either the source image or destination format
> lacks bitmaps); when absent, there is never an error (for
> back-compat), but the output will instead include a new line item for
> bitmaps (which you would have to manually add), with that line being
> omitted in the same cases where passing --bitmaps would error.
> 
> The behavior chosen here is symmetrical with the upcoming 'qemu-img
> convert --bitmaps' being added in the next patch: that is, either both
> commands will succeed (your qemu-img was new enough to do bitmap
> manipulations, AND you correctly measured and copied the bitmaps, even
> if that measurement was 0 because there was nothing to copy) or both
> fail (either your qemu-img is too old to understand --bitmaps, or it
> understands it but your choice of images do not support seamless
> transition of bitmaps because either source, destination, or both lack
> bitmap support).
> 
> The addition of a new field demonstrates why we should always
> zero-initialize qapi C structs; while the qcow2 driver still fully
> populates all fields, the raw and crypto drivers had to be tweaked to
> avoid uninitialized data.
> 
> See also: https://bugzilla.redhat.com/1779904
> 
> Reported-by: Nir Soffer <nsoffer@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   docs/tools/qemu-img.rst          | 10 +++++-
>   qapi/block-core.json             | 15 ++++++---
>   block/crypto.c                   |  2 +-
>   block/qcow2.c                    | 37 +++++++++++++++++++--
>   block/raw-format.c               |  2 +-
>   qemu-img.c                       | 25 ++++++++++++++
>   qemu-img-cmds.hx                 |  4 +--
>   tests/qemu-iotests/178.out.qcow2 | 16 +++++++++
>   tests/qemu-iotests/190           | 57 ++++++++++++++++++++++++++++++--
>   tests/qemu-iotests/190.out       | 35 +++++++++++++++++++-
>   10 files changed, 187 insertions(+), 16 deletions(-)
> 
> diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
> index 219483cec279..b6f87ec6d3c0 100644
> --- a/docs/tools/qemu-img.rst
> +++ b/docs/tools/qemu-img.rst
> @@ -593,7 +593,7 @@ Command description:
>     For more information, consult ``include/block/block.h`` in QEMU's
>     source code.
> 
> -.. option:: measure [--output=OFMT] [-O OUTPUT_FMT] [-o OPTIONS] [--size N | [--object OBJECTDEF] [--image-opts] [-f FMT] [-l SNAPSHOT_PARAM] FILENAME]
> +.. option:: measure [--output=OFMT] [-O OUTPUT_FMT] [-o OPTIONS] [--size N | [--object OBJECTDEF] [--image-opts] [-f FMT] [--bitmaps] [-l SNAPSHOT_PARAM] FILENAME]
> 
>     Calculate the file size required for a new image.  This information
>     can be used to size logical volumes or SAN LUNs appropriately for
> @@ -616,6 +616,7 @@ Command description:
> 
>       required size: 524288
>       fully allocated size: 1074069504
> +    bitmaps: 0
> 
>     The ``required size`` is the file size of the new image.  It may be smaller
>     than the virtual disk size if the image format supports compact representation.
> @@ -625,6 +626,13 @@ Command description:
>     occupy with the exception of internal snapshots, dirty bitmaps, vmstate data,
>     and other advanced image format features.
> 
> +  The ``bitmaps size`` is the additional size required if the

you called it "bitmaps" in example output above. Should it be consistent? Either "``bitmaps``" here, or "bitmaps size: 0" above?

> +  destination supports persistent bitmaps, in order to additionally
> +  copy bitmaps in addition to the guest-visible data.  If the
> +  ``--bitmaps`` option was in use, the bitmap size is folded into the
> +  required and fully-allocated size for convenience, rather than being
> +  a separate line item.
> +
>   .. option:: snapshot [--object OBJECTDEF] [--image-opts] [-U] [-q] [-l | -a SNAPSHOT | -c SNAPSHOT | -d SNAPSHOT] FILENAME
> 
>     List, apply, create or delete snapshots in image *FILENAME*.
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 943df1926a91..65280eb9847d 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -633,18 +633,23 @@
>   # efficiently so file size may be smaller than virtual disk size.
>   #
>   # The values are upper bounds that are guaranteed to fit the new image file.
> -# Subsequent modification, such as internal snapshot or bitmap creation, may
> -# require additional space and is not covered here.
> +# Subsequent modification, such as internal snapshot or further bitmap
> +# creation, may require additional space and is not covered here.
>   #
> -# @required: Size required for a new image file, in bytes.
> +# @required: Size required for a new image file, in bytes, when copying just
> +#            guest-visible contents.
>   #
>   # @fully-allocated: Image file size, in bytes, once data has been written
> -#                   to all sectors.
> +#                   to all sectors, when copying just guest-visible contents.

"copying just guest-visible" sounds like something less than "all fully-allocated sectors"..
But I don't have better suggestion.. Just, "not including bitmaps" sounds weird too.

> +#
> +# @bitmaps: Additional size required if all the top-level bitmap metadata in
> +#           the source image were to be copied to the destination, present
> +#           when the destination supports persistent bitmaps. (since 5.1)
>   #
>   # Since: 2.10
>   ##
>   { 'struct': 'BlockMeasureInfo',
> -  'data': {'required': 'int', 'fully-allocated': 'int'} }
> +  'data': {'required': 'int', 'fully-allocated': 'int', '*bitmaps': 'int'} }
> 
>   ##
>   # @query-block:
> diff --git a/block/crypto.c b/block/crypto.c
> index 6b21d6bf6c01..eadbcb248563 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -552,7 +552,7 @@ static BlockMeasureInfo *block_crypto_measure(QemuOpts *opts,
>        * Unallocated blocks are still encrypted so allocation status makes no
>        * difference to the file size.
>        */
> -    info = g_new(BlockMeasureInfo, 1);
> +    info = g_new0(BlockMeasureInfo, 1);
>       info->fully_allocated = luks_payload_size + size;
>       info->required = luks_payload_size + size;
>       return info;
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 1c8f3ab8ae68..be0950016365 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -4721,6 +4721,7 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
>       PreallocMode prealloc;
>       bool has_backing_file;
>       bool has_luks;
> +    uint64_t bitmaps_size = 0; /* size occupied by bitmaps in in_bs */
> 
>       /* Parse image creation options */
>       cluster_size = qcow2_opt_get_cluster_size_del(opts, &local_err);
> @@ -4796,13 +4797,38 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
> 
>       /* Account for input image */
>       if (in_bs) {
> +        BdrvDirtyBitmap *bm;
> +        size_t bitmap_dir_size = 0;
>           int64_t ssize = bdrv_getlength(in_bs);
> +
>           if (ssize < 0) {
>               error_setg_errno(&local_err, -ssize,
>                                "Unable to get image virtual_size");
>               goto err;
>           }
> 
> +        FOR_EACH_DIRTY_BITMAP(in_bs, bm) {
> +            if (bdrv_dirty_bitmap_get_persistence(bm)) {
> +                const char *name = bdrv_dirty_bitmap_name(bm);
> +                uint32_t granularity = bdrv_dirty_bitmap_granularity(bm);
> +                uint64_t bmbits = DIV_ROUND_UP(bdrv_dirty_bitmap_size(bm),
> +                                               granularity);
> +                uint64_t bmclusters = DIV_ROUND_UP(DIV_ROUND_UP(bmbits,
> +                                                                CHAR_BIT),
> +                                                   cluster_size);
> +
> +                /* Assume the entire bitmap is allocated */
> +                bitmaps_size += bmclusters * cluster_size;
> +                /* Also reserve space for the bitmap table entries */
> +                bitmaps_size += ROUND_UP(bmclusters * sizeof(uint64_t),
> +                                         cluster_size);
> +                /* And space for contribution to bitmap directory size */
> +                bitmap_dir_size += ROUND_UP(strlen(name) + 24,
> +                                            sizeof(uint64_t));

Could we instead reuse code from qcow2_co_can_store_new_dirty_bitmap(), which calls calc_dir_entry_size() for this thing?
Possibly, make a function qcow2_measure_bitmaps in block/qcow2-bitmaps.c with this FOR_EACH? All details about qcow2 bitmap structures sounds better in block/qcow2-bitmaps.c

> +            }
> +        }
> +        bitmaps_size += ROUND_UP(bitmap_dir_size, cluster_size);
> +
>           virtual_size = ROUND_UP(ssize, cluster_size);
> 
>           if (has_backing_file) {
> @@ -4849,16 +4875,21 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
>           required = virtual_size;
>       }
> 
> -    info = g_new(BlockMeasureInfo, 1);
> +    info = g_new0(BlockMeasureInfo, 1);
>       info->fully_allocated =
>           qcow2_calc_prealloc_size(virtual_size, cluster_size,
>                                    ctz32(refcount_bits)) + luks_payload_size;
> 
> -    /* Remove data clusters that are not required.  This overestimates the
> +    /*
> +     * Remove data clusters that are not required.  This overestimates the
>        * required size because metadata needed for the fully allocated file is
> -     * still counted.
> +     * still counted.  Show bitmaps only if both source and destination
> +     * would support them.
>        */
>       info->required = info->fully_allocated - virtual_size + required;
> +    info->has_bitmaps = version >= 3 && in_bs &&
> +        bdrv_supports_persistent_dirty_bitmap(in_bs);
> +    info->bitmaps = bitmaps_size;

AFAIK, in QAPI, if has_<something> field is false, than <something> must be zero. Maybe, it's only about nested structured fields, not about simple numbers, but I think it's better keep bitmaps 0 in case when has_bitmaps is false.

Also, it seems a bit better to check version earlier, and don't do all the calculations, if we are not going to use them.. But it's a rare backward-compatibility case, I don't care.

>       return info;
> 
>   err:
> diff --git a/block/raw-format.c b/block/raw-format.c
> index 9108e4369628..a134b1954ca2 100644
> --- a/block/raw-format.c
> +++ b/block/raw-format.c
> @@ -346,7 +346,7 @@ static BlockMeasureInfo *raw_measure(QemuOpts *opts, BlockDriverState *in_bs,
>                               BDRV_SECTOR_SIZE);
>       }
> 
> -    info = g_new(BlockMeasureInfo, 1);
> +    info = g_new0(BlockMeasureInfo, 1);
>       info->required = required;
> 
>       /* Unallocated sectors count towards the file size in raw images */
> diff --git a/qemu-img.c b/qemu-img.c
> index 8c99e68ba8aa..0a326993d7ac 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -78,6 +78,7 @@ enum {
>       OPTION_ENABLE = 272,
>       OPTION_DISABLE = 273,
>       OPTION_MERGE = 274,
> +    OPTION_BITMAPS = 275,
>   };
> 
>   typedef enum OutputFormat {
> @@ -5096,6 +5097,7 @@ static int img_measure(int argc, char **argv)
>           {"output", required_argument, 0, OPTION_OUTPUT},
>           {"size", required_argument, 0, OPTION_SIZE},
>           {"force-share", no_argument, 0, 'U'},
> +        {"bitmaps", no_argument, 0, OPTION_BITMAPS},
>           {0, 0, 0, 0}
>       };
>       OutputFormat output_format = OFORMAT_HUMAN;
> @@ -5112,6 +5114,7 @@ static int img_measure(int argc, char **argv)
>       QemuOpts *sn_opts = NULL;
>       QemuOptsList *create_opts = NULL;
>       bool image_opts = false;
> +    bool bitmaps = false;
>       uint64_t img_size = UINT64_MAX;
>       BlockMeasureInfo *info = NULL;
>       Error *local_err = NULL;
> @@ -5192,6 +5195,9 @@ static int img_measure(int argc, char **argv)
>               img_size = (uint64_t)sval;
>           }
>           break;
> +        case OPTION_BITMAPS:
> +            bitmaps = true;
> +            break;
>           }
>       }
> 
> @@ -5220,6 +5226,10 @@ static int img_measure(int argc, char **argv)
>           error_report("Either --size N or one filename must be specified.");
>           goto out;
>       }
> +    if (!filename && bitmaps) {
> +        error_report("--bitmaps is only supported with a filename.");
> +        goto out;
> +    }
> 
>       if (filename) {
>           in_blk = img_open(image_opts, filename, fmt, 0,
> @@ -5275,9 +5285,24 @@ static int img_measure(int argc, char **argv)
>           goto out;
>       }
> 
> +    if (bitmaps) {
> +        if (!info->has_bitmaps) {
> +            error_report("no bitmaps measured, either source or destination "
> +                         "format lacks bitmap support");
> +            goto out;
> +        } else {
> +            info->required += info->bitmaps;
> +            info->fully_allocated += info->bitmaps;
> +            info->has_bitmaps = false;

And here, I think better to zero info->bitmaps as well.

> +        }
> +    }
> +
>       if (output_format == OFORMAT_HUMAN) {
>           printf("required size: %" PRIu64 "\n", info->required);
>           printf("fully allocated size: %" PRIu64 "\n", info->fully_allocated);
> +        if (info->has_bitmaps) {
> +            printf("bitmaps size: %" PRIu64 "\n", info->bitmaps);
> +        }
>       } else {
>           dump_json_block_measure_info(info);
>       }

[..]

> --- a/tests/qemu-iotests/190
> +++ b/tests/qemu-iotests/190
> @@ -2,7 +2,7 @@
>   #
>   # qemu-img measure sub-command tests on huge qcow2 files
>   #
> -# Copyright (C) 2017 Red Hat, Inc.
> +# Copyright (C) 2017-2020 Red Hat, Inc.
>   #
>   # This program is free software; you can redistribute it and/or modify
>   # it under the terms of the GNU General Public License as published by
> @@ -42,7 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>   _supported_fmt qcow2
>   _supported_proto file
> 
> -echo "== Huge file =="
> +echo "== Huge file without bitmaps =="
>   echo
> 
>   _make_test_img -o 'cluster_size=2M' 2T
> @@ -51,6 +51,59 @@ $QEMU_IMG measure -O raw -f qcow2 "$TEST_IMG"
>   $QEMU_IMG measure -O qcow2 -o cluster_size=64k -f qcow2 "$TEST_IMG"
>   $QEMU_IMG measure -O qcow2 -o cluster_size=2M -f qcow2 "$TEST_IMG"
> 
> +echo
> +echo "== Huge file with bitmaps =="
> +echo
> +
> +$QEMU_IMG bitmap --add --granularity 512 -f qcow2 "$TEST_IMG" b1
> +$QEMU_IMG bitmap --add -g 2M -f qcow2 "$TEST_IMG" b2
> +
> +# No bitmap without a source
> +$QEMU_IMG measure --bitmaps -O qcow2 --size 10M

should this be ored to  'echo "unexpected success"' as following failures?


> +# No bitmap output, since raw does not support it
> +$QEMU_IMG measure -O raw -f qcow2 "$TEST_IMG" ||
> +    echo "unexpected failure"
> +$QEMU_IMG measure --bitmaps -O raw -f qcow2 "$TEST_IMG" &&
> +    echo "unexpected success"
> +# No bitmap output, since no bitmaps on raw source
> +$QEMU_IMG measure -O qcow2 -f raw "$TEST_IMG" ||
> +    echo "unexpected failure"
> +$QEMU_IMG measure --bitmaps -O qcow2 -f raw "$TEST_IMG" &&
> +    echo "unexpected success"
> +# No bitmap output, since v2 does not support it
> +$QEMU_IMG measure -O qcow2 -o compat=0.10 -f qcow2 "$TEST_IMG" ||
> +    echo "unexpected failure"
> +$QEMU_IMG measure --bitmaps -O qcow2 -o compat=0.10 -f qcow2 "$TEST_IMG" &&
> +    echo "unexpected success"
> +
> +# Compute expected output:
> +echo
> +val2T=$((2*1024*1024*1024*1024))
> +cluster=$((64*1024))
> +b1clusters=$(( (val2T/512/8 + cluster - 1) / cluster ))
> +b2clusters=$(( (val2T/2/1024/1024/8 + cluster - 1) / cluster ))

comment on the following calculations won't hurt, at least something like
  "bitmap clusters + bitmap tables + bitmaps directory"

> +echo expected bitmap $((b1clusters * cluster +
> +			(b1clusters * 8 + cluster - 1) / cluster * cluster +
> +			b2clusters * cluster +
> +			(b2clusters * 8 + cluster - 1) / cluster * cluster +
> +			cluster))
> +$QEMU_IMG measure -O qcow2 -o cluster_size=64k -f qcow2 "$TEST_IMG"
> +$QEMU_IMG measure --bitmaps -O qcow2 -o cluster_size=64k -f qcow2 "$TEST_IMG"
> +
> +# Compute expected output:
> +echo
> +cluster=$((2*1024*1024))
> +b1clusters=$(( (val2T/512/8 + cluster - 1) / cluster ))
> +b2clusters=$(( (val2T/2/1024/1024/8 + cluster - 1) / cluster ))
> +echo expected bitmap $((b1clusters * cluster +
> +			(b1clusters * 8 + cluster - 1) / cluster * cluster +
> +			b2clusters * cluster +
> +			(b2clusters * 8 + cluster - 1) / cluster * cluster +
> +			cluster))
> +$QEMU_IMG measure --output=json -O qcow2 -o cluster_size=2M -f qcow2 "$TEST_IMG"
> +$QEMU_IMG measure --output=json --bitmaps -O qcow2 -o cluster_size=2M \
> +     -f qcow2 "$TEST_IMG"
> +
>   # success, all done
>   echo "*** done"
>   rm -f $seq.full
> diff --git a/tests/qemu-iotests/190.out b/tests/qemu-iotests/190.out
> index d001942002db..5c35f9268068 100644
> --- a/tests/qemu-iotests/190.out
> +++ b/tests/qemu-iotests/190.out
> @@ -1,11 +1,44 @@
>   QA output created by 190
> -== Huge file ==
> +== Huge file without bitmaps ==
> 
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2199023255552
>   required size: 2199023255552
>   fully allocated size: 2199023255552
>   required size: 335806464
>   fully allocated size: 2199359062016
> +bitmaps size: 0
>   required size: 18874368
>   fully allocated size: 2199042129920
> +bitmaps size: 0
> +
> +== Huge file with bitmaps ==
> +
> +qemu-img: --bitmaps is only supported with a filename.
> +required size: 2199023255552> +fully allocated size: 2199023255552

  - same as for "without bitmaps" sections, good

> +qemu-img: no bitmaps measured, either source or destination format lacks bitmap support
> +required size: 7012352
> +fully allocated size: 17170432
> +qemu-img: no bitmaps measured, either source or destination format lacks bitmap support
> +required size: 335806464
> +fully allocated size: 2199359062016

matches "without bitmaps" section (hmm, v2 image needs same space? Ok)

> +qemu-img: no bitmaps measured, either source or destination format lacks bitmap support
> +
> +expected bitmap 537198592
> +required size: 335806464
> +fully allocated size: 2199359062016

matches "without bitmaps" section.

> +bitmaps size: 537198592

match expectations

> +required size: 873005056
> +fully allocated size: 2199896260608

matches "without bitmaps" section + expected

> +
> +expected bitmap 545259520
> +{
> +    "bitmaps": 545259520,

match expected

> +    "required": 18874368,
> +    "fully-allocated": 2199042129920

matches "without bitmaps" section.
> +}
> +{
> +    "required": 564133888,
> +    "fully-allocated": 2199587389440
> +}

matches "without bitmaps" section + expected

>   *** done
> 


-- 
Best regards,
Vladimir

