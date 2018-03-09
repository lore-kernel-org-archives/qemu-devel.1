Received: from eggs.gnu.org ([2001:4830:134:3::10]:52067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euGIn-00068Y-30
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:35:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euGIl-0006VR-Sm
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:35:09 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:37332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1euGIl-0006V5-LJ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:35:07 -0500
Received: by mail-ot0-x243.google.com with SMTP id t2so8396159otj.4
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 03:35:07 -0800 (PST)
MIME-Version: 1.0
References: <CAHNT7NtB16m=Sn7bWugeOOiqVyeCT4Z7VrXijMDVZBA+tUdgPw@mail.gmail.com>
	<CAFEAcA_rPkjEgNc=uyQ2C+at8Zs28YZVAkOLAZk17JaVyjxuNw@mail.gmail.com>
	<CAHNT7NvZER8r0Jk2K_vLeB53tDS=rcpZg7S3Yy-7OFy=Gt+4CA@mail.gmail.com>
In-Reply-To: <CAHNT7NvZER8r0Jk2K_vLeB53tDS=rcpZg7S3Yy-7OFy=Gt+4CA@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 09 Mar 2018 11:34:56 +0000
Message-ID: <CAHNT7NtLVFU08oC0ReduK-2mFBwgwjvgfEWaZpYFY-GkjKWv=g@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan O'Rear <sorear2@gmail.com>

On Sat, 10 Mar 2018 at 12:17 AM, Michael Clark <mjc@sifive.com> wrote:

> On Fri, 9 Mar 2018 at 11:45 PM, Peter Maydell <peter.maydell@linaro.org>
> wrote:
>
>> On 9 March 2018 at 04:22, Michael Clark <mjc@sifive.com> wrote:
>> > I need to dig into this. I'll need to take the assertions out, or run
>> with
>> > tracing to see which fcvt test is triggering this unreachable piece of
>> > code. FYI. I can look into it.
>>
>> >
>> ERROR:/Users/mclark/src/sifive/riscv-qemu/fpu/softfloat.c:1374:round_to_=
int_and_pack:
>> > code should not be reached
>> > qemu-images/run-tests.sh: line 6: 58437 Abort trap: 6           ${QEMU=
}
>> > -nographic -machine spike_v1.10 -kernel $i
>>
>> This looks like maybe it's the issue Richard Jones sent a patch for ?
>> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg01005.html
>
>
> Thanks. Seems I wasn=E2=80=99t on the =E2=80=98cc.
>
> We need this patch in our downstream repo... We also need to automate
> riscv-tests in the riscv.org repo .travis.yml so we can pick these things
> up automatically...
>

BTW how does one hide signed-off-by or cc email addresses with the
git-send-email workflow?

Seems like editing the patch after git format-patch is likely the only way
around for contributors whose wishes I might not have honoured, except
originally when I was using an advoc albeit buggy workflow, where the Cc=E2=
=80=99s
et all we=E2=80=99re later added to the patch headers and not the commits. =
I=E2=80=99ve
probably inadvertently violated someone=E2=80=99s wish to keep their email =
address
out of the list archives, which is an understandable wish.

This is not an issue with GitHub PR=E2=80=99s as they keep identity informa=
tion
differently however slicing up the port for upstreaming has lost some of
our contributor history. I have made tags before every squash and rebase so
we can find all history in the riscv repo, as well as previously trying to
keep personal emails out of the cover letters in the first series. With the
change to the git-sendemail  workflow i=E2=80=99ve likely regressed here.

I also probably have to manually edit patches to add =E2=80=98Cc to the
riscv-patches mailing list, as it doesn=E2=80=99t seem right to put that em=
ail in
the commit messages.

I=E2=80=99ll guess we=E2=80=99ll figure it all out eventually...

Michael

>
