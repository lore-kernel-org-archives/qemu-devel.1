Received: from eggs.gnu.org ([2001:4830:134:3::10]:43087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fxtLk-0004zi-Vg
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 08:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fxtLh-00077s-RT
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 08:25:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34776 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1fxtLh-00077B-Ly
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 08:25:25 -0400
Date: Thu, 6 Sep 2018 14:25:19 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180906122519.v7dmqrpcan6jm34i@kamzik.brq.redhat.com>
References: <1536174934-26022-1-git-send-email-wei@redhat.com>
	<1536174934-26022-5-git-send-email-wei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536174934-26022-5-git-send-email-wei@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V9 4/4] tests: Add migration test for
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
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peter.maydell@linaro.org, quintela@redhat.com, dgilbert@redhat.com

On Wed, Sep 05, 2018 at 03:15:34PM -0400, Wei Huang wrote:
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
> code and the build script in tests/migration/aarch64. So users can change
> the source and/or re-compile the binary as they wish.
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Wei Huang <wei@redhat.com>
> ---
>  tests/Makefile.include               |  1 +
>  tests/migration-test.c               | 27 +++++++++++--
>  tests/migration/Makefile             |  2 +-
>  tests/migration/aarch64/Makefile     | 20 ++++++++++
>  tests/migration/aarch64/a-b-kernel.S | 75 ++++++++++++++++++++++++++++++++++++
>  tests/migration/aarch64/a-b-kernel.h | 19 +++++++++
>  tests/migration/migration-test.h     |  9 +++++
>  7 files changed, 148 insertions(+), 5 deletions(-)
>  create mode 100644 tests/migration/aarch64/Makefile
>  create mode 100644 tests/migration/aarch64/a-b-kernel.S
>  create mode 100644 tests/migration/aarch64/a-b-kernel.h
>

I see this is already pulled, but just in case it still matters

Reviewed-by: Andrew Jones <drjones@redhat.com>
