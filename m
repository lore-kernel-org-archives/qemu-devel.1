Received: from eggs.gnu.org ([2001:4830:134:3::10]:34734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqRmm-0002up-IY
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 18:02:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqRmj-0006Fv-Tl
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 18:02:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59606 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eqRmj-0006Ff-Om
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 18:02:17 -0500
References: <1519683480-33201-1-git-send-email-mjc@sifive.com>
	<1519683480-33201-24-git-send-email-mjc@sifive.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d652883b-7e99-5ada-93e9-3d5982266d25@redhat.com>
Date: Mon, 26 Feb 2018 17:02:15 -0600
MIME-Version: 1.0
In-Reply-To: <1519683480-33201-24-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 23/23] RISC-V Build Infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 02/26/2018 04:18 PM, Michael Clark wrote:
> This adds RISC-V into the build system enabling the following targets:
> 
> - riscv32-softmmu
> - riscv64-softmmu
> - riscv32-linux-user
> - riscv64-linux-user
> 
> This adds defaults configs for RISC-V, enables the build for the RISC-V
> CPU core, hardware, and Linux User Emulation. The 'qemu-binfmt-conf.sh'
> script is updated to add the RISC-V ELF magic.
> 
> Expected checkpatch errors for consistency reasons:
> 
> ERROR: line over 90 characters
> FILE: scripts/qemu-binfmt-conf.sh
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---

> +++ b/qapi-schema.json

>   ##
>   # @CpuInfo:
> @@ -452,6 +454,7 @@
>               'ppc': 'CpuInfoPPC',
>               'mips': 'CpuInfoMIPS',
>               'tricore': 'CpuInfoTricore',
> +            'riscv': 'CpuInfoRISCV',
>               'other': 'CpuInfoOther' } }

Hmm - we're trying to deprecate CpuInfo in parallel, in favor of the new 
query-cpus-fast.  CpuInfoRISCV will be useless once that happens, but it 
doesn't invalidate your pull request.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
