Received: from eggs.gnu.org ([2001:4830:134:3::10]:34988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkaJb-0002SB-98
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkaJX-0007I3-1J
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:28:15 -0400
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242]:46258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkaJW-0007Ha-Pu
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:28:10 -0400
Received: by mail-ua0-x242.google.com with SMTP id u11-v6so6346713uan.13
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 12:28:10 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-60-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eae3f4ed-ddfb-7284-11dc-4f238fd14d6c@linaro.org>
Date: Tue, 31 Jul 2018 15:28:00 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-60-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 59/76] gdbstub: Disable handling of
 nanoMIPS ISA bit in the MIPS gdbstub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/30/2018 12:12 PM, Aleksandar Markovic wrote:
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

Likewise re nanomips not setting M16.


r~
