Received: from eggs.gnu.org ([2001:4830:134:3::10]:55644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fheAx-0004Ff-8e
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fheAw-0003oj-HD
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:59:11 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fheAw-0003o9-9t
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:59:10 -0400
Received: by mail-pg1-x542.google.com with SMTP id p23-v6so793597pgv.13
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 09:59:10 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-33-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8d1a14bf-8cc5-91cb-5aed-cefeb8d97962@linaro.org>
Date: Mon, 23 Jul 2018 09:59:06 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-33-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 32/40] elf: Add nanoMIPS specific
 variations in ELF header fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/19/2018 05:55 AM, Stefan Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Add nanoMIPS-related values in ELF header fields as specified in
> nanoMIPS' "ELF ABI Supplement".
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  include/elf.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

None of these values have made it upstream to binutils yet,
so I can't double-check them.  However,

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~
