Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07B0C83004
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 05:42:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6649B206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 05:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QcQY51Y9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6649B206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTJ1G-0005Uz-EC
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 01:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTIxE-0002pd-CC
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 01:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTIfB-000066-19
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 01:23:35 -0400
Received: from mail-eopbgr70138.outbound.protection.outlook.com
 ([40.107.7.138]:56526 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTIfA-00005n-9G
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 01:20:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNUtAQ60Hcer2wBnZBdmG/I4/BP8lgSPBiRoKlsV0cw2GugKeP1WDbBcgU/ujf8LiYz6hkN0OhF3CY5t/q4www3Kl3DONuIFHs2USWaegT6+zOWmJKRTUrOs/yviN1hi8C6PgYSKW+fswUMd6yC/I3GztYoz4zO2I+/k3tD5GtrlR9mK300/cs0mVcY0jukJ9vHxQ1uhe3KDWIJ/Z1YVYvp6cIjnZo8E5bJFC7J13UwS64XnUKc5XVi+oT/QNs0HFzZoDx0bS0Vu1tJOM537p1giJc+quzP5UfN/Gr1NN2E/zu0EJbLyoU5uvx6EwpxCYbmz/ZELIuygOLrpAEAwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Z+mitY1eBx3nzvo3oqkbyUsMnOqZ79y23GIN/dACpU=;
 b=OBzZvB3+zlkTrNLIyWe/3VO48RMyMnvNJrAtozDP4oHuyA1Ikdu5rLyy5kkyVt+WGSErtsor4CssEB2CZay0mcKc6uLeG2vhfZijbOxmJd4gdm8LvsYVlfConFcV9KkrIZdjUMJKGgstk0WhippNLV3aakJWF0Cq4jKa1cEhEkJJq8Akz1qiCftLR6c3YTGy1iSUh9F+G5ThdzmxvJIgbF+TdswwCdn5modtd3FU/+oUD8ImQ5HeGKa7CRQDqFpPCEQ0ZoRQxYgeS/lZbREt/qJNVS/iHKCvJLgv2NQRBsFTksfwmcUjK8ZF5RpKEFCVXfgP4JVFoMnDH2ypXpZEQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Z+mitY1eBx3nzvo3oqkbyUsMnOqZ79y23GIN/dACpU=;
 b=QcQY51Y99A5zVCw0DgRPvSb1rEUkLLBQtTv/k3J1xI5BgqxJeILu9jlpJ05dbC2EnD3yXJCMVUTIZWfqAooSqRZE6WUd3WRX+BYGS8Mn5SZxj5BC7k1OemfgOLKaq5179S1yZ5BsuEwF74lKJ4N6vcenEH0wtaZ6ywRYToVxcV4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5479.eurprd08.prod.outlook.com (2603:10a6:20b:104::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 05:20:04 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 05:20:04 +0000
Subject: Re: Questionable aspects of QEMU Error's design
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <87blo7heag.fsf@dusky.pond.sub.org> <87blndey9c.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200428082002459
Message-ID: <3b9d53fd-bdd0-c15b-292c-c4952fa24dfd@virtuozzo.com>
Date: Tue, 28 Apr 2020 08:20:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87blndey9c.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:200:89::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.155) by
 AM4PR0202CA0003.eurprd02.prod.outlook.com (2603:10a6:200:89::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Tue, 28 Apr 2020 05:20:03 +0000
X-Tagtoolbar-Keys: D20200428082002459
X-Originating-IP: [185.215.60.155]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 641643dc-5219-418a-9923-08d7eb33ceb6
X-MS-TrafficTypeDiagnostic: AM7PR08MB5479:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5479C42EB3DDAE3BC185C996C1AC0@AM7PR08MB5479.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39850400004)(376002)(16526019)(54906003)(316002)(4326008)(36756003)(16576012)(8936002)(26005)(81156014)(52116002)(5660300002)(6486002)(478600001)(2906002)(31686004)(86362001)(186003)(8676002)(66946007)(956004)(31696002)(2616005)(66556008)(66476007);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1IWmI3+rj3wJBcEtak90pdUOtzDmP69FyKWB3XX6UKdC/DZydlSuJHZon3vYITbegBX4n/gAvc+9bBDglkGctl3HXwYnLlOsNHpj2OYKFYFZ295GhVHG36/2qzguVGcgjF8AKD4o4fzDGOuwTvHxiWkOHvgPK5s9BcMRWiTm1EVOQLHyT1Zc0HWFHeCQgSmUG8rszGvWVi1mhSjE7j83MJRhSh6d/IGtu8iZ2O4Oc++fKPeXkAz5TuY1IWw58FOhIyLx3SsPFAMzI5+cF51y+EYPwwvgk7McyeINjcbuO+xPWNYTcOxy7owlT0wcB2SIthnUamP/E/34Y99KGLG89tz5TDhSXc28YZ5Pq3Ot9oaq1dUBKtmazYmF1uiLd2DHnlkknCewh2PKr+lBbCZJprDL4Vp5s6wBFtUg1pjrp59jFFb4dy8Bc6gpo5guRqQO
X-MS-Exchange-AntiSpam-MessageData: hNtDaZS1knA51x+5IqKAHYff0lbt4O+YhJsk89W/ahJGrmapW7O6ymYoW032pWA65csFmy6S2XWrutZAKGKLzOwm1wL/6KFAeti6hp8x/rgzg45vDfGddTarfNHIrRiR2xmzga6yHOoDXu3USu3wetnbTXzhqnZGZ9Gc3eJGcYUaRJVNU9+2WcKvpcplJUjvwSbekWhoZCRKtBVmyOrEh6tJddaPwrOTFsCmN4chnx2dfALyethGk4croTIAi9bKnHs9eawtC1AEL803YO4gx6JTj5qnn0SR6E5IjhxiZcNvoKrI41dKS8GwBuk/OiWefzjLZXKwl82AZIMuZe59+VZs/ZgOsoAdRNONXnD0bD810wZ++G53Q8ALhXOIuZZueKOmq44KU9qag5Y1SdCH+dDRXegYBlE4tEoiAgUHEJK/0iq8lv+cwDN0hg6qGeFh67MqHLpTxJ+q5HLwcRQjuXAXzhLOqp0JMmnk35HF9CybvvkPG2wm2CAEqGygn3T3yWMmhjYm6XGrsjdxQQokVEQTMUnqoTmvmht13V5dvU//mz2kMvEr5teqNi7kWYg/triddF+mshA3UFt5bLNy12ht4ErQJzSpqrGNmWRB6Us4TR84XiBDItvFCppr3Fuh0ZJLwrspgQKiHMHGTHJo69pNne21jQ5gh6HI2eDmw6SKul0MAVYUBnXWQR6gQqwNgasQBjt0CPekyL0lrVzREUlfw8PZu2uQKFcZ0S3EIpAhjlBDUcaWt9PxwJ8itY5zrmOrWP7+EqTkEG8TqEhWkU+DHoHD6HWj664b7rzWDIk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 641643dc-5219-418a-9923-08d7eb33ceb6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 05:20:04.4358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6EenoCbnioaA5p1UM4SuqISm7vvfj4jSRFYyLcWsosDMaMPgHpg+rE5Z5DMYLtts/URKDEsQCA5SR071AAeNksej3Oj7pz9BxdziEfPRXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5479
Received-SPF: pass client-ip=40.107.7.138;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 01:20:05
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.138
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.04.2020 18:36, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>>> QEMU's Error was patterned after GLib's GError.  Differences include:
>> [...]
>>> * Return value conventions
>>>
>>>    Common: non-void functions return a distinct error value on failure
>>>    when such a value can be defined.  Patterns:
>>>
>>>    - Functions returning non-null pointers on success return null pointer
>>>      on failure.
>>>
>>>    - Functions returning non-negative integers on success return a
>>>      negative error code on failure.
>>>
>>>    Different: GLib discourages void functions, because these lead to
>>>    awkward error checking code.  We have tons of them, and tons of
>>>    awkward error checking code:
>>>
>>>      Error *err = NULL;
>>>      frobnicate(arg, &err);
>>>      if (err) {
>>>          ... recover ...
>>>          error_propagate(errp, err);
>>>      }
>>>
>>>    instead of
>>>
>>>      if (!frobnicate(arg, errp))
>>>          ... recover ...
>>>      }
>>>
>>>    Can also lead to pointless creation of Error objects.
>>>
>>>    I consider this a design mistake.  Can we still fix it?  We have more
>>>    than 2000 void functions taking an Error ** parameter...
>>>
>>>    Transforming code that receives and checks for errors with Coccinelle
>>>    shouldn't be hard.  Transforming code that returns errors seems more
>>>    difficult.  We need to transform explicit and implicit return to
>>>    either return true or return false, depending on what we did to the
>>>    @errp parameter on the way to the return.  Hmm.
>> [...]
>>
>> To figure out what functions with an Error ** parameter return, I used
>> Coccinelle to find such function definitions and print the return types.
>> Summary of results:
>>
>>     2155 void
>>      873 signed integer
>>      494 pointer
>>      153 bool
>>       33 unsigned integer
>>        6 enum
>>     ---------------------
>>     3714 total
>>
>> I then used Coccinelle to find checked calls of void functions (passing
>> &error_fatal or &error_abort is not considered "checking" here).  These
>> calls become simpler if we make the functions return a useful value.  I
>> found a bit under 600 direct calls, and some 50 indirect calls.
>>
>> Most frequent direct calls:
>>
>>      127 object_property_set_bool
>>       27 qemu_opts_absorb_qdict
>>       16 visit_type_str
>>       14 visit_type_int
>>       10 visit_type_uint32
>>
>> Let's have a closer look at object_property_set() & friends.  Out of
>> almost 1000 calls, some 150 are checked.  While I'm sure many of the
>> unchecked calls can't actually fail, I am concerned some unchecked calls
>> can.
>>
>> If we adopt the convention to return a value that indicates success /
>> failure, we should consider converting object.h to it sooner rather than
>> later.
>>
>> Please understand these are rough numbers from quick & dirty scripts.
> 
> FYI, I'm working on converting QemuOpts, QAPI visitors and QOM.  I keep
> running into bugs.  So far:
> 
>      [PATCH v2 for-5.1 0/9] qemu-option: Fix corner cases and clean up
>      [PATCH for-5.1 0/5] qobject: Minor spring cleaning
>      [PATCH v2 00/14] Miscellaneous error handling fixes
>      [PATCH 0/4] Subject: [PATCH 0/4] smbus: SPD fixes
>      [PATCH 0/3] fuzz: Probably there is a better way to do this
>      [PATCH v2 00/15] qapi: Spring cleaning
>      [PATCH 00/11] More miscellaneous error handling fixes
> 
> I got another one coming for QOM and qdev before I can post the
> conversion.
> 
> Vladimir, since the conversion will mess with error_propagate(), I'd
> like to get it in before your auto-propagation work.
> 

OK, just let me know when to regenerate the series, it's not hard.

-- 
Best regards,
Vladimir

