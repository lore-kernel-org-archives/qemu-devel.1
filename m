Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6759C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D2420757
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BPvlIi+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D2420757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK3UK-0000jc-EH
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 13:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jK3TB-00005u-NO
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jK3T9-0006Pw-A1
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:17:32 -0400
Received: from mail-eopbgr20097.outbound.protection.outlook.com
 ([40.107.2.97]:1873 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jK3T8-0006P1-E8
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:17:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyULoYlTGVR+4z8RAi7QRXKnEELg491e2g8FqSuu47Braatik2CY8eIJm1Se0wMqktLKEjaA6kQEMqB3QEMw9T+3IPfJCFg5bdWoQ+zWdrIIlUt5BvXZ1l/2u3w2L9DjfHNv/A5wqmi/3X0s+xNSLZCX1t65x28rUeU4BQh5itM8xPJ5L/QH8vHfYBtBBDvyJ3QW4QjoQ+E33IB0dpEEaINdUmnOTCvGJT4J/0jnF9/V2dU0coy204KGlT4JOguF6p/Nq+6MZcJ8kYSJyW7GJZ04tDIJ6o6dNKMhtdrX41b6UW+t+pSSgvjkZQHPH87oEF6cefQ449ktlhmzUgoSfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGR+HhFlKdAnMr4UzZzT+96svfVS+3gjbREaONcOWsA=;
 b=DPey8MOO4jsqdBROfu7VDSUWwonAsaWf18U8pCZpv2pRGeVbE36ltIRMzTxUXaZbiIE8A2ZjOMt4K4R8fLRrKEUZ+qIGjAHYxghHYxV6kQcK48QER7aY/BGzlcS/AJjc6oX8tmM0t10xT3ApBuh4SZ9/iOe2rge5N5fqbNSzp61yivF/QewAd+v9qpHUGAgG9XYuYj836VT06Y2xbLzct+uu7zSk+Cu6pnUqjTquD43jDX5lJ2p5MT3T/ZZjxoUt9hy9aDDpT7YjFSGWTmO+DBJGUcACcmjsyszQQh7taPGug1YX65eYivZRum5oxPJ+HH1ZXo6cp3YNGxfQ7YIAQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGR+HhFlKdAnMr4UzZzT+96svfVS+3gjbREaONcOWsA=;
 b=BPvlIi+G1gpkM+vmX6rqhb4hensqydcxTX/h2A/DN6RBx8M0/qZaOj2TxpKgwcw3ZSgetFdDPCqXpfg/8vRlAzGV9SHzJOThODfWk+zvI2CTvEYM93pXyKsYhnPV189rJ9tAS+n9KNr0zykDDCU6zsRFv4ylQnpf4wuStiCDxgs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5352.eurprd08.prod.outlook.com (10.141.174.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Thu, 2 Apr 2020 17:17:27 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.016; Thu, 2 Apr 2020
 17:17:27 +0000
Subject: Re: Questionable aspects of QEMU Error's design
To: Markus Armbruster <armbru@redhat.com>
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <CAFEAcA_b1gZ-B4NaEdQS2zffdvobW=FUx4ysEgXVAz+=cZ+R3Q@mail.gmail.com>
 <87sghmbfgc.fsf@dusky.pond.sub.org>
 <44b5ff2c-6dce-e516-a9cc-9d80354c5a72@virtuozzo.com>
 <CAFEAcA_cmOkR4YsDmP7mDdKzs0jTu3WDO=d1uvMxHguvZjGW_g@mail.gmail.com>
 <877dyy9shs.fsf@dusky.pond.sub.org>
 <045198b9-29d8-231c-d35c-440723308003@virtuozzo.com>
 <878sjegc5a.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200402201726346
Message-ID: <cf346d30-c233-50a1-b1fa-f5be20bfd891@virtuozzo.com>
Date: Thu, 2 Apr 2020 20:17:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <878sjegc5a.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0039.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::19) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.23) by
 AM0PR10CA0039.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Thu, 2 Apr 2020 17:17:27 +0000
X-Tagtoolbar-Keys: D20200402201726346
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1893a53f-9f3a-456d-2a26-08d7d729b7f4
X-MS-TrafficTypeDiagnostic: AM7PR08MB5352:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5352B56CE487113C59C7950BC1C60@AM7PR08MB5352.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39840400004)(346002)(136003)(396003)(376002)(366004)(26005)(66946007)(86362001)(66476007)(66556008)(36756003)(2906002)(316002)(16576012)(2616005)(5660300002)(81166006)(54906003)(8676002)(81156014)(52116002)(16526019)(478600001)(31696002)(6916009)(31686004)(186003)(8936002)(6486002)(956004)(4326008);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D/wFb8MnAaodsMbxbGYIXcUxKiC2vt84gK5v7c94bFuFkgNQQ7hE99zWXinJ2HIEVot5WSaaneQ1w0h5C+YfXX8Rf5txFMEsZBjlK7YkS2F6lh1Zu1sezZEzoB9fTasWw/dsuB30qO9VwObYsa0wS2z+xxsHcHy7YEKnPW7hnLbTxUlAtyXa8TjwXyn+++eJklNXOtnYbB6Gx4xo47RIM/AbkeRurJh+3meJv8zgeo4wVfyL0zgHfsICV4mtkSeiehltXbPSI66K94VXDRrjs60luXj0GfKU7yNi1Ck45XTxcJ8c42js5S0KQYmYPkgT42IGjzLwNiL9wegzXMHlTikMAQBDiuPAtXf+VlZ5xwCmOkG+VspILTqF8LBrZUcUDiBJJaYsxntQ8xW39Tr+Ia7QKMvYttETyE8A8Fz2U78bcCFpVOMkRpwGkKZG0FO2
X-MS-Exchange-AntiSpam-MessageData: Pq9seGjl3G8BhmQsJfeXJDdTm+j9yFlnj4HeiccE7J51OJuMSdLR502BXKYMkktYZqcQvV+i/NQ1o/75PQnC9LZ702+VxYcny/1oRa2kg3j7bWKXJUurbqrq0/vMoIG7S0p1niAdWyeGrGLVvzkG+g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1893a53f-9f3a-456d-2a26-08d7d729b7f4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 17:17:27.7939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJIbarw5ATE9ynR/F/2K7OtVJjQV7XmivchoO03ri9YYRVEGsheZVgYwXhINH8H06509ekADMJyahwVSbKPzKkfQhNxXwbSEEHGl9CSM7UA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5352
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.2.97
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.04.2020 18:06, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
> 
>> 02.04.2020 11:55, Markus Armbruster wrote:
>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>
>>>> On Thu, 2 Apr 2020 at 07:11, Vladimir Sementsov-Ogievskiy
>>>> <vsementsov@virtuozzo.com> wrote:
>>>>> Somehow, in general, especially with long function names and long parameter lists I prefer
>>>>>
>>>>> ret = func(..);
>>>>> if (ret < 0) {
>>>>>        return ret;
>>>>> }
>>>>
>>>> Personally I prefer the other approach -- this one has an extra line
>>>> in the source and
>>>> needs an extra local variable.
>>>
>>> Me too, except when func(...) is so long that
>>>
>>>       if (func(...) < 0) {
>>>
>>> becomes illegible like
>>>
>>>       if (func(... yadda, yadda,
>>>                yadda, ...) < 0) {
>>>
>>> Then an extra variable can improve things.
>>>
>>>>> Are you sure that adding a lot of boolean functions is a good idea? I somehow feel better with more usual int functions with -errno on failure.
>>>>>
>>>>> Bool is a good return value for functions which are boolean by nature: checks, is something correspond to some criteria. But for reporting an error I'd prefer -errno.
>>>>
>>>> When would we want to return an errno? I thought the whole point of the
>>>> Error* was that that was where information about the error was returned.
>>>> If all your callsites are just going to do "if (ret < 0) { ... } then having
>>>> the functions pick an errno value to return is just extra work.
>>>
>>> 0/-1 vs. true/false is a matter of convention.  Lacking convention, it's
>>> a matter of taste. >
>>> 0/-1 vs. 0/-errno depends on the function and its callers.  When -errno
>>> enables callers to distinguish failures in a sane and simple way, use
>>> it.  When -errno feels "natural", I'd say feel free to use it even when
>>> all existing callers only check < 0.
>>>
>>> When you return non-null/null or true/false on success/error, neglecting
>>> to document that in a function contract can perhaps be tolerated; you're
>>> using the return type the common, obvious way.  But when you return 0/-1
>>> or 0/-errno, please spell it out.  I've seen too many "Operation not
>>> permitted" that were actually -1 mistaken for -EPERM.  Also too many
>>> functions that return -1 for some failures and -errno for others.
>>>
>>
>> I just want to add one note:
>>
>> OK, you like the pattern
>>
>>    if (func()) {
>>        <handle error>
>>    }
>>
>> , I can live with it.
>>
>> I believe, we have a lot of such patterns already in code.
>>
>> Now, we are going to add a lot of functions, returning true on success and false on failure, so add a lot of patterns
>>
>>    if (!func()) {
>>        <handle error>
>>    }
> 
> We already have this pattern all over the place with functions returning
> non-null pointers on success, null pointer on failure.

Functions returning pointer are simpler to distinguish by name.

Hmm, strange. But this pattern lose the pointer.. You mean

ptr = func();
if (!ptr) {
   <handle error>
}

this is much more understandable. Usually ptr variable name and function name - all will help to understand that it's all about pointer.


> 
>> ---
>>
>> After it, looking at something like
>>
>>    if (!func()) {} / if (func()) {}
>>
>> I'll have to always jump to function definition, to check is it int or bool function, to understand what exactly is meant and is there a mistake in the code..
>> So, I'm afraid that such conversion will not help reviewing/understanding the code. I'd prefer to avoid using two opposite conventions in on project.
> 
> C sucks :)
> 
> Conventions help mitigate.  Here's one: when fun() returns
> non-negative/negative on success/error, always use
> 
>      fun(...) < 0

This reduces chances that it fit in one line..

But yes, if all use this convention, it makes it obvious what happening.

> 
> or
> 
>      fun(...) >= 0
> 
> to check.  I dislike the latter.
> 
> When returns 0/negative, always use
> 
>      fun(...) < 0
> 
> Avoid
> 
>      fun(...) >= 0
> 
> because that suggests it could return a positive value, which is wrong.
> 
> Avoid
> 
>      fun(...)
> 
> because that requires the reader to know the return type.

Exactly the problem I mention. To follow your suggestion, we'll have to update
the whole code base.. However, why not.

> 
> When its returns non-null/null or true/false on success/failure, always
> use
> 
>      !fun(...)
> 
> Avoid
> 
>      fun(...)
> 
> because that requires the reader to know the return type.
> 
> Note that we have a usable check for failure in all cases.  Goes well
> with the habit to handle errors like this whenever practical
> 
>      if (failed) {
>          handle failure
>          bail out
>      }
>      handle success
> 

OK. If convert everything to your suggestion it looks good.

The only possible problem is boolean functions, which just check something, not returning the error..

With a function like is_x_in_set(x, set), it's native to write

if (is_x_in_set(x, set)) {

    ...

}

which is a bit in conflict with your suggestion. Still, such functions should be simply distinguished by name.

>> I can also imagine combining different function types (int/bool) in if conditions o_O, what will save us from it?
> 
> Can you give an example?

I just meant something like if (f1() || !f2()) { < error > }, nothing special.

> 
>> And don't forget about bool functions, which just check something, and false is not an error, but just negative answer on some question.
> 
> For what it's worth, GLib specifically advises against such function
> contracts:
> 
>      By convention, if you return a boolean value indicating success then
>      TRUE means success and FALSE means failure.  Avoid creating
>      functions which have a boolean return value and a GError parameter,
>      but where the boolean does something other than signal whether the
>      GError is set.  Among other problems, it requires C callers to
>      allocate a temporary error.  Instead, provide a "gboolean *" out
>      parameter.  There are functions in GLib itself such as
>      g_key_file_has_key() that are deprecated because of this.
> 

Sounds good. But we are speaking about all functions, not only with errp parameter.. Or not?

-- 
Best regards,
Vladimir

