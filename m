Received: from eggs.gnu.org ([2001:4830:134:3::10]:38549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dOMKp-0005lS-Lr
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 07:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dOMKo-0004rc-Rd
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 07:01:07 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:35930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dOMKo-0004rS-Lf
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 07:01:06 -0400
Date: Fri, 23 Jun 2017 13:01:03 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170623110103.cnkfsbe74zia2gvz@aurel32.net>
References: <20170620000405.3391-1-rth@twiddle.net>
	<20170620000405.3391-8-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620000405.3391-8-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 07/18] target/s390x: Implement
 load-and-zero-rightmost-byte insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

On 2017-06-19 17:03, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/insn-data.def | 4 ++++
>  target/s390x/translate.c   | 7 +++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index 60d244f..20dec56 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -429,6 +429,10 @@
>  /* LOAD AND TRAP */
>      C(0xe39f, LAT,     RXY_a, LAT, 0, m2_32u, r1, 0, lat, 0)
>      C(0xe385, LGAT,    RXY_a, LAT, 0, a2, r1, 0, lgat, 0)
> +/* LOAD AND ZERO RIGHTMOST BYTE */
> +    C(0xe3eb, LZRF,    RXY_a, LZRB, 0, m2_32u, new, r1_32, lzrb, 0)
> +    C(0xe32a, LZRG,    RXY_a, LZRB, 0, m2_64, r1, 0, lzrb, 0)
> +    C(0xe33a, LLZRGF,  RXY_a, LZRB, 0, m2_32u, r1, 0, lzrb, 0)

Small nitpick, LLZRGF is considered a separate instruction in the PoO,
called LOAD LOGICAL AND ZERO RIGHTMOST BYTE.

That said:

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
