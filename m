Received: from eggs.gnu.org ([2001:4830:134:3::10]:43878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fk89k-0004ye-OJ
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:24:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fk89k-00026e-1f
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:24:12 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:40083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fk89j-00026R-ST
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:24:11 -0400
Received: by mail-oi0-x231.google.com with SMTP id w126-v6so21163395oie.7
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 06:24:11 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 14:23:50 +0100
Message-ID: <CAFEAcA8yrNzEaL5_D79OjHCUUwPQnS4MnQhU9gumR7fpTThyuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] 'make vm-build-freebsd' &c don't work if KVM isn't
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

The tests in tests/vm/ seem to make some attempt to cope with the
host system not allowing the user to use KVM, but it doesn't quite
work. The problem is that tests/vm/basevm.py always uses "-cpu host"
in the QEMU options it uses to run the VM, and that only works if
KVM is enabled. If the user can't run KVM then we correctly avoid
passing it "-enable-kvm" but then QEMU doesn't run because "-cpu host"
isn't supported...

I guess the right fix here is to use "-cpu max" ?

thanks
-- PMM
