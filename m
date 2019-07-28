Return-Path: <SRS0=P1lm=VZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4EDC7618B
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 10:11:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 592812075B
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 10:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j7qvabY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592812075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrg9J-0005St-Dv
	for qemu-devel@archiver.kernel.org; Sun, 28 Jul 2019 06:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51189)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hrg8v-00053D-JU
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 06:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hrg8u-0007SZ-GE
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 06:11:05 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:37864)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hrg8u-0007Qt-7f
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 06:11:04 -0400
Received: by mail-wr1-x42b.google.com with SMTP id n9so33597145wrr.4
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2019 03:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:subject:in-reply-to:date:message-id
 :mime-version:content-transfer-encoding;
 bh=EgUjYMA3G/i/4aEaa2hC3U9rQKxp5Fsj28//K19qHxg=;
 b=j7qvabY2KUmN3+QGxN+pc0a912WiCbHQThUqmX53LCQz+bu7P677SeQqXoxr9z8WkG
 nrFm35pi47+tVlZAmgnfYADTQlmn73tCZKz6hUemclm3Ggg0Pv+FzA/wSPCP2+dIqoUm
 Oiha8m5JG8AlFE4/LTkUl9CCVYYZRUVjGM6OeQXaOu0c2B/voBAetaHJttPAC3dXsETa
 1OGFGdTOpLb+l6w/nh5zc2HtP/T4T9A+jgFDpeviYOKPsslgprGfJGPwgqooSxvu/AGr
 q/pq254KBO70mtJsYAqC6RaNZ/LVTUev6I+2BYUlyFyI4zuBJpunr5B6V1+k6iZB3hCK
 csUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=EgUjYMA3G/i/4aEaa2hC3U9rQKxp5Fsj28//K19qHxg=;
 b=Pe9NW8q7FzK6tzbzZxdZ+HUH1ZcevHVsR+FF1mvXYqK0x7RUyngCd471T5vYM5oFeW
 sYnyudO7fgqxQvpdjJt3LN4w3wLF1vd2EMvA7DlEYfTKILAvVqZSM9V1u61PIYH31CK0
 5DGI9yeHBYLGn+Xz8rniYNNQHPI6uF6HyFUqYlKSC9kTBpbGLMdxXE8Atwp0MTfT6Iby
 UrQF5GGthKcput/JLQwSe7Ap+LKiUpDtvjr31/aztn92hrTOHeOX7RqssZO3gSyz8Tyz
 UwK5Z3506jfEEGPvWajJ4FjfF0wWICZvrMVKl1r+VoymwaLCx7G7TpJ05P2PsxXQkI7I
 FdpQ==
X-Gm-Message-State: APjAAAVaCxPFox0cO+L84vei4hB2pW7Sk8V4QhOxsCcfVS6FrO1yjrRv
 YkxDzx6RdZGq07Rar9V/e5GR1KTAWog=
X-Google-Smtp-Source: APXvYqzmqczWASs32EMk8inB54qHde27MoPmjOcZkdtorxouSEZI92H+9CLUSxSx0uoAIthbm6BScg==
X-Received: by 2002:adf:de8b:: with SMTP id w11mr35857953wrl.134.1564308661989; 
 Sun, 28 Jul 2019 03:11:01 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id b8sm75689647wmh.46.2019.07.28.03.11.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 28 Jul 2019 03:11:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 184841FF87
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2019 11:11:01 +0100 (BST)
References: <CABqzqi5n9Sz4H+wc7yJSQz+tzOf8zr8=9H+KkgSoNv8wf=04WA@mail.gmail.com>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <CABqzqi5n9Sz4H+wc7yJSQz+tzOf8zr8=9H+KkgSoNv8wf=04WA@mail.gmail.com>
Date: Sun, 28 Jul 2019 11:11:01 +0100
Message-ID: <87k1c2cvuy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
Subject: Re: [Qemu-devel] Question regarding tcg trace-events
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


sainath grandhi <saiallforums@gmail.com> writes:

> Hello
> I am working with qemu tracing support and combined with tcg.
> I read that if tcg property is used for trace-event, it generates a
> trace-event once during translation and another trace-event after the
> execution.
>
> I made the following change in target/i386/translate.c
>
> -static inline void gen_op_movl_seg_T0_vm(DisasContext *s, int seg_reg)
> +static inline void gen_op_movl_seg_T0_vm(DisasContext *s, int
> seg_reg, CPUX86State *env)
>  {
>      tcg_gen_ext16u_tl(s->T0, s->T0);
>      tcg_gen_st32_tl(s->T0, cpu_env,
>                      offsetof(CPUX86State,segs[seg_reg].selector));
> +    trace_seg_write_tcg(tcg_ctx->cpu, cpu_env, env->eip, seg_reg,
> env->segs[seg_reg].selector, s->T0);

This is a new trace point you've added?

>      tcg_gen_shli_tl(cpu_seg_base[seg_reg], s->T0, 4);
>
> I see seg_write_trans and seg_write_exec trace-events.
> Question I have is the following:
> I expect one seg_write_trans trace-event per seg_write_exec
> trace-event. However I notice more than one seg_write_exec
> trace-events after a seg_write_trans

If a translated block is executed more than once (most are) you should
see more exec events than trans events.

> and in some cases seg_write_exec
> trace-events occur without a seg_write_trans.

That is odd.

> Why do this happen? Does this have something to do with TCG and TBs?

In TCG an execution block (TranslationBlock) is:

  - translated into TCgops
  - generated into host code
  - added to the code cache

from this point each time we need to execute something with the same
parameters (pc/flags) we fetch the already translated code and execute
it directly. There are more pointers to how the TCG works on the wiki.

--
Alex Benn=C3=A9e

