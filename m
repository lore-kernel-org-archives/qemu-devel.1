Received: from eggs.gnu.org ([209.51.188.92]:49579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmgDP-0007ia-Ah
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:42:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmgDO-0001ZJ-Gj
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:42:47 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gmgDO-0001YG-Af
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:42:46 -0500
Received: by mail-wr1-x441.google.com with SMTP id z5so6720964wrt.11
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 06:42:45 -0800 (PST)
References: <20181209193749.12277-1-cota@braap.org>
	<20181209193749.12277-2-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181209193749.12277-2-cota@braap.org>
Date: Thu, 24 Jan 2019 14:42:43 +0000
Message-ID: <87sgxiyv4s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 01/38] trace: expand mem_info:size_shift
 to 3 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>


Emilio G. Cota <cota@braap.org> writes:

> This will allow us to trace 16B-long memory accesses.
>
> While at it, add some defines for the mem_info bits and simplify
> trace_mem_get_info by making it a wrapper around trace_mem_build_info.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  trace-events | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/trace-events b/trace-events
> index 4fd2cb4b97..9d65d472d2 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -151,7 +151,7 @@ vcpu guest_cpu_reset(void)
>  # Access information can be parsed as:
>  #
>  # struct mem_info {
> -#     uint8_t size_shift : 2; /* interpreted as "1 << size_shift" bytes =
*/
> +#     uint8_t size_shift : 3; /* interpreted as "1 << size_shift" bytes =
*/
>  #     bool    sign_extend: 1; /* sign-extended */
>  #     uint8_t endianness : 1; /* 0: little, 1: big */
>  #     bool    store      : 1; /* wheter it's a store operation */


--
Alex Benn=C3=A9e
