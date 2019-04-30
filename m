Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225CAC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:39:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DECB720652
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oylFkfB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECB720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50021 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLVn9-0001cq-7j
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 12:39:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLVmF-0001Dh-Pm
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLVmE-0002MF-Ub
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:38:43 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:41681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLVmE-0002Lt-PC
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:38:42 -0400
Received: by mail-pf1-x42b.google.com with SMTP id 188so7323719pfd.8
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=B21XwZ0YpozH12LTfCkW5cuuBFrg8tjpj+grwGv52GI=;
	b=oylFkfB+k3czNCChQYEXvU+Dum1lDnlgVxWPAsDW1XDBL99UDPvtymdiszFi/A+x7Q
	Gl5TqiDiapvpzP1nw5UeowyAXu2B/fnaiXib68poVCnmWSJekBtTtj72YPSjwaUPN4mK
	bEHZNx/P2DXWDlgZdIwy9IK8ytCj1IQRSWx28PM5It8wr6kDtz0oMtA1fWsvDA0wmaJk
	vd2jtIhan10iVbDHVj7UjUCtcK8zgDbWEsfDThakfFbqIfEQS/AjAe6+eAl42Tz/UszN
	WJBp9Vpq33ky+sC/RLu7ujujBCuDpKvwbS0+j5t+Dw3LOeMYK0moRC9U6oy5QBNmKl1d
	2veA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=B21XwZ0YpozH12LTfCkW5cuuBFrg8tjpj+grwGv52GI=;
	b=ZPrwC/rbMG2U5Wm1dXh0j89KBa6+99CqWjd5ZFQlhDz37xK5OLnVevzZI/MVHexXsq
	0hJYUhxqbbjEto5+UG0bGWQUAxeYK37P73PMilh46Xiyxvl3V6A9MZWa9nBXVVnzvz+d
	0NVyZ3QCntysKeFIW5g14PExEQovq1qTWr6YqqQgeADG+HAIsyd4IYngAudea3PIdtUI
	+W8J2fw4YAWF5VXPiD+MNjhc4qUqNOwMg9iBSNBJAg/Afo+dpYFbh1MtvMJ6a+DquRj1
	iO11/PcA2JpROjLcjOiRYz0UG0ifmGCNIAO5gqbzmMT695fEXIiE+6LyPf3zRHOeGAtK
	zG0w==
X-Gm-Message-State: APjAAAXMQuW1C/OtvG+andIBDGK+iKdXUUa1Gdme2DI7NtMrQVZUyAwq
	zRs0SEV77RBhh1HJ05PjaS9S/w==
X-Google-Smtp-Source: APXvYqw0Yxta39QXl+y2CarpLzxL0XRNG0KcPegOuywoGRShdw5M2S7VbjloUPSv8oADTYpt34cnXg==
X-Received: by 2002:aa7:8ac8:: with SMTP id b8mr27932683pfd.234.1556642321610; 
	Tue, 30 Apr 2019 09:38:41 -0700 (PDT)
Received: from [192.168.1.11] (97-113-18-231.tukw.qwest.net. [97.113.18.231])
	by smtp.gmail.com with ESMTPSA id
	z7sm68463533pgh.81.2019.04.30.09.38.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 09:38:40 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
	gkurz@kaod.org
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-6-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <784adbd2-0447-9d01-cff8-e7234f9d9679@linaro.org>
Date: Tue, 30 Apr 2019 09:38:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190428143845.11810-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42b
Subject: Re: [Qemu-devel] [PATCH 05/14] target/ppc: introduce
 GEN_VSX_HELPER_X2 macro to fpu_helper.c
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430163835.czIjM3bVUSIs4-1EFUQ7VhGemK_eCLei36jPKfKpe3A@z>

On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
> +#define GEN_VSX_HELPER_X2(name, op1, op2, inval, type)                        \
> +static void gen_##name(DisasContext *ctx)                                     \
> +{                                                                             \
> +    TCGv_i32 opc;                                                             \
> +    TCGv_ptr xt, xb;                                                          \
> +    if (unlikely(!ctx->vsx_enabled)) {                                        \
> +        gen_exception(ctx, POWERPC_EXCP_VSXU);                                \
> +        return;                                                               \
> +    }                                                                         \
> +    opc = tcg_const_i32(ctx->opcode);                                         \
> +    xt = gen_vsr_ptr(xT(ctx->opcode));                                        \
> +    xb = gen_vsr_ptr(xB(ctx->opcode));                                        \
> +    gen_helper_##name(cpu_env, opc, xt, xb);                                  \

Similarly wrt opc.  However,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

