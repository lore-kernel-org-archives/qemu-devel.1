Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAABC35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:31:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B23B024650
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23B024650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j59Kn-0003z3-OD
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 09:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j59K8-0003W8-5V
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:30:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j59K6-0000e5-UW
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:30:36 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:50089)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j59K4-0000Zr-9X; Fri, 21 Feb 2020 09:30:32 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MGzI3-1jHVWA2ZVr-00E7qq; Fri, 21 Feb 2020 15:29:50 +0100
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200219220333.1411905-1-laurent@vivier.eu>
 <CAFEAcA8g+uRrGuNLdURegmpjRLtk=vVC9zUE1+QVKRitPjJy7A@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v2 00/20] linux-user: generate syscall_nr.sh
Message-ID: <6050c10c-5911-ac76-f79e-5966e5e1faf6@vivier.eu>
Date: Fri, 21 Feb 2020 15:29:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8g+uRrGuNLdURegmpjRLtk=vVC9zUE1+QVKRitPjJy7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:t6dy6vbREfQ92u1nf4ffM9RoxAkl5pdqtfzOsmj2f8h9fND7aUQ
 S0KrDuAHOPlq6AeUr1JYZWkFDCsJfIK/CyBfPvwYp4yt7+Q5FmL4eOVBT+Lv1HexNAPSHKI
 zGUDCNbe6nTNGxnhPp9D082OeTq4LYU/RY2GOKmTC0hvWMJ39qmxzyIiqWW02Gok8bhEedl
 Ay7YbgxehYc1r7K+GJJ9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7O0qZyIxQkM=:2SL4r5ITNj0Yv5rSzYj0UB
 ELbIaOkjUYNsfGFvf9axTpJyRhMtDCd70Z79a3WUt+uBciy4lJ6hpDuky2ZePDrdwMHErYN9T
 7svJKpuO2Xv/VLVvakxINuRzJDKOO/5flVZYHLh+SqxZlbj63vO3qnq6RAvss7kmO3c9RQL3k
 +Nqn44pIPDlSmGe+bSN1Fsns4uTZe0QhI6yVH1dtrqjEy0hcZtz3ie5zz0pkMMGLjN4A9u5e+
 rJMXsk8qVM2ZWQKeL3upAeFROmd8/nBqCAw/SJf8u2LsnEtP44vKkrhCZFT7Fjq0pt6GXGUuO
 TaniWv8SUj1PyYyoyH70pm8uIHdbfpd6S4sdZVNQWTyadf8gXaxEGKjlXl6jSO00zsBpMUU/v
 tsAbdLQrHoew74uSjjyUmLxO5CaMksZQqUU4N5XIZTKw6zi7GC3WLGNSCTcsZGUX5lybSiBfL
 2zIOTqDycZKUG6GTWdia2toOUe5/gJfbjynmp1VKHoypqtBXh/2DVXIOxHMYEm2tS8y9wwK5J
 j7MyYvbXQpHbm1UGuhUNOjNN6OtNiGdj+4Mw0GnUSjf7J46PhL6xG/iRfDCbwuUh4qjx7k1ri
 JR9dQX5RD9xi/EIjvZ5Iazs49Rb4QfPGSboEjQ0UX1FKVHbW72XDUiy0hd0r+bP54yLp4vP7t
 oEkiKYvdZKAx33gfvSLTc/S08Nh+qzD/IxH3e9xB/QDxGMK+GaPVGQRAxjcs1Mdv+bn9vlAMK
 /EY+D0fkvHagzwgSChjW/N1VXh2slXpwFFMZKF45PSSaNwmV29IIF5PcGd+AII82YBmkFFd3e
 b27ODydVFZJRx5q7DDZxAT+sFito2Z9aSh7DiybsMdi4govy23o/ToFV75PKThNKfuo7myb
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 21/02/2020 à 14:45, Peter Maydell a écrit :
> On Wed, 19 Feb 2020 at 22:07, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> This series copies the files syscall.tbl from linux v5.5 and generates
>> the file syscall_nr.h from them.
>>
>> This is done for all the QEMU targets that have a syscall.tbl
>> in the linux source tree: mips, mips64, i386, x86_64, sparc, s390x,
>> ppc, arm, microblaze, sh4, xtensa, m68k, hppa and alpha.
>>
>> tilegx and cris are depecrated in linux (tilegx has no maintainer in QEMU)
>>
>> aarch64, nios2, openrisc and riscv have no syscall.tbl in linux.
> 
> Is it the case that all our architectures either:
>  (1) have a syscall.tbl
>  (2) are using the asm-generic common numbering system ?

Yes, for what I see archs that have not been converted to syscall.tbl
are the ones using asm-generic common numbering system.

> 
> Though even if they do use asm-generic there's awkwardness
> still around whether they have extra arch-specific syscalls
> and what features of the asm-generic/unistd.h they select,
> so I'm not sure whether it helps us much to know that they're
> sharing a basically common numbering system.
> 
> It does suggest that future architectures are unlikely to have
> a syscall.tbl unless somebody pushes for one to be generated
> for asm-generic users.

I agree.

> 
>> It seems there is a bug in QEMU that forces to disable manually arch_prctl
>> with i386 target: do_arch_prctl() is only defined with TARGET_ABI32 but
>> TARGET_ABI32 is never defined with TARGET_I386 (nor TARGET_X86_64).
> 
> TARGET_ABI32 for x86 would mean the x32 "32-bit APIs
> on a 64-bit CPU", which we don't implement. But the
> guards on do_arch_prctl() are
> #if defined(TARGET_I386) && !defined(TARGET_ABI32)
> 
> where the !TARGET_ABI32 check seems like it's unnecessary but
> harmless (we never define it for x86), so what causes a problem?

Yes, my conclusion was too quick.

The error is:

  CC      i386-linux-user/linux-user/syscall.o
linux-user/syscall.c: In function 'do_syscall1':
linux-user/syscall.c:10208:2: error: #error unreachable
10208 | #error unreachable
      |  ^~~~~

So something defines TARGET_ABI32:

include/exec/user/abitypes.h

 42 #ifdef TARGET_ABI32
...
 54 #else
...
 60 /* for consistency, define ABI32 too */
 61 #if TARGET_ABI_BITS == 32
 62 #define TARGET_ABI32 1
 63 #endif
...
 70 #endif

TARGET_ABI32 is always defined if TARGET_ABI_BITS is 32 (and i386 is 32bit)

An the problem is more complex.

do_arch_prctl() uses TARGET_ARCH_SET_GS, TARGET_ARCH_SET_FS,
TARGET_ARCH_GET_GS and TARGET_ARCH_GET_FS that are defined in
linux-user/x86_64/target_syscall.h and not in i386.

Thanks,
Laurent

