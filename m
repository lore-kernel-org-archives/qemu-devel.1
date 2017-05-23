Received: from eggs.gnu.org ([2001:4830:134:3::10]:43426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dD7jg-0006Wy-S9
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:12:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dD7jf-0002EW-VI
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:12:20 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:43304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dD7jf-0002E8-PV
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:12:19 -0400
Date: Tue, 23 May 2017 13:12:18 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170523111218.3rkdldvfgk7y2uhy@aurel32.net>
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-31-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170523030312.6360-31-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 30/31] target/s390x: Implement CSPG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On 2017-05-22 20:03, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/insn-data.def | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index 4c91f30..8604847 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -838,6 +838,7 @@
>  #ifndef CONFIG_USER_ONLY
>  /* COMPARE AND SWAP AND PURGE */
>      D(0xb250, CSP,     RRE,   Z,   r1_32u, ra2, r1_P, 0, csp, 0, MO_TEUL)
> +    D(0xb98a, CSPG,    RRE,   Z,   r1_o, ra2, r1_P, 0, csp, 0, MO_TEQ)

CSPG is part of the of the DAT-enhancement facility. I called it DAT_ENH
in my local patches to match the name we have in the CPU features.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
