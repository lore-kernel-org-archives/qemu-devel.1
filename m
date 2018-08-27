Received: from eggs.gnu.org ([2001:4830:134:3::10]:33374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuDZ5-0001wt-0i
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 05:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuDTD-0002aW-02
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 05:06:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57554 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fuDT9-0002Z9-CO
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 05:05:55 -0400
Date: Mon, 27 Aug 2018 11:05:51 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180827090551.4lhug2yvghirb3si@sirius.home.kraxel.org>
References: <20180824012126.22721-1-famz@redhat.com>
	<8d039be4-486e-e017-88ca-5cb6ebd89519@comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d039be4-486e-e017-88ca-5cb6ebd89519@comstyle.com>
Subject: Re: [Qemu-devel] [PATCH] tests: vm: auto_install OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Fri, Aug 24, 2018 at 10:36:30AM -0400, Brad Smith wrote:
> I very much appreciate the effort to bump up to 6.3 as I was going
> to suggest doing that at some point. But bumping up to 6.3 at the
> moment will fail with the configure script. We've switched from GCC 4.2
> to Clang. The TLS check will fail with Clang's emulated TLS. We've
> had a local patch for awhile to fix the test but I don't think it is
> appropriate to upstream as is.

Hmm, /me looks a bit surprised.
Seems to work fine for me ...

openbsd kraxel ~/build/qemu# uname -a
OpenBSD openbsd.sirius.kraxel.org 6.3 GENERIC.MP#107 amd64
openbsd kraxel ~/build/qemu# cc --version
OpenBSD clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
Target: amd64-unknown-openbsd6.3
Thread model: posix
InstalledDir: /usr/bin

cheers,
  Gerd
