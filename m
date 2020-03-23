Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F2CC10F26
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 08:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ABDC20732
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 08:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bfEKX3fW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABDC20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGI1w-0000MV-DL
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 04:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGI10-0008Ak-7x
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGI0y-0000ZV-Rq
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:00:54 -0400
Received: from mail-eopbgr70128.outbound.protection.outlook.com
 ([40.107.7.128]:61436 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jGI0t-0000UV-MQ; Mon, 23 Mar 2020 04:00:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGF89c4sPWxNtLBQPN8WqZB4W83xdyjEmzk37t69Raa/a9hXhiO3olqG6dKijwEw/P2KdApuY0uejZAYeYUPBYMCG3+6KEpBBpCD8KOzKBCWc7zMSSE2pk9FU3DZmlBz9ZL7eif2aCLq3Zu0dDQVrhOHjWgT0YoO+jYgaFhoAEWgNfH7alRgJ42yeewPhHjFE4BMV/Cb5znVlvq8XiXM4/3+AJCgkDzm4/OE+kam3BGgeubp7t0FVAguPSaxbdkJ2s5eiXSyspaQJ5NQ4sZ8zKwHIHP7b5x2Z3tH3/17L3WjXgIsExl/V8L0IbrTtwS4ePkja5RPluFOSdzraFdIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0cwV4w2ZjK0mwyzw6rLFxgcX6yvo9Q1NMsAb85r7kU=;
 b=TMbjt1v6p6J0U9vq18BROVv7vwiW0eMVnbXfA3QA7baoSEd5icIyuNVlPt7YhjIgRssT6WFfgtcKXNvB0Mx461TPBOtSfg2e3xfdILCGIh8cxYYdZ2EP+py2nlYEUY6wSqn53motLQ6HJkBQvdvK9W2miBeWZO4SwPKE7FZUqnb7sFp1O+cISJRuMFrBCrHKWQlady2wrf/ElOLf3M90/V6yyv30N/M5hPqhHsPJ0Cbipq52MMLEP/tX0ESd3iKZplwNWURkKKBhmpTR95ZSTNVDn89VsOH+81ikCDpTAc/LSuZuK3f2OPkosoa8eRTSRd6J5ZAbGTK2AdZUCGrduw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0cwV4w2ZjK0mwyzw6rLFxgcX6yvo9Q1NMsAb85r7kU=;
 b=bfEKX3fW9Qds7gCnSO0KDB5Aj6VS4UlGEGh80Gs/ocMNgYv0Y/yby1i+h+u6ygHF1RRSeoI6t2SGfUKcJiGjgIpjAG1PJGO0wbfIvGOL0N5mvP8hlxqPllq+VhmMZp3vxRNhKV178prVzPvUQXnnTyYkvThsZzjRVbs4FdCkMyg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5432.eurprd08.prod.outlook.com (10.141.173.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Mon, 23 Mar 2020 08:00:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 08:00:44 +0000
Subject: Re: [PATCH v8 1/4] qcow2: introduce compression type feature
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200321143431.19629-1-dplotnikov@virtuozzo.com>
 <20200321143431.19629-2-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200323110042824
Message-ID: <401c0627-a7ad-3434-a861-69f4a5d58d21@virtuozzo.com>
Date: Mon, 23 Mar 2020 11:00:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200321143431.19629-2-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0101CA0079.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::47) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.183) by
 AM4PR0101CA0079.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend
 Transport; Mon, 23 Mar 2020 08:00:43 +0000
X-Tagtoolbar-Keys: D20200323110042824
X-Originating-IP: [185.215.60.183]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddf90850-b995-4ebe-3ef7-08d7cf004a00
X-MS-TrafficTypeDiagnostic: AM7PR08MB5432:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5432AAA0C47DA4B9FE0A3181C1F00@AM7PR08MB5432.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(366004)(346002)(39840400004)(396003)(136003)(199004)(16576012)(2616005)(316002)(31696002)(16526019)(2906002)(86362001)(956004)(186003)(4326008)(81166006)(81156014)(52116002)(478600001)(26005)(8936002)(31686004)(36756003)(8676002)(66946007)(6486002)(66476007)(66556008)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5432;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHstwSLW1Wy6sMpv7OTXBmZbMJ7hbZTo0tA6EZ2CR69Swa62t65lhy1t6JiTjh6RTF+8ksG3VjQGbgvfvqh24EAXx3djQUkGrfCBI9Xq9O8uGrdX+YU900BK0IoKoOZr3Vear6+3/mWyGdIF+MI50b2Nv4LvJzwDyfX3pFG/C1q1oSIzP4ja4y4NyipQCHeE9JSFKszHs4mTYW8Z2sxuh9KEyb0iTEb20WF9MBKLIZvqqS/MQ20wn+BmMeJmvVfLJB+aNPS8AqQl3k3VuL+fxMz5i3kGg9j4E/FuR/d9pxrofHYA5jaFoJYCTgA75NmErb6XlvpENUTXq2yuEDsYLDdC5bxXHi+mF+SDYe2UYTNRDelb0VsBM4FZuOOh7tL6TZiGZQ4AbB2e7LJqZAZpTf/+LjmCR6kxxZ8LXdrdNIwXW27dsA0iNYi3C7OQPBXI
X-MS-Exchange-AntiSpam-MessageData: BJDI9WGw5/K2NH3iyfd6btrbqDw+KEX45nLM9Yvik8if7jmcbObsk7s9P+arTY3owvR7bIgD2Fk8a0RmpIviK8n1UMhCsxQEJ9b9dM1RtvBIs1gbte+AVkH4Ry5W7zbN1r+Kl9XxPTOWqBrH0HmSGw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf90850-b995-4ebe-3ef7-08d7cf004a00
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 08:00:44.6157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iD4ViQjb4EvQEellGWTegFd14ErDsz3mwmLijYNPgkiKEHLYmHjN+TPOhXwdBssIqpMJ2Ekroihb6GY5j00yCTbwitG91vreaYmDuMLlu4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5432
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.128
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
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.03.2020 17:34, Denis Plotnikov wrote:
> The patch adds some preparation parts for incompatible compression type
> feature to qcow2 allowing the use different compression methods for
> image clusters (de)compressing.
> 
> It is implied that the compression type is set on the image creation and
> can be changed only later by image conversion, thus compression type
> defines the only compression algorithm used for the image, and thus,
> for all image clusters.
> 
> The goal of the feature is to add support of other compression methods
> to qcow2. For example, ZSTD which is more effective on compression than ZLIB.
> 
> The default compression is ZLIB. Images created with ZLIB compression type
> are backward compatible with older qemu versions.
> 
> Adding of the compression type breaks a number of tests because now the
> compression type is reported on image creation and there are some changes
> in the qcow2 header in size and offsets.
> 
> The tests are fixed in the following ways:
>      * filter out compression_type for many tests
>      * fix header size, feature table size and backing file offset
>        affected tests: 031, 036, 061, 080
>        header_size +=8: 1 byte compression type
>                         7 bytes padding
>        feature_table += 48: incompatible feature compression type
>        backing_file_offset += 56 (8 + 48 -> header_change + feature_table_change)
>      * add "compression type" for test output matching when it isn't filtered
>        affected tests: 049, 060, 061, 065, 144, 182, 242, 255
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

[...]

> @@ -4859,6 +4949,7 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
>               .data_file          = g_strdup(s->image_data_file),
>               .has_data_file_raw  = has_data_file(bs),
>               .data_file_raw      = data_file_is_raw(bs),
> +            .compression_type   = s->compression_type,
>           };
>       } else {
>           /* if this assertion fails, this probably means a new version was
> @@ -5248,6 +5339,22 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>                                    "images");
>                   return -EINVAL;
>               }
> +        } else if (!strcmp(desc->name, BLOCK_OPT_COMPRESSION_TYPE)) {
> +            int compression_type =
> +                qapi_enum_parse(&Qcow2CompressionType_lookup,
> +                                qemu_opt_get(opts, BLOCK_OPT_COMPRESSION_TYPE),
> +                                -1, errp);
> +
> +            if (compression_type == -EINVAL) {

You should compare to -1, as qapi_enum_parse returns given default on error.

> +                error_setg(errp, "Unknown compression type");

and errp is already set (ofcourse, if qemu_opt_get returned non NULL, but I hope it is guaranteed by if (!strcmp(desc->name, BLOCK_OPT_COMPRESSION_TYPE)) condition

> +                return -ENOTSUP;
> +            }
> +
> +            if (compression_type != s->compression_type) {
> +                error_setg(errp, "Changing the compression type "
> +                                 "is not supported");
> +                return -ENOTSUP;
> +            }
>           } else {
>               /* if this point is reached, this probably means a new option was
>                * added without having it covered here */
> @@ -5516,6 +5623,12 @@ static QemuOptsList qcow2_create_opts = {
>               .help = "Width of a reference count entry in bits",
>               .def_value_str = "16"
>           },
> +        {
> +            .name = BLOCK_OPT_COMPRESSION_TYPE,
> +            .type = QEMU_OPT_STRING,
> +            .help = "Compression method used for image cluster compression",
> +            .def_value_str = "zlib"
> +        },
>           { /* end of list */ }
>       }
>   };


[...]


-- 
Best regards,
Vladimir

