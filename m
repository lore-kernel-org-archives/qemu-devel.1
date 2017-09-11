Received: from eggs.gnu.org ([2001:4830:134:3::10]:52042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1drVHf-00069U-U5
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 16:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1drVHc-0001Q6-Pf
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 16:26:19 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:54648
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1drVHc-0001Ph-Iy
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 16:26:16 -0400
References: <20170911022839.23231-1-f4bug@amsat.org>
	<1c72c0c6-bd29-5228-d4ad-b26b11afa712@linaro.org>
	<CAFEAcA9+iDKf7UmQ2tevR9KQb_F2fJoBY03zrMMwM7ypFUdeAw@mail.gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <dd244160-8b53-22bc-cf97-9948fb34f0f6@weilnetz.de>
Date: Mon, 11 Sep 2017 22:26:14 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9+iDKf7UmQ2tevR9KQb_F2fJoBY03zrMMwM7ypFUdeAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tcg/tci: do not use ldst label (never
 implemented)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Am 11.09.2017 um 20:24 schrieb Peter Maydell:
> I've also turned on a tci compile check on my pre-merge tests.
> (It doesn't pass "make check" for me, though...)

Did you run "make" before running "make check"?

I had an assertion because of a missing qemu-ga
when I=E2=80=8C only had run "make check", so there is a
dependency (perhaps check: tools) missing.

Now "make check" is running fine with all targets
(at least until check-qtest-ppc64). Sorry, I have
to finish for today.

Stefan
