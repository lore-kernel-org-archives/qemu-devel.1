Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08FCC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 20:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942BE20720
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 20:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942BE20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtd04-0000Oi-QX
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 16:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jtczQ-0008Is-3I; Thu, 09 Jul 2020 16:17:52 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:43087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jtcyn-0004fY-Hf; Thu, 09 Jul 2020 16:17:51 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M7sQ6-1jxST23URe-004zic; Thu, 09 Jul 2020 22:17:07 +0200
Subject: Re: [PATCH] hw/register: Document register_init_block @memory_size
To: Alistair Francis <alistair23@gmail.com>
References: <20200707062308.4531-1-f4bug@amsat.org>
 <772cb98e-865c-0c75-ffa2-60773a6df2dd@vivier.eu>
 <CAKmqyKOebG+=vFMXoNKA+4A__hq5srKV6oGa1TOcmiaLYUgTww@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <444a1458-6de4-b963-9d8b-914ae6c50033@vivier.eu>
Date: Thu, 9 Jul 2020 22:17:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOebG+=vFMXoNKA+4A__hq5srKV6oGa1TOcmiaLYUgTww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fT/UlNo+6OpHVodlQ4pTREOAx+/ofGXP9mCiXTbj/gVrWJtJST2
 hBr+VimStLC4yvcYJfDKsWJ/uTBd+pC6JcCxHuZ6PSXCgc+ZP1DyWPMwvWSyxL0sTKgvP2n
 abfM8imInZY15DZtnFalY76yweYZh3NiuWdLG6knv+WcuwDzLOpCF+JXBBCFO/V623o6JlV
 o4vqP6XANZLt1B52cYjKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B0fhZ6hZrxs=:eknn+0nIAOGKUfz3kqrbsO
 9fNL6AtSKTcCk3dKI0I4itjJyxNHikuwdfcMXxwWYelf8fR4Ft5BbOjMWdAjBW/P3tLcalLLJ
 1lnhSxn25/3+B7W71b1aiEgBxmMoM26T3xYdA7lO4yNIySGznsBZl3h9rzDYkQH6WOywQo1U0
 /LHX3IRTj6G30WCSOEFIvuPgiDuGr6lEvNBOdgxU7Jt8FeU8oN7cj/YmVbpqfMI+g77TWLTRP
 tPqksg8mLdjIb4U8xhQZfUzy60+PpPt0ZPfiIOkpHc5efZcg4SWiSFFwVVRoqTx6RcNd1N/dZ
 orqfQ4qLEQkmfYENgwORGgXvGiBvz2qucxTSJdGF3+3OzVujBTJ41AHUYVB0WnwiHqhZof1Mv
 tHC717R3jneYeHYjJhAPH2LhjafCxxwjDrYlvIy3YrM7U30rWpVUSPkhZz+vAbFTkJokcqEPy
 GiA2ptLemDu2fqJCusGStla98Fqn/gjbWmp/yVbzTjfZ+bukUOxbyMoqPzbxmVVqf30N1C1Z4
 +NVYERS/8cixO9A8uDFhMxGYtLf0Xx9eBoIecscSaw1fiilo/vWOeLJE1OVN0HQjvKLiU1bt2
 /O2YUxaBq0u4FHzZsIIc7JqFxNTVHeQCbAvZ2E8/dBBph3by8Z1aDKv2NeproBBMECHf14BXL
 6c7VVm7X6fmunh9lvbIT18tkS3z4EWY5psaZB7LAgAtmVlx1rsAV/YMmo0DFejlyff/Pb7/Cm
 Bp4DpFT++tSJDNsfQA7NwkbPdEoxxZykZ64PzMUjwIQdFxuvMXYIUQ/29nT0KyoyL2TrkoLNK
 vWKApV/t40rNgk2H5B2v7eH0O5CHpe9nX4t/dFD5bHdb6yxs6fZnS0+a/LYKrZJSoaBXYxh
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 16:17:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 09/07/2020 à 19:19, Alistair Francis a écrit :
> On Wed, Jul 8, 2020 at 5:43 AM Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Le 07/07/2020 à 08:23, Philippe Mathieu-Daudé a écrit :
>>> Document the 'memory_size' argument of register_init_block().
>>>
>>> Fixes: a74229597e ("register: Add block initialise helper")
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>  include/hw/register.h | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/include/hw/register.h b/include/hw/register.h
>>> index 5d2c565ae0..fdac5e69b5 100644
>>> --- a/include/hw/register.h
>>> +++ b/include/hw/register.h
>>> @@ -181,6 +181,7 @@ uint64_t register_read_memory(void *opaque, hwaddr addr, unsigned size);
>>>   * @data: Array to use for register data, must already be allocated
>>>   * @ops: Memory region ops to access registers.
>>>   * @debug enabled: turn on/off verbose debug information
>>> + * @memory_size: Size of the memory region
>>>   * returns: A structure containing all of the registers and an initialized
>>>   *          memory region (r_array->mem) the caller should add to a container.
>>>   */
>>>
>>
>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> 
> Can this go via the trivial tree?
> 

Yes, I will try to do a PR before the hard freeze.

Thanks,
Laurent

