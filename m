Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C047C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:32:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FAA4207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Pr1c1s8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FAA4207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVG6W-0001de-Dd
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFsN-0003jo-E7; Wed, 21 Oct 2020 11:18:07 -0400
Received: from mail-eopbgr50096.outbound.protection.outlook.com
 ([40.107.5.96]:38910 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFsK-00027G-Gl; Wed, 21 Oct 2020 11:18:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jcd5IGN25lHetm7z/vN4pPFmQdkRuwy/XxqejZahIu90czuH+jOYAasVLSSI6ABXnrOJLmSmjuytUbztWsRl1OH6l8ZYcaZ5ht7pJFIHTbUb5Yz60dQA6H4YdkwXOrSasXI0jD6blmJnR3Qm3vMYn/dBFZj7Z5geoaXv8pQrtL17HoNR7u9v7HIrqFVj2u5n+S3V9xffHtaPWsrNhzpbtfZcGHdXX29zE9V010tEY18/tQmAEqdSZ1eJe7RjTGgj87I/w+ZMkhp5HW95+pb6ChLeR4i+U8fwz70ud9MpaNAd+/4EbyU2u6djCKxoW+raPcfmLuX4FmLF5QOL1fYecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcBwdZjZ0v2sD5LC5sttv9WnLuH1O5MDytbONn9/01A=;
 b=BMQ2bnyPvvR4AXQIjVcek4bxk7EQ8C/5uuR4lD+aOR6T+PuXatxpnjK52dSTGAnizfdppWl/nHwpNaTYA9e9FgfMF0x6fqFS23/LM9z2SJt/jrHkb1NrtW75oQ/+TV+m0Wc/k5ClKweUqUM38cNth7teRcjH7Lptr6xAthjJGk2QqnvezspwtW/YDD+F/M7kGQOskIu/4YJwVLbX1OVEdm0RgH16Lrwa8dfkn9Iu7QIWbsbVCd6cFb1axvbGJ7VFA/RokvSUMFVn4DxOlQRPXVL3bLao2KU/djmYjQgG42cWenrl+HqF8hq8t1+dJaXFIrXH2rL2WPwI+yb04ahrzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcBwdZjZ0v2sD5LC5sttv9WnLuH1O5MDytbONn9/01A=;
 b=Pr1c1s8dlnGcTac7zuRKnZU9jrqaxSjmo1gsFHrZsI0hpYfjDUh9QCZzjLHOi9rENnqnxSoas9XbmJWXJDSIihaNtCG/ZsrRj+UqPNTvUBznxQSamW06wd2JYf+IC1RVIaT4/OjXvovxlNZxDiiVVKZdGsptmKaDCmgNEVirZhs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6168.eurprd08.prod.outlook.com (2603:10a6:20b:294::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 21 Oct
 2020 15:18:01 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 15:18:01 +0000
Subject: Re: [PATCH] migration/block-dirty-bitmap: fix larger granularity
 bitmaps
To: Stefan Reiter <s.reiter@proxmox.com>, quintela@redhat.com,
 dgilbert@redhat.com
Cc: jsnow@redhat.com, eblake@redhat.com, fam@euphon.net, stefanha@redhat.com, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20201021144456.1072-1-s.reiter@proxmox.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <0f3e0eba-28a3-7c6d-d8db-6831ab6a54f5@virtuozzo.com>
Date: Wed, 21 Oct 2020 18:17:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
In-Reply-To: <20201021144456.1072-1-s.reiter@proxmox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR04CA0070.eurprd04.prod.outlook.com
 (2603:10a6:208:1::47) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.82) by
 AM0PR04CA0070.eurprd04.prod.outlook.com (2603:10a6:208:1::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21 via Frontend Transport; Wed, 21 Oct 2020 15:18:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebbd486f-c97f-4332-a2cf-08d875d47fef
X-MS-TrafficTypeDiagnostic: AS8PR08MB6168:
X-Microsoft-Antispam-PRVS: <AS8PR08MB6168E5EE3B0D50A59ABAC4E1C11C0@AS8PR08MB6168.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:285;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3KbYi+DrBy1Qg4it0TX+UZpO65YtcLJ8WqlT89G38JxvUfrohs8xmFp6u/afCdHpTLRjKxTMpR10JzXBjJdYbDN5f1z90IZPajkp+JXmq1usQObMe2gp4RD6DPzRIb4FngfuwQkWEuhAINQdNrKLL3exv5NzWg+gAYE8vpAXyLX/olbJvIlloImvWWHL/tNqEMUQdDTJWqrbgm9zXfGl5K3bkjq0v7yI0eTqP1VsElzLE8INVzI0kDGwA8K70PnPfjkpuijgYwQsefR9Qw4ReCWtmfJ1y9BJyBpYuOevx0y8dRMrG2YeGQgfY/Or0hTzXZhn/DuSQk84TDQ4CZAY5cFSElO0yaup61+PMxKpBf/Psg2M5RnUbmdqlvikOZKKrmFsEeKxpi9BaBmRwaA0kA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39840400004)(366004)(2616005)(26005)(956004)(66556008)(4326008)(36756003)(86362001)(66476007)(31696002)(16526019)(478600001)(186003)(16576012)(66946007)(8676002)(31686004)(83380400001)(6486002)(52116002)(316002)(8936002)(5660300002)(2906002)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Y+EucE96aJ3W1S8gke3tpovh8jGabByUKJ7raZHSJpb9wuAGzcfTrZTrdV/PxbPg7W8X4bUGFGxGz2U3qmxkvii4VpM5lBGMlN9FFVZrA5QBHE3/pnkPmzCzEl2e1r5iyiBfBzeHr00H5m5y1DXQlkfvBmkjc1KkboKgOLP5UhSemjO1CI3AbEiZWALF1KgOII1kquSHMY/7Yr4IExgEeUaR0oyAZ1KsgWf1FZ1/suQpmZCSoPOPoUsoJ4YZEZUmoUC+Xj/BB5QEJylXCK8HrI6ramdXDlMmdendsRKDcB+ZXMVhinzVsCpsLXPnHSAh2QR9UdKpF1bZGYEHMDBW5JAU8ANdF4i55XiaaP2T3cxDK37Wfj48WJ/bTMMur4MdPQyePYbPMLpLeRKV+PkIPvo6JhSvDJdGbqlb5PzJ6dLd6QD42WeSfku+TeWo++0/wsTYVAk4KWDmcpvAhIgt4ZRgHANYc8hqVMx+LjQCPp5O5Nz9eDqmXqCvaZe4V/VwnD/zZejauuJvq9ufPuBFaEstqCmw7fr0qoJCHw7ZCqZmkGrgE/3uLhALTiVtgAGV6eQy5VfuPZZYTG347dbz0ixNmLJtHsFtLzAGygbg0tB+gUNA8AmovkDYoiOloPpK9xUIPAmrrrM9c06Go3rkog==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbd486f-c97f-4332-a2cf-08d875d47fef
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 15:18:01.3729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhAGnv71uoy5U9TzcuJ7/EaDC9bZ+ir3PYmZsTC8wVelB1oWJKLZF1VRGdOesF9hHMKKO3jEzY/JZj4KTifbuqDt/TyAtRPwYnf4qywMgbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6168
Received-SPF: pass client-ip=40.107.5.96;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 11:18:02
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.10.2020 17:44, Stefan Reiter wrote:
> sectors_per_chunk is a 64 bit integer, but the calculation is done in 32
> bits, leading to an overflow for coarse bitmap granularities.
> 
> If that results in the value 0, it leads to a hang where no progress is
> made but send_bitmap_bits is constantly called with nr_sectors being 0.
> 
> Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
> ---
>   migration/block-dirty-bitmap.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 5bef793ac0..5398869e2b 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -562,8 +562,9 @@ static int add_bitmaps_to_list(DBMSaveState *s, BlockDriverState *bs,
>           dbms->bitmap_alias = g_strdup(bitmap_alias);
>           dbms->bitmap = bitmap;
>           dbms->total_sectors = bdrv_nb_sectors(bs);
> -        dbms->sectors_per_chunk = CHUNK_SIZE * 8 *
> +        dbms->sectors_per_chunk = CHUNK_SIZE * 8lu *

I'd prefer 8llu for absolute safety.

>               bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS;
> +        assert(dbms->sectors_per_chunk != 0);

I doubt that we need this assertion. Bug fixed, and it's obviously impossible.
And if we really want to assert that there is no overflow (assuming future changes),
it should look like this:

   assert(bdrv_dirty_bitmap_granularity(bitmap) < (1ull << 63) / CHUNK_SIZE / 8 >> BDRV_SECTOR_BITS);

to cover not only corner case but any overflow.. And of course we should modify original expression
to do ">> BDRV_SECTOR_BITS" earlier than all multiplies, like

   dbms->sectors_per_chunk = CHUNK_SIZE * 8llu * (bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS);


But I think that only s/8/8ull/ change is enough.

>           if (bdrv_dirty_bitmap_enabled(bitmap)) {
>               dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_ENABLED;
>           }
> 


With 8llu and with or without assertion:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

