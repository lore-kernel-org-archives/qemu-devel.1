Received: from eggs.gnu.org ([2001:4830:134:3::10]:41758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epOgk-0008Af-PQ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 20:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epOgh-0003cw-Ka
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 20:31:46 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:42205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epOgh-0003b5-DC
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 20:31:43 -0500
Received: by mail-pl0-x243.google.com with SMTP id 31so5885798ple.9
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 17:31:43 -0800 (PST)
References: <20180223145959.18761-1-laurent@vivier.eu>
	<20180223145959.18761-3-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0b55b60d-65c4-f48c-c062-449e3ef531eb@linaro.org>
Date: Fri, 23 Feb 2018 17:31:39 -0800
MIME-Version: 1.0
In-Reply-To: <20180223145959.18761-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/4] target/m68k: add fmod/frem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, Richard Henderson <rth@twiddle.net>

On 02/23/2018 06:59 AM, Laurent Vivier wrote:
> Using a local m68k floatx80_mod()
> [copied from previous:
> Written by Andreas Grabher for Previous, NeXT Computer Emulator.]
> 
> The quotient byte of the FPSR is updated with
> the result of the operation.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/Makefile.objs |   3 +-
>  target/m68k/cpu.h         |   1 +
>  target/m68k/fpu_helper.c  |  35 +++++++++++++++-
>  target/m68k/helper.h      |   2 +
>  target/m68k/softfloat.c   | 105 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/m68k/softfloat.h   |  26 ++++++++++++
>  target/m68k/translate.c   |   6 +++
>  7 files changed, 176 insertions(+), 2 deletions(-)
>  create mode 100644 target/m68k/softfloat.c
>  create mode 100644 target/m68k/softfloat.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
