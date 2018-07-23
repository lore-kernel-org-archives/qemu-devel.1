Received: from eggs.gnu.org ([2001:4830:134:3::10]:57132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fheFB-0006yM-SQ
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fheFA-0006ew-Vh
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:03:33 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fheFA-0006db-P1
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:03:32 -0400
Received: by mail-pg1-x542.google.com with SMTP id x5-v6so815470pgp.7
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 10:03:32 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-39-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <692ad736-c547-7007-dbd3-fdf6a827308f@linaro.org>
Date: Mon, 23 Jul 2018 10:03:28 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-39-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 38/40] gdbstub: Disable handling of
 nanoMIPS ISA bit in the MIPS gdbstub
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
> From: James Hogan <james.hogan@mips.com>
> 
> nanoMIPS has no ISA bit in the PC, so remove the handling of the low bit
> of the PC in the MIPS gdbstub for nanoMIPS. This prevents the PC being
> read as e.g. 0xbfc00001, and prevents writing to the PC clearing
> MIPS_HFLAG_M16.
> 
> Signed-off-by: James Hogan <james.hogan@mips.com>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/gdbstub.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

See my comments for 28/40.


r~
