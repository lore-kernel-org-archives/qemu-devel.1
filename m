Received: from eggs.gnu.org ([2001:4830:134:3::10]:49137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1UcJ-0001SN-Vf
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1UcF-0007mB-Hs
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:17:11 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f1UcF-0007lt-BI
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:17:07 -0400
Received: by mail-wm0-x242.google.com with SMTP id o23so17894267wmf.0
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 03:17:07 -0700 (PDT)
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-8-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1519709965-29833-8-git-send-email-cota@braap.org>
Date: Thu, 29 Mar 2018 11:17:04 +0100
Message-ID: <87vadf6va7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/16] translate-all: remove hole in
 PageDesc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> Groundwork for supporting parallel TCG generation.
>
> Move the hole to the end of the struct, so that a u32
> field can be added there without bloating the struct.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/translate-all.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index f2bfa71..816419a 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -107,8 +107,8 @@ typedef struct PageDesc {
>  #ifdef CONFIG_SOFTMMU
>      /* in order to optimize self modifying code, we count the number
>         of lookups we do to a given page to use a bitmap */
> -    unsigned int code_write_count;
>      unsigned long *code_bitmap;
> +    unsigned int code_write_count;
>  #else
>      unsigned long flags;
>  #endif


--
Alex Benn=C3=A9e
