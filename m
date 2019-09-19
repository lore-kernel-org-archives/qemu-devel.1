Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E354C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:24:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2894B208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cVuHkQoR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2894B208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAxLn-0002jI-6D
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 10:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iAwyi-0001ek-4H
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:00:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAwyf-000761-Ha
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:00:11 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51665)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAwyf-00074C-60
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:00:09 -0400
Received: by mail-wm1-x343.google.com with SMTP id 7so4702305wme.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 07:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Ejei11cjnbALdqyMM9e22yTDGtCercYxdkCtkHYeYqU=;
 b=cVuHkQoR8EO2i0nyRyg/xwuQT6Q2GqFwV+0wu8wRyZ6xepIHCBru/aWKC5MRGYBz+2
 oN9vLfiJTeJP9N7J96tz7vtLQU3fLRu98aUbIZCWqT3GtUGyYmtY3YftQJTFSw8wO1oX
 IMC/Axl3HmmWZS+VFjjabUEBIsIQcnqX3iaZl0w3njFM0CxQYX22wFvp6WZPvXB0VrUa
 qS4O309vWYSt4XA9rLdJvVRbI14Sfy3UhuFYx552wUhasw0KqfYp4xO+vE/EVXNr7Rg/
 0XLJWRJYebEWmb43gdz26uveTFZYVh+xhE7PrPGicXBGua5gIdAxxBX94ltkB82ZwvTY
 LWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Ejei11cjnbALdqyMM9e22yTDGtCercYxdkCtkHYeYqU=;
 b=ckp1GZ3fmAs/Rt/2w3/j+7APqcO6AxPkCW9ct46+me1P4qUNhXo5TiZMschxF2YZGO
 4K1g7Zy6RxWyOBYZvIzPL8ZrdooksC14qdRoDnYIkgvHb0skPuZiUiBC60zy6rqVqKz2
 68pNHRvQDcWZu6YmJBG6ZcGABuXRV0Ji0C+Ab4Duxe5eOsKriDutVTbckU73uGH8TM20
 K0ORcnQkaYYnyY1PEfJwHooClvW4B0gEaqvWHelD2d7yjIA4eosMt2m49maryTkXkAvO
 8Ymjr2analcB7t1z78YrCQ6pW8UN6S/sltgnFJ4cVapGKKXN8bIFIkxB+kYDYhiBE7fo
 YM4g==
X-Gm-Message-State: APjAAAUXxWA3zv5XoyUH3ZhEr1ra6Im2wWKXudmzzHZZKMzAEHEqXeMA
 fFALY+SBaJ39aZnOKf6LTWWfYa5l5zo=
X-Google-Smtp-Source: APXvYqw32RvKe0iA2qnE8J4sQQYLP/o932n6fBLAPF2p8ipwVW+IIeYjg5eFVz/+anq+SDuFAQI2GQ==
X-Received: by 2002:a1c:d185:: with SMTP id i127mr3033327wmg.28.1568901604570; 
 Thu, 19 Sep 2019 07:00:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r65sm6299660wmr.9.2019.09.19.07.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 07:00:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0C25D1FF87;
 Thu, 19 Sep 2019 15:00:03 +0100 (BST)
References: <20190913154952.27724-1-peter.maydell@linaro.org>
 <20190913154952.27724-13-peter.maydell@linaro.org>
 <9ede7068-7f92-3e1a-c1f8-c0994eddf671@redhat.com>
 <CAFEAcA8nj27YwR3F0NA8JiV2yqqLcBzZ6T42Ue5FV2cUcmRoaQ@mail.gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <CAFEAcA8nj27YwR3F0NA8JiV2yqqLcBzZ6T42Ue5FV2cUcmRoaQ@mail.gmail.com>
Date: Thu, 19 Sep 2019 15:00:03 +0100
Message-ID: <87o8zgz8rg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PULL 12/12] qemu-ga: Convert invocation
 documentation to rST
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 19 Sep 2019 at 02:25, Eric Blake <eblake@redhat.com> wrote:
>>
>> On 9/13/19 10:49 AM, Peter Maydell wrote:
>> > The qemu-ga documentation is currently in qemu-ga.texi in
>> > Texinfo format, which we present to the user as:
>> >  * a qemu-ga manpage
>> >  * a section of the main qemu-doc HTML documentation
>> >
>> > Convert the documentation to rST format, and present it to
>> > the user as:
>> >  * a qemu-ga manpage
>> >  * part of the interop/ Sphinx manual
>> >
>> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> > Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>> > Tested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>> > Message-id: 20190905131040.8350-1-peter.maydell@linaro.org
>> > ---
>>
>> In an incremental build on Fedora 30, I'm now seeing:
>>
>>         CHK version_gen.h
>>   GEN     docs/interop/qemu-ga.8
>> No filename or title
>> make: *** [/home/eblake/qemu/rules.mak:394: docs/interop/qemu-ga.8]
>> Error 255
>>
>> and suspect this patch introduced it.  It may be that I just need to
>> nuke intermediate artifacts rather than an actual problem with the
>> patch, but I'd welcome help in identifying the problem.
>
> If you build with V=3D1 what does it say it's doing?

This is what shippable shows:

make -I/root/src/github.com/stsquad/qemu/dtc VPATH=3D/root/src/github.com/s=
tsquad/qemu/dtc -C dtc V=3D"1" LIBFDT_srcdir=3D/root/src/github.com/stsquad=
/qemu/dtc/libfdt CPPFLAGS=3D"-I/root/src/github.com/stsquad/qemu/dtc -I/roo=
t/src/github.com/stsquad/qemu/dtc -I/root/src/github.com/stsquad/qemu/dtc/l=
ibfdt" CFLAGS=3D"-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g  -I/usr/inc=
lude/pixman-1 -I/root/src/github.com/stsquad/qemu/dtc/libfdt -Werror  -pthr=
ead -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -f=
PIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_S=
OURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -=
Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=3Dgnu99  =
-Wendif-labels -Wno-shift-negative-value -Wno-missing-include-dirs -Wempty-=
body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -Wignored-=
qualifiers -Wold-style-declaration -Wold-style-definition -Wtype-limits -fs=
tack-protector-strong -I/usr/include/p11-kit-1    -I/usr/include/libpng16  =
-I/usr/include/spice-server -I/usr/include/spice-1 -I/root/src/github.com/s=
tsquad/qemu/capstone/include -I/root/src/github.com/stsquad/qemu/tests" LDF=
LAGS=3D"-Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie -m64 -g " ARFLAGS=3D=
"rv" CC=3D"cc" AR=3D"ar" LD=3D"ld"  BUILD_DIR=3D/root/src/github.com/stsqua=
d/qemu libfdt/libfdt.a
if ! cmp -s qemu-version.h qemu-version.h.tmp; then mv qemu-version.h.tmp q=
emu-version.h; else rm qemu-version.h.tmp; fi
make[1]: Entering directory '/root/src/github.com/stsquad/qemu/dtc'
make[1]: Entering directory '/root/src/github.com/stsquad/qemu/slirp'
make -C /root/src/github.com/stsquad/qemu/capstone CAPSTONE_SHARED=3Dno BUI=
LDDIR=3D"/root/src/github.com/stsquad/qemu/capstone" CC=3D"cc" AR=3D"ar" LD=
=3D"ld" RANLIB=3D"ranlib" CFLAGS=3D"-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=
=3D2 -g -I/usr/include/pixman-1 -I/root/src/github.com/stsquad/qemu/dtc/lib=
fdt -pthread -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/i=
nclude -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LA=
RGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -std=3Dgnu99 -fstac=
k-protector-strong -I/usr/include/p11-kit-1 -I/usr/include/libpng16 -I/usr/=
include/spice-server -I/usr/include/spice-1 -I/root/src/github.com/stsquad/=
qemu/capstone/include -I/root/src/github.com/stsquad/qemu/tests -DCAPSTONE_=
USE_SYS_DYN_MEM -DCAPSTONE_HAS_ARM -DCAPSTONE_HAS_ARM64 -DCAPSTONE_HAS_POWE=
RPC -DCAPSTONE_HAS_X86"  BUILD_DIR=3D/root/src/github.com/stsquad/qemu /roo=
t/src/github.com/stsquad/qemu/capstone/libcapstone.a
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/root/src/github.com/stsquad/qemu/slirp'
make[1]: Entering directory '/root/src/github.com/stsquad/qemu/capstone'
set -e; echo '	CHK version_gen.h'; mkdir -p ./; 	(echo "#define DTC_VERSION=
 \"DTC 1.4.7\""; ) < Makefile > version_gen.h.tmp; if [ -r version_gen.h ] =
&& cmp -s version_gen.h version_gen.h.tmp; then rm -f version_gen.h.tmp; el=
se echo '	UPD version_gen.h'; mv -f version_gen.h.tmp version_gen.h; fi;
	CHK version_gen.h
make[1]: '/root/src/github.com/stsquad/qemu/capstone/libcapstone.a' is up t=
o date.
make[1]: Leaving directory '/root/src/github.com/stsquad/qemu/capstone'
make[1]: 'libfdt/libfdt.a' is up to date.
make[1]: Leaving directory '/root/src/github.com/stsquad/qemu/dtc'
cc -iquote /root/src/github.com/stsquad/qemu/tests/qemu-iotests -iquote tes=
ts/qemu-iotests -iquote /root/src/github.com/stsquad/qemu/tcg -iquote /root=
/src/github.com/stsquad/qemu/tcg/i386 -I/root/src/github.com/stsquad/qemu/l=
inux-headers -I/root/src/github.com/stsquad/qemu/linux-headers -iquote . -i=
quote /root/src/github.com/stsquad/qemu -iquote /root/src/github.com/stsqua=
d/qemu/accel/tcg -iquote /root/src/github.com/stsquad/qemu/include -I/usr/i=
nclude/pixman-1 -I/root/src/github.com/stsquad/qemu/dtc/libfdt -Werror  -pt=
hread -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include =
-fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE=
_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings=
 -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=3Dgnu99=
  -Wendif-labels -Wno-shift-negative-value -Wno-missing-include-dirs -Wempt=
y-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -Wignore=
d-qualifiers -Wold-style-declaration -Wold-style-definition -Wtype-limits -=
fstack-protector-strong -I/usr/include/p11-kit-1    -I/usr/include/libpng16=
  -I/usr/include/spice-server -I/usr/include/spice-1 -I/root/src/github.com=
/stsquad/qemu/capstone/include -I/root/src/github.com/stsquad/qemu/tests -M=
MD -MP -MT tests/qemu-iotests/socket_scm_helper.o -MF tests/qemu-iotests/so=
cket_scm_helper.d -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g   -c -o te=
sts/qemu-iotests/socket_scm_helper.o tests/qemu-iotests/socket_scm_helper.c
( echo "@set VERSION 4.1.50" && echo "@set CONFDIR /usr/local/etc/qemu" )> =
docs/version.texi
sh /root/src/github.com/stsquad/qemu/scripts/hxtool -t < /root/src/github.c=
om/stsquad/qemu/qemu-options.hx > qemu-options.texi
sh /root/src/github.com/stsquad/qemu/scripts/hxtool -t < /root/src/github.c=
om/stsquad/qemu/hmp-commands.hx > qemu-monitor.texi
sh /root/src/github.com/stsquad/qemu/scripts/hxtool -t < /root/src/github.c=
om/stsquad/qemu/qemu-img-cmds.hx > qemu-img-cmds.texi
sh /root/src/github.com/stsquad/qemu/scripts/hxtool -t < /root/src/github.c=
om/stsquad/qemu/hmp-commands-info.hx > qemu-monitor-info.texi
perl -Ww -- /root/src/github.com/stsquad/qemu/scripts/texi2pod.pl -I docs -=
I . -I . -DVERSION=3D"4.1.50" -DCONFDIR=3D"/usr/local/etc/qemu" qemu-img.te=
xi qemu-img.1.pod && pod2man --utf8 --section=3D1 --center=3D" " --release=
=3D" " qemu-img.1.pod > qemu-img.1
perl -Ww -- /root/src/github.com/stsquad/qemu/scripts/texi2pod.pl -I docs -=
I . -I . -DVERSION=3D"4.1.50" -DCONFDIR=3D"/usr/local/etc/qemu" qemu-nbd.te=
xi qemu-nbd.8.pod && pod2man --utf8 --section=3D8 --center=3D" " --release=
=3D" " qemu-nbd.8.pod > qemu-nbd.8
perl -Ww -- /root/src/github.com/stsquad/qemu/scripts/texi2pod.pl -I docs -=
I scripts -I docs/interop -DVERSION=3D"4.1.50" -DCONFDIR=3D"/usr/local/etc/=
qemu" scripts/texi2pod.pl docs/interop/qemu-ga.8.pod && pod2man --utf8 --se=
ction=3D8 --center=3D" " --release=3D" " docs/interop/qemu-ga.8.pod > docs/=
interop/qemu-ga.8
python3 -B /root/src/github.com/stsquad/qemu/scripts/qapi-gen.py -o qga/qap=
i-generated -p "qga-" /root/src/github.com/stsquad/qemu/qga/qapi-schema.json
No filename or title
/root/src/github.com/stsquad/qemu/rules.mak:394: recipe for target 'docs/in=
terop/qemu-ga.8' failed
make: *** [docs/interop/qemu-ga.8] Error 255
make: *** Waiting for unfinished jobs....

--
Alex Benn=C3=A9e

