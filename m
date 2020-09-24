Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE6DC4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:00:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FA54206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DaO8zZaC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA54206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLLFQ-0000a9-T3
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 03:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLLEF-0008Nt-KX; Thu, 24 Sep 2020 02:59:44 -0400
Received: from mail-eopbgr140139.outbound.protection.outlook.com
 ([40.107.14.139]:4419 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLLEB-0004zS-Lm; Thu, 24 Sep 2020 02:59:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njqPAP0wUnbJff1+hTm0dHY5qaTaxUv9kX7WmXvq6RYOXunQlSZMGmbBHIe+Qu04ijpRrZl3YO9OLGXA9W069X3B166RRXzweUwtuxO6tSlGbnbvIhBcp0liV1SYEputb03mw+3+9qrimIS7vAcFpHaUPx/2FupvQnbMAFN19imx2gl22zwwjFWM2snoTq70XvKoQL56uOW3PPu91nQWHoZ1Wod2ZF+nsDAU7Vv9XbM9ghF5HCeGXvXXK4+6LcenyhOC7b2SwpXkIVxNdlrVOik121IoBYgG1rBDjSXZxMYg6pv8TceDLYfAlbQjOHJlwmXg59u7R5uGxi5LSMcocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/SGanRGJS1/Jkh1ZeAsAAmfWYpHt9cTKyW0VtxCo5U=;
 b=ZpQD7lKJNfnWPmomh4tEiCn4vt67rBaIBdJ0NqCzGVsgPR/zkdkdUreaMCEBLZrHrN/sDdif/qzu+4WCmTAgFzY4iTw4lh8n/1qxKykFoGvcR8y2npMAdtzOLchlJa/wSy4w8E2sfIp4nKqG7/IxSDYexHkH8sMBeCvVzJrpQQDbP0lolBozgBmK/p9taPyWvbPL9KPkPumNT3QijJAU2qYey5eJ944d5dpZtwlln/Hwna526WdWL334cusCSsCGSL7Xepv8P7oxqXDuRvWjwYCeZlJV09hXm2sYqYHcpvbia2VTDkxGIBSKre3GV1FRgfEwdJijDwjLY2zaYDwDZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/SGanRGJS1/Jkh1ZeAsAAmfWYpHt9cTKyW0VtxCo5U=;
 b=DaO8zZaCG9fu4c1XE7Z26YIZxUjTZJU9vwmsIuE+X6unoIeX7jlziJkbdatTcxIGU8SLeVc5/WJV5maqc8myP+joK65ZHn1zNGo2wMl9PCrIrF4VNWhaF9edc3zhdX776YkE0RNaoRItmnXt3Uy8RovSe968PVGa7S0RJePeuAg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2982.eurprd08.prod.outlook.com (2603:10a6:209:43::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Thu, 24 Sep
 2020 06:59:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Thu, 24 Sep 2020
 06:59:34 +0000
Subject: Re: [PATCH v8 4/7] scripts: add block-coroutine-wrapper.py
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, crosa@redhat.com, ehabkost@redhat.com,
 fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 den@openvz.org, John Snow <jsnow@redhat.com>
References: <20200915164411.20590-1-vsementsov@virtuozzo.com>
 <20200915164411.20590-5-vsementsov@virtuozzo.com>
 <be6408ba-a430-0294-96e8-a38af7f94c1b@virtuozzo.com>
 <73781605-a817-c627-fea9-183caf84c4b6@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <fbdd3c1c-56c6-7256-e868-7524d93ccd9a@virtuozzo.com>
Date: Thu, 24 Sep 2020 09:59:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <73781605-a817-c627-fea9-183caf84c4b6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::23)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.94) by
 FRYP281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.14 via Frontend Transport; Thu, 24 Sep 2020 06:59:33 +0000
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 314e69f5-423f-47f3-44a6-08d8605764ad
X-MS-TrafficTypeDiagnostic: AM6PR08MB2982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB29827AE0ABC983C5E2366BD8C1390@AM6PR08MB2982.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIEBOFuMpbo9bpvwIo79/n3ugXaRDcwM0XwoDV2SezRYCcR6pxlx8i5wHJYddahwwNbwFEAMTzBIrfBpr5guc+mA51h8//WYLeAuos0Zwa95j6RZRvk0jjQBr2+f+uwx+mW8XpldDEXSTohmyojB5PFwsdLidD4Bb7IHvmLhBTOd/oO3Ifopq1q1mHaodZYuF8mrfXmcjjx/1TJa2yIg7B8clap3m00apIg6QagemWlDppnxoYkdOSm9TG0nmUac3fMjcu4UudZnkbOvcXqgph7Xy1v/xqZ9Q1luE2xGPJJB/KbpLVEjMovsBs8tVfVX/eJCpJP6IDJXK776WsMs0WRfwudgkCoenPech2BfnhuSbCetZ1LO671v0Vw10/FfH6yGN7XVU6HhDwPGB1VEyBEDWQXNg0H4lGtqKgV+wVFLPOJk5jfPrUIB94tBbZr560pnZJyK+nCJLCy1YyNfXRD1IhswXJya9HtvhLGS7IQvHIK/+UdyIc9Uwapt2ui9ZEDe9O70GJBlQkwaFuwMwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39830400003)(52116002)(66946007)(30864003)(66476007)(5660300002)(26005)(53546011)(186003)(16526019)(316002)(16576012)(4326008)(36756003)(478600001)(83380400001)(7416002)(31686004)(956004)(86362001)(2616005)(31696002)(8676002)(2906002)(6486002)(8936002)(66556008)(2004002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zNBCCQc3Uqy22nWutBaECpCmWM3lXqiyGvVBDrKXl3FmAy0jmtQg5Rq6B5I6pliZr19kWJhIjal1xY4rsFJYTW3AtG45jsDwR10R3Ndr3VR6ZTR3QlJFPCOSBN6zsjQqsfNvM/oYal6x4ZtfAe41YK4hVw34JFdRjVVt0vyzRJFTj1kzAsOGMP+pQ6OA1crR6MSIlZUUkbu7Xct/O0eORjU49OOUpL1A+ruGEIxQORZCon3Vi1WeVFVysK10UW8nOCXP9GbLFwqyjArGpkvgf2OpiV91EMKxvy44JFPJphPln9oLjmegF8SQqHB+pqSvjG+BMZ5kNgPUZzt/YjwxzCUKqXLPmlU8rD/SEK0B+p7NoZzNVM8jnjqDR8MH6JqRyjJ3xHrldXd8ePIfkXCTRbCq0JUunM0SnEABoO5fYPA+N9tMmChbkCOCf4TEK3qCgcY/juhrdjLxTJPH3AtzhKhq3HJdtxiGO48XHHcl5m3JVnL8RgY1wwLOquceV5pOfq7XGMlOYajIhWyYskLZx5MSmPXOCW1yTE5i6V/FqmO+5KY+k9MwEdkf69zt8drikoRdR4mjSXmN3J+J/HGCo3ZYh7epAKfh2qei7D6Lb2iISwMMNWKwzI9cNkR9rYWDiHN17bbrZ046vnloFMuuJA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314e69f5-423f-47f3-44a6-08d8605764ad
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 06:59:34.3450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q6cI5+s9hi8dkk9Jojma1KTxRTxv3jhYhQICme74rZegI62YlUK6vXlj8Izibry7xo5Ue0LlK55Q3rzWcxJjwjouzYCDgKF/rh2SVXLfiFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2982
Received-SPF: pass client-ip=40.107.14.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 02:59:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
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

24.09.2020 03:00, Eric Blake wrote:
> On 9/15/20 3:02 PM, Vladimir Sementsov-Ogievskiy wrote:
>> 15.09.2020 19:44, Vladimir Sementsov-Ogievskiy wrote:
>>> We have a very frequent pattern of creating coroutine from function
>>> with several arguments:
>>>
>>>    - create structure to pack parameters
>>>    - create _entry function to call original function taking parameters
>>>      from struct
>>>    - do different magic to handle completion: set ret to NOT_DONE or
>>>      EINPROGRESS or use separate bool field
>>>    - fill the struct and create coroutine from _entry function and this
>>>      struct as a parameter
>>>    - do coroutine enter and BDRV_POLL_WHILE loop
>>>
>>> Let's reduce code duplication by generating coroutine wrappers.
>>>
>>> This patch adds scripts/block-coroutine-wrapper.py together with some
>>> friends, which will generate functions with declared prototypes marked
>>> by 'generated_co_wrapper' specifier.
>>>
> 
>>>
>>>      4. add header with generated_co_wrapper declaration into
>>>         COROUTINE_HEADERS list in Makefile
> 
> This phrase is out-of-date.  I also see 4 steps here,...
> 
>>>
>>> Still, no function is now marked, this work is for the following
>>> commit.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>
>>> ---
>>>   docs/devel/block-coroutine-wrapper.rst |  54 +++++++
>>>   block/block-gen.h                      |  49 +++++++
>>>   include/block/block.h                  |  10 ++
>>>   block/meson.build                      |   8 ++
>>>   scripts/block-coroutine-wrapper.py     | 187 +++++++++++++++++++++++++
>>>   5 files changed, 308 insertions(+)
>>>   create mode 100644 docs/devel/block-coroutine-wrapper.rst
>>>   create mode 100644 block/block-gen.h
>>>   create mode 100755 scripts/block-coroutine-wrapper.py
>>
>>
>> Also needed:
>>
>> diff --git a/docs/devel/index.rst b/docs/devel/index.rst
>> index 04773ce076..cb0abe1e69 100644
>> --- a/docs/devel/index.rst
>> +++ b/docs/devel/index.rst
>> @@ -31,3 +31,4 @@ Contents:
>>      reset
>>      s390-dasd-ipl
>>      clocks
>> +   block-coroutine-wrapper
> 
> I've squashed that in.
> 
>> +++ b/docs/devel/block-coroutine-wrapper.rst
>> @@ -0,0 +1,54 @@
>> +=======================
>> +block-coroutine-wrapper
>> +=======================
>> +
>> +A lot of functions in QEMJ block layer (see ``block/*``) can by called
> 
> QEMU
> 
> s/by called only/only be called/
> 
>> +only in coroutine context. Such functions are normally marked by
> 
> by the
> 
>> +coroutine_fn specifier. Still, sometimes we need to call them from
>> +non-coroutine context, for this we need to start a coroutine, run the
> 
> 
> s/context,/context;/
> 
>> +needed function from it and wait for coroutine finish in
> 
> in a
> 
>> +BDRV_POLL_WHILE() loop. To run a coroutine we need a function with one
>> +void* argument. So for each coroutine_fn function, which needs
> 
> needs a
> 
>> +non-coroutine interface, we should define a structure to pack the
>> +parameters, define a separate function to unpack the parameters and
>> +call the original function and finally define a new interface function
>> +with same list of arguments as original one, which will pack the
>> +parameters into a struct, create a coroutine, run it and wait in
>> +BDRV_POLL_WHILE() loop. It's boring to create such wrappers by hand, so
>> +we have a script to generate them.
>>
>> +Usage
>> +=====
>> +
>> +Assume we have defined ``coroutine_fn`` function
>> +``bdrv_co_foo(<some args>)`` and need a non-coroutine interface for it,
>> +called ``bdrv_foo(<same args>)``. In this case the script can help. To
>> +trigger the generation:
>> +
>> +1. You need ``bdrv_foo`` declaration somewhere (for example in
>> +   ``block/coroutines.h`` with ``generated_co_wrapper`` mark,
>> +   like this:
> 
> Missing a closing ).
> 
>> +
>> +.. code-block:: c
>> +
>> +    int generated_co_wrapper bdrv_foor(<some args>);
> 
> s/foor/foo/
> 
>> +
>> +2. You need to feed this declaration to block-coroutine-wrapper script.
> 
> to the block-
> 
>> +   For this, add .h (or .c) file with the declaration to
>> +   ``input: files(...)`` list of ``block_gen_c`` target declaration in
>> +   ``block/meson.build``
>> +
>> +You are done. On build, coroutine wrappers will be generated in
> 
> s/On/During the/
> 
>> +``<BUILD_DIR>/block/block-gen.c``.
> 
> ...but 2 in the .rst.  Presumably, the .rst steps belong in the commit message as well.
> 
>> +++ b/block/block-gen.h
> 
>> +++ b/include/block/block.h
>> @@ -10,6 +10,16 @@
>>  #include "block/blockjob.h"
>>  #include "qemu/hbitmap.h"
>>
>> +/*
>> + * generated_co_wrapper
>> + *
>> + * Function specifier, which does nothing but marking functions to be
> 
> s/marking/mark/
> 
>> + * generated by scripts/block-coroutine-wrapper.py
>> + *
>> + * Read more in docs/devel/block-coroutine-wrapper.rst
>> + */
>> +#define generated_co_wrapper
>> +
>>  /* block.c */
>>  typedef struct BlockDriver BlockDriver;
>>  typedef struct BdrvChild BdrvChild;
>> diff --git a/block/meson.build b/block/meson.build
>> index a3e56b7cd1..88ad73583a 100644
>> --- a/block/meson.build
>> +++ b/block/meson.build
>> @@ -107,6 +107,14 @@ module_block_h = custom_target('module_block.h',
>>                                 command: [module_block_py, '@OUTPUT0@', modsrc])
>>  block_ss.add(module_block_h)
>>
>> +wrapper_py = find_program('../scripts/block-coroutine-wrapper.py')
>> +block_gen_c = custom_target('block-gen.c',
>> +                            output: 'block-gen.c',
>> +                            input: files('../include/block/block.h',
>> +                                         'coroutines.h'),
>> +                            command: [wrapper_py, '@OUTPUT@', '@INPUT@'])
>> +block_ss.add(block_gen_c)
>> +
>>  block_ss.add(files('stream.c'))
> 
> I tested that this works (I'm not a meson expert, but if it works, your patch can't be too far off ;)
> 
>>
>>  softmmu_ss.add(files('qapi-sysemu.c'))
>> diff --git a/scripts/block-coroutine-wrapper.py b/scripts/block-coroutine-wrapper.py
>> new file mode 100755
>> index 0000000000..d859c07a5f
>> --- /dev/null
>> +++ b/scripts/block-coroutine-wrapper.py
>> @@ -0,0 +1,187 @@
>> +#!/usr/bin/env python3
>> +"""Generate coroutine wrappers for block subsystem.
>> +
>> +The program parses one or several concatenated c files from stdin,
>> +searches for functions with 'generated_co_wrapper' specifier
> 
> with the
> 
>> +and generates corresponding wrappers on stdout.
>> +
>> +Usage: block-coroutine-wrapper.py generated-file.c FILE.[ch]...
>> +
>> +Copyright (c) 2020 Virtuozzo International GmbH.
>> +
>> +This program is free software; you can redistribute it and/or modify
>> +it under the terms of the GNU General Public License as published by
>> +the Free Software Foundation; either version 2 of the License, or
>> +(at your option) any later version.
>> +
>> +This program is distributed in the hope that it will be useful,
>> +but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +GNU General Public License for more details.
>> +
>> +You should have received a copy of the GNU General Public License
>> +along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> +"""
> 
> John had a patch that unified how copyrights are (or are not) placed in doc comments.  I'm of the opinion that it may be easier to apply this patch as written and let him touch it up later, rather than forcing it to delay longer waiting for his style patches to land first, but I'm open to discussion on alternate approaches.

Here copyright is in doc string for purpose: it's used also for generated files :) Not sure how much is it correct, but it's fun.

> 
>> +
>> +import sys
>> +import re
>> +import subprocess
>> +import json
>> +from typing import Iterator
>> +
>> +
>> +def prettify(code: str) -> str:
>> +    """Prettify code using clang-format if available"""
> 
> Nothing else in the codebase uses clang-format, yet.  Is this an optional dependency we should be documenting somewhere?

Hmm at least I should note it in docs/devel/block-coroutine-wrapper.rst

> 
>> +
>> +    try:
>> +        style = json.dumps({
>> +            'IndentWidth': 4,
>> +            'BraceWrapping': {'AfterFunction': True},
>> +            'BreakBeforeBraces': 'Custom',
>> +            'SortIncludes': False,
>> +            'MaxEmptyLinesToKeep': 2
>> +        })
> 
> Is it worth always using a trailing comma, so that future additions don't have as many lines to touch?

Yes

> 
>> +        p = subprocess.run(['clang-format', f'-style={style}'], check=True,
>> +                           encoding='utf-8', input=code,
>> +                           stdout=subprocess.PIPE)
>> +        return p.stdout
>> +    except FileNotFoundError:
>> +        return code
>> +
>> +
>> +def gen_header():
>> +    copyright = re.sub('^.*Copyright', 'Copyright', __doc__, flags=re.DOTALL)
>> +    copyright = re.sub('^(?=.)', ' * ', copyright.strip(), flags=re.MULTILINE)
>> +    copyright = re.sub('^$', ' *', copyright, flags=re.MULTILINE)
>> +    return f"""\
>> +/*
>> + * File is generated by scripts/block-coroutine-wrapper.py
>> + *
>> +{copyright}
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "block/coroutines.h"
>> +#include "block/block-gen.h"
>> +#include "block/block_int.h"\
>> +"""
>> +
>> +
>> +class ParamDecl:
>> +    param_re = re.compile(r'(?P<decl>'
>> +                          r'(?P<type>.*[ *])'
>> +                          r'(?P<name>[a-z][a-z0-9_]*)'
>> +                          r')')
>> +
>> +    def __init__(self, param_decl: str) -> None:
>> +        m = self.param_re.match(param_decl.strip())
>> +        if m is None:
>> +            raise ValueError(f'Wrong parameter declaration: "{param_decl}"')
>> +        self.decl = m.group('decl')
>> +        self.type = m.group('type')
>> +        self.name = m.group('name')
>> +
>> +
>> +class FuncDecl:
>> +    def __init__(self, return_type: str, name: str, args: str) -> None:
>> +        self.return_type = return_type.strip()
>> +        self.name = name.strip()
>> +        self.args = [ParamDecl(arg.strip()) for arg in args.split(',')]
>> +
>> +    def gen_list(self, format: str) -> str:
>> +        return ', '.join(format.format_map(arg.__dict__) for arg in self.args)
>> +
>> +    def gen_block(self, format: str) -> str:
>> +        return '\n'.join(format.format_map(arg.__dict__) for arg in self.args)
>> +
>> +
>> +# Match wrappers declared with a generated_co_wrapper mark
>> +func_decl_re = re.compile(r'^int\s*generated_co_wrapper\s*'
>> +                          r'(?P<wrapper_name>[a-z][a-z0-9_]*)'
>> +                          r'\((?P<args>[^)]*)\);$', re.MULTILINE)
>> +
>> +
>> +def func_decl_iter(text: str) -> Iterator:
>> +    for m in func_decl_re.finditer(text):
>> +        yield FuncDecl(return_type='int',
>> +                       name=m.group('wrapper_name'),
>> +                       args=m.group('args'))
>> +
>> +
>> +def snake_to_camel(func_name: str) -> str:
>> +    """
>> +    Convert underscore names like 'some_function_name' to camel-case like
>> +    'SomeFunctionName'
>> +    """
>> +    words = func_name.split('_')
>> +    words = [w[0].upper() + w[1:] for w in words]
>> +    return ''.join(words)
>> +
>> +
>> +def gen_wrapper(func: FuncDecl) -> str:
>> +    assert func.name.startswith('bdrv_')
>> +    assert not func.name.startswith('bdrv_co_')
>> +    assert func.return_type == 'int'
>> +    assert func.args[0].type in ['BlockDriverState *', 'BdrvChild *']
>> +
>> +    name = 'bdrv_co_' + func.name[5:]
>> +    bs = 'bs' if func.args[0].type == 'BlockDriverState *' else 'child->bs'
>> +    struct_name = snake_to_camel(name)
>> +
>> +    return f"""\
>> +/*
>> + * Wrappers for {name}
>> + */
>> +
>> +typedef struct {struct_name} {{
>> +    BdrvPollCo poll_state;
>> +{ func.gen_block('    {decl};') }
>> +}} {struct_name};
>> +
>> +static void coroutine_fn {name}_entry(void *opaque)
>> +{{
>> +    {struct_name} *s = opaque;
>> +
>> +    s->poll_state.ret = {name}({ func.gen_list('s->{name}') });
> 
> Excuse my lack of python style awareness, but why are we mixing {nospace} and { space } on the same line?

Hmm. It's just
  - strange for me to add spaces in first case, for just one variable
  - hard to read the second case without spaces
  - strange to make exclusion for only one line (if add spaces in both cases here, we should add spaces in all cases in the file)

It seems inconsistent.. But at least I'm consistent in this mixed style:) So, I'd keep as if neither of us has strong opinion on this.

> 
>> +    s->poll_state.in_progress = false;
>> +
>> +    aio_wait_kick();
>> +}}
>> +
>> +int {func.name}({ func.gen_list('{decl}') })
>> +{{
>> +    if (qemu_in_coroutine()) {{
>> +        return {name}({ func.gen_list('{name}') });
>> +    }} else {{
>> +        {struct_name} s = {{
>> +            .poll_state.bs = {bs},
>> +            .poll_state.in_progress = true,
>> +
>> +{ func.gen_block('            .{name} = {name},') }
>> +        }};
>> +
>> +        s.poll_state.co = qemu_coroutine_create({name}_entry, &s);
>> +
>> +        return bdrv_poll_co(&s.poll_state);
>> +    }}
>> +}}"""
>> +
>> +
>> +def gen_wrappers_file(input_code: str) -> str:
>> +    res = gen_header()
>> +    for func in func_decl_iter(input_code):
>> +        res += '\n\n\n'
>> +        res += gen_wrapper(func)
>> +
>> +    return prettify(res)  # prettify to wrap long lines
>> +
>> +
>> +if __name__ == '__main__':
>> +    if len(sys.argv) < 3:
>> +        exit(f'Usage: {sys.argv[0]} OUT_FILE.c IN_FILE.[ch]...')
>> +
>> +    with open(sys.argv[1], 'w') as f_out:
>> +        for fname in sys.argv[2:]:
>> +            with open(fname) as f_in:
>> +                f_out.write(gen_wrappers_file(f_in.read()))
>> +                f_out.write('\n')
> 
> Tested-by: Eric Blake <eblake@redhat.com>
> 
> There's enough grammar fixes, and the fact that John is working on python cleanups, to make me wonder if we need a v9, or if I should just stage it where it is with any other cleanups as followups.  But I'm liking the reduced maintenance burden once it is in, and don't want to drag it out to the point that it needs more rebasing as other things land first.
> 


-- 
Best regards,
Vladimir

