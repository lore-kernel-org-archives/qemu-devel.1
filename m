Received: from eggs.gnu.org ([209.51.188.92]:41737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goU3F-0006uZ-GM
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:07:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goU3E-0001dF-P7
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:07:45 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:42499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goU3E-0001d0-KI
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:07:44 -0500
Received: by mail-oi1-x233.google.com with SMTP id w13so16173986oiw.9
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 06:07:44 -0800 (PST)
MIME-Version: 1.0
References: <20190129120002.3866-1-peter.maydell@linaro.org>
In-Reply-To: <20190129120002.3866-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Jan 2019 14:07:32 +0000
Message-ID: <CAFEAcA8YEvCegfTObE1Ys8g+g4FGsAS=FNQMc_bY6TBEv7E_2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/23] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 29 Jan 2019 at 12:00, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> v2: dropped patches that add the microbit nRF51 non-volatile memories
> and the test case for them.
>
> thanks
> -- PMM
>
>
> The following changes since commit 3a183e330dbd7dbcac3841737ac874979552cca2:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190128' into staging (2019-01-28 16:26:47 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190129
>
> for you to fetch changes up to 46f5abc0a2566ac3dc954eeb62fd625f0eaca120:
>
>   gdbstub: Simplify gdb_get_cpu_pid() to use cpu->cluster_index (2019-01-29 11:46:06 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Fix validation of 32-bit address spaces for aa32 (fixes an assert introduced in ba97be9f4a4)
>  * v8m: Ensure IDAU is respected if SAU is disabled
>  * gdbstub: fix gdb_get_cpu(s, pid, tid) when pid and/or tid are 0
>  * exec.c: Use correct attrs in cpu_memory_rw_debug()
>  * accel/tcg/user-exec: Don't parse aarch64 insns to test for read vs write
>  * target/arm: Don't clear supported PMU events when initializing PMCEID1
>  * memory: add memory_region_flush_rom_device()
>  * microbit: Add stub NRF51 TWI magnetometer/accelerometer detection
>  * tests/microbit-test: extend testing of microbit devices
>  * checkpatch: Don't emit spurious warnings about block comments
>  * aspeed/smc: misc bug fixes
>  * xlnx-zynqmp: Don't create rpu-cluster if there are no RPUs
>  * xlnx-zynqmp: Realize cluster after putting RPUs in it
>  * accel/tcg: Add cluster number to TCG TB hash so differently configured
>    CPUs don't pick up cached TBs for the wrong kind of CPU
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
