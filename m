Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB83C3B187
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:13:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589A92086A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Dg+0L2y/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589A92086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1XDg-0001JU-J0
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 10:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j1XD4-0000iU-5T
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:12:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j1XD2-00053d-TO
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:12:21 -0500
Received: from mail-db8eur05on2119.outbound.protection.outlook.com
 ([40.107.20.119]:21856 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j1XD2-00052z-9f; Tue, 11 Feb 2020 10:12:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiqoyvA8s3b3yHyki5SvIB53ysVisva6KPQVbZNdVVBzSvVpr7ZoDZWU5H8Mznr36rbthrMhhfEHIHz0CYuZDyH+GpdmYSROEl1PKsSEbF0NQFrbpNf5mztDJvuuclabB52zI5EJfzgD9xICWTBrUSLHJuMhdlIBxklgkEqEH1LLChx16xXL3+XpwpRsTMThTLM/hHJM8cyKSCR+ZE3XqGNCtLAoQGk4qy41fM+wchLOorLU0xr4C7Lqv4c3omLKB3OCnUOE01OWFNd5GY3GZLSybwumApsqZyael3hWLFmr7DubgVqvzLqhedXv9tMdSBsf1FyzteAafe9F+2nmyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RU6wfQZH9h0W5cyEHJ1AmgoeY9o5zqqa6l2b6jyS6AI=;
 b=ZCH88rYf8CcY5ShAObMgXbAoDPYLVVXfdEFFlomGS/Yl6BPNSJnfnpT5p82csySHgWQdf2n4OgLPF19A6KLaNIGV0w3mivKdG6NIA0wgty4UvyzeOVroWSKBGs6YjanG7M/R3/rbsRcweFt1dL12h1ExiVS8C7xfmdCfXOMMKNFB/6R694FXNYedwgfdc9aydKi0hkB3u/Vf+hAfbcuGADSUVJC7f5ySAoYEH9t+N//j55Kcrz4QyW5aZFsWdERYTRgvnDIyNqmH5JzvWgTjZGayl3nRt0cozos0dHrDUt+b7CMcu4sCBUr/JjJgmiAWX/0uWC3hC4BqPmj7viT1WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RU6wfQZH9h0W5cyEHJ1AmgoeY9o5zqqa6l2b6jyS6AI=;
 b=Dg+0L2y/GLSRkvTCNVgvQSNk+TJFONSjIZ5MkM+Mh6TAfprJMXbzZlP6Evgcxr0v1qqB0aa9XGFLehBUAU2glsGGGBQdnStXVVJbyvQdEvRLNwzwwWXp7xze6t5TO/bDOsFACWywPteOgfolF/9LV2JY6rxsmLUy9SDbf+SeqpA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4952.eurprd08.prod.outlook.com (10.255.120.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 15:12:17 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 15:12:17 +0000
Subject: Re: [PATCH 4/7] migration/block-dirty-bitmap: keep bitmap state for
 all bitmaps
To: quintela@redhat.com
References: <20200122132328.31156-1-vsementsov@virtuozzo.com>
 <20200122132328.31156-5-vsementsov@virtuozzo.com>
 <875zh15d9p.fsf@secure.laptop>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200211181215513
Message-ID: <f6dff4ef-7cf2-0881-3e49-9c2f4e7514fa@virtuozzo.com>
Date: Tue, 11 Feb 2020 18:12:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <875zh15d9p.fsf@secure.laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0202CA0037.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::23) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0202CA0037.eurprd02.prod.outlook.com (2603:10a6:3:e4::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 15:12:17 +0000
X-Tagtoolbar-Keys: D20200211181215513
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a733ae1-e8b2-4eb5-073c-08d7af04c88e
X-MS-TrafficTypeDiagnostic: AM6PR08MB4952:
X-Microsoft-Antispam-PRVS: <AM6PR08MB49528F8EDFF36FF509BBA2D8C1180@AM6PR08MB4952.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:131;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(396003)(39850400004)(366004)(376002)(189003)(199004)(86362001)(66946007)(52116002)(6486002)(66476007)(66556008)(36756003)(81166006)(31686004)(8676002)(81156014)(8936002)(956004)(26005)(6916009)(5660300002)(31696002)(16526019)(478600001)(186003)(2906002)(4326008)(316002)(16576012)(2616005)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4952;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vqPAPIqZpHlM91VDfs0F1Afi34ja8oe9u4TUEtC8RGjXPfsskE2Q9hv5s7+CmwxbTphF7hGO5zE1zidMc7nL5ap0fzxGaaH1T4w8SiKix9Mu/Bn0XJfU3bViO9Z90HRp4o2D6YEF9V9mOeKAZZypoWWUqPxx2VG3Comq6+CWEUC8mFHQIz1jgh7lcu0/UoMsO1fhHh3dD+m8YtOPUPyDXqQvaicpc8FuKisMyHzfwVe94C4KlCokmGpN2bRgM7xT85toIi00rA3ohirK2zpLCR5phvW5jcCDKlSwi8lefbg1Gx1xca7InKJzhv5TVV0QXwq3eFHS9v+aXduoLqZ1cuDati5ez/xdXHA2ehIIsulLGMnMxZhm6YzklZTQVH9VJkZ1IPm9dINw55JzDJDjAhCNGeqfeV96jdivJmS526qJVc8T7FX1awW1cO5GwviXL1TDfBFD7/2teQIyvIR+hP6ui4fnpAJ5y00Aq9ko/lxAhqqoCS9Cfzqm9hAgtObS
X-MS-Exchange-AntiSpam-MessageData: qsspEdQebljxN5qIWjj/6KSfb2IHLCgOuuQkD0OHIQBYY0IMZNP6wZ2nwuDN4pmp6HmlGzKYhoQa67qs7Yj0ufQ1mfs3k88+8UgUWTKnSvJFAN4KiyfWd1vMkHFWztx1pCRPBYdOHnQNLA1FAuSpQg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a733ae1-e8b2-4eb5-073c-08d7af04c88e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 15:12:17.7164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjB7+HtrS1/P1wAXVNfkCagScBoFjIwPmyaR+Vli1d1OIeN28YBS+Lnwd9GXfXON9kX1MxhJQUOrTMIn2XmlArGv/VLwhcMSK3lbxbXJECc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4952
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.20.119
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 dgilbert@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.01.2020 14:01, Juan Quintela wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>> Keep bitmap state for disabled bitmaps too. Keep the state until the
>> end of the process. It's needed for the following commit to implement
>> bitmap postcopy canceling.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> -
>> -        b = g_new(DirtyBitmapLoadBitmapState, 1);
>> -        b->bs = s->bs;
>> -        b->bitmap = s->bitmap;
>> -        b->migrated = false;
>> -        dbm_load_state.enabled_bitmaps =
>> -            g_slist_prepend(dbm_load_state.enabled_bitmaps, b);
>>       }
>>   
>> +    b = g_new(DirtyBitmapLoadBitmapState, 1);
>> +    *b = (DirtyBitmapLoadBitmapState) {
>> +        .bs = s->bs,
>> +        .bitmap = s->bitmap,
>> +        .migrated = false,
>> +        .enabled = flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED,
>> +    };
> 
> What is wrong with:
>       b->bs = s->bs;
>       b->bitmap = s->bitmap;
>       b->migrated = false;
>       b->enabled = flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED;
> 
> ???

Nothing wrong. Compound literal is a bit better, as it will initialize to zero all skipped fields.
Still nothing missed here. The change is actually unrelated to the patch, I can drop it.


-- 
Best regards,
Vladimir

