Received: from eggs.gnu.org ([2001:4830:134:3::10]:46126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fLRWX-0000xW-KN
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fLRWO-0000ue-30
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:01:41 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:45094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fLRWN-0000uF-SO
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:01:32 -0400
Received: by mail-wr0-x242.google.com with SMTP id w3-v6so17959919wrl.12
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 04:01:31 -0700 (PDT)
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-23-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180521140402.23318-23-peter.maydell@linaro.org>
Date: Wed, 23 May 2018 12:01:28 +0100
Message-ID: <87wovutz3r.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 22/27] vmstate.h: Provide
 VMSTATE_BOOL_SUB_ARRAY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> Provide a VMSTATE_BOOL_SUB_ARRAY to go with VMSTATE_UINT8_SUB_ARRAY
> and friends.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/migration/vmstate.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index df463fd33d..59fc75e418 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -870,6 +870,9 @@ extern const VMStateInfo vmstate_info_qtailq;
>  #define VMSTATE_BOOL_ARRAY(_f, _s, _n)                               \
>      VMSTATE_BOOL_ARRAY_V(_f, _s, _n, 0)
>
> +#define VMSTATE_BOOL_SUB_ARRAY(_f, _s, _start, _num)                \
> +    VMSTATE_SUB_ARRAY(_f, _s, _start, _num, 0, vmstate_info_bool, bool)
> +
>  #define VMSTATE_UINT16_ARRAY_V(_f, _s, _n, _v)                         \
>      VMSTATE_ARRAY(_f, _s, _n, _v, vmstate_info_uint16, uint16_t)


--
Alex Benn=C3=A9e
