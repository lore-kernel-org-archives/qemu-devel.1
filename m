Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62411C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 07:28:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2831220678
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 07:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VX9uPYZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2831220678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLif4-0006fV-6T
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 03:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLieP-00067q-2W
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 03:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLieO-0000Gi-4u
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 03:28:01 -0400
Received: from mail-eopbgr140123.outbound.protection.outlook.com
 ([40.107.14.123]:58366 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jLieL-000067-Nm; Tue, 07 Apr 2020 03:27:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egRRdyipAbRCDfYGopsWSVCbU1utUADehKLnblZhYx4wU0byraRxVBJkXrVZjaZ3wg0PhruJ1/Bse43o2N4WrMhc6cIvmY2ayD7az9zdzjRmTFCsWcQVoH3st5KLwpGwW3dH3smmhjNncu1YUGJJXPupYE5me+5qiq6nAN12brj+t9RkjD7SgSxbJhI3jzIUKbsDK5dxPq51W5l0e7XoGWXk/mUrN6KzSAuhjG1oPYGJFM21rXilGA3rSozBUoh/T/f3AWZNlq9PFGSU/HgwWNEtl45IcL3QqdKjVvmFT+hGppWEl8xb42d8ZMZkOUPvcAaYwlqHHud8LXPCvzBGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ehWGCYkjp1btbfrjg6PQw0CchtkNpW/PA9mI7rXKPk=;
 b=nwkAbwzUKihLxXATyrKrhhucVr/hoAG+EbHRH7e0sM3NtDtoqVjIAlHP9l+QPphEvEXAjbjhkiB4BHltB8cXcTgn9EVrJMRYSSSS7rJYq3V8XHVg/51voKxQ+hHKS5VQZdCpnVzWmPNHcysoAhJ/u7ZaiUrNkk2cX01DHnFnFLsqYvxNcnY6mpbzL+pMb5gRWZ8R3h7NQ1WTWIWOLfVOjkyqQPkSFPU43HWo+Otrg4iD53a4GzRHecNpDJuNE+RAdlN54ys1jdea0fXOK6FeWQwwvMAcyi48wYdb7yHYOSrb1QF3XpShTsaTYqNRj/+vnNlwXU2j2iHDzZz+DYrJQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ehWGCYkjp1btbfrjg6PQw0CchtkNpW/PA9mI7rXKPk=;
 b=VX9uPYZGy7H6uXweH0hFOZ4dz+tVTxWYR3jcyLdpiQ7dopV0KfJovrHRVOBFj3ESxeztHIj1TY5902B5NQ1B7TKU5HAtda6FLF0dlPdMiJjhdJXV9ksEAaoWP/bCgJZsjEP1tsvqcdvH2oSrxV2zIHGLLrJZAj+4cXZcRiFKxeM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5381.eurprd08.prod.outlook.com (10.141.172.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.20; Tue, 7 Apr 2020 07:27:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Tue, 7 Apr 2020
 07:27:53 +0000
Subject: Re: [PATCH v2] qcow2: Check request size in
 qcow2_co_pwritev_compressed_part()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200406143401.26854-1-berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200407102749882
Message-ID: <90ae7712-7624-2367-a035-f155d3e7e4f3@virtuozzo.com>
Date: Tue, 7 Apr 2020 10:27:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200406143401.26854-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0701CA0004.eurprd07.prod.outlook.com
 (2603:10a6:203:51::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.160) by
 AM5PR0701CA0004.eurprd07.prod.outlook.com (2603:10a6:203:51::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.11 via Frontend
 Transport; Tue, 7 Apr 2020 07:27:52 +0000
X-Tagtoolbar-Keys: D20200407102749882
X-Originating-IP: [185.215.60.160]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2d28e54-e5bd-4457-29aa-08d7dac52f04
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5381D16AECA04BCC4BDD4E7CC1C30@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:350;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39830400003)(346002)(396003)(366004)(136003)(376002)(4326008)(8936002)(8676002)(186003)(81166006)(26005)(478600001)(31696002)(16526019)(86362001)(36756003)(5660300002)(107886003)(52116002)(81156014)(31686004)(66556008)(54906003)(2906002)(6666004)(2616005)(316002)(16576012)(956004)(66476007)(6486002)(66946007);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9424HWYnSisdTu9Yx4MHsBFozwzEleY6Ltm2AbSqzLNg7F90DcJuEiue89eFG7/tYQwJ3QLLvchUyC6pPwyFfNvq7ZVNFa3ksLHxGkisJfGwr7VHJapd0vi0lt+Xa4dS6m9ClfqMtnk5jn63iyYEDFjQYAybvVfWFrV8Tq3JLF9iDSu6bHEyGrqR4S7n1u6qs3hwgt6OTgzM3cnOsFelMaYugPPVwchBbO5YrLDXw+WH0zXa7sy0nOEPE46Q+0uClqFdIljHh4Qhnl0ZTBek4y77m9xW0glkIJTXwxt/3rWxCdWemQZyjyNbv6jh9NIXxZptY9bbFW3bEnkiDmhxrY7hrsr+ZMzh/zz1fYdzCzBiWXGsNsFn4Ri4BFTXg9DPfC6KELCxXkcNPZ9h7OoWErI/OgMlXG8cPBK7LoUs2Ui7mms8WTCzKGVLBWYuvetx
X-MS-Exchange-AntiSpam-MessageData: AxwCioqIDycthnDQVtQ7D7KqxbF8scDWHcB+JH5DQjNQaj0UTcl00kWvsBkh5LZ1s9vWFpze7mg4VylXpNGLjf1ovHJv10IRhddB8pP21KYl5f3mleYCryguMyTJOCd5+L9YFDAUHtDjVj7n5iX1qQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d28e54-e5bd-4457-29aa-08d7dac52f04
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 07:27:53.0111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EekEmDuLka71CH1kJLWujvg8XgwQayg6NA5Ob3L3j+HUCxH6cgX3f9Q1wvauQHyofauiLVNDYeUbww056MQVgQ/aCwn+NUZcunSx1tG7Mz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.14.123
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
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

06.04.2020 17:34, Alberto Garcia wrote:
> When issuing a compressed write request the number of bytes must be a
> multiple of the cluster size or reach the end of the last cluster.
> 
> With the current code such requests are allowed and we hit an
> assertion:
> 
>     $ qemu-img create -f qcow2 img.qcow2 1M
>     $ qemu-io -c 'write -c 0 32k' img.qcow2
> 
>     qemu-io: block/qcow2.c:4257: qcow2_co_pwritev_compressed_task:
>     Assertion `bytes == s->cluster_size || (bytes < s->cluster_size &&
>                (offset + bytes == bs->total_sectors << BDRV_SECTOR_BITS))' failed.
>     Aborted
> 
> This patch fixes a regression introduced in 0d483dce38
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---
>   block/qcow2.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 2bb536b014..587cf51948 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -4349,6 +4349,11 @@ qcow2_co_pwritev_compressed_part(BlockDriverState *bs,
>           return -EINVAL;
>       }
>   
> +    if (offset_into_cluster(s, bytes) &&
> +        (offset + bytes) != (bs->total_sectors << BDRV_SECTOR_BITS)) {
> +        return -EINVAL;
> +    }
> +
>       while (bytes && aio_task_pool_status(aio) == 0) {
>           uint64_t chunk_size = MIN(bytes, s->cluster_size);
>   
> 


-- 
Best regards,
Vladimir

