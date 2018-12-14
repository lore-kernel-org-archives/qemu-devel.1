Received: from eggs.gnu.org ([2001:4830:134:3::10]:48825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXnuf-0007n2-Vo
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:53:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXnub-0001ZC-ID
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:53:57 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:35352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gXnub-0001Yw-7u
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:53:53 -0500
Received: by mail-wr1-x433.google.com with SMTP id 96so5525231wrb.2
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 05:53:53 -0800 (PST)
References: <154399222698.26202.11105511106314070474.malonedeb@gac.canonical.com>
	<154472615125.23782.34468593847836502.malone@soybean.canonical.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <154472615125.23782.34468593847836502.malone@soybean.canonical.com>
Date: Fri, 14 Dec 2018 13:53:50 +0000
Message-ID: <87k1kc1afl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Bug 1806824 <1806824@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org


Peter Maydell <peter.maydell@linaro.org> writes:

> Thanks for the bug report and the test program. The fix seems straightfor=
ward -- just adjust what we return for the register value. I've sent a patc=
h:
> http://patchwork.ozlabs.org/patch/1013034/

I know you had a bunch of M-profile test cases. Once we get tcg system
tests enabled would it be worth porting some of those into the QEMU src
tree?

There is already one other ARM system test pending for the microbit
tests.


>
>
> ** Changed in: qemu
>        Status: New =3D> In Progress


--
Alex Benn=C3=A9e
