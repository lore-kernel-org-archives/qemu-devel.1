Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0485FC54FCF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:11:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C73BF2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fU0NSvSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73BF2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGgWh-0008Us-WC
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 06:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <den@virtuozzo.com>) id 1jGgU9-0004I5-1w
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1jGgU7-0003aE-RB
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:08:36 -0400
Received: from mail-vi1eur05on20728.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::728]:7424
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>)
 id 1jGgU7-0003Ze-Iv; Tue, 24 Mar 2020 06:08:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a20xwMubkBa38gies1pvwTb8XeiH1gWqhAXnhTw2N6qRVMkwzGZrvt0xy2ebvIGfZ0JBzFDkZgwPYegkpo/uxcTfrLc+gTmImOjbOtH5IIqeyZ7OuumE+vxxWqINhQN3gdF4MXhkmr77CeQXNc0u+RvmXyvL0+TLrFWEQHm8iQmk1+dg16ijSGFw716uCibk0UA/E2/g2tL0/qj0IotlRir+dpucgEuSy6/ZBaUiecc5JNWiOlPN7Li5FU13T/WtlRnzpoudIWikEvWChJsUBmzWIWezOhiM6f4WK+kr6GZzhCIW7hXSh2c7exWLeUP441XaXBwZYMb7VhatPVAbPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zitZis/M7kNmpmZXbRK65AyKf++o9o/zXUoXbAm+QMY=;
 b=nyvyWCUJ1hnzyb3FTytIc3Sh3pFvDrEm7P5tHxI4y3/OnJBoNxKQwTgb9mTXRJI0xb9ohRPNPNJf5c4cLtGlIm6yvXSYqYneFsDOxxCw7V3uP25IP9RDQZb8xDvSo5/D4UCaWzUsVCnnBjWIx+/+Gphjc2amV7XQPGzosAYpwCbmc95Q4uytrKLZwXjT6skH7kMeZNUUbYS7MzuyYk0S/eKRqAZCdJKjFBxkqYKs9ruMOWaPCViKiDwM3krTUTg6TpdjmMXGKfE6RV9AMOyveKuYUfqKBXqQA9Eb+URP0rDadwJQJvMfSdhAUP+ZY0Nvc4WIQQZlJflzq5XJmmysDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zitZis/M7kNmpmZXbRK65AyKf++o9o/zXUoXbAm+QMY=;
 b=fU0NSvSOKl0I91PzdnAUM2nz+gA9iesW2zYsDltDhwHck7jeAIymYHFTbgOy4INf6zWqazgbYPnPdUh7KOwRXCCoslKCzX8gX9/VbMS8hTIilocJftltz7v7CH74hQzIfRtqh3GtV2DY+kuBkP7ciwJGXrMiF1f8R5XcBCxMPtA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
Received: from AM0PR08MB5268.eurprd08.prod.outlook.com (20.179.39.157) by
 AM0PR08MB3539.eurprd08.prod.outlook.com (20.177.110.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Tue, 24 Mar 2020 10:08:33 +0000
Received: from AM0PR08MB5268.eurprd08.prod.outlook.com
 ([fe80::20c6:8b78:b40c:283e]) by AM0PR08MB5268.eurprd08.prod.outlook.com
 ([fe80::20c6:8b78:b40c:283e%5]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 10:08:33 +0000
Subject: Re: [PATCH] iotests: drop group file
To: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20200324074156.5330-1-vsementsov@virtuozzo.com>
 <20200324093629.GC5417@linux.fritz.box>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <9b6a3da4-1109-171d-2a16-30901bc5f245@openvz.org>
Date: Tue, 24 Mar 2020 13:08:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200324093629.GC5417@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0038.eurprd02.prod.outlook.com
 (2603:10a6:208:d2::15) To AM0PR08MB5268.eurprd08.prod.outlook.com
 (2603:10a6:208:155::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.45] (31.148.204.195) by
 AM0PR02CA0038.eurprd02.prod.outlook.com (2603:10a6:208:d2::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20 via Frontend Transport; Tue, 24 Mar 2020 10:08:32 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf8f7937-e9e3-473f-4a84-08d7cfdb4f31
X-MS-TrafficTypeDiagnostic: AM0PR08MB3539:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB35391AE5C3BD291B3974129EB6F10@AM0PR08MB3539.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(39850400004)(366004)(136003)(396003)(376002)(36756003)(31696002)(4326008)(53546011)(478600001)(52116002)(66476007)(66946007)(66556008)(110136005)(16576012)(316002)(2616005)(956004)(42882007)(186003)(31686004)(16526019)(26005)(8676002)(81156014)(81166006)(8936002)(5660300002)(2906002)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3539;
 H:AM0PR08MB5268.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pGpMIqiCjfUHn8P9nZ3+rlGLjYR+fD8PhhrL4bwMv/Kb5kQYDyy90ZtiSeox3ALSFl6vqqA6tArytmcrH7bFFxTjQ/XdPD1HVFZZKRBu8kEX5pvETnHbeFjoXyQ16PrSy1MIsJr99oy3QRcOIriGm/iUFTjHxU2yvsUOAZnwvcLO7+jcGRPlSdF6qEw8snqmoixwFFHi0+8Me0YhN79ElAylp+QIUrwdY6b7UhrswsGz5ngL5y6UwBX38KHTiqg/c4c445OxxKkdCgx/SVZZWtECu3ib692//vILqzYvCLV1E0ClLp7Z4pvWGu6gUjE5RutFU3rIu/esVDd/ziUaNY4ULX2O5nQvtVJYRdm9iCDGcLwzZnJYd1PF3W6tDn9zjHd70KnY0T+f79cGMgkHrvC6utF4X0T3iiD3Me9QHIQOYRm/7k8mrsF0/vulGs07
X-MS-Exchange-AntiSpam-MessageData: GI7hL7ojhu370IAdYhYIgy92y/W7yCbp+GqAEwFtDyVk1KiH6RoOMMnAgBxOdhUbiigUWAgh84LMQNymE2VmqbEpqIEmGGL1b5BoXKs5XNuccf1wow2jELSh4Vng2HUpifo5WJJ7BuBNWPSh0iDWzA==
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8f7937-e9e3-473f-4a84-08d7cfdb4f31
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 10:08:33.1121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTbKoRPjkazkt0a88SKpFKjGCOFwEwoYsbkn9aJE017FvAM9esEABZWbm+S/A82hVt48tiHPcl2L97ELAmIQog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3539
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:7d00::728
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/24/20 12:36 PM, Kevin Wolf wrote:
> Am 24.03.2020 um 08:41 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> When sending iotests to upstream or do patch porting from one branch
>> to another we very often have to resolve conflicts in group file, as
>> many absolutely independent features are intersecting by this file.
>> These conflicts are simple, but imagine how much time we all have
>> already spent on resolving them? Let's finally get rid of group file.
>>
>> This patch transposes group info: instead of collecting it in one file,
>> let each test define its groups by itself.
>>
>> Several steps are done to achive it:
>>
>> 1. Define groups in test files automatically:
>>
>>     grep '^[0-9]\{3\} ' group | while read line; do
>>         file=$(awk '{print $1}' <<< "$line");
>>         groups=$(sed -e 's/^... //' <<< "$line");
>>         awk "NR==2{print \"# group: $groups\"}1" $file > tmp;
>>         cat tmp > $file;
>>     done
>>
>> 2. Copy groups documentation into docs/devel/testing.rst, which already
>>    has a section about iotests.
>>
>> 3. Modify check script to work without group file.
>>
>>    Here is a logic change: before, even if test do not belong to any
>>    group (only iotest 142 currently) it should be defined in group
>>    file. Now, test is not forced to define any group. Instead check
>>    considers all files with names matching [0-9][0-9][0-9] as tests.
> This has both a positive and a negative effect: Now you don't have to
> modify another file when you add a new test, but it will be picked up
> automatically. However, if you want to disable a test, you could
> previously just remove it from groups (or comment it out), and now you
> have to delete the test instead.
>
> Downstream, I think we still disable a few tests because we're compiling
> out features that are required for some tests to pass, and deleting the
> test cases completely would probably move conflicts just to a different
> place.
>
> So I think we need a method to distuingish an enabled test that is in no
> group from a disabled test.
+1 for blacklist.local file

>
>>    check script is also refactored to make it simple to do next cool
>>    thing about iotests: allow meaningful names for test-case files.
> This one would also require us to be able to distinguish test case files
> from arbitrary other files.
>
>> -#
>> -# test-group association ... one line per test
>> -#
>> -001 rw auto quick
>> -002 rw auto quick
>> -003 rw auto
>> -004 rw auto quick
>> -005 img auto quick
>> -# 006 was removed, do not reuse
> We lose these comments without a replacement. I wonder whether it's
> important or if we can think of another way to make sure that numbers
> aren't reused. (I'm not completely sure any more why we decided that we
> don't want to reuse numbers. Maybe because of backports?)
we could generate this file with a starter script with proper
option.

Den

