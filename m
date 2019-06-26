Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99E0C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 07:58:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7EAB20B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 07:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EAB20B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg2pM-0001Lo-RK
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 03:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39337)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hg2oR-0000wp-2F
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hg2oP-0004A1-2d
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:57:50 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:48919)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hg2oN-00045U-55
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:57:48 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MAORn-1hqC4m1Jet-00Bs5W; Wed, 26 Jun 2019 09:57:23 +0200
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <1560953834-29584-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1560953834-29584-6-git-send-email-aleksandar.markovic@rt-rk.com>
 <a45cb51c-68f0-f52e-17d0-a8926852c74c@vivier.eu>
 <CAL1e-=iVBGniLxy28jbrLjz4uULBGdG6OaaoXHoZQd32B2zqGQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d9358762-604b-7185-27b1-2477c4d8829e@vivier.eu>
Date: Wed, 26 Jun 2019 09:57:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=iVBGniLxy28jbrLjz4uULBGdG6OaaoXHoZQd32B2zqGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8SG2YyyK7WcZohzLqnb11WYLzmPvsdtPlVc4rJS+Tt4iG3kTatg
 ZI1mtc7t9r2xpCCZqA7S4kagSJ+t91533UTZgPIGK72snjRxFemWBqgRGT9P4M4Bmfifr3t
 ixTGbVDwIgOrBDtmLcT3SIuyuA3Px5QFB8jjJ62LV5zhb3BvP/w19IdDJpcYZGmymbmaU3e
 q6oPgZz70OeOSjjKNZraw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CGfBaHsrHxU=:SaEr/WDi1p0bC34LUsohE+
 5Au/wm20Vl1+J8fUBaqGMb3IIJgboWdIJYPnTc+v4gDie0WG7Eou1w8hYpAcU2joouhf/XLtS
 Qzt2Q4JqT5bmHoCwYaBHyAvZjbznYPSZAtV16NDXgnRm9n1Q+xeGqBTnG5uaB1lRB2MM4lj1j
 GgMV4DNI7vScrRHnIpQclnXVteleq52ip27jwwscp85fB+9krWLCTweTsIcpk72d+AAe09Yvm
 LYb9mRrzNtG4RqHsKSoS78GFPK/fEef26EzKVqYw0K6/YQpWDQ0Kj+nUt0lF/lhCO7awozKDW
 vjQ35htoUJ2agLbiFL7BS0iqjzOOgbCHW3JxYeG4AdaVhUygwLTRwUaQY03OxFsNUDWY4an6c
 7dSfIOYheLekaGL8v1snCbDHH0TL8auwYHi99rf1ihp86/TkbQHJuQbEr/92QEjeut6XbE4+X
 oC/cvLaIROMYuVtB6X/zBhuXNvwennPIvXUKQZIZLbaBS2SR0DLiS9hLhxYOW/pT++J5Zo3XX
 0cicDIb9Uvct7YUfkNvHJgFnfR1Jmr7KGDaXeluO5XI+wLukrg3sXN+ZmS7IQ46mAx/SPMfz2
 gTlhJ5sVnruhuEJXMdVaIF2ruTg1nqHec1Eqm6O9G7GGBa2esBGsSXzJ9bX01MUWCL2c0CR39
 qe+eDynQ/N5J/F40q4z4zwMHEcouiepXCpXZfoz5a/c9rkdOrsDl6xFcBhPYr38KXsr2MLxZ8
 G65+tuQqcYfcblcNrJtdRORQy55fwT38gqwzXPGDp5rd0VPJkBXXObGRLV0=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: Re: [Qemu-devel] [PATCH v12 5/5] linux-user: Fix flock structure
 for MIPS O64 ABI
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org,
 amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 26/06/2019 à 09:54, Aleksandar Markovic a écrit :
> 
> On Jun 19, 2019 6:34 PM, "Laurent Vivier" <laurent@vivier.eu
> <mailto:laurent@vivier.eu>> wrote:
>>
>> Le 19/06/2019 à 16:17, Aleksandar Markovic a écrit :
>> > From: Aleksandar Markovic <amarkovic@wavecomp.com
> <mailto:amarkovic@wavecomp.com>>
>> >
>> > Only MIPS O32 and N32 have special (different than other
>> > architectures) definition of structure flock in kernel.
>> >
>> > Bring flock definition for MIPS O64 ABI to the correct state.
>> >
>> > Reported-by: Dragan Mladjenovic <dmladjenovic@wavecomp.com
> <mailto:dmladjenovic@wavecomp.com>>
>> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com
> <mailto:amarkovic@wavecomp.com>>
>> > ---
>> >  linux-user/generic/fcntl.h     | 2 +-
>> >  linux-user/mips/target_fcntl.h | 4 ++++
>> >  2 files changed, 5 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/linux-user/generic/fcntl.h b/linux-user/generic/fcntl.h
>> > index a775a49..1b48dde 100644
>> > --- a/linux-user/generic/fcntl.h
>> > +++ b/linux-user/generic/fcntl.h
>> > @@ -129,7 +129,7 @@ struct target_flock {
>> >      short l_whence;
>> >      abi_long l_start;
>> >      abi_long l_len;
>> > -#if defined(TARGET_MIPS)
>> > +#if defined(TARGET_MIPS) && (TARGET_ABI_BITS == 32)
>> >      abi_long l_sysid;
>> >  #endif
>> >      int l_pid;
>> > diff --git a/linux-user/mips/target_fcntl.h
> b/linux-user/mips/target_fcntl.h
>> > index 000527c..795bba7 100644
>> > --- a/linux-user/mips/target_fcntl.h
>> > +++ b/linux-user/mips/target_fcntl.h
>> > @@ -27,7 +27,11 @@
>> >  #define TARGET_F_SETOWN        24       /*  for sockets. */
>> >  #define TARGET_F_GETOWN        23       /*  for sockets. */
>> > 
>> > +#if (TARGET_ABI_BITS == 32)
>> >  #define TARGET_ARCH_FLOCK_PAD abi_long pad[4];
>> > +#else
>> > +#define TARGET_ARCH_FLOCK_PAD
>> > +#endif
>> >  #define TARGET_ARCH_FLOCK64_PAD
>> > 
>> >  #define TARGET_F_GETLK64       33      /*  using 'struct flock64' */
>> >
>>
>> The patch is correct, but I think it would be cleaner to introduce an
>> "TARGET_HAVE_ARCH_STRUCT_FLOCK" as we have in the kernel for the mips
> case.
>>
>> Thanks,
>> Laurent
>>
> 
> Do you mean we should do everything in a single patch, or do you ask me
> to devise a separate restructuring/cleanup patch here?

As you want, I'm fine with all in a single patch.

Thanks,
Laurent


