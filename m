Received: from eggs.gnu.org ([2001:4830:134:3::10]:55697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eg9Ek-0000R2-4a
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:12:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eg9Ei-0002XA-Vq
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:12:38 -0500
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:34164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eg9Ei-0002Wq-QL
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:12:36 -0500
Received: by mail-ot0-x231.google.com with SMTP id x15so6468502ote.1
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 05:12:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180128231528.22719-1-richard.henderson@linaro.org>
References: <20180128231528.22719-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jan 2018 13:12:15 +0000
Message-ID: <CAFEAcA9eXiKYvFLcReHOH0+Au5cTFS8RiaxD_wVirLjm=4B2mQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v4 00/43] hppa-softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 28 January 2018 at 23:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Changes since patch v3:
>   * Drop MMU_DEBUG_LOAD, which obviates the sh4 changes.
>
>
> r~
>
>
> The following changes since commit e607bbee553cfe73072870cef458cfa4e78133e2:
>
>   Merge remote-tracking branch 'remotes/edgar/tags/edgar/xilinx-next-2018-01-26.for-upstream' into staging (2018-01-26 14:24:25 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-hppa-20180128
>
> for you to fetch changes up to 129ffd7265832fb748dc04e48dc761bfcd8508d3:
>
>   target/hppa: Implement PROBE for system mode (2018-01-28 14:15:40 -0800)
>
> ----------------------------------------------------------------
> Implement hppa-softmmu
>

Hi. Looks like this has a couple of format-string errors on 32-bit:

/home/peter.maydell/qemu/hw/hppa/machine.c: In function 'machine_hppa_init':
/home/peter.maydell/qemu/hw/hppa/machine.c:149:21: error: format '%lx'
expects argument of type 'long unsigned int', but argument 3 has type
'uint64_t {aka long long unsigned int}' [-Werror=format=]
     fprintf(stderr, "Firmware loaded at 0x%08lx-0x%08lx, entry at 0x%08lx.\n",
                     ^
/home/peter.maydell/qemu/hw/hppa/machine.c:149:21: error: format '%lx'
expects argument of type 'long unsigned int', but argument 4 has type
'uint64_t {aka long long unsigned int}' [-Werror=format=]
/home/peter.maydell/qemu/hw/hppa/machine.c:149:21: error: format '%lx'
expects argument of type 'long unsigned int', but argument 5 has type
'uint64_t {aka long long unsigned int}' [-Werror=format=]
/home/peter.maydell/qemu/hw/hppa/machine.c:180:25: error: format '%lx'
expects argument of type 'long unsigned int', but argument 3 has type
'uint64_t {aka long long unsigned int}' [-Werror=format=]
         fprintf(stderr, "Kernel loaded at 0x%08lx-0x%08lx, entry at 0x%08lx, "
                         ^
/home/peter.maydell/qemu/hw/hppa/machine.c:180:25: error: format '%lx'
expects argument of type 'long unsigned int', but argument 4 has type
'uint64_t {aka long long unsigned int}' [-Werror=format=]
/home/peter.maydell/qemu/hw/hppa/machine.c:180:25: error: format '%lx'
expects argument of type 'long unsigned int', but argument 5 has type
'uint64_t {aka long long unsigned int}' [-Werror=format=]

thanks
-- PMM
