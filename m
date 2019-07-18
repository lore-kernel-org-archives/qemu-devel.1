Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39841C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 11:10:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1036220880
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 11:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1036220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho4JE-0007DN-A6
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 07:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44844)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1ho4J4-0006oU-DL
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ho4J2-00043a-MW
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:10:38 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:38367)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ho4J2-00042I-DJ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:10:36 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MZAvp-1hsgtb3BUP-00V83G; Thu, 18 Jul 2019 13:10:07 +0200
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190717145418.23883-1-laurent@vivier.eu>
 <CAFEAcA8kMkRuqWt4_tv+ZH5NJ0-kidJ==2A_JdFbPhjYuS+XCQ@mail.gmail.com>
 <a1c7dda7-8a20-c712-686f-5648014ce643@vivier.eu>
 <CAFEAcA86Ev+-m5hYTyUDZMcfzYUcmmaSxhq05k1OACgcZFj40w@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <82d9337d-52dd-5d1f-a9e5-0fb12f0f495c@vivier.eu>
Date: Thu, 18 Jul 2019 13:10:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA86Ev+-m5hYTyUDZMcfzYUcmmaSxhq05k1OACgcZFj40w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ekd5ZF+Lc4Dq221V6Gm+CEL+YWJKed7tV7eWCIWg/aY/6pnZ28e
 +LO0nwfudLOPWG+phjEKmR65BD6A7nLq8H/vi41Jhm+puSC1MjlqHQ/7fRb+Psbj9MBrOlc
 EWaaZfljQpLoHHItPLBbbWQ4QOGH9yyC6tQB5BlFHwtPSyJgwH1hm/S5+d3++3WRiUtHqFZ
 CXifFXWPZZ/t/NSZJQSmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2sDr4lcSb6M=:DGrSMXe9UKcDtt28GOG+KO
 gd6iCy419qQ/HBWWwx5VbXbplxhvuoMsbsNi3OcwTqr8XxauP38omPmFVzbWFM3r/DnUBRzkE
 xakKK+xK5JgxEO8CfR1/CztOUF9brQuTpcr9K2bms6gGSHpg8brOyzV4RPA2qFF4rZXv/w/Ib
 3/n209sinmFiLWUBrwD5c/yq5KkE38Tc112BXIa970wDVqxeYZikTNvJ+MP5kivtHCmIyrLKQ
 ygoXdQO0xHFqWZzrq9xevY+bEkjUKoM6M8u4YvWFhkEB5/m8g4aZDzaERV2LGIRTyroq4J94H
 pCWSN9PuEYZ96wSbML03xnQTrt2TKAjH9Bvyz6On73wZOffdGwc54wcoHcP/42KOb0yMQ0J6T
 etcDg7Ut0KTvkzvtzQ/iQaot/QHONRdQMZrHfuKRiDCG+7N6p4lgS56K/iKD7ppQv5gn2NnNB
 K8p0TVTQC4V/ir737lckBzmZ7NmCiQL2sNCODOLjRa2pyV+nEJP93GgL9cF9NnFAhR6Tj+2ap
 JXUfvyLSm8Y08dluh3zOdLNc2egYYR4BtONhjwnZPr2bDzAMrz5a/H391qH1MT3A7FTEJ/j5Y
 oI2QNg3KtqLCOmvtx2apBid1rKlhtZr8ocSo3xbdCU3icg4VjtS46F0F88LwHnbKW5STXMcih
 bt2bDNDieC0MNKtl0Bdm5hV34gzjftISiHu7nrzshJKVdES/lhdEb5XgnXY/Cbs1fP37Oa876
 igQBA4z1dHI0oQ/gLakMTJXVn1RWuxa3k47TTRoL9O1K0bJa0cbOlSihUUU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: Re: [Qemu-devel] [PULL 0/3] Linux user for 4.1 patches
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 18/07/2019 à 13:00, Peter Maydell a écrit :
> On Thu, 18 Jul 2019 at 11:40, Laurent Vivier <laurent@vivier.eu> wrote:
>> It comes from linux-user/syscall.c:
>>
>>  6328         /* automatic consistency check if same arch */
>>  6329 #if (defined(__i386__) && defined(TARGET_I386) && defined(TARGET_ABI32)) || \
>>  6330     (defined(__x86_64__) && defined(TARGET_X86_64))
>>  6331         if (unlikely(ie->target_cmd != ie->host_cmd)) {
>>  6332             fprintf(stderr, "ERROR: ioctl(%s): target=0x%x host=0x%x\n",
>>  6333                     ie->name, ie->target_cmd, ie->host_cmd);
>>  6334         }
>>  6335 #endif
>>
>> because of:
>>
>> +  { TARGET_SIOCGSTAMP_OLD, SIOCGSTAMP, "IOCGSTAMP_OLD", IOC_R, \
>> +    do_ioctl_SIOCGSTAMP },
>> +  { TARGET_SIOCGSTAMPNS_OLD, SIOCGSTAMPNS, "IOCGSTAMPNS_OLD", IOC_R, \
>> +    do_ioctl_SIOCGSTAMPNS },
>> +  { TARGET_SIOCGSTAMP_NEW, SIOCGSTAMP, "IOCGSTAMP_NEW", IOC_R, \
>> +    do_ioctl_SIOCGSTAMP },
>> +  { TARGET_SIOCGSTAMPNS_NEW, SIOCGSTAMPNS, "IOCGSTAMPNS_NEW", IOC_R, \
>> +    do_ioctl_SIOCGSTAMPNS },
>>
>> As the host_cmd is not used, the simplest way to fix that is
>>
>> +  { TARGET_SIOCGSTAMP_OLD, TARGET_SIOCGSTAMP_OLD, "IOCGSTAMP_OLD", IOC_R, \
>> +    do_ioctl_SIOCGSTAMP },
>> +  { TARGET_SIOCGSTAMPNS_OLD, TARGET_SIOCGSTAMPNS_OLD, "IOCGSTAMPNS_OLD", IOC_R, \
>> +    do_ioctl_SIOCGSTAMPNS },
>> +  { TARGET_SIOCGSTAMP_NEW, TARGET_SIOCGSTAMP_NEW, "IOCGSTAMP_NEW", IOC_R, \
>> +    do_ioctl_SIOCGSTAMP },
>> +  { TARGET_SIOCGSTAMPNS_NEW, TARGET_SIOCGSTAMPNS_NEW, "IOCGSTAMPNS_NEW", IOC_R, \
>> +    do_ioctl_SIOCGSTAMPNS },
>>
>> As SIOCGSTAMP_OLD and SIOCGSTAMP_NEW can be undefined on the host (and not needed
>> because we always use SIOCGSTAMP and SIOCGSTAMPNS)
> 
> So we don't use the host_cmd because we have a custom do_ioctl_foo
> function which doesn't look at that field?

Yes

> Sounds OK, but please include a comment explaining why.

OK

> PS: why didn't you use IOCTL_SPECIAL() rather than hand-written
> array entries? None of the other ioctls.h entries do that.

because IOCTL_SPECIAL() extracts the host command from the parameter and
so we would need the _NEW and _OLD definitions on the host, and they are
not available with kernel before 5.2

> Of course now we're trying to sidestep the consistency check
> we can't use the macro, but it wolud have been fine otherwise.
> It also would get the names of the ioctls in the string form
> right -- they are all missing the initial "S" here.

oh, yes. I fix that too.

> Perhaps for 4.2 it might be worth considering having a
> macro for "IOCTL_SPECIAL but skip the consistency check"
> to be a bit less hacky here.

Perhaps, rather than using TARGET_XXX in host_cmd I can use NULL and
check for NULL in consistency check?

Do you think we should defer the whole patch after 4.1 release?
But then the build of 4.1 will be broken with 5.2+ kernel

Thanks,
Laurent


