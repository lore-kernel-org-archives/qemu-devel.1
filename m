Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F15C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA7F32073B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uiMRjpOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7F32073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK0xq-0004Ln-TN
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 10:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jK0wy-0003Rc-7J
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jK0ww-0002eZ-2O
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:36:07 -0400
Received: from mail-db3eur04on0718.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::718]:26818
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jK0wu-0002cc-6k
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:36:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpGge8/ePpcbUHMqmMVcD2qz7zund2Syj5fGA8irtuaiByrHR6cuwcSXtQyYbqjLGdvdXIPOBamkPpodQIvrNzJLKTS+1f0b3d7YHpUAA2FJGk7GaJ1+nOm8dtjuE1B0MlsmdRzSq404nc1REdEK0v8nv4KH06szvxPRfl/pPtb4Of0Bgp24bdWXM9M2PtR92y+m7wNtgn5XXqwfoyN1zMWKL06lktrmhr+wT+5OapEaEhDlx7oebn5mNZgESoJFpnBhUvqL0di+60zudCeqI35spkiLVZwNhMXuwqDG3jDRKQSclc0aHwVkPcfh7UwSLgbAHDpbeKYwylqx40cSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsKkww9Akfdi0bIiLeY1ZGLRcZulbCV/EJ1vzsmZSuw=;
 b=bM6JWGnAvfBicGdlscRxAZlM+2dHxciRGkZaJHscyPBPTM0HNrzK3/PFtzhF2wJ1WFwDHI48bhBaptOqUmLFJmLFoluh4mKNXIyXz0HvDdtrTClg1oiZaZ/DFQpRGKbz7OsnZC3egCwW4I67YjhW67L7GTmHlpmdEU4PTIge5BvevCOyPI5DDfxkE0hEoYsE7OW+SQPeDHm6WGwrYHi/78BL8+CHclQ9mgL7r9cM+dSuRtrGyXmqVjOHesNcqosS1JBP4oLseIY/EuUb2MQFWA3QaluKQqGHwe6Uf1yhmlbpPDEuakAyb4mgEwjAe2tXiE3Yla8wzPYJwXTlbOAXgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsKkww9Akfdi0bIiLeY1ZGLRcZulbCV/EJ1vzsmZSuw=;
 b=uiMRjpOU4oV6IJVhETriOTHFOw5JuzvDd3nCZPUF8V+sK1hFIgGF3Ko9LZfB1fKiq2dfH+cjS8O3h048ObaAXqhSww3p1UrBC0LX/A48ejduZhm24yP2xGblDWl4hxsaDzzLc8V0fVu6zB3cGWqXkP9QABiPvNs5MVs3LKL+yCA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5336.eurprd08.prod.outlook.com (10.141.172.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Thu, 2 Apr 2020 14:36:01 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.016; Thu, 2 Apr 2020
 14:36:01 +0000
Subject: Re: Questionable aspects of QEMU Error's design
To: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <CAFEAcA_b1gZ-B4NaEdQS2zffdvobW=FUx4ysEgXVAz+=cZ+R3Q@mail.gmail.com>
 <87sghmbfgc.fsf@dusky.pond.sub.org>
 <44b5ff2c-6dce-e516-a9cc-9d80354c5a72@virtuozzo.com>
 <CAFEAcA_cmOkR4YsDmP7mDdKzs0jTu3WDO=d1uvMxHguvZjGW_g@mail.gmail.com>
 <877dyy9shs.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200402173559702
Message-ID: <045198b9-29d8-231c-d35c-440723308003@virtuozzo.com>
Date: Thu, 2 Apr 2020 17:35:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <877dyy9shs.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0141.eurprd05.prod.outlook.com
 (2603:10a6:207:3::19) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.23) by
 AM3PR05CA0141.eurprd05.prod.outlook.com (2603:10a6:207:3::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Thu, 2 Apr 2020 14:36:00 +0000
X-Tagtoolbar-Keys: D20200402173559702
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95859def-20c5-424a-731e-08d7d7132a48
X-MS-TrafficTypeDiagnostic: AM7PR08MB5336:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5336C2C496A85896A992459EC1C60@AM7PR08MB5336.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(346002)(376002)(136003)(396003)(39840400004)(2906002)(52116002)(6486002)(66946007)(2616005)(26005)(66476007)(54906003)(81156014)(81166006)(31686004)(5660300002)(956004)(66556008)(8936002)(110136005)(478600001)(31696002)(16576012)(4326008)(16526019)(186003)(36756003)(316002)(8676002)(86362001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O8s8gAookDhuYoU3t/ogiQvvr0hUbQlbOmKWJGrENHcSM3euFlMlU2LVjFCgOBvxaC1YpNaeSERosgVMbDxzF+lTYsWZ939Qc7SJivn5zHm5KzJNHaBZvjJVkbEu5RF5VzY5J6fDJqKLQ+lVuP7nhmVHIRg0GocBQLMy7qTY+dQdKfx7qjfFntIdrOLjwQThwd/sm47UpMeQYOeDw6LB2EUoNYR/eYtz0Yz32VyL2EQfemmPds6cuZTea0/uxMg57O0Yq91pKRd9goRII3RHsHEt4RIlTe3LSkUOjUWTKd7hUO/PeFHUwemD4VJdC5lx/RvWlcMEz6HAU6L8uImzSZjnwFYyD9LSPJEBrIMpdRdmbmvKdnFhk7sUtVEtW3tLPO5BUPqIG2oKtbn4/3rqQ8n3mNe5Xp0IOIT1XnAMlvgeWlfFju1+uW6oVIdDfMX4
X-MS-Exchange-AntiSpam-MessageData: FaPfjw8zcSJIHaQvbdIlg/oOMjibSm5yLlSNztKJMoUH8psV8tm/PRCKwLpjvP13eQk2lgQcu2ml6R+AxtXft/NA2IvrKyh+0yFRQJsf5QDi3q3zua7h8CrHSacDGaCZ0TlpckSYvbBv5djgqaebQQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95859def-20c5-424a-731e-08d7d7132a48
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 14:36:01.0822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xllKGlTg5gFUvRT1wXlBg7J9S9Cq+8Ksp3N+hjvwgZ7OpFNajIoFKliaJmEbVyHozp2TwmGh3rfLiLBPZ3oxr0bVbHFx9Yz4TgHxPG2Afk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0c::718
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.04.2020 11:55, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Thu, 2 Apr 2020 at 07:11, Vladimir Sementsov-Ogievskiy
>> <vsementsov@virtuozzo.com> wrote:
>>> Somehow, in general, especially with long function names and long parameter lists I prefer
>>>
>>> ret = func(..);
>>> if (ret < 0) {
>>>       return ret;
>>> }
>>
>> Personally I prefer the other approach -- this one has an extra line
>> in the source and
>> needs an extra local variable.
> 
> Me too, except when func(...) is so long that
> 
>      if (func(...) < 0) {
> 
> becomes illegible like
> 
>      if (func(... yadda, yadda,
>               yadda, ...) < 0) {
> 
> Then an extra variable can improve things.
> 
>>> Are you sure that adding a lot of boolean functions is a good idea? I somehow feel better with more usual int functions with -errno on failure.
>>>
>>> Bool is a good return value for functions which are boolean by nature: checks, is something correspond to some criteria. But for reporting an error I'd prefer -errno.
>>
>> When would we want to return an errno? I thought the whole point of the
>> Error* was that that was where information about the error was returned.
>> If all your callsites are just going to do "if (ret < 0) { ... } then having
>> the functions pick an errno value to return is just extra work.
> 
> 0/-1 vs. true/false is a matter of convention.  Lacking convention, it's
> a matter of taste. >
> 0/-1 vs. 0/-errno depends on the function and its callers.  When -errno
> enables callers to distinguish failures in a sane and simple way, use
> it.  When -errno feels "natural", I'd say feel free to use it even when
> all existing callers only check < 0.
> 
> When you return non-null/null or true/false on success/error, neglecting
> to document that in a function contract can perhaps be tolerated; you're
> using the return type the common, obvious way.  But when you return 0/-1
> or 0/-errno, please spell it out.  I've seen too many "Operation not
> permitted" that were actually -1 mistaken for -EPERM.  Also too many
> functions that return -1 for some failures and -errno for others.
> 

I just want to add one note:

OK, you like the pattern

   if (func()) {
       <handle error>
   }

, I can live with it.

I believe, we have a lot of such patterns already in code.

Now, we are going to add a lot of functions, returning true on success and false on failure, so add a lot of patterns

   if (!func()) {
       <handle error>
   }

---

After it, looking at something like

   if (!func()) {} / if (func()) {}

I'll have to always jump to function definition, to check is it int or bool function, to understand what exactly is meant and is there a mistake in the code..
So, I'm afraid that such conversion will not help reviewing/understanding the code. I'd prefer to avoid using two opposite conventions in on project.

I can also imagine combining different function types (int/bool) in if conditions o_O, what will save us from it?

And don't forget about bool functions, which just check something, and false is not an error, but just negative answer on some question.

-- 
Best regards,
Vladimir

