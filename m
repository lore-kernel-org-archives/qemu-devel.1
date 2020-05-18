Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5B7C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:36:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A78020671
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="E4BcrohE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A78020671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jajgO-0006yo-CZ
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 13:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jaje8-0003nI-Ct; Mon, 18 May 2020 13:33:48 -0400
Received: from mail-eopbgr60097.outbound.protection.outlook.com
 ([40.107.6.97]:6018 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jaje5-0003tB-2b; Mon, 18 May 2020 13:33:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvSvo4NZeBnBV5DqQJLN4aSMiXzkWKpTlV70TMJxHPTQXEWoOU8Q9Dc+iG8XpyhgEB09TqDjdVIOvCy5WPQJMhKmDaP7VyM4N4vY192NNZgwNZ2TeyNQFB2kPl18s2zEac1v17QfRPqTiCkd+A4H48r8uTd8mfRu4P+Fe6M76L36pyHZ1gQgn4/xFBb+NMXKrAwHfaJlXDZuy693V8LhHTJdU6FdD1ctcWrbO6JIw+/+fnJuZ9pqMyChuhnlx4/Ok8vbZaEHpclh37Lo/63HLhvd5UXYyzmjMAnXqg9OJX8HNBsunc6dQT0G60zql1r7WESmPhOg6mtxfLr7J48z2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A2nw0onGuWmOSkuPkrIdRoaoQ/dYTAF1c0sy8LUW3Y=;
 b=mbXUy02SdmJKYxYwl2d8X/n+Ft+685du/YZAyBdu5slBWlMV3z3qGu3EC18AycWFe9N5CV1eMcLoBarFnKiHiCdw8RBeYePiHv8KYpVhb4UyqQhBt5/8dCU8VgSjTPAZr9rbuOi8UoieGJii33ZKEQrkTrUrBjWErae45P/bbUQko9KE52SN4L1a7TwQ6+j1y0YhUkJXHEtTFC2JPtyRxwaIYESllBqQsxowqrv25uDZvycYmHsT6x/odoO9/yZgDo/jb4l4AHsdQf60dDMeDW6JXbp++hoV+C0ST3D0MbGk6M0a/ewuEdb2QhmBrwA+PNnGLq/vB59NnDHZ+BB5CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A2nw0onGuWmOSkuPkrIdRoaoQ/dYTAF1c0sy8LUW3Y=;
 b=E4BcrohEBgaiPAb95Xt9dyzF9dvRyn5Q6fecjLYZw1xDnU6dpbMcpHda+OBSNZUJUAb01zUIIJe+gNiuTKpH3SL04VhOU7HEKOIwkI42Ok+Ak0LjkM9gl9j5VUjsXkeVqJkRT4wneNAfjSchqYMNNTyTk9LA3UXI7HLvnl0LEaY=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB4239.eurprd08.prod.outlook.com (2603:10a6:803:fd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Mon, 18 May
 2020 17:33:41 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%7]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 17:33:41 +0000
Subject: Re: [PATCH v4 9/9] iotests: rename and move 169 and 199 tests
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
References: <20200515211505.3042-1-vsementsov@virtuozzo.com>
 <20200515211505.3042-10-vsementsov@virtuozzo.com>
 <6ad020e7-ed54-5bc8-0c70-9776dab903ac@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d0194c87-1689-2b44-a696-19078f1efa3f@virtuozzo.com>
Date: Mon, 18 May 2020 20:33:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <6ad020e7-ed54-5bc8-0c70-9776dab903ac@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0005.eurprd04.prod.outlook.com
 (2603:10a6:208:122::18) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.187) by
 AM0PR04CA0005.eurprd04.prod.outlook.com (2603:10a6:208:122::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Mon, 18 May 2020 17:33:40 +0000
X-Originating-IP: [185.215.60.187]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86e18482-b2f1-41aa-0cc7-08d7fb519b69
X-MS-TrafficTypeDiagnostic: VI1PR08MB4239:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB423920F3134A56DFEBA841EAC1B80@VI1PR08MB4239.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRh63nkkxG5MNYuh6u4ZcoK65k+Q6iut1Zx/QiZ0ArPV7TuIBkdGh2jZh5tdFwKzG2qvsnsBFbUh7TQvk2BNkQSbbWl+mvNLYnk3Cq+zWtNagGHFndU/HTZfZgDFxmFSfAu2LM+kjWVHtQFAeMT4XOvhfqFQI9fS8ZP8sw2IrqZ3pYOCfVQy2yoT5/KdBkLerRL9cMZpvQDiKGe6k4OxOZrnkbm61iiq1hmXaBPQ0+vUaVlVSo1CdTQYFvP+3smS1McKoEC+gjD994sYWi3U9wtFV1mcrmyuONdD5NgLl0dQ3bHI2XRidJefxEb3IqgpWkROnmC0oP2VjpWz9JLUlWIUc7uGmeaONr47w/2fC3XvMVXQ2q76Ve7bPpUBXghGqxJcCLhvArbw3D0NGQQGRZoig2CmEUxAT8fXX9ZWbmdRI+4V+r3+51boKYmTS/GnWRN9WkD2PCbXZdfzIoNhPJodMM2GFKNgEgKC9/iPTvQ9ApLSfJnSmK3QS+IOj4p9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39840400004)(136003)(376002)(366004)(346002)(5660300002)(6486002)(316002)(478600001)(31696002)(31686004)(16576012)(4326008)(956004)(16526019)(2616005)(2906002)(186003)(86362001)(6666004)(52116002)(26005)(8676002)(36756003)(66476007)(8936002)(107886003)(66946007)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: pRKzpA80vlgr7FDz0sp9GgSIJHUavicA2UCALa84r2uqWV+o//j5AmdmCPgDtv42RDBwcsyH93CzxG6S/U6lF3w59llprRkdeF0uey2ENdnki5fICi6i0HdWynghgKWlmu4kYVCxcljhRjo9gh7faOf/T7iBAqCBvpMP+Ej/fiA/fEQMoc7Y/gSruvYp7M5UHDDP2sOQp/sZdFGjRbHYXJPWbSp92hEwbcRuiFZUpxKaDb2hBir+VC31DCSj5eDUS+b6T4SW0FksEK683iyjfa9zGpRauEfEk7YMlsYr3jZgQdw90lMPvQ7xSXP2IK0h0+g8V8YYuW6NmxYXbr+N6IDKs7kdfZDLjlxLNsnfsgOlkAZzZYIpV2XddtWkAO7mf/hotpeErjyOyJz4E6k6xJvUWeoCh8SDGJA7VpzlxOjaYdR9HUL5eSwZgG7nBEhJPdDwIWz0zgHJQfVaUg0sRnj5HzjLg/tcqe3QdGSF89XshZZEy/YSuCHESU+2MLGC
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e18482-b2f1-41aa-0cc7-08d7fb519b69
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 17:33:41.5894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3r2zZoq31v6Mox0nWRS1OnufJzVRs3UWJBEn9mAVURKcxvVqoM5+x106jf5iG8A9Sj8lEdqFoFtdWKBbXzrIBLrnvq4QXfnpgsPaID7jvFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4239
Received-SPF: pass client-ip=40.107.6.97;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 13:33:42
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

18.05.2020 19:12, Thomas Huth wrote:
> On 15/05/2020 23.15, Vladimir Sementsov-Ogievskiy wrote:
>> Rename bitmaps migration tests and move them to tests subdirectory to
>> demonstrate new human-friendly test naming.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/{199 => tests/migrate-bitmaps-postcopy-test}   | 0
>>   .../{199.out => tests/migrate-bitmaps-postcopy-test.out}          | 0
>>   tests/qemu-iotests/{169 => tests/migrate-bitmaps-test}            | 0
>>   tests/qemu-iotests/{169.out => tests/migrate-bitmaps-test.out}    | 0
>>   4 files changed, 0 insertions(+), 0 deletions(-)
>>   rename tests/qemu-iotests/{199 => tests/migrate-bitmaps-postcopy-test} (100%)
>>   rename tests/qemu-iotests/{199.out => tests/migrate-bitmaps-postcopy-test.out} (100%)
>>   rename tests/qemu-iotests/{169 => tests/migrate-bitmaps-test} (100%)
>>   rename tests/qemu-iotests/{169.out => tests/migrate-bitmaps-test.out} (100%)
>>
>> diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
>> similarity index 100%
>> rename from tests/qemu-iotests/199
>> rename to tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
>> diff --git a/tests/qemu-iotests/199.out b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test.out
>> similarity index 100%
>> rename from tests/qemu-iotests/199.out
>> rename to tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test.out
>> diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/tests/migrate-bitmaps-test
>> similarity index 100%
>> rename from tests/qemu-iotests/169
>> rename to tests/qemu-iotests/tests/migrate-bitmaps-test
>> diff --git a/tests/qemu-iotests/169.out b/tests/qemu-iotests/tests/migrate-bitmaps-test.out
>> similarity index 100%
>> rename from tests/qemu-iotests/169.out
>> rename to tests/qemu-iotests/tests/migrate-bitmaps-test.out
> 
> I like the idea ... but the path name + file names get now quite long.
> While you're at it, what about renaming the "qemu-iotests" directory to
> just "iotests" or even just "io" now?

I'm for, and I remember, someone else already said about it. OK, I'll add a patch if send a next version.


-- 
Best regards,
Vladimir

