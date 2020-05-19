Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5743DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 11:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2117E20708
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 11:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lArQzj8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2117E20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb0IW-0002jB-Ad
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 07:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb0Hc-0001rV-9o; Tue, 19 May 2020 07:19:40 -0400
Received: from mail-eopbgr00112.outbound.protection.outlook.com
 ([40.107.0.112]:46859 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb0HZ-00053O-Lx; Tue, 19 May 2020 07:19:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pja4/9erEmv5xb2OsMlOkv1wJV6DlS4pkQAkqHRv3ayC4Xxh7o+hNC9s9DDva8fMpSV+bIlF7HrUtnjPOAQRshuLDfDfNE0Bxp7jKYI06mzg+1bIqilJGk09B5b6EeCeXxs6nofNgEo0hQty+x3LLxLZyX26LTeTZXzJITHRrD8Q7stbyroiEpulO8E8nzgQ9RPmzilMYGIYp2NXSV7xVOTUV8B1ZJ1FCrKasxv2rXda5RZQceqQ4QF5Ycug2CFdD8EKSjCLbOyCkCqwvS8JsYRVdwk5N2gMwjlwDkc1bh9DH2WiRrlktpd5muzzqlrZUQmP+z6KJQLyWi67G/QOAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4UUihZXJcx87nrGc/iSbMxD4IQOGAHigpkkuzDn6Tc=;
 b=V3yqgbypm0DMvy8uSPUXEKbMBvkOO733F5Q3oukS61/5oG8lC0ndYQ1/1rD4HaVUxwS30bD6r6DlPveCq7QUmZIqb91X8VwWMe/cCntvRGLTRhRwzhi8Z/o20cEaG946mx/acU41X1r9hf/j2OVU6saTsr4eK7G9B4hhlcRggVVDp3maOXXt04TRn+nY2ZlOFbF39ENp4BG4mfdUaFX36BLQfcvBahZD3BXaaN2537vKEiglvlH8Q/HBxBqQ/elcBkiPHs/O0c1Al3jpIcQy9M+meKwFPSZ98BAztzKB80TNJBqmNiaqZaATWpzI7rIvaiDBS5Qh476TejzlPaVXHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4UUihZXJcx87nrGc/iSbMxD4IQOGAHigpkkuzDn6Tc=;
 b=lArQzj8gtTwB3GmIaEOhXq2uXABnDpJYLYyoMaHKQpN/JgMdE4tpNSdoLJJzw/mu13sTHtTRDK32nr5yGRLHittn0PNp94ZIlaE1roEhb9oxxC4KkZm7A4YLd5Et2e/HplYRZXQ+bXY/jeu6PT1Wh2151pGYUAUtpvA9tQRdYPw=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5415.eurprd08.prod.outlook.com (2603:10a6:20b:10d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 11:19:33 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 11:19:33 +0000
Subject: Re: [PATCH v2 0/9] block/io: safer inc/dec in_flight sections
To: qemu-block@nongnu.org
References: <20200427143907.5710-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2350408e-23e6-9dcc-0b3a-ff6546df2c86@virtuozzo.com>
Date: Tue, 19 May 2020 14:18:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200427143907.5710-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::7) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 FR2P281CA0020.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.24 via Frontend Transport; Tue, 19 May 2020 11:19:33 +0000
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2947be4b-26d9-4f61-f8b3-08d7fbe681f2
X-MS-TrafficTypeDiagnostic: AM7PR08MB5415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54155AF38127D074AED19530C1B90@AM7PR08MB5415.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gIZEUEzZ6xCP2HO32ogXArIka8YXhQr84Hot0mLdiZSliITlG6VsrqVmPqLsnZReik04dLO201s8pT5jDpU+yBdqo2wfNirc3/4G4wnAYu9Rwr/iGIOYWGcMJgP6Cg72rd6WYIbut/RQ6IboOb87ISWf5nfjeNzvBjN6XSH5o/Bn92TcqaxnxpzOCyCf/hiKGwTitZun1lMEDeIHNF0s/1X7t9Vg5phAeapX2vTHKxsDz6DfHCcVtdKjNBqUTTBwMHPk5N/TNmiucEhvl9jWU2d1zkshyay0QhU5Pu/vEDNHKvq1GtpFlNaZQQ55X9X9LrseTTx4PVMu2Zt16LZ+9qrkUebp0Vq7KdM17bFbZaA0jkzjo3sbANvG90EpJcdioJm3UQL6b7xoFEqrphY8TNI/FZmacdl5UoPgSrqMgcpMaz0ELqA0zdHIAyNNsITpn11Sm7f+P4vKqd5KkfHpNqdRg93KQa9BPi131D2F5g6jmrkEMJnxoR0FJ2l5hgSq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39850400004)(396003)(346002)(136003)(366004)(186003)(316002)(16576012)(4744005)(5660300002)(16526019)(36756003)(956004)(2616005)(107886003)(6486002)(26005)(478600001)(6916009)(4326008)(31686004)(8676002)(2906002)(8936002)(66946007)(52116002)(86362001)(31696002)(66556008)(66476007)(6666004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: U0KdBPVt7YZHSaFdaeDCND+t8M9ImO42u2WSJskNzREQKkaRfT6jdEsNnZ1D7jOYXGMyuorWxqdohODwo58s3m8yNAbMVBtOu6kuYhhRaWjt226OAmeWsyTZTtLEVZORYtPTTjU3AfpqudkTQH4VYLfsL7SGqHzloD68qwxWybw1C62ewIuzlUaL6mJbxduf/iVJbpMrItsD3iU1kEMGa+oyQ3XcN2y+ZcS588jyhUS3b+W9ghYUFZN8/TuX1bUYQ7hZTcnbKJTDEwEhyR2mPl95SRRyFki52TMzWjJIa645qYLqJXo1tqduLOaeEUYSekgIUKtQIWDMASjJ7KtigyVv/P2stkv7nENxC+HUB2Hf81t62ayjMgjjjbu6pEKF9SEABpPw62SyThLKSbPlXCcgSVZnQn1Aoc3TvuFUeMSmGnS6VKJDE0VYvQYj38Js+p1z/VVNuYUa/320f7Na4xJsk7xyp8NQBgw/1vQsGctpKWj3Y1IQvlfoN79tm2R/
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2947be4b-26d9-4f61-f8b3-08d7fbe681f2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 11:19:33.8215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZP1EJO8VM2DGwV8kec+imAAqO9mHXz8BzLzHN6giNI5K6S3ZOnKfs1fICmzd5f59l/vAhlFcmIeFuWbEUcOLiCsWXzVJmk5qyeVckPd2Cj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5415
Received-SPF: pass client-ip=40.107.0.112;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 07:19:34
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.04.2020 17:38, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> This is inspired by Kevin's
> "block: Fix blk->in_flight during blk_wait_while_drained()" series.
> 
> So, like it's now done for block-backends, let's expand
> in_flight-protected sections for bdrv_ interfaces, including
> coroutine_enter and BDRV_POLL_WHILE loop into these sections.
> 

OK, let's postpone this thing.

1. Idea to move ind/dec out of coroutine seems wrong, it leads to dead-lock, as shown in backtrace in my answer to 5/9.

2. Idea to keep request inside only one pair of ind/dec is probably an extra restriction in bdrv layer (I just blindly followed how it was done in blk layer by Kevin)

3. We still may have a theoretical race between request start and drained section start, but it needs another audit and smarter solution.

So, seems that we should not apply these series as it is, sorry for the noise. I think, I'll resend my 64bit-block-layer series based on master instead of this one.

-- 
Best regards,
Vladimir

