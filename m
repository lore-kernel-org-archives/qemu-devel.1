Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40CCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:16:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F08E206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="q8Hy3WVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F08E206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0PTN-0006R9-Pt
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 09:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0PST-0005tC-Ih; Tue, 28 Jul 2020 09:15:53 -0400
Received: from mail-eopbgr70115.outbound.protection.outlook.com
 ([40.107.7.115]:40196 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0PSP-0007YE-TA; Tue, 28 Jul 2020 09:15:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vhp0vVUvbQjNoVaM7zz1k4NtjcbDFBGJnyPN696hM9jHQBFygRQZNxqkUtWELebnczFjf0wlg+C8PvtCtgcobM5S9MrfFsPjgXCzyY8fVBdZtm1pQGPTcnBWrP0xAc0nVyoXIjHVGcb6pOf05lhSgJ6XLjhR+kSpLFaG3uawdAZSMW7zT1UTE7WUK/Vge3SqcLIKbP79dXbPvjoaNHh6sH0lSgL4Jp8MdhB+icWoGpPueMxI6DRareensO6+aZWRlylLuG1m0vx9SiELLLVBMSzfjDReJI0be5DxiOirBkYsdfsdsPubPH7SJdylOQ12d9iUlZdNONHwBrNn2YG8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqrxGBxQ5FMoz6m4SDjWmLIjSEGDxb0Q3ydaTI//izs=;
 b=YO+a4NdmoMZswVIc7AEALx6pdIIRdqfh1NnQCPxtDeZq+sUuRNnM+oFO6NQ3aBug8Fs7V+1NAegnRruy1hJa85+AGpT39BDJ+jUn/VspSHX4kEpXkxm0tpnOcsJyGMEwF+F37zYFNDTWV57LyKZizRWp6Mhy2vpfCdrVkkiwyzoePJFkjykoh5klVh4U7rtLm9X1I967tt6qrkA2+yZtK5JOdDQJibYLErkslIETEAoPfNUdjdTCwLMRu8912SoL3F6jgzEsrlLNuJtwS0fndayAeTeKEBBTAUhybLhs6dF3nqcuy3gqRbCGLCnSG4bvv9vFlPp4U18yS/k0wpTzPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqrxGBxQ5FMoz6m4SDjWmLIjSEGDxb0Q3ydaTI//izs=;
 b=q8Hy3WVbqE5lhe3EIqsJ1lMV1ibeOC9TBgBAo4BSey5h1g2ayIBNe7fvO7o3ttwxe3skR58m8ajDYjzEAkSETJqU3v1o8xdkfEui2pBLblteR1h3xXZuV7Yg2/G8PvelxscVKbagYN6z2hHagVdnSlgCO6rQ0UY4LXzbr+XoHnU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5080.eurprd08.prod.outlook.com (2603:10a6:20b:e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 13:15:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 13:15:46 +0000
Subject: Re: [PATCH v2 1/4] block: nbd: Fix convert qcow2 compressed to nbd
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20200727215846.395443-1-nsoffer@redhat.com>
 <20200727215846.395443-2-nsoffer@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <627189f3-7cc3-a316-9b06-7e39179f69a8@virtuozzo.com>
Date: Tue, 28 Jul 2020 16:15:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200727215846.395443-2-nsoffer@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0029.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.158) by
 AM0PR08CA0029.eurprd08.prod.outlook.com (2603:10a6:208:d2::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Tue, 28 Jul 2020 13:15:45 +0000
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f01be154-25dd-4f6b-8095-08d832f856d6
X-MS-TrafficTypeDiagnostic: AM6PR08MB5080:
X-Microsoft-Antispam-PRVS: <AM6PR08MB50805DB6367D88397000760EC1730@AM6PR08MB5080.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gNWZrAlHGBVIHm2OzjWaWtSE59O2omqDoU56+gsEXlcLvmp/wnMV9bp15R2VulG3kvH2AjxX4SVYLJKemVnJncD/c+UHesjMRMxhTc0qntg7ElDVmWoCap2EBwy4EqWJsAD6VDXJsddx3Spo5XHvbCVY0DZPu3mDBPI0vxNjqmesL0S5A5ebeQSTp55Qx4MV4Oi85OdZMrEAMu+tq9CBLe495c8dvjNE+NShelXMtLorN5HXuzD7qllXMZG+Kk/MdW2LPeOqHPG8aYeA2uRlBQrS7KUYJlZp4vjqWaeClMZ3FpgwFjoqhhSGgcn1USvSJpwiuwRUC7fZB6XD0/4cX8eU1F/tpV/etqrHn8q+YraMD3iSWCMat73Jy7tI2X49UiUyX1Etzq8FatXaObLKmr31x7FCaP+Y11qnPHPKPIIIQuAPasELbMxneot5Dd4QAm+qVI0c4vw99/uEwssoYe3p+JfyvD9yrvuNGkKtRD5qLxIdP+hyTGCC9SUuNjXR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39850400004)(31696002)(8936002)(83380400001)(66946007)(26005)(66556008)(66476007)(52116002)(2906002)(16526019)(966005)(186003)(8676002)(478600001)(54906003)(2616005)(316002)(36756003)(6486002)(16576012)(86362001)(5660300002)(31686004)(956004)(4326008)(43740500002)(33290500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Ym3P4v6Aq4YtTjb3eH0/6NFquFQSjfqvW5/n8oXqPqWR59AHK9TzeRrw9C0y/nUsP9tn3X4uAuTxLt0Nk/9tFSDUt+/X2FE5RzHjiYVZ39hdnBo0Jr95eDLEhXPQzM0VwGhzHBvOSxFgh+eLpFbfUFRGjmSXlFaoOSKhmD3T6rbI0NE0HrR6+nHH8mZVObXHQTIpZBBxRop0/SCTXC2xx2dTT1KMwwWfMgcaTXwU7EbCw2doedORQFXxKMEqtEmatQVZ04HwPwfJmYBNzfQVYKAb0Pus3TGSWJBBMVqZ2AYk5Gh1c99UMh4M3D9TzZJNxZQfzYDe+hUPEW4jAzpULxFNsSwOirIqohPIKwsJo/YoewbfE5DhY/6Z7PWq6GAwrxbUrtAKHkz4/pqg5dLQJsW3/YFZSPadujZUrWMp9aZU/0lnOvKy6ufIAZpFlB30YFrs4XMAARmGzwE9p1/hMimRXEvE3wOhCVnF9tqFnZNJQkqZ7HF+QzkHnqZOJsvD
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f01be154-25dd-4f6b-8095-08d832f856d6
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 13:15:46.4754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W41RtDTH/aEnSksWJCS6CXLmkw/nXWruJc1Xh+N7niWu4/ilAYPE9nxEDTyEO9hvZ44m7s7WA+p1dioN2ua8KGgxJ+wbLzriXwMPAUdb1SA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5080
Received-SPF: pass client-ip=40.107.7.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 09:15:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

28.07.2020 00:58, Nir Soffer wrote:
> When converting to qcow2 compressed format, the last step is a special
> zero length compressed write, ending in call to bdrv_co_truncate(). This
> call always fails for the nbd driver since it does not implement
> bdrv_co_truncate().
> 
> For block devices, which have the same limits, the call succeeds since
> file driver implements bdrv_co_truncate(). If the caller asked to
> truncate to the same or smaller size with exact=false, the truncate
> succeeds. Implement the same logic for nbd.
> 
> Example failing without this change:
> 
> In one shell starts qemu-nbd:
> 
> $ truncate -s 1g test.tar
> $ qemu-nbd --socket=/tmp/nbd.sock --persistent --format=raw --offset 1536 test.tar
> 
> In another shell convert an image to qcow2 compressed via NBD:
> 
> $ echo "disk data" > disk.raw
> $ truncate -s 1g disk.raw
> $ qemu-img convert -f raw -O qcow2 -c disk1.raw nbd+unix:///?socket=/tmp/nbd.sock; echo $?
> 1
> 
> qemu-img failed, but the conversion was successful:
> 
> $ qemu-img info nbd+unix:///?socket=/tmp/nbd.sock
> image: nbd+unix://?socket=/tmp/nbd.sock
> file format: qcow2
> virtual size: 1 GiB (1073741824 bytes)
> ...
> 
> $ qemu-img check nbd+unix:///?socket=/tmp/nbd.sock
> No errors were found on the image.
> 1/16384 = 0.01% allocated, 100.00% fragmented, 100.00% compressed clusters
> Image end offset: 393216
> 
> $ qemu-img compare disk.raw nbd+unix:///?socket=/tmp/nbd.sock
> Images are identical.
> 
> Fixes: https://bugzilla.redhat.com/1860627
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> ---
>   block/nbd.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index 65a4f56924..dcb0b03641 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -1966,6 +1966,33 @@ static void nbd_close(BlockDriverState *bs)
>       nbd_clear_bdrvstate(s);
>   }
>   
> +/*
> + * NBD cannot truncate, but if the caller asks to truncate to the same size, or
> + * to a smaller size with exact=false, there is no reason to fail the
> + * operation.
> + *
> + * Preallocation mode is ignored since it does not seems useful to fail when
> + * when never change anything.
> + */
> +static int coroutine_fn nbd_co_truncate(BlockDriverState *bs, int64_t offset,
> +                                        bool exact, PreallocMode prealloc,
> +                                        BdrvRequestFlags flags, Error **errp)
> +{
> +    BDRVNBDState *s = bs->opaque;
> +
> +    if (offset != s->info.size && exact) {
> +        error_setg(errp, "Cannot resize NBD nodes");
> +        return -ENOTSUP;
> +    }
> +
> +    if (offset > s->info.size) {
> +        error_setg(errp, "Cannot grow NBD nodes");
> +        return -EINVAL;
> +    }

I think that ENOTSUP actually is valid error code for both cases.. NBD protocol has experimental extension NBD_CMD_RESIZE, so one day we'll implement this. So, I think, it's not invalid, but just not supported yet. Still, not a big deal, so with ENOTSUP or EINVAL:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Also, may be better to manage it in generic layer:
If driver doesn't implement bdrv_co_truncate handler (or return ENOTSUP), and we are truncating to the same size, or to smaller size with exact=false, we just report success? Then we'll drop same code from file-posix.c

> +
> +    return 0;
> +}
> +
>   static int64_t nbd_getlength(BlockDriverState *bs)
>   {
>       BDRVNBDState *s = bs->opaque;
> @@ -2045,6 +2072,7 @@ static BlockDriver bdrv_nbd = {
>       .bdrv_co_flush_to_os        = nbd_co_flush,
>       .bdrv_co_pdiscard           = nbd_client_co_pdiscard,
>       .bdrv_refresh_limits        = nbd_refresh_limits,
> +    .bdrv_co_truncate           = nbd_co_truncate,
>       .bdrv_getlength             = nbd_getlength,
>       .bdrv_detach_aio_context    = nbd_client_detach_aio_context,
>       .bdrv_attach_aio_context    = nbd_client_attach_aio_context,
> @@ -2072,6 +2100,7 @@ static BlockDriver bdrv_nbd_tcp = {
>       .bdrv_co_flush_to_os        = nbd_co_flush,
>       .bdrv_co_pdiscard           = nbd_client_co_pdiscard,
>       .bdrv_refresh_limits        = nbd_refresh_limits,
> +    .bdrv_co_truncate           = nbd_co_truncate,
>       .bdrv_getlength             = nbd_getlength,
>       .bdrv_detach_aio_context    = nbd_client_detach_aio_context,
>       .bdrv_attach_aio_context    = nbd_client_attach_aio_context,
> @@ -2099,6 +2128,7 @@ static BlockDriver bdrv_nbd_unix = {
>       .bdrv_co_flush_to_os        = nbd_co_flush,
>       .bdrv_co_pdiscard           = nbd_client_co_pdiscard,
>       .bdrv_refresh_limits        = nbd_refresh_limits,
> +    .bdrv_co_truncate           = nbd_co_truncate,
>       .bdrv_getlength             = nbd_getlength,
>       .bdrv_detach_aio_context    = nbd_client_detach_aio_context,
>       .bdrv_attach_aio_context    = nbd_client_attach_aio_context,
> 


-- 
Best regards,
Vladimir

