Received: from eggs.gnu.org ([2001:4830:134:3::10]:46375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euG22-0006Fr-VG
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:17:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euG21-0008CY-Rj
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:17:50 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:34128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1euG21-0008C4-J9
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:17:49 -0500
Received: by mail-ot0-x244.google.com with SMTP id n74so8376204ota.1
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 03:17:49 -0800 (PST)
MIME-Version: 1.0
References: <CAHNT7NtB16m=Sn7bWugeOOiqVyeCT4Z7VrXijMDVZBA+tUdgPw@mail.gmail.com>
	<CAFEAcA_rPkjEgNc=uyQ2C+at8Zs28YZVAkOLAZk17JaVyjxuNw@mail.gmail.com>
In-Reply-To: <CAFEAcA_rPkjEgNc=uyQ2C+at8Zs28YZVAkOLAZk17JaVyjxuNw@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 09 Mar 2018 11:17:38 +0000
Message-ID: <CAHNT7NvZER8r0Jk2K_vLeB53tDS=rcpZg7S3Yy-7OFy=Gt+4CA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Apparently fpu/softfloat.c:1374 is reachable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On Fri, 9 Mar 2018 at 11:45 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 9 March 2018 at 04:22, Michael Clark <mjc@sifive.com> wrote:
> > I need to dig into this. I'll need to take the assertions out, or run
> with
> > tracing to see which fcvt test is triggering this unreachable piece of
> > code. FYI. I can look into it.
>
> >
> ERROR:/Users/mclark/src/sifive/riscv-qemu/fpu/softfloat.c:1374:round_to_i=
nt_and_pack:
> > code should not be reached
> > qemu-images/run-tests.sh: line 6: 58437 Abort trap: 6           ${QEMU}
> > -nographic -machine spike_v1.10 -kernel $i
>
> This looks like maybe it's the issue Richard Jones sent a patch for ?
> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg01005.html


Thanks. Seems I wasn=E2=80=99t on the =E2=80=98cc.

We need this patch in our downstream repo... We also need to automate
riscv-tests in the riscv.org repo .travis.yml so we can pick these things
up automatically...
