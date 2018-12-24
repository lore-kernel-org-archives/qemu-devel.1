Received: from eggs.gnu.org ([208.118.235.92]:60545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gbYQJ-0007Qx-29
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 17:10:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gbYQE-000148-Az
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 17:10:07 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33497)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gbYQE-00013p-3T
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 17:10:02 -0500
Date: Mon, 24 Dec 2018 17:10:00 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181224221000.GB21289@flamenco>
References: <20181126230450.672-1-richard.henderson@linaro.org>
	<20181126230450.672-5-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126230450.672-5-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 4/4] tcg: Add reachable_code_pass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On Mon, Nov 26, 2018 at 15:04:50 -0800, Richard Henderson wrote:
> Delete trivially dead code that follows unconditional branches and
> noreturn helpers.  These can occur either via optimization or via
> the structure of a target's translator following an exception.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
(snip)
> +                /*
> +                 * Optimization can fold conditional branches to unconditional.
> +                 * If we find a label with one reference which is preceeded by

s/preceeded/preceded/

Reviewed-by: Emilio G. Cota <cota@braap.org>

for the series.

Thanks,

		E.
