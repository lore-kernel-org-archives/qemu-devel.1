Received: from eggs.gnu.org ([2001:4830:134:3::10]:44822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwlNC-0002P7-8F
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwlN8-0003UM-8Y
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:42:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40724 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fwlN8-0003U9-3k
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:42:14 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1535778675-32170-5-git-send-email-wei@redhat.com> (Wei Huang's
	message of "Sat, 1 Sep 2018 01:11:15 -0400")
References: <1535778675-32170-1-git-send-email-wei@redhat.com>
	<1535778675-32170-5-git-send-email-wei@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 03 Sep 2018 11:42:09 +0200
Message-ID: <87y3ci3ojy.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH V8 4/4] tests: Add migration test for
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, lvivier@redhat.com, drjones@redhat.com, dgilbert@redhat.com

Wei Huang <wei@redhat.com> wrote:
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
> Signed-off-by: Wei Huang <wei@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

with the change spotted by Peter.

Thanks a lot for getting this done.  I was "porting" your previous
version to 3.0 because I thought that you had already gone through too
many "posts" just to get "general", not aarch64 bits fixed.

I have no idea about arm asm, so the reviewed by is for the other bits O:-)

Later, Juan.
