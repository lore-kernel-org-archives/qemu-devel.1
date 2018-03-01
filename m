Received: from eggs.gnu.org ([2001:4830:134:3::10]:37437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1erKm9-00010a-Uo
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 04:45:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1erKm5-0007xj-5b
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 04:45:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42990 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1erKm4-0007xM-Vu
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 04:45:17 -0500
Date: Thu, 1 Mar 2018 10:45:05 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180301094505.zuqnvbkxyrm42nmf@kamzik.brq.redhat.com>
References: <20180228180215.25470-1-wei@redhat.com>
	<20180228180215.25470-5-wei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228180215.25470-5-wei@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V7 4/4] tests: Add migration test for
 aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, peter.maydell@linaro.org, quintela@redhat.com

On Wed, Feb 28, 2018 at 12:02:15PM -0600, Wei Huang wrote:
> This patch adds migration test support for aarch64. The test code, which
> implements the same functionality as x86, is booted as a kernel in qemu.
> Here are the design choices we make for aarch64:
> 
>  * We choose this -kernel approach because aarch64 QEMU doesn't provide a
>    built-in fw like x86 does. So instead of relying on a boot loader, we
>    use -kernel approach for aarch64.
>  * The serial output is sent to PL011 directly.
>  * The physical memory base for mach-virt machine is 0x40000000. We change
>    the start_address and end_address for aarch64.
> 
> In addition to providing the binary, this patch also includes the source
> code and the build script in tests/migration/. So users can change the
> source and/or re-compile the binary as they wish.
> 
> Signed-off-by: Wei Huang <wei@redhat.com>
> ---
>  tests/Makefile.include               |  1 +
>  tests/migration-test.c               | 44 +++++++++++++++++++--
>  tests/migration/Makefile             | 12 +++++-
>  tests/migration/aarch64-a-b-kernel.S | 75 ++++++++++++++++++++++++++++++++++++
>  tests/migration/aarch64-a-b-kernel.h | 19 +++++++++
>  tests/migration/migration-test.h     |  9 +++++
>  6 files changed, 154 insertions(+), 6 deletions(-)
>  create mode 100644 tests/migration/aarch64-a-b-kernel.S
>  create mode 100644 tests/migration/aarch64-a-b-kernel.h
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
