Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E019C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 13:49:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18F7324699
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 13:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YUuqVyqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F7324699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7g0q-0002bF-5x
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 08:49:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7g06-000227-60
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 08:48:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7g04-0001j6-Gk
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 08:48:22 -0500
Received: from mail-vi1eur05on2132.outbound.protection.outlook.com
 ([40.107.21.132]:37409 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7fzz-0001fI-Ps; Fri, 28 Feb 2020 08:48:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOvJadAgaOy8jBRQjtWvotAWzfftUJXVSeWnMjymWw8BqbFZpw6kVfG2AsqFEDtllSqKTgECCca/fHahC+Nrhape3/eO5r49CRXOihHqYVIC7OPCLcqS2XpFOjwkSPAcRdsYb4KAtlDy+mkxVeYJlNl1nFQlC7tCeZ/q0LrGHgHDDaqQIPI/WaFYNR8IOHLXEdl2Jm1WswT4Mc8467Dc6xyGab1PcXMFn4vrzALl6Q0DCMZmCV2FMsMIxw6fFzYmqWRvIegqQDZ824Hl0ohz4eMWHfYLfTPoMVxFbpv9yoh2fj7sJKFqPJkLoGi0Gp/lg8ZuAQztOcOsgfL2WvJkqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTOA39/fPXwfyL5nsk9vOEq0HFG1y/ZKgarR/jLm/m8=;
 b=jTQCgGtM/fEdP9n8UqTSZBk5QTK2yHar7ZnFKUW4oNjLFdqm/4OsjIQ8bTHO67MHGqG0aWXWi3hX3+XfJz8FDyjgYtEHv3y5KGl45TESf4e3vKmWWex7Wo423cW6H5rzXRozqP2pMHVE22gOxb20+QOCsHPLN8Co3rfXqdsDof0xfpf0JMoatptez4d+SfU7OeDPQEAwKdisx6VT08Dm7CBExaGHL7Rr/VtyzaSfoJ4NyBARkzP6p9qgcVMqJKYZ37+Oy/yt/MT0w+JeocHqpsv/UyEIV+jscRobzbTReeg6Tt5Tunohp7ucNP0hCxJEcUsG4/ZYna9RCKvPtj1fSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTOA39/fPXwfyL5nsk9vOEq0HFG1y/ZKgarR/jLm/m8=;
 b=YUuqVyqZzLAgRc0njU/T1/DLGVsqV0bd5YTUQhiAWeoBdP34DmnllmEVrD+ytNsdx7AhuGst1nyQEKlY0RhNn1V1fYDWm+G7WHPGyzApKMW7+ZLlg07gLHYr+Z/0CKaE0BWszaDD3TxUIB45L7openpnS4KVmLKRkmIrUj433pY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3173.eurprd08.prod.outlook.com (52.135.167.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Fri, 28 Feb 2020 13:48:12 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.024; Fri, 28 Feb 2020
 13:48:12 +0000
Subject: Re: [PATCH v3 1/4] scripts/simplebench: add simplebench.py
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20200228071914.11746-1-vsementsov@virtuozzo.com>
 <20200228071914.11746-2-vsementsov@virtuozzo.com>
 <CAL1e-=hX=7OJP-Rpc5TtVQkftq_F3wrh-auYt7yjAe+2i3whHQ@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200228164810355
Message-ID: <75b4d5ad-f95f-dab2-1b53-5e654c29015e@virtuozzo.com>
Date: Fri, 28 Feb 2020 16:48:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <CAL1e-=hX=7OJP-Rpc5TtVQkftq_F3wrh-auYt7yjAe+2i3whHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR06CA0149.eurprd06.prod.outlook.com
 (2603:10a6:7:16::36) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR06CA0149.eurprd06.prod.outlook.com (2603:10a6:7:16::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Fri, 28 Feb 2020 13:48:11 +0000
X-Tagtoolbar-Keys: D20200228164810355
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2413e41c-50d0-484f-a76c-08d7bc54da6e
X-MS-TrafficTypeDiagnostic: AM6PR08MB3173:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3173E14EE78AC59B9CD9BC19C1E80@AM6PR08MB3173.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0327618309
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(366004)(136003)(39850400004)(346002)(199004)(189003)(66556008)(5660300002)(66946007)(6486002)(2616005)(66476007)(26005)(54906003)(956004)(16576012)(316002)(478600001)(53546011)(52116002)(16526019)(4326008)(31686004)(186003)(6916009)(36756003)(86362001)(8936002)(8676002)(81166006)(31696002)(2906002)(81156014)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3173;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sF8YvpuscgmJFT2lcNRmXrG3C8q3RDmh6lBaYUFdXkRskIkXazw4PdM28WG85mZilbkQTQJZDmNuocMP0PYxqj7M6iKO5sT9kSiUDYjui3NyM4CpHUNhwa6abkuHmSSC7C7zPQsVKJipcfY7cXfp2msM4LuuRQLFDqxhW00TU9Ymsh7wFD697vu4UJ710cYDuFEIztKUIh+JYxaFgk261VQ1cHZ8yC98CJ5aG+JKmZI/iZCCH6eCQwf5hrl1kbCAc2P+/Ldli2eGJAIzFkNnzSgowZVcwyVHGsA7+oQ14i7vr8/E2Lb6DPfABL2UrvSFFOGvjLBtwvlatvUa88LnV/f7+4coPeQRc2OsaTPOVUwaZINBcODyE735C+fm793bXx6Fsf9SbuAeOzfig+qW6T36kxlBE2k2B7MdDJrIp9xQKMtpuOllMf28EfkRTcHSkcRaKLfYPAdsB2DA2nPMDUy+6xEdpWzlcziqpeaQm58OfXkGr70mrZdS3ZFg4ugfH5vrqTcH1P6lWNKz/dTch6EdCyYCBLeNt+ONT/88e1fenpsMKtGwB29qjbszABMH
X-MS-Exchange-AntiSpam-MessageData: 3fY4OtlFaUzHiFXaUMIFQ8m8wtG+rH6F4JWFwxSzU6w7Dv16e2V2YiGGdSgfnM+GHeu4lgJZg3gmWH5Hv6IPnlVC7Ni5WeNIu55fabbjioS/F+eo4CMXdWoO0JV56D4u94dKorDGNkXrW2JbLGOLOQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2413e41c-50d0-484f-a76c-08d7bc54da6e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 13:48:12.6592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfHZgKyAlwKoP0YRaaFvTt69oqnEjOr6fmSqqjHOYZeCotzRlAxiqrAPTUNbf/qKkgJRrFlW9QZtRPbVeFmD8uwMCZRMjPArLed8v4WeTnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3173
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.21.132
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
 "open list:bochs" <qemu-block@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

28.02.2020 16:03, Aleksandar Markovic wrote:
> On Fri, Feb 28, 2020 at 8:19 AM Vladimir Sementsov-Ogievskiy
> <vsementsov@virtuozzo.com> wrote:
>>
>> Add simple benchmark table creator.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   scripts/simplebench/simplebench.py | 128 +++++++++++++++++++++++++++++
>>   1 file changed, 128 insertions(+)
>>   create mode 100644 scripts/simplebench/simplebench.py
>>
>> diff --git a/scripts/simplebench/simplebench.py b/scripts/simplebench/simplebench.py
>> new file mode 100644
>> index 0000000000..59e7314ff6
>> --- /dev/null
>> +++ b/scripts/simplebench/simplebench.py
>> @@ -0,0 +1,128 @@
>> +#!/usr/bin/env python
>> +#
>> +# Simple benchmarking framework
>> +#
>> +# Copyright (c) 2019 Virtuozzo International GmbH.
>> +#
>> +# This program is free software; you can redistribute it and/or modify
>> +# it under the terms of the GNU General Public License as published by
>> +# the Free Software Foundation; either version 2 of the License, or
>> +# (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> +#
>> +
>> +
>> +def bench_one(test_func, test_env, test_case, count=5, initial_run=True):
>> +    """Benchmark one test-case
>> +
>> +    test_func   -- benchmarking function with prototype
>> +                   test_func(env, case), which takes test_env and test_case
>> +                   arguments and returns {'seconds': int} (which is benchmark
>> +                   result) on success and {'error': str} on error. Returned
>> +                   dict may contain any other additional fields.
>> +    test_env    -- test environment - opaque first argument for test_func
>> +    test_case   -- test case - opaque second argument for test_func
>> +    count       -- how many times to call test_func, to calculate average
>> +    initial_run -- do initial run of test_func, which don't get into result
>> +
>> +    Returns dict with the following fields:
>> +        'runs':     list of test_func results
>> +        'average':  average seconds per run (exists only if at least one run
>> +                    succeeded)
>> +        'delta':    maximum delta between test_func result and the average
>> +                    (exists only if at least one run succeeded)
>> +        'n-failed': number of failed runs (exists only if at least one run
>> +                    failed)
>> +    """
>> +    if initial_run:
>> +        print('  #initial run:')
>> +        print('   ', test_func(test_env, test_case))
>> +
>> +    runs = []
>> +    for i in range(count):
>> +        print('  #run {}'.format(i+1))
>> +        res = test_func(test_env, test_case)
>> +        print('   ', res)
>> +        runs.append(res)
>> +
>> +    result = {'runs': runs}
>> +
>> +    successed = [r for r in runs if ('seconds' in r)]
>> +    if successed:
>> +        avg = sum(r['seconds'] for r in successed) / len(successed)
>> +        result['average'] = avg
>> +        result['delta'] = max(abs(r['seconds'] - avg) for r in successed)
>> +
>> +    if len(successed) < count:
>> +        result['n-failed'] = count - len(successed)
>> +
>> +    return result
>> +
>> +
>> +def ascii_one(result):
>> +    """Return ASCII representation of bench_one() returned dict."""
>> +    if 'average' in result:
>> +        s = '{:.2f} +- {:.2f}'.format(result['average'], result['delta'])
>> +        if 'n-failed' in result:
>> +            s += '\n({} failed)'.format(result['n-failed'])
>> +        return s
>> +    else:
>> +        return 'FAILED'
> 
> I think it would be visually clearer if "+-" was printed without any
> space between it and the following number, using something
> like this:
> 
> s = ' {:.2f} +-{:.2f}'.format(result['average'], result['delta'])
> 
> The resulting table would look like:
> 
> ----------  -------------  -------------  -------------
>              backup-1       backup-2       mirror
> ssd -> ssd   0.43 +-0.00    4.48 +-0.06    4.38 +-0.02
> ssd -> hdd   10.60 +-0.08   10.69 +-0.18   10.57 +-0.05
> ssd -> nbd   33.81 +-0.37   10.67 +-0.17   10.07 +-0.07
> ----------  -------------  -------------  -------------
> 
> But, this is just cosmetics.
> 
> With or without the suggestion above:
> 
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Thanks for reviewing!

Agree with this change, but I don't think it worth to resend the series for this one space)
Hope it may be applied with pull request..

> 
>> +
>> +
>> +def bench(test_func, test_envs, test_cases, *args, **vargs):
>> +    """Fill benchmark table
>> +
>> +    test_func -- benchmarking function, see bench_one for description
>> +    test_envs -- list of test environments, see bench_one
>> +    test_cases -- list of test cases, see bench_one
>> +    args, vargs -- additional arguments for bench_one
>> +
>> +    Returns dict with the following fields:
>> +        'envs':  test_envs
>> +        'cases': test_cases
>> +        'tab':   filled 2D array, where cell [i][j] is bench_one result for
>> +                 test_cases[i] for test_envs[j] (i.e., rows are test cases and
>> +                 columns are test environments)
>> +    """
>> +    tab = {}
>> +    results = {
>> +        'envs': test_envs,
>> +        'cases': test_cases,
>> +        'tab': tab
>> +    }
>> +    n = 1
>> +    n_tests = len(test_envs) * len(test_cases)
>> +    for env in test_envs:
>> +        for case in test_cases:
>> +            print('Testing {}/{}: {} :: {}'.format(n, n_tests,
>> +                                                   env['id'], case['id']))
>> +            if case['id'] not in tab:
>> +                tab[case['id']] = {}
>> +            tab[case['id']][env['id']] = bench_one(test_func, env, case,
>> +                                                   *args, **vargs)
>> +            n += 1
>> +
>> +    print('Done')
>> +    return results
>> +
>> +
>> +def ascii(results):
>> +    """Return ASCII representation of bench() returned dict."""
>> +    from tabulate import tabulate
>> +
>> +    tab = [[""] + [c['id'] for c in results['envs']]]
>> +    for case in results['cases']:
>> +        row = [case['id']]
>> +        for env in results['envs']:
>> +            row.append(ascii_one(results['tab'][case['id']][env['id']]))
>> +        tab.append(row)
>> +
>> +    return tabulate(tab)
>> --
>> 2.21.0
>>
>>


-- 
Best regards,
Vladimir

