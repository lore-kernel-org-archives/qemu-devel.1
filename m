Received: from eggs.gnu.org ([2001:4830:134:3::10]:54832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbC3Z-0003tK-Jy
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 16:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbC3U-0004HE-Kl
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 16:40:21 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbC3U-0004F8-GV
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 16:40:16 -0400
Received: by mail-qk0-x242.google.com with SMTP id d136so22089615qkg.3
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 13:40:15 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170728185050.20395-1-rth@twiddle.net>
	<20170728185050.20395-3-rth@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1184ee43-2cd3-8abd-e131-75a6cf3932ac@amsat.org>
Date: Fri, 28 Jul 2017 17:40:11 -0300
MIME-Version: 1.0
In-Reply-To: <20170728185050.20395-3-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/2] target/s390x: Fix CSST for
 16-byte store
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 07/28/2017 03:50 PM, Richard Henderson wrote:
> Found by Coverity.

"Found by Coverity (CID 1378273)."

> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   target/s390x/mem_helper.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index cdc78aa3d4..c71dce4b1e 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -1580,6 +1580,7 @@ uint32_t HELPER(csst)(CPUS390XState *env, uint32_t r3, uint64_t a1, uint64_t a2)
>                   cpu_stq_data_ra(env, a2 + 0, svh, ra);
>                   cpu_stq_data_ra(env, a2 + 8, svl, ra);
>               }
> +            break;
>           default:
>               g_assert_not_reached();
>           }
> 
