Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92F1CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75807206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cqg5F2TL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75807206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYXFK-0003QA-Ls
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jYXEd-0002uW-Sl; Tue, 12 May 2020 11:54:23 -0400
Received: from mail-db8eur05on2133.outbound.protection.outlook.com
 ([40.107.20.133]:23616 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jYXEb-0001nN-0e; Tue, 12 May 2020 11:54:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyfLxuZBaKF2QmdudBmA3somjPjX5QOwyxeoH0BOSLekqYeLKeZ4O30TGHTajg42bj+6+wBO+Zhna91u9noSQEyqwL00q+PumCIF5wDTiGV1MZc+cLJYdYhJyZu8pge3NDkpuF3OcM+VjyFc8NU4QCSJHjsNS4yStTc3/S3G8PIcrN6umbblmc7gU+hG04T3uQp0HGmNT1IbaBBVOJfnSRa+yyVJj/PUlI0B989V9poc+HpSg2lo6PYnqOHqi7LcFEy/0CPHkaFbpSYX89X+Oyz+fXG5Rca3PPSlDD888x3dSu1PYzAL3D1+AQCU0qiRK/gmrry4/X3Gv1dSuaFxBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5fM0SFD0PxF9HACFUuk9BP8TYd0H87w2PJbKD2kQJI=;
 b=Eerfsakj1hxFW/PFXFJ20nDgLBbIQWl8M9q8eXM9IagJZgK5HTu/lmitNGpWo1stHMJ3BijMz/wU/sKk5t+XqyW48aARJEi/QXLefCrXSB27D5RmIgQROn0Y72HVAIIjWj6NvTrkLxFToX4+fN485+oypIy9uo7sdMdZ+kv2FW8tiPIJ/YF1lklV8ySFNi8jwlfj1zkXoWDwlrmpEnw5Qe+t2tDPd+qFfWv3jgbc1TbVR1S0H2K+zE4pnIuBD8dNbA1/LoUvNd6wtiC6xlh+iIhr9+r4HkqB+11KZyXR1q6eLNWaJbtX/ap6yrksnfd955COn/M6FGG5Y2JzOWIZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5fM0SFD0PxF9HACFUuk9BP8TYd0H87w2PJbKD2kQJI=;
 b=cqg5F2TLl7RdO7YVMGBYhy9s7smAB6NeJ/pQWtgpGTm5MJ1jOKr6FPBcC/PbcJJOnD3Q6h2udx+oB2zqc9lnSEms7TQV/e+JUghjA+Dtd21rDTsFW/NlrIFaJFn+fDjVUv0rMRDkpYfD/6Uq5aZZT6Eu7GlABzEEEjonCBQMa0w=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5397.eurprd08.prod.outlook.com (2603:10a6:20b:dd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29; Tue, 12 May
 2020 15:54:17 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 15:54:17 +0000
Subject: Re: [PATCH v2 2/4] iotests/229: Use blkdebug to inject an error
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200511135825.219437-1-kwolf@redhat.com>
 <20200511135825.219437-3-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200512185408860
Message-ID: <43443e30-df14-b888-e11d-aa97967eff05@virtuozzo.com>
Date: Tue, 12 May 2020 18:54:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200511135825.219437-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0202CA0012.eurprd02.prod.outlook.com
 (2603:10a6:200:89::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.163) by
 AM4PR0202CA0012.eurprd02.prod.outlook.com (2603:10a6:200:89::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Tue, 12 May 2020 15:54:16 +0000
X-Tagtoolbar-Keys: D20200512185408860
X-Originating-IP: [185.215.60.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d705d400-6139-44e9-2bf9-08d7f68cb9e9
X-MS-TrafficTypeDiagnostic: AM7PR08MB5397:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5397DDFA0C8BEF789222B6A7C1BE0@AM7PR08MB5397.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBJidTGDBTi8kklv0jvo0qbD4cvVrIxKNpfKZ05MeBy3ZpDh8d7BItKaXhPNBaWwoIj0TgsJ+R9p+/e1FPxUIxMYGTGWVDMECmB3JM2zY1uS5tb1JnRtz9s3BCa02dxyhRwp8vSoi89Dn87ddxTqg5w3h+J2XNr+LilbaKuDB14I2teAhV/ehrQhDr63gGcv6NRq/XxnGJWQNYyu5nMALlQsLtNFS3a9e0x6U1HVGZlmPGDN80qXZRjQvwwhshmV4USxFDi+3LzzmHhAeT1wwoeTCIXMAicsJVIjd/V9WY40639aSIDiioP5uas4fy4cR1WBjZY56m92c48mGZcKxuW4rqBKUqXu6ZhiDci51j27yl8XqF9RCnamHfRhTTdEfk69tDAMVUnehpfF5y0+g04KJrMR57IklHTYyPh+mbLeLlI7IcPzCEIvJ5z7mrq+MDiQfN1XXGiYAHwO2ZOY90uVvXDpW3Cnmbeu20POYpfKTJ2/gLRH7YcJ/WvMMrsyvhpi9k7AuS1Rnijs3Hx5c0RaQlTkiQ//bjm0pxfO0PIUidZW/Zvl3TW8THqrpGE+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39840400004)(376002)(136003)(346002)(33430700001)(316002)(478600001)(66476007)(6486002)(66556008)(8676002)(5660300002)(4744005)(86362001)(31696002)(8936002)(66946007)(31686004)(16576012)(52116002)(6666004)(16526019)(186003)(26005)(4326008)(36756003)(33440700001)(956004)(2616005)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: lqnCcjut/bUIuYby30nmlIwAgNYhoDDP1+c0kG8/tAM2/liLqeKxDn5IdQzZqjS0ZCqaj2dlwrm/BTHFYeujDscw4gWDO2PUTu+cYihAXlpiYbyhCQdLrUQfLQmjsnGBV5dYw2tWL2qDd6fzvWUwbAE1AXwnQpDXTcGKsdrI7vnFs6j3AowdV3lpUooR9eL3SQUt/sWdaF72vXA/gjWBTKaWIjEiNSomb56RcDnAmRKvNTlZ3OxkmykulOR4rahfwh7POsXf+BBYvKqkqAi3MRvcWEyQ6bsbdTw447DzHK0zS4IitPR+q9wJxdvYT9748DG9WrhKXYDmXy8ykTi13XyYb8oy3srz33CwTayFGjHVySLd1uOWG/CMlVIB3Q+IGaUpiHxXj/Af8txoF7Ok43vjgDISYa9vVVYzgwLCzGoo+S/iUt4QkwmkQMcJxvrNahoYQPMnAN6dvBbnKaTlN6DZBsbSc+wuT+xaPGgSAxAMmg7HhVt1vfeBYhNxQZUJ
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d705d400-6139-44e9-2bf9-08d7f68cb9e9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 15:54:17.7322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIacN0T98BlGHiChbPivaiHEhkAQXsh9LhTNJxMDFU+y3R1aUMNQ4Wnw37EA2AmjJDXQV/f3z9PrURgMKn3ivvpjzOsegcrJT+Zs+3URrEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5397
Received-SPF: pass client-ip=40.107.20.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 11:54:18
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.05.2020 16:58, Kevin Wolf wrote:
> 229 relies on the mirror running into an I/O error when the target is
> smaller than the source. After changing mirror to catch this condition
> while starting the job, this test case won't get a job that is paused
> for an I/O error any more. Use blkdebug instead to inject an error.
> 
> Signed-off-by: Kevin Wolf<kwolf@redhat.com>
> Message-Id:<20200507145228.323412-2-kwolf@redhat.com>
> Reviewed-by: Eric Blake<eblake@redhat.com>
> Signed-off-by: Kevin Wolf<kwolf@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

