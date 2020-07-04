Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EBBC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:05:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A915208D5
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nonterra01.onmicrosoft.com header.i=@nonterra01.onmicrosoft.com header.b="QFn8MRBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A915208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nonterra.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrjjS-0003bp-LO
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobias.koch@nonterra.com>)
 id 1jrjdl-00037X-T5
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 10:59:42 -0400
Received: from mail-eopbgr00089.outbound.protection.outlook.com
 ([40.107.0.89]:21334 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobias.koch@nonterra.com>)
 id 1jrjdi-0005Pz-UQ
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 10:59:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJhUbKPxh+Cr5xZFfdR0AomHU+hR+K9ljd/R4rNbqRfYRNUGMAvGqI1zU/elBREj1zmFox8NP0ZqeJ/DK2r63saRawLaOvqFpq1fV7nMvL3xy/gs6PdNMVb2I+zeQ/9db7+O4p+p9UQaph3O7eK8sMWET8sKW6pZd4Jrbgu4wWA373ROBTP0pta2McGR4PsyoEGSCbHuJuo9hT1dVpxX1yH1FOo93wVTRjWecdf7whoSw8cjo8bAlkTzeWJXnv2Ph+5ahP1yotVFWrYzhD3aG3tXwhuCuuRb8Y46U87JHU6m2o+9xWj7XfdM1erqf6yqPiNeTiXNOBlsPpkPHtmGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1En32mGFdrOOJVXvIo765TszM7LnsqOtGvMId6Id7Ps=;
 b=acv76HXcgmaE1EpEd2laq/DOSVov1jPNGdGPim1DbtpL9PC59D9OGznbPudLLs/dP0jkQxqLSrncU7I7GtYSPXfcnfkoLPxaOaIENI9nf+f6G/Td7bk2wh5V/1Y3iS45+R57bPHfLC4pa2kTQwiTmgvjxOXwTiOsXLH5DD2VAMOT69rzJxhngO5UZmFnX83p7j31aJ7IL7Smyy/pm8DkTW28cQwAr9B71jbKmSD3ufbKbMgobSuWg9K6+ClS4zt4tq4vJ3+LbrGvccMQ1FwE88s5o8f2aKhhZEZ/giY2zExTEoKekgKZEPZFAUBV5ixrkaLYgA5uOnw+QHkRcpyoDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nonterra.com; dmarc=pass action=none header.from=nonterra.com;
 dkim=pass header.d=nonterra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nonterra01.onmicrosoft.com; s=selector2-nonterra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1En32mGFdrOOJVXvIo765TszM7LnsqOtGvMId6Id7Ps=;
 b=QFn8MRBIXL4eBURxO6JhSTEMTHcHFc3VcQUFW6Pc2DJepVXaFuuRe5i3oX81jv8mu09xQWqhuTr5t1DpQV/IksKxmh4BxFXe7pGVEIT6g09BjhjGzhnckyNZQjFgvrINlEEV9ZGYDA1D1a5+dG4hzgMyYv6d8A9I3SprGZYZelE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=nonterra.com;
Received: from AM6PR08MB3302.eurprd08.prod.outlook.com (2603:10a6:209:41::10)
 by AM6PR08MB4134.eurprd08.prod.outlook.com (2603:10a6:20b:a8::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Sat, 4 Jul
 2020 14:44:33 +0000
Received: from AM6PR08MB3302.eurprd08.prod.outlook.com
 ([fe80::c484:b59d:1164:8055]) by AM6PR08MB3302.eurprd08.prod.outlook.com
 ([fe80::c484:b59d:1164:8055%7]) with mapi id 15.20.3153.029; Sat, 4 Jul 2020
 14:44:33 +0000
Subject: Re: [PATCH] linux-user: mremap fails with EFAULT if address range
 overlaps with stack guard
From: Tobias Koch <tobias.koch@nonterra.com>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200305210534.28392-1-tobias.koch@nonterra.com>
 <d643f0d0-d5e7-d1f3-d3e2-7d62661774e8@vivier.eu>
 <3c9dffdf-b4be-d17c-730d-5a65665b3eac@nonterra.com>
 <d58a375c-42a0-a1a6-8970-e4aefa5a646b@nonterra.com>
 <768e88f1-0f0f-10d8-08e1-0b6137c210d6@nonterra.com>
Message-ID: <17e4b800-5555-d12c-4cd5-95965c5fff8b@nonterra.com>
Date: Sat, 4 Jul 2020 17:44:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <768e88f1-0f0f-10d8-08e1-0b6137c210d6@nonterra.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR10CA0111.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::40) To AM6PR08MB3302.eurprd08.prod.outlook.com
 (2603:10a6:209:41::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.20.10.11] (176.54.248.208) by
 VI1PR10CA0111.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:28::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.23 via Frontend Transport; Sat, 4 Jul 2020 14:44:32 +0000
X-Originating-IP: [176.54.248.208]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f82d97d9-17f8-4b79-87c0-08d82028c3da
X-MS-TrafficTypeDiagnostic: AM6PR08MB4134:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4134F68B46D62F9057E7DE4C896B0@AM6PR08MB4134.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0454444834
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jtEzR2m7KaTZQdrF4od4mYj19PdUYpTXhShxWKz7/C/pZvKcMRo2ifkh25WlgPhxXRpjDa7cZRTTXLgpZQWtATpOmefWzboIx7oOtOTRo0tUCTyAW4jZ0HPUPQLUMpYovgGPmAoukD/7k9Wm4IY+mr1Ye/mYZgcx31RPWBdPYySbCd6k+RoibQ6E8GFTjbPrn8ccjSGd1OZ9p4cTBMfZick0wUCTC+mWM59sKGW/cONOf1gRaoYNdd63k8aR66rOWyNx4dIVKZIGZIc2r2qlxs7blp/hsYSiTiz5nOLOi58EZnbrX9CeY0IPTHbPRFRPqekWLEb907Buz28DHK77mfeXGiau9H737QNIHbodLIRZZNVehUg5jsCckZDJ6aO+TttRbp5sx/DXVTxgCoqqfWyT315m+kKck6lsudjs1qluN0t67QnQZxlRABCRQbkPhXvMl5WxeVBSh5fjnt7jQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB3302.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(376002)(346002)(366004)(39830400003)(136003)(508600001)(2616005)(31696002)(316002)(31686004)(956004)(66574015)(52116002)(966005)(6486002)(8676002)(16526019)(66556008)(66476007)(66946007)(8936002)(36756003)(83380400001)(6666004)(186003)(26005)(5660300002)(16576012)(86362001)(44832011)(53546011)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ClBWX3aTrYXuOZ3dFUTXlBu1MfnJ7Yea0W0kV59eqc6C4TY5zvYbhK/mkMwgOoqw9h2Hf9hbjQcODmVrE0c0g3qBLMVFd2J5Aa7EU8nHDbzWIk/c8JxQRGriOj1vaT/2SLAIsRqfcjKg21ITDqnmyQr7ihecMq8mV6Mto4KO6O64P2yoOxNb/qR+LdLjfbkIiffQz7ldzgK/LeS4m++BIOKVZl1SjPWZcRAaqhMXbn9VeK+WboGMOa7hltQnvPIePIVy3NBXF7UaFoe28c3DVoEaX9ARNtXrW8haDLNaTnu24tKqfO47tgWgRXyu40a/2vnNxLf8yHBaNI+u07bAkbut1eYnGiLiYHY2WvQ4Akl78BN9EnHG+TvB8JQtiq/N6+hK0f49GCuL3zZGUkCDV0WLx0R2QxXfjDFEYxNbn/u+XSVL6OuRCfTbGzEhJUVjCDx4XmkVG6AT+10S2qgt7Bo9n6KQgYC3n39upaw0yuQ=
X-OriginatorOrg: nonterra.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f82d97d9-17f8-4b79-87c0-08d82028c3da
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB3302.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2020 14:44:33.2822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 76ec9478-ab84-4eac-917c-c1a3242376a3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjDpfnQl0183wn6AWcfrwgKAe/iKCnNFeUW1NZDANlmI9EhRWomdSCZXRJ8RD5bPHMMP9OMxL9U5qnzlnFmzXgdcUAfdVf+/RlQSFlokcVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4134
Received-SPF: pass client-ip=40.107.0.89;
 envelope-from=tobias.koch@nonterra.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 10:59:37
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping

On 6/16/20 12:10 AM, Tobias Koch wrote:
> Ok, so according to the manpage, mremap generates EFAULT when "the range old_address to old_address+old_size is an
> invalid virtual memory address for this process". This is what the kernel does for the stack guard. However, the
> mappings in setup_arg_pages() will only ever provoke an ENOMEM, because there is no artifical way to turn a page into an
> invalid address. So as long as target bits >= host bits, this works as expected and EFAULT is generated, because then
> mremap is basically passed through and the kernel responds directly. But when reserved_va is set, this needs to be
> special-cased to fake kernel behavior.
> 
> I'm open to other suggestions. I also understand that the code duplication in elfload.c and mmap.c to handle this is
> undesirable, but the most viable alternative seems to be introducing more globals.
> 
> On 6/15/20 11:28 PM, Tobias Koch wrote:
>> Hm, I see I need to have another look at this :)
>>
>> On 6/15/20 10:17 AM, Tobias Koch wrote:
>>> Hi Laurent,
>>>
>>> the code in musl libc probing the stack is in
>>>
>>>     https://git.musl-libc.org/cgit/musl/plain/src/thread/pthread_getattr_np.c
>>>
>>> The setup in elfload.c does work, but only when reserved_va is not set. In that case, any stack guard violation is
>>> handled by the host kernel and thus results in the expected EFAULT.
>>>
>>> However, in case of e.g. a 32bit target being emulated on a 64bit host, reserved_va is set and the current code in
>>> mmap.c will only produce a more generic ENOMEM, deviating from the kernel's behavior.
>>>
>>>
>>> On 5/7/20 5:35 PM, Laurent Vivier wrote:
>>>> Le 05/03/2020 à 22:05, Tobias Koch a écrit :
>>>>> If the address range starting at old_address overlaps with the stack guard it
>>>>> is invalid and mremap must fail with EFAULT. The musl c library relies on this
>>>>> behavior to detect the stack size, which it does by doing consecutive mremaps
>>>>> until it hits the stack guard. Without this patch, software (such as the Ruby
>>>>> interpreter) that calls pthread_getattr_np under musl will crash on 32 bit
>>>>> targets emulated on a 64 bit host.
>>>> Could you share some pointers to the code that is doing this?
>>>>
>>>> We have already this kind of code in linux-user/elfload.c,
>>>> setup_arg_pages(): could you check why it doesn't work?
> 

