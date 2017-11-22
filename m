Received: from eggs.gnu.org ([2001:4830:134:3::10]:47234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHPzG-0001Y1-Gt
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:02:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHPyh-0000ez-Cq
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:02:26 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:41869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eHPyh-0000e0-4Q
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:01:51 -0500
Received: by mail-wm0-x244.google.com with SMTP id b189so8298040wmd.0
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 00:01:50 -0800 (PST)
References: <20171109144155.17076-1-batuzovk@ispras.ru>
	<20171109144155.17076-2-batuzovk@ispras.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <806653ba-9011-bd92-d619-ce480237a415@linaro.org>
Date: Wed, 22 Nov 2017 09:01:46 +0100
MIME-Version: 1.0
In-Reply-To: <20171109144155.17076-2-batuzovk@ispras.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 1/3] tcg: support MOV_VEC and MOVI_VEC
 opcodes in register allocator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirill Batuzov <batuzovk@ispras.ru>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 11/09/2017 03:41 PM, Kirill Batuzov wrote:
> Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
> ---
>  tcg/tcg.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index a7854a59a1..6db7dd526a 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -3327,10 +3327,12 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
>          switch (opc) {
>          case INDEX_op_mov_i32:
>          case INDEX_op_mov_i64:
> +        case INDEX_op_mov_vec:
>              tcg_reg_alloc_mov(s, op);
>              break;
>          case INDEX_op_movi_i32:
>          case INDEX_op_movi_i64:
> +        case INDEX_op_movi_vec:
>              tcg_reg_alloc_movi(s, op);
>              break;
>          case INDEX_op_insn_start:
> 

Thanks.  I'd actually missed out on this myself until quite late in v6, which
caused a number of interesting problems.


r~
