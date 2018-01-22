Received: from eggs.gnu.org ([2001:4830:134:3::10]:59245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edZsG-0002dQ-6X
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edZsD-0006Av-33
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:02:48 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1edZsC-0006AC-TQ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:02:45 -0500
Received: by mail-wm0-x244.google.com with SMTP id f3so15966410wmc.1
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 03:02:44 -0800 (PST)
References: <20180119045438.28582-1-richard.henderson@linaro.org>
	<20180119045438.28582-8-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180119045438.28582-8-richard.henderson@linaro.org>
Date: Mon, 22 Jan 2018 11:02:42 +0000
Message-ID: <87y3kqjgvh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/16] vmstate: Add
 VMSTATE_UINT64_SUB_ARRAY
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

> At the same time, move VMSTATE_UINT32_SUB_ARRAY
> beside the other UINT32 definitions.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/migration/vmstate.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 88b55df5ae..8c3889433c 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -905,6 +905,9 @@ extern const VMStateInfo vmstate_info_qtailq;
>  #define VMSTATE_UINT32_ARRAY(_f, _s, _n)                              \
>      VMSTATE_UINT32_ARRAY_V(_f, _s, _n, 0)
>
> +#define VMSTATE_UINT32_SUB_ARRAY(_f, _s, _start, _num)                \
> +    VMSTATE_SUB_ARRAY(_f, _s, _start, _num, 0, vmstate_info_uint32, uint=
32_t)
> +
>  #define VMSTATE_UINT32_2DARRAY(_f, _s, _n1, _n2)                      \
>      VMSTATE_UINT32_2DARRAY_V(_f, _s, _n1, _n2, 0)
>
> @@ -914,6 +917,9 @@ extern const VMStateInfo vmstate_info_qtailq;
>  #define VMSTATE_UINT64_ARRAY(_f, _s, _n)                              \
>      VMSTATE_UINT64_ARRAY_V(_f, _s, _n, 0)
>
> +#define VMSTATE_UINT64_SUB_ARRAY(_f, _s, _start, _num)                \
> +    VMSTATE_SUB_ARRAY(_f, _s, _start, _num, 0, vmstate_info_uint64, uint=
64_t)
> +
>  #define VMSTATE_UINT64_2DARRAY(_f, _s, _n1, _n2)                      \
>      VMSTATE_UINT64_2DARRAY_V(_f, _s, _n1, _n2, 0)
>
> @@ -932,9 +938,6 @@ extern const VMStateInfo vmstate_info_qtailq;
>  #define VMSTATE_INT32_ARRAY(_f, _s, _n)                               \
>      VMSTATE_INT32_ARRAY_V(_f, _s, _n, 0)
>
> -#define VMSTATE_UINT32_SUB_ARRAY(_f, _s, _start, _num)                \
> -    VMSTATE_SUB_ARRAY(_f, _s, _start, _num, 0, vmstate_info_uint32, uint=
32_t)
> -
>  #define VMSTATE_INT64_ARRAY_V(_f, _s, _n, _v)                         \
>      VMSTATE_ARRAY(_f, _s, _n, _v, vmstate_info_int64, int64_t)


--
Alex Benn=C3=A9e
