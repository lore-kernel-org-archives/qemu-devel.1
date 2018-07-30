Received: from eggs.gnu.org ([2001:4830:134:3::10]:47709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fk8Lk-0003Io-2V
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fk8Lj-00074v-C1
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:36:36 -0400
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:39584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fk8Lj-00074n-5p
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:36:35 -0400
Received: by mail-oi0-x22d.google.com with SMTP id d189-v6so21215950oib.6
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 06:36:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8yrNzEaL5_D79OjHCUUwPQnS4MnQhU9gumR7fpTThyuQ@mail.gmail.com>
References: <CAFEAcA8yrNzEaL5_D79OjHCUUwPQnS4MnQhU9gumR7fpTThyuQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 14:36:13 +0100
Message-ID: <CAFEAcA-uzB1KQqX-mZF2yVYO0sknkQL0+jWtCwrwbXYqrY-6vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] 'make vm-build-freebsd' &c don't work if KVM isn't
 enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 30 July 2018 at 14:23, Peter Maydell <peter.maydell@linaro.org> wrote:
> The tests in tests/vm/ seem to make some attempt to cope with the
> host system not allowing the user to use KVM, but it doesn't quite
> work.

Also, passing V=1 to the outer make command like:
 make vm-build-freebsd J=16 V=1
isn't propagated through to the VM: test output looks like
  GTESTER check-qtest-aarch64
  GTESTER check-qtest-alpha
instead of the proper verbose output with a line per subtest.

thanks
-- PMM
