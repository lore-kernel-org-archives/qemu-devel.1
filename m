Received: from eggs.gnu.org ([2001:4830:134:3::10]:37715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4bHE-0000x3-0V
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 19:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4bH9-0000Ku-8B
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 19:28:00 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49263)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e4bH9-0000KL-1G
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 19:27:55 -0400
Date: Tue, 17 Oct 2017 19:27:53 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171017232753.GS1345@flamenco>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-20-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016172609.23422-20-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 19/50] target/alpha: Avoid
 translate_init unless tcg_enabled
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

On Mon, Oct 16, 2017 at 10:25:38 -0700, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/alpha/cpu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> index b8a21f4e01..b52ebd7356 100644
> --- a/target/alpha/cpu.c
> +++ b/target/alpha/cpu.c
> @@ -260,7 +260,9 @@ static void alpha_cpu_initfn(Object *obj)
>      cs->env_ptr = env;
>      tlb_flush(cs);
>  
> -    alpha_translate_init();
> +    if (tcg_enabled()) {
> +        alpha_translate_init();
> +    }

This change is undone/superseded by the next patch (patch 20).

I'd just drop it.

		E.
