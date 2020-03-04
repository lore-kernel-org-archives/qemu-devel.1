Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC354C3F2D8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 07:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F9F21775
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 07:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XX6KXy+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F9F21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Olp-0006OQ-Iu
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 02:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j9OkI-0005mI-LS
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 02:47:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j9OkG-0000kf-GV
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 02:47:10 -0500
Received: from mail-am6eur05on2119.outbound.protection.outlook.com
 ([40.107.22.119]:26094 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j9Ok8-0000RC-SC; Wed, 04 Mar 2020 02:47:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZebrvW61zyQzg80O5TueAdl0swN3JUZcMd70c6pj9NZ9OomDrrXhxAaHLThNb3JEzLH4MwozQ1eC1rcyRDPQDghGyMJOpSzQE9F7WvCF0yPlPISwL97QoCHEx0l/mZex4wElqgqRBeIWXkiaRW/7OMQ4gDpKyOAQwADssUBjvbtqSGRuH2hbPN/VU7JeQpFW7O6gdVqMYGMLhZGtaDiqoTNJCU+pDQREBRBLdlf+h/rfoAt6daYN5NmJaBt4LLSwYVqHdlURn0q2wKs0F1SF/0v0JJRvNY/geRfvdITCQxJ4kCmHfsjQ2NbMshDwAuiwc26QCiqcfHqJWAluI39weA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hxCVihzycqAqgpPnzn9Xi58pnA3IOXszU731B6+KJw=;
 b=SjGGHhCkdAbkL28qWRSLheIwo8rYlC74FRMvdFcn4egMoaacGE6DGYyt58T4MSihupt1E3uPiE1P8RJhms/XVQ265wNGTuMyIb+LWq1gfcjx6cN5xv9wnQmbpqisU+WV2pgB/St55+67pNB0qr9dzDCz03+05WSKIkGhUrKCNU3AsIrcaHKPICyRqKGLrQty5dRLvSeWeONYsdTbOO2SYU9Pwkem4ITGxtw3bMNDvTKT+k2IZM5Ud4L/fVXoYsJ5tqndR383qd4hcwd4F1S/Be+u3Oi2WBAg5lJkkpmj4slZiNf8Glpzfdj+jhGUBV2VooRKd2N8xcvucPSGxTqGoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hxCVihzycqAqgpPnzn9Xi58pnA3IOXszU731B6+KJw=;
 b=XX6KXy+HSuWcb7wlKPITChlL9qmBcoS4TWp75vdWCYE4hwEio8DhXSpK5Njht1fPoR+9m3KlA694fMiC7wRDuAM7RKk8OGLptZip6D7+U//ezG7ubSNto8iS3QIEeZMu0Hn4dYl4ECBRe/sY7ojMvMIBvuFIJ5S+y7SaYlgJ5Ok=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3669.eurprd08.prod.outlook.com (20.177.116.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Wed, 4 Mar 2020 07:46:58 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2793.013; Wed, 4 Mar 2020
 07:46:58 +0000
Subject: Re: [PATCH v4 3/5] qcow2: rework the cluster compression routine
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200303133425.24471-1-dplotnikov@virtuozzo.com>
 <20200303133425.24471-4-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200304104655441
Message-ID: <65cd66fc-a5a7-ae83-cdc4-f7a94a81d2cc@virtuozzo.com>
Date: Wed, 4 Mar 2020 10:46:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200303133425.24471-4-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0309.eurprd05.prod.outlook.com
 (2603:10a6:7:93::40) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0309.eurprd05.prod.outlook.com (2603:10a6:7:93::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Wed, 4 Mar 2020 07:46:57 +0000
X-Tagtoolbar-Keys: D20200304104655441
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee715fc5-ccce-4cf3-502e-08d7c0103789
X-MS-TrafficTypeDiagnostic: AM6PR08MB3669:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3669405B2FC666F4D30BD6CCC1E50@AM6PR08MB3669.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(396003)(39850400004)(366004)(136003)(189003)(199004)(66476007)(66946007)(66556008)(16526019)(8676002)(86362001)(5660300002)(8936002)(316002)(4326008)(16576012)(26005)(6486002)(956004)(2616005)(478600001)(52116002)(81166006)(31696002)(36756003)(31686004)(81156014)(186003)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3669;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b4gYShLMHWCse61ybz+116cnXvGrAIlOthgmvO1YV3eoe/HP4fO/1/KAqwCNqzuUvAbjrUBzUjB7KAh7vHRhjTV5auj5GP7SaD9t8T1XJrn9dMzGeq+5LDn87n07gthWKuPWE40eoMX6/2mkkHfNfVUI5axCMXkXvTVG4knwqdTSCbPmmyR6a6iD4go7z0SYczwYi9WZuQkW5WQuSD1LwpMEc1ABX16CMg7uCAo79XvelOuTSo6dkkNmTRB8NvIhTqc5PZ8n7tmIk2Lq9c3YjXsAZQbYQUrErJuTggk8N4NciO9GM+6T10kOkIIib+s65Qq6Tz78JGvk0SHXm8ahMoEw4+zwcNs0rVfiUg7wWeDvjXSDJsPcQwtrtuIaiMl7BNdbqNju+yxBvUO0l7kI+IFr+L1IrQnxg2vbpxZcWSEjnNHJSY6aJRLH7x2ebsCG
X-MS-Exchange-AntiSpam-MessageData: zwFFzNAzZarE9iYrsEFotjrVau9cW+lwVQZ2Tji4VhC1CdVTdUDkla0iRY1wHGebB7hLZlnPmvpkl8DKkpfINgnAWyoXFSjVksaTIBuH+V8izOYOwhMvd4bsnD2ME4+62PTOAaIUzDt+swHHUGwU1A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee715fc5-ccce-4cf3-502e-08d7c0103789
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 07:46:58.1649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHsY+ZwywU6DcIZCcYBxt/xLEwj3pxwuYX9l4cVgrtOdHqcGH6ldAqR44323UK8BgZgFtMxtdl7CoFMayi96igRE/b1nJwbcI5kHVM1ytgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3669
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.119
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

03.03.2020 16:34, Denis Plotnikov wrote:
> The patch enables processing the image compression type defined
> for the image and chooses an appropriate method for image clusters
> (de)compression.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>   block/qcow2-threads.c | 71 ++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 60 insertions(+), 11 deletions(-)
> 
> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
> index a68126f291..9bfcda6918 100644
> --- a/block/qcow2-threads.c
> +++ b/block/qcow2-threads.c
> @@ -74,7 +74,9 @@ typedef struct Qcow2CompressData {
>   } Qcow2CompressData;
>   
>   /*
> - * qcow2_compress()
> + * qcow2_zlib_compress()
> + *
> + * Compress @src_size bytes of data using zlib compression method
>    *
>    * @dest - destination buffer, @dest_size bytes
>    * @src - source buffer, @src_size bytes
> @@ -83,8 +85,8 @@ typedef struct Qcow2CompressData {
>    *          -ENOMEM destination buffer is not enough to store compressed data
>    *          -EIO    on any other error
>    */
> -static ssize_t qcow2_compress(void *dest, size_t dest_size,
> -                              const void *src, size_t src_size)
> +static ssize_t qcow2_zlib_compress(void *dest, size_t dest_size,
> +                                   const void *src, size_t src_size)
>   {
>       ssize_t ret;
>       z_stream strm;
> @@ -119,10 +121,10 @@ static ssize_t qcow2_compress(void *dest, size_t dest_size,
>   }
>   
>   /*
> - * qcow2_decompress()
> + * qcow2_zlib_decompress()
>    *
>    * Decompress some data (not more than @src_size bytes) to produce exactly
> - * @dest_size bytes.
> + * @dest_size bytes using zlib compression method
>    *
>    * @dest - destination buffer, @dest_size bytes
>    * @src - source buffer, @src_size bytes
> @@ -130,8 +132,8 @@ static ssize_t qcow2_compress(void *dest, size_t dest_size,
>    * Returns: 0 on success
>    *          -EIO on fail
>    */
> -static ssize_t qcow2_decompress(void *dest, size_t dest_size,
> -                                const void *src, size_t src_size)
> +static ssize_t qcow2_zlib_decompress(void *dest, size_t dest_size,
> +                                     const void *src, size_t src_size)
>   {
>       int ret;
>       z_stream strm;
> @@ -191,20 +193,67 @@ qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
>       return arg.ret;
>   }
>   
> +/*
> + * qcow2_co_compress()
> + *
> + * Compress @src_size bytes of data using the compression
> + * method defined by the image compression type
> + *
> + * @dest - destination buffer, @dest_size bytes
> + * @src - source buffer, @src_size bytes
> + *
> + * Returns: compressed size on success
> + *          a negative error code on failure
> + */
>   ssize_t coroutine_fn
>   qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
>                     const void *src, size_t src_size)
>   {
> -    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size,
> -                                qcow2_compress);
> +    BDRVQcow2State *s = bs->opaque;
> +    Qcow2CompressFunc fn;
> +
> +    switch (s->compression_type) {
> +    case QCOW2_COMPRESSION_TYPE_ZLIB:
> +        fn = qcow2_zlib_compress;
> +        break;
> +
> +    default:
> +        abort();
> +    }
> +
> +    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size, fn);
>   }
>   
> +/*
> + * qcow2_co_decompress()
> + *
> + * Decompress some data (not more than @src_size bytes) to produce exactly
> + * @dest_size bytes using the compression method defined by the image
> + * compression type
> + *
> + * @dest - destination buffer, @dest_size bytes
> + * @src - source buffer, @src_size bytes
> + *
> + * Returns: 0 on success
> + *          a negative error code on failure
> + */
>   ssize_t coroutine_fn
>   qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
>                       const void *src, size_t src_size)
>   {
> -    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size,
> -                                qcow2_decompress);
> +    BDRVQcow2State *s = bs->opaque;
> +    Qcow2CompressFunc fn;
> +
> +    switch (s->compression_type) {
> +    case QCOW2_COMPRESSION_TYPE_ZLIB:
> +        fn = qcow2_zlib_decompress;
> +        break;
> +
> +    default:
> +        return -ENOTSUP;

abort() here, like in _compress()

> +    }
> +
> +    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size, fn);
>   }
>   
>   
> 


-- 
Best regards,
Vladimir

