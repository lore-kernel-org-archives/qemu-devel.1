Received: from eggs.gnu.org ([2001:4830:134:3::10]:52925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eddkJ-0000TU-9v
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:10:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eddkG-0007yh-4q
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:10:51 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:39949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eddkF-0007xT-U9
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:10:48 -0500
Received: by mail-wr0-x244.google.com with SMTP id 100so9026669wrb.7
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 07:10:47 -0800 (PST)
References: <20180119045438.28582-1-richard.henderson@linaro.org>
	<20180119045438.28582-16-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180119045438.28582-16-richard.henderson@linaro.org>
Date: Mon, 22 Jan 2018 15:10:45 +0000
Message-ID: <87mv16j5e2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 15/16] target/arm: Simplify
 fp_exception_el for user-only
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


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index c0e5f321c5..44814af99b 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11707,6 +11707,7 @@ uint32_t HELPER(crc32c)(uint32_t acc, uint32_t va=
l, uint32_t bytes)
>   */
>  static inline int fp_exception_el(CPUARMState *env)
>  {
> +#ifndef CONFIG_USER_ONLY
>      int fpen;
>      int cur_el =3D arm_current_el(env);
>
> @@ -11763,7 +11764,7 @@ static inline int fp_exception_el(CPUARMState *en=
v)
>          /* Trap all FP ops to EL3 */
>          return 3;
>      }
> -
> +#endif
>      return 0;
>  }


--
Alex Benn=C3=A9e
