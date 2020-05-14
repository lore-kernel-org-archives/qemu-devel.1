Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4D6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 08:02:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5285A2065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 08:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rtiUchVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5285A2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ8ob-0005Lj-H7
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 04:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZ8mb-000309-Gs
 for qemu-devel@nongnu.org; Thu, 14 May 2020 03:59:57 -0400
Received: from mail-eopbgr00106.outbound.protection.outlook.com
 ([40.107.0.106]:4566 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZ8mW-0003PN-It
 for qemu-devel@nongnu.org; Thu, 14 May 2020 03:59:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FF78L4fkGBxGveL3tzRa7LyoOvE58aoS5UAJuY7XZkAd8vABaC2FHGrIentmYjDsxTAqqeoMoB6IOMFP+T8PE3w9/PyknjmeTHAG6VW4+mvPyo7kwJQNh4VPXOFNS5NFlhPXmxoLBdNaZJo7SlNZYiYbcG9M4zznacefthb02Fu1ZfMe+TXef77hFsw7evnkeXeTZqNe18Ol0F2pLF0fqaO4hnJ4fKeePUCRIS9hYxMZRHFtEk34xl8JOSg/N8bSSluh0+eKDuM2wsEO7ul6AA+o0nqyNnsAo40hfkURdcIIb1deXXvO8XXIUVU2wqltE/euOz+FmsA1LUfRopeBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtdEX1qlm82sRFrHQ9X0HAoEtAenB5QcQHmLMPAJGJw=;
 b=RQbwWE1r1A+dlnUkjzGcX0zKeRKQrJ81fBpoDWQ0HCH4mD4Nx8LABevqRj077YZ82TR3qlAf46EAo2/8R63NOiKhM73ConpWyxelBH1i6xB8BqD7jYOZCwJ0Lo86ZZibe+EHPa4segRh8xic7jerMb6c5nFqjFBWadUJdLInGlFqMrkOBDUkigVxR1unygzFRciKIPvW6fJJLlKEl2POGaqS0O0n5N8t7LZ2ZVrzhihRUNWqCODwEGeWx3tWCnppZCTdzCBjfzYKjKZ2/iR8Y8qJIagzrsmrYmRpLa6ZwQRWe4xOyMcXdka5YCVuHfnc1biOBTBsHIvLF+BW6+TZig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtdEX1qlm82sRFrHQ9X0HAoEtAenB5QcQHmLMPAJGJw=;
 b=rtiUchVOiJCrU+HC3DsSDJv6d5E+bvSSoOB9uJ3wHI5aupHDB/1cxDCH/Lz5/pP6SwKQCiGAKD3FCGs3fUvp6L07mYGAP1vJCZgZiVSqbceC+H1ihErzXUblekEzK1xnhrqPQx+x1FS/wBi6Ln0qSCcJdBsLX220KMYttHTD6ag=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5447.eurprd08.prod.outlook.com (2603:10a6:20b:10b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Thu, 14 May
 2020 07:59:49 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Thu, 14 May 2020
 07:59:49 +0000
Subject: Re: Questionable aspects of QEMU Error's design
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <87blo7heag.fsf@dusky.pond.sub.org> <87blndey9c.fsf@dusky.pond.sub.org>
 <3b9d53fd-bdd0-c15b-292c-c4952fa24dfd@virtuozzo.com>
Message-ID: <923ceeeb-1fc8-489e-a32d-4cebfa6eadae@virtuozzo.com>
Date: Thu, 14 May 2020 10:59:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <3b9d53fd-bdd0-c15b-292c-c4952fa24dfd@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0109.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.186) by
 AM0PR01CA0109.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Thu, 14 May 2020 07:59:49 +0000
X-Originating-IP: [185.215.60.186]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea11dc1f-7e5c-468f-49aa-08d7f7dcc6c0
X-MS-TrafficTypeDiagnostic: AM7PR08MB5447:
X-Microsoft-Antispam-PRVS: <AM7PR08MB54474301B07F1B46BAE0C99CC1BC0@AM7PR08MB5447.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 41xgHW5ysov4JOCuxnJdS2s0+evykEKha3yihI5XZpdvcw/1oDyRvP0CysPTTSHKDYSRBEWHjqm4QPCtpUMpg/QlF+I0qCyFwmg90hTRufr4LK2GF2zKal1YO9cCmDthR0Lc6Pdf0xJUO8ok4v2uSqg8jOaMqSvpWXRUjpVk9NUXBc02bU6xNZKOrEOSZAAEJUh95/w+JDZDf6IAZEPsbvPdY4emMROUX11/apcSVaR2JqGDZ/VjHY80AHsmpSJN/iAYxwIVX/w5bKb2FMz2g5ltz/MSCF5svZ+xVzV0rlC1XozmFfhQNtLslCKBoYU+PqCElUYOoV/pV6YpipPoWHWoVeDIih7C8Yz2WVWW6Ysf4nxzUKq41lEdKfRPbKqgyLBLmZfTa2EWqcW+64Kp4yCBcXjubFhubX/HntUuU6ElPeZ+oofF90Z6EO28DQDYAVwozobCyAahkrUbGTBROYNp5wsXI2kZZsw/oAk22+utgg4FWlWjabWR89k5eOj6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39840400004)(346002)(366004)(396003)(136003)(5660300002)(86362001)(8936002)(36756003)(16576012)(66556008)(66946007)(8676002)(478600001)(16526019)(31686004)(186003)(956004)(6486002)(54906003)(2906002)(316002)(66476007)(31696002)(2616005)(4326008)(52116002)(26005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: VvxnlQHD40LGyBsWSaTlEMNdCBz5mU1b4yek1gHOQAEI3QugdqkvEATpRdMFVOVrvmB52NA6gernshvv/FsI/Fuyj9Eh/WPboh25IuqwqSLDWJLBZPCXh5qL0yGB7g9ZxOmJ0wv47vdQWa9i5cBO5IhjA/FO/rGZHDedriv4WY1qkZVGZfPGJC8NqMTmhmMet79ETEXs31UvmlAsfjYxWMmiixDVtsgtYbBEAWt2+G/XMvCvFQJyvP+pe1gHB+76O5odk4hRbtux7Hx5IRBkOz/IbLtFWrh/VJINapA5vAQTyr88So5NzwMxWuga7WEbaUapO55MnN5pYZWsBHWG3DfB+YN61PQAmuaqAGesTfGSyoBstLWWvy8sKeLBZ/f4bmUEyVCUdNf2NzaQxngcl7qmzBcwgGtkYolR9U5uyyEo123JF6xewy4LqlKpxK9QLtnStgQ+l8jtge5Mrewk58ftAP1HLbNSBaNqNmxxCm00sXHqNAMPwbuntD/oKw8Q
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea11dc1f-7e5c-468f-49aa-08d7f7dcc6c0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 07:59:49.7641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Y0Ubh0+yFUOzqrRfmz1xxPhYfgO3/GHnU3wy+u3BaVjbVFl1lAMR2KAR4U+NQ+pzQxgAjakpFm15nSoxZjy8e/ZhsHi/s8kbeWEO+Wrml8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5447
Received-SPF: pass client-ip=40.107.0.106;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 03:59:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

28.04.2020 08:20, Vladimir Sementsov-Ogievskiy wrote:
> 27.04.2020 18:36, Markus Armbruster wrote:
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>>> Markus Armbruster <armbru@redhat.com> writes:
>>>
>>>> QEMU's Error was patterned after GLib's GError.  Differences include:
>>> [...]
>>>> * Return value conventions
>>>>
>>>>    Common: non-void functions return a distinct error value on failure
>>>>    when such a value can be defined.  Patterns:
>>>>
>>>>    - Functions returning non-null pointers on success return null pointer
>>>>      on failure.
>>>>
>>>>    - Functions returning non-negative integers on success return a
>>>>      negative error code on failure.
>>>>
>>>>    Different: GLib discourages void functions, because these lead to
>>>>    awkward error checking code.  We have tons of them, and tons of
>>>>    awkward error checking code:
>>>>
>>>>      Error *err = NULL;
>>>>      frobnicate(arg, &err);
>>>>      if (err) {
>>>>          ... recover ...
>>>>          error_propagate(errp, err);
>>>>      }
>>>>
>>>>    instead of
>>>>
>>>>      if (!frobnicate(arg, errp))
>>>>          ... recover ...
>>>>      }
>>>>
>>>>    Can also lead to pointless creation of Error objects.
>>>>
>>>>    I consider this a design mistake.  Can we still fix it?  We have more
>>>>    than 2000 void functions taking an Error ** parameter...
>>>>
>>>>    Transforming code that receives and checks for errors with Coccinelle
>>>>    shouldn't be hard.  Transforming code that returns errors seems more
>>>>    difficult.  We need to transform explicit and implicit return to
>>>>    either return true or return false, depending on what we did to the
>>>>    @errp parameter on the way to the return.  Hmm.
>>> [...]
>>>
>>> To figure out what functions with an Error ** parameter return, I used
>>> Coccinelle to find such function definitions and print the return types.
>>> Summary of results:
>>>
>>>     2155 void
>>>      873 signed integer
>>>      494 pointer
>>>      153 bool
>>>       33 unsigned integer
>>>        6 enum
>>>     ---------------------
>>>     3714 total
>>>
>>> I then used Coccinelle to find checked calls of void functions (passing
>>> &error_fatal or &error_abort is not considered "checking" here).  These
>>> calls become simpler if we make the functions return a useful value.  I
>>> found a bit under 600 direct calls, and some 50 indirect calls.
>>>
>>> Most frequent direct calls:
>>>
>>>      127 object_property_set_bool
>>>       27 qemu_opts_absorb_qdict
>>>       16 visit_type_str
>>>       14 visit_type_int
>>>       10 visit_type_uint32
>>>
>>> Let's have a closer look at object_property_set() & friends.  Out of
>>> almost 1000 calls, some 150 are checked.  While I'm sure many of the
>>> unchecked calls can't actually fail, I am concerned some unchecked calls
>>> can.
>>>
>>> If we adopt the convention to return a value that indicates success /
>>> failure, we should consider converting object.h to it sooner rather than
>>> later.
>>>
>>> Please understand these are rough numbers from quick & dirty scripts.
>>
>> FYI, I'm working on converting QemuOpts, QAPI visitors and QOM.  I keep
>> running into bugs.  So far:
>>
>>      [PATCH v2 for-5.1 0/9] qemu-option: Fix corner cases and clean up
>>      [PATCH for-5.1 0/5] qobject: Minor spring cleaning
>>      [PATCH v2 00/14] Miscellaneous error handling fixes
>>      [PATCH 0/4] Subject: [PATCH 0/4] smbus: SPD fixes
>>      [PATCH 0/3] fuzz: Probably there is a better way to do this
>>      [PATCH v2 00/15] qapi: Spring cleaning
>>      [PATCH 00/11] More miscellaneous error handling fixes
>>
>> I got another one coming for QOM and qdev before I can post the
>> conversion.
>>
>> Vladimir, since the conversion will mess with error_propagate(), I'd
>> like to get it in before your auto-propagation work.
>>
> 
> OK, just let me know when to regenerate the series, it's not hard.
> 

Hi! Is all that merged? Should I resend now?

-- 
Best regards,
Vladimir

