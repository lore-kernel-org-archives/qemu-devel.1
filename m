Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9590C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 21:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72FB720707
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 21:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nonterra01.onmicrosoft.com header.i=@nonterra01.onmicrosoft.com header.b="mDB3rHtp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FB720707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nonterra.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkwik-0005Wb-Jx
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 17:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobias.koch@nonterra.com>)
 id 1jkwNY-0006dm-9b
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 17:10:52 -0400
Received: from mail-eopbgr20050.outbound.protection.outlook.com
 ([40.107.2.50]:10567 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobias.koch@nonterra.com>)
 id 1jkwNW-0005NW-3Y
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 17:10:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFXJytWBxsO7OZp4ZLxy1nxL5GOX8j9WPKEulPX/qXvqN8/SLXNlELam7/EEszZ28ldZur/2sqLlrhSHxJZbK2ra05+UpKQv6M+oUpnbQ1OA9XcuNSyxLn5+t0oXJm9DpOuglvO607zG2FCSLpCGnfZ1q8XVu2O1MlOKYGh/2aESfTzk3I0D4aKBZSF/ko7q0f9NNbOcQRq2BhY+lFH4V3+bpOmiD5jg3SI1BD3JTrlUJ5CnmTzwKXkDm7J7DQg+wANnFKGPWWHBCDn9vFBkFVTuS+w7rY2rZ9lBQX5k5tXY/Ho38nM6o4P2d9TstrZjpekidWwlT9pDEKP0KpgI4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pz9kXdUzbEoFDb8Yb+XvF8rn4Ks9VKGkKOPyfK0hVB4=;
 b=NB1243EfI/ZKP7X89nr1/7b/z3shg98uTbLmCOcH8ItkiAvDVcu/e5jAeJy8Co9iIg3Zh1OmnibLCa80YYxtKtaXOZSvDgUm621KHSqPcPY2Oev46FaJ3G04eyPz1ZDBA2UUMJGlSLCY2IBNWgwwkPiMo1MCVWYBr1JRAaDxMYqsFAIaZBvSva9Z7LTJL0HeB5LV3WWEjcWHc34CtYB9OKR2O5w1GpPcAD8ujee8cafDRU4axSFJo+voPX5c0Dw+46r1iUz3rQ6vcDM+ViGMu1DblhBPouQAIrjKIui30Ct0rq7ev+ePZHUZkc8LKg6EL9S5bi2q2b3kNa/PeH8iXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nonterra.com; dmarc=pass action=none header.from=nonterra.com;
 dkim=pass header.d=nonterra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nonterra01.onmicrosoft.com; s=selector2-nonterra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pz9kXdUzbEoFDb8Yb+XvF8rn4Ks9VKGkKOPyfK0hVB4=;
 b=mDB3rHtps38rBGupEoF6dqZxb0LIQqIWa1Ds9IW4/EfOP3LNcL0fqikdEPE40crhreOydpQDXYEYe2cqOweQ0AvuTfbxsAF/n8ZENQVVBESHAIio8Gs3hFZm/0tBmXU1BQgClNKET+F+4opg1zgxoJNicJPkjiF3SGYOvum5hA8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=nonterra.com;
Received: from AM6PR08MB3302.eurprd08.prod.outlook.com (2603:10a6:209:41::10)
 by AM6PR08MB3734.eurprd08.prod.outlook.com (2603:10a6:20b:82::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.23; Mon, 15 Jun
 2020 21:10:46 +0000
Received: from AM6PR08MB3302.eurprd08.prod.outlook.com
 ([fe80::c484:b59d:1164:8055]) by AM6PR08MB3302.eurprd08.prod.outlook.com
 ([fe80::c484:b59d:1164:8055%7]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 21:10:46 +0000
Subject: Re: [PATCH] linux-user: mremap fails with EFAULT if address range
 overlaps with stack guard
From: Tobias Koch <tobias.koch@nonterra.com>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200305210534.28392-1-tobias.koch@nonterra.com>
 <d643f0d0-d5e7-d1f3-d3e2-7d62661774e8@vivier.eu>
 <3c9dffdf-b4be-d17c-730d-5a65665b3eac@nonterra.com>
 <d58a375c-42a0-a1a6-8970-e4aefa5a646b@nonterra.com>
Message-ID: <768e88f1-0f0f-10d8-08e1-0b6137c210d6@nonterra.com>
Date: Tue, 16 Jun 2020 00:10:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <d58a375c-42a0-a1a6-8970-e4aefa5a646b@nonterra.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0018.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::28) To AM6PR08MB3302.eurprd08.prod.outlook.com
 (2603:10a6:209:41::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.181.119] (85.203.15.71) by
 ZR0P278CA0018.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.21 via Frontend Transport; Mon, 15 Jun 2020 21:10:45 +0000
X-Originating-IP: [85.203.15.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8175b76-67d1-42bb-99d5-08d811709240
X-MS-TrafficTypeDiagnostic: AM6PR08MB3734:
X-Microsoft-Antispam-PRVS: <AM6PR08MB37346F430D65999F703B3A6C899C0@AM6PR08MB3734.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UGTAawBepUKfwY1xv1u3H3oBnqzABuyEvfmYk9Da+idUiRqMTyJ44XgeBcmWt5g3t5DLHCYAEnpz+2HiAr/WVhgkolmWlZLO60AFx2/xqdjmg5gthwdKeLkdyxQOqnXJYBSR9XsplS0A7JZq9gtlK8ZV5jq+bRndgGZXSfESg0ojGauWEHNjyIbtWMl2Mcmt3zI/q9NXUw7ly3gnwF1fBLF0dor44VWNH6D4R2fB7tpDxBd/oD26uGrGbTRgxCRJRx5M2K5v56wZd3WWjzTyAKqcdTa3ZGfvEo0DH2CaLD2ASHm7klKcOBzI/+IDwKFVTv6Hd9e3yVPkHXWDyEDUbLMwx+/BZflfegUxRK9issXu9B2nMHdGBheGewe2yCLBTLbLLkUgjO8aD3LZivduV2rfwjNwwHYzLIc8zRrQi8TGNcRm4CBWpfnt6W+fdxqFJHRgg2zZzLNPj34PuW96HA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB3302.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(366004)(136003)(396003)(376002)(346002)(508600001)(36756003)(55236004)(53546011)(52116002)(31686004)(8676002)(16526019)(16576012)(26005)(186003)(956004)(2616005)(316002)(2906002)(8936002)(5660300002)(83380400001)(66556008)(66476007)(6486002)(86362001)(66574014)(31696002)(66946007)(966005)(44832011)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0QwNfTxuZBxNs4s+RSohfz1j0lKPNl/9mJNcDzPDsvDheNJ8zhDzL7NC1mi0DIX1eIv/KE6/aajkYFrT9shCZJXFc9I6yr3Y6h9E5Jmear6ibO9ivjfVwX/r9tyW26+46JwpIEJdDcoqBkHyR++3Vs8bjTJir0E0TjiGk4HMoB9eoBZfuOpj/87zLfCmbXG9Oaih4dzafJPEAO6+pyAL+fE1f5WmRYT0QMMqw/3HfY0iWveh6iebrsFqyW+SjTIg25p3fgN4EvpxOWwn2MDrX7L4Eu4HqSyRoeF/5NILhZsdmEkUWCFcNeNAmnLEL8TMRPslKJtxmulA8Oh3r7MXhMBND6HXR/pOKsd3+wdRBXVKMfplTcGYvrbFy2RTXsV/DYcC8gA3S0VW0x5LofMapoCMBU0BYoQJBRaeHOg9HWUjLSuMj8piMtivGkSfG2Z/SCWKGpGHBabsh63jheHotLEG4Bq6bGr16yM6qrjnV4w=
X-OriginatorOrg: nonterra.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8175b76-67d1-42bb-99d5-08d811709240
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 21:10:46.1561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 76ec9478-ab84-4eac-917c-c1a3242376a3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gaa/u9f2RtIUi0lxdu+jznaIilgShkupYO+fpgcbRkfHWvz9qYZzZU6Xddt66AJAgMCddCjTfmC+S+lGBSRB4sVP9PzNLqZzXF5Mn/ytYpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3734
Received-SPF: pass client-ip=40.107.2.50;
 envelope-from=tobias.koch@nonterra.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 17:10:47
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

Ok, so according to the manpage, mremap generates EFAULT when "the range old_address to old_address+old_size is an
invalid virtual memory address for this process". This is what the kernel does for the stack guard. However, the
mappings in setup_arg_pages() will only ever provoke an ENOMEM, because there is no artifical way to turn a page into an
invalid address. So as long as target bits >= host bits, this works as expected and EFAULT is generated, because then
mremap is basically passed through and the kernel responds directly. But when reserved_va is set, this needs to be
special-cased to fake kernel behavior.

I'm open to other suggestions. I also understand that the code duplication in elfload.c and mmap.c to handle this is
undesirable, but the most viable alternative seems to be introducing more globals.

On 6/15/20 11:28 PM, Tobias Koch wrote:
> Hm, I see I need to have another look at this :)
>
> On 6/15/20 10:17 AM, Tobias Koch wrote:
>> Hi Laurent,
>>
>> the code in musl libc probing the stack is in
>>
>>     https://git.musl-libc.org/cgit/musl/plain/src/thread/pthread_getattr_np.c
>>
>> The setup in elfload.c does work, but only when reserved_va is not set. In that case, any stack guard violation is
>> handled by the host kernel and thus results in the expected EFAULT.
>>
>> However, in case of e.g. a 32bit target being emulated on a 64bit host, reserved_va is set and the current code in
>> mmap.c will only produce a more generic ENOMEM, deviating from the kernel's behavior.
>>
>>
>> On 5/7/20 5:35 PM, Laurent Vivier wrote:
>>> Le 05/03/2020 à 22:05, Tobias Koch a écrit :
>>>> If the address range starting at old_address overlaps with the stack guard it
>>>> is invalid and mremap must fail with EFAULT. The musl c library relies on this
>>>> behavior to detect the stack size, which it does by doing consecutive mremaps
>>>> until it hits the stack guard. Without this patch, software (such as the Ruby
>>>> interpreter) that calls pthread_getattr_np under musl will crash on 32 bit
>>>> targets emulated on a 64 bit host.
>>> Could you share some pointers to the code that is doing this?
>>>
>>> We have already this kind of code in linux-user/elfload.c,
>>> setup_arg_pages(): could you check why it doesn't work?

