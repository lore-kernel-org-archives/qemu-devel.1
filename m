Received: from eggs.gnu.org ([2001:4830:134:3::10]:46544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1erx3X-0004zp-Fa
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 21:37:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1erx3V-0008Ak-Tu
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 21:37:51 -0500
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:33852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1erx3V-0008A8-Mr
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 21:37:49 -0500
Received: by mail-ot0-x22e.google.com with SMTP id n74so10478576ota.1
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 18:37:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4506959a-8d32-039a-f0e3-c864fd44ace6@redhat.com>
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-24-git-send-email-mjc@sifive.com>
	<4506959a-8d32-039a-f0e3-c864fd44ace6@redhat.com>
From: Michael Clark <mjc@sifive.com>
Date: Sat, 3 Mar 2018 15:37:47 +1300
Message-ID: <CAHNT7NsGeLU8rzfJBBrKxuD9WffHRNcF=mUrgGXzWF=2Qz2FdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 23/23] RISC-V Build Infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

Let me know if you have a branch for me to pull and rebase against.

We are passing all build and make check tests in travis (except for a
couple of build timeouts because we are hitting the default 50 minute
timeout)

https://travis-ci.org/riscv/riscv-qemu/builds/348234736

On Sat, Mar 3, 2018 at 3:33 AM, Eric Blake <eblake@redhat.com> wrote:

> On 03/02/2018 07:51 AM, Michael Clark wrote:
>
>> This adds RISC-V into the build system enabling the following targets:
>>
>> - riscv32-softmmu
>> - riscv64-softmmu
>> - riscv32-linux-user
>> - riscv64-linux-user
>>
>> This adds defaults configs for RISC-V, enables the build for the RISC-V
>> CPU core, hardware, and Linux User Emulation. The 'qemu-binfmt-conf.sh'
>> script is updated to add the RISC-V ELF magic.
>>
>> Expected checkpatch errors for consistency reasons:
>>
>> ERROR: line over 90 characters
>> FILE: scripts/qemu-binfmt-conf.sh
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Sagar Karandikar <sagark@eecs.berkeley.edu>
>> Signed-off-by: Michael Clark <mjc@sifive.com>
>> ---
>>   arch_init.c                            |  2 ++
>>   configure                              | 13 +++++++++++++
>>   cpus.c                                 |  6 ++++++
>>   default-configs/riscv32-linux-user.mak |  1 +
>>   default-configs/riscv32-softmmu.mak    |  4 ++++
>>   default-configs/riscv64-linux-user.mak |  1 +
>>   default-configs/riscv64-softmmu.mak    |  4 ++++
>>   hw/riscv/Makefile.objs                 | 11 +++++++++++
>>   include/sysemu/arch_init.h             |  1 +
>>   qapi-schema.json                       | 17 ++++++++++++++++-
>>
>
> Will need rebasing to modify qapi/misc.json if my pending PULL request
> issues get resolved first:
>
> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg00469.html
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
