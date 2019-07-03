Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57A5C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DE102187F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE102187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiiEk-0002QL-Tm
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 12:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58499)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hihsY-0007GP-Gu
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hihsV-0003KL-Cg
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:13:06 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:48293)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hihsQ-0003HC-Iq; Wed, 03 Jul 2019 12:12:59 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.184]) with ESMTPSA (Nemesis) id
 1N9Mh8-1icbvW2rXo-015Msg; Wed, 03 Jul 2019 18:12:55 +0200
From: Laurent Vivier <laurent@vivier.eu>
Message-Id: <EBA933C4-69B4-43BF-9049-FF1E6A327429@vivier.eu>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Date: Wed, 3 Jul 2019 18:12:51 +0200
In-Reply-To: <5d7fa8ef-c56c-1f90-d5d6-b230d1e3f363@vivier.eu>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190702123713.14396-1-laurent@vivier.eu>
 <CAFEAcA_Zu0X1zLfKtBkQdi25KCkjf_PNu8zKWE5Dx7uzzLEzBA@mail.gmail.com>
 <5d7fa8ef-c56c-1f90-d5d6-b230d1e3f363@vivier.eu>
X-Mailer: Apple Mail (2.3445.9.1)
X-Provags-ID: V03:K1:dPmjrw+1Ja+a3JyiZ15YSPoVd78DBu+ZECVlnaQrPAKSxLS/Bdw
 G4IH/1gBQQG3tIXmvukoCXj9MWJdWTiUlqlNnolp240dq4tAptpyx3XOfvD5az3oLYGpMCY
 izpbY7z8EpjW7NwQ26QXBsIco5jQbvKKW/dIQrHCfxemx9Yoq/Orn1bW+pKtPyYxpQIYZ6N
 w5WqeHja3mCD55cR8M54w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8Mo6p8AFCoA=:mnw6/ltJ3dj2n6K25E88Rg
 /nYWV0G4teL3ZnADEp9Vl3IQEYQ1itxhqPMB7MuXbieHtzoT0dvP/D9z7tp86ruSlHeWEM637
 c2XaqBn80XFSK/VXUgPu3bG21t0/Hd5XBjLUikehjFkSxvhZaEWWnkdFaSIJ94wXSgUeSEXqv
 EUtw2GcACSucYfd60CgOk9Z2PvM7IsGNwxTUQTe6qde+nsCCjD6tbb7mvH4cqZVh/IWl2ava0
 5zt51dxljoLtzmun8XezxfSZSDEtyQEIZlux4PlfQd4zbHn/6CcqVGv6qIb0z/tTeEPeWzgVB
 ukJXHxSyrNBeFAVS/m+5yxqLNRacdfxadaKLXHaIaEsBSysfEvz1pQ9jIOaxed4/fkhZO/pmX
 AMFeI7gDGePUkywnyzIoWMNXWGUgvKnCX3tgZMznCctJL872EWGbbtRtWpAH6kJXvdhhI3NWR
 R2YuIgBzLLOurtNJ7zuvvS4Dsb8iWEfOFXIHB6Y6Yxc5D220D0ZZ8guiwwVf+JsiXk8Ei+86l
 dsuySAT4QyaT5MqbueW0nMT+O5sWo78eLS4ycC/2Vvc1CA3yPsT9vmWsVt0awYehiSdLktKHB
 jIFqqVu0P7WXAQrs8rMeoovTuY9MIYjkTLkbauvrT1ueXrtXxgx9DFKvMuey7DTrPZbNEYDRY
 eKCHQyhkqvKgCzUjNaOfzasaUQCNjMUbW0w8UD3Y1/c5ZT44ix/ss9BmnjAWPRGvCmP+acSr3
 ezhSljGOkOdGW9i3Y5yKiHbR1gIi6Xtqgro8Gix3lejoCyCEJdRTuGEylD4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PULL 0/3] Trivial branch patches
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>, Justin Hibbits <chmeeedalf@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Le 3 juil. 2019 =C3=A0 17:22, Laurent Vivier <laurent@vivier.eu> a =
=C3=A9crit :
>=20
> Le 03/07/2019 =C3=A0 16:45, Peter Maydell a =C3=A9crit :
>> On Tue, 2 Jul 2019 at 13:39, Laurent Vivier <laurent@vivier.eu> =
wrote:
>>>=20
>>> The following changes since commit =
7d0e02405fc02a181319b1ab8681d2f72246b7c6:
>>>=20
>>>  Merge remote-tracking branch =
'remotes/vivier2/tags/trivial-patches-pull-request' into staging =
(2019-07-01 17:40:32 +0100)
>>>=20
>>> are available in the Git repository at:
>>>=20
>>>  git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
>>>=20
>>> for you to fetch changes up to =
7c955080d40ccc7952a0479bc160f2b048c0af53:
>>>=20
>>>  docs/devel/testing: Fix typo in dockerfile path (2019-07-02 =
10:12:32 +0200)
>>>=20
>>> ----------------------------------------------------------------
>>> Fix typo, fix sys_cache_info() on FreeBSD/powerpc,
>>> change virtio-rng default to urandom
>>>=20
>>> ----------------------------------------------------------------
>>=20
>> Hi; this makes 'make check' fail on OSX:
>>=20
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-char -m=3Dquick -k --tap < /dev/null |
>> ./scripts/tap-driver.pl --test-name=3D"test-char"
>> Assertion failed: ((isize & (isize - 1)) =3D=3D 0), function
>> init_cache_info, file
>> /Users/pm215/src/qemu-for-merges/util/cacheinfo.c, line 179.
>>=20
>> I guess this is the sys_cache_info change.
>=20
> OK, I will try to reproduce the problem.
>=20
> I think before this patch (regarding the kind of change we have
> introduced) isize and dsize were always set to 0 and then changed to =
16
> in fallback_cache_info()... or perhaps MacOS X sysctlbyname() needs a =
long.

It seems MacOS X (x86_64) needs a long:

#include <stdio.h>
#include <sys/types.h>
#include <sys/sysctl.h>

int main(void)
{
        long size;
        int ret;
        size_t len =3D sizeof(size);
        ret =3D sysctlbyname("hw.cachelinesize", &size, &len, NULL, 0);
        printf("ret %d size 0x%lx\n", ret, size);
        return 0;
}
$ cc -o cachesize cachesize.c
$ ./cachesize=20
ret 0 size 0x40

#include <stdio.h>
#include <sys/types.h>
#include <sys/sysctl.h>

int main(void)
{
        int size;
        int ret;
        size_t len =3D sizeof(size);
        ret =3D sysctlbyname("hw.cachelinesize", &size, &len, NULL, 0);
        printf("ret %d size 0x%x\n", ret, size);
        return 0;
}
$ cc -o cachesize cachesize.c
$ ./cachesize=20
ret 0 size 0x1737b1d2
$ sysctl hw.cachelinesize
hw.cachelinesize: 64

But man page is not up-to-date:

$ uname -r
17.7.0
$ man sysctl
SYSCTL(8)                 BSD System Manager's Manual                =
SYSCTL(8)
=E2=80=A6
     The string and integer information is summarized below.  For a =
detailed
     description of these variable see sysctl(3).

     The changeable column indicates whether a process with appropriate =
privi-
     lege can change the value.  String and integer values can be set =
using
     sysctl.

     Name                                        Type          =
Changeable
=E2=80=A6
     hw.cachelinesize                            integer       no
=E2=80=A6

In fact, it is in sysctl(3):

SYSCTL(3)                BSD Library Functions Manual                =
SYSCTL(3)
=E2=80=A6
   CTL_HW
     The string and integer information available for the CTL_HW level =
is
     detailed below.  The changeable column shows whether a process with
     appropriate privilege may change the value.

           Name                         Type          Changeable
...
           hw.cachelinesize             int64_t       no

I will try to check on MacOS/X ppc and ppc64.

Thanks,
Laurent

