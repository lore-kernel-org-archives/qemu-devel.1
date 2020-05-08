Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682B7C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 09:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C31920725
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 09:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bOgtNxva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C31920725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWzXg-0000R6-Am
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 05:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWzX4-0008Ng-9f; Fri, 08 May 2020 05:43:02 -0400
Received: from mail-eopbgr80134.outbound.protection.outlook.com
 ([40.107.8.134]:60198 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWzX1-0001VO-5I; Fri, 08 May 2020 05:43:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fj4qNRXKf8fR4TfbLNsx+9/t7HerosnpbdxIEs1aTIdIdYBIIMsLeX9vptlDT5HRseBh7Vs7IDJDjl7HRlOY9iclqOnzUUwu31BfiNYaErtm4QWRANM7xmsyveLBv7P6mb6vnFJ3+bOgdlXCeuVeTp5o4qKkP7mAq/Hw7FfeJ2SJLb40bzkHyyEvs4B9jEYIFiPktNBcMpSHZnSKQLqIeeE+K7h0C86c1zY5a3vcdMMLDsq77fN8OMT1avfB6ckjUipEb0IsxTMEI7+CfA/l0UwhyI+4/vvvmZoYKzLRkXeauCO+siPpNxht5557oc+oAaBgAbo8dhFDO6UOTeZV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01IIMH9FVw5fQ0+6cw8fhhZlC0rC7hYM1R6su2nGIGU=;
 b=YBwC9oZcQLBC9KLSmXDS7NggZQskjDlirnPhFcwnEx2fRpLabZeZNwg/VIFfP8+cCM+58QywPNdcXP8PLUh69wgKamRjeJhY96Szo69OXAJ57kZRn4YlPioP1llL51/9bWnEV9FkDNcGC+j+8i5lwzwLdLJS+1IZzwLLpVToEyYJQ1L4Hr5G20GuWqYAX4eZf4WEQwtkPXEJzqiTYp+maQfPPIuz3atkZn6hbPo3CYtksaLw+nu9xFyqzm1BJlywuLyZUfk2uuB3wM6Vl2LQrAQE6i1H0k0X1rLzr4jcmiOgUzPuMdVwR112t4sFenSZ7QXzqhbyXHfAMdYEP/BRXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01IIMH9FVw5fQ0+6cw8fhhZlC0rC7hYM1R6su2nGIGU=;
 b=bOgtNxvaW37xW9goTDwc7FYptybzZ5tCuQm3PQ9UVEwwV17AwsxSN39TtjePCRf4XZ5vZPrHlADuccsVvdGKI3wWKR5cQAqUR52Fj6TqpRNLqYq0yUq1IOPQLEwfq15CGRbxCKhbBogHhULjHsZ6pTsdKbyqFe0Dh+m3K7Zu+Wg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5462.eurprd08.prod.outlook.com (2603:10a6:20b:10b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Fri, 8 May
 2020 09:42:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.034; Fri, 8 May 2020
 09:42:53 +0000
Subject: Re: [PATCH v3 06/10] iotests: add testfinder.py
To: Kevin Wolf <kwolf@redhat.com>
References: <20200421073601.28710-1-vsementsov@virtuozzo.com>
 <20200421073601.28710-7-vsementsov@virtuozzo.com>
 <20200421165647.GE22440@linux.fritz.box>
 <5a185a4e-1c5d-9887-c88c-6ca71ebeeee1@virtuozzo.com>
 <20200508084903.GA4970@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200508124251643
Message-ID: <d548b9f8-1f45-d7dd-cf95-fea1603a8e5d@virtuozzo.com>
Date: Fri, 8 May 2020 12:42:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200508084903.GA4970@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.163) by
 FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.31 via Frontend Transport; Fri, 8 May 2020 09:42:52 +0000
X-Tagtoolbar-Keys: D20200508124251643
X-Originating-IP: [185.215.60.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 728ce96a-c302-4067-e32e-08d7f3342e0d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5462C26AA15865838764DDBFC1A20@AM7PR08MB5462.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 039735BC4E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ND4nw+Uptv3hP7Tm7L4Z/i+fJ3YFNuc1VEjcvxfEwlC6vVua5Kfl3SXlu2VughFgd3Ch0pB2ZAC/0qbXkfp9azQqv9S67FlN/EVfV+OuVN72fJB4UYsLSeYGsJjKW2RZWKx8m7hTOh5RhXcQRGrPWuAwMEYvBpLotUxOdtXMcaKCZYq5v7J9VUYh5OvvgDoY+6K848gX1mDMbibRaOxLr75bRZBxDwUJZU+h4VosMK+Yb5WQK9Zetqe72jkTqsZvk9THkZqSaOndPEvWTiUuEFRT4V45/Ae4eyCu0SWf+Jyaj+S1xfVChgtecsgtYVDOjBPV9fookDYtCXMLLfdb/hFAYViFPLE1yBI1d54QyyrC2kXMloyedFrQvsJa2HT38XzBSaf6OT8QY1UsSE8CEIzYLBKj//QjUI8rVZP+4XV4CH8qieGNbTSz6xsukIxEnUyHevXM8FVFEDVotrkn75B9NhVURw7mrHd8SPEzI6GjJz78f1tOO7P1QK6Wlw8DCLln2FwiczYyl7RDgRLJ4aIkbt5Fx+5RsRMtWM5U+omo3MZWSMpIRctXbtfznvox
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(366004)(396003)(136003)(346002)(376002)(33430700001)(2906002)(4326008)(956004)(5660300002)(86362001)(6916009)(36756003)(186003)(31696002)(478600001)(8676002)(8936002)(66476007)(66946007)(66556008)(16526019)(26005)(52116002)(16576012)(316002)(31686004)(6486002)(33440700001)(83320400001)(83290400001)(83280400001)(83310400001)(2616005)(83300400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ktH5i9cherQHURN1FyZsWOyHYJOvlGnKQQG0M2hP7oqgtfgHyzkE4NfJLJ+RZymjSmsgKoel4RcyBvSobnfYeAA0wLoBOKpFaP3rkunYBbI+TEKT06lc8BgL+sUM7j/2ajmROSuxdcz2S2I2ohYhjJHZnU+0S5uOBQB1uDP7eZ8ESi8NH5tfiAAcdSecWXuK2IKP+KQWK2mF7oFUBWVP2WUyDPm9BpnDXftlMHTiTCJ8dosxuN7Hmo6aB0oIXfpBYESgndm8WHwUTlaokgjkap3+7Ox2Ejo4JjXpz+AuI7e5OeYakcKF0zdrWrvyMq5tikHr/QlPLrC8Ee/+Fcx4y0LsAac+vRAHtUR8rgsGqo5cnnbQOfCf8RvWnd4O8mwviQnmI10g8qdev3zUL39RzHdNWRUgYzRZWuBweRdejHFI6DlSxjzkpMMVvDwTLw+CH5Qbw/igKsMjXmap8TBK5WcW5AvO3pnvwU0+cT3dSnBsepIN4hDAQvMgrHS9qwlR
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728ce96a-c302-4067-e32e-08d7f3342e0d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2020 09:42:53.4846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSh/Ru7CyGQWpcea3GyLTaCRJSI8BfnbHRdmwy7nRoiU7Pcy15ki4RNESy99Z4ZhEhcnn3rfuJEXnIysUnppGuUYvBWqWL0fv83hfplvn70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5462
Received-SPF: pass client-ip=40.107.8.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 05:42:54
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

08.05.2020 11:49, Kevin Wolf wrote:
> Am 07.05.2020 um 19:43 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 21.04.2020 19:56, Kevin Wolf wrote:
>>> Am 21.04.2020 um 09:35 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>> Add python script with new logic of searching for tests:
>>>>
>>>> Current ./check behavior:
>>>>    - tests are named [0-9][0-9][0-9]
>>>>    - tests must be registered in group file (even if test doesn't belong
>>>>      to any group, like 142)
>>>>
>>>> Behavior of new test:
>>>>    - group file is dropped
>>>>    - tests are searched by file-name instead of group file, so it's not
>>>>      needed more to "register the test", just create it with name
>>>>      *-test. Old names like [0-9][0-9][0-9] are supported too, but not
>>>>      recommended for new tests
>>>
>>> I wonder if a tests/ subdirectory instead of the -test suffix would
>>> organise things a bit better.
>>>
>>
>> It will make more difficult to import iotests.py.. Calling common.rc from
>> bash tests will need to be modified too.
>>
>> So, we'll need additional line in all python tests:
>>
>> sys.path.append(os.path.join(os.path.dirname(__file__), '..'))
> 
> Hm, yes, this is nasty.
> 
> Would it be any better have a wrapper script that just imports the
> actual test so that the import path would still contain the main
> qemu-iotests/ directory?

I think, that better to keep all tests self-executable without any additional preparations, just set all interface environment variables and run test (or use check to automate environment initialization). In this way we can support any executable, not even limited to  python and bash (I doubt that we need more, but keeping test interface full-defined by environment variables seems a good thing).

> 
>> which doesn't seem to be good practice.. So, instead we'd better call
>> tests with PYTHONPATH set appropriately..
> 
> This is another option, especially if we do want to create a lib/.
> 
>> and modify bash tests to do
>> . ../common.rc
>> . ../common.filter
>> <etc>
>>
>> or again, better to export BASH_TEST_LIB directory.
> 
> I don't think this is necessary because the working directory wouldn't
> change, so bash scripts should just keep working as before.

Hmm, right. Probably same works for python tests as well?

> 
>> Is it worth doing?
>>
>> I think, there are two variants:
>>
>> 1) keep as is: all in one directory, add *-test notation
> 
> I think it would make it rather hard to find the files that belong to
> the test harness implementation between all the tests. Currently, 'ls'
> in the qemu-iotests directory is still kind of usable because all the
> test cases are at the start and everything that comes later is not a
> test.
> 
>> 2) go further and restructure to something like:
>>
>> iotests/<only check script and its dependencies here>
>> iotests/tests/<all-tests-here>
>> iotests/lib/python/iotests.py
>> iotests/lib/bash/<common.rc and friends here>
>>
>> And then, check script will export PYTHONPATH and BASH_TEST_LIB
>> variables.
> 
> I think leaving everything except named tests where it is, but setting
> PYTHONPATH or having a wrapper script, is still a third option that's
> worth considering. It sounds like the most attrative option to me.
> 

Works for me too. OK, let's go this way.

-- 
Best regards,
Vladimir

