Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4071C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:32:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B5E20575
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qYhLsvbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B5E20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ6Tl-0002cR-HU
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 01:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZ6T2-0001zP-MZ; Thu, 14 May 2020 01:31:36 -0400
Received: from mail-am6eur05on2120.outbound.protection.outlook.com
 ([40.107.22.120]:39137 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZ6Sz-0005q3-Rd; Thu, 14 May 2020 01:31:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=St3zGBkwjvK7vwpLmrJ7xwOXakF6HhErsIGk9AKmLxUyVRHvlyVz3G8Vh9zjBjMjqXtqkz7/6Z4I7PD4ji0EQifNh8i8zefpOZTCEDuJBY9ryXAmPuS7/frfd7/RZ8T6C5b52rG3kLJzVLfQpdFcTHmTnQKqAbJvUhqZwBWsOsuu6DsAlR/4FcrgG5Ha8cvtUXYxatpjq2cEfDWhV5jZ5AAPFXJO37EFcI8OSDuLTneW8VSEfSFIxWCVcvCVqGxDhDLiALR2phfRkFijOc4MEWfbqWa6Siwo1jRCmVQVX0bXz+grHjTb1xVpItVOodHETtcN0snzC0+sRZUcRQIhVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C49BoqpjaqFde/DaCpCWEgah7no66H15MtpHe5tvTNo=;
 b=e2jphS/I1Am/aHvk/1/FdcNpcKpE2PPKnCe6hfcnJVbY811cTrqfIU1F6xrVxWa/zT9wYcxszJKyMtnZHwFw7IC7mRcazM49OJAmiu1a6gRr/qx90E5IfZY4tbpeOPuVOkgptU1HPofgs7W7qdT4h7vZI6iCT2XZbwpUf7TYMDYXlW+yTU/ukh1DrpTvx2cveioSKtJAHspD75qt98xKw6MM18KF6AMbgoyNLREy7UBjKhX5B8SR0YL32t50FWe3BzXfA9H0s3Yd3uy8OJQIurMYAa8mY+n5RlQd8fmBLLzVKzpFwhb6FZe7eQ1+ky0KdEsEYpvXbAIMsCQZzJWyIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C49BoqpjaqFde/DaCpCWEgah7no66H15MtpHe5tvTNo=;
 b=qYhLsvbxRDnNi4hQDnPXVgUve948nDl29pXuE3foxSjLFHEmZIOHTHILeVIpP0RghpKl1hB8nJmdYSczV+mH4Ji9sVOyOP07SDZ4xAUvWFnRU2brxiqTNT694UcxMUnZvq9mAwHogguhW93hTXzfsEqPQfWbeQq8rHKCFvW4mCo=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5399.eurprd08.prod.outlook.com (2603:10a6:20b:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Thu, 14 May
 2020 05:31:29 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Thu, 14 May 2020
 05:31:29 +0000
Subject: Re: [PATCH v3 06/10] iotests: add testfinder.py
To: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20200421073601.28710-1-vsementsov@virtuozzo.com>
 <20200421073601.28710-7-vsementsov@virtuozzo.com>
 <20200421165647.GE22440@linux.fritz.box>
 <5a185a4e-1c5d-9887-c88c-6ca71ebeeee1@virtuozzo.com>
 <d0c4728e-99e4-568d-473e-952f57f3f07e@redhat.com>
 <2a62c728-1607-1375-6126-713bd047d5b1@virtuozzo.com>
 <47de3b0c-c07c-ad4e-25ab-1353d9710d10@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f0310def-c10f-4b4e-c03e-2e85ef9bcf0d@virtuozzo.com>
Date: Thu, 14 May 2020 08:31:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <47de3b0c-c07c-ad4e-25ab-1353d9710d10@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0021.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::34) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.186) by
 AM0PR02CA0021.eurprd02.prod.outlook.com (2603:10a6:208:3e::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.25 via Frontend Transport; Thu, 14 May 2020 05:31:29 +0000
X-Originating-IP: [185.215.60.186]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efa13f0b-cc29-4510-7a82-08d7f7c80e0f
X-MS-TrafficTypeDiagnostic: AM7PR08MB5399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5399F55F019D7C9A652A1E61C1BC0@AM7PR08MB5399.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jvz3uI5ppxa/4gU9knWiqIXfPuXFhVdeksCBJj/hIleejxVND+hqY5M1leTyVVVVo4BuJKp5QlyZ0bS/0JfaXdHz4YMuE94x0UWYpPFdaXYN6D0D+GS3WyyIgs+PMqv5Kugi/A75owuK6m07BmRlbkFGnDtOTeHoCq363nETIllrYGefpgIIMHeiPJVcDFBYsLI8M66BG76QH8aCCH3t72T9QpMv9oX+m/8tHHj4b1yoYCg8muGEIp/WCMtzU8Eqg2nOt7J9YeesBi+BErmrlHsB7tyMOw/fhy/XgTDvqR/SaY/OuHniTDlWVC+5GE3i3jvE+xe8b9HhIhE3yzX9wxcZ+hNdWs6x91ExqC9DhdbDk1aIV3WohrqLP5AbnBGex11FmjA9dNJePtUGW991CJ0I3NpYiFI7j37OEODEDUUGBBcEVnfnRYW3Auqkp1vLy/2pBwvwicAn2L7o3Hi0D+fwj5wu6fdzHdW3dLM9OWTC8+SuCSFAuhwfR0qgFngX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(39840400004)(136003)(396003)(366004)(186003)(16526019)(2906002)(316002)(6486002)(8936002)(26005)(31696002)(36756003)(110136005)(52116002)(53546011)(16576012)(86362001)(66946007)(956004)(66476007)(5660300002)(8676002)(478600001)(4326008)(66556008)(2616005)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: h/ko2VlzM/4OWHetteBTeOXjb19L6lfiroVwPBQJEsMWvo9tuUKo5ef1PiWvoGTvmhRoNi0dbZ5MHE8/qFtsg82jbVY3qqPFOUK4tPK5o/Ek/s43qDmWcCH5RZf+7RsCkGehLQe6FJo2KPJWvQ6sk9pqRvXJyjpFD64qfsdoG1YM3YO72iHtRU6wfGuPsZTP+8DCHso5JMnK4XlxsagfcfvRH2Kei8DFFtwZgd2Qr1OLf2VF6CmCAjxS74SQIXBBvEVeVSmLzZ8rZ9bG1eDot/4GFBg2NwwzBNWLs4+zaZtlHmcgpLMy3Y+jkFIe8NP15iQDKhGOoVXDVNHIFhXXO/vns545wzmyRXabscFJXJegdWvfRs/yLF9FTOIKfXZLaGAvw+yS++Kl+w+7Zwev97HR+gg5P6TMiSqa1IDt6ASwyrsxyqT09gfKO1kyAVjyefRWKIe5h+qGtF+t7VqpHwVWZMtnVSy+82R2QssC+zNVftj/BLyUmsYSM7ATO/1j
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa13f0b-cc29-4510-7a82-08d7f7c80e0f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 05:31:29.8804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGCixXvSZcqxWjU2YGga41/2DCtE1LwjiSk3taf8kUxz39rvE+dtJyvno+sJQO3GnD1UKj8Rehztjl9TAzy3EnR8qPKLZmlrOvgh6aCun7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5399
Received-SPF: pass client-ip=40.107.22.120;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 01:31:30
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
Cc: den@openvz.org, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.05.2020 08:06, John Snow wrote:
> 
> 
> On 5/14/20 12:54 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 14.05.2020 00:58, John Snow wrote:
>>>
>>>
>>> On 5/7/20 1:43 PM, Vladimir Sementsov-Ogievskiy wrote:
>>>> 21.04.2020 19:56, Kevin Wolf wrote:
>>>>> Am 21.04.2020 um 09:35 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>>>> Add python script with new logic of searching for tests:
>>>>>>
>>>>>> Current ./check behavior:
>>>>>>     - tests are named [0-9][0-9][0-9]
>>>>>>     - tests must be registered in group file (even if test doesn't
>>>>>> belong
>>>>>>       to any group, like 142)
>>>>>>
>>>>>> Behavior of new test:
>>>>>>     - group file is dropped
>>>>>>     - tests are searched by file-name instead of group file, so it's
>>>>>> not
>>>>>>       needed more to "register the test", just create it with name
>>>>>>       *-test. Old names like [0-9][0-9][0-9] are supported too, but not
>>>>>>       recommended for new tests
>>>>>
>>>>> I wonder if a tests/ subdirectory instead of the -test suffix would
>>>>> organise things a bit better.
>>>>>
>>>>
>>>> It will make more difficult to import iotests.py.. Calling common.rc
>>>> from
>>>> bash tests will need to be modified too.
>>>>
>>>> So, we'll need additional line in all python tests:
>>>>
>>>> sys.path.append(os.path.join(os.path.dirname(__file__), '..'))
>>>>
>>>> which doesn't seem to be good practice.. So, instead we'd better call
>>>> tests with PYTHONPATH set appropriately..
>>>>
>>>
>>> Just chiming in to say that it's largely bad practice because it
>>> confuses pylint, mypy and friends -- if we want to keep pushing our CI
>>> code analysis for python in that direction, this will be a barrier.
>>>
>>> Using PYTHONPATH is better, because it isolates the script itself from
>>> the environment, but requires you to now always set PYTHONPATH to
>>> execute any of the individual iotests.
>>>
>>> Not actually a big deal, because iotests already expect a large number
>>> of environment variables to be set. It's not really a huge net loss in
>>> convenience, I think.
>>>
>>> looks like that's the direction you're headed in anyway based on
>>> discussion, so that's good.
>>>
>>
>> Hm, does PYTHONPATH-way works good with mypy and friends? Probably, it
>> should
>> be set when checking the code? So, actually developers will have to set
>> PYTHONPATH by hand to always contain some directories within qemu source
>> tree?
>>
> 
> pylint respects PYTHONPATH but mypy doesn't. mypy uses MYPYPATH, but I
> wouldn't worry about accommodating it. It's a fussy tool and we're only
> ever going to run it from very specific environments.
> 

Hmm, recently I installed dense-analysis/ale plugin into my vim which does mypy checking (among other things).. And most probably, I'll have to set these variables to keep it working. But it's not a big problem.

> You don't need to worry too much about what environment variables these
> tools take; it's only worth noting that "sys.path" hacks tend to make
> these tools harder to use.
> 
> 
> As for setting PYTHONPATH by hand ... There are a few places in the QEMU
> tree where we set PYTHONPATH already, and the individual iotests already
> don't work if they're not launched by `check`, because they're missing a
> ton of environment variables.
> 
> It's not going to be too bad to set PYTHONPATH in the launcher script,
> is it?
> 
> (Or are we replacing the top-level script with a python one?)

Yes we do, bright future is near:) But it's not a problem to set PYTHONPATH in it. Anyway, we run all tests as executables, so passing PYTHONPATH is a valid thing to do.

> 
> 
> 
> 
> Really, the same is true of pylint, too. It's only annoying to deal with
> sys.path hacking because it can't be worked around in those CQA tools.
> 


-- 
Best regards,
Vladimir

