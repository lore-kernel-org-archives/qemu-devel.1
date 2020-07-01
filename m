Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54488C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:20:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F6DA2067D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cNt0ADIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6DA2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqZqp-00023k-Dv
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 06:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqZq9-0001Mf-LS; Wed, 01 Jul 2020 06:19:42 -0400
Received: from mail-vi1eur05on2111.outbound.protection.outlook.com
 ([40.107.21.111]:4288 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqZq7-0005Fc-3n; Wed, 01 Jul 2020 06:19:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fa1yFrmXqGBo82jrgAI2oifx0Y+RBVEk0hxk4WwahmPqvWvy4Fuizno9iOtlHyciADkDQ/MysmS4aVlELop7SZ5yzi1MPI68UcCXJO1h497EGkAUp97L76OnXGPWo6AO77AeVLEAG0lgve1f76x1YqpAVRQzVz2jTyDN/0AQd6mf9mooM1VImCCEN+tbwsP0nzef8nBVR8EBWi7RIP34FPqNoexiZgaTDzLL2m3j8sJ0JPqcryyzwv9+aUgD2rEgzpgicxY1h/1q8ZEQIrZ/FkVX/8H8juntJUCeaU7CnvluuINc3ADgGFwghzRyCBoII//N+3RvrLBjCSp/aO3rJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyUxS3NUze4QV9cq3qjavV+b4tLhQld1MqGys/z2jzU=;
 b=WeJxKQsCHn2wSty8lwxI8h7hIe/Qs57JwtvkrZWemVUrQ/pPuD6a/HJ2FUttTTdrh3E20qwdU8aJ/TFD25Qgq+U3pYwEhPT/XJLGw78zinmTCjfdpy2xpaBNdf0cLhMoYLUN4z8cYs0ztThngSHd6mQy9vJziDR2id3ev3Uem2YBNCrAioOqlcfu5IpaulWGKC86hZ7qiyCJWIJCP4baPyTbDJEZvOG00P60vRSRH7kQVP98e4smg7kzrS6MO0XbyX6cJwI7mUhyYBPTN7FcyudbQD4muv3umwqpdWpAktWJaDUhVJeOICqhMd6gfXrHL91s7YEegtu/NaSYU2KAfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyUxS3NUze4QV9cq3qjavV+b4tLhQld1MqGys/z2jzU=;
 b=cNt0ADICXSmuhi/sbj+lvPN6EGx+z1ve62u3RtUgoZLNzJ0aizNt19XWWdTsl9urEkN6j+TZNRmawxS8JEuo1haOStULdoP/WU37iZrgYASifuC65D9cUCTP0KW2w6++JQxpr1ZmD3Hj1S+cc8UhIIKuyrAN/ySu0ZxDf4y7b40=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4723.eurprd08.prod.outlook.com (2603:10a6:20b:c8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Wed, 1 Jul
 2020 10:19:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 10:19:34 +0000
Subject: Re: [PATCH 3/4] nbd: make client_close synchronous
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200625142540.24589-1-vsementsov@virtuozzo.com>
 <20200625142540.24589-4-vsementsov@virtuozzo.com>
 <6f10f2d1-49f3-edff-eff6-0a2f97c07ebc@virtuozzo.com>
 <20200629135616.GR31392@stefanha-x1.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7013ae27-27c9-e58d-8a55-fdb84d82d5e1@virtuozzo.com>
Date: Wed, 1 Jul 2020 13:19:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200629135616.GR31392@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR03CA0074.eurprd03.prod.outlook.com
 (2603:10a6:207:5::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.28) by
 AM3PR03CA0074.eurprd03.prod.outlook.com (2603:10a6:207:5::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21 via Frontend Transport; Wed, 1 Jul 2020 10:19:32 +0000
X-Originating-IP: [185.215.60.28]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f89cdc9b-d62e-4cf7-f62b-08d81da84002
X-MS-TrafficTypeDiagnostic: AM6PR08MB4723:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4723BECAC60EB26FCC057C41C16C0@AM6PR08MB4723.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GR+vWpArXoGRkbkX9MjO7cU+Ryoo547fMy1LSi/y8e+3aozih0mpQHI7Q7j8ffGxzVBGzV75ttK2qxFGMi0iNTttc31tDHzGplw4bfCoatRzMGcIbgIuRszvQQ9RCL4T1TJiZsX+ZHqQkPISf2D7w5W8uvCciPyDEVUK5sEJL1Gr95z1dhJW2W1s/E4G3wx/UJT1oBfmciPOAHt/+/TnOopvf0x/wGPjiCqWOw8rFalwdZdPS4QgPEe5ITuHH9FbcWV320ZcVShy6FXNK7BFEUpbn5QLZ14yARg9aFhlOxrVMdr7f6pGoiWy6CH6kJN/87Mclv+OrmTioc5ZF0Fm9zflXcyg6SKUa/tmWao5UiHRzbGTMS13Ki49gK2yTz92
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(396003)(346002)(376002)(366004)(136003)(66946007)(6916009)(316002)(6486002)(31696002)(86362001)(956004)(2616005)(5660300002)(66476007)(66556008)(52116002)(107886003)(16576012)(4326008)(2906002)(16526019)(83380400001)(186003)(36756003)(31686004)(8676002)(8936002)(26005)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: YuyCimC7nTlL1J38nG5FDwpGZystWOB5FtQLkFL2WCOEKUJKevZDHOhbKFckI0P/Gfht+fra91ZcjAgOrjhddT/0BE3gqxl9sGj/z/nBfesrBCuWcRAaPHH/BV7MBZfsYxZpAQmxnCTh2db/vuZru7/2+5rtOwYaJPAt8VviV3190mShOJmtAc1M5RjI3Xw9rfi6P3SioMAADfJPWUifzwil8fllfz7yoWfwA5Q0U8lWZo+JQovwdKZhEsfKxbYez0JGZ7PaRf8DtTW2VvJVnF1GdpCNbmQFOQfp2U4TnTgxq6jYIlTH+T9lu8sZEnC6L4j9fKjQ2t7w+Q2ltI4P7ji8X3HWqNppgeSNc+XTpby05sNotOxpUYb3tKaomDA5dd7Eg+AJfhXhzVBNbiDWm9lChLRMvnUElSrs4ttKJBn4OwKKwWNKE5dbYEsL3w/sCVNleTmc6Syf4BrwIIeUBkh/WlkTuR1But32ypBZY4U=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f89cdc9b-d62e-4cf7-f62b-08d81da84002
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 10:19:34.0742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYO1FUozesTwaa/+juTLYQilgYy0RRxtiVO1FxXUgyqLXfeTPd4B+ZT38cfMFxpjhs8NT3WTIcSSdHT/9Guy0svs1rLtYZtJBdVR1ecLLgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4723
Received-SPF: pass client-ip=40.107.21.111;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 06:19:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

29.06.2020 16:56, Stefan Hajnoczi wrote:
> On Mon, Jun 29, 2020 at 10:55:06AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Also, why in block/io.c we kick the main context, but not bs->aio_context?
> 
>  From AIO_WAIT_WHILE():
> 
>   * The caller's thread must be the IOThread that owns @ctx or the main loop
>   * thread (with @ctx acquired exactly once).  This function cannot be used to
>   * wait on conditions between two IOThreads since that could lead to deadlock,
>   * go via the main loop instead.
> 
> Case 1: IOThread
> 
>    while ((cond)) {                                           \
>        aio_poll(ctx_, true);                                  \
>        waited_ = true;                                        \
>    }                                                          \
> 
> In this case aio_poll() returns after every event loop iteration and we
> will re-evaluate cond. Therefore we don't need to be kicked.
> 
> Case 2: Main loop thread
> 
> In this case we need the kick since we're waiting on the main loop
> AioContext, not the IOThread AioContext that is doing the actual work.
> aio_wait_kick() schedules a dummy BH to wake up the main loop thread.
> 
> There is no harm in scheduling the dummy BH in the main loop thread when
> AIO_WAIT_WHILE() is called from an IOThread.
> 
> Hope this helps,

Thanks!

Looking at this all again, I think that client->recv_coroutine == NULL is a bad marker of finish, as it's not directly bound to _put. I'll try another approach, to make nbd_export_close_all() be synchronous instead by waiting for all export to be actually freed.


-- 
Best regards,
Vladimir

