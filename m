Received: from eggs.gnu.org ([2001:4830:134:3::10]:43275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dLbhZ-0008VD-Nk
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 16:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dLbhY-00075q-M1
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 16:49:13 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:57320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dLbhY-00075O-FG
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 16:49:12 -0400
Date: Thu, 15 Jun 2017 22:49:08 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170615204908.3izswcs4q6l34wrg@aurel32.net>
References: <20170615055356.20684-1-rth@twiddle.net>
	<20170615055356.20684-6-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170615055356.20684-6-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 5/5] target/s390x: mark CSST, CSST2,
 FPSEH facilities as available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, david@redhat.com

On 2017-06-14 22:53, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/cpu_models.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index c3a4ce6..703feca 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -683,8 +683,11 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
>          S390_FEAT_ETF2_ENH,
>          S390_FEAT_STORE_CLOCK_FAST,
>          S390_FEAT_MOVE_WITH_OPTIONAL_SPEC,
> +        S390_FEAT_COMPARE_AND_SWAP_AND_STORE,
> +        S390_FEAT_COMPARE_AND_SWAP_AND_STORE_2,
>          S390_FEAT_GENERAL_INSTRUCTIONS_EXT,
>          S390_FEAT_EXECUTE_EXT,
> +        S390_FEAT_FLOATING_POINT_SUPPPORT_ENH,

Theoretically the floating-point-support-enhancement facilities include
the DFP rounding facility. Given We don't implement the DFP facility I
guess this can be ignored.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
