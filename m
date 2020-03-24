Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URI_NOVOWEL,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CE0C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF9F20775
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="n4a0oYb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF9F20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGgYG-00022H-Ci
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 06:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGgSd-0001tt-2K
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGgSb-0002mR-Cn
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:07:02 -0400
Received: from mail-eopbgr70124.outbound.protection.outlook.com
 ([40.107.7.124]:5555 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jGgSb-0002lP-3s; Tue, 24 Mar 2020 06:07:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cmp87vsBGGHTksB5j2gLL+ZokzNgrbrn65MrxmFF/8x+a9wVtn6e9713vCo3CWv3BawDbO0qJqj3KVu83tmYFVzMV3LWGYpKLefhBJ6qG/Qinvsl1YL0H+2zHkx0zQx83JR4a/VDmRJ8Z3z6dfdL4bBZF9J06+olOAcGiwlnVWEJLU7xVAF9SWUk9sLnvGsW4xyOmguXp78Dw83azC2Cw20Xx8JrGNNrXSVewMoAVsORfgkTQRpKodypELeWFDHTalY5eX8Dnf3rxCSN/aESW+lO/PHxJxHI9n1MEH76zLi3KKuQxcBPVzuMwvl5ejclx5gFnFx953dDJnwoSkruHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35ThRf00CimmC5M3Qnk4oCWf559XLsP+XEtsBbdmI3c=;
 b=mv3Lkl+hRhr5yw0Xv/p1B4/3pGO0I9Fjbp4yT1BJw5ZtN9iEkUK20KzUdPCYD1gJi0Cezl44qhQVVuzfZ45opQE5JErfIYMeq4sksA59AQxbr5pzQfmtf8rAC/XNaGCWbIlrES0jfxdlZaoPh1lM5TH+Qu6IeQKYrHVUaPFKpCij6XjqM9trRVcUY+FVYbUv/WWU8DB9w/zZGHyzX3dJI3ItVfXUVFbFxQvYx7KOZKORlZd8NX6mHgh1MGitIWo2R7D4/RFi4vXtvrdLU/1QcSZvm8E5k8YfqOIc1bBnCa4RpvdVc2GjpYn7i7T/V6n2mHuZMk+lWX/e5ZkgTu2H2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35ThRf00CimmC5M3Qnk4oCWf559XLsP+XEtsBbdmI3c=;
 b=n4a0oYb4bKZYjzTJr0Mo8sl1nloBMZ0955cLTO5VVLrWkDyegx1jYgvaFV8WglnK+sMZUMgzjW5yrwwAeTEWqpJQFa5wKrzeCc2eG9IC6Poi/5mwQjd2AIaLpXAP+6Gn+2U9DIdrJUZma1n3DGCTxE6YZx9ZWBLHIFvm57ao4Is=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5320.eurprd08.prod.outlook.com (10.141.171.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Tue, 24 Mar 2020 10:06:58 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 10:06:58 +0000
Subject: Re: [PATCH] iotests: drop group file
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20200324074156.5330-1-vsementsov@virtuozzo.com>
 <20200324093629.GC5417@linux.fritz.box> <20200324095142.GC3597586@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200324130655731
Message-ID: <5976e2ac-98b9-400b-8f02-002867f5ce10@virtuozzo.com>
Date: Tue, 24 Mar 2020 13:06:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200324095142.GC3597586@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR07CA0007.eurprd07.prod.outlook.com
 (2603:10a6:7:67::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.15) by
 HE1PR07CA0007.eurprd07.prod.outlook.com (2603:10a6:7:67::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.8 via Frontend Transport; Tue, 24 Mar 2020 10:06:57 +0000
X-Tagtoolbar-Keys: D20200324130655731
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6fc1b4a-de76-4a68-ddc0-08d7cfdb1694
X-MS-TrafficTypeDiagnostic: AM7PR08MB5320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5320E5DC6F133C4DF46803FDC1F10@AM7PR08MB5320.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(39850400004)(346002)(366004)(376002)(136003)(16576012)(2906002)(5660300002)(110136005)(2616005)(316002)(36756003)(107886003)(31686004)(52116002)(6486002)(478600001)(4326008)(31696002)(956004)(26005)(66476007)(81156014)(81166006)(186003)(66556008)(8676002)(8936002)(66946007)(16526019)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5320;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vIhjBJEXePoYxbkFkaJFwMh5S4forsFNTOpikTVheoYl2QY3aZKsBUck8llYsmisvDUnbTMecjX0j06M+c15qQumb2icp74fKHT6jmmPfhUGACPEoqZKmSKmzNGCv0Dxt6OPnTXNG6f53qiRUyKKrVEIYWebOcWrN4yupGaHuVlcMNo+OSjY8F2LkdJ5or5RCk/NAI6T8qzlHqi+uzHIJcrx6IpiterUo6ZFdLrQYtGeMxVIZ+FNXqQew0oZNdEYfu1nrgG1vm+t29gzL/rY+PvNd4Hy72ilT3c1Fg2tsA7mgY+gCOtByYZPLJyRWlGlWUO0pujxz4dVk3yj0r6tBxi37vSLBJC0GOD4aPto1l650c4EJalJQzXErpjQCQ0x7y2KGZzaZ/SNYoYsztbWBX8RfwnYMM7RjEPiyQCrV5Inznwlq368yOe4CyazAd+z
X-MS-Exchange-AntiSpam-MessageData: M4j/rnPXrs+zM6vL8XeddXD31yAzSHV2CUbq204n72zGPnE651r3n+EVFAeHKsMZ8DQAyrkKsO6kcfdIDFrBHve/ezxsAW07mfGR3dlgZ2+dp8zHe/ZEGHM9IHeEpW76JbK6BDBEQ5We7Sm1pRCSjA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fc1b4a-de76-4a68-ddc0-08d7cfdb1694
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 10:06:58.0961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/c+3fR9gDM56xCBCeigBVp4r2L1tBnDOmJHwuxlzm0r2JjVApZhlYbyi2YQnut+stjo5CR6knXdnriaCAm8zZcG8JKeMgoRrICR+dFHaZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5320
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.124
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
Cc: den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.03.2020 12:51, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Mar 24, 2020 at 10:36:29AM +0100, Kevin Wolf wrote:
>> Am 24.03.2020 um 08:41 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>> When sending iotests to upstream or do patch porting from one branch
>>> to another we very often have to resolve conflicts in group file, as
>>> many absolutely independent features are intersecting by this file.
>>> These conflicts are simple, but imagine how much time we all have
>>> already spent on resolving them? Let's finally get rid of group file.
>>>
>>> This patch transposes group info: instead of collecting it in one file,
>>> let each test define its groups by itself.
>>>
>>> Several steps are done to achive it:
>>>
>>> 1. Define groups in test files automatically:
>>>
>>>      grep '^[0-9]\{3\} ' group | while read line; do
>>>          file=3D$(awk '{print $1}' <<< "$line");
>>>          groups=3D$(sed -e 's/^... //' <<< "$line");
>>>          awk "NR=3D=3D2{print \"# group: $groups\"}1" $file > tmp;
>>>          cat tmp > $file;
>>>      done
>>>
>>> 2. Copy groups documentation into docs/devel/testing.rst, which already
>>>     has a section about iotests.
>>>
>>> 3. Modify check script to work without group file.
>>>
>>>     Here is a logic change: before, even if test do not belong to any
>>>     group (only iotest 142 currently) it should be defined in group
>>>     file. Now, test is not forced to define any group. Instead check
>>>     considers all files with names matching [0-9][0-9][0-9] as tests.
>>
>> This has both a positive and a negative effect: Now you don't have to
>> modify another file when you add a new test, but it will be picked up
>> automatically. However, if you want to disable a test, you could
>> previously just remove it from groups (or comment it out), and now you
>> have to delete the test instead.
>>
>> Downstream, I think we still disable a few tests because we're compiling
>> out features that are required for some tests to pass, and deleting the
>> test cases completely would probably move conflicts just to a different
>> place.
>>
>> So I think we need a method to distuingish an enabled test that is in no
>> group from a disabled test.
>=20
>=20
> Can we just have a file "blacklist.local" (which doesn't exist by default=
)
> where you list tests to skip locally ?
>=20
> Or a "group.local" such that any info in this group.local file will repla=
ce
> the default info extracted from the test file ?
>=20
>>>     check script is also refactored to make it simple to do next cool
>>>     thing about iotests: allow meaningful names for test-case files.
>>
>> This one would also require us to be able to distinguish test case files
>> from arbitrary other files.
>=20
> A test-XXXXXXXXX.sh or a XXXXXX.test  naming convention ?
>=20
>>> -#
>>> -# test-group association ... one line per test
>>> -#
>>> -001 rw auto quick
>>> -002 rw auto quick
>>> -003 rw auto
>>> -004 rw auto quick
>>> -005 img auto quick
>>> -# 006 was removed, do not reuse
>>
>> We lose these comments without a replacement. I wonder whether it's
>> important or if we can think of another way to make sure that numbers
>> aren't reused. (I'm not completely sure any more why we decided that we
>> don't want to reuse numbers. Maybe because of backports?)
>=20
> The key goal of the patch is to avoid conflicts from clashing changes
> between branches. To full achieve that goal we need to both avoid
> touching the shared groups file, but more than than, we must avoid
> creating clashing test filenames.
>=20
> If we keep using 3-digit filenames then the goal of this patch is
> not achieved, as the risk of clashes is still higher. IOW, we must
> switch to a more verbose naming convention to increase the entropy
> and thus eliminate risk of clashes. If this is done, then the idea
> of reserving previously used test names ceases to be something to
> worry about.

Hm. You are right, better to solve all these problems together.


--=20
Best regards,
Vladimir

