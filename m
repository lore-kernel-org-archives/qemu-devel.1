Received: from eggs.gnu.org ([2001:4830:134:3::10]:42767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1elcE2-0000Tx-MZ
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:10:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1elcDx-0007x3-0v
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:10:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35336 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1elcDw-0007wH-EV
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:10:24 -0500
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA9ENQR7k9G95X_N6B5NzAam0OfQeA_XnO4t-R-LCyhn0A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <21338ea9-c4d0-cbcb-9b7e-0d001d51897b@redhat.com>
Date: Tue, 13 Feb 2018 16:10:19 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9ENQR7k9G95X_N6B5NzAam0OfQeA_XnO4t-R-LCyhn0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/48] Misc patches for 2018-02-13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 13/02/2018 15:37, Peter Maydell wrote:
> Hi. This fails tests on Linux/ppc64, Linux/s390x
> and Linux/sparc:
> 
> TEST: tests/sdhci-test... (pid=63141)
>   /x86_64/sdhci/pc:                                                    **
> ERROR:/home/pm215/qemu/tests/sdhci-test.c:118:check_specs_version:
> assertion failed (v == version): (1 == 2)
> FAIL
> GTester: last random seed: R02Sfc2909dc6cf031163b43c8bd23c9b9e3
> (pid=63154)
> FAIL: tests/sdhci-test
> 
> Given the set of failing hosts I suspect an endianness bug.

Indeed.  The qpci_memread calls should be qpci_io_readX.

Paolo
