Received: from eggs.gnu.org ([2001:4830:134:3::10]:48438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDoLg-0003kz-UF
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDoLc-00089I-00
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:46:56 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fDoLb-00088I-7r
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:46:51 -0400
Received: by mail-wr0-x243.google.com with SMTP id f2-v6so1478593wrm.3
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 02:46:50 -0700 (PDT)
References: <20180501180455.11214-1-richard.henderson@linaro.org>
	<20180501180455.11214-2-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180501180455.11214-2-richard.henderson@linaro.org>
Date: Wed, 02 May 2018 10:46:47 +0100
Message-ID: <87a7ti9ypk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/2] target/arm: Tidy conditions
 in handle_vec_simd_shri
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> The (size > 3 && !is_q) condition is identical to the preceeding test
> of bit 3 in immh; eliminate it.  For the benefit of Coverity, assert
> that size is within the bounds we expect.
>
> Fixes: Coverity CID1385846
> Fixes: Coverity CID1385849
> Fixes: Coverity CID1385852
> Fixes: Coverity CID1385857
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/translate-a64.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index bff4e13bf6..97950dce1a 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -9019,11 +9019,7 @@ static void handle_vec_simd_shri(DisasContext *s, =
bool is_q, bool is_u,
>          unallocated_encoding(s);
>          return;
>      }
> -
> -    if (size > 3 && !is_q) {
> -        unallocated_encoding(s);
> -        return;
> -    }
> +    tcg_debug_assert(size <=3D 3);
>
>      if (!fp_access_check(s)) {
>          return;


--
Alex Benn=C3=A9e
