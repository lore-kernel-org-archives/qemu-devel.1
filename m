Received: from eggs.gnu.org ([2001:4830:134:3::10]:60400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gWhCv-0006kz-U8
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:32:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gWhCv-0002W0-0k
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:32:13 -0500
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:45842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gWhCu-0002VM-Ry
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:32:12 -0500
Received: by mail-yw1-xc43.google.com with SMTP id d190so5349173ywd.12
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 04:32:12 -0800 (PST)
MIME-Version: 1.0
References: <20181210152829.29271-1-alex.bennee@linaro.org>
	<20181210152829.29271-8-alex.bennee@linaro.org>
	<CAMo8BfJHo=6VJXbrnAYn+PiQECA6-Hj_rCOVPc12rPiKfc3u=Q@mail.gmail.com>
	<87tvjk1dhc.fsf@linaro.org>
In-Reply-To: <87tvjk1dhc.fsf@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 11 Dec 2018 04:32:00 -0800
Message-ID: <CAMo8BfLpHbDZJXuR3imFdBf5tMC3HYQ6dhbzbQZRNTOc2Pmn+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 07/13] tests/tcg/xtensa: enable system
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Aurelien Jarno <aurelien@aurel32.net>, amarkovic@wavecomp.com, Stafford Horne <shorne@gmail.com>

On Tue, Dec 11, 2018 at 3:58 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> I could certainly add a rule like:
>
> gdb-%: %
>         gdb --args $(QEMU) $(QEMU_OPTS) $<

Thanks (:

> > and a way to run tests on Tensilica ISS, it would be nice to keep it.
>
> I can restore some xtensa specific rules:
>
> xt-run-%: %
>         xt-run --xtensa-core=3DDC_B_232L --exit_with_target_code $<

The idea in the original makefile was that 'make check XT=3D'
runs the same suite on the ISS that 'make check' runs on QEMU.

> What are EXTFLAGS used for?

To pass additional flags to the current emulator.
Usually -d something for QEMU.

Also now that I'm looking at the following, it seems to me that CC
would be more appropriate there than HOST_CC:

> +linker.ld: linker.ld.S
> +       $(HOST_CC) $(XTENSA_INC) -E -P $< -o $@

--=20
Thanks.
-- Max
