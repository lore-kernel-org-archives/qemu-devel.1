Received: from eggs.gnu.org ([2001:4830:134:3::10]:35218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1drgwA-0001Do-PJ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 04:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1drgw7-0002a9-Nk
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 04:52:54 -0400
Received: from smtp.mail.uni-mannheim.de ([134.155.96.80]:44155)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1drgw7-0002XM-GF
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 04:52:51 -0400
References: <20170911022839.23231-1-f4bug@amsat.org>
	<1c72c0c6-bd29-5228-d4ad-b26b11afa712@linaro.org>
	<CAFEAcA9+iDKf7UmQ2tevR9KQb_F2fJoBY03zrMMwM7ypFUdeAw@mail.gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <cff16e31-4be0-9665-62d7-88a12b6d0b56@weilnetz.de>
Date: Tue, 12 Sep 2017 10:52:49 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9+iDKf7UmQ2tevR9KQb_F2fJoBY03zrMMwM7ypFUdeAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
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
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Am 11.09.2017 um 20:24 schrieb Peter Maydell:
> I've also turned on a tci compile check on my pre-merge tests.
> (It doesn't pass "make check" for me, though...) thanks -- PMM

"make check-qtest-ppc64" fails for me, too.

Thomas, this seems to be again the well known timing problem
in tests/prom-env-test.c. The time for the test had been
changedfrom 30 s to 10 s to 120 s in the past.

For TCI, even that latest value isnot sufficient when
testing with pseries. Of course that also depends on other
parameters (speed of test machine, compilerflags).

In my test pseries took nearly 5 minutes, so the test passes
when the loop upper limit is increased to 30000.

Is there a better way to handle this test? Why does pseries
still need much more time than the other machines
(not only with TCI)?

Regards,
Stefan
