Received: from eggs.gnu.org ([2001:4830:134:3::10]:38327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fl6Sa-0003YL-Bh
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 01:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fl6SX-0004MD-9B
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 01:47:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38720 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fl6SX-0004Kb-3P
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 01:47:37 -0400
Date: Thu, 2 Aug 2018 13:47:32 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180802054732.GB11859@lemon.usersys.redhat.com>
References: <CAFEAcA8yrNzEaL5_D79OjHCUUwPQnS4MnQhU9gumR7fpTThyuQ@mail.gmail.com>
	<CAFEAcA-uzB1KQqX-mZF2yVYO0sknkQL0+jWtCwrwbXYqrY-6vw@mail.gmail.com>
	<CAFEAcA883Ts4W-Ks+h7Ds4_SAdAYYab9GYO94Whcqg5FJuoZkg@mail.gmail.com>
	<CAFEAcA-iB7_hU2KNUS3rra4FD_P7PzXtXW1BaP37zp=OKZkv3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-iB7_hU2KNUS3rra4FD_P7PzXtXW1BaP37zp=OKZkv3w@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Mon, 07/30 16:20, Peter Maydell wrote:
> On 30 July 2018 at 14:40, Peter Maydell <peter.maydell@linaro.org> wrote:
> > On 30 July 2018 at 14:36, Peter Maydell <peter.maydell@linaro.org> wrote:
> >> On 30 July 2018 at 14:23, Peter Maydell <peter.maydell@linaro.org> wrote:
> >>> The tests in tests/vm/ seem to make some attempt to cope with the
> >>> host system not allowing the user to use KVM, but it doesn't quite
> >>> work.
> >>
> >> Also, passing V=1 to the outer make command like:
> >>  make vm-build-freebsd J=16 V=1
> >> isn't propagated through to the VM: test output looks like
> >>   GTESTER check-qtest-aarch64
> >>   GTESTER check-qtest-alpha
> >> instead of the proper verbose output with a line per subtest.
> >
> > Nor is the J=16 option passed through to "make check":
> 
> Patches for these things on the way, once I've completed a test run.

All good catches! Looking forward to the fixes. Thanks.

Fam
