Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5997FC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 14:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27BF920787
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 14:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EVSx+VR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BF920787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jah0a-0007DK-B2
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 10:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jagzk-0006b8-JE; Mon, 18 May 2020 10:43:56 -0400
Received: from mail-eopbgr10123.outbound.protection.outlook.com
 ([40.107.1.123]:37440 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jagzg-0005wj-BR; Mon, 18 May 2020 10:43:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1zb9vRNtF6eELAv+oybpqVD8/byDIRsyIF1sqi98Yv5WaKm0izzG0NJmjIh+KBKxMt06EEQLBvwi9B1tHNN0L75o5JgoVhoso55IPvsHPCI5rCeMpVX+HXcS5eBwFvnMXQw7hbLP9DoWTUQezXZKsuuktEPajoLsKdWU7qY2l7KkP1X/wa3qZ6L1gvmb6E5LA6a3X+4s7P6nB5WRO7jiDCIiBTNP1nFrXG4DP3KRxoFnMJeLlWCpqA9EtKBVjzcbejmkAZNhQZ608FHhgUDhdfidCEDD/5LRCD/N0sBT2tpvIKGiA0vQ/ml9u77EC/KRQICx+tZbiN3X7qvjbrLJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJSjOQ3wXGBLMUdPb7NIXXIn9AgUKATt7LBAbbkFGIY=;
 b=SawtWHmJHLa8b5b9GZ217b+xULAXBpmsc1cbeVEdWNyCxKfPTh4fCx09DeAD3lJ+s0ctWL2HPwOH5kFusWpcgtOaWjB+O+AWrHswbdb41FjRmU9ttZZvfQa17blhh3FJ57DR5BPQT3/mCHm0qfcP9KouvBPD/PTMbfB888H5JyZFCFnKVrjV3JbbSqbUWnCSuDt2XeED9bSs0X0hKSpq8VK8Kb1QQks+wqmZFrLkJuZfeYQ+wNQ18tMWA6O3GCn51gOrC+Wz0MUwuP6HisgXj3TV3anAVhTrVhSJQu1wZzjN/L/lRfBqH4zg96MzPv7Vds9333KcjdT5I8P4LHPjyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJSjOQ3wXGBLMUdPb7NIXXIn9AgUKATt7LBAbbkFGIY=;
 b=EVSx+VR0FMb8bnaVE9lidLX2vltcmT1pxkg7Tl4zHuG+osgEtNSO0oDLaU1EAbuNf51iDCThKDm1crnTTXbuE4KMwoJmHzYZykpmUMgKX7JEee4EfZ5Eh5M19i8xUXrqReJ9yrWxy7U1g7b1Or3CTYRcgqHEDwM3sYIE6G4vqnk=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB3645.eurprd08.prod.outlook.com (2603:10a6:803:84::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 14:43:47 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%7]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 14:43:47 +0000
Subject: Re: [PATCH v4 9/9] iotests: Add test 291 to for qemu-img bitmap
 coverage
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200513011648.166876-1-eblake@redhat.com>
 <20200513011648.166876-10-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2caf6a79-8687-0e1d-e4e7-59fe4992a1b1@virtuozzo.com>
Date: Mon, 18 May 2020 17:43:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200513011648.166876-10-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0029.eurprd04.prod.outlook.com
 (2603:10a6:208:122::42) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.187) by
 AM0PR04CA0029.eurprd04.prod.outlook.com (2603:10a6:208:122::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend
 Transport; Mon, 18 May 2020 14:43:46 +0000
X-Originating-IP: [185.215.60.187]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 581b9258-0b09-4941-0cea-08d7fb39dee8
X-MS-TrafficTypeDiagnostic: VI1PR08MB3645:
X-Microsoft-Antispam-PRVS: <VI1PR08MB3645D63D11E04E78FD4CF37AC1B80@VI1PR08MB3645.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kW59wJ2q87wM6ZppObdtF5EY1eKvhYWMXssIV8uPojIxAGnto69S+geYycQGNbAVSPz8aNTdCSsTjRn6t6gcNDWdKWGTigopE+H8E9mfP76E3jsZStq7Qc7Vo/lKcKcsOxf3f8mX3IGytkAb2lkHaCcdQKZY2po2WAr9Xn05IoQirG7cJsLD4KhAn42u1WSUqDXxMEpYbO89NOQEGvU77QyTmLRY/S3/S0PjFhUm7QYPppcYADxJ7hqalUNZA5CxDeRf0TFx4u0r3Ft0AYF5UWpHpYTGAK2mknXVwjZGaZXmR4/mnrWIWHqWU//y5RJ0KqQO5ovfD7DiIOCsV1RbkIBE9CLHLFhjhG9MBKkstb6w7mJJ359zadcM+sn9xYIkGMEMNoA+xEp26rqWGPL6RKtgUCsz4ewVcm39kimdSwhBroiOVzXEuHdPw09w6tIZnu41jZTS5As36csROT5m3r5yPip2aprSfpzzvoS5AhP28lEcQP5e/Mwwt06S1bPq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39840400004)(346002)(136003)(396003)(366004)(2906002)(26005)(5660300002)(186003)(16526019)(4326008)(478600001)(16576012)(8676002)(956004)(8936002)(36756003)(52116002)(2616005)(6486002)(66476007)(86362001)(316002)(31696002)(66556008)(31686004)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: igC0ySfQWqItrWhOhV96nrD80WApfALy5CEjgLTNN6p1ln9Hib/HwsWsgsg6OxmdyDlTCDcrpVXqWJIE6MQDW4oIqTlE46nKiTiTv/sNAf2aGY9TEtn48TZ8dSjbVwqlxxea9wE0hWeTBQ/bzuCPRib4CKv210dm6ncbHNfIEqtij2XIsxF9jYoYZcePXwm6JsLMUt7ErL8JGGuAuxFt8kno+qlT5i1xbcXdVgiyycHihXx5DS6Zns+9dCrJ0t5JqKIIQF63+hmbz7qIAXqnUOfK+MQofn6DtrmeIvcVmz8IG3e+mUhEbaL0ygBLhW4Y5FSU3x7nIrU+fqUMOIRkWto5hlVeNYI6z552oofcMOLpmmKOBW0lPM8IbqvdTk/p8Bp88qCWekkTVqTV+Xu4b2dq5StLZM0K2lkkRG3Uzs2m1m0z58LYMNTpE334Ngm56gxPWr1T9FsUiOwDJYZDmTDEDb07Uh8SZl06yvtvIvax1xi9bXZfgfSLlhnBqYM3
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581b9258-0b09-4941-0cea-08d7fb39dee8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 14:43:46.9971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lS7lYLBJtXia5xBWTae+GnwsRvjSvMbHWnMNz4eTwyaayl/Wwu7QK+GEahdrdEsiWvQfZARe17yKVWKpgYZeSZmYHk80qRPBtz1uTEFhscc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3645
Received-SPF: pass client-ip=40.107.1.123;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 10:43:48
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.05.2020 04:16, Eric Blake wrote:
> Add a new test covering the 'qemu-img bitmap' subcommand, as well as
> 'qemu-img convert --bitmaps', both added in recent patches.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---
>   tests/qemu-iotests/291     | 112 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/291.out |  78 ++++++++++++++++++++++++++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 191 insertions(+)
>   create mode 100755 tests/qemu-iotests/291
>   create mode 100644 tests/qemu-iotests/291.out
> 
> diff --git a/tests/qemu-iotests/291 b/tests/qemu-iotests/291
> new file mode 100755
> index 000000000000..3ca83b9cd1f7
> --- /dev/null
> +++ b/tests/qemu-iotests/291
> @@ -0,0 +1,112 @@
> +#!/usr/bin/env bash
> +#
> +# Test qemu-img bitmap handling

[..]

> +TEST_IMG="$TEST_IMG.base" _make_test_img 10M
> +$QEMU_IMG bitmap --add -f $IMGFMT "$TEST_IMG.base" b0
> +$QEMU_IO -c 'w 3M 1M' -f $IMGFMT "$TEST_IMG.base" | _filter_qemu_io

Actually '-f $IMGFMT' option is already inside $QEMU_IO. Still it's a kind of standard for iotests to duplicate -f option, so I don't care. I hope one day we'll restrict it in qemu-io interface :)

-- 
Best regards,
Vladimir

