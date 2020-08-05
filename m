Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1306AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:40:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0EF522BF3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G/UU5vdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EF522BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3EyO-0003en-3W
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 04:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3ExW-0002mq-CK
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:39:38 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:38781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3ExT-0007VM-Si
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:39:37 -0400
Received: by mail-wm1-x334.google.com with SMTP id t14so5474670wmi.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 01:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=xe1k233ApD8d6nMoBhc3DkyMmYn711JgFc93nVFkxSs=;
 b=G/UU5vdRu3BHTzNdyUz0Wl08v10hal+81QdG3rfnNbQ0m1H6OmBFyVIZggOsx/RuA+
 2W9/SM9QzH4wXwNfaDc7mGfOhsulPjjVMNXFOKNNnJSB3eR84zEEC1r/CIbRN7n6LylB
 Zeq4A05Xs+joyKSjlj8QDMPx6cJ2jKBIbiV0VqQ40VVD/Zh8iWWWtU9NBM/ZL9Mq/2fV
 f71IZQmOlNUYB4BoAXcn6oxGm1pfaUk4puGGZIcdxH6uUoNVh8vwUbeD3wFVIFpFMUvi
 MuYSboXBRP/Qw+jSn6qWohHRMsNFSZaGZtnj5pmg9KjXH8r/irg/X+X7erpvHIzOJZCX
 tWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=xe1k233ApD8d6nMoBhc3DkyMmYn711JgFc93nVFkxSs=;
 b=j6XM4yL9270OrtdaODxWR6cIN6BE7rP8WtktPHXOi2PYkzUa8Ox3ZmB4FTsloWOA/C
 wB2z7cfxtD06T8Tiu14ahLZdUon5yOeHHMQwok6woCvDHjLg4/FF2G09vK+aJq5nP0vs
 Zzl66T7VHW45ppqDRhHS5vW9Nxk4l+xjAzQuOeINoGOEeRE2HXTp38Bd/1gSGH9W2VT9
 W52RNqDA0cA+lAJck4F+NPoyiraS6jNqfJ+AWgjiHG6T40esviWrAshgWawba92rERGn
 0SnrUdU1tZ2RJZc1BqqdrbHfXJi1biGapsIpOhW1vNPd1z6CWSbpvvNx2bcPPtAnFIxL
 858A==
X-Gm-Message-State: AOAM533UWqQnRi9737Z67OIVmSw5pIi1DLCct/RZrNE0och0TJiZWrBE
 onw8mkiakDOhbFtreLoxxwIW+A==
X-Google-Smtp-Source: ABdhPJwm0wEGnkrcy0YqOgb1YzhkEgQ/PsIbAb8Gefe5VNEaYVNv2zVHtbTQlyxSwcXmUe5lpXPcTg==
X-Received: by 2002:a1c:b487:: with SMTP id d129mr2388667wmf.185.1596616773073; 
 Wed, 05 Aug 2020 01:39:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p3sm1753579wma.44.2020.08.05.01.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 01:39:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0006E1FF7E;
 Wed,  5 Aug 2020 09:39:28 +0100 (BST)
References: <tencent_61ECB8BB3639D7BF2284FBDC@qq.com>
 <tencent_3C5D583315945B14647C946B@qq.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: lrwei <lrwei@bupt.edu.cn>
Subject: Re: Question on implementation detail of `temp_sync`
In-reply-to: <tencent_3C5D583315945B14647C946B@qq.com>
Date: Wed, 05 Aug 2020 09:39:28 +0100
Message-ID: <874kphmqpr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


lrwei <lrwei@bupt.edu.cn> writes:

> Sorry for the unintentional sending of an uncompleted message.

Questions about the internals of the TCG are very much in the remit of
qemu-devel so are likely to get missed on qemu-discuss which is more
aimed at user questions.

>
<re-pasted to fix html noise>

> I understands that the current code works, but gets confused on why `ts` =
needs to be loaded in to a register when `free_or_dead` is not
> set.

It isn't, the break leaves the switch statement once it stores the
constant to memory.

> For example in the following scenario:
> movi_i32    r0, 0x1
> add_i32      r1, r1, r0
> ...
> (where r0 is not used any more, and both r0 and r1 are globals)

> If I am not mistaken, the code gen procedure of the first IR will call `t=
emp_sync` with `free_or_dead` not set, which load the constant in to
> a register and store it back to memory. At this time, `r0` will be `TEMP_=
VAL_REG` instead of `TEMP_VAL_CONST`, so the following IR can't
> embed this constant operand in the assembly instruction it produces. Also=
, this results in a seemingly useless register allocation (, why
> don't the further use of r0 use the constant directly?)

Is this what you are actually seeing generated? If you run with -d
in_asm,op,op_opt,out_asm it should be clear what actually happened.

> So I wonder whether there is any reason for this loading a constant into =
register, I'll be very appreciated if someone can point out the
> reason for me.

<snip>
>
>
> Thanks in advance.
> lrwei&nbsp;=20
> &nbsp;
> ------------------&nbsp;Original&nbsp;------------------
> From: &nbsp;"lrwei"<lrwei@bupt.edu.cn&gt;;
> Date: &nbsp;Tue, Aug 4, 2020 12:06 PM
> To: &nbsp;"qemu-discuss"<qemu-discuss@nongnu.org&gt;;=20
> Subject: &nbsp;Question on implementation detail of `temp_sync`
>
<re-pasted fixing html noise>

> Hello to the list,
> Recently I have been studying the code of TCG, and get confused by the fo=
llowing detail in function `temp_sync` in tcg/tcg.c:

>     case TEMP_VAL_CONST:
>         /* If we're going to free the temp immediately, then we won't
>            require it later in a register, so attempt to store the
>            constant to memory directly.  */
>         if (free_or_dead
>            && tcg_out_sti(s, ts->type, ts->val,
>                            ts->mem_base->reg, ts->mem_offset)) {
>            break;
>         }
>         temp_load(s, ts, tcg_target_available_regs[ts->type],
>                   allocated_regs, preferred_regs);
>         /* fallthrough */

> movi_i32

> Would it be better to remove the `free_or_dead` in the if statement, i.e.=
 turn the function to be:

>     case TEMP_VAL_CONST:
>         if (tcg_out_sti(s, ts->type, ts->val,
>                            ts->mem_base->reg, ts->mem_offset)) {
>            break;
>         }
>         temp_load(s, ts, tcg_target_available_regs[ts->type],
>                   allocated_regs, preferred_regs);
>         /* fallthrough */


--=20
Alex Benn=C3=A9e

