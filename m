Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA63FC4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:04:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83E3920775
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wBqphi41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E3920775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGgQX-0006yg-I8
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 06:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGgOA-0004i2-AO
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:02:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGgO7-0000DL-Ra
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:02:25 -0400
Received: from mail-eopbgr150108.outbound.protection.outlook.com
 ([40.107.15.108]:31488 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jGgO7-0000CN-68; Tue, 24 Mar 2020 06:02:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1sn0IU3WHNboqjiOnhxDWy+AwSDGcU/VSFlnSLinzwhD/BiL0BrYcgIucyZHb+emP9J4c1eS9A7PZaZno3/rMDM8bE88mbClkqBzGvDVmvGYeIQSOaAQsc0hgYuAXLq5SmKuZwEqE8yPNwR84ZyJVY0YV1mDylwl9cuZIgai7IZq9QDobSAP51HQKFt7HwgfQxnXWrv0vHLae/nr2GN8m/kbNufDjtwsikjjJQ6zXyhG4J/fmngC0TxQoskUzLCHerMSqZOOKCKY1/6KC6I+7l3bOLVMo3L0Adlcb7kVIW9KpCV5POvzhUudTcHrkURYytG/+lajKa8orfrvRtYZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ml6yFJs+5/v5cUpfvne3PRbzVZKkqGgHWfIqU+T5QxQ=;
 b=BQG5g8PZdKSpC18mEeFmy4kPVAzqzaGD/M7SLTbrVKHYk3WRh6JFCQlJ9AlPJ/SVRa7C6mCrHU6YuTj/fKIv0OX+RIKvu/1j/DiTgMQKglcLeMubaZ2oZHcmNOkIlCQLp2znESTJKn9slpNG4/HzhCQ2MtJpgYJ76mx2pJQ57oD9JUCxDH+UKZHTpnYKwIkc2d1tT0gZBtsClIsswRgnCQxeSPw7IGlDeb/cZc8rZE0zQmZwRiWTEhemF4ILuudWd6sGfVkAHumT0/EfF1eMHbbYbW7gzc0rErNlhOTOuroXVvs4zeI2AbYqOZITMKg6hO10V9KSrH+4AagkILHIIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ml6yFJs+5/v5cUpfvne3PRbzVZKkqGgHWfIqU+T5QxQ=;
 b=wBqphi41nsITQlH4aqYYk6ofYPxEzKM3Ew4Cs8pQ8GoD11d2lTBIBQ9LsCGNw+ZUlxOV0fA6gJFF7llJna7rijEuzwMhte4sWR/+Tyu6gsJ6yiBJr+SRZmaXke6wo1KcU0faJcSTju9IQ0XAMqxIveYd8NJ7GxtMmhCxClNKFDI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5320.eurprd08.prod.outlook.com (10.141.171.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Tue, 24 Mar 2020 10:02:21 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 10:02:21 +0000
Subject: Re: [PATCH] iotests: drop group file
To: Kevin Wolf <kwolf@redhat.com>
References: <20200324074156.5330-1-vsementsov@virtuozzo.com>
 <20200324093629.GC5417@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200324130218371
Message-ID: <9ef27fe0-ef6e-ede7-7d8e-bc5331cd907e@virtuozzo.com>
Date: Tue, 24 Mar 2020 13:02:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200324093629.GC5417@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P189CA0019.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::32)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.15) by
 HE1P189CA0019.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.15 via Frontend Transport; Tue, 24 Mar 2020 10:02:20 +0000
X-Tagtoolbar-Keys: D20200324130218371
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a347f6e-7bca-448d-d3a0-08d7cfda7165
X-MS-TrafficTypeDiagnostic: AM7PR08MB5320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53202E27C3F4A57F2E506D58C1F10@AM7PR08MB5320.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(39850400004)(346002)(366004)(376002)(136003)(6916009)(16576012)(2906002)(5660300002)(2616005)(316002)(36756003)(107886003)(31686004)(52116002)(6486002)(478600001)(4326008)(31696002)(956004)(26005)(66476007)(81156014)(81166006)(186003)(66556008)(8676002)(8936002)(66946007)(16526019)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5320;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xwEOklgNdnEduZdKYp6eqHjhX189d97DzINYIMs5o5tP+oLWRgSzb0WKGZAbglrcly2lWEiAbbBI26ejBgv2KkDBSYh+UimZi21hGDlPbWngW5VN8FfPp1To2LFVTcIDibr5kyL9S37aJ6pr5CLuZ/zwt1p5Cf7qtRhrzeCS43ncl3YgPBfr27UkvAaPZmSjqyNL23uTkwN9oeeJhVpM/9WdoiVnHYO3ondOcSNQzYRLlFX3jN7qv808xht8STxfryMtdCEzNnkhsVi7UEZ+0A4ha3VR0Mj2zH0jn6YOKUzkmVaWQyKpO5hemTUHDkmNGHoRT8AbP2ZPnOEBbW+tZDkEOqWr+5gXYMexnaK7Ngoh7Q4D1pJJYLO0HLhcppSNxqnlfWZEXejf9F6IiSdCLcAz7kgqXMhTJ0Lbn/+iH7LNo9CCRdUbUd36b0PVIkBy
X-MS-Exchange-AntiSpam-MessageData: 0EUfDycKFGjwo3hKUIkQJXD8QKyM43A6+MTWxX3xfa77T3x/ao5m2jvyOgTyTK4NIyI/9k0g8WLW3Fh5w+BU8HF8yaITnEMDgEpnbAlXYrAF9jFxvzbzt9mcnj+CKBkbBEU2iM0p/+oJQMsgOCgRMw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a347f6e-7bca-448d-d3a0-08d7cfda7165
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 10:02:20.9588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yeFH9rk4SkBOJ96nXdCLHXfasEe4jV7gxX1xXhe7x2UGhfpJ2NNwP9DhIrWEYUbqXWmGf8Jih8ZLZNvyA4rlmPRmXyGlXDVb3uuXAFvy07I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5320
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.15.108
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
Cc: qemu-block@nongnu.org, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.03.2020 12:36, Kevin Wolf wrote:
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
>>      grep '^[0-9]\{3\} ' group | while read line; do
>>          file=$(awk '{print $1}' <<< "$line");
>>          groups=$(sed -e 's/^... //' <<< "$line");
>>          awk "NR==2{print \"# group: $groups\"}1" $file > tmp;
>>          cat tmp > $file;
>>      done
>>
>> 2. Copy groups documentation into docs/devel/testing.rst, which already
>>     has a section about iotests.
>>
>> 3. Modify check script to work without group file.
>>
>>     Here is a logic change: before, even if test do not belong to any
>>     group (only iotest 142 currently) it should be defined in group
>>     file. Now, test is not forced to define any group. Instead check
>>     considers all files with names matching [0-9][0-9][0-9] as tests.
> 
> This has both a positive and a negative effect: Now you don't have to
> modify another file when you add a new test, but it will be picked up
> automatically. However, if you want to disable a test, you could
> previously just remove it from groups (or comment it out), and now you
> have to delete the test instead.

Hmm. Probably, you could add it to group "disabled", and run check -x disabled.

> 
> Downstream, I think we still disable a few tests because we're compiling
> out features that are required for some tests to pass, and deleting the
> test cases completely would probably move conflicts just to a different
> place.

I came to fixing all test in downstream, correctly skipping test-cases which
needs compiled-out feature. We don't comment out tests in group, all tests
should pass or be correctly skipped by check.

> 
> So I think we need a method to distuingish an enabled test that is in no
> group from a disabled test.

What about "disabled" group?

> 
>>     check script is also refactored to make it simple to do next cool
>>     thing about iotests: allow meaningful names for test-case files.
> 
> This one would also require us to be able to distinguish test case files
> from arbitrary other files.

I think, something like "all files started with 'test-' prefix"

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
> 
> We lose these comments without a replacement. I wonder whether it's
> important or if we can think of another way to make sure that numbers
> aren't reused. (I'm not completely sure any more why we decided that we
> don't want to reuse numbers. Maybe because of backports?)
> 

Hmm.. Okay, if we had this test in past, than drop, than reuse number for the
another test, we possibly may break bisecting.

I can add notes about it into documentation (nobody will read it). Anyway, I
don't think it is too bad.

And if we move to textual file-names for tests, we will not reuse old removed
numbers anyway.

-- 
Best regards,
Vladimir

