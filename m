Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD148C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7724E20644
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="imFPyvdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7724E20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT2Md-00088V-Du
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 07:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT2LO-0006Eo-Mg
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:54:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT2LO-0005AH-Ai
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:54:38 -0400
Received: from mail-am6eur05on2096.outbound.protection.outlook.com
 ([40.107.22.96]:65428 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jT2LK-00059Q-Ch; Mon, 27 Apr 2020 07:54:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjWOPvg0C99ylIv3xjF98W9rMH3r6E4m8aKUAsOGZ5np4zwLJE7WwwmD1MG2LLH5tJsdK/p1gu5IcjJNRGjzNOT1xjr6XVsR4vv74uEcjWbJta/AaCK3ZMAy1nV8TLDm9YeIdge4zFjFFw6WqUm8svGnquGMQCeyVUIQq3baLl+JA0VnS83WD26C0agJj0ekb4z5tL/O2/efUCg2JZmvd1XG6JP67cUgF8D3JFPmq6zSimZ6S9v3kUz/YU9vKnwALhNi5P/UrJYy+TTDXWRI1CHHCmGMzYcw5W/YUpgo68wQYazJ63a9gWTalJ0VUCu+5A/e8deF0BAlC20SlYeonA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AW7urXKN3rYaDTJ4iTUmWDBMYOGW5c29HG7cVdj8mok=;
 b=TjvFmRS4gTcme9S7HyOKDWijRPNT7uwZvntzefCx2fyZr1cVBo/5R3LwXOItBgJ3P9cGT5TvLz1GokG/vmv3lZmM7JJzySRoUjAzQob8V4SOGg6pdg6HWaxyS14MOuitYw0fFTh+vA9SOrZqz/JM+xoRpy/mluS3gXx+2txSGuEhR9eFMsjrdMDVwwePdc6lWJCrCpu6ibq7UwPdDlz+oq8FNyXPv2GVHTz5lndmPt7jePmlqMQ97ILMKsFM8kUf3yUt4F/N7CnrvTfuW/mvHsrpQg7isbgIRF+4HDRte1eEUci8zrMSjWQPq1x0D/x9rvaL/LyTHPnaDWn+ivwZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AW7urXKN3rYaDTJ4iTUmWDBMYOGW5c29HG7cVdj8mok=;
 b=imFPyvdo0+FSvHuo4oaJJ9l1NwAoQccCaIp3Rabr4IzW/mrN6mSEKwrPc0+pY8qkubXNKgAy6g4HH+/5GHOOMRM/NjxzoIU8KH9AezvLqPTDqoNth2WizxeSGyfPsemq9j7T0GM+ppmeGAsv3M4N1qU7tENQ577/bGZb6gmPXz4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5319.eurprd08.prod.outlook.com (2603:10a6:20b:dc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 11:54:31 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 11:54:31 +0000
Subject: Re: [PATCH v4 25/30] qcow2: Add subcluster support to
 handle_alloc_space()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <7346b6242cb3589cf946314db445edc9250bd3e7.1584468723.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200427145429268
Message-ID: <a12c2c2b-eb02-f299-4321-74236b2cf8da@virtuozzo.com>
Date: Mon, 27 Apr 2020 14:54:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <7346b6242cb3589cf946314db445edc9250bd3e7.1584468723.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0009.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::19) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.182) by
 AM0P190CA0009.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 11:54:30 +0000
X-Tagtoolbar-Keys: D20200427145429268
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dce6167-a014-4bdd-bbe4-08d7eaa1bede
X-MS-TrafficTypeDiagnostic: AM7PR08MB5319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB531912B7414AEE0A39AF8AE8C1AF0@AM7PR08MB5319.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39840400004)(376002)(136003)(346002)(6486002)(107886003)(8676002)(81156014)(8936002)(2616005)(4326008)(52116002)(36756003)(26005)(2906002)(4744005)(956004)(16526019)(5660300002)(66946007)(478600001)(86362001)(66556008)(31696002)(54906003)(316002)(66476007)(16576012)(31686004)(186003);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zoNqBAxRCTmg8cJbdQuOWtotkx7FKYueGzfagvu8RZi6pkqbRMcStCSyUwaeMWK6UHFyhru7LEWn4E4nFqo03aqZxFuS5B+3WbDOdA2epSynxiKU9wcH1csU64jY6krzvKdlzm6ZAuFaKSU0+Lvo145DK60v6LZjew/Kz1tmF2XAzFJ+4NDKc/4KrPu63qZxOfyA6mIY9cc4bA+xBZZuuc+ELaw9flTl+DCSItC2oWGw9tElG7GgJoGOmntnEKyhl7dI8tPpzxNAEMzd/tIAU9+07mNAPWFiEnXAc6/ZQN50Bxo9YtADfWrz3b6c4uhO1R6PwwmRqA08AsxTLxPemJ9VVem13tS9pDJ254oJbamEaLfWWquZ9mVxGvuf+Y+RSkkyIoAhVWueSj0TV7Yo9mvTViBxjb6EpIqoli3lzDyUOR4dX19U4U1rVpZnKPYe
X-MS-Exchange-AntiSpam-MessageData: dRxGyHzkSFQR89UaprI2Mulk4y0YIXs/RYBwc2NJk9N9fDqx6NDbPOYFm/cP6YE2XS0KFUi3+AF6E/3+dtQ7+XsD0wrSr2jtbxYXBrvQBiidMS6kw9rSWwM55m7XB1u/IQAg/Z/V5/3tUcyy9sQQUjK8Aqfl2wmKdLqZ3Xss7nvIArhd4uWdT/8Vl7vB8rbUYGirxcjMU2jHxQ2m9pjnfboc2fGcn6yFWTtUEQDYT9nYr+46R3Mk2ATf8zMmBtVlKVl0V4PY7RQ2Y9fTDZ85Jg9SqA7mUkyCnaOBOTQusTnPYN3Ipk+gM75rRbegnK2zM0zp2f8vIuR3eweLdal3cMWktTywRNHVVFpBizjdFTpTGY7rsKF8wyBO1zDJUAg7ifwipm+5xUPnW9Vj+2bV/Ht+WLJ3PkQOowg/4fgfrMGUaYA6nL62oAM837YVAQCdQyKWaRo0ftaeotF002+GFRB+i/9gLtged1wpDs2/uF/awLksozbMozB3cn+JvbuH6cAx52lQeBC4cV6rfRYW/RiqNU76kQKysKiUW0j4v64KKAI8iAHEDVESfQRbnNsF4SbpHlquwzHyDO/9PnIMS4Ef27YasYNMB2ornQq+CW77KpdQnH/5x48ySHE+1fKH4zrBXmy35VUbfW+epp/yeZoMuvV69l7umpbRxauyZN2TVyo7gS0iYtJZtu3iMmPjVyP5Yyp55eM72vU2cjCMRgZI5JjdpWkq35u3IJyXmF8Wn+r20cYAR4tbueKy7MN1ZhQqBv/tqcDlaxTClXRcW2IMF5i+GS8BFM3fLYT31e8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dce6167-a014-4bdd-bbe4-08d7eaa1bede
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 11:54:31.1008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9z97er2/rqkK4xuaf/gOL3jD3WsGesQCSIxbhgaZyJIzo8+D0OMQITsM14pLG0QbfQfJNtXQWErrXHEYUrjLw7B+gtKIkn9trwvTXxOZ0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5319
Received-SPF: pass client-ip=40.107.22.96;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 07:54:31
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.22.96
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.03.2020 21:16, Alberto Garcia wrote:
> The bdrv_co_pwrite_zeroes() call here fills complete clusters with
> zeroes, but it can happen that some subclusters are not part of the
> write request or the copy-on-write. This patch makes sure that only
> the affected subclusters are overwritten.
> 
> A potential improvement would be to also fill with zeroes the other
> subclusters if we can guarantee that we are not overwriting existing
> data. However this would waste more disk space, so we should first
> evaluate if it's really worth doing.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

