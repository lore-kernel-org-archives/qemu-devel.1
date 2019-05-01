Received: from eggs.gnu.org ([209.51.188.92]:36464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLt2r-0008D8-Sr
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLt2m-0007lS-Ip
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:29:25 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLt2j-0007a6-1I
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:29:18 -0400
Received: by mail-wr1-x441.google.com with SMTP id l2so9694912wrb.9
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 10:29:13 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	z4sm15181000wrq.75.2019.05.01.10.29.11 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 10:29:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 6ADD41FF87
	for <qemu-devel@nongnu.org>; Wed,  1 May 2019 18:29:11 +0100 (BST)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-7-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190501050536.15580-7-richard.henderson@linaro.org>
Date: Wed, 01 May 2019 18:29:11 +0100
Message-ID: <87o94m5biw.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 06/29] tcg: Return bool success from
 tcg_out_mov
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> This patch merely changes the interface, aborting on all failures,

You say this but...

<snip>
>
> -static inline void tcg_out_mov(TCGContext *s, TCGType type,
> +static inline bool tcg_out_mov(TCGContext *s, TCGType type,
>                                 TCGReg ret, TCGReg arg)
>  {
> -    tcg_out_dat_reg(s, COND_AL, ARITH_MOV, ret, 0, arg, SHIFT_IMM_LSL(0)=
);
> +    if (ret !=3D arg) {
> +        tcg_out_dat_reg(s, COND_AL, ARITH_MOV, ret, 0, arg, SHIFT_IMM_LS=
L(0));
> +    }
> +    return true;
>  }

You fix a mov folding here.. either mention in commit message or fix in
a separate commit. I appreciate the other arches already do this.

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
