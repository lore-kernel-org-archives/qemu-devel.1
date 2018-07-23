Received: from eggs.gnu.org ([2001:4830:134:3::10]:53941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fhe77-0000wj-4O
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fhe74-0001Z8-RU
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:55:11 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fhe74-0001Yn-Hq
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:55:10 -0400
Received: by mail-pg1-x541.google.com with SMTP id r1-v6so789154pgp.11
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 09:55:10 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-31-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5df2dde1-1d54-1a96-cfcc-b1788fc42885@linaro.org>
Date: Mon, 23 Jul 2018 09:55:06 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-31-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 30/40] target/mips: Adjust set_pc() for
 nanoMIPS
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
> ERET and ERETNC shouldn't clear MIPS_HFLAG_M16 for nanoMIPS since there
> is no ISA bit, so fix set_pc() to skip the hflags update.
> 
> Signed-off-by: James Hogan <james.hogan@mips.com>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/op_helper.c | 4 ++++
>  1 file changed, 4 insertions(+)

See my comments for 28/40.


r~
