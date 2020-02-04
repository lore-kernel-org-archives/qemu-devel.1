Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3617AC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E396A20730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Rh7KFYGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E396A20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyzAD-0003y8-VY
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 09:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyz9Y-0003TQ-TU
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:26:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyz9X-0005gk-HQ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:26:12 -0500
Received: from mail-eopbgr70097.outbound.protection.outlook.com
 ([40.107.7.97]:52295 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iyz9T-000501-CD; Tue, 04 Feb 2020 09:26:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vm9mTmc8auSPEhyb4cY8hYlEll4JqBd81ItfLjiHY7aK8g1ykNKJVIg9Ds9hQPuVNfbZqtBGSAMeEdnLRzfBDjXNX8ggkK0MOI1gh+Yj1ld4EjXyRZJ8OhZQmj3xjoZwdVpsGagiQZjbApaiIFIIDups32JI49iY8WLYJlcGeaGHf9iMbQYMrv5FPaGfsN/Wj3NTVtrZITHA2Gf1cP4moq7AwwPQDTUWnYDJ78KiR0HTBS0STg6JL1eThIkWbYTqtnk4DOQiio2ZpHI3Gx+kgVN2sttDNPepax8alHonEd1cDxr4tL2AaJGxAtdGYSCsI/XjtmyKTFlUV9oMqFetsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GIz6FEdXFu1e1Uyhgry7DGis/DWsQFgnRwi+kZ7y+M=;
 b=eF39bxXSFduXxivjT13TASc8fdZGCoLtu0XN8LJ1HFfG6gw6jsdJMEc9BF68XD6G3jNAvXCoZ/JnKZMqnxmnxRiwv/K26q7JXJoFiU0PDwIihB8B0MHFGgIzF8H+O/Man6Ty8bOYsMLE4Aa7mhBxFGTh5rcRjM6icN1je2VXM6QIWuY/6qTQdu1RZSVnVhgdV1kqM3hxEzOTVyahz4UuoGw4WiVTrODuLLPyqdxEZ3Vp38o6sLBEr58MXhorCJk7W0d3SekJjGPb1KlOsoYLo0Nqk7Z8mcyMt9QWGUVzi3yH81A4hzQgHGyRh+SZI4n5CunoD+iX0p+CM8xVArjpyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GIz6FEdXFu1e1Uyhgry7DGis/DWsQFgnRwi+kZ7y+M=;
 b=Rh7KFYGqYylWE3BZjpKKl8oTU8GOmz7JlgQ10z+uJbZQNk09xeWKKyBn/XtbYRgMPE7YbVpuioPr/ZenDKccN3ob4NNl7Wbl3TwExe4ITj4KBkTTzjtoWxMDB0/7pQUJJ7bT9q7yInaDAsIOFz5XlupWV7FAA4nWjdNjcnI9rzM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4424.eurprd08.prod.outlook.com (20.179.18.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Tue, 4 Feb 2020 14:26:04 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 14:26:04 +0000
Subject: Re: [PATCH 02/17] qcow2: List autoclear bit names in header
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-3-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200204172601741
Message-ID: <8d1558ad-539e-259a-8dbd-b7aa77eb61e4@virtuozzo.com>
Date: Tue, 4 Feb 2020 17:26:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200131174436.2961874-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0235.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::11) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0235.eurprd05.prod.outlook.com (2603:10a6:3:fb::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Tue, 4 Feb 2020 14:26:03 +0000
X-Tagtoolbar-Keys: D20200204172601741
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9e1c046-0a88-4322-c0c6-08d7a97e2a92
X-MS-TrafficTypeDiagnostic: AM6PR08MB4424:
X-Microsoft-Antispam-PRVS: <AM6PR08MB44248B2616F7AE89A5D8434CC1030@AM6PR08MB4424.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(366004)(396003)(376002)(346002)(189003)(199004)(86362001)(36756003)(31696002)(52116002)(2616005)(5660300002)(956004)(316002)(4326008)(186003)(8936002)(26005)(66476007)(16576012)(478600001)(66556008)(81156014)(81166006)(66946007)(8676002)(16526019)(31686004)(2906002)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4424;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TDPnAjyWhtORH7X+7zpqOuGToVZKBVLAXrj96ILhD/dUKqhrjCUvQfnJ+GYs8ZT1/XIJCZZWiUGSW7f+EAnF3fWCmneuciPyWjKlE/7Q4rShrlTWcW9Z1Y7ok3s/YKPEkyg0XEbkDPNs/kf7Q481fDlVuPWVzqs4WpFjiyQVygNjBUiWiDGr7o1Bhmp9K4z/MM86ydhpTNYw02XP+NbuNVTEGiS8n+hcJb5OfXXL6kzliZdDa/a2JAknSeS+7D0WXXu/osR5vSERbWnwwCrGcnFMVOewQ5nkADz9p/VRtPVgWHh5zRf+iZB/aoSz+HZWCOLX7Pzw9jclJMqgRZcdvnn0dM0un7B6Tv8iJ+6RtD9H1a4nVsFAS6IkVih5NcmjDnuxBML3PnfB3cME36jz/a97z3pR2Uzh4baFPsRdqkK97dafXdjYGAb33bcOSR30
X-MS-Exchange-AntiSpam-MessageData: cwON2NQBoTqoAuENgZlPuMmggzi17ixwT/r4sKpOyCt/L34La1rPGO1u8ifdT+AAN7C/55y87/jCJkwUU2V1SHAtjg4DoXbKi/cmnaEUMJYgNep63O5cO31qFYg3HTY9b/aX0W8sYrlW6O20bXtiDg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e1c046-0a88-4322-c0c6-08d7a97e2a92
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 14:26:04.2538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gA9nBTt7whmm6R3MlqP9gRnTecfYUwbZ6WAadTjQnzkxTYUOEfLd1wqHONHzcha6dlZgfWdyVzt6xfJTfZdYhsi1b3eY5qnSHpka/hIkyR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4424
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.97
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
Cc: david.edmondson@oracle.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

31.01.2020 20:44, Eric Blake wrote:
> The feature table is supposed to advertise the name of all feature
> bits that we support; however, we forgot to update the table for
> autoclear bits.  While at it, move the table to read-only memory in
> code, and tweak the qcow2 spec to name the second autoclear bit.
> Update iotests that are affected by the longer header length.
> 
> Fixes: 88ddffae
> Fixes: 93c24936
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   block/qcow2.c              | 12 +++++++++++-
>   docs/interop/qcow2.txt     |  3 ++-
>   tests/qemu-iotests/031.out |  8 ++++----
>   tests/qemu-iotests/036.out |  4 ++--
>   tests/qemu-iotests/061.out | 14 +++++++-------
>   5 files changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 30fd3d13032a..d3e7709ac2b4 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2821,7 +2821,7 @@ int qcow2_update_header(BlockDriverState *bs)
> 
>       /* Feature table */
>       if (s->qcow_version >= 3) {
> -        Qcow2Feature features[] = {
> +        static const Qcow2Feature features[] = {
>               {
>                   .type = QCOW2_FEAT_TYPE_INCOMPATIBLE,
>                   .bit  = QCOW2_INCOMPAT_DIRTY_BITNR,
> @@ -2842,6 +2842,16 @@ int qcow2_update_header(BlockDriverState *bs)
>                   .bit  = QCOW2_COMPAT_LAZY_REFCOUNTS_BITNR,
>                   .name = "lazy refcounts",
>               },
> +            {
> +                .type = QCOW2_FEAT_TYPE_AUTOCLEAR,
> +                .bit  = QCOW2_AUTOCLEAR_BITMAPS_BITNR,
> +                .name = "consistent bitmaps",

Hmm, what do you mean by "consistent" ? Each bitmap has own in_use flag, and my be
"inconsistent" on its own.

I'd prefer to name it just "bitmaps", as extension is named "Bitmaps". With this change:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> +            },
> +            {
> +                .type = QCOW2_FEAT_TYPE_AUTOCLEAR,
> +                .bit  = QCOW2_AUTOCLEAR_DATA_FILE_RAW_BITNR,
> +                .name = "raw external data",
> +            },
>           };
> 
>           ret = header_ext_add(buf, QCOW2_EXT_MAGIC_FEATURE_TABLE,
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index af5711e53371..8510d74c8079 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -138,7 +138,8 @@ in the description of a field.
>                                   bit is unset, the bitmaps extension data must be
>                                   considered inconsistent.
> 
> -                    Bit 1:      If this bit is set, the external data file can
> +                    Bit 1:      Raw external data bit
> +                                If this bit is set, the external data file can
>                                   be read as a consistent standalone raw image
>                                   without looking at the qcow2 metadata.
> 
> diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out
> index d535e407bc30..46f97c5a4ea4 100644
> --- a/tests/qemu-iotests/031.out
> +++ b/tests/qemu-iotests/031.out
> @@ -117,7 +117,7 @@ header_length             104
> 
>   Header extension:
>   magic                     0x6803f857
> -length                    192
> +length                    288
>   data                      <binary>
> 
>   Header extension:
> @@ -150,7 +150,7 @@ header_length             104
> 
>   Header extension:
>   magic                     0x6803f857
> -length                    192
> +length                    288
>   data                      <binary>
> 
>   Header extension:
> @@ -164,7 +164,7 @@ No errors were found on the image.
> 
>   magic                     0x514649fb
>   version                   3
> -backing_file_offset       0x178
> +backing_file_offset       0x1d8
>   backing_file_size         0x17
>   cluster_bits              16
>   size                      67108864
> @@ -188,7 +188,7 @@ data                      'host_device'
> 
>   Header extension:
>   magic                     0x6803f857
> -length                    192
> +length                    288
>   data                      <binary>
> 
>   Header extension:
> diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
> index 0b52b934e115..23b699ce0622 100644
> --- a/tests/qemu-iotests/036.out
> +++ b/tests/qemu-iotests/036.out
> @@ -26,7 +26,7 @@ compatible_features       []
>   autoclear_features        [63]
>   Header extension:
>   magic                     0x6803f857
> -length                    192
> +length                    288
>   data                      <binary>
> 
> 
> @@ -38,7 +38,7 @@ compatible_features       []
>   autoclear_features        []
>   Header extension:
>   magic                     0x6803f857
> -length                    192
> +length                    288
>   data                      <binary>
> 
>   *** done
> diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
> index 8b3091a412bc..413cc4e0f4ab 100644
> --- a/tests/qemu-iotests/061.out
> +++ b/tests/qemu-iotests/061.out
> @@ -26,7 +26,7 @@ header_length             104
> 
>   Header extension:
>   magic                     0x6803f857
> -length                    192
> +length                    288
>   data                      <binary>
> 
>   magic                     0x514649fb
> @@ -84,7 +84,7 @@ header_length             104
> 
>   Header extension:
>   magic                     0x6803f857
> -length                    192
> +length                    288
>   data                      <binary>
> 
>   magic                     0x514649fb
> @@ -140,7 +140,7 @@ header_length             104
> 
>   Header extension:
>   magic                     0x6803f857
> -length                    192
> +length                    288
>   data                      <binary>
> 
>   ERROR cluster 5 refcount=0 reference=1
> @@ -195,7 +195,7 @@ header_length             104
> 
>   Header extension:
>   magic                     0x6803f857
> -length                    192
> +length                    288
>   data                      <binary>
> 
>   magic                     0x514649fb
> @@ -264,7 +264,7 @@ header_length             104
> 
>   Header extension:
>   magic                     0x6803f857
> -length                    192
> +length                    288
>   data                      <binary>
> 
>   read 65536/65536 bytes at offset 44040192
> @@ -298,7 +298,7 @@ header_length             104
> 
>   Header extension:
>   magic                     0x6803f857
> -length                    192
> +length                    288
>   data                      <binary>
> 
>   ERROR cluster 5 refcount=0 reference=1
> @@ -327,7 +327,7 @@ header_length             104
> 
>   Header extension:
>   magic                     0x6803f857
> -length                    192
> +length                    288
>   data                      <binary>
> 
>   read 131072/131072 bytes at offset 0
> 


-- 
Best regards,
Vladimir

