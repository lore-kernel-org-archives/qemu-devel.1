Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,YOU_INHERIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92371C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 12:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E67B20663
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 12:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EJ/ImCHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E67B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEu2y-0000kD-GY
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 08:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEu2B-0008EZ-6t
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 08:12:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEu29-0007Rj-58
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 08:12:23 -0400
Received: from mail-eopbgr70090.outbound.protection.outlook.com
 ([40.107.7.90]:61197 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jEu22-0007Ph-G7; Thu, 19 Mar 2020 08:12:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhxqduhCmooaSgC9whD0HxFIVnELbA85xZoXvUTbvME51jv+r7gLej6GJCPucM8LE2mgKDPARXdvnchIqcAQRJdn2DzBO71VpVxj3JmbZ7h5qfHOLDWW44c+rqYs7zN37DsS8Q9VlDWvDQf+h8iOkWsleHOFKVEJ6z64C054k0rtgjP8/3nTHm8Cw4U4NQzAhHb9VHs6pVRFbwCtuWF/+QM47D4+j0pRdkxH1YdBEj3v1ipt1hdYh992BpgDt80Wo7pjTMAA4PqPGDtjE/hqY0jwZxBnuc4tFaniKq9V0bXCap0tMizN/xa1ULbUnGuTAEfIR/7CVhJCm4w4gcQ+ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoMIg7xAqBHMlZ9bZu+U4I6A5l7J1RwQ4KLoChN3HgE=;
 b=oglKtx4av5fSPC2MnJ5NyW8q6IChPi+S+sxEK10Ia2/0ftgEmzSR0P4p5dmvtmoVLf8t/3ESE+B6REsU1/qTWIa/BirYA5dJ78/px7ea8aeC3NwsKUrFN9BfHAj9E6/dHFaHBy6AnN9GlTJ1m7jSB3G6rs4vMrf566BNdIPQog1iqB4J0j6gXFqoWjbZLkKMNYl1W53XO1Szr0hZcaEayzNPXwWjllxpDOG+4d6EIsEDmAvES65qTHa2P5R0iANXxvt8e5i9q4u2LkqJb/kuElsxDimhPRa9vgMLZDglN8btrEc8sOwSggX8FGGB1EAb8COR/pJj5IHOOgBDZkmymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoMIg7xAqBHMlZ9bZu+U4I6A5l7J1RwQ4KLoChN3HgE=;
 b=EJ/ImCHyJ+TIrJHk42X/OEsTayZbyu0qb0DY3wWExauofLownPv+DhShk0LpBQNt0nVB1M821SLtDF12vwlMAmyp1y0Z0SmDSJnQEDLhYEYBgmuO4mqgxBHjoCQJxt01UjoBks7GeFC42DxuQdNOS9pCgq1ZzlN6a60ftpyOFKw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2188.eurprd08.prod.outlook.com (10.172.126.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Thu, 19 Mar 2020 12:12:11 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2835.017; Thu, 19 Mar
 2020 12:12:11 +0000
Subject: Re: [PATCH v9 02/10] scripts: Coccinelle script to use
 ERRP_AUTO_PROPAGATE()
To: Markus Armbruster <armbru@redhat.com>
References: <20200312085936.9552-1-vsementsov@virtuozzo.com>
 <20200312085936.9552-3-vsementsov@virtuozzo.com>
 <874kuto7hq.fsf@dusky.pond.sub.org>
 <4a70c6ee-10a2-fdc3-f8df-88c05340398b@virtuozzo.com>
 <875zf8gt2m.fsf@dusky.pond.sub.org>
 <7c6f9a91-76cf-242d-8166-0693ec14b24d@virtuozzo.com>
 <87blozex9v.fsf@dusky.pond.sub.org>
 <f9c8de73-38d8-a14c-632a-8e57d18e00c8@virtuozzo.com>
 <87o8swk8wc.fsf@dusky.pond.sub.org>
 <db2fa8a3-48cc-51aa-a3d5-eba88fb29f66@virtuozzo.com>
 <87wo7jqn8m.fsf@dusky.pond.sub.org>
 <c944511d-0a10-0840-258f-8e0bac19eb47@virtuozzo.com>
 <87wo7gd3nb.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200319151207960
Message-ID: <d7bc3318-2d39-ce6f-1bd0-4165084458a2@virtuozzo.com>
Date: Thu, 19 Mar 2020 15:12:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87wo7gd3nb.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0101CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::31) To HE1PR0802MB2507.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.237) by
 HE1PR0101CA0021.eurprd01.prod.exchangelabs.com (2603:10a6:3:77::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Thu, 19 Mar 2020 12:12:09 +0000
X-Tagtoolbar-Keys: D20200319151207960
X-Originating-IP: [185.215.60.237]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 963caff5-ee24-4d16-292d-08d7cbfec089
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2188:
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2188FCE9E9AED56B003495D4C1F40@HE1PR0802MB2188.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(376002)(39850400004)(346002)(366004)(136003)(199004)(52116002)(956004)(8936002)(31696002)(316002)(2616005)(16576012)(86362001)(16526019)(478600001)(5660300002)(66946007)(186003)(66556008)(6486002)(66476007)(31686004)(2906002)(26005)(81166006)(81156014)(53546011)(54906003)(4326008)(8676002)(6916009)(30864003)(7416002)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2188;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r3PLAMAOxjBx0+c/uufKnOMxwgaGvd0Uyvp670eHMdYjcWyj3pV3b9WkbEy7wfijI0T7+WX8XcfXd0YQ5sxnZDad8gmyrJKbI1tiyHjfifVJYKBmI+KPI+FJLHE7SB8Z81vcMyPDYQft6CvYjmPC9Smor4bC8A/5rtAHvHfe9L87EvfOjsNf8YLTwKlx10XF121pkn97NFcciIdOjQigeT1pJUc8Z0NR76aVs1D6fmD+wivShRD5PYSrIbB8ME26vIkgV/ULoZTanSvd/E0pAF/307WgodxN8K4D8yirAQjl8VEnsrdQC0CjdCqbFdLqJ2AeL1ebdYzxc9vf+EwrD0p5HuoN/3ARjYAjzYs8GTDcffcuSYmpEVQpnGAvLTwpPOGD9i0zWn1NGiJfcKBmD8Mu84z+W8E/urbKXOCdRugDyjbk1udNgDbV26KUHCzQ
X-MS-Exchange-AntiSpam-MessageData: mbmb1FuoGUWai3C2t5cAa0EAeKpdMcETOGt7f7XA6qaeZdWNtAJE/JXD9tRYrbCyVX6+mSC3eRWVD6qWSTCmFmubmA3Y+Ina5xBZmDQTZwaOgnV0xiNiDsidxVUr03EavFq3MqSrPHGxXBmdSd2HnQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963caff5-ee24-4d16-292d-08d7cbfec089
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 12:12:11.1289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LP/NtBUXuUuDBDDlNge/HR9OMxjy/Fm4WtGhoXXhcvJKJlkmcOaqdxrjzhaebmHfdsK5wjSJSgj9E+RotVVgfnHClwsvEYzQEYP3kJYvbtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2188
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.90
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.03.2020 13:45, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
> 
>> 17.03.2020 13:39, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>
>>>> 16.03.2020 11:21, Markus Armbruster wrote:
>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>>
>>>>>> On 14.03.2020 00:54, Markus Armbruster wrote:
>>>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>>>>
>>>>>>>> 13.03.2020 18:42, Markus Armbruster wrote:
>>>>>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>>>>>>
>>>>>>>>>> 12.03.2020 19:36, Markus Armbruster wrote:
>>>>>>>>>>> I may have a second look tomorrow with fresher eyes, but let's get this
>>>>>>>>>>> out now as is.
>>>>>>>>>>>
>>>>>>>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>> [...]
>>>>>>>>>>>> +@@
>>>>>>>>>>>> +
>>>>>>>>>>>> + fn(..., Error ** ____, ...)
>>>>>>>>>>>> + {
>>>>>>>>>>>> +     ...
>>>>>>>>>>>> +     Error *local_err = NULL;
>>>>>>>>>>>> +     ... when any
>>>>>>>>>>>> +     Error *local_err2 = NULL;
>>>>>>>>>>>> +     ... when any
>>>>>>>>>>>> + }
>>>>>>>
>>>>>>> This flags functions that have more than one declaration along any
>>>>>>> control flow path.  It doesn't flag this one:
>>>>>>>
>>>>>>>         void gnat(bool b, Error **errp)
>>>>>>>         {
>>>>>>>             if (b) {
>>>>>>>                 Error *local_err = NULL;
>>>>>>>                 foo(arg, &local_err);
>>>>>>>                 error_propagate(errp, local_err);
>>>>>>>             } else {
>>>>>>>                 Error *local_err = NULL;
>>>>>>>                 bar(arg, &local_err);
>>>>>>>                 error_propagate(errp, local_err);
>>>>>>>             }
>>>>>>>         }
>>>>>>>
>>>>>>> The Coccinelle script does the right thing for this one regardless.
>>>>>>>
>>>>>>> I'd prefer to have such functions flagged, too.  But spending time on
>>>>>>> convincing Coccinelle to do it for me is not worthwhile; I can simply
>>>>>>> search the diff produced by Coccinelle for deletions of declarations
>>>>>>> that are not indented exactly four spaces.
>>>>>>>
>>>>>>> But if we keep this rule, we should adjust its comment
>>>>>>>
>>>>>>>         // Warn several Error * definitions.
>>>>>>>
>>>>>>> because it sure suggests it also catches functions like the one I gave
>>>>>>> above.
>>>>>>
>>>>>> Hmm, yes.. We can write "Warn several Error * definitions in _one_
>>>>>> control flow (it's not so trivial to match _any_ case with several
>>>>>> definitions with coccinelle)" or something like this.
>>>>>
>>>>> Ha, "trivial" reminds me of a story.  The math professor, after having
>>>>> spent a good chunk of his lecture developing a proof on the blackboad
>>>>> turns to the audience to explain why this little part doesn't require
>>>>> proof with the words familiar to any math student "and this is trivial."
>>>>> Pause, puzzled look...  "Is it trivial?"  Pause, storms out of the
>>>>> lecture hall.  A minute or three pass.  Professor comes back beaming,
>>>>> "it is trivial!", and proceeds with the proof.
>>>>>
>>>>> My point is: it might be trivial with Coccinelle once you know how to do
>>>>> it.  We don't.
>>>>>
>>>>> Suggest "(can't figure out how to match several definitions regardless
>>>>> of control flow)".
>>>>
>>>> Wrong too, because I can:) for example, chaining two rules, catching the
>>>> positions of definition and check that they are different.. Or, some
>>>> cheating with python script.. That's why I wrote "not trivial",
>>>>
>>>> So, most correct would be "(can't figure out how to simply match several definitions regardless
>>>>> of control flow)".
>>>
>>> Works for me.
>>>
>>>> But again, coccinelle is for matching control flows, so its probably impossible to match such thing..
>>> [...]
>>>>>> OK, I almost OK with it, the only thing I doubt a bit is the following:
>>>>>>
>>>>>> We want to keep rule1.local_err inheritance to keep connection with
>>>>>> local_err definition.
>>>>>
>>>>> Yes.
>>>>>
>>>>>> Interesting, when we have both rule1.fn and rule1.local_err inherited,
>>>>>> do we inherit them in separate (i.e. all possible combinations of fn
>>>>>> and local_err symbols from rule1) or do we inherit a pair, i.e. only
>>>>>> fn/local_err pairs, found by rule1? If the latter is correct, that
>>>>>> with your script we loss this pair inheritance, and go to all possible
>>>>>> combinations of fn and local_err from rule1, possibly adding some wrong
>>>>>> conversion (OK, you've checked that no such cases in current code tree).
>>>>>
>>>>> The chaining "identifier rule1.FOO" is by name.  It's reliable only as
>>>>> long as there is exactly one instance of the name.
>>>>>
>>>>> We already discussed the case of the function name: if there are two
>>>>> instances of foo(), and rule1 matches only one of them, then we
>>>>> nevertheless apply the rules chained to rule1 to both.  Because that can
>>>>> be wrong, you came up with the ___ trick, which chains reliably.
>>>>>
>>>>> The same issue exists with the variable name: if there are two instances
>>>>> of @local_err, and rule1 matches only one of them, then we nevertheless
>>>>> apply the rules chained to rule1 to both.  Can also be wrong.
>>>>>
>>>>> What are the conditions for "wrong"?
>>>>>
>>>>> Because the ___ chaining is reliable, we know rule1 matched the
>>>>> function, i.e. it has a parameter Error **errp, and it has a automatic
>>>>> variable Error *local_err = NULL.
>>>>>
>>>>> We're good as long as *all* identifiers @local_err in this function are
>>>>> declared that way.  This seems quite likely.  It's not certain, though.
>>>>>
>>>>> Since nested declarations of Error ** variables are rare, we can rely on
>>>>> review to ensure we transform these functions correctly.
>>>>>
>>>>>> So, dropping inheritance in check-rules makes sence, as it may match
>>>>>> (and warn) more interesting cases.
>>>>>>
>>>>>> But for other rules, I'd prefere to be safer, and explictly inherit all
>>>>>> actually inherited identifiers..
>>>>>
>>>>> I still can't see what chaining by function name in addition to the ___
>>>>> chaining buys us.
>>>>
>>>> I'll check this thing soon. And resend today.
>>
>> Checked.
>>
>> Yes, it inherits pair of fn and local_err, and it definitely makes sense. It more stable.
>>
>> Consider the following example:
>>
>> # cat a.c
>> int f1(Error **errp)
>> {
>>      Error *err1 = NULL;
>>      int err2 = 0;
>>
>>      error_propagate(errp, err1);
>>
>>      return err2;
>> }
>>
>> int f2(Error **errp)
>> {
>>      Error *err2 = NULL;
>>      int err1 = 0;
>>
>>      error_propagate(errp, err2);
>>
>>      return err1;
>> }
>>
>>
>> My script works correct and produces this change:
>> --- a.c
>> +++ /tmp/cocci-output-1753-10842a-a.c
>> @@ -1,19 +1,15 @@
>>   int f1(Error **errp)
>>   {
>> -    Error *err1 = NULL;
>> +    ERRP_AUTO_PROPAGATE();
>>       int err2 = 0;
>>
>> -    error_propagate(errp, err1);
>> -
>>       return err2;
>>   }
>>
>>   int f2(Error **errp)
>>   {
>> -    Error *err2 = NULL;
>> +    ERRP_AUTO_PROPAGATE();
>>       int err1 = 0;
>>
>> -    error_propagate(errp, err2);
>> -
>>       return err1;
>>   }
>>
>>
>> But yours script is caught:
>> --- a.c
>> +++ /tmp/cocci-output-1814-b9b681-a.c
>> @@ -1,19 +1,15 @@
>>   int f1(Error **errp)
>>   {
>> -    Error *err1 = NULL;
>> +    ERRP_AUTO_PROPAGATE();
>>       int err2 = 0;
>>
>> -    error_propagate(errp, err1);
>> -
>> -    return err2;
>> +    return *errp;
>>   }
>>
>>   int f2(Error **errp)
>>   {
>> -    Error *err2 = NULL;
>> +    ERRP_AUTO_PROPAGATE();
>>       int err1 = 0;
>>
>> -    error_propagate(errp, err2);
>> -
>> -    return err1;
>> +    return *errp;
>>   }
>>
>>
>> - see, it touches err1, which is unrelated to Error in f2. Hmm,
>> interesting that it doesn't want to convert err1 declaration:)
>>
>> - this is because relation between local_err and fn is lost.
> 
> Let me try to think this through.
> 
> rule1 matches functions that propagate from a local variable @local_err
> to parameter @errp.  It uses the ___ hack to reliably tag the function.
> Later rules that should only apply to these functions can match ___.
> 
> These later rules each provide a part of the total error propagation
> transformation.  They must transform exactly the @local_err and @errp
> matched by rule1 in each function.
> 
> Your solution is to constrain the identifiers, i.e.
> 
>      identifier rule1.fn, rule1.local_err;
> 
> If rule1 matches only one function named foo(), and within that foo()
> the local variable @local_err rule1 matches actually binds all
> occurences of the identifier @local_err, the constraint is reliable.
> 
> Else, the constraint may still accept occurences of @local_err not bound
> to the variable matched by rule1.
> 
> Example 1:
> 
>      int bar(Error **errp)
>      {
>          if (pred()) {
>              Error *local_err = NULL;
> 
>              error_setg(&local_err, "zzzt");
>              error_propagate(errp, local_err);
>          } else {
>              int local_err = 0;
>              return local_err;
>          }
>          return 0;
>      }
> 
> rule1 matches the first @local_err variable, and not the second one.  We
> must transform occurences of the first one, and not occurences of the
> second one.  We do transform all:
> 
>       int bar(Error **errp)
>       {
>      +    ERRP_AUTO_PROPAGATE();
>           if (pred()) {
>      -        Error *local_err = NULL;
>      -
>      -        error_setg(&local_err, "zzzt");
>      -        error_propagate(errp, local_err);
>      +        error_setg(errp, "zzzt");
>           } else {
>               int local_err = 0;
>      -        return local_err;
>      +        return *errp;
>           }
>           return 0;
>       }
> 

Aha, good example. And we even do not warn it.

> Example 2:
> 
>      int foo(Error **errp)
>      {
>          Error *local_err = NULL;
> 
>          error_setg(&local_err, "zzzt");
>          error_propagate(errp, local_err);
>          return 0;
>      }
> 
>      int foo(Error **errp)
>      {
>          Error *err = NULL;
>          int local_err = 0;
> 
>          error_setg(&local_err, "zzzt");
>          error_propagate(errp, err);
>          return local_err;
>      }
> 
> rule1 matches @local_err in the first foo(), and @err in the second one.
> We must transform @local_err in the first one(), and @err in the second
> one.  We do transform both in both:
> 
>       int foo(Error **errp)
>       {
>      -    Error *local_err = NULL;
>      +    ERRP_AUTO_PROPAGATE();
> 
>      -    error_setg(&local_err, "zzzt");
>      -    error_propagate(errp, local_err);
>      +    error_setg(errp, "zzzt");
>           return 0;
>       }
> 
>       int foo(Error **errp)
>       {
>      -    Error *err = NULL;
>      +    ERRP_AUTO_PROPAGATE();
>           int local_err = 0;
> 
>      -    error_setg(&local_err, "zzzt");
>      -    error_propagate(errp, err);
>      -    return local_err;
>      +    error_setg(errp, "zzzt");
>      +    return *errp;
>       }
> 
> Constraining only the variable identifier like I proposed is even less
> reliable, as you demonstrated: then the issue in example 2 exists even
> for differently named functions.
> 
> For a reliable solution, we could use perhaps use the ___ hack again:
> have rule1 rename @local_err it actually matches. But to be honest, my
> appetite for another round of wrestling with Coccinelle isn't what it
> used to be. >
> I think we can do without as long as we're well aware of the script's
> limitations, and we're confident we can detect problematic cases.
> 
> Detecting transformation of multiple functions with the same name should
> be easy.
> 
> Detecting occurences of identifiers not bound by a certain variable
> should be feasible: we find and review every transformed function that
> doesn't declare the variable in its outermost scope.
> 
> Since "well aware" is going to erode with time, we may want to delete
> the script when we're done converting.
> 
>> So, understanding that there no such cases in the whole tree, and even
>> if your patch works faster on the whole tree, I still don't want to
>> drop inheritance, because it's just a correct thing to do. Yes, we've
>> added ____ helper. It helps to avoid some problems. Pair-inheritance
>> helps to avoid another problems. I understand, that there still may
>> other, not-covered problems, but better to be as safe as possible. And
>> inheritance here is native and correct thing to do, even with our ____
>> additional helper. What do you think?
> 
> I wouldn't call it correct.  It's still unreliable, but less so than
> without the function name constraint.  That makes it less wrong.

Agree.

> 
> 100% reliable would be nice, but not at any cost.  Something we're
> reasonably confident to get right should be good enough.
> 
> To be confident, we need to understand the script's limitations, and how
> to compensate for them.  I figure we do now.  You too?
> 

I will not be surprised, if we missed some more interesting cases :)
But we should proceed. What is our plan? Will you queue v10 for 5.1?

-- 
Best regards,
Vladimir

