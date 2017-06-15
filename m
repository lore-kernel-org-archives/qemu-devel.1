Received: from eggs.gnu.org ([2001:4830:134:3::10]:43950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLQfX-0002cw-7P
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 05:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLQfS-0006SM-Bk
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 05:02:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dLQfS-0006Ru-5i
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 05:02:18 -0400
References: <20170615055356.20684-1-rth@twiddle.net>
	<20170615055356.20684-6-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8799c130-96d1-b9c0-5cee-dd1c81047273@redhat.com>
Date: Thu, 15 Jun 2017 11:02:11 +0200
MIME-Version: 1.0
In-Reply-To: <20170615055356.20684-6-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, david@redhat.com

On 15.06.2017 07:53, Richard Henderson wrote:
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

Do we really support the CSST instruction in TCG already (Opcode
0xc802)? I did not spot it in the source code yet...?

 Thomas
