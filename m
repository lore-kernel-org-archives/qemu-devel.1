Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826D1C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:38:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591C020833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591C020833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58016 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRGaz-0000wz-J2
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 09:38:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hRGZD-0008Gh-0X
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hRGZ9-0004EC-VV
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:37:02 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:59013)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hRGZ9-00049Q-Na
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:36:59 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1N17cq-1ghez41H6w-012W0x; Thu, 16 May 2019 15:36:56 +0200
To: Peter Maydell <peter.maydell@linaro.org>
References: <20181210165636.28366-1-peter.maydell@linaro.org>
	<98f62d5c-0c2a-9651-0dd6-961a243c4519@vivier.eu>
	<CAFEAcA_AqVBcjSsJkkruO-rGnvJSiOq9w2RW7VXVCXJu5kXW=A@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <2e054351-8210-4a43-dcb9-066a743631d9@vivier.eu>
Date: Thu, 16 May 2019 15:36:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_AqVBcjSsJkkruO-rGnvJSiOq9w2RW7VXVCXJu5kXW=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:yrJ41vfu+IW3yAarRd2BCvirsDAiFcARhC2erGCyYk+Xi69bRvu
	XBk6TRz2KCgNdmib2+Lcsj/8FzDAdQf2qFNpzWo4LdwGvDl8gs6kraI6mnC3jC/XQBtZFNn
	+7Gqc4eThIO9H/W0oQI7D83BRSCRR3i1BAcLNBC+fgTCfawlw5Z3dznNVqNEkQIN0wYOmHt
	90Flv5tx9lStmx2TCR6tg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ODJ5316Tk9k=:dOjVGqt1VIA71ggbuHr0Vn
	kABkTI13qmp6OyKrDf8AJ19+w1U+BwR4/BeyTzaHZnelpl+2FKphGfkv4FGqcMWK8oKKRaYiN
	nw6Mt/tyUEKWyIukWGrnyP4emnVKjTmoLt4Ht+wvMO2RTlYWqvl8MPYnbqtH/AxgVCAFhLwNu
	ka+vyacSXcj2ZqEAUzA3My9pSrrZ2MyWngX1CZH0yETNa1Werzg8WNu2DEHocGM+adgWNE1RX
	M7e8qmAHkmYJtCHuFmThVOoZyQHKWt9glZI79ZUc/RmaLDn1N8bM1yzk40Ga9TXxkHszgPC9b
	rABpHoFHXjzdnp91TIPe6Mjq2qthXMFoNyXZE+GKCMM4QzfubVru8YN7nBcHs0Iretqoi+eml
	Y+TmAqPlmu8eyFB+5h/orakr4ToWCPZ6UmVshKVNFk0Nh7ztmSrd2BKduV8/R9hkdfJ6VfIyF
	+qMleATk524TxiF3LHVooO3S5Mi7FTY7rSiVN54Jo1N/NimwcFuOhIZF430AEZbwXZ1yoeS/v
	qNdL4T7k1FVez8qh7HE62DIZUno5V2wbGgJIpMmEnshdWZhQJdbbz7EgGcZOo0QuCD/IqjaA7
	wVh1T2w9QRHHUg8U7oAPhVCDrOJ80aQGJv/9FVYV4U9Al7YJvRX8Th4qor3aMmhL9fe8fr7bE
	msAJ1XvmtHdOH/kxxOVaHqdPInYGiR+q5OLpw0zAy6BHiK3WBJ/EyKkwYhco3bzuNNi3796nm
	uS48C0PoKbPuaRlEyq/AWQOIVLB49R1FKR5cc7f84lotbnNCJmLNeo+G/d0=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: Re: [Qemu-devel] [RFC 0/3] target/m68k: convert to
 transaction_failed hook
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	QEMU Developers <qemu-devel@nongnu.org>,
	"patches@linaro.org" <patches@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/05/2019 15:26, Peter Maydell wrote:
> On Fri, 3 May 2019 at 18:12, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> On 10/12/2018 17:56, Peter Maydell wrote:
>>> This patchset converts the m68k target from the deprecated
>>> unassigned_access hook to the new transaction_failed hook.
>>> It's RFC for a couple of reasons:
>>>    * it's untested, since I don't have an m68k test image
>>>    * the second patch just makes "bus error while trying to
>>>      read page tables" be treated as a page fault, when it
>>>      should probably cause a fault reporting it as a bus error
>>>      of some kind
>>>    * I don't understand why the old unassigned_access hook
>>>      set the ATC bit in the MMU SSW, since the docs I have say
>>>      this should be set if the fault happened during a table
>>>      search, but cleared if it's just an ordinary bus-errored
>>>      data or insn access. Probably this is a pre-existing bug?
>>
>> I think you're right. It must be cleared on bus error.
> 
> Thanks for the review of this patchset. Is there anything
> you want me to do for a v2, or is it ready to be applied ?

It looks good to me. I'm going to add it to my m68k branch and send a PR.

Thanks,
Laurent

