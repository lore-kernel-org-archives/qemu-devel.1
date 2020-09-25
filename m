Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97754C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1EE208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wgELemRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1EE208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLr4P-0002XS-Th
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLr39-0001qR-AX; Fri, 25 Sep 2020 12:58:23 -0400
Received: from mail-eopbgr40129.outbound.protection.outlook.com
 ([40.107.4.129]:14406 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLr36-0003UF-CQ; Fri, 25 Sep 2020 12:58:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3qzYGAdvQpOqi2LJHu2qHfPscubJq1Cu5h+n22v6/3gfTEVj3S452jEXjjQAncZn59gSBxr6cVBJqELoy6NYO/MJnLsW1zo5ghn25p6SM5MIIRzo91vBn4QwguOcnRJRxxdFp8NfLWAzmxAQ5vPzADrEqPrw92xENNA+s2qkqHnlrc+ANyzJMoa/grc7QXmC8pPtN/0IlPPDDiH0xskNECQV6bj5WVqZI91/bQmxsYpk6qtRPdw7OGEwVKOiOYSaxP7Z7+gsdCUcHf4a447ocBe0bxf1ux3UxLd09AgOmT+GDt1H0x8ui/CtSexF+7jbtQj4UTwu/0R/QhvFhFAhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qowZAi6Nu3T94fZxEdleh1LF5XED+vBkDYdlDZguqJI=;
 b=dXT2zAUjko4t/PuzI6g0W+HSxJo70+k/n6se8TfPRT5EPf9Ugql6JJ5E/d2bzT2lfXCblWHrd3cXZGwg0kWIrSpSVRoiqBBKv/KjeeaHZHsQv5+Ne8u1SynbvQzg0uj4bsz2QoY8QkxvM+SQk5LO121uGL1Cj2qpJxBgAOHwHmDR63IPQsMqihgvWk9dcNIAIjdqX1cIwppeHKnkEBhISlN+eeVJM2XsAjhw+TRtv69w/vqfU2ihSdXPQQ87S1k7ZsrrhVWWm9ZtnUF7ZWiCexlkRxx/H4A5+VFmZzrqPcHcKphhlbht/af+fCOMvJ2CWARMyRNuafgR9aESvMXPSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qowZAi6Nu3T94fZxEdleh1LF5XED+vBkDYdlDZguqJI=;
 b=wgELemRJoWcJR9jOgH3WwluS1PqAZ0vjiLVwQRV8DRkq+5h/mP2DrggtFCRv6eFHXME2Tq8OYPyTX/OQb8iSNBt/XJHRCLSdeSxx93miQksK8fpDuS61ej2uZd/e9b89TVqOkWoDMO/AuO2XlqnHxrnmoiUDnfLCRoXgRrtqNW8=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4279.eurprd08.prod.outlook.com (2603:10a6:20b:bb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Fri, 25 Sep
 2020 16:58:17 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Fri, 25 Sep 2020
 16:58:17 +0000
Subject: Re: [PATCH v6 13/15] scripts/simplebench: improve view of ascii table
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 fam@euphon.net, stefanha@redhat.com, kwolf@redhat.com, den@openvz.org
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
 <20200918181951.21752-14-vsementsov@virtuozzo.com>
 <ce8df484-251f-dac5-1f46-eb8eeff3a3c9@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e2f6d8a7-49c1-a515-41eb-7afb5773819e@virtuozzo.com>
Date: Fri, 25 Sep 2020 19:58:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <ce8df484-251f-dac5-1f46-eb8eeff3a3c9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR07CA0136.eurprd07.prod.outlook.com
 (2603:10a6:207:8::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.94) by
 AM3PR07CA0136.eurprd07.prod.outlook.com (2603:10a6:207:8::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.14 via Frontend Transport; Fri, 25 Sep 2020 16:58:16 +0000
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5157407-212a-4e3e-cbe8-08d8617432b3
X-MS-TrafficTypeDiagnostic: AM6PR08MB4279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4279058C51E497C25C26C969C1360@AM6PR08MB4279.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CqJE3rLVII3UvUMgjbSEvYxj3McKxiBndrSC11txSCB9JxhdaqTyXxNw0l1ebvlN5Sf6xsxbDfzjI3HpsmEHS2A9tEsHnh1+ztaJIlf9qx/aL3LoIh+ugtjPduNWbTMU8h09AA69SglZ+FbKyooAVmIbahHxwcOWia3v4NpwIalJqyfh9N2poD1rRQ8qGCmRXQtYEEE4z+3pZ3Jl7gQ4PZsTleNRL3Al13hsJZgMS20of63VSJbBctaK/vfRY11pnJdxaOTFRm/xnAJ6Ni3x5q+U+7MoZ6Mof58bF7MKtW5/MxfDeSWsNt65GhljHOQq4W203jLBBe4C3DM9uHnlc6NIH0qap/nUt52nq8MOU2hU2dtJOchg0m2xAt4RlFNgNLCy11GkLazJo3wytVT4JEJ4p37klP4LHEHxOraXUlJVox3Ht9nV15Mxc+7zppZD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(366004)(396003)(346002)(376002)(136003)(66476007)(66556008)(31696002)(6486002)(66946007)(956004)(316002)(86362001)(2616005)(16576012)(4326008)(36756003)(31686004)(8936002)(107886003)(83380400001)(2906002)(186003)(26005)(52116002)(53546011)(16526019)(478600001)(8676002)(5660300002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: oyOMzCxnuSXAqX2I0KaGp0x9mvxYqPy1oPVGeWX+p7auQpA2gcP6cSRJS9f1KjBc0xNu4ZwE5GKuG1Pa6TIbsAltp1XtgelLB8Gnq++r4Q6mlzltxE7ivubkNvxY4EDPV3ZaYvsUjbkWFcMEnJZKvRiYoC6q/4ilPx28m/eY+CEq5QGzy6g8jmxnFzBen0QduxCme0o8Cyw1aonLhsDy1XJAX4NY5OooL52VtGOiZfIAvpOOZZDjfyv4XQWmh7+q0lwUUMEL+brz9kQt6C4mYfxoui2oThDESBH3t4+e7gxPAhSVI3gQ332ZCiPlnDKNqBixN1KGZVPR6Jm10Y1Ex7p7mLPk1AUlKB2uCAA55T6Ih9ZVW7FY92SiljLk4+BGwx+bM0Ch1zESPw+nn3B4/8QRJx2jdOuobvdRK4zOA/c0Dd6P0QyKsS2tE32KULAInaKX8PZ+3iT10JkouVLTEmj5LnGqIpUHNwe0/DRT0i+QWqovcA06hVl8IRqrNFldrg5KGv3UcN2aQVWiZudgDOJ7DugPVbKRtktixgrFuPik18UhFCjEe1YAbapP7e7y7jPc/KeUAZ/oaI8YX9nTmMY3NG5QYxtT4pOlkMKqYWApNpVvwBhc2FnsYdJNIl9y63flyNsytTbesHMaCD+xYw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5157407-212a-4e3e-cbe8-08d8617432b3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 16:58:16.9402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8m3SCtLVdElDBjwk8EOCDQpagL3muF0tybPjAbOh8+De9Tzg72zUk6VJPe+uVqW1oWa2wkTIIkrtWnBeVU0vHUKtyKZn3nV2NR0/JALmEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4279
Received-SPF: pass client-ip=40.107.4.129;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 12:58:18
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

25.09.2020 12:31, Max Reitz wrote:
> On 18.09.20 20:19, Vladimir Sementsov-Ogievskiy wrote:
>> Introduce dynamic float precision and use percentage to show delta.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   scripts/simplebench/simplebench.py | 26 +++++++++++++++++++++++++-
>>   1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/simplebench/simplebench.py b/scripts/simplebench/simplebench.py
>> index 716d7fe9b2..56d3a91ea2 100644
>> --- a/scripts/simplebench/simplebench.py
>> +++ b/scripts/simplebench/simplebench.py
>> @@ -79,10 +79,34 @@ def bench_one(test_func, test_env, test_case, count=5, initial_run=True):
>>       return result
>>   
>>   
>> +def format_float(x):
>> +    res = round(x)
>> +    if res >= 100:
>> +        return str(res)
>> +
>> +    res = f'{x:.1f}'
>> +    if len(res) >= 4:
>> +        return res
>> +
>> +    return f'{x:.2f}'
> 
> This itches me to ask for some log() calculation.
> 
> Like:
> 
> %.*f' % (math.ceil(math.log10(99.95 / x)), x)
> 

Oh yes, that's cool.

> 
>> +def format_percent(x):
>> +    x *= 100
>> +
>> +    res = round(x)
>> +    if res >= 10:
>> +        return str(res)
>> +
>> +    return f'{x:.1f}' if res >= 1 else f'{x:.2f}'
> 
> Same here.  (Also, why not append a % sign in this function?)

OK

> 
>>   def ascii_one(result):
>>       """Return ASCII representation of bench_one() returned dict."""
>>       if 'average' in result:
>> -        s = '{:.2f} +- {:.2f}'.format(result['average'], result['delta'])
>> +        avg = result['average']
>> +        delta_pr = result['delta'] / avg
>> +        s = f'{format_float(avg)}±{format_percent(delta_pr)}%'
> 
> Pre-existing, but isn’t the ± range generally assumed to be the standard
> deviation?
> 

Hmm. Actually, why not, let's just use standard deviation. I wanted to show maximum deviation, not mean, to not miss some bugs in experiment (big deviation of one test run). Still, seems standard deviation is good enough in it.

> 
>>           if 'n-failed' in result:
>>               s += '\n({} failed)'.format(result['n-failed'])
>>           return s
>>
> 
> 


-- 
Best regards,
Vladimir

