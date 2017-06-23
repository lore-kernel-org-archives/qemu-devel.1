Received: from eggs.gnu.org ([2001:4830:134:3::10]:49253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dOQth-0008OF-MA
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dOQtg-0002qT-HA
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:53:25 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:38064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dOQtg-0002oV-Ay
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:53:24 -0400
Date: Fri, 23 Jun 2017 17:53:17 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170623155317.ccdiobaonssmmmok@aurel32.net>
References: <20170620000405.3391-1-rth@twiddle.net>
	<20170620000405.3391-18-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620000405.3391-18-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 17/18] target/s390x: Mark ETF3 and
 ETF3_ENH facilities as available
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

On 2017-06-19 17:04, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/cpu_models.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index be7757c..16129f6 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -678,11 +678,13 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
>          S390_FEAT_STFLE,
>          S390_FEAT_EXTENDED_IMMEDIATE,
>          S390_FEAT_EXTENDED_TRANSLATION_2,
> +        S390_FEAT_EXTENDED_TRANSLATION_3,
>          S390_FEAT_LONG_DISPLACEMENT,
>          S390_FEAT_LONG_DISPLACEMENT_FAST,
>          S390_FEAT_ETF2_ENH,
>          S390_FEAT_STORE_CLOCK_FAST,
>          S390_FEAT_MOVE_WITH_OPTIONAL_SPEC,
> +        S390_FEAT_ETF3_ENH,
>          S390_FEAT_COMPARE_AND_SWAP_AND_STORE,
>          S390_FEAT_COMPARE_AND_SWAP_AND_STORE_2,
>          S390_FEAT_GENERAL_INSTRUCTIONS_EXT,

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
