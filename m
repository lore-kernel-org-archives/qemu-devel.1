Received: from eggs.gnu.org ([2001:4830:134:3::10]:58469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1erq8z-0002al-P7
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 14:15:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1erq8y-0008Ab-Ku
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 14:15:01 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:41855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1erq8y-000893-DY
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 14:15:00 -0500
Received: by mail-lf0-x243.google.com with SMTP id m69so14806084lfe.8
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 11:15:00 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <152001667299.1335.13671168491760473180@bdbb90650ae5>
References: <cover.1520013048.git.alistair.francis@xilinx.com>
	<152001667299.1335.13671168491760473180@bdbb90650ae5>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 2 Mar 2018 11:14:28 -0800
Message-ID: <CAKmqyKPq4cOr=jmxkusfstYRPxY8tsjgB-LB7wyUdruM+BUj5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Add a property to set the ARM CPU
 core count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Fri, Mar 2, 2018 at 10:51 AM,  <no-reply@patchew.org> wrote:
> Hi,
>
> This series failed build test on ppcle host. Please find the details below.
>
...
>   CC      aarch64-softmmu/target/arm/helper-a64.o
>   LINK    sparc64-softmmu/qemu-system-sparc64
>   CC      arm-softmmu/trace/control-target.o
>   CC      aarch64-softmmu/target/arm/gdbstub64.o
>   CC      aarch64-softmmu/target/arm/crypto_helper.o
>   CC      aarch64-softmmu/target/arm/arm-powerctl.o
>   LINK    armeb-linux-user/qemu-armeb
>   CC      arm-softmmu/gdbstub-xml.o
>   GEN     trace/generated-helpers.c
>   CC      arm-softmmu/trace/generated-helpers.o
>   CC      aarch64-softmmu/trace/control-target.o
>   CC      aarch64-softmmu/gdbstub-xml.o
>   CC      aarch64-softmmu/trace/generated-helpers.o
>   LINK    arm-linux-user/qemu-arm
> target/arm/cpu.o:(.toc+0x0): undefined reference to `smp_cpus'
> collect2: error: ld returned 1 exit status
> make[1]: *** [qemu-aarch64] Error 1
> make: *** [subdir-aarch64-linux-user] Error 2
> make: *** Waiting for unfinished jobs....
> target/arm/cpu.o:(.toc+0x0): undefined reference to `smp_cpus'
> collect2: error: ld returned 1 exit status
> make[1]: *** [qemu-armeb] Error 1
> make: *** [subdir-armeb-linux-user] Error 2
>   LINK    mipsel-linux-user/qemu-mipsel
> target/arm/cpu.o:(.toc+0x0): undefined reference to `smp_cpus'
> collect2: error: ld returned 1 exit status
> make[1]: *** [qemu-arm] Error 1
> make: *** [subdir-arm-linux-user] Error 2
>   LINK    aarch64_be-linux-user/qemu-aarch64_be
> target/arm/cpu.o:(.toc+0x0): undefined reference to `smp_cpus'
> collect2: error: ld returned 1 exit status
> make[1]: *** [qemu-aarch64_be] Error 1
> make: *** [subdir-aarch64_be-linux-user] Error 2
>   LINK    s390x-softmmu/qemu-system-s390x
>   LINK    mipsn32el-linux-user/qemu-mipsn32el
>   LINK    i386-softmmu/qemu-system-i386
>   LINK    ppc64-linux-user/qemu-ppc64
>   LINK    x86_64-softmmu/qemu-system-x86_64
>   LINK    ppc64le-linux-user/qemu-ppc64le
>   LINK    ppc-linux-user/qemu-ppc
>   LINK    mipsel-softmmu/qemu-system-mipsel
>   LINK    ppc64abi32-linux-user/qemu-ppc64abi32
>   LINK    arm-softmmu/qemu-system-arm
>   LINK    mips-softmmu/qemu-system-mips
>   LINK    mips64el-softmmu/qemu-system-mips64el
>   LINK    aarch64-softmmu/qemu-system-aarch64
>   LINK    mips64-softmmu/qemu-system-mips64
>   LINK    ppcemb-softmmu/qemu-system-ppcemb
>   LINK    ppc-softmmu/qemu-system-ppc
>   LINK    ppc64-softmmu/qemu-system-ppc64
> === OUTPUT END ===

Argh! I rushed this through without waiting on the CI. I'll re-send V3.

Alistair

>
> Test command exited with code: 2
>
>
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
