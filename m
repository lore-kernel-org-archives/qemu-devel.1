Received: from eggs.gnu.org ([2001:4830:134:3::10]:56842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4w07-0001qm-Uu
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 17:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4w03-0001cr-Ic
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 17:35:43 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:56921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4w03-0001ci-Dd
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 17:35:39 -0400
Received: by mail-qk0-x243.google.com with SMTP id l194so8067969qke.13
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 14:35:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-21-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1f3349aa-9fc5-82be-8a80-068dd3fba21e@amsat.org>
Date: Wed, 18 Oct 2017 18:35:35 -0300
MIME-Version: 1.0
In-Reply-To: <20171016172609.23422-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 20/50] qom: Introduce
 CPUClass.tcg_initialize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: cota@braap.org, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 10/16/2017 02:25 PM, Richard Henderson wrote:
> Move target cpu tcg initialization to common code,
> called from cpu_exec_realizefn.
> 
> Cc: Andreas Färber <afaerber@suse.de>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

much cleaner, esp. the CRIS part.
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/qom/cpu.h           |  8 ++++++--
>  target/sparc/cpu.h          |  2 +-
>  exec.c                      |  7 ++++++-
>  target/alpha/cpu.c          |  5 +----
>  target/alpha/translate.c    |  6 ------
>  target/arm/cpu.c            |  6 +-----
>  target/cris/cpu.c           | 16 ++++++----------
>  target/hppa/cpu.c           |  3 +--
>  target/hppa/translate.c     |  6 ------
>  target/i386/cpu.c           |  5 +----
>  target/i386/translate.c     |  6 ------
>  target/lm32/cpu.c           |  7 +------
>  target/m68k/cpu.c           |  7 +------
>  target/microblaze/cpu.c     |  7 +------
>  target/mips/cpu.c           |  5 +----
>  target/mips/translate.c     |  7 -------
>  target/moxie/cpu.c          |  7 +------
>  target/moxie/translate.c    |  6 ------
>  target/nios2/cpu.c          |  7 +------
>  target/openrisc/cpu.c       |  7 +------
>  target/ppc/translate.c      |  6 ------
>  target/ppc/translate_init.c |  5 +----
>  target/s390x/cpu.c          |  7 +------
>  target/sh4/cpu.c            |  5 +----
>  target/sh4/translate.c      |  7 -------
>  target/sparc/cpu.c          |  5 +----
>  target/sparc/translate.c    |  9 +--------
>  target/tilegx/cpu.c         |  7 +------
>  target/tricore/cpu.c        |  5 +----
>  target/tricore/translate.c  |  5 +----
>  target/unicore32/cpu.c      |  7 +------
>  target/xtensa/cpu.c         |  7 +------
>  32 files changed, 40 insertions(+), 165 deletions(-)
