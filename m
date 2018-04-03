Received: from eggs.gnu.org ([2001:4830:134:3::10]:49908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1f3GeH-000280-Vj
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 03:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1f3GeE-0007N0-SR
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 03:46:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1f3GeE-0007MM-N0
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 03:46:30 -0400
Date: Tue, 3 Apr 2018 08:46:27 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180403074627.GN2450@redhat.com>
References: <20180328022233.13400-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328022233.13400-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/2] RISC-V: Mark FP status dirty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, patches@groups.riscv.org, mjc@sifive.com, palmer@sifive.com

On Wed, Mar 28, 2018 at 10:22:31AM +0800, Richard Henderson wrote:
> Since it was my patch that broke FP state tracking in the
> first place, I feel obligated to fix it again.

I missed this patch, thanks Michael Clark for pointing it out to me.

I've just tried it now using my test reproducer of the bug
(http://oirase.annexia.org/tmp/sched.c) and Fedora/RISC-V and it
appears to fix the problem.

> Mark mstatus[fs] as dirty whenever we write to the file.
> This can be optimized by only doing so once within a TB
> which initially began with a clean file.
> 
> I have not yet put together an environment that can test
> this, so I'll need someone else to give it a go.

This is the Fedora stage4 disk image which works fine under qemu from
git (make sure you read the readme.txt file first):

  https://fedorapeople.org/groups/risc-v/disk-images/

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
