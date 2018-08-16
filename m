Received: from eggs.gnu.org ([2001:4830:134:3::10]:42759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqNdI-0004Iy-2A
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:08:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqNdE-0005Aq-WD
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:08:32 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:44424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fqNdA-0005AX-O9
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:08:25 -0400
Received: by mail-pl0-x242.google.com with SMTP id ba4-v6so2522998plb.11
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 12:08:24 -0700 (PDT)
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-50-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7e2fc906-4396-5d97-2599-018e9812c47c@linaro.org>
Date: Thu, 16 Aug 2018 12:08:20 -0700
MIME-Version: 1.0
In-Reply-To: <1534431497-1385-50-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 49/84] target/mips: Add handling of ISA
 mode bit for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 08/16/2018 07:57 AM, Aleksandar Markovic wrote:
> From: Matthew Fortune <matthew.fortune@mips.com>
> 
> ISA mode bit (LSB of address) is no longer required but is also
> masked to allow for tools transition. The flag has_isa_mode has the
> key role in the implementation.
> 
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Is this still on the to-be-cleaned-up list?


r~
