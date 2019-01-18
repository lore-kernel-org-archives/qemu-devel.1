Received: from eggs.gnu.org ([209.51.188.92]:60251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkTTB-0007cG-5u
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:41:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkTT9-0002fx-6y
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:41:56 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:37695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkTT8-0002ci-L2
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:41:55 -0500
Received: by mail-ot1-x32f.google.com with SMTP id s13so14252335otq.4
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 04:41:54 -0800 (PST)
MIME-Version: 1.0
References: <1547748785-14030-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1547748785-14030-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 12:41:40 +0000
Message-ID: <CAFEAcA_+=6Ls4wYWgGc4+vFvmLPhNMVjuonUsWv=bXKCp79n2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/12] MIPS queue for January 17, 2019*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Thu, 17 Jan 2019 at 18:13, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 681d61362d3f766a00806b89d6581869041f73cb:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-01-17 12:48:42 +0000)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-january-17-2019
>
> for you to fetch changes up to 60bfe335972213bada1ac954e84234aa7c4046f9:
>
>   target/mips: Introduce 32 R5900 multimedia registers (2019-01-17 19:06:56 +0100)
>
> ----------------------------------------------------------------
>
> MIPS queue for January 17, 2019
>
>   - provide access to configuration registers SAARI, SAAR, and
>     MemoryMapID
>   - update Inter-Thread Communication Unit
>   - CP0-related cleanups
>   - introduce R5900 multimedia registers
>

Hi; I'm afraid this fails 'make check' on all platforms:

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=mips64el-softmmu
/qemu-system-mips64el QTEST_QEMU_IMG=qemu-img tests/machine-none-test
-m=quick -k --tap < /dev/null
| ./scripts/tap-driver.pl --test-name="machine-none-test"
PASS 1 machine-none-test /mips64el/machine/none/cpu_option
MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=mips64el-softmmu
/qemu-system-mips64el QTEST_QEMU_IMG=qemu-img tests/qom-test -m=quick
-k --tap < /dev/null | ./scrip
ts/tap-driver.pl --test-name="qom-test"
qemu-system-mips64el: Property '.saar-present' not found
Broken pipe
/home/petmay01/linaro/qemu-for-merges/tests/libqtest.c:135:
kill_qemu() tried to terminate QEMU proc
ess but encountered exit status 1
ERROR - too few tests run (expected 8, got 0)
Aborted (core dumped)

thanks
-- PMM
