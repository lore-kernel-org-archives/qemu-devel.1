Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AB0C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D027F206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o9GPxVwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D027F206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY5sb-00023s-1I
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 06:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jY5rp-0001RB-3k
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:41:01 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jY5rn-0007kT-Q5
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:41:00 -0400
Received: by mail-wr1-x444.google.com with SMTP id l18so10279475wrn.6
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 03:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=KmOMb/w+y5ybGjEyAVlLVMagRkwkjCh19DohBQ5tKEg=;
 b=o9GPxVwZDyfgUlqqyUV6DDmAdUF4wbuOjCJ8ylUOmWx53QB5eE1YEpQv3urP/M7367
 2nVdJDqI6oWQM8qZvYuZh9xxotf0z0q1HIQfrjJPgWZX/LkspEajXion4DB6XOsKmAB+
 ODIAsBu/Sk4ycLMoF6sKpcRH83eg+qVpwe5ZQxZLPzu1CPe0lQtSUbehraJJYJBgPafA
 15wRwJ07A+y6W4w2afDdQEkOyWFzIE0LxvidSnxKMj6FLGjFi0F0Rc6tMm3B4PXLbTsF
 8go/ofuP80FAFa8YmOSTADLmSvZEGEKT4PZWXgi6KBpjfJYFdT1A/xCSz8qx2rT5JItW
 tkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=KmOMb/w+y5ybGjEyAVlLVMagRkwkjCh19DohBQ5tKEg=;
 b=E6wtoJeWQz3STszngyyC5sSbujA3H+1PTZ0cHd1UENWm/NbhpU6dnCZqLpBJOhyBO/
 yaH0vupreHWEpc5GLThi5yjHGnjEeVQaFWuTG4DmRrJ1MAolBUGPnSM4aBYdwSLnZvgo
 U9m3b9+F3BIAijwMwT3TDIlDJb/A0GswqOvWCBZr+MhjDIbMcOF07izBBuEiXw6l1YDf
 W0Vlo+y/BK+KGP60AaHMUWW3FzbKl2oAZKxZK51qT0y7PrHHiHf5wef0eExV6WmipsVf
 pGEZLwHzU4CeEcR3qp5g36EFoaMFi0o0jikhokinHqrOwQ6aRxsoX7xE6e3R8WyO4ifL
 qMqA==
X-Gm-Message-State: AGi0PuajzwkiE5zO5Z1Irwsw9bkV4AvllKu6rqDU29JErom/T+akitqY
 bGKs8bYiWgs/D5bFhPHx4KXQAw==
X-Google-Smtp-Source: APiQypJNSctQwIIDHrofXULxAQnPv5OrNo1fPWOBhRURc5eNnviTCmZYrQ1KhRrwNgYwdTdGzrFHdQ==
X-Received: by 2002:adf:94c2:: with SMTP id 60mr4418291wrr.366.1589193658138; 
 Mon, 11 May 2020 03:40:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o2sm19127902wmc.21.2020.05.11.03.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:40:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 236E31FF7E;
 Mon, 11 May 2020 11:40:56 +0100 (BST)
References: <20200326193156.4322-1-robert.foley@linaro.org>
 <20200326193156.4322-26-robert.foley@linaro.org>
User-agent: mu4e 1.4.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v8 25/74] riscv: convert to cpu_halted
In-reply-to: <20200326193156.4322-26-robert.foley@linaro.org>
Date: Mon, 11 May 2020 11:40:56 +0100
Message-ID: <87wo5ig3ev.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 richard.henderson@linaro.org, qemu-devel@nongnu.org,
 "Emilio G. Cota" <cota@braap.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair23@gmail.com>, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> From: "Emilio G. Cota" <cota@braap.org>
>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Alistair Francis <alistair23@gmail.com>
> Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>

You can drop Cc: lines fron patches once you have an a-b or r-b tag from
the person in question. They are basically a formalised way of saying "I
have tried to contact the maintainer/relevant party" and memorialising
it in the patches. The effect of Cc, r-b and a-b tags in the patch is
all pretty much the same in that people get Cc'ed anyway - on top of
what get_maintainers.pl will add as well!

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  target/riscv/op_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index c6412f680c..91f8833c2e 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -182,7 +182,7 @@ void helper_wfi(CPURISCVState *env)
>          riscv_cpu_virt_enabled(env)) {
>          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      } else {
> -        cs->halted =3D 1;
> +        cpu_halted_set(cs, 1);
>          cs->exception_index =3D EXCP_HLT;
>          cpu_loop_exit(cs);
>      }


--=20
Alex Benn=C3=A9e

