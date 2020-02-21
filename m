Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1A8C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:39:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8195420679
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8195420679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j59Sd-0007YE-Mb
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 09:39:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j59Rc-0006dL-Ev
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:38:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j59Rb-0005OY-8L
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:38:20 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:59213)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j59RY-0005Kc-QV; Fri, 21 Feb 2020 09:38:17 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N79hs-1jWQFE3Hmm-017Y5B; Fri, 21 Feb 2020 15:37:41 +0100
Subject: Re: [PATCH v2 00/20] linux-user: generate syscall_nr.sh
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200219220333.1411905-1-laurent@vivier.eu>
 <CAFEAcA8g+uRrGuNLdURegmpjRLtk=vVC9zUE1+QVKRitPjJy7A@mail.gmail.com>
 <CAFEAcA9xfrevtS=KupC1H2oMCG3p2LUqDvKN9KX-cW12OhJbGA@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <90b5e8f8-60dc-f953-491b-46022f078ed1@vivier.eu>
Date: Fri, 21 Feb 2020 15:37:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9xfrevtS=KupC1H2oMCG3p2LUqDvKN9KX-cW12OhJbGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iPM0v2+l70TGhENRsoSOGVa6UwAOKBo806MARg2EikVZxQBaRUP
 4mvy3ypj6AApy1bmyQ4Ffe8f3j9+C4v2x5Ix88NePCbsbaf69AuJOpaij2PoY2C5Vt3BvFr
 9/8ECg+EmhFKMIV2z4SsKtEVPCFR581Cq6Pl1byQM7v9qhaSxiqkw989gbkj0Iaw1FwjtBZ
 ppss+3eh8pLwEhn/qi+UQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VC2HYPIZdWQ=:p5zHD68X8MwgIzZDqxFD5a
 BYR+bLk3f11E2BYBHdsgoccvUfwHuv4/o7ck/ccMlkOeNqzOF8kFbrBADBIJ7ZvCpJNrmVeEU
 YsgBFSfzhe6k8fd5nM5ToQQfpFkFB3tdt1EAwiMGL5wxFrDKIMOaQ60r282DSpuS6UWfSB6xX
 2svDmoHIC5RYjncwi7rlHU6TZFgaXSr0/RLVUjQgIqrnlJ/WmjdvLDjO73ixlG2v3GyAz/INC
 pJgMI+lIDjSn7WBCFVCkOABjfrXj6Z0JzZg5+Y/yEiag/L4z5r3zERISu3S3TtxMT/YlKLUNd
 tWcSVpMUQMNP+xAo/FjVy5r9O+2at7S6lDtFvi6WDk/qm95+VAeUZmnf4eAz27qmhhdZKeJus
 HzUmldO0FsTFqcMh3M1YyLXPV7YJXTouJjXumCpYYsgqbhyFOEaxf2FmPKCk2Cb+ajMAEL7jd
 W3TzBWuqKvjww0fefnaPTlC05ENRtoTddmfBxdns/Ra7+bzDHXf5ysNi4inOEtax1eB76sZ8d
 RKt/OdjIQaczr9KIplIV5fxOkWHte+jNlux0c0UYSHmOddchkjdWCWB6dbURHKM9ngeHVQ6kq
 nY3BpjGN2+2GfOu6UwtkuMGlWfB+dvFWjvy/xfWSzotnsOXS4IRUGy4JUrv3RHBSD6XR4KJVa
 XyXJkrxP4oV4YRFapDa4SglMPE2wJutRle0MvlCl+Xr/qHa7ABe/yNa93agh8yCc4EOiy2qkg
 qLzKLijkz+4K5EUU4DFH8yHuR2itvggrODn2byGlrUz4eQzw6pWlzMG2ObI/E98HajvJglAcW
 59B5LgckWYIQLrA/S4FtS+9L7b+m0LODHnlkzwthammvyY+9iU8Rc142JRkabgm1saR6rzv
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

Le 21/02/2020 à 14:56, Peter Maydell a écrit :
> On Fri, 21 Feb 2020 at 13:45, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Wed, 19 Feb 2020 at 22:07, Laurent Vivier <laurent@vivier.eu> wrote:
>>>
>>> This series copies the files syscall.tbl from linux v5.5 and generates
>>> the file syscall_nr.h from them.
>>>
>>> This is done for all the QEMU targets that have a syscall.tbl
>>> in the linux source tree: mips, mips64, i386, x86_64, sparc, s390x,
>>> ppc, arm, microblaze, sh4, xtensa, m68k, hppa and alpha.
>>>
>>> tilegx and cris are depecrated in linux (tilegx has no maintainer in QEMU)
>>>
>>> aarch64, nios2, openrisc and riscv have no syscall.tbl in linux.
>>
>> Is it the case that all our architectures either:
>>  (1) have a syscall.tbl
>>  (2) are using the asm-generic common numbering system ?
> 
> I think that for asm-generic we should be able to generate
> the syscall_nr.h by suitably defining a __SYSCALL macro
> before #including linux-headers/asm-whatever/unistd.h --
> They basically define syscall numbers like this:
> #define __NR_setxattr 5
> __SYSCALL(__NR_setxattr, sys_setxattr)
> 
> so a C program that just did the autogeneration has the
> info it needs.

Thank you for the hint. I will have a look.

Thanks,
Laurent


