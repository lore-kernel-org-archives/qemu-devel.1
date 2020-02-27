Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA26C4BA0E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 00:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A397021D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 00:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A397021D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j77Fo-00050b-PD
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 19:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j77Eo-0004Cx-Pp
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 19:41:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j77En-0006fX-JG
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 19:41:14 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:46985)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j77En-0006ee-78; Wed, 26 Feb 2020 19:41:13 -0500
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MwQKp-1jNYIA0ojN-00sLc2; Thu, 27 Feb 2020 01:41:07 +0100
To: Alistair Francis <alistair23@gmail.com>
References: <cover.1582586444.git.alistair.francis@wdc.com>
 <85f33856ee6f32125e5c81a9561346b28b340a3e.1582586444.git.alistair.francis@wdc.com>
 <24431d59-b535-97d4-95d7-fe4401e10787@vivier.eu>
 <CAKmqyKObXNXj2jsMYTvAL-eHS43Wb5upwq6mHeHo7q-4Pr4W7g@mail.gmail.com>
 <fd0e0b49-b2c4-9adf-8cbe-9e160b89f9f2@vivier.eu>
 <CAKmqyKM+nmUwr65i8keu578wLfMappj-9yUJHg+rO44+_YVz6w@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v2 2/2] linux-user/riscv: Update the syscall_nr's to the
 5.5 kernel
Message-ID: <04072aaf-320b-9f23-d3a7-82df223806ba@vivier.eu>
Date: Thu, 27 Feb 2020 01:41:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKmqyKM+nmUwr65i8keu578wLfMappj-9yUJHg+rO44+_YVz6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:s/Br+SGv704cCcxz5tLvkoirAU63PLeRJMVPh42DTmZdSF6K5oc
 Zu3HiH4040FxUqPtTxKx+kdrJ8wPoYY2UtnzGRcDeCKzOJlSksRXgNvKikzR+PlqOq8hyA3
 S/UfwlonIciyKjXRZEoBIN3EW5tY15S78w/XMgoNu03zIj6FaExhUhGew0mdmm61PofRn+x
 FQyuG8FZd/OWH3++5js1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wPMF34/ZgJ0=:o1DdUT0doUFhuXj7I23n+Q
 TuR7F0dWw0hVdJlpq9pdrBZ49yjMZsTpsMMOCi1v91YLAQq/kBG2GnFC8MY1hGEgsS/UlIP03
 K72HUdng7Hpne3wSwOGrrHr1e3UQT7qKVNB7cEXrMRNLDQsp2+UsBsFkY8iucAAGK1raGCPNx
 dH8n4W+0BQJQ3DYdh4WWH0ypf0VGa5lGvldr0fy7znXFVmDbzWYA4/cog6DPSprtV/b8xb9+d
 6wCLc5AcwGiLbUl+XtZwHQIYoKcj9uV7chBrQyxKIosTryU+W3jxFtntBPNQ4n4ZtCcqbW+wl
 lximo5LmV/tjx4pU2kPYWGn47XJZcPACjgDPDG/bhqXowKP6l3SgPdGJGOxMCg9akoa1LbPdz
 YtAbyhSaUUlqTztJ7RLRoiAhb/ygpJuBp8BArOnwnxPf21SEf0EnqSninuwiG7YAKHkyPPuFS
 UhHA1Z3oXx7O9gI3DGloqKyi/2aPli3HTb8gC0e5n5Uw+HEQTR0dqtzjNw6RE1aiOHDR7a1K5
 wHRyjk7sFnIIrzwpbKX6VVC7dZtCyhWANlsLFEsl3xmrS7eMVHFGt0ct4Simgth7p6b95d+0M
 hNCjaT5RR5xc8UB6oV7h4yzQdfOVa3VUrjR0KxpnmSBklUjsHb+RpcVCEtiUNaap9akO77QU8
 Zjz5aaHTc8sexATl+owipLNZvpp743lf/4zlc9sUJVNLul6cETsTccUrj4q/mf+hntSHwxovQ
 cdvgdjYiWdOXMPP6AEu0UFGM9aPBKPHtioocp29Qlsy639QboFW5oV9zXkbRYsnkglnCxsfnM
 0lVkMnCFsf7IlE+5Exu94siBKJpdClt2cn3iTkwMxZKPgFFE2fwVJQ8kt9URnBC7LwyNBTL
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 27/02/2020 à 01:10, Alistair Francis a écrit :
> On Wed, Feb 26, 2020 at 4:02 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Le 26/02/2020 à 20:32, Alistair Francis a écrit :
>>> On Tue, Feb 25, 2020 at 3:50 AM Laurent Vivier <laurent@vivier.eu> wrote:
>>>>
>>>> Le 25/02/2020 à 00:21, Alistair Francis a écrit :
>>>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ...
>>>> I think you can remove following defintion as they should be translated
>>>> by the target glibc.
>>>
>>> glibc won't be exposing these externally, the current plan is just to
>>> use this internally to glibc.
>>
>> But if they are defined internally to glibc, glibc will always translate
>> the older ones to the 64bit ones and thus glibc will never use the older
>> ones with the kernel, only the 64bit ones, thus the older syscalls
>> should never come to QEMU.
> 
> That's part of the problem. QEMU has no TARGET_NR_futex_time64
> support, so we define TARGET_NR_futex to be TARGET_NR_futex_time64.

Ok, I understand the problem.

> Looking a bit more it looks like there will still be issues as the
> syscall.c makes assumptions on time_t and friends being the word
> length (which isn't true for RV32), but this is at least a step in the
> right direction.
> 
> Would it be possible to define the type sizes per architecture like glibc does?

The best to do is to define the TARGET_NR_XXX_time64, it will be
beneficial for all the targets.

We already have functions host_to_target_timespec(),
host_to_target_timespec64() and a target__kernel_timespec with 64bit fields.

Thanks,
Laurent

