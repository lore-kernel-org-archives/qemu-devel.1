Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A1EC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 06:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4CBD20784
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 06:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="utJwlh3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CBD20784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJt51-0003V9-VQ
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 02:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJt4J-00034L-5s
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 02:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJt4H-0004tz-3q
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 02:11:10 -0400
Received: from mail-db8eur05on2109.outbound.protection.outlook.com
 ([40.107.20.109]:54816 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJt4G-0004t4-Gw
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 02:11:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGJ7b9an3z9s8wh2l9IJkYTfHIOyHZJURlNoFQHLaRhuu4QrBJ9sBzSqPR3pBATV2uyOVRRaRkRZj0cmNxccwMmrgACF190GBZsU+OW2kLc6zgNfM2OxqhiQe9O3DPTtCsV4lQvXge1S6ZkX52ZJGqJ3qsRJNMo9jlLgU0IR/6AefB1T+vtJLp616x8BLwsv1Sq/HRwpEhBf6WEKm5GH4arAAKmp12hMzS7XJw7uwhqvpH0e5nxg1HX8C6Mndznh9jqlah+RUoBFsw5UCBlLQtVAjcCdtRvJED6U+aegXftqnv3gnSfK860/+l/uIlUyl5z+9mRg0pipuxbbnNXf6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qe+ieZKv9dY21fnMe3a31HNuqt4WwMVN9ug1K7oorkk=;
 b=eBJYaGXQGh0OYlwh9iSfwqgJbFQqsTV+wBorPjVHhYCOKsXDpm9j5NHEaSfguE1MfNjEiPFonT1F66Uxatnz2KR8oLBm27m3TfqxnGsVm7tpHsx9u5QknWkZlbtmTJ6pXQlaoCCvLBvVWUFMvNB26BYb3xy1mJqVNgKHHwrxLL5QDbr89ukbGg+3boGPaVaMk3egP9S7GnoCHqPJvurYtJcVuCrq1uDga8X61pg2hgfLuCUNW+Od8GSX6/oSkEQuCUZIEPhQqFRqeM2uLYA1b12LHvYv5XZ5DgOiOAlh//GegAJGCghWsZQD75wVfoHpjWFNIomcnpFsgudYXBjhXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qe+ieZKv9dY21fnMe3a31HNuqt4WwMVN9ug1K7oorkk=;
 b=utJwlh3BbkGYYEio/3GZ+cZUpWVyH+/Vef7MP9xzAMwmdWt7J0JZyAbtK5AGBK+eToH85T1pkqBeL57IkYX24Y7K/1PI17shMufOInavmUB0NO8j2Ui75KVqFIr0N7OfI+i4LLOkKpRN44+sSuyzYqJdihhtDtAKmCOXKCPNGIE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5527.eurprd08.prod.outlook.com (10.141.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Thu, 2 Apr 2020 06:11:04 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.016; Thu, 2 Apr 2020
 06:11:04 +0000
Subject: Re: Questionable aspects of QEMU Error's design
To: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <CAFEAcA_b1gZ-B4NaEdQS2zffdvobW=FUx4ysEgXVAz+=cZ+R3Q@mail.gmail.com>
 <87sghmbfgc.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200402091103011
Message-ID: <44b5ff2c-6dce-e516-a9cc-9d80354c5a72@virtuozzo.com>
Date: Thu, 2 Apr 2020 09:11:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87sghmbfgc.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0100.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::41) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.23) by
 AM0PR06CA0100.eurprd06.prod.outlook.com (2603:10a6:208:fa::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15 via Frontend Transport; Thu, 2 Apr 2020 06:11:04 +0000
X-Tagtoolbar-Keys: D20200402091103011
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfbe4b3f-8a51-4b53-0f4c-08d7d6cca01b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5527:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5527AF4F29AD94F0C9DCF655C1C60@AM7PR08MB5527.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(366004)(376002)(396003)(346002)(39840400004)(54906003)(6486002)(8936002)(36756003)(8676002)(2906002)(4326008)(52116002)(16576012)(81156014)(81166006)(26005)(66946007)(31696002)(186003)(316002)(5660300002)(110136005)(86362001)(478600001)(16526019)(66476007)(2616005)(956004)(66556008)(31686004);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUnkoLFJU2jSLLKrVq7ao9MbC1NtkIxz8y8rKlpaXAzyfXDEcYUn0FTYA0dLV6qFIFB6McKyBSXek5cWEkxioLXn6H9VZcN1M3Z5RYqzY2BWvVRV1GhDub9e4vRdbiHNdA31Bg9Fc01VX6dBf7zWirE4ORUUdsXu2PKJtk7ECalNLhjRmjXgt0DY4hbhSKJPd42cumuPDdR6tC4aoGvSwkQ97NgCJfbCjZfraMN5Q3jrjKUR9pHxIKe8Xsmk9CeiRIe5EgTx7/c2wlIWyX8RvLkG48/5b6wnE/kmriBrodC8xfc+iOhgok/vuwTbcLdySmUFzRd4pv+pa+Fmy4K3+VxQLBTVZLeVMbYR9RcfKmqzvshyW8PRsHFJIeLIbIxuBEYNDvllQQCFw5nqOyMjjWOjK2SbXxBErTPNTsNrtHlCgzWTD4i3tZWtFEepEzSK
X-MS-Exchange-AntiSpam-MessageData: /ux80bqk9fsLQtCdFl9gpTZa5p9ftUk+DA816mDDOV26/IrxoP7VatFM5m2WZpvwv8NM22x5cAoM5DWmWeKKRKZuAPfN6LMChsdt8Xzt9LXylD5zNoaCVedjZkb4uS9F6Di4kJvrz5zRz7NhOWO/jA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbe4b3f-8a51-4b53-0f4c-08d7d6cca01b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 06:11:04.5229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJb3iyQeEpUr4KGgqjZCXTCzeWY7TYNGXo4Ces6whL8bUIkCGjnmI4fjsBZ4pcul6OaIvaJeovYjEBSDF3TlNrMegKMj8HgbruyoYLIr4MA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5527
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.109
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

02.04.2020 8:54, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Wed, 1 Apr 2020 at 10:03, Markus Armbruster <armbru@redhat.com> wrote:
>>>
>>> QEMU's Error was patterned after GLib's GError.  Differences include:
>>
>>  From my POV the major problem with Error as we have it today
>> is that it makes the simple process of writing code like
>> device realize functions horrifically boilerplate heavy;
>> for instance this is from hw/arm/armsse.c:
>>
>>          object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
>>                                   "memory", &err);
>>          if (err) {
>>              error_propagate(errp, err);
>>              return;
>>          }
>>          object_property_set_link(cpuobj, OBJECT(s), "idau", &err);
>>          if (err) {
>>              error_propagate(errp, err);
>>              return;
>>          }
>>          object_property_set_bool(cpuobj, true, "realized", &err);
>>          if (err) {
>>              error_propagate(errp, err);
>>              return;
>>          }
>>
>> 16 lines of code just to set 2 properties on an object
>> and realize it. It's a lot of boilerplate and as
>> a result we frequently get it wrong or take shortcuts
>> (eg forgetting the error-handling entirely, calling
>> error_propagate just once for a whole sequence of
>> calls, taking the lazy approach and using err_abort
>> or err_fatal when we ought really to be propagating
>> an error, etc). I haven't looked at 'auto propagation'
>> yet, hopefully it will help?
> 
> With that, you can have
> 
>          object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
>                                   "memory", errp);
>          if (*errp) {
>              return;
>          }
>          object_property_set_link(cpuobj, OBJECT(s), "idau", errp);
>          if (*errp) {
>              return;
>          }
>          object_property_set_bool(cpuobj, true, "realized", errp);
>          if (*errp) {
>              return;
>          }
> 
> but you have to add
> 
>          ERRP_AUTO_PROPAGATE();
> 
> right at the beginning of the function.
> 
> It's a small improvement.  A bigger one is
> 
>          if (object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
>                                       "memory", errp)) {
>              return;

return false; you mean, assuming we converting the caller too...

>          }
>          if (object_property_set_link(cpuobj, OBJECT(s), "idau", errp)) {
>              return;
>          }
>          if (object_property_set_bool(cpuobj, true, "realized", errp)) {
>              return;
>          }

Hmm..

Somehow, in general, especially with long function names and long parameter lists I prefer

ret = func(..);
if (ret < 0) {
     return ret;
}

notation to moving the entire function call into if condition.. Extra level of parentheses complicates the view of the code.

But, yes, may be for boolean functions it looks a bit strange:

ok = func(..);
if (!ok) {
     return false;
}


> 
> This is item "Return value conventions" in the message you replied to.
> 
> Elsewhere in this thread, I discussed the difficulties of automating the
> conversion to this style.  I think I know how to automate converting the
> calls to use the bool return value, but converting the functions to
> return it looks hard.  We could do that manually for a modest set of
> frequently used functions.  object.h would top my list.
> 

Are you sure that adding a lot of boolean functions is a good idea? I somehow feel better with more usual int functions with -errno on failure.

Bool is a good return value for functions which are boolean by nature: checks, is something correspond to some criteria. But for reporting an error I'd prefer -errno.

-- 
Best regards,
Vladimir

