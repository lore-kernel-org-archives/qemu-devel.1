Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55A6C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 07:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B416C2072F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 07:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qyKdPugV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B416C2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCIVB-0000kV-Qn
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 03:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCIUO-00089X-6U
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 03:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCIUM-0000aL-Fu
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 03:42:44 -0400
Received: from mail-eopbgr130135.outbound.protection.outlook.com
 ([40.107.13.135]:22503 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jCIUH-00009o-N6; Thu, 12 Mar 2020 03:42:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxb3xGKBqMtfCV6MX/78U2EVD2YfSUZ1ZTd/U5QHDERnc4wHPvyI939CRpw8jPEnAfQhCZKwC+HFlvl5wUMoSvpq0UfK/wNJ1je8mmPQElBBEBmNIk3mFKjHzjafnZYsV3qE6G1CUgtUGA/S8mrVzBgJtWg16oLVAgfnU92im07iMIX1Udrm3ulOG6asIcnsu8QJ3ldfPlbEERqawTkYgzyeCVDTiWftIhlkTeAd9gKtSdKSm4X4zAyRMhR1OOwcHNX+32hLIZSRqHeBI8xyD1BTZwLsYwT0l+aM3tKYyRMuGbilX8xgEu9eegrzCZ8pqK3qF7NmjQsH3wZShzW1hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GMRDENyPa5vHklTvA/upKYzvGWr9kL0BSgqBktBkcQ=;
 b=mvoVWwzHZ215FfYUDpnIa8pyk5hZ17XJv/JOYfj/2SXzfaaq2wSFdDhIGetXzMPZ+CInzC1Vi30jvVJDuEjZn5UbfeiphmqkA8VkXsrViToXk1gNtp0n7IRcSnQvo+lZsjfEAabBRU/lRTuWn5AUjHr/W7tZZtTbiQWCWkpRpnxx5uuWdQs8H1ftYDgNFmg/NzpCDHMKaBDh8U87yUYPE7MwOKygZcuSoaQYKQzt7/C2LM5czVUqGgNWTFc9jdM5ujjsPG0ShSrMRjTmUT0KO1jcLtXzx6NPR9ecXQEcd+B73QX8yOGY81YbuoSgo8q6LBEETeJwlflphY8+cXPUBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GMRDENyPa5vHklTvA/upKYzvGWr9kL0BSgqBktBkcQ=;
 b=qyKdPugVvlgez4KHS0eEMAobiM9QLHl5eAKs7cgMIOhCW8rP4F9UANmXx1ZMmt+nME0SbMQ0LP8U/lZoarhayBdudUOYyEkTSsR3TG5chq1onUbutDkP+kasbv47t7cS+nEbPNVjK+1CWNrliF5ZmxVJeJ05d1yIHvyAeQP3tcs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4982.eurprd08.prod.outlook.com (10.255.122.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Thu, 12 Mar 2020 07:42:30 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2814.007; Thu, 12 Mar 2020
 07:42:30 +0000
Subject: Re: [PATCH v8 02/10] scripts: add coccinelle script to use auto
 propagated errp
To: Markus Armbruster <armbru@redhat.com>
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
 <20200306051536.27803-3-vsementsov@virtuozzo.com>
 <87lfo997hs.fsf@dusky.pond.sub.org>
 <fda76f8a-bb62-d867-d7b4-7cf8caf0489e@virtuozzo.com>
 <87a74ngriw.fsf@dusky.pond.sub.org>
 <71ada30b-c72b-6251-cc38-877ddd4156a8@virtuozzo.com>
 <87h7yvx8ce.fsf@dusky.pond.sub.org>
 <a16e5dee-7f2b-236d-1e71-f40c75cb5902@virtuozzo.com>
 <87blp2rq92.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200312104227555
Message-ID: <554d6b37-1fc7-ca8b-258a-2280462f903c@virtuozzo.com>
Date: Thu, 12 Mar 2020 10:42:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87blp2rq92.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0901CA0057.eurprd09.prod.outlook.com
 (2603:10a6:3:45::25) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0901CA0057.eurprd09.prod.outlook.com (2603:10a6:3:45::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.20 via Frontend Transport; Thu, 12 Mar 2020 07:42:29 +0000
X-Tagtoolbar-Keys: D20200312104227555
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7326355f-3204-4f6d-bc04-08d7c658eb4b
X-MS-TrafficTypeDiagnostic: AM6PR08MB4982:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4982D87B69F837BD65BE0240C1FD0@AM6PR08MB4982.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(396003)(39850400004)(366004)(136003)(199004)(6916009)(81156014)(7416002)(52116002)(16576012)(8936002)(8676002)(36756003)(31686004)(316002)(81166006)(6486002)(2616005)(4326008)(478600001)(54906003)(956004)(26005)(66946007)(66556008)(31696002)(2906002)(86362001)(5660300002)(186003)(16526019)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4982;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6q/BD6NTClHN2UpeNoLhA3kRGRxZb9N/XuIy8vacRNlVbvNbcTWDWSR9wsejxaQ6KlMAaE1CbhnOkllhw7d91hx321O8OKO3wyihoc4pjR73peR7IO4Y+HEDAesbnDbjhAKxIJ0Nkay1yeUx5nvmQxtu0NEKgU6ZRiebU54VP8WMD1at/1FrNb4mM4BEjOH1tfyUdrddlCNClgVJfNIkMifTnAyUNYAHjpmdfgr58VuxMHKp5lCjsNRqESCi0zcLmhCnx7Ae+WIQxE3vB2h8RuiZ2ljFnx40XEQwhT5ZJt0q4+RC8RmL2poXF9252dT64tA/i7fV2yosUreGjILaGQyNdONsgKgnVj5Ln2qtx5p/+NRGJkgsxRdBa/sNWb5NlqE+0Fq0Xjr5aTtxgrdf/8+3DcxACV1KgBJ0Ippw1xxTXWE6lCy+Ef6VbDl3XGCi
X-MS-Exchange-AntiSpam-MessageData: wDQyW9vmB5yY1uvul9x9rs/2bNhSk8HPQz0gwoBfTqGxCtdB4k9bXlnbDA7PzcOzcUICy4QAVI0h+zk3j8xippuu+xIVYSkfTfrMkUagWoFMyyYaZpXu8e6DXL1dnG1nAMULBZSILKaSt2Jv3KiOpw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7326355f-3204-4f6d-bc04-08d7c658eb4b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 07:42:30.6153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNZ4IAm8CXo8c4cEDzpMt9BcKWtBx1NNoQtxAkk/CZNCg4ImdEGOt16z1GkDrzY7azRbgeLT7TGgfakEtkQzmkrU5JCcF1vIQSi/2W1Zxmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4982
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.13.135
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

12.03.2020 10:23, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
> 
>> 11.03.2020 17:41, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>
>>>> 11.03.2020 12:38, Markus Armbruster wrote:
>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>>
>>>>>> 09.03.2020 12:56, Markus Armbruster wrote:
>>>>>>> Suggest
>>>>>>>
>>>>>>>         scripts: Coccinelle script to use auto-propagated errp
>>>>>>>
>>>>>>> or
>>>>>>>
>>>>>>>         scripts: Coccinelle script to use ERRP_AUTO_PROPAGATE()
>>>>>>>
>>>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>> [...]
>>>>>>>> +// Note, that we update everything related to matched by rule1 function name
>>>>>>>> +// and local_err name. We may match something not related to the pattern
>>>>>>>> +// matched by rule1. For example, local_err may be defined with the same name
>>>>>>>> +// in different blocks inside one function, and in one block follow the
>>>>>>>> +// propagation pattern and in other block doesn't. Or we may have several
>>>>>>>> +// functions with the same name (for different configurations).
>>>>>>>
>>>>>>> Context: rule1 matches functions that have all three of
>>>>>>>
>>>>>>> * an Error **errp parameter
>>>>>>>
>>>>>>> * an Error *local_err = NULL variable declaration
>>>>>>>
>>>>>>> * an error_propagate(errp, local_err) or error_propagate_prepend(errp,
>>>>>>>       local_err, ...) expression, where @errp is the parameter and
>>>>>>>       @local_err is the variable.
>>>>>>>
>>>>>>> If I understand you correctly, you're pointing out two potential issues:
>>>>>>>
>>>>>>> 1. This rule can match functions rule1 does not match if there is
>>>>>>> another function with the same name that rule1 does match.
>>>>>>>
>>>>>>> 2. This rule matches in the entire function matched by rule1, even when
>>>>>>> parts of that function use a different @errp or @local_err.
>>>>>>>
>>>>>>> I figure these apply to all rules with identifier rule1.fn, not just
>>>>>>> this one.  Correct?
>>>>>>>
>>>>>>> Regarding 1.  There must be a better way to chain rules together, but I
>>>>>>> don't know it.
>>>>>>
>>>>>> Hmm, what about something like this:
>>>>>>
>>>>>> @rule1 disable optional_qualifier exists@
>>>>>> identifier fn, local_err;
>>>>>> symbol errp;
>>>>>> @@
>>>>>>
>>>>>>     fn(..., Error **
>>>>>> - errp
>>>>>> + ___errp_coccinelle_updating___
>>>>>>        , ...)
>>>>>>     {
>>>>>>         ...
>>>>>>         Error *local_err = NULL;
>>>>>>         ...
>>>>>> (
>>>>>>        error_propagate_prepend(errp, local_err, ...);
>>>>>> |
>>>>>>        error_propagate(errp, local_err);
>>>>>> )
>>>>>>         ...
>>>>>>     }
>>>>>>
>>>>>>
>>>>>> [..]
>>>>>>
>>>>>> match symbol ___errp_coccinelle_updating___ in following rules in function header
>>>>>>
>>>>>> [..]
>>>>>>
>>>>>>
>>>>>> @ disable optional_qualifier@
>>>>>> identifier fn, local_err;
>>>>>> symbol errp;
>>>>>> @@
>>>>>>
>>>>>>     fn(..., Error **
>>>>>> - ___errp_coccinelle_updating___
>>>>>> + errp
>>>>>>        , ...)
>>>>>>     {
>>>>>>         ...
>>>>>>     }
>>>>>>
>>>>>>
>>>>>> - hacky, but seems not more hacky than python detection, and should work better
>>>>>
>>>>> As simple, forceful and unsubtle as a sledgehammer.  I like it :)
>>>>>
>>>>
>>>>
>>>> Hmm, not so simple.
>>>>
>>>> It leads to reindenting of function header, which is bad.
>>>
>>> Because ___errp_coccinelle_updating___ is longer than errp, I guess.
>>> Try ____?
>>
>> I'm afraid not. It's because it just adds \n, when I do
>>
>> ...,
>>
>> - errp
>> + ___errp_coccinelle_updating___
>> ,...
> 
> I was thinking of something like the appended patch, which in my
> (superficial!) testing leaves alone newlines unless lines are long, but
> hangs for block.c.  Oh well.

Sorry, I didn't say, but I've checked and I was wrong: ___  works fine. But
we need --max-width 80, otherwise coccinelle wraps some lines which fit into
80 characters and produces extra hunks.

So, now I'm preparing v9 with errp->____->errp concept. It differs from your patch and works on block.c

We don't need to switch all errp into ____, it's an extra complication. Changing name only in function
header is enough. And don't worry about broken compilation: it's broken anyway among the rules, and all
is OK after all rules applied.

> 
> 
> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts/coccinelle/auto-propagated-errp.cocci
> index bff274bd6d..492a4db826 100644
> --- a/scripts/coccinelle/auto-propagated-errp.cocci
> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
> @@ -35,12 +35,12 @@
>   // error_propagate_prepend().
>   @ depends on !(file in "util/error.c") disable optional_qualifier@
>   identifier fn;
> -identifier _errp != errp;
> +identifier _errp;
>   @@
>   
>    fn(...,
>   -   Error **_errp
> -+   Error **errp
> ++   Error **____
>       ,...)
>    {
>   (
> @@ -48,7 +48,7 @@ identifier _errp != errp;
>   &
>        <...
>   -    _errp
> -+    errp
> ++    ____
>        ...>
>   )
>    }
> @@ -63,26 +63,26 @@ identifier _errp != errp;
>   // all possible control flows (otherwise, it will not match standard pattern
>   // when error_propagate() call is in if branch).
>   @ disable optional_qualifier exists@
> -identifier fn, local_err, errp;
> +identifier fn, local_err;
>   @@
>   
> - fn(..., Error **errp, ...)
> + fn(..., Error **____, ...)
>    {
>   +   ERRP_AUTO_PROPAGATE();
>       ...  when != ERRP_AUTO_PROPAGATE();
>   (
> -    error_append_hint(errp, ...);
> +    error_append_hint(____, ...);
>   |
> -    error_prepend(errp, ...);
> +    error_prepend(____, ...);
>   |
> -    error_vprepend(errp, ...);
> +    error_vprepend(____, ...);
>   |
>       Error *local_err = NULL;
>       ...
>   (
> -    error_propagate_prepend(errp, local_err, ...);
> +    error_propagate_prepend(____, local_err, ...);
>   |
> -    error_propagate(errp, local_err);
> +    error_propagate(____, local_err);
>   )
>   )
>       ... when any
> @@ -92,18 +92,17 @@ identifier fn, local_err, errp;
>   // Match scenarios with propagation of local error to errp.
>   @rule1 disable optional_qualifier exists@
>   identifier fn, local_err;
> -symbol errp;
>   @@
>   
> - fn(..., Error **errp, ...)
> + fn(..., Error **____, ...)
>    {
>        ...
>        Error *local_err = NULL;
>        ...
>   (
> -    error_propagate_prepend(errp, local_err, ...);
> +    error_propagate_prepend(____, local_err, ...);
>   |
> -    error_propagate(errp, local_err);
> +    error_propagate(____, local_err);
>   )
>        ...
>    }
> @@ -118,7 +117,6 @@ symbol errp;
>   // without error_propagate() call), coccinelle fails to match this "out: }".
>   @@
>   identifier rule1.fn, rule1.local_err, out;
> -symbol errp;
>   @@
>   
>    fn(...)
> @@ -128,7 +126,7 @@ symbol errp;
>   +    return;
>        ...>
>   - out:
> --    error_propagate(errp, local_err);
> +-    error_propagate(____, local_err);
>    }
>   
>   // Convert most of local_err related staff.
> @@ -159,7 +157,6 @@ symbol errp;
>   @ exists@
>   identifier rule1.fn, rule1.local_err;
>   expression list args;
> -symbol errp;
>   @@
>   
>    fn(...)
> @@ -172,30 +169,30 @@ symbol errp;
>   // Convert error clearing functions
>   (
>   -    error_free(local_err);
> -+    error_free_errp(errp);
> ++    error_free_errp(____);
>   |
>   -    error_report_err(local_err);
> -+    error_report_errp(errp);
> ++    error_report_errp(____);
>   |
>   -    error_reportf_err(local_err, args);
> -+    error_reportf_errp(errp, args);
> ++    error_reportf_errp(____, args);
>   |
>   -    warn_report_err(local_err);
> -+    warn_report_errp(errp);
> ++    warn_report_errp(____);
>   |
>   -    warn_reportf_err(local_err, args);
> -+    warn_reportf_errp(errp, args);
> ++    warn_reportf_errp(____, args);
>   )
>   ?-    local_err = NULL;
>   
>   |
> --    error_propagate_prepend(errp, local_err, args);
> -+    error_prepend(errp, args);
> +-    error_propagate_prepend(____, local_err, args);
> ++    error_prepend(____, args);
>   |
> --    error_propagate(errp, local_err);
> +-    error_propagate(____, local_err);
>   |
>   -    &local_err
> -+    errp
> ++    ____
>   )
>        ...>
>    }
> @@ -205,27 +202,43 @@ symbol errp;
>   // conflicts with other substitutions in it (at least with "- local_err = NULL").
>   @@
>   identifier rule1.fn, rule1.local_err;
> -symbol errp;
>   @@
>   
>    fn(...)
>    {
>        <...
>   -    local_err
> -+    *errp
> ++    *____
>        ...>
>    }
>   
>   // Always use the same patter for checking error
>   @@
>   identifier rule1.fn;
> -symbol errp;
>   @@
>   
>    fn(...)
>    {
>        <...
> --    *errp != NULL
> -+    *errp
> +-    *____ != NULL
> ++    *____
>        ...>
>    }
> +
> +@@
> +identifier fn;
> +symbol errp;
> +@@
> +
> + fn(...,
> +-   Error **____
> ++   Error **errp
> +    ,...)
> + {
> + ...
> + }
> +
> +@@
> +@@
> +-____
> ++errp
> 


-- 
Best regards,
Vladimir

