Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481C5C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 16:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DDE421872
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 16:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDE421872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernkonzept.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50586 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSOKL-0002O2-CL
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 12:06:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jakub.jermar@kernkonzept.com>) id 1hSOI4-00010L-QF
	for qemu-devel@nongnu.org; Sun, 19 May 2019 12:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jakub.jermar@kernkonzept.com>) id 1hSOI3-0000Bw-Rf
	for qemu-devel@nongnu.org; Sun, 19 May 2019 12:04:00 -0400
Received: from serv1.kernkonzept.com ([2a01:4f8:1c1c:b490::2]:42463
	helo=mx.kernkonzept.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jakub.jermar@kernkonzept.com>)
	id 1hSOI3-0000AF-Lc
	for qemu-devel@nongnu.org; Sun, 19 May 2019 12:03:59 -0400
Received: from 93-153-64-87.customers.tmcz.cz ([93.153.64.87]
	helo=[192.168.0.108]) by mx.kernkonzept.com with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	id 1hSOI0-0001yG-74; Sun, 19 May 2019 18:03:56 +0200
To: Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1558263144-8776-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<bb25cbee-9265-260a-681d-d7d390c007ee@kernkonzept.com>
	<BN6PR2201MB125130243EB8B0ED9AE36848C6050@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<034a6cb7-7fb6-e59c-007b-4f8610db37a8@kernkonzept.com>
	<BN6PR2201MB1251AE5715F377C587459080C6050@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Jakub Jermar <jakub.jermar@kernkonzept.com>
Organization: Kernkonzept
Message-ID: <d97e3bee-85b4-9197-46a1-ab390181bbf3@kernkonzept.com>
Date: Sun, 19 May 2019 18:03:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB1251AE5715F377C587459080C6050@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a01:4f8:1c1c:b490::2
Subject: Re: [Qemu-devel] [PULL 00/10] MIPS queue for May 19th, 2019
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/19 5:16 PM, Aleksandar Markovic wrote:
>> From: Jakub Jermar <jakub.jermar@kernkonzept.com>
>>
>> On 5/19/19 2:00 PM, Aleksandar Markovic wrote:
>>>>>
>>>>>   * A fix for HelenOS boot hang (related to the flag PAGE_EXEC)
>>>>
>>>> This was rather a problem with failing non-executable page tests in
>>>> L4Re, not HelenOS. Even though I tested HelenOS for regressions.
>>>
>>> OK, Jakub, what would be your suggestion for a high-level description
>>> of this message for end users (it is definitely a change that affects end
>>> user)? Something like" Improved PAGE_EXEC flag handling"?
>>
>> It makes sure that referenced pages are not automatically marked
>> executable by QEMU (despite the XI bit).
>>
>> As a user-visible change, this might unbreak some tests that attempt to
>> execute data. Note that this fix does not affect pages that are not
>> referenced prior to being executed - those have worked fine.
>>
>> Otherwise for normal code that does not attempt to execute data, things
>> should not change at all.
>>
> 
> I changed the first item in MIPS section of 4.1 release notes (change log)
> to be:
> 
> * Marking referenced memory pages as executable is improved (it is restricted to necessary cases only).

Sounds good.

> Thanks for your engaging in this issue!

You are welcome.

Thanks to all for reviewing and testing this.

Jakub

> 
> Aleksandar
> 
> 
>> Cheers,
>> Jakub
>>
>>> Thanks,
>>> Aleksandar
>>>
>>
>> --
>> Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael
>> Hohmuth

-- 
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael
Hohmuth

