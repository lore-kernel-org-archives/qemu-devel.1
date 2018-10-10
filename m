Received: from eggs.gnu.org ([2001:4830:134:3::10]:49717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gALqt-0003Tu-8m
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 17:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gALqq-0003fk-5J
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 17:17:07 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gALqp-0003eT-Up
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 17:17:04 -0400
Received: by mail-wm1-x341.google.com with SMTP id 189-v6so6919756wmw.2
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 14:17:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180930214744.27580-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <50011b67-99bc-59c2-1b42-831be7b42e81@amsat.org>
Date: Wed, 10 Oct 2018 23:17:00 +0200
MIME-Version: 1.0
In-Reply-To: <20180930214744.27580-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 0/4] mips: Increase the insn_flags
 holder size and clean mips-defs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: qemu-devel@nongnu.org

Ping?

On 9/30/18 11:47 PM, Philippe Mathieu-Daudé wrote:
> After noticing Fredrik patch [1] clashes with an ongoing work, I shared my
> concerns after the current limitations of CPUMIPSState::insn_flags, having
> 1 bit left to store more 'Chip specific instructions'.
> 
> Since v2: https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg04064.html
> 
> - rebased on upstream/master (previous was based on Fredrik's R5900)>
> Since v1: https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg00933.html
> 
> - update "int insn_flags;" in target/mips/translate.c::DisasContext
> - cleaned the 'insn_flags' namespace per Aleksandar suggestion
> - drop cpu defs used once
> - add my email in MAINTAINERS:MIPS to help me catch patches to review
> 
> Regards,
> 
> Phil.
> 
> [1] http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg01978.html
> [2] http://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg00901.html
> 
> Philippe Mathieu-Daudé (4):
>   target/mips: Increase the 'supported instructions' flags holder size
>   target/mips: Remove definitions that are only used once
>   target/mips: Clean the 'insn_flags' namespace
>   MAINTAINERS: Voluntary to review hobbyist MIPS contributions
> 
>  target/mips/cpu.h                |  2 +-
>  target/mips/internal.h           |  2 +-
>  target/mips/mips-defs.h          | 89 ++++++++++++++++++--------------
>  target/mips/translate.c          |  6 +--
>  target/mips/translate_init.inc.c |  6 +--
>  MAINTAINERS                      |  2 +
>  6 files changed, 61 insertions(+), 46 deletions(-)
> 
