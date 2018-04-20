Received: from eggs.gnu.org ([2001:4830:134:3::10]:36433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9RFH-0003Xv-5T
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9RFE-0005xR-1P
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:18:15 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:40381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9RFD-0005xG-PL
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:18:11 -0400
Received: by mail-wr0-x22c.google.com with SMTP id v60-v6so20578369wrc.7
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 01:18:11 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-27-alex.bennee@linaro.org>
	<3765e085-c4e5-44a4-5986-41b233be4d22@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <3765e085-c4e5-44a4-5986-41b233be4d22@linaro.org>
Date: Fri, 20 Apr 2018 09:18:09 +0100
Message-ID: <87r2na9tq6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 26/43] tests/tcg/arm: fix up
 test-arm-iwmmxt test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 04/19/2018 03:58 AM, Alex Benn=C3=A9e wrote:
>> +test-arm-iwmmxt: CFLAGS+=3D-marm -march=3Diwmmxt -mabi=3Daapcs
>> +test-arm-iwmmxt: test-arm-iwmmxt.S
>
> This appears to be insufficient.
> If I begin with armv7l-linux-gnueabihf-gcc, then I get
>
>   CROSS-BUILD arm guest-tests with armv7l-linux-gnueabihf-gcc
> cc1: error: iWMMXt and NEON are incompatible

Was this with the docker fall-back?

It worked with my local:

07:37:25 [alex@zen:~/l/q/qemu.git] softmmu/demacro-cputlb-rfc + arm-linux-g=
nueabihf-gcc --version
arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 201606=
09
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


>
>
>
> r~


--
Alex Benn=C3=A9e
