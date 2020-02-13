Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57756C352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 00:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BB02206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 00:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB02206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j22O5-0007S9-ET
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 19:29:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j22NR-0006hq-5Z
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 19:29:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j22NP-0003g5-Hc
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 19:29:09 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:54151)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j22NP-0003e4-8Y
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 19:29:07 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MauFB-1je7LB3l7r-00cO2N; Thu, 13 Feb 2020 01:28:23 +0100
Subject: Re: [PATCH 0/9] linux-user: Update syscall numbers to kernel 5.5 level
From: Laurent Vivier <laurent@vivier.eu>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1580818058-16159-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <62529593-1ac2-e294-1750-4e31a59867da@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <eb759931-d726-f1df-e794-2d5cfdd1e96f@vivier.eu>
Date: Thu, 13 Feb 2020 01:28:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <62529593-1ac2-e294-1750-4e31a59867da@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fXA++eTBMHZkWs0itYgX5TanYK8EYVEoeMH4CbOpjBaxjFeVWeD
 L2FLSXmc8ZaVKAVrq+EENwkQsgrbYPvwxA44rQmorY1GTSpKc4LClc5BhzxoVJA1yOPryCI
 rPysdKmJEQKUhjdqnE5YNJTgPbyx04rgsqRmHsbh6vEgDe5i5W07t5TBPTiBhCkYWYGowiC
 /GjZaoyP2S0PhAK2x0e4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vlqPdRCH9cE=:3sbguQNKRcDf1b3+hUoW+k
 eMMGntQjKEg1XYnbG9Xp3/AhPHU65LrzFU0D0+WryVFo66A6laTZSUKubcXHkWO6Csq+FnsfK
 wqfaXzRiAgsilTqeQ/iZvSr4msicCLTWCkdhWNELDwibzt+9zd765i+j3DYR8xtVg1K3SOcTM
 CyjWlXt4vWS4+GDk2VP2e2hehhjMub08w2gtcBZ7cQmJ1UA0WjFv4qH5nzZisw0k/K46ig4rP
 trxq4gvANueF89CjB+TVlPNY+lGA9gZLL40vqpP2r8LatD0qrGmjQNUd5pFN+uTfgkjyfKRSH
 ucCwrGfKMdzVAl5V2SPhDwmmW93huuOeQhwx5k3Eh5It3wylIXgSGHvMEV1MyhhDL/t3FWcL9
 R8S8FBQ49mSaUanzcKzgx1SeitPb2VpzVcslnr6WfKpRHoRNc8BUdVomyhf1FO6rw11+KK2uL
 +xmiv2LWdto8SvW2wa3wCpSOhodHEpDHOtIHxDXzd//PRWGRHbvveMNzsNIcRnYvT4XUfejvv
 WN4/sZEzvAUUqnq348eSSaw86lq6sCtO4bRMIvWVIb2TT1NRkUJ5gJrjj+UU/jAAoFSF0Aguo
 mJcMzwbrgS44rFLAQ1szi9vJcrUq0v9nNG1aOZIGw5qeitOKbY/rR521Mt1XoQUrI+XIKPX2g
 yomJGedmaKHIdvQ+fKn5H8H3uXexz8vvsmtm4FZvqslWxaTeEfj43NYYX8nm9s4CgvBLGyNiJ
 asArSpyuooOwdN6I+xVQpWHC780b/p7anRCN2aUlKpQgQDh1yMq7T+FNiJwbLEQgszHuDPqkn
 vSYtLEY8OfeEfXO8hKnQkhN65BKZ35AMY30lPB0v5MCQHBPXvWH8MVhVl/fP4DAeynN5n04
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, amarkovic@wavecomp.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Stafford Horne <shorne@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 12/02/2020 à 22:34, Laurent Vivier a écrit :
> Le 04/02/2020 à 13:07, Aleksandar Markovic a écrit :
>> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>>
>> Hello, folks!
>>
>> This series is a spin-off of another larger linux-user series
>> that become too large to handle, hence these patches related to
>> syscall numbers are now in this, separate, series.
>>
>> Now that kernel 5.5 is released few days ago, it is time to
>> reflect what can be updated in linux-user for upcomming QEMU 5.0.
>>
>> An obvoius kernel change we should take into account are new
>> system calls, and the foirst step is updating syscall numbers
>> mainteined within QEMU linux-user.
>>
>> Regarding kernel syscal numbers there is good news and bad news.
>>
>> The good news is that kernel developers decided to make future
>> syscall numbers much more synchonized accross architectures than
>> before. They already reached that state.
>>
>> The bad news is that we in QEMU did not reach that state yet, since
>> we lag after kernel significantly.
>>
>> The good news again is that we will reach that state if we update
>> syscall numbers accross the board now. This is the main intention
>> and motivation of this series.
>>
>> The bad news again is that in order to update syscall numebrs we
>> need to be very careful at this moment. There are a number of new
>> syscalls added to the kernel recently that QEMU doesn't know about
>> at all. Significant number of new syscalls deal with 32/64-bit
>> compatibility, traditionally a problematic area in kernel, and in
>> QEMU as well. Moreover, some of the new syscalls are applicable to
>> 32-bit architectures only.
>>
>> This series covers updating syscall numbers defined in the following
>> files:
>>
>>   - linux-user/alpha/syscall_nr.h
>>   - linux-user/arm/syscall_nr.h
>>   - linux-user/m68k/syscall_nr.h
>>   - linux-user/microblaze/syscall_nr.h
>>   - linux-user/mips/cpu_loop.c
>>   - linux-user/mips/syscall_nr.h
>>   - linux-user/mips64/syscall_nr.h
>>   - linux-user/sh4/syscall_nr.h
>>   - linux-user/x86_64/syscall_nr.h
>>   - linux-user/xtensa/syscall_nr.h
>>
>> This series doesn't cover following files (since they use certain
>> proprietary rules for mapping between kernel source and qemu source,
>> I don't feel quite comfortable changing them - therefore I am asking
>> corresponding target maintainers or Lauren to update them, if
>> possible, before our 5.0 release):
>>
>>   - linux-user/aarch64/syscall_nr.h
>>   - linux-user/i386/syscall_nr.h
>>   - linux-user/nios2/syscall_nr.h
>>   - linux-user/ppc/syscall_nr.h
>>   - linux-user/riscv/syscall_nr.h
>>   - linux-user/s390x/syscall_nr.h
>>   - linux-user/sparc/syscall_nr.h
>>   - linux-user/sparc64/syscall_nr.h
>>
>> CC: Peter Maydell <peter.maydell@linaro.org>
>> CC: Paolo Bonzini <pbonzini@redhat.com>
>> CC: Richard Henderson <rth@twiddle.net>
>> CC: Eduardo Habkost <ehabkost@redhat.com>
>> CC: Chris Wulff <crwulff@gmail.com>
>> CC: Marek Vasut <marex@denx.de>
>> CC: David Gibson <david@gibson.dropbear.id.au>
>> CC: Palmer Dabbelt <palmer@dabbelt.com>
>> CC: Alistair Francis <Alistair.Francis@wdc.com>
>> CC: Sagar Karandikar <sagark@eecs.berkeley.edu>
>> CC: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>> CC: David Hildenbrand <david@redhat.com>
>> CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> CC: Artyom Tarasenko <atar4qemu@gmail.com>
>>
>> This series also doesn't cover following files (since I can't find
>> corresponding kernel code - and I am also asking corresponding
>> target maintainers or Lauren to update them, if possible, before
>> our 5.0 release):
>>
>>   - linux-user/cris/cpu_loop.c
>>   - linux-user/hppa/syscall_nr.h
>>   - linux-user/openrisc/syscall_nr.h
>>   - linux-user/tilegx/syscall_nr.h
>>
>> CC: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>> CC: Richard Henderson <rth@twiddle.net>
>> CC: Stafford Horne <shorne@gmail.com>
>>
>> Again, I don't plan (I am really running out of time resources) to
>> work in a significant way on this issue any more, and I am asking
>> you guys other maintainers to help finish updating syscall numbers
>> before QEMU 5.0 release.
>>
>> Once we do that, updating syscall numbers in QEMU should and will
>> be significantly easier.
>>
> 
> I think we should copy the syscall.tbl and syscallhdr.sh scripts from
> the linux tree and update syscallhdr.sh to generate our syscall_nr.h

I made a draft here:

https://github.com/vivier/qemu/commits/linux-user-syscalltbl

Thanks,
Laurent


