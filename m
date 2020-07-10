Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F02EC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 14:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECCB120748
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 14:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tY9KfIXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCB120748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtuD6-0004rl-8o
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 10:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jtuCE-0003qD-Ab; Fri, 10 Jul 2020 10:40:14 -0400
Received: from mail-am6eur05on2129.outbound.protection.outlook.com
 ([40.107.22.129]:39424 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jtuCB-0006Nm-4i; Fri, 10 Jul 2020 10:40:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0M4/UmwzCIyZKesvTP6b0l2G+Nui3AcuCReghM5jBHsyv06kAOdopVfnJP/YDXNMpT9EH0fZ6FKWvdI1vmJPSvnws06DOvmzT49RyfqpZybX2K6rgM69qTLvpgLUCjD1pBaK0jKQGDu5gNM7itz6jQuZQkoCCg+cK4bEiUAgQ6KzIcZKIpsh9wnzZ50qza7jy1kCh5DsiAxJHR/RBqVPl2IRBNhF/wdZUcnLrc8JCDp/Hw2x5wZJdiiPSxaIXa5h4wWi2mave6ULUkaujOJJHsDUl37YcEq/1L+SOeUwd73aniTQk6NlRj88j5DOncUzDQARrqNJ2p7jMqbKZcoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9iQ6hy+5up+2ukwZEhJi2WiYiogPpDsRrNz7uajO+E=;
 b=lr6OaQEir7VQuthKnqX2FYc8HsKLKN5wK60N/oeMhjpHdl2g80jAtm0HoUYeeqjFyEijCz/zAbBSjvYgHTM0SQw5HbDVWt/X5zonO1vMVmPqrKVY2UnHUmkGFrZzC+udQfo42J6Lz0LfPHD0feCANBCVgdokh2018b2/ta+I8ZI/uohTD99az7UbygkHy6P/h5Wpmg4FQRAAnaCSA4FIerOJhej/fn0ZlEC/bGge4ZWGM5UWLOwfofAORmVayVpC54hNwQzMV6cGnuXbk/GTR+vsuEacvCgltsEeg6RdNvIIGywkPhTA9TUfcw/RFyFshXOzKJcU/+eHuQEx5mmG0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9iQ6hy+5up+2ukwZEhJi2WiYiogPpDsRrNz7uajO+E=;
 b=tY9KfIXkdb7JYS+DdZYLtyc3u8OaVbq3K6XLlDJP4zDCsgxBwem608ksVcJf5ff04aqHiL3KRhyPYdR9gZ6bTgoaZpNnPj2aO+iJZ7Eam4bnKmgcganCJfM3V/wlJx3qmUvaery4g5a1588JHLdxZ9uEa9kVAXKl4wMxYBX3zpI=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3767.eurprd08.prod.outlook.com (2603:10a6:20b:84::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Fri, 10 Jul
 2020 14:40:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.021; Fri, 10 Jul 2020
 14:40:06 +0000
Subject: Re: [PATCH 6/6] block/io: improve loadvm performance
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200709132644.28470-1-den@openvz.org>
 <20200709132644.28470-7-den@openvz.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b5725ffa-60a1-8c15-d8c2-33c47ad11441@virtuozzo.com>
Date: Fri, 10 Jul 2020 17:40:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200709132644.28470-7-den@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0902CA0011.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.189) by
 AM4PR0902CA0011.eurprd09.prod.outlook.com (2603:10a6:200:9b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Fri, 10 Jul 2020 14:40:05 +0000
X-Originating-IP: [185.215.60.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ddcd2d1-eb8a-49bd-a32d-08d824df2367
X-MS-TrafficTypeDiagnostic: AM6PR08MB3767:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3767452CE39F1370E9D1CA14C1650@AM6PR08MB3767.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 87FL4dWfKgShDJMStSpXQbNG5h12joQhAlZEOqCyMgH/iznq77RnS4Kmdl86zpUQS4s69fCWhyWxojViOosjAeJFUEK/1HkqgqpvrP/dn3SiKoC+FKxn+wNYZFGQs1Kmr+CE/5twR6bPXce+pKwmfu6hPf1Rpws1Nr5lISnzrP10L6kGgkYaaI1nbuETU10ZgwLQMfE7OVCQfsU/0OAd6mqF/jeCm97+cS+qL5bl2vkM+jsF6p4fECZGvsaojzMbhYcphm9g0cRXmpYN9eNYAN75SzLINxiOD/SZBDWIRMSgFLbABroe8MKLtMQoiYv3vJHeFqwwV2L02PmtWTs4Ey44uPF6BHr0Xn0TG7uq7XIgAhRTenozqhLhtx7jl8Wj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(39840400004)(376002)(136003)(5660300002)(54906003)(316002)(4744005)(6486002)(66556008)(66476007)(83380400001)(16576012)(66946007)(186003)(16526019)(26005)(8936002)(36756003)(86362001)(2616005)(956004)(31696002)(2906002)(52116002)(31686004)(4326008)(107886003)(8676002)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: f2eDkpsK73LNQM4ojyqv91Awaf9Pv9adT6ZKpwih0ZEhd4oOGQ3Dn+YjGhdk+PD+2mxZW1ZTi7x/NavMfvYWahQRYGTRBHxHT8Pqd+chQNvgQ4dMGx+wEXwWd8WNBa4PZbvt+3x/P6KuLiy5he4QWmNAhh6wnJ3YSNjzGHLRXGKCHSZz8IL6hkRiZKcIUk6TSgog2EvxygaoKUs4OH4mPU1w2g6kI9d8uvrSILrwStyGDY6vspL23j7RF0lqsF4m5CmI7FqbmU6lESblH7hkEoXhHgZwQGPv+ScBcu402BTzCq2rV9H9r7aKC+7XvMFqZ2uGurj4BjXKjbx1cW6USAa6QvJraRiJ6J2NflfV1iKsGwfjTAqO8MTXg33cjhiaqojYDyp8WMEkNGkLzwHfWi2mbnh1FLqxfKJ9dHw1w5ZvmbmzuQHHsliBDUzQiecozey9UtNZtbEi3OVrYETZubL/yQ/Wd2xJs5cPjXArV1V1ZmOmQtMrv9Ugb+k42tez
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddcd2d1-eb8a-49bd-a32d-08d824df2367
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 14:40:06.4481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fi4tDJ8A0ox1Zp3pYZ1ltJPzAoUwOVZl/3OB8sf+VTThCuos0YGQ4s8gQ7TGj0j+QmMeai1+jUuuAbjqxjMGqRrK1SArgBticCADoZGTM7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3767
Received-SPF: pass client-ip=40.107.22.129;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 10:40:07
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

09.07.2020 16:26, Denis V. Lunev wrote:
> This patch creates intermediate buffer for reading from block driver
> state and performs read-ahead to this buffer. Snapshot code performs
> reads sequentially and thus we know what offsets will be required
> and when they will become not needed.
> 
> Results are fantastic. Switch to snapshot times of 2GB Fedora 31 VM
> over NVME storage are the following:
>                  original     fixed
> cached:          1.84s       1.16s
> non-cached:     12.74s       1.27s
> 
> The difference over HDD would be more significant:)
> 
> Signed-off-by: Denis V. Lunev<den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>
> CC: Kevin Wolf<kwolf@redhat.com>
> CC: Max Reitz<mreitz@redhat.com>
> CC: Stefan Hajnoczi<stefanha@redhat.com>
> CC: Fam Zheng<fam@euphon.net>
> CC: Juan Quintela<quintela@redhat.com>
> CC: Denis Plotnikov<dplotnikov@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

