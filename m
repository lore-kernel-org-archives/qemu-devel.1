Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE029C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 05:55:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82B2B20663
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 05:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B2B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqsBz-000413-Rg
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 01:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1jqsBM-0003Q5-5G
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 01:54:48 -0400
Received: from mail.ispras.ru ([83.149.199.84]:58492)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1jqsBJ-0006WY-Uf
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 01:54:47 -0400
Received: from [192.168.0.183] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id A4E4A40A9287;
 Thu,  2 Jul 2020 05:54:40 +0000 (UTC)
Subject: Re: [PATCH] scripts/get_maintainer: Use .ignoredmailmap to ignore
 invalid emails
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200629172716.20781-1-f4bug@amsat.org>
 <8616bdd8-34a9-f737-aa9d-f11d735cc0fe@redhat.com>
 <caee1217-867e-f2b3-68c6-3b3e87e926a9@amsat.org>
 <70e3b721-4515-352a-1f9a-0638ee19b784@redhat.com>
 <94527813-1a04-16d7-4449-f583b356a76e@amsat.org>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Message-ID: <986bbb22-85e4-d4b1-abd2-4358632745e8@ispras.ru>
Date: Thu, 2 Jul 2020 08:54:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <94527813-1a04-16d7-4449-f583b356a76e@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 01:54:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>,
 Alexander Graf <graf@amazon.com>, Paul Burton <paulburton@kernel.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01.07.2020 19:54, Philippe Mathieu-Daudé wrote:
> +Pavel/Paul/Alexander
> 
> On 7/1/20 5:12 PM, Paolo Bonzini wrote:
>> On 01/07/20 17:07, Philippe Mathieu-Daudé wrote:
>>> $ cat .ignoredmailmap
>>> #
>>> # From man git-shortlog the forms are:
>>> #
>>> #  Proper Name <commit@email.xx>
>>> #  <proper@email.xx>
>>> #
>>> Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>>> Caio Carrara <ccarrara@redhat.com>
>>> Yongbok Kim <yongbok.kim@mips.com>
>>> James Hogan <james.hogan@mips.com>
>>> Paul Burton <pburton@wavecomp.com>
>>> Alexander Graf <agraf@suse.de>
>>> Roy Franz <roy.franz@linaro.org>
>>> Dmitry Solodkiy <d.solodkiy@samsung.com>
>>> Evgeny Voevodin <e.voevodin@samsung.com>
>>> Serge Hallyn <serge.hallyn@ubuntu.com>
>>> Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>>>
>>
>> For at least Paul Burton, Pavel Dovgalyuk and Alex Graf we should just
>> use .mailmap, anyway I think the concept of the patch is okay.
> 
> Pavel has been using a GMail account, but seems to be back to
> ispras.ru, so it might have be a temporary failure (over few
> days although).

Right, my primary e-mail for QEMU-related work was pavel.dovgaluk@ispras.ru.
However, I recently added alias with better transliteration 
(Pavel.Dovgalyuk@ispras.ru), and now I will use it for the patches.

> 
> I can send a pair of patches for Paul and Alexander if they
> are OK. The others seem MIA.
> 
>>
>> Paolo
>>
>>


