Received: from eggs.gnu.org ([2001:4830:134:3::10]:46502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTlea-00026E-Kc
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:40:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTleZ-0003YL-Rr
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:40:40 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gTleZ-0003W6-LQ
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:40:39 -0500
Received: by mail-wm1-x342.google.com with SMTP id m22so5106367wml.3
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 02:40:36 -0800 (PST)
References: <20181130215221.20554-1-richard.henderson@linaro.org>
	<20181130215221.20554-13-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181130215221.20554-13-richard.henderson@linaro.org>
Date: Mon, 03 Dec 2018 10:40:34 +0000
Message-ID: <87zhtm3nbx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 12/16] tcg/i386: Return false on failure
 from patch_reloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/i386/tcg-target.inc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index 5c88f1f36b..28192f4608 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -175,7 +175,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int =
type,
>      case R_386_PC32:
>          value -=3D (uintptr_t)code_ptr;
>          if (value !=3D (int32_t)value) {
> -            tcg_abort();
> +            return false;
>          }
>          /* FALLTHRU */
>      case R_386_32:
> @@ -184,7 +184,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int =
type,
>      case R_386_PC8:
>          value -=3D (uintptr_t)code_ptr;
>          if (value !=3D (int8_t)value) {
> -            tcg_abort();
> +            return false;
>          }
>          tcg_patch8(code_ptr, value);
>          break;


--
Alex Benn=C3=A9e
