Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF38C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 12:14:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A6B20656
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 12:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fyhuckd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A6B20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34606 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hShB4-0006Ei-CO
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 08:14:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hSh9g-0005O0-Nv
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hSh9f-0002No-Nk
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:12:36 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hSh9f-0002Mk-GY
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:12:35 -0400
Received: by mail-wr1-x441.google.com with SMTP id f8so7932734wrt.1
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 05:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=EiZMrWh/HV0B7chDO1x0daLn0Xc41PkqR/bETmLgSnM=;
	b=Fyhuckd9qcSiMzlJN+jYZi8uv7xqvwjRH861O5FZuOWKPQTP+ApwyYItQ1sYyhGvX/
	LAvYJSjviWc5y6aRq8qkCs2kmwFIgxZjJxOvmraWdziSzBTGQdHxGRraMAlN1FuWXYqT
	W9upWUJMp81Xi57TYAMEmQBjN7F7m80bLExWjAdONyCuYNLYPvenKARl3NH51j2fFJfd
	8QUaskE2IVg+bc9LaFExX9qTY26f99ip8bb88Zuz3jscSZfUvmVdZTx7GSGZCYI6Tr8v
	Ol1QzvkqlBa1utiJ1toyDvnMlok72kPYTegqzF5UKpOs7YMjHhZmo7ibl228Fii9jzc1
	UFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=EiZMrWh/HV0B7chDO1x0daLn0Xc41PkqR/bETmLgSnM=;
	b=p8i+IJFGg42gjzXiRK7BWWPkRjTTBw3tgjvVjCRKog6UdoFi1RzSJcfYcQkKPU8hdt
	upmfspeZnPoGKwtKLvvd1LnyZz3beAmLWfbPIYVr+ewVPPAMY68JdeA6n5SGLO6Snfqa
	Gct/HrtApCovgYBukAO3JES1QBZ+G4JpSKTx2E5qRowjvp+z6b+TSvdvQ5gezg0bOiyF
	khpnWJ9suqKJ+NiG+0lQjWf0vYwzccfZDVVMs7Gey93DXe63fhILbn1J4cyfJywpYVvM
	yqTpSPpzMBc0e0ES+woEW3+JODa6OrgwA2VBqiJAB1jzCmOKgJnigvgcoc9wRYxNx4Uc
	eV2g==
X-Gm-Message-State: APjAAAUeFXakadYSzMgpvdnsMZ9zCjjMy6qUIz3wF0UTwsEtc3AA9XUI
	M7NOYeW7XbFQ/FVBmpW46dl2Fw==
X-Google-Smtp-Source: APXvYqxpr+L0Fzs6tWnWl9irm8W5eWkgd+zq81mK1HCcdxMcHLBr9qdHTO8rf/E8lNMTxvA6s5a7Og==
X-Received: by 2002:a5d:658f:: with SMTP id q15mr36065108wru.213.1558354353842;
	Mon, 20 May 2019 05:12:33 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	y130sm17414356wmc.44.2019.05.20.05.12.33
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 20 May 2019 05:12:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id D383F1FF87;
	Mon, 20 May 2019 13:12:32 +0100 (BST)
References: <20190517224450.15566-1-jan.bobek@gmail.com>
	<20190517224450.15566-6-jan.bobek@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Bobek <jan.bobek@gmail.com>
In-reply-to: <20190517224450.15566-6-jan.bobek@gmail.com>
Date: Mon, 20 May 2019 13:12:32 +0100
Message-ID: <871s0tiatr.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [RISU v2 05/11] risu_i386: implement missing
 CPU-specific functions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jan Bobek <jan.bobek@gmail.com> writes:

> risu_i386.c is expected to implement the following functions:
>
> - advance_pc
> - get_reginfo_paramreg, set_ucontext_paramreg
> - get_risuop
> - get_pc
>
> This patch adds the necessary code. We use EAX as the parameter
> register and opcode "UD1 %xxx,%eax" for triggering RISU actions.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  risu_i386.c | 35 ++++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
>
> diff --git a/risu_i386.c b/risu_i386.c
> index 2d2f325..06d95e5 100644
> --- a/risu_i386.c
> +++ b/risu_i386.c
> @@ -25,12 +25,37 @@ static int insn_is_ud2(uint32_t insn)
>
>  void advance_pc(void *vuc)
>  {
> -    /* We assume that this is either UD1 or UD2.
> -     * This would need tweaking if we want to test
> -     * expected undefs on x86.
> +    ucontext_t *uc =3D (ucontext_t *) vuc;
> +
> +    /*
> +     * We assume that this is UD1 as per get_risuop below.
> +     * This would need tweaking if we want to test expected undefs.
>       */
> -    ucontext_t *uc =3D vuc;
> -    uc->uc_mcontext.gregs[REG_EIP] +=3D 2;
> +    uc->uc_mcontext.gregs[REG_E(IP)] +=3D 3;
> +}
> +
> +void set_ucontext_paramreg(void *vuc, uint64_t value)
> +{
> +    ucontext_t *uc =3D (ucontext_t *) vuc;
> +    uc->uc_mcontext.gregs[REG_E(AX)] =3D value;
> +}
> +
> +uint64_t get_reginfo_paramreg(struct reginfo *ri)
> +{
> +    return ri->gregs[REG_E(AX)];
> +}
> +
> +int get_risuop(struct reginfo *ri)
> +{
> +    if ((ri->faulting_insn & 0xf8ffff) =3D=3D 0xc0b90f) { /* UD1 %xxx,%e=
ax */
> +        return (ri->faulting_insn >> 16) & 7;
> +    }
> +    return -1;
> +}
> +
> +uintptr_t get_pc(struct reginfo *ri)
> +{
> +    return ri->gregs[REG_E(IP)];
>  }
>
>  int send_register_info(int sock, void *uc)


--
Alex Benn=C3=A9e

