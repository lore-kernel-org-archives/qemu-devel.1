Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F152C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:02:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 140EC20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BdX1c9bz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140EC20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEDk5-0004Sa-4k
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEDic-0003QG-Sw
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEDib-00005V-9D
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:01:22 -0400
Received: from mail-eopbgr130108.outbound.protection.outlook.com
 ([40.107.13.108]:40099 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jEDiQ-0007Xq-FP; Tue, 17 Mar 2020 11:01:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NG3c/DV9ddiwqXS6KZ+Q8h9ghxsGMcvxJwoyOUZ0oTiLE57OhpAx5a0JLi6bIQCTya84W1oyBxXOVRoW1ftc6vqoCUi5+aIhBAYXR5DAuuEgFVnTyRKXh44MyZVCKsjE6e23rEM6VDhS88wa5O0iuIHcDklLcxMHewM2NluWcUglAO7q6D9FBpcFaOkhg4IqiXiS1BXS+pDbwdwTmsUNMCM1t1tkXJOt4pos2FJvKSyglP55jsDElXybRQwy4i8mBDORcva62NIgYT0lLgOXvTLksT9TtWrb9A28GsRYt6h9w0u1D9BrdAp4THplWOyAUHMQaZFVhEg1eSPSHwhLrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xam7mxUsfLlk/DyuDnZF6GQJ9BBDXBG2TMzX+c19+9A=;
 b=n+uyEwjpgzfY8IlH/LiAWVuiGvnTqdg7c/l4Mwq5FgwM6lzoFq1qrlFBB0H2jjtVT313wslw5HCqo42vj4iYJXlS4WGo8j4+Q4H61o17ixCc/RcV5HkecwwU4lFSNAi7TlXpT9Gpp0AzzemJrLNH5dKDIYTIfINsDSYBHxIoeYEJBmwj8fNb6f4aozS/vv/nfKVG84N3zLDvg8+QYNF/+gd6RngEMJpHHHTwgJ+1uPRjHyFDdyhxpPEaYlpb9LOjVoU9PWwMD9b2e3FJyk4II/gAeWBk6zwIakzJ/pFRyIZPicwhnCOpbxnQR1fhhWUv5n2t1oCH627BbJGAfCupfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xam7mxUsfLlk/DyuDnZF6GQJ9BBDXBG2TMzX+c19+9A=;
 b=BdX1c9bze/sEbmmNKA4KE3j57BvLEkRmESH2uq/Yt6JdG6KYIVYokII4yAK6aPDAEHy6ngDKH+bSjCyvDrOIH/QPAo0xfenr3sL8AnQHGRcEf74cmBmLydfalMSWtGNoLENcWqgB5ZovftW5vwmPuiLdymIyF2XygBfFpwohNwk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2188.eurprd08.prod.outlook.com (10.172.126.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13; Tue, 17 Mar 2020 15:01:03 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2814.021; Tue, 17 Mar
 2020 15:01:03 +0000
Subject: Re: [PATCH v3 1/4] scripts/simplebench: add simplebench.py
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20200228071914.11746-1-vsementsov@virtuozzo.com>
 <20200228071914.11746-2-vsementsov@virtuozzo.com>
 <CAL1e-=hX=7OJP-Rpc5TtVQkftq_F3wrh-auYt7yjAe+2i3whHQ@mail.gmail.com>
 <75b4d5ad-f95f-dab2-1b53-5e654c29015e@virtuozzo.com>
 <CAL1e-=gkw9_UJ-0zYx_qUYfRpGmpi-otXf2VnR=5SYDhm=RCGw@mail.gmail.com>
 <CAL1e-=gcf5DY_mCFoQ-0pVJp7jG6w5eQimk7+W5=MTgZ9Emb-Q@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200317180100370
Message-ID: <3e1701d8-9068-cbb1-34e8-1f88946dbfcc@virtuozzo.com>
Date: Tue, 17 Mar 2020 18:01:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <CAL1e-=gcf5DY_mCFoQ-0pVJp7jG6w5eQimk7+W5=MTgZ9Emb-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0031.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::18) To HE1PR0802MB2507.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.248) by
 ZR0P278CA0031.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21 via Frontend Transport; Tue, 17 Mar 2020 15:01:02 +0000
X-Tagtoolbar-Keys: D20200317180100370
X-Originating-IP: [185.215.60.248]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6606fe5f-86d2-44e7-6783-08d7ca840305
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2188:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB218837AEE24FF004FDBB72B4C1F60@HE1PR0802MB2188.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39850400004)(376002)(136003)(366004)(396003)(346002)(199004)(316002)(52116002)(478600001)(966005)(4326008)(53546011)(31686004)(8936002)(66556008)(66476007)(66946007)(5660300002)(36756003)(86362001)(956004)(2616005)(16526019)(81156014)(81166006)(8676002)(186003)(26005)(31696002)(54906003)(2906002)(6486002)(16576012)(6916009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2188;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iTuhfCqZA0WdgmqxweKKCiJkVFAA6FQU/Tu0MP5jOLB/weioHKgaMVfvJ2VlTh3r9SjlILuH/+DWibvHhDnjl3F7xmx0niUAheHiqNQKXx7oVVXtPp1LGqjvNQyDsReoGYcpHL+OQCMXOjZUNcq4YqiMvcjj9exyZdNYkUVPPNdTlbw3ja2oQUSdKlCUZK5i29ppydjQNaK0dd4xBFy9uKXJJJ6K6GyH++W8IPa9VRN2wFY3DGHAXgE4MmfrorvWsc6/hCODkmzb1etbUNysAh33/C0gIW0V+W3wFANiZU6GnZnQSKtC65CGBYk8iM5W8GKFXlYGcAT2tnG6ci2tJErfeVKRkaMml/dBxGtGVv+xRmOum6k8bTND2lteMBTLwKQu3rgfTtb6akL3q28esHpECBNpaSw+Pvvk2bAYQbiB7hqvewhqMSEVhehWbuaSm6Csx+qoofurEr8skwnRJR28jYmif1pFfBpdTuaywKWgdLWRSDmee5cJp0vKoTTxsZfuazDmZtDAHxeChOa4IQ==
X-MS-Exchange-AntiSpam-MessageData: KSIhPNrwemFGxzicUMXsfSK1dye1G3PwfvlF1VMl/icTuxh0r7wqiFT6nXbwRLsu8rnZtbtItHUyMDoS9dpnsebVqfUYokVqWML7ZmdfG1P+Hi3oZenI0C61PYrUqQIaI0USC3P9ytsjrgVWsKjF8A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6606fe5f-86d2-44e7-6783-08d7ca840305
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 15:01:03.4922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qstgMN79V8iQu8bp6Mlm5CAmfWC0FbOqLGgiX+4XRjTF15ZiPDsqZ42La47F725NRaBmEsv6ly9x8h+X9XFkveZWQ8UXyXNYVTXVREXxVvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2188
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.13.108
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

17.03.2020 17:40, Aleksandar Markovic wrote:
> On Mon, Mar 2, 2020 at 10:05 PM Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
>>
>>
>>
>>
>>>>> +
>>>>> +
>>>>> +def ascii_one(result):
>>>>> +    """Return ASCII representation of bench_one() returned dict."""
>>>>> +    if 'average' in result:
>>>>> +        s = '{:.2f} +- {:.2f}'.format(result['average'], result['delta'])
>>>>> +        if 'n-failed' in result:
>>>>> +            s += '\n({} failed)'.format(result['n-failed'])
>>>>> +        return s
>>>>> +    else:
>>>>> +        return 'FAILED'
>>>>
>>>> I think it would be visually clearer if "+-" was printed without any
>>>> space between it and the following number, using something
>>>> like this:
>>>>
>>>> s = ' {:.2f} +-{:.2f}'.format(result['average'], result['delta'])
>>>>
>>>> The resulting table would look like:
>>>>
>>>> ----------  -------------  -------------  -------------
>>>>               backup-1       backup-2       mirror
>>>> ssd -> ssd   0.43 +-0.00    4.48 +-0.06    4.38 +-0.02
>>>> ssd -> hdd   10.60 +-0.08   10.69 +-0.18   10.57 +-0.05
>>>> ssd -> nbd   33.81 +-0.37   10.67 +-0.17   10.07 +-0.07
>>>> ----------  -------------  -------------  -------------
>>>>
>>>> But, this is just cosmetics.
>>>>
>>>> With or without the suggestion above:
>>>>
>>>> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>
>>> Thanks for reviewing!
>>>
>>> Agree with this change, but I don't think it worth to resend the series for this one space)
>>> Hope it may be applied with pull request..
>>>
>>
>> I am an occasional Python programmer, and I felt comfortable
>> reviewing your series, but I am not a maintainer of this directory,
>> and I believe Eduardo or Cleber or other more active Python
>> contributors would be better choice for selecting this series in
>> their pull request.
>>
>> So, I can't send this series to Peter - Cleber, Eduardo, please
>> see to it.
>>
> 
> Eduardo, can you perhaps consider this series for selecting
> into your pull request?

I saw, he has taken the patches into python-next in:
https://github.com/ehabkost/qemu/commits/python-next

Hope, pull request will come)


> 
> Thanks,
> Aleksandar
> 
>> Yours,
>> Aleksandar
>>
>>>>
>>>>> +
>>>>> +
>>>>> +def bench(test_func, test_envs, test_cases, *args, **vargs):
>>>>> +    """Fill benchmark table
>>>>> +
>>>>> +    test_func -- benchmarking function, see bench_one for description
>>>>> +    test_envs -- list of test environments, see bench_one
>>>>> +    test_cases -- list of test cases, see bench_one
>>>>> +    args, vargs -- additional arguments for bench_one
>>>>> +
>>>>> +    Returns dict with the following fields:
>>>>> +        'envs':  test_envs
>>>>> +        'cases': test_cases
>>>>> +        'tab':   filled 2D array, where cell [i][j] is bench_one result for
>>>>> +                 test_cases[i] for test_envs[j] (i.e., rows are test cases and
>>>>> +                 columns are test environments)
>>>>> +    """
>>>>> +    tab = {}
>>>>> +    results = {
>>>>> +        'envs': test_envs,
>>>>> +        'cases': test_cases,
>>>>> +        'tab': tab
>>>>> +    }
>>>>> +    n = 1
>>>>> +    n_tests = len(test_envs) * len(test_cases)
>>>>> +    for env in test_envs:
>>>>> +        for case in test_cases:
>>>>> +            print('Testing {}/{}: {} :: {}'.format(n, n_tests,
>>>>> +                                                   env['id'], case['id']))
>>>>> +            if case['id'] not in tab:
>>>>> +                tab[case['id']] = {}
>>>>> +            tab[case['id']][env['id']] = bench_one(test_func, env, case,
>>>>> +                                                   *args, **vargs)
>>>>> +            n += 1
>>>>> +
>>>>> +    print('Done')
>>>>> +    return results
>>>>> +
>>>>> +
>>>>> +def ascii(results):
>>>>> +    """Return ASCII representation of bench() returned dict."""
>>>>> +    from tabulate import tabulate
>>>>> +
>>>>> +    tab = [[""] + [c['id'] for c in results['envs']]]
>>>>> +    for case in results['cases']:
>>>>> +        row = [case['id']]
>>>>> +        for env in results['envs']:
>>>>> +            row.append(ascii_one(results['tab'][case['id']][env['id']]))
>>>>> +        tab.append(row)
>>>>> +
>>>>> +    return tabulate(tab)
>>>>> --
>>>>> 2.21.0
>>>>>
>>>>>
>>>
>>>
>>> --
>>> Best regards,
>>> Vladimir


-- 
Best regards,
Vladimir

