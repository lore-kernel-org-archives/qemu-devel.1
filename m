Received: from eggs.gnu.org ([2001:4830:134:3::10]:58869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fBEqg-00044V-On
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 03:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fBEqd-0004Gv-LT
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 03:28:18 -0400
Date: Wed, 25 Apr 2018 09:28:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180425092805.36c96d4a.cohuck@redhat.com>
In-Reply-To: <20180424214550.32549-2-lersek@redhat.com>
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-2-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] qapi: fill in CpuInfoFast.arch in
 query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-stable@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, 24 Apr 2018 23:45:45 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> Commit ca230ff33f89 added added the @arch field to @CpuInfoFast, but it
> failed to set the new field in qmp_query_cpus_fast(), when TARGET_S390X
> was not defined. The updated @query-cpus-fast example in
> "qapi-schema.json" showed "arch":"x86" only because qmp_query_cpus_fast()
> calls g_malloc0() to allocate CpuInfoFast, and the CPU_INFO_ARCH_X86 enum
> constant is generated with value 0.
> 
> All @arch values other than @s390 implied the @CpuInfoOther sub-struct for
> @CpuInfoFast -- at the time of writing the patch --, thus no fields other
> than @arch needed to be set when TARGET_S390X was not defined. Set @arch
> now, by copying the corresponding assignments from qmp_query_cpus().

I agree with others that this looks a bit odd for riscv, and merging
patch 2 would be an option. But this is fine as well.

> 
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: qemu-stable@nongnu.org
> Fixes: ca230ff33f89bf7102cbfbc2328716da6750aaed
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
