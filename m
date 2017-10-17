Received: from eggs.gnu.org ([2001:4830:134:3::10]:34396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4aA6-0000Lp-4c
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 18:16:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4aA2-0001Ge-VJ
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 18:16:34 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41387)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e4aA2-0001Fe-QG
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 18:16:30 -0400
Date: Tue, 17 Oct 2017 18:16:29 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171017221629.GN1345@flamenco>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-15-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016172609.23422-15-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 14/50] tcg: Use per-temp state data in
 optimize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Mon, Oct 16, 2017 at 10:25:33 -0700, Richard Henderson wrote:
> From: Richard Henderson <rth@twiddle.net>
> 
> While we're touching many of the lines anyway, adjust the naming
> of the functions to better distinguish when "TCGArg" vs "TCGTemp"
> should be used.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
(snip)
> -static struct tcg_temp_info temps[TCG_MAX_TEMPS];
> +static struct tcg_temp_info temps_[TCG_MAX_TEMPS];

Is this rename really necessary?

The rest looks good:

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
