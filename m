Received: from eggs.gnu.org ([2001:4830:134:3::10]:48653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHQ3A-0002Mb-NC
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:06:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHQ37-0002vK-Gr
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:06:28 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:46343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eHQ37-0002ut-9C
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:06:25 -0500
Received: by mail-wm0-x230.google.com with SMTP id u83so8355850wmb.5
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 00:06:25 -0800 (PST)
References: <20171109144155.17076-1-batuzovk@ispras.ru>
	<20171109144155.17076-4-batuzovk@ispras.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c4be5f68-2093-db46-c917-953578a22d46@linaro.org>
Date: Wed, 22 Nov 2017 09:06:20 +0100
MIME-Version: 1.0
In-Reply-To: <20171109144155.17076-4-batuzovk@ispras.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 3/3] tcg/optimize: handle vector loads
 and stores during copy propagation
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
> +                    } else if (re == INDEX_op_mov_vec) {
> +                        if (ts_are_copies(arg_temp(op->args[0]), ml->copy)) {
> +                            tcg_op_remove(s, op);
> +                            break;
> +                        }
> +                        op->opc = re;
> +                        op->args[1] = temp_arg(find_better_copy(s, ml->copy));
> +                        op->args[2] = op->args[3];
>                      } else {

Why don't you send this through tcg_opt_gen_mov as with mov_i32 and mov_i64?


r~
