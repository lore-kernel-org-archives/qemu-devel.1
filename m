Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54524C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 11:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC97207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 11:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="V0BW6kCq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC97207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j40dR-0008MD-9w
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 06:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j40cZ-0007Tu-Hl
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 06:00:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j40cY-0003pZ-HC
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 06:00:55 -0500
Received: from mail-he1eur04on070a.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::70a]:35620
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j40cR-0003mL-5D; Tue, 18 Feb 2020 06:00:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7uqwuPP/fAc6abX+FgghXPlAmZhTCbMQEnX/jJOoYTSdXfzyMwtuHO7dktJHW7lT3E9AdtFwRlX0sr6KIKzAKCJcoCkWP9tbBN9zslOnfns3lw7IN3esASSg6hM6lmJiwbKqDOwT8vrwe2toq6kqD2l3fqB4al7Yk7cltJXlFu3CNwwRFdLJklnwbcDKI1fopVIHIXWUrvebSgru7myDIb3G1fctna6uR6xVWlwUOVkNUZKC3jX28w4ph7Ab88Lf/R2rlHHeMl8coLBYwxFTk4MVbozuj/a7MV3mBzX7xJiRG6RVO0R3H/hvnD/f023mTLdR16KjXfuQfPcBbKtnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTSwHmVCBwbgSgC8uqYaRRZcugzfdfg8jVA9MLWNG08=;
 b=FU+iRK3Z/oeu7IyHcb6HglN5P0W13oXzoi4O+FgS3gWtZ4g064slngK3HqZafhxHvFarIKYRI+afL4i6wKMZoCxfuMAwhXYw/WvXB3nN2jnWB61bzD2RfqbRxaVCmEBWYU97aEE7J8ULuBFft+Td/JMk4+5SXefyjFTJryi4zRT4V7TkdQ2YQihPldwNLLKDcD/iOirEXQH3zQsklVaE9wThLkWV6j1vMJIe20/BFKQ2E3qmJeUjX/s17S6yxEdT3lEj7U4JJLNgyTrjPAoBnlQhE31s+54SCLxJMKLoNwXLk5GkhLUH29CBRnCEcGz+uRFNsU3XXo75WqCl1m4yXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTSwHmVCBwbgSgC8uqYaRRZcugzfdfg8jVA9MLWNG08=;
 b=V0BW6kCq077+l6JPHe+Z+7UvZCgLZlQs/t4qK7N8URzzFCy3dM1788I5z9E7fLT2vNdOf0Qi4bW6d8WyjgVNd2HctA1Vv2VGtolWGXT4SrgdddCY4xRsqV6TIh6XZVJcslCI3cM2Hz/jDXoxkKBJAMrv3BVCU8TukPy3NyPkMGo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB3222.eurprd08.prod.outlook.com (52.135.162.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.27; Tue, 18 Feb 2020 11:00:43 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 11:00:43 +0000
Subject: Re: [PATCH v2 03/22] migration/block-dirty-bitmap: rename
 dirty_bitmap_mig_cleanup
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-4-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <bbdc4dc6-d220-1b97-50e9-31dcc3459bc1@virtuozzo.com>
Date: Tue, 18 Feb 2020 14:00:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200217150246.29180-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P190CA0020.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::30)
 To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1P190CA0020.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22 via Frontend Transport; Tue, 18 Feb 2020 11:00:42 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ea39290-1ff0-4def-e8c5-08d7b461cc5f
X-MS-TrafficTypeDiagnostic: AM6PR08MB3222:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3222D77392C7A77FD687A4AAF4110@AM6PR08MB3222.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(4326008)(5660300002)(956004)(478600001)(44832011)(2616005)(16576012)(36916002)(8676002)(316002)(54906003)(86362001)(26005)(52116002)(31686004)(36756003)(6486002)(53546011)(186003)(66556008)(66946007)(66476007)(16526019)(31696002)(2906002)(8936002)(81156014)(81166006)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3222;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d6V2TRW2uIodNkoB4/GLjCR/RKSmyGfs0//FF82SSN8ZhQqz8jHTR22NBwRAZqGzy7npzPX7gehE2KXLqmvzRvicFPMVaO4Q7MVauLIxznwEv9oaAJiqTWQK19PvhG2LU7CZEH3oCK9pPZIJH0pI3RIiVK2yujEjA0pBQUYvnLvhMxJ0m23UF2XZf7+Tn2YKlAus0MNncUZavp16RWI/OjRX6WfoAuNMCJTRYVmRaWSCUGuQRrdjtDmlRGYLFklkGdNcIkgpx3xRI0Am2MJUAj566lUHTs3JVcdk+rdjFbEGA9KXqZWu8F8+d0vP1TpnStMoCyuEQngkrVuFdiYiDGKEChhwneq7FFHKm1m0qTN77VpNxmzGMG+nVXowgQ9vmIRnxJcdjZYYEGwWr64ymTmHzJnT3b9auJdlxU65iFkLSMH6jTkmSIMkyPELQFtgecOCKyxhgkbGzJZgBosCqXHLZkpD74RKKSycbZ80Be6EoLmGYA+0PATBc0eKG+hc
X-MS-Exchange-AntiSpam-MessageData: woXHRVILDl0TkZfW502WgnGBmXmZh283ukST2cwHzHGsh0MywnIh2/qJMyMCC1BG56wDZ0YMYjgtDb1SRiONOmwr1g4yyvUX4B/4pVcDpEpfriVKwxaJVRAA57EkveYWID57PiauqRsKe9g2229x+g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea39290-1ff0-4def-e8c5-08d7b461cc5f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 11:00:43.1888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RZn8ZyqqDkjd3vtkJAb7ayZ5k8+Uw87V1ho2UKKFGkyQj+03SZk+J2vNRdo8x5DdldLiRMd5OFGG2+h4Nl1es9o3cVTDoRez2bs/XPdxTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3222
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0d::70a
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, quintela@redhat.com,
 dgilbert@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/02/2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
> Rename dirty_bitmap_mig_cleanup to dirty_bitmap_do_save_cleanup, to
> stress that it is on save part.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   migration/block-dirty-bitmap.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 73792ab005..4e8959ae52 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -259,7 +259,7 @@ static void send_bitmap_bits(QEMUFile *f, SaveBitmapState *dbms,
>   }
>   
>   /* Called with iothread lock taken.  */
> -static void dirty_bitmap_mig_cleanup(void)
> +static void dirty_bitmap_do_save_cleanup(void)
>   {
>       SaveBitmapState *dbms;
>   
> @@ -338,7 +338,7 @@ static int init_dirty_bitmap_migration(void)
>       return 0;
>   
>   fail:
> -    dirty_bitmap_mig_cleanup();
> +    dirty_bitmap_do_save_cleanup();
>   
>       return -1;
>   }
> @@ -377,7 +377,7 @@ static void bulk_phase(QEMUFile *f, bool limit)
>   /* for SaveVMHandlers */
>   static void dirty_bitmap_save_cleanup(void *opaque)
>   {
> -    dirty_bitmap_mig_cleanup();
> +    dirty_bitmap_do_save_cleanup();
>   }
>   
>   static int dirty_bitmap_save_iterate(QEMUFile *f, void *opaque)
> @@ -412,7 +412,7 @@ static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
>   
>       trace_dirty_bitmap_save_complete_finish();
>   
> -    dirty_bitmap_mig_cleanup();
> +    dirty_bitmap_do_save_cleanup();
>       return 0;
>   }
>   
> 

At the next opportunity, I would suggest the name like
"dirty_bitmap_do_clean_after_saving()"
and similar for dirty_bitmap_save_cleanup()
"dirty_bitmap_clean_after_saving()".

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
-- 
With the best regards,
Andrey Shinkevich

