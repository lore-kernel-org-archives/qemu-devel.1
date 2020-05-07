Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29758C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:15:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB51920A8B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="F3BObZgG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB51920A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWeUe-0005ga-5m
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 07:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jWeTy-00051A-DF; Thu, 07 May 2020 07:14:26 -0400
Received: from mail-eopbgr30095.outbound.protection.outlook.com
 ([40.107.3.95]:64388 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jWeTr-0002if-CY; Thu, 07 May 2020 07:14:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7StkwRjiKUanPPl179wqrznBexTQD7FUZVv8NrH764RW5oLp2+Y62GCY4qqfMjDk4MuGk9y0Fpzjw+B5tzZWjeuB2L2hxDJOkiCT8dnck+U79Rls/8xi6BoTNtSXbf5z9AFGSgiZaev6cNobda6+8AzmRb+FeIuCZq5oG/HQ6IIvm4sanRCzbDAji0rSsI+RnsrrSkJmkxV1ew8Dlh/cyxAR32fAEYkjtTmIPNcbM9ZIfMqSR1PtuKeWvUTAsnNszVuaQrTmax6wS08tWZD3mwX146bbu8NhlJI5Ul7KaK2QJUgk9U8KgyoV4v1ht02a/+6FNDXPJdTV3YSwF4wHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/beLZMZAK8P0gxlQTwzitNrkzwh07NTqFNCx6chGncU=;
 b=XH3OT+fS0kJwdhWwHTMqlP/wJJMvI7ZrL47CX13jnF3lYj/TA70wI6FRvzQFwe8FQFgs39IdEKFY+BcmqQLKJoh+RDOVCB6QkCUWgWCbeNgSd/R9e/QywgG3y916KKC9LedNJMeBROg6CfqyQKtUCjd3e428qNHPdNjYOzOwxNpjRjpWhQU9iPgS8sAPLW8IPTijEdNfOt+FfI9Mt5+yfy9jnANSsjkkfJcVL5fYARrGyOIQYg02N5BB7v9D6D0FrN4xnmvqqV+/ruIoGS3UOEAdnh2C9zWKLjb+bLvpkYmhR0YZUFnvtCnPTSPXKWuA6DvV4Z38Tdo0gTSR5QeRpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/beLZMZAK8P0gxlQTwzitNrkzwh07NTqFNCx6chGncU=;
 b=F3BObZgG5FVoggo5rFNMHgXTL9dYySotapBrw25UInq1Ia8WZEeCHHv97Um9lpqwRxFv4SHwl1gH8Zu9lMxeAhltQCjmJBbjD/34Ng+JTE0PwH6pc6icR+pQEeEPV38+bIznCMR2crBRQjH70RfgYPqIvm7+i9nrvmbNgwgNakk=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB3367.eurprd08.prod.outlook.com (2603:10a6:20b:44::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Thu, 7 May
 2020 11:14:14 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::7582:191d:d70d:cba1]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::7582:191d:d70d:cba1%5]) with mapi id 15.20.2958.034; Thu, 7 May 2020
 11:14:14 +0000
Subject: Re: [PATCH 7/9] parallels: Rework truncation logic
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200428202905.770727-1-eblake@redhat.com>
 <20200428202905.770727-8-eblake@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <41b25659-7064-fe3e-22be-3a581c76f4d8@openvz.org>
Date: Thu, 7 May 2020 14:14:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200428202905.770727-8-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::15)
 To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.22] (31.148.204.195) by
 FRYP281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.27 via Frontend Transport; Thu, 7 May 2020 11:14:14 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7efe75b6-d2be-48b1-4188-08d7f277c6a8
X-MS-TrafficTypeDiagnostic: AM6PR08MB3367:
X-Microsoft-Antispam-PRVS: <AM6PR08MB336737D3A099EF564F95BD28B6A50@AM6PR08MB3367.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m4qiwYhwYZS5x7reTLjgrvOo9GEiBLAkLP5Hu6tcOFlANfBR2HNw3/PTPBZPfoOcmNAqKvwuNLZy9y4aK0AuzLn4Z9USO3udcyxRBFmKMc5eYiFqCwCVhNHiOHh9Z6Hqc7YhJxie2s7nch1Wny74zXzm3si67Iw4AJ+hBdpjqJuMvr1mJ4vt1FJul6EQBmy82setj0vQixYL7o5Bxj1jGagry1YCpz/1Zh2N2DfAKZZIFdDSZqiSdSdTc/yKabBt22l2yGtKYROBuwsYhg8czSueprNrmO3FTN9kSTb7Gs8TyCocPWj1O9E+tWsYsla1eTakZSN04+hZFzl9Iz+hvMw/iC4a/OX5hYRE1VRXJxu6JQ90p3zJ04p5sW/OTixBmBryRoEmhi1DzOJERYkAMRdtuLnKmkRru9ZH+t1zitsYMPO4Ol9hJQdJbhO9D5KlAYKoEnn4dMk3IFMX9UyrRT/51xxs/Ho11fPnMp+haBq7Ysh9q6NcWHcF9XKJoJ0frodttxVaoSHxjgYYI/MZLevqTn6AgcraOIuw1YciDdOmUeF3EFo+3GHUq/H7xTrO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39850400004)(366004)(33430700001)(52116002)(83170400001)(186003)(42882007)(31686004)(2616005)(2906002)(8676002)(5660300002)(53546011)(33440700001)(26005)(478600001)(316002)(66556008)(66476007)(66946007)(16576012)(54906003)(83320400001)(83280400001)(83310400001)(956004)(6486002)(31696002)(83290400001)(16526019)(36756003)(8936002)(4326008)(83300400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 3xq2SKewqHvbd57q1GYqr7AyA2P4JFG193kZLa5WLZ0anJ+USpR5F+dGB9F2++O7fjdh8HpXuo7lx6uZZ5zF6HVYXO1zj/5dGlhLz/jFI455U/VQFU1wnfHhMkZKC1AB0DkCBLoBTaI3EZgyDYQyVeeMKECYErVv6xnfZM0FSu7B4mHxpjBOh7Rkx5+7RVY6PSVL9Nw8/4Clsjkx8faxCVTrOr9yPpXOxb1zgZrkB+MCWiomyTR6G2yHNUyal/HnC22H37fiju5yDX/AzM7Wqu6NbGx7IOn2P6Ingdm0XME354d0wNueGsqstWNQfsQp3teFg0QHUcf6fLuDeDhDoTHNmQ236N7S//AiJqOCxsknj4ou8oajeuFBli2O1KDnUsxtlemqjrg2HMKXE8WqNeS1abZdg3sgjjy+CJKXlw74tUyfDuHXSfF5IVC5fMmLtkahy+tlDwRCKgt8RfTEBFBaIQcc8MbZz1GIW9zZOJzxLMGCsKh2jmcapulGfKH5EsCAqheHr7CZoNWT9F/+rQE8YpcEYKv8Dy/Av3k8kyz/PpKvCM6XlWUqisSvCcctNFeDQ5NwgpwsAlB4gUjqNaEC+wl1g0E0JlD3Wd9RAJaqnYAv+ZRYitjzgFLotR06atkzm4VvknfS5kjT7guGQxJhz7bB3kprDDeDwvYbnekjYzaE3zT6kuWhS9OFgNq3oTPkuZ8debjmsPNhUUJIATyOJndunmQrBuixysZZ3Hn5aWUVa3igA9kEGZGQdkxxlbHTArizbexOHHuJTdVKNKsAkiqrvzj7ta6zqPgf1tc=
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 7efe75b6-d2be-48b1-4188-08d7f277c6a8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 11:14:14.6458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZP56POU2Ks7RoHVbUyOfAcA9aavA+2lac4O9V/qluasOsxagF1lGwcAPimG3pJWCWK0NRsx5c2RiQEyBod5QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3367
Received-SPF: pass client-ip=40.107.3.95; envelope-from=den@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 07:14:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 11:29 PM, Eric Blake wrote:
> The parallels driver tries to use truncation for image growth, but can
> only do so when reads are guaranteed as zero.  Now that we have a way
> to request zero contents from truncation, we can defer the decision to
> actual allocation attempts rather than up front, reducing the number
> of places that still use bdrv_has_zero_init_truncate.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/parallels.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 2be92cf41708..9dadaa3217b9 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -196,14 +196,24 @@ static int64_t allocate_clusters(BlockDriverState *bs, int64_t sector_num,
>      }
>      if (s->data_end + space > (len >> BDRV_SECTOR_BITS)) {
>          space += s->prealloc_size;
> +        /*
> +         * We require the expanded size to read back as zero. If the
> +         * user permitted truncation, we try that; but if it fails, we
> +         * force the safer-but-slower fallocate.
> +         */
> +        if (s->prealloc_mode == PRL_PREALLOC_MODE_TRUNCATE) {
> +            ret = bdrv_truncate(bs->file,
> +                                (s->data_end + space) << BDRV_SECTOR_BITS,
> +                                false, PREALLOC_MODE_OFF, BDRV_REQ_ZERO_WRITE,
> +                                NULL);
> +            if (ret == -ENOTSUP) {
> +                s->prealloc_mode = PRL_PREALLOC_MODE_FALLOCATE;
> +            }
> +        }
>          if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE) {
>              ret = bdrv_pwrite_zeroes(bs->file,
>                                       s->data_end << BDRV_SECTOR_BITS,
>                                       space << BDRV_SECTOR_BITS, 0);
> -        } else {
> -            ret = bdrv_truncate(bs->file,
> -                                (s->data_end + space) << BDRV_SECTOR_BITS,
> -                                false, PREALLOC_MODE_OFF, 0, NULL);
>          }
>          if (ret < 0) {
>              return ret;
> @@ -828,6 +838,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>          qemu_opt_get_size_del(opts, PARALLELS_OPT_PREALLOC_SIZE, 0);
>      s->prealloc_size = MAX(s->tracks, s->prealloc_size >> BDRV_SECTOR_BITS);
>      buf = qemu_opt_get_del(opts, PARALLELS_OPT_PREALLOC_MODE);
> +    /* prealloc_mode can be downgraded later during allocate_clusters */
>      s->prealloc_mode = qapi_enum_parse(&prealloc_mode_lookup, buf,
>                                         PRL_PREALLOC_MODE_FALLOCATE,
>                                         &local_err);
> @@ -836,10 +847,6 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>          goto fail_options;
>      }
>
> -    if (!bdrv_has_zero_init_truncate(bs->file->bs)) {
> -        s->prealloc_mode = PRL_PREALLOC_MODE_FALLOCATE;
> -    }
> -
>      if ((flags & BDRV_O_RDWR) && !(flags & BDRV_O_INACTIVE)) {
>          s->header->inuse = cpu_to_le32(HEADER_INUSE_MAGIC);
>          ret = parallels_update_header(bs);
Reviewed-by: Denis V. Lunev <den@openvz.org>

