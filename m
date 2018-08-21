Received: from eggs.gnu.org ([2001:4830:134:3::10]:53682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fsEOV-0002w5-PN
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 17:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fsEET-00043f-BG
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 17:30:38 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:42307)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fsEEP-00042O-Gm
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 17:30:31 -0400
Date: Tue, 21 Aug 2018 17:30:23 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180821213023.GA29425@flamenco>
References: <20180821142704.18783-1-richard.henderson@linaro.org>
	<20180821142704.18783-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821142704.18783-2-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/5] tcg: Split CONFIG_ATOMIC128
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Tue, Aug 21, 2018 at 07:27:00 -0700, Richard Henderson wrote:
(snip)
> +++ b/accel/tcg/atomic_template.h
(snip)
> +#else
> +/* Fallback definitions that must be optimized away, or error.  */
> +Int128 __attribute__((error("unsupported atomic")))
> +    atomic16_read(Int128 *ptr);
> +Int128 __attribute__((error("unsupported atomic")))
> +    atomic16_set(Int128 *ptr, Int128 val);

void return type.

Other than that,

Reviewed-by: Emilio G. Cota <cota@braap.org>
