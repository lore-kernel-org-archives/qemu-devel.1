Received: from eggs.gnu.org ([2001:4830:134:3::10]:44239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g80kC-0005vX-TO
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 06:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g80gW-00006V-KH
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 06:16:47 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:33202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g80gW-0008WC-6x
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 06:16:44 -0400
Received: by mail-wr1-x42a.google.com with SMTP id e4-v6so9300980wrs.0
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 03:16:44 -0700 (PDT)
References: <20181003200454.18384-1-cota@braap.org>
	<20181003200454.18384-3-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181003200454.18384-3-cota@braap.org>
Date: Thu, 04 Oct 2018 11:16:41 +0100
Message-ID: <87zhvuqanq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/4] cputlb: fix assert_cpu_is_self macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


Emilio G. Cota <cota@braap.org> writes:

> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/cputlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 502eea2850..f6b388c961 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -58,9 +58,9 @@
>      } \
>  } while (0)
>
> -#define assert_cpu_is_self(this_cpu) do {                         \
> +#define assert_cpu_is_self(cpu) do {                              \
>          if (DEBUG_TLB_GATE) {                                     \
> -            g_assert(!cpu->created || qemu_cpu_is_self(cpu));     \
> +            g_assert(!(cpu)->created || qemu_cpu_is_self(cpu));   \
>          }                                                         \
>      } while (0)


--
Alex Benn=C3=A9e
