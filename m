Received: from eggs.gnu.org ([2001:4830:134:3::10]:41611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erll3-00032Z-JX
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:34:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erll0-0001jz-CS
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:34:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39542 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erll0-0001jE-7o
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:33:58 -0500
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-24-git-send-email-mjc@sifive.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4506959a-8d32-039a-f0e3-c864fd44ace6@redhat.com>
Date: Fri, 2 Mar 2018 08:33:47 -0600
MIME-Version: 1.0
In-Reply-To: <1519998711-73430-24-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 23/23] RISC-V Build Infrastructure
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

On 03/02/2018 07:51 AM, Michael Clark wrote:
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
> Signed-off-by: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>   arch_init.c                            |  2 ++
>   configure                              | 13 +++++++++++++
>   cpus.c                                 |  6 ++++++
>   default-configs/riscv32-linux-user.mak |  1 +
>   default-configs/riscv32-softmmu.mak    |  4 ++++
>   default-configs/riscv64-linux-user.mak |  1 +
>   default-configs/riscv64-softmmu.mak    |  4 ++++
>   hw/riscv/Makefile.objs                 | 11 +++++++++++
>   include/sysemu/arch_init.h             |  1 +
>   qapi-schema.json                       | 17 ++++++++++++++++-

Will need rebasing to modify qapi/misc.json if my pending PULL request 
issues get resolved first:

https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg00469.html

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
