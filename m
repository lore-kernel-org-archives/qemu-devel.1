Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B71C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 11:35:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E995A2087F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 11:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E995A2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46240 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcpvU-0000q5-K2
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 07:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53515)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1hcpsX-0007s9-Uu
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:32:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1hcpsU-0003Mn-CP
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:32:48 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:51474 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
 id 1hcpsS-0003I2-Sr
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:32:46 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id A18781A21E6;
 Mon, 17 Jun 2019 13:32:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from [10.10.13.132] (rtrkw870-lin.domain.local [10.10.13.132])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 851A51A1DD1;
 Mon, 17 Jun 2019 13:32:41 +0200 (CEST)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
 <583e3095-2429-cda5-c21d-b6c3ccd3ddd8@linaro.org>
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Message-ID: <87089d7e-8763-8d4b-3b31-b1da7fd2fa5d@rt-rk.com>
Date: Mon, 17 Jun 2019 13:32:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <583e3095-2429-cda5-c21d-b6c3ccd3ddd8@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: Re: [Qemu-devel] [PATCH 0/8] Optimize emulation of ten Altivec
 instructions: lvsl, 
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 6.6.19. 19:13, Richard Henderson wrote:
> On 6/6/19 5:15 AM, Stefan Brankovic wrote:
>> Stefan Brankovic (8):
>>    target/ppc: Optimize emulation of lvsl and lvsr instructions
>>    target/ppc: Optimize emulation of vsl and vsr instructions
>>    target/ppc: Optimize emulation of vpkpx instruction
>>    target/ppc: Optimize emulation of vgbbd instruction
>>    target/ppc: Optimize emulation of vclzd instruction
>>    target/ppc: Optimize emulation of vclzw instruction
>>    target/ppc: Optimize emulation of vclzh and vclzb instructions
>>    target/ppc: Refactor emulation of vmrgew and vmrgow instructions
>>
>>   target/ppc/translate/vmx-impl.inc.c | 705 ++++++++++++++++++++++++++++++++----
>>   1 file changed, 636 insertions(+), 69 deletions(-)
> You should be removing the out-of-line helpers that are no longer used.
>
I agree. I will remove them in v2.

Kind Regards,

Stefan

> r~

