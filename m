Received: from eggs.gnu.org ([2001:4830:134:3::10]:39830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e249F-0006zr-B8
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 19:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e249C-0001VC-M0
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 19:41:17 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54975)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e249C-0001Uw-Fb
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 19:41:14 -0400
Date: Tue, 10 Oct 2017 19:41:10 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171010234110.GA6467@flamenco>
References: <20171010214540.30970-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171010214540.30970-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] tcg: Initialize cpu_env generically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On Tue, Oct 10, 2017 at 14:45:40 -0700, Richard Henderson wrote:
> This is identical for each target.  So, move the initialization to
> common code.  Move the variable itself out of tcg_ctx and name it
> cpu_env to minimize changes within targets.
> 
> This also means we can remove tcg_global_reg_new_{ptr,i32,i64},
> since there are no longer global-register temps created by targets.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
