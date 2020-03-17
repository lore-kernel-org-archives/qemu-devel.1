Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,YOU_INHERIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08600C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:36:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E1F20658
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZbTdhF3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E1F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAWI-0004oe-02
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEAVP-0004CW-9W
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEAVN-0008K7-Ik
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:35:31 -0400
Received: from mail-eopbgr40118.outbound.protection.outlook.com
 ([40.107.4.118]:23783 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jEAVI-0007Be-4j; Tue, 17 Mar 2020 07:35:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnWIqTMh8ilibbNEcyN3ZxCN5MPIp4d8bAdsxjWm0QRTTE0zyDkbP2ZhXeRoO9MPlZdza4kwCKLmt2rGob5Q7MUc0Yil2AueQqdSoXpTz4yvpeSLa5OURFrI/1Vo6QXDaDwi0qHLNz9s1711qR3uV6gN9Jav4wnDg0VbPDvn/QA1q6zlVqBNN5ce25Nr7/wx2SQXtbvIZclOsAngx86vd9rrfWTJFSOJ7Py5X3pGdiGYsgNbGTCRrvMVBf8SqHmzKNSQqUByepV7dJLY8XtuGAXNT9HNP/U8bNW1hDev8rdc3ynK4rmTYp05tqrpR7ZmIHf8pafkNAwhEwjP3guMxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7Mlm90O9RAIhBshRzJi8VbFFsHYxFt206XYwQLpAlM=;
 b=L5ZwOGlDEsZDzoUYBdN9ZNrKJmqU8h+lYapdLiuZCMgm580pi5y3ftK0f+rUwj1jGZdbalMK2DsDCVpBXeY+VMrjAwHCe6m3+74Z9uqZt9VCcuwlzI8XAuQNpxUJCdGXroBJK4AOjzd18faL8XV8LcRMzz9d3/2NvK8N0OebC96DG9fqDiAQQWqXjUEYlDdiaP4P0ncqRBc6PnFNmamJjZmF/7R1M453T+2dGJ9TnHHW7FkLtP6gHbsQ0qLdooSyFG7M1bVW7ljphQOCUjYhXqLpYgDf/KOg3f+d5YCcjYiECPuYl3/eBYp8cjicf2lZ0L6gebK1En9jolEiU24jXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7Mlm90O9RAIhBshRzJi8VbFFsHYxFt206XYwQLpAlM=;
 b=ZbTdhF3PO/GE2Txow6KaS2a2E0w/0jew0mzwEiGdqapEJJWd/4ml0ee4jDInWAp63uYvVh3iqmq4aqNdbR6wRD2Jp5/Oc2WVhwLC0/b5W1qOh5jEqHmm7PlFW3OUcY6A3o033zaHmeAx2Vex7RRWia+KROtCyMKmEKDeweztAtg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2540.eurprd08.prod.outlook.com (10.175.29.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13; Tue, 17 Mar 2020 11:35:18 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2814.021; Tue, 17 Mar
 2020 11:35:18 +0000
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
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200317143514980
Message-ID: <c944511d-0a10-0840-258f-8e0bac19eb47@virtuozzo.com>
Date: Tue, 17 Mar 2020 14:35:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87wo7jqn8m.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0108.eurprd02.prod.outlook.com
 (2603:10a6:208:154::49) To HE1PR0802MB2507.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.248) by
 AM0PR02CA0108.eurprd02.prod.outlook.com (2603:10a6:208:154::49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.19 via Frontend
 Transport; Tue, 17 Mar 2020 11:35:16 +0000
X-Tagtoolbar-Keys: D20200317143514980
X-Originating-IP: [185.215.60.248]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11b8b2e8-5f0b-4aab-cd33-08d7ca674494
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2540:
X-Microsoft-Antispam-PRVS: <HE1PR0802MB254091323ADACCF0B24DD417C1F60@HE1PR0802MB2540.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(396003)(136003)(39850400004)(366004)(346002)(199004)(54906003)(8676002)(16576012)(81166006)(81156014)(316002)(53546011)(52116002)(478600001)(2616005)(6486002)(956004)(186003)(8936002)(16526019)(26005)(31696002)(86362001)(66556008)(66476007)(66946007)(36756003)(31686004)(7416002)(5660300002)(2906002)(6916009)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2540;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /0DWNH5s4niM8Z2a9cWAuWwjQ7brxnf060EO4+4QD8e/gyE0TLkcwcrYPy7c5+YDIakYjuN1GlGuBYfA9ijBB4LJhhZaUwPt2WbNQZlIU1VrPbf6M4imCHSy79+3bTDnaY9MEyDe7ZROJfAK2p3pMOQM4WJohRr2Cu+Yp/aiKSquxznNX2Mpw84V3vycNiNFIB8vkZua92zxo5NIU2HF1nWTXB+xJg7A2Nehv4+WGtPX1Q8e7m4OiuhXEJJ5KScK9kkhTKTnJCeKzVniUckE6XEb1N9ECXausVTS1aSC0+1n2nAUXhSV7PKNNcTVbc4ujozug+lZ5eT0WWOXF6rfFuNnkQ0/TMvQcffLYVaogqEieJB7JqQEJoyVODVzjjZQ29uPYp2bwpCAsoCtrOp9DBshGXjIi3FPQt1QgSEa2sJWLrak6LwAYN9I3hJJlng0
X-MS-Exchange-AntiSpam-MessageData: PiyR2O1+KvrW0D3zqPzLqpeP+wZcpOeQvA8I6EI8FVrB+1sZp0Q9YdXfGtUfqYb7ivPModAqKJXd/85p+LoReQpTRNvRXHs1k8AulWEEE0nYL7c2uFkIUQZd48OL/jksCjvYhHRGvfuoAyWLXMqU/A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b8b2e8-5f0b-4aab-cd33-08d7ca674494
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 11:35:18.2556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvgUI3aBPhPzmu7qVawFf/mhV9Tr9zF3gFsM7/keK0wveo/OdInIh7zWyBc4LT8/21j6UDOTFebpkIZkXjtvIU+Bkhktnh3gUEvfp1Kq00U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2540
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.118
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
 Laszlo Ersek <lersek@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.03.2020 13:39, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
> 
>> 16.03.2020 11:21, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>
>>>> On 14.03.2020 00:54, Markus Armbruster wrote:
>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>>
>>>>>> 13.03.2020 18:42, Markus Armbruster wrote:
>>>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>>>>
>>>>>>>> 12.03.2020 19:36, Markus Armbruster wrote:
>>>>>>>>> I may have a second look tomorrow with fresher eyes, but let's get this
>>>>>>>>> out now as is.
>>>>>>>>>
>>>>>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
> [...]
>>>>>>>>>> +@@
>>>>>>>>>> +
>>>>>>>>>> + fn(..., Error ** ____, ...)
>>>>>>>>>> + {
>>>>>>>>>> +     ...
>>>>>>>>>> +     Error *local_err = NULL;
>>>>>>>>>> +     ... when any
>>>>>>>>>> +     Error *local_err2 = NULL;
>>>>>>>>>> +     ... when any
>>>>>>>>>> + }
>>>>>
>>>>> This flags functions that have more than one declaration along any
>>>>> control flow path.  It doesn't flag this one:
>>>>>
>>>>>        void gnat(bool b, Error **errp)
>>>>>        {
>>>>>            if (b) {
>>>>>                Error *local_err = NULL;
>>>>>                foo(arg, &local_err);
>>>>>                error_propagate(errp, local_err);
>>>>>            } else {
>>>>>                Error *local_err = NULL;
>>>>>                bar(arg, &local_err);
>>>>>                error_propagate(errp, local_err);
>>>>>            }
>>>>>        }
>>>>>
>>>>> The Coccinelle script does the right thing for this one regardless.
>>>>>
>>>>> I'd prefer to have such functions flagged, too.  But spending time on
>>>>> convincing Coccinelle to do it for me is not worthwhile; I can simply
>>>>> search the diff produced by Coccinelle for deletions of declarations
>>>>> that are not indented exactly four spaces.
>>>>>
>>>>> But if we keep this rule, we should adjust its comment
>>>>>
>>>>>        // Warn several Error * definitions.
>>>>>
>>>>> because it sure suggests it also catches functions like the one I gave
>>>>> above.
>>>>
>>>> Hmm, yes.. We can write "Warn several Error * definitions in _one_
>>>> control flow (it's not so trivial to match _any_ case with several
>>>> definitions with coccinelle)" or something like this.
>>>
>>> Ha, "trivial" reminds me of a story.  The math professor, after having
>>> spent a good chunk of his lecture developing a proof on the blackboad
>>> turns to the audience to explain why this little part doesn't require
>>> proof with the words familiar to any math student "and this is trivial."
>>> Pause, puzzled look...  "Is it trivial?"  Pause, storms out of the
>>> lecture hall.  A minute or three pass.  Professor comes back beaming,
>>> "it is trivial!", and proceeds with the proof.
>>>
>>> My point is: it might be trivial with Coccinelle once you know how to do
>>> it.  We don't.
>>>
>>> Suggest "(can't figure out how to match several definitions regardless
>>> of control flow)".
>>
>> Wrong too, because I can:) for example, chaining two rules, catching the
>> positions of definition and check that they are different.. Or, some
>> cheating with python script.. That's why I wrote "not trivial",
>>
>> So, most correct would be "(can't figure out how to simply match several definitions regardless
>>> of control flow)".
> 
> Works for me.
> 
>> But again, coccinelle is for matching control flows, so its probably impossible to match such thing..
> [...]
>>>> OK, I almost OK with it, the only thing I doubt a bit is the following:
>>>>
>>>> We want to keep rule1.local_err inheritance to keep connection with
>>>> local_err definition.
>>>
>>> Yes.
>>>
>>>> Interesting, when we have both rule1.fn and rule1.local_err inherited,
>>>> do we inherit them in separate (i.e. all possible combinations of fn
>>>> and local_err symbols from rule1) or do we inherit a pair, i.e. only
>>>> fn/local_err pairs, found by rule1? If the latter is correct, that
>>>> with your script we loss this pair inheritance, and go to all possible
>>>> combinations of fn and local_err from rule1, possibly adding some wrong
>>>> conversion (OK, you've checked that no such cases in current code tree).
>>>
>>> The chaining "identifier rule1.FOO" is by name.  It's reliable only as
>>> long as there is exactly one instance of the name.
>>>
>>> We already discussed the case of the function name: if there are two
>>> instances of foo(), and rule1 matches only one of them, then we
>>> nevertheless apply the rules chained to rule1 to both.  Because that can
>>> be wrong, you came up with the ___ trick, which chains reliably.
>>>
>>> The same issue exists with the variable name: if there are two instances
>>> of @local_err, and rule1 matches only one of them, then we nevertheless
>>> apply the rules chained to rule1 to both.  Can also be wrong.
>>>
>>> What are the conditions for "wrong"?
>>>
>>> Because the ___ chaining is reliable, we know rule1 matched the
>>> function, i.e. it has a parameter Error **errp, and it has a automatic
>>> variable Error *local_err = NULL.
>>>
>>> We're good as long as *all* identifiers @local_err in this function are
>>> declared that way.  This seems quite likely.  It's not certain, though.
>>>
>>> Since nested declarations of Error ** variables are rare, we can rely on
>>> review to ensure we transform these functions correctly.
>>>
>>>> So, dropping inheritance in check-rules makes sence, as it may match
>>>> (and warn) more interesting cases.
>>>>
>>>> But for other rules, I'd prefere to be safer, and explictly inherit all
>>>> actually inherited identifiers..
>>>
>>> I still can't see what chaining by function name in addition to the ___
>>> chaining buys us.
>>
>> I'll check this thing soon. And resend today.

Checked.

Yes, it inherits pair of fn and local_err, and it definitely makes sense. It more stable.

Consider the following example:

# cat a.c
int f1(Error **errp)
{
     Error *err1 = NULL;
     int err2 = 0;

     error_propagate(errp, err1);

     return err2;
}

int f2(Error **errp)
{
     Error *err2 = NULL;
     int err1 = 0;

     error_propagate(errp, err2);

     return err1;
}


My script works correct and produces this change:
--- a.c
+++ /tmp/cocci-output-1753-10842a-a.c
@@ -1,19 +1,15 @@
  int f1(Error **errp)
  {
-    Error *err1 = NULL;
+    ERRP_AUTO_PROPAGATE();
      int err2 = 0;

-    error_propagate(errp, err1);
-
      return err2;
  }

  int f2(Error **errp)
  {
-    Error *err2 = NULL;
+    ERRP_AUTO_PROPAGATE();
      int err1 = 0;

-    error_propagate(errp, err2);
-
      return err1;
  }


But yours script is caught:
--- a.c
+++ /tmp/cocci-output-1814-b9b681-a.c
@@ -1,19 +1,15 @@
  int f1(Error **errp)
  {
-    Error *err1 = NULL;
+    ERRP_AUTO_PROPAGATE();
      int err2 = 0;

-    error_propagate(errp, err1);
-
-    return err2;
+    return *errp;
  }

  int f2(Error **errp)
  {
-    Error *err2 = NULL;
+    ERRP_AUTO_PROPAGATE();
      int err1 = 0;

-    error_propagate(errp, err2);
-
-    return err1;
+    return *errp;
  }


- see, it touches err1, which is unrelated to Error in f2. Hmm, interesting that it doesn't want to convert err1 declaration:)

- this is because relation between local_err and fn is lost.

So, understanding that there no such cases in the whole tree, and even if your patch works faster on the whole tree, I still don't want to drop inheritance, because it's just a correct thing to do. Yes, we've added ____ helper. It helps to avoid some problems. Pair-inheritance helps to avoid another problems. I understand, that there still may other, not-covered problems, but better to be as safe as possible. And inheritance here is native and correct thing to do, even with our ____ additional helper. What do you think?

>>
>>>
>>>>                                    Still, I feel, we'll never be
>>>> absolutely safe with coccinelle :)
>>>
>>> Right, although this particular problem is not really Coccinelle's
>>> fault.  Blindly treating all instances of a certain identifier in a
>>> certain area the same regardless of how they are bound to declarations
>>> is fundamentally unreliable, regardless of your actual tooling.
>>>
>>
>> Yes, still interesting, can coccinelle do more smart inheritance to match
>> exactly same object... I think, I need to CC coccinelle mailing list
>> to the next version
> 
> I'love to get taught how to chain reliably.
> 


-- 
Best regards,
Vladimir

