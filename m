Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732D5C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4512087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dN3V5PTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4512087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyzqR-0006od-Cc
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 10:10:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyzp6-0005bc-Q0
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyzp5-0008KF-QQ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:09:08 -0500
Received: from mail-eopbgr60090.outbound.protection.outlook.com
 ([40.107.6.90]:10116 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iyzp3-00083L-FK; Tue, 04 Feb 2020 10:09:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAjtpKcDnUehRsuYtqAV0/KqBZ3p9DoZqnxc8ygdJMio97gV9D62prvuCjGWy8z66m92Y1tZQL+S77wBq1bZuoipkAL+/04yaeOnfqBktmwyV4MWbeUStDsvf187pvp4Zl6CrkZeBJNjh5R5g+PQJM/q3VmWPrkraHlzBjaVJMMW3QGeHE+4gTz6648ITA/2/VlkzbOMQ8MbPcXFaZgL5/mvRGUn8Me8ZXIi42+wQ7JnjOXIHvmz5CmyL6hmb3dhWyygnfITc1XDoakESmEwVZtbucooACUy97zkv4B3piE5OgPfpKBd5lfS45qzAeIn6mt5gpiwAoc4J9qaxpBa3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoZFcUbBqvFRh86t5czt+WO7lNuaTjYGP/5niqD66KE=;
 b=KwDDQnsOCX0tDnf14PGsJ7ykNsbjwmiylWhKWiUEgXhmQ9HeqTTB/PnOdOwPqoDneyrKFOhVGY3urOcTiWtzYluNHqo8/bNZ4Ms45ez9ZJUd9XVFQHKt/5j1P4ne8T2JVpX6LN51CcnC0jLM5lWvX3JQm+nDW/6Jwu4UU1PcUYjp72y15QvN4Y6i7bz5x7OvCqAh1wpB7RrXZBIk83zLYBi0Q2ss2EHmDUfAX5dwGeTzfGYgRLjQEdwzTdrGdZANAON9/ZjuOiYtmzidze/XMyQYBAUUq0ckkxqDAwCJTrXLOCvTzxe1+IjvVsMTjnv3fVy/lXtdUx8EvTgOt20QLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoZFcUbBqvFRh86t5czt+WO7lNuaTjYGP/5niqD66KE=;
 b=dN3V5PTplZkN8SFvEYEgj7gBKhg7C5f7Z6ez4ZgaMF8zDSP4HBuVt+dh5EHILFb0U1KDHrzKIvMWv3JxnGUEkMkicClqAEH6selLsTqzWoik4ofUPPodFjvSMt5M2vrNfAijgpqN/QmjW+tTJaT6PghtTvWRg2bQwT0MA8Oby2Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB2981.eurprd08.prod.outlook.com (52.135.163.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Tue, 4 Feb 2020 15:09:03 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 15:09:03 +0000
Subject: Re: [PATCH 08/17] sheepdog: Consistently set
 bdrv_has_zero_init_truncate
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-9-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200204180900487
Message-ID: <702fa276-df56-facc-8529-2fd91d0ff4fd@virtuozzo.com>
Date: Tue, 4 Feb 2020 18:09:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200131174436.2961874-9-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR09CA0061.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::29) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR09CA0061.eurprd09.prod.outlook.com (2603:10a6:7:3c::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Tue, 4 Feb 2020 15:09:02 +0000
X-Tagtoolbar-Keys: D20200204180900487
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 759de796-b3ff-4bc2-14be-08d7a9842bc9
X-MS-TrafficTypeDiagnostic: AM6PR08MB2981:
X-Microsoft-Antispam-PRVS: <AM6PR08MB2981FF1D3D1FB7229F64D6E2C1030@AM6PR08MB2981.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(366004)(396003)(39850400004)(136003)(199004)(189003)(31696002)(26005)(66946007)(81156014)(81166006)(956004)(8676002)(186003)(16526019)(86362001)(2616005)(54906003)(5660300002)(66556008)(66476007)(36756003)(2906002)(52116002)(6486002)(16576012)(316002)(478600001)(31686004)(4326008)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB2981;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zflclb6L9RLN7USQ6j/aUhd4ncleIvu23/bZzzISfe6xgpT5LEk5E87sjS1nwzAFQepghtIGkcupmXlNjMKwytwYjzq78BlNAbnzZnchbE4UUgDsUU9YsvK8OapBs3WNy0hVUeM+j3rAU1E7aQaC6qXY1G1YOv+6BE52H0m4Q56GvB9ERNzHSGj+QL3HlFI5NPhL53E/5NAduWy1Wcq5Nq6Pg+zS5gSwKEtolYGMWoriPP3dptwm5+jvJ7P4mVBycxOgF8IPoBk/2+TEyExWWlG6gmJ4kfwhuXrYqWM1+rdu1zljVlo7to3oYI+WwHTZWTcu6u1L85/yG9a+LgzRsn6vEF4pVRwKwOGcUdxYpYRvhY92n5eL1fw6QKwDLasIuG7TlDB+VePUGSwbm8w77cAQuywPQ3aOjrtu/6vzHngMOLXcvaSlra4GcmLIIUbZ
X-MS-Exchange-AntiSpam-MessageData: 8Bv4XwfKVe2u9gv66KpTU38GTl3hQa/9XJb/KFAS3ojCfBGqK0R6GCU5O6eK4qJ/f5q/F/bXSJNfVl3sSbsTEjfPLLeJAXUadz9mQRu3BPJ8aXoizg2YIykVnNzA12Cugpi4TLyHsFgt2hYHtR+qmw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759de796-b3ff-4bc2-14be-08d7a9842bc9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 15:09:03.2759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4eOgD8Q6hGneD2uKwffPEWqAzGLtTfLxsKnNOuLEYdzZkjTyJW5K7134eQrN+N7kwWJW1nhoK8YtlqaGrS8i6BrXqRw7GFLnxbnN4qTpeOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2981
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.90
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
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 mreitz@redhat.com, david.edmondson@oracle.com, Liu Yuan <namei.unix@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

31.01.2020 20:44, Eric Blake wrote:
> block_int.h claims that .bdrv_has_zero_init must return 0 if
> .bdrv_has_zero_init_truncate does likewise; but this is violated if

Hmm, you changed this in patch 04..

> only the former callback is provided if .bdrv_co_truncate also exists.
> When adding the latter callback, it was mistakenly added to only one
> of the three possible sheepdog instantiations.
> 
> Fixes: 1dcaf527
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   block/sheepdog.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index cfa84338a2d6..522c16a93676 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -3269,6 +3269,7 @@ static BlockDriver bdrv_sheepdog_tcp = {
>       .bdrv_co_create               = sd_co_create,
>       .bdrv_co_create_opts          = sd_co_create_opts,
>       .bdrv_has_zero_init           = bdrv_has_zero_init_1,
> +    .bdrv_has_zero_init_truncate  = bdrv_has_zero_init_1,
>       .bdrv_getlength               = sd_getlength,
>       .bdrv_get_allocated_file_size = sd_get_allocated_file_size,
>       .bdrv_co_truncate             = sd_co_truncate,
> @@ -3307,6 +3308,7 @@ static BlockDriver bdrv_sheepdog_unix = {
>       .bdrv_co_create               = sd_co_create,
>       .bdrv_co_create_opts          = sd_co_create_opts,
>       .bdrv_has_zero_init           = bdrv_has_zero_init_1,
> +    .bdrv_has_zero_init_truncate  = bdrv_has_zero_init_1,
>       .bdrv_getlength               = sd_getlength,
>       .bdrv_get_allocated_file_size = sd_get_allocated_file_size,
>       .bdrv_co_truncate             = sd_co_truncate,
> 


-- 
Best regards,
Vladimir

