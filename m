Received: from eggs.gnu.org ([2001:4830:134:3::10]:59430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dqFch-000121-8x
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dqFcc-0004BM-Cz
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:30:51 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:46666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dqFcc-0004AN-4w
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:30:46 -0400
Received: by mail-wm0-x236.google.com with SMTP id i189so1292741wmf.1
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 02:30:46 -0700 (PDT)
References: <20170817230114.3655-1-richard.henderson@linaro.org>
	<20170817230114.3655-7-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170817230114.3655-7-richard.henderson@linaro.org>
Date: Fri, 08 Sep 2017 10:30:43 +0100
Message-ID: <8760ctilks.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 6/8] tcg: Add INDEX_op_invalid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Add with value 0 so that structure zero initialization can
> indicate that the field is not present.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tcg/tcg-opc.h | 2 ++
>  tcg/tcg.c     | 3 +++
>  2 files changed, 5 insertions(+)
>
> diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
> index 9162125fac..b1445a4c24 100644
> --- a/tcg/tcg-opc.h
> +++ b/tcg/tcg-opc.h
> @@ -26,6 +26,8 @@
>   * DEF(name, oargs, iargs, cargs, flags)
>   */
>
> +DEF(invalid, 0, 0, 0, TCG_OPF_NOT_PRESENT)
> +
>  /* predefined ops */
>  DEF(discard, 1, 0, 0, TCG_OPF_NOT_PRESENT)
>  DEF(set_label, 0, 0, 1, TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 3c3cdda938..879b29e81f 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -756,6 +756,9 @@ int tcg_check_temp_count(void)
>  bool tcg_op_supported(TCGOpcode op)
>  {
>      switch (op) {
> +    case INDEX_op_invalid:
> +        return false;
> +
>      case INDEX_op_discard:
>      case INDEX_op_set_label:
>      case INDEX_op_call:


--
Alex Bennée
