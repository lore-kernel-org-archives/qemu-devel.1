Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B83C55189
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 12:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BC7220787
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 12:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="n6yaf6YG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC7220787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jREqE-0004Jz-94
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 08:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jREpB-00035k-Bn
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 08:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jREp7-00022l-SG
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 08:49:56 -0400
Received: from mail-am6eur05on2100.outbound.protection.outlook.com
 ([40.107.22.100]:13408 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jREp6-0001wV-4k; Wed, 22 Apr 2020 08:49:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJvG5S1HQuE+o/8cmhhcIpdJ4OIFMz6bhdySLezQahifFtkf91YdF4QbD80cfsdKM4M9uUHtpXAYIeL6JrbQNrTby19ZPtzF0xiEq6/mlcVLsZCXheZNsbUZI0TPZrygcSHbdoKnBdQ0X8yNk3HlM8pYmIlZI+qpVa2apZQhvxIo6nrGgFIadh9olSZLPQNI67RXYuEKgxro+R1N6S42eDPXSgcEHRiLhFzO+/3G+oar6HtDnpjK1bv6y0W73r1UjVwd7kUhyaGUkcMS7BEeFXixcJkGD3cEiKDT6iZvzutishYEevsbR+XpOcTTffeMZ6AWaFSueE+CX3xcVUaYPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82kN+ArT1EJntnVRfkmKRsg7SLtvYz+SfGpjju5U/Tg=;
 b=gOPrQKpjncTeI0KQT2I0pkYBEigHjH5U+5zQpj8loQkyDsGCSCSlVfZzYy5vaw62skeEW3RKzCvAKqp1htMMZT26Qrnu7dFMM6TmV6Qn7UhfXCdVEcqXGkVdTLcfXr7SydHin7hMn43tYaS25SdQg6Tnug92Ukkkv/kR6ej34Ys5tmPboUQvgGW3bJD8ocbNPzgeWBHzl0fFemS2vcL2mG2ztNZ856H9luE72Tutcq15OpiAFbpc49xltuFDt+bs8xUD88zFqG0pKGJ4/KxqkzJo4n+/pxMwFlU2/C5zKUzSxVqGIMrQz2/jW/TpCxhIl5IuEsXw4kEm7XvC1JyO+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82kN+ArT1EJntnVRfkmKRsg7SLtvYz+SfGpjju5U/Tg=;
 b=n6yaf6YG4QwTJzRWpkgxwDAydUa8e+bhF+XL4OBr5Ha3sMF+EtcgA+fllEmbyn2FUw986tVqwQmDBL6drEaeaPUe8ywkEENvfFMw4KHmhAiX7Bvk5RDuskOBJZL/0T/MpmTlqRQNEp3l5zUMsVLjZ5o+WpCT7Bz8qcZHmIxJyhQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5430.eurprd08.prod.outlook.com (2603:10a6:20b:106::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 22 Apr
 2020 12:49:48 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Wed, 22 Apr 2020
 12:49:48 +0000
Subject: Re: [PATCH v3 06/10] iotests: add testfinder.py
To: Kevin Wolf <kwolf@redhat.com>
References: <20200421073601.28710-1-vsementsov@virtuozzo.com>
 <20200421073601.28710-7-vsementsov@virtuozzo.com>
 <20200421165647.GE22440@linux.fritz.box>
 <024af11c-180a-2ef6-fbab-fe31107d4438@virtuozzo.com>
 <20200422115310.GA7155@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200422154946351
Message-ID: <bebaad72-1c40-36e2-b562-edfc69196326@virtuozzo.com>
Date: Wed, 22 Apr 2020 15:49:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200422115310.GA7155@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0008.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.157) by
 AM0PR02CA0008.eurprd02.prod.outlook.com (2603:10a6:208:3e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.27 via Frontend Transport; Wed, 22 Apr 2020 12:49:47 +0000
X-Tagtoolbar-Keys: D20200422154946351
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e30f9fed-660c-4fe4-eeed-08d7e6bba3d8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB543073E3F46219F7044A8A3AC1D20@AM7PR08MB5430.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39840400004)(8936002)(8676002)(6916009)(81156014)(16526019)(36756003)(31686004)(186003)(86362001)(6486002)(31696002)(4326008)(2906002)(478600001)(16576012)(66476007)(316002)(66946007)(66556008)(30864003)(26005)(52116002)(2616005)(956004)(5660300002)(2004002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dDT9KB5VJ/TcO3IxPwkoexskZVxPkdszvk4I+9r2xKaYoB4XavYo3V3Hx48UVeQAjoJrRmM8yMaDyEUL1o9TMPD3wuBf8bvhc/h71JdI2q0B7ippgKEj8AvBSL7hxuGiZD22ruDiHxGC06KzXwJVkPawR0uA6LvfXKVAuRif8IKgUGx5Smqs2QhzFICUnwc4ZFoHvKb6k5vRCajDT65nl8IkZk41J9wmIkdrRy1AeNnsqqbpfal9/MDNKJ89tiUNasCzAcJ0cOSXndsjJXnvF7NBVaavwe33xXACsBqfOXdaEwJcLZtVT1muu1OCIuKtKrKxNz8wEu5W876wZtQ0IG4sdMbt4liIsb93nJnDef8Wb4uqHuzX202u0btjchOZwtYmD/CrcknXkpogAYYXZbLrpd4nUy2Gt3kiGi48eBB5sEHfF6EGKwq6AhIBG6XpZvU6KW1DC706C5jDMTSmWow0tm1m3J8QLQb9/a4vujhmHdC1c9aHU8tWnohk6uN7989++dY9Nusg4xZ58qWw9I0ZfQSWPjChhD9iMbJtRtBPhJ2Sp4z5xWFpAfQtza8
X-MS-Exchange-AntiSpam-MessageData: PQSiOKmt1s+bHBKNTBVU/sNzF5qEF0bqGUzK6lCMVSTtH4wf1KTjCvwZgMqbkH7Y8wwwcAtJK4450XB+ejMJjzJ4fG0lhIVNtDdoZvfYUGiGUa5D6IOJYcLQvGlUw2n7b8uzPes0czPolNH/I9Vqmw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30f9fed-660c-4fe4-eeed-08d7e6bba3d8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 12:49:47.9684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdC12hqH3ONk35if4BsdqBeCClEcsQrUsmPHbW3HMoxiry+U5ntl1p0o62ovSgdtpWk5NrK6KgWgik/amwGucpDUdtBlC++G4PLcTkNv87k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5430
Received-SPF: pass client-ip=40.107.22.100;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 08:49:49
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.22.100
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

22.04.2020 14:53, Kevin Wolf wrote:
> Am 22.04.2020 um 07:35 hat Vladimir Sementsov-Ogievskiy geschrieben:
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
>>
>> No objections.
>>
>> I also thought about, may be, a tests/ subtree, so we'll have something like
>>
>> tests/jobs/<mirror, stream, backup tests>
>> tests/formats/<qcow2 tests and others, or may be one more subdirectory level>
>> ...
> 
> I thought of that, too, but then decided not to mention it because I
> feel it might be hard to decide where a test belongs. Many tests are
> qcow2 and mirror tests at the same time, every commit test is also a
> backing file test etc.
> 
> This is essentially why we have groups and each test can be in more
> than one group.
> 
> On the other hand, I assume that for some tests it would be quite clear
> where they belong. So if we're prepared to have some tests directly in
> tests/ and only some others in subdirectories, we can still do that.
> 
>>>>    - groups are parsed from '# group: ' line inside test files
>>>>    - optional file group.local may be used to define some additional
>>>>      groups for downstreams
>>>>    - 'disabled' group is used to temporary disable tests. So instead of
>>>>      commenting tests in old 'group' file you now can add them to
>>>>      disabled group with help of 'group.local' file
>>>>    - selecting test ranges like 5-15 are not supported more
>>>
>>> Occasionally they were useful when something went wrong during the test
>>> run and I only wanted to repeat the part after it happened. But it's a
>>> rare case and we don't have a clear order any more with arbitrary test
>>> names (which are an improvement otherwise), so we'll live with it.
>>
>> Yes, I've used it for same thing.
>>
>> Actually, we still have the order, as I just sort iotests by name. I think,
>> we could add a parameter for testfinder (may be, as a separate step no in
>> these series), something like
>>
>> --start-from TEST : parse all other arguments as usual, make sorted sequence
>> and than drop tests from the first one to TEST (not inclusive). This may be
>> used to rerun failed ./check command, starting from the middle of the process.
> 
> True, this would be a good replacement. I don't think it's a requirement
> to have it in this series, but I won't complain if you implement it. :-)
> 
>>>
>>>> Benefits:
>>>>    - no rebase conflicts in group file on patch porting from branch to
>>>>      branch
>>>>    - no conflicts in upstream, when different series want to occupy same
>>>>      test number
>>>>    - meaningful names for test files
>>>>      For example, with digital number, when some person wants to add some
>>>>      test about block-stream, he most probably will just create a new
>>>>      test. But if there would be test-block-stream test already, he will
>>>>      at first look at it and may be just add a test-case into it.
>>>>      And anyway meaningful names are better.
>>>>
>>>> This commit just adds class, which is unused now, and will be used in
>>>> further patches, to finally substitute ./check selecting tests logic.
>>>
>>> Maybe mention here that the file can be executed standalone, even if
>>> it'S not used by check yet.
>>>
>>>> Still, the documentation changed like new behavior is already here.
>>>> Let's live with this small inconsistency for the following few commits,
>>>> until final change.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>    docs/devel/testing.rst           |  52 +++++++++-
>>>>    tests/qemu-iotests/testfinder.py | 167 +++++++++++++++++++++++++++++++
>>>
>>> A little bit of bikeshedding: As this can be executed as a standalone
>>> tool, would a name like findtests.py be better?
>>
>> Hmm. I named it by class name, considering possibility to execute is
>> just for module testing. So for module users, it's just a module with
>> class TestFinder, and it's called testfinder.. But I don't have strict
>> opinion in it, findtests sound more human-friendly.
> 
> It was just a thought. If you prefer testfinder.py, I'm fine with it.
> 
>>>
>>>>    2 files changed, 218 insertions(+), 1 deletion(-)
>>>>    create mode 100755 tests/qemu-iotests/testfinder.py
>>>>
>>>> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
>>>> index 770a987ea4..6c9d5b126b 100644
>>>> --- a/docs/devel/testing.rst
>>>> +++ b/docs/devel/testing.rst
>>>> @@ -153,7 +153,7 @@ check-block
>>>>    -----------
>>>>    ``make check-block`` runs a subset of the block layer iotests (the tests that
>>>> -are in the "auto" group in ``tests/qemu-iotests/group``).
>>>> +are in the "auto" group).
>>>>    See the "QEMU iotests" section below for more information.
>>>>    GCC gcov support
>>>> @@ -267,6 +267,56 @@ another application on the host may have locked the file, possibly leading to a
>>>>    test failure.  If using such devices are explicitly desired, consider adding
>>>>    ``locking=off`` option to disable image locking.
>>>> +Test case groups
>>>> +----------------
>>>> +
>>>> +Test may belong to some groups, you may define it in the comment inside the
>>>> +test. By convention, test groups are listed in the second line of the test
>>>> +file, after "#!/..." line, like this:
>>>> +
>>>> +.. code::
>>>> +
>>>> +  #!/usr/bin/env python3
>>>> +  # group: auto quick
>>>> +  #
>>>> +  ...
>>>> +
>>>> +Additional way of defining groups is creating tests/qemu-iotests/group.local
>>>> +file. This should be used only for downstream (this file should never appear
>>>> +in upstream). This file may be used for defining some downstream test groups
>>>> +or for temporary disable tests, like this:
>>>> +
>>>> +.. code::
>>>> +
>>>> +  # groups for some company downstream process
>>>> +  #
>>>> +  # ci - tests to run on build
>>>> +  # down - our downstream tests, not for upstream
>>>> +  #
>>>> +  # Format of each line is:
>>>> +  # TEST_NAME TEST_GROUP [TEST_GROUP ]...
>>>> +
>>>> +  013 ci
>>>> +  210 disabled
>>>> +  215 disabled
>>>> +  our-ugly-workaround-test down ci
>>>> +
>>>> +The following groups are defined:
>>>> +
>>>> +- quick : Tests in this group should finish within some few seconds.
>>>> +
>>>> +- img : Tests in this group can be used to excercise the qemu-img tool.
>>>> +
>>>> +- auto : Tests in this group are used during "make check" and should be
>>>> +  runnable in any case. That means they should run with every QEMU binary
>>>> +  (also non-x86), with every QEMU configuration (i.e. must not fail if
>>>> +  an optional feature is not compiled in - but reporting a "skip" is ok),
>>>> +  work at least with the qcow2 file format, work with all kind of host
>>>> +  filesystems and users (e.g. "nobody" or "root") and must not take too
>>>> +  much memory and disk space (since CI pipelines tend to fail otherwise).
>>>> +
>>>> +- disabled : Tests in this group are disabled and ignored by check.
>>>
>>> We have more groups than just these. We could either try and document
>>> all of them here, or we could only keep auto/quick/disabled which have a
>>> general meaning rather than defining an area of code that they test. If
>>> we do the latter, I would clarify that this is not an exhaustive list,
>>> and remove "img" from this section.
>>
>> OK. I'll drop img for now, documenting all the groups may be done in separate.
>>
>>>
>>>>    .. _docker-ref:
>>>>    Docker based tests
>>>> diff --git a/tests/qemu-iotests/testfinder.py b/tests/qemu-iotests/testfinder.py
>>>> new file mode 100755
>>>> index 0000000000..1da28564c0
>>>> --- /dev/null
>>>> +++ b/tests/qemu-iotests/testfinder.py
>>>
>>> As this is a new code file, would you mind adding type hints from the
>>> start?
>>
>> I added it in one-two non-obvious places. Is there any general thought
>> about using type-hints? Should modern coder use them absolutely
>> everywhere?
> 
> Type checkers only work if things are consistently annotated. For
> example, if a function definition doesn't have type hints, the whole
> code in this function stays completely unchecked even if it contains an
> obvious error like passing a string literal to another function that is
> annotated to take an int.
> 
> So I think we should add type hints everywhere.
> 
>>>
>>>> @@ -0,0 +1,167 @@
>>>> +#!/usr/bin/env python3
>>>> +#
>>>> +# Parse command line options to define set of tests to run.
>>>> +#
>>>> +# Copyright (c) 2020 Virtuozzo International GmbH
>>>> +#
>>>> +# This program is free software; you can redistribute it and/or modify
>>>> +# it under the terms of the GNU General Public License as published by
>>>> +# the Free Software Foundation; either version 2 of the License, or
>>>> +# (at your option) any later version.
>>>> +#
>>>> +# This program is distributed in the hope that it will be useful,
>>>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> +# GNU General Public License for more details.
>>>> +#
>>>> +# You should have received a copy of the GNU General Public License
>>>> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>>> +#
>>>> +
>>>> +import os
>>>> +import sys
>>>> +import glob
>>>> +import argparse
>>>> +import re
>>>> +from collections import defaultdict
>>>> +from contextlib import contextmanager
>>>> +
>>>> +
>>>> +@contextmanager
>>>> +def chdir(path):
>>>> +    if path is None:
>>>> +        yield
>>>> +        return
>>>> +
>>>> +    saved_dir = os.getcwd()
>>>> +    os.chdir(path)
>>>> +    try:
>>>> +        yield
>>>> +    finally:
>>>> +        os.chdir(saved_dir)
>>>> +
>>>> +
>>>> +class TestFinder:
>>>> +    @staticmethod
>>>> +    def create_argparser():
>>>> +        p = argparse.ArgumentParser(description="Select set of tests",
>>>
>>> "a set of tests"?
>>>
>>>> +                                    add_help=False, usage=argparse.SUPPRESS)
>>>> +
>>>> +        p.add_argument('-g', metavar='group1,...', dest='groups',
>>>> +                       help='include tests from these groups')
>>>> +        p.add_argument('-x', metavar='group1,...', dest='exclude_groups',
>>>> +                       help='exclude tests from these groups')
>>>> +        p.add_argument('tests', metavar='TEST_FILES', nargs='*',
>>>> +                       help='tests to run')
>>>> +
>>>> +        return p
>>>> +
>>>> +    argparser = create_argparser.__func__()
>>>> +
>>>> +    def __init__(self, test_dir=None):
>>>> +        self.groups = defaultdict(set)
>>>> +
>>>> +        with chdir(test_dir):
>>>> +            self.all_tests = glob.glob('[0-9][0-9][0-9]')
>>>> +            self.all_tests += [f for f in glob.iglob('*-test')]
>>>> +
>>>> +            for t in self.all_tests:
>>>> +                with open(t) as f:
>>>> +                    for line in f:
>>>> +                        if line.startswith('# group: '):
>>>> +                            for g in line.split()[2:]:
>>>> +                                self.groups[g].add(t)
>>>> +
>>>> +    def add_group_file(self, fname):
>>>> +        with open(fname) as f:
>>>> +            for line in f:
>>>> +                line = line.strip()
>>>> +
>>>> +                if (not line) or line[0] == '#':
>>>> +                    continue
>>>> +
>>>> +                words = line.split()
>>>> +                test_file = words[0]
>>>> +                groups = words[1:]
>>>> +
>>>> +                if test_file not in self.all_tests:
>>>> +                    print('Warning: {}: "{}" test is not found. '
>>>> +                          'Skip.'.format(fname, test_file))
>>>
>>> You're using f strings in the later patches. Wouldn't it be more
>>> consistent to use them here, too?
>>
>> Yes, thanks. I just wrote this code before learning f-strings)
>>
>>>
>>>> +                    continue
>>>> +
>>>> +                for g in groups:
>>>> +                    self.groups[g].add(test_file)
>>>> +
>>>> +    def find_tests(self, groups=None, exclude_groups=None, tests=None):
>>>> +        """
>>>> +        1. Take all tests from @groups,
>>>> +           or just all tests if @groups is None and @tests is None
>>>> +           or nothing if @groups is None and @tests is not None
>>>> +        2. Drop tests, which are in at least one of @exclude_groups or in
>>>> +           'disabled' group (if 'disabled' is not listed in @groups)
>>>> +        3. Add tests from @tests
>>>> +        """
>>>> +        if groups is None:
>>>> +            groups = []
>>>> +        if exclude_groups is None:
>>>> +            exclude_groups = []
>>>> +        if tests is None:
>>>> +            tests = []
>>>> +
>>>> +        if groups:
>>>> +            res = set().union(*(self.groups[g] for g in groups))
>>>> +        elif tests:
>>>> +            res = set()
>>>> +        else:
>>>> +            res = set(self.all_tests)
>>>> +
>>>> +        if 'disabled' not in groups and 'disabled' not in exclude_groups:
>>>> +            exclude_groups.append('disabled')
>>>> +
>>>> +        res = res.difference(*(self.groups[g] for g in exclude_groups))
>>>> +
>>>> +        # We want to add @tests. But for compatibility with old test names,
>>>> +        # we should convert any number < 100 to number padded by
>>>> +        # leading zeroes, like 1 -> 001 and 23 -> 023.
>>>> +        for t in tests:
>>>> +            if re.fullmatch(r'\d{1,2}', t):
>>>> +                res.add('0' * (3 - len(t)) + t)
>>>> +            else:
>>>> +                res.add(t)
>>>> +
>>>> +        return sorted(res)
>>>> +
>>>> +    def find_tests_argv(self, argv):
>>>> +        args, remaining = self.argparser.parse_known_args(argv)
>>>> +
>>>> +        if args.groups is not None:
>>>> +            args.groups = args.groups.split(',')
>>>> +
>>>> +        if args.exclude_groups is not None:
>>>> +            args.exclude_groups = args.exclude_groups.split(',')
>>>> +
>>>> +        return self.find_tests(**vars(args)), remaining
>>>> +
>>>> +
>>>> +def find_tests(argv, test_dir=None):
>>>> +    tf = TestFinder(test_dir)
>>>> +
>>>> +    if test_dir is None:
>>>> +        group_local = 'group.local'
>>>> +    else:
>>>> +        group_local = os.path.join(test_dir, 'group.local')
>>>> +    if os.path.isfile(group_local):
>>>> +        tf.add_group_file(group_local)
>>>> +
>>>> +    return tf.find_tests_argv(argv)
>>>> +
>>>> +
>>>> +if __name__ == '__main__':
>>>> +    if len(sys.argv) == 2 and sys.argv[1] in ['-h', '--help']:
>>>> +        TestFinder.argparser.print_help()
>>>> +        exit()
>>>> +
>>>> +    tests, remaining_argv = find_tests(sys.argv[1:])
>>>> +    print('\n'.join(tests))
>>>> +    if remaining_argv:
>>>> +        print('\nUnhandled options: ', remaining_argv)
>>>
>>> I think unhandled options shouldn't be considered an error and we
>>> shouldn't even try to find and display any tests then. I'd either print
>>> the help text or have an error message that refers to --help.
>>
>> As I considered running this script as executable for testing purposes, it's
>> good to know, which options are not handled..
> 
> Yes, that makes sense. I just think it should be an error and not just
> an additional hint at the end.
> 

It's not and error, as usual case will leave some arguments for TestEnv and TestRunner.
Assume you run ./check with some arguments.. And it works bad. You assume that problem is in testfinder.py. Then, you just take the entire list of options and call ./testfinder.py with them. And it shows, how it parses its arguments, and what is reminded. Seems correct and shouldn't be an error.

Still, maybe better to print unhandled options first, to be more noticeable.


-- 
Best regards,
Vladimir

