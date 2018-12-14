Received: from eggs.gnu.org ([2001:4830:134:3::10]:60155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXoNl-0007Gw-Jq
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:24:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXoNk-0002ii-Qk
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:24:01 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:41199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXoNk-0002i7-JX
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:24:00 -0500
Received: by mail-oi1-x22b.google.com with SMTP id j21so4651947oii.8
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 06:24:00 -0800 (PST)
MIME-Version: 1.0
References: <154399222698.26202.11105511106314070474.malonedeb@gac.canonical.com>
	<154472615125.23782.34468593847836502.malone@soybean.canonical.com>
	<87k1kc1afl.fsf@linaro.org>
In-Reply-To: <87k1kc1afl.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 14:23:48 +0000
Message-ID: <CAFEAcA9ZjB8FidPOyjKwqP+PMaoNfD0szVk_XbQk11LzSU_ZfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1806824] Re: SIE-200 (TrustZone) MPC: BLK_MAX
 returns an incorrect value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: 1806824@bugs.launchpad.net, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 14 Dec 2018 at 13:56, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Thanks for the bug report and the test program. The fix seems straightf=
orward -- just adjust what we return for the register value. I've sent a pa=
tch:
> > http://patchwork.ozlabs.org/patch/1013034/
>
> I know you had a bunch of M-profile test cases. Once we get tcg system
> tests enabled would it be worth porting some of those into the QEMU src
> tree?

I don't have anything suitable -- unless we have
support for "system test of this guest kernel", in which case
we could add the arm trusted firmware boot/selftests.

thanks
-- PMM
