Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29EDC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA642074F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZSVW8n03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA642074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02G1-0007Gq-RJ
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 08:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k02Ek-0005Xi-9H; Mon, 27 Jul 2020 08:28:10 -0400
Received: from mail-db8eur05on2108.outbound.protection.outlook.com
 ([40.107.20.108]:31840 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k02EZ-0006s1-EM; Mon, 27 Jul 2020 08:28:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRJD1UxlIIprjKeTNnUSQ86t+hTn5maEQP03d/FlXGleB8VlHKcKHvGnz0ewDVuhnLP2cKswedsZaLWJk8OxQu7ljS0UPa+vxvw4CnXUII77wHv7Ynx94SNOZtZFOY0+mXU/PpsrmM4A7uKWb5zC4RB/M6J9/pkI1wbEcXgj790JWSQObVoEkkdZ6MDypBTW7OUvZLh1FpXKxMzcy+AuZP/Famr+7eiGHlcj1d/k/Mnava1DtH0spVOx/tNE9Ov5j7HWWehDT9fc37pYTo0NfweBl5zo4VWvgfn/R2TVR/onj4V0fDv7KXv8Sdc6hVpGu0qUao7phcde7g+6iY70Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10Uxd11O44w9WRWnzAZTh13XBOllMu0RCkZnifuNU+A=;
 b=BTRDWONvJOrQ4pj72NW7+oYz6ORCTorw1gvrkk+Pn3i+dBII5sN3Yrd+bbRJwyGJHNKmlT+8i/Crw0AQ15nX40WM2vk1fLUDe+CU4UcakBwytEzLLrR7hfo6NWt6zwQK4qoxZ/n3CN+N+77HQihRBSfS82Ed2Nlt7IzfUzSOGlDukgueuon/W3M3AYIKspgoBN8fphMRJC18QL7SfZx55MUxeUiemdM41XtN5UH/2B/PZA0FEyYUkhN+hXlpBXb90t22FEEUaikIj36Gif6go7idBFFS4odS0FgjPjQHTVnPUqjLzIou2YwRoXLfofXRgEqSBcCjQHASIuvyoY5VZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10Uxd11O44w9WRWnzAZTh13XBOllMu0RCkZnifuNU+A=;
 b=ZSVW8n03XiX/ZNrFGvBVRIFquuaATzk/N4+A3Sh2UYVpQ/7AC//7/5N5Z98fGPgz5Wr/rafYUeyEpxBIBKZKgeg6a4CTIaLx3UR3q80HCsmruLXPe3MhqG/xC9MWKe2DSNdVb7h4wfW7vFDUW0TRtjLPuudengY2uO9qHXmpxaA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4952.eurprd08.prod.outlook.com (2603:10a6:20b:e1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Mon, 27 Jul
 2020 12:27:51 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 12:27:51 +0000
Subject: Re: [PATCH v7 41/47] block: Leave BDS.backing_file constant
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-42-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <17ef88da-15fc-57ae-801e-a5374e87743f@virtuozzo.com>
Date: Mon, 27 Jul 2020 15:27:47 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-42-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: FR2P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::23) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 FR2P281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.10 via Frontend Transport; Mon, 27 Jul 2020 12:27:49 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73dfc9d3-c36d-45c7-08bc-08d832287a86
X-MS-TrafficTypeDiagnostic: AM6PR08MB4952:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4952030A252A612CC52404A2F4720@AM6PR08MB4952.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 98/YTnXgwRN4hVutl4G8immqrr9xfSz0oL8Bqw4LoglD6ac2u25Na8Vxz9o8wIrprWfbIxj5rGH3S2Wpa7iXSKHKvk05wUO8kMptq0OKXxEplnBzCXjttruKeoc3vPizTTKS+PipG02zHSU2A4+dYKL8JB34C2dc8SnwO/oW+od0rV6QYv0Uui028IlWDCTDDJvm9k5u0WvCPYfEWtDHWkHTeMAMXLjTJQG4WF5ia+bhsCy1jOjGRQt48j9Q3KG3ZpzqE6N1LI5hSiRKRXia06j6JziyafWxJgnRvlr4N93xQXi3D4EivKVAq2pTzQMZX/aA3ZK+aXBDvYxHt0GdFG0MZ0Gp1EMjpp9bCnT2+qoH1v8x4Up4vZHI1s76d5lI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39840400004)(478600001)(86362001)(31696002)(4326008)(36756003)(26005)(83380400001)(31686004)(8676002)(5660300002)(52116002)(16526019)(6506007)(53546011)(44832011)(8936002)(2906002)(6486002)(316002)(186003)(6512007)(66476007)(66556008)(66946007)(956004)(54906003)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: TL83Zo/HUoTV6Di0qiBwjz/pO90qxjSpdyDSmkEiOkzS7WtgMTfC80buOk8g66AT8VEq/W7lapu1EQ/zdSApkFetaWM4eCx14pq7CczBoS7kuO+3HD8PnZ0ZshZnWmLczaIJ/2LuayyAk77t1dLIXGpGwv2npo5cIllo8WRyDWQCgqz/VnUCf0NDq7xQbekmulcoecOWprj/ngW/pFWGYkh9UeP/EHxvcnf4Yj+XuMs3cUvFJmPoplsYsTqqqHm/PGPRl7IehKczehp/uPtNmewOBQ3HzZ9kh76tpbNv1jJynlocoW6ckN3tc+676IRONTul3hT7gHZycPAWv3QTwZmHPqxO5spZzJezt6lx4VCnQOFUwRJJkOjzfAqdbMPKHp9UOm7qZpvWQksXDStxKaXF8FmNi5fvggOj9sR/k3geJDrXVcxcRwlCusCu2nEHVRFm4SADW/8IRxx/QWHPr328WZ0/Yg71/j3tb5SdYA0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73dfc9d3-c36d-45c7-08bc-08d832287a86
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 12:27:51.0449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wVehlVHETTM5lFTqCQEYiXFje8ToWMotuX099UUIqk5u2TMI7gbuUqJwgSbi3m2EwukwijoXvq4USONwcxuMgfg7/crt8kPhRHMgcXPbA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4952
Received-SPF: pass client-ip=40.107.20.108;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 08:27:51
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25.06.2020 18:22, Max Reitz wrote:
> Parts of the block layer treat BDS.backing_file as if it were whatever
> the image header says (i.e., if it is a relative path, it is relative to
> the overlay), other parts treat it like a cache for
> bs->backing->bs->filename (relative paths are relative to the CWD).
> Considering bs->backing->bs->filename exists, let us make it mean the
> former.
>
> Among other things, this now allows the user to specify a base when
> using qemu-img to commit an image file in a directory that is not the
> CWD (assuming, everything uses relative filenames).
>
> Before this patch:
>
> $ ./qemu-img create -f qcow2 foo/bot.qcow2 1M
> $ ./qemu-img create -f qcow2 -b bot.qcow2 foo/mid.qcow2
> $ ./qemu-img create -f qcow2 -b mid.qcow2 foo/top.qcow2
> $ ./qemu-img commit -b mid.qcow2 foo/top.qcow2
> qemu-img: Did not find 'mid.qcow2' in the backing chain of 'foo/top.qcow2'
> $ ./qemu-img commit -b foo/mid.qcow2 foo/top.qcow2
> qemu-img: Did not find 'foo/mid.qcow2' in the backing chain of 'foo/top.qcow2'
> $ ./qemu-img commit -b $PWD/foo/mid.qcow2 foo/top.qcow2
> qemu-img: Did not find '[...]/foo/mid.qcow2' in the backing chain of 'foo/top.qcow2'
>
> After this patch:
>
> $ ./qemu-img commit -b mid.qcow2 foo/top.qcow2
> Image committed.
> $ ./qemu-img commit -b foo/mid.qcow2 foo/top.qcow2
> qemu-img: Did not find 'foo/mid.qcow2' in the backing chain of 'foo/top.qcow2'
> $ ./qemu-img commit -b $PWD/foo/mid.qcow2 foo/top.qcow2
> Image committed.
>
> With this change, bdrv_find_backing_image() must look at whether the
> user has overridden a BDS's backing file.  If so, it can no longer use
> bs->backing_file, but must instead compare the given filename against
> the backing node's filename directly.
>
> Note that this changes the QAPI output for a node's backing_file.  We
> had very inconsistent output there (sometimes what the image header
> said, sometimes the actual filename of the backing image).  This
> inconsistent output was effectively useless, so we have to decide one
> way or the other.  Considering that bs->backing_file usually at runtime
> contained the path to the image relative to qemu's CWD (or absolute),
> this patch changes QAPI's backing_file to always report the
> bs->backing->bs->filename from now on.  If you want to receive the image
> header information, you have to refer to full-backing-filename.
>
> This necessitates a change to iotest 228.  The interesting information
> it really wanted is the image header, and it can get that now, but it
> has to use full-backing-filename instead of backing_file.  Because of
> this patch's changes to bs->backing_file's behavior, we also need some
> reference output changes.
>
> Along with the changes to bs->backing_file, stop updating
> BDS.backing_format in bdrv_backing_attach() as well.  In order not to
> change our externally visible behavior (incompatibly), we have to let
> bdrv_query_image_info() try to get the image format from bs->backing if
> bs->backing_format is unset.  (The QAPI schema describes
> backing-filename-format as "the format of the backing file", so it is
> not necessarily what the image header says, but just the format of the
> file referenced by backing-filename (if known).)
>
> iotest 245 changes in behavior: With the backing node no longer
> overriding the parent node's backing_file string, you can now omit the
> @backing option when reopening a node with neither a default nor a
> current backing file even if it used to have a backing node at some
> point.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   include/block/block_int.h  | 21 ++++++++++++++++-----
>   block.c                    | 35 +++++++++++++++++++++++++++--------
>   block/qapi.c               | 17 +++++++++++++----
>   tests/qemu-iotests/228     |  6 +++---
>   tests/qemu-iotests/228.out |  6 +++---
>   tests/qemu-iotests/245     |  4 +++-
>   6 files changed, 65 insertions(+), 24 deletions(-)
>
...
> diff --git a/block/qapi.c b/block/qapi.c
> index 2628323b63..5da6d7e6e0 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -47,7 +47,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
>                                           Error **errp)
>   {
>       ImageInfo **p_image_info;
> -    BlockDriverState *bs0;
> +    BlockDriverState *bs0, *backing;
>       BlockDeviceInfo *info;
>   
>       if (!bs->drv) {
> @@ -76,9 +76,10 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
>           info->node_name = g_strdup(bs->node_name);
>       }
>   
> -    if (bs->backing_file[0]) {
> +    backing = bdrv_cow_bs(bs);
> +    if (backing) {
>           info->has_backing_file = true;
> -        info->backing_file = g_strdup(bs->backing_file);
> +        info->backing_file = g_strdup(backing->filename);
>       }
>   
>       if (!QLIST_EMPTY(&bs->dirty_bitmaps)) {
> @@ -314,6 +315,8 @@ void bdrv_query_image_info(BlockDriverState *bs,
>       backing_filename = bs->backing_file;
>       if (backing_filename[0] != '\0') {
>           char *backing_filename2;
> +        const char *backing_format = NULL;
> +
>           info->backing_filename = g_strdup(backing_filename);
>           info->has_backing_filename = true;
>           backing_filename2 = bdrv_get_full_backing_filename(bs, NULL);
> @@ -326,7 +329,13 @@ void bdrv_query_image_info(BlockDriverState *bs,
>           }
>   
>           if (bs->backing_format[0]) {
> -            info->backing_filename_format = g_strdup(bs->backing_format);
> +            backing_format = bs->backing_format;
> +        } else if (bs->backing && bs->backing->bs->drv &&
> +                   !bdrv_backing_overridden(bs)) {
> +            backing_format = bs->backing->bs->drv->format_name;
> +        }


In case bdrv_backing_overridden() returns true , should we invoke 
bdrv_refresh_filename() and assign the format_name then?

Andrey


> +        if (backing_format) {
> +            info->backing_filename_format = g_strdup(backing_format);
>               info->has_backing_filename_format = true;
>           }
>           g_free(backing_filename2);

...


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>



