Received: from eggs.gnu.org ([2001:4830:134:3::10]:38051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMupT-0004m8-Nl
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:03:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMupP-0005uV-LE
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:03:35 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:35203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gMupH-0005ma-BA
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:03:25 -0500
Received: by mail-wm1-x336.google.com with SMTP id t15-v6so14736899wmt.0
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 05:03:22 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-3-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025172057.20414-3-cota@braap.org>
Date: Wed, 14 Nov 2018 13:03:19 +0000
Message-ID: <875zwzerqg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 02/48] trace: expand mem_info:size_shift to 3
 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> This will allow us to trace 16B-long memory accesses.
>
> While at it, add some defines for the mem_info bits and simplify
> trace_mem_get_info by making it a wrapper around trace_mem_build_info.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Currently we ignore atomic operation but I assume we'll want to
represent them at some point here. I don't know if memory barrier
behaviour would also be worth exporting?

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
