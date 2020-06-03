Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D95C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9314A207DA
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="D3uUqYat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9314A207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgOhw-0000js-TT
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 04:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgOhH-0000FW-2x; Wed, 03 Jun 2020 04:24:27 -0400
Received: from mail-eopbgr130123.outbound.protection.outlook.com
 ([40.107.13.123]:48886 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgOhE-0002p7-TI; Wed, 03 Jun 2020 04:24:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wsyv/faB0LZM0+xKMLKF5h0YZZIhR0XEWa/QesqO//a77tr4eYrdAKVHmUs+2wRgnKXD4SEKpMwySfC7pCXRgcW9vfeeq6IWQk2ISztEdkC78jTVc6pJGZmJcg/7gZSZ0p6qhF+sXvXYmF+hF5b3HyjJRqq3fuZ+RJb0eU6eT9U7gymQDtYqulFz5wCPEr0y4QRDV2aIFlsSDswkEy9Oa5sdoCBY5bzbQgMetoYaSHm5fUeHooK7EEshJm6EYBLckuMG4F2nXFTjnJ1eY4kbqpJzb7BtHZkU/f6NrOTtCmf2PThl5rU7x9fCznhpxQVRFH/eAimPTbraWqE+3fJ9lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcvl3sGucMhRIkgVywEGHUGBqb/lJGRzyUF2B1wRhbM=;
 b=N0iqN2gpbXcYAbATrg5KekMr34LKOVaomKrGiaXE8BiKIjX6p+ORRppGocVTmaUOBPv/sf1Ke98Rxuqv9jKZGWIypJoQF/D1eViq3PXSL8Kv7DyVFZd9pgCet3V2+XJwd/1HTKnekWfSJ0RZPH+K7eJ9rYWCJuYoLthwtfQ+nmo8oLMMzcJsyLYH9DspVC0hGHZS/110Sy0vPCv0XwdQWjztcVIheZoNsxXuAVDuQkjOevkXXxKhD9sfWaEBbFKsHMH8t970wDsBYMiOiu8Lai3E3CnoHW75ZgV4u1p54YZcj+6+9bu9bjGiRR9mtZMgxKTT0Xkls4YUksW+50Et5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcvl3sGucMhRIkgVywEGHUGBqb/lJGRzyUF2B1wRhbM=;
 b=D3uUqYat5B2JKd+yDYzjyjG9+V9mmTKYAOA/3qcEVTH7pDO3sCwX/tmZU9H61p5oa1gtPkJXMMRvoyWCG3UVw8PCU80p/GUOxrfj1MSl4pJto1889FTWAciAq/ZQvRsk8+5gTu6vi8x8Y5IPPgKrSZSzd9cSsaU2orVhdvJKnYE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5464.eurprd08.prod.outlook.com (2603:10a6:20b:10a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 08:24:21 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 08:24:21 +0000
Subject: Re: [PATCH v2 00/16] python: add mypy support to python/qemu
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200602214528.12107-1-jsnow@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <12911ee6-68be-b1a3-0a26-07bc5f4b5533@virtuozzo.com>
Date: Wed, 3 Jun 2020 11:24:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200602214528.12107-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0102.eurprd07.prod.outlook.com
 (2603:10a6:207:7::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.188) by
 AM3PR07CA0102.eurprd07.prod.outlook.com (2603:10a6:207:7::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.7 via Frontend Transport; Wed, 3 Jun 2020 08:24:20 +0000
X-Originating-IP: [185.215.60.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17ed1d76-5969-4105-71bd-08d80797843f
X-MS-TrafficTypeDiagnostic: AM7PR08MB5464:
X-Microsoft-Antispam-PRVS: <AM7PR08MB54644DB19C150A850BDDFC2BC1880@AM7PR08MB5464.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUuYB5ClQ4qh7zsdEGFP9025735CPQ+JihLnmhSpUUwspkjPZeOsSht9V9Br3IBBnfXMk/cXqaINE1pARXL8nJBqwlfBDzFubMZ2M/YtfDsAOSQnAiCIBPkcHO60SPz/a0ZqI14sH24Va7iDhAoDqm8se9Wa1j0/8lLjovLoOFVJUZcrWzSbZTeNhgTWVVEtjaUEhTUj/fEbm+jsZuOyvG2SmyzNWMoMTlNLhZRUTTxextC8YHZ3NyG91trvx3+laf1/T9dYWx+y2oZCEgotR7pRhdgnJUQtFYymt3jW/JhfYKa989cmAFAyv7dM9ugQGo1bW1ZPD8XVSw722zIqBTjObwWa0yVk8pVwgimfjMdchGKLh73POFzTCp58Yqdk6V7EFVuwoo04vFmpogOz3BNY81C2gx8IWDS8AmiummfYyEzK2UEQhxg4Kj7WBsD9RJmyqariIFIMpzfkGNInXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39840400004)(136003)(366004)(346002)(376002)(26005)(8936002)(4326008)(36756003)(316002)(8676002)(186003)(558084003)(2906002)(6486002)(956004)(2616005)(16526019)(31686004)(66946007)(478600001)(31696002)(54906003)(66476007)(66556008)(16576012)(966005)(52116002)(5660300002)(86362001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 41fnUcf9f4anuGS1u0wry9KDgpAtlOD+BuHyI3iN6kZ9R9VjzDWm/GvYCyU4VAnI38xv8DifgzoqFGD7N+s4YaLTnYboALhNyqk11K1CoQJDgjrgXSLqHymuyfKUjjS5QhOlcJlSKo+yHVnnMYzSJuG2YzX2Fv+BtJ1U41xkJPoXvVicoegdt6ORs9PoNvObBvf0x3i9DwKL08ZxCNXzIPHrfo23p5Jsrb2kjW3jrwuYSYKwvkxoiruC6TqL0FCNJJk5TB6uVYVTXHsPdqsggaUd+rpMcb6N4K+zneSVXbYNrq8X33Cz8C8B+RJL9mU+/emwZUKv3IoFjZNZ7uqHVmQDy+3xyQk6CPyi3f2xOaDKTqZ8Oi6EaBuAaCf6GR2q5Ps3tJI1I1ZhZhdx6DqCf+Kv1WRsAxh11zICk19sKg4F98F4JU01WPdQFWLmPNEChAoxacvKgkdqfMQdardA0S8+LOZLlkv8BXiPRCw7L1Zv7sVGYvhgbWQZT0yu7kPM
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ed1d76-5969-4105-71bd-08d80797843f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 08:24:21.4884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4cOhS9tavAoks3c/Iowkp4eOywnw6+DS/7m9jlvBSqKq7LSpYCPVL6hhMK3uZyCs5jZg1Z4m6s358Lw/Mr2wqrRUPDmFisFM6cbTUmn6XU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5464
Received-SPF: pass client-ip=40.107.13.123;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 04:24:22
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

03.06.2020 00:45, John Snow wrote:
> Requires: 20200602194844.15258-1-jsnow@redhat.com

Hmm, somehow, I can't find it neither in https://lists.gnu.org/archive/html/qemu-devel/
nor in my thunderbird..

Could you post sequence of your series by subject, or export a git branch?


-- 
Best regards,
Vladimir

