Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB170C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 20:07:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 919AB206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 20:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NLFB+Fmw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919AB206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34634 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb9WU-0007Cr-TI
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 16:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44743)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hb9Ql-0001IY-I8
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 16:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hb9Ba-00046F-NJ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 15:45:32 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42033)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hb9BT-0003q9-Ap
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 15:45:25 -0400
Received: by mail-pg1-x544.google.com with SMTP id l19so6891619pgh.9
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 12:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cmGVtkaVqH/W+zbOVWl+JG0OzLHGLxd+GCCZk7lokFw=;
 b=NLFB+FmwBJMPDiGqVVHaqWM1IDZ2m29pxqOu7HtvpOwXuwnRXcOfJ1yGXCsZnI6+bX
 E4r8uIsKU48GetCfrBlE/0oQZ5XcU7J0hiCeDy044ri3TbJqu7zG1z0ODDDgdEqZRv7q
 4h8BNFsllkIvOBFVMgKq2xWD46Bm+/7UW6ut6mT8QUPN1LVqzClgg3Q6WyL3+0vaTgvA
 WqBIhmpFpVFxhs1Pq+HV74DdsrtWh1Nb37E8vf24XHB+ic9xGP7sjUpOByjEl4xd8Csa
 dbbexAckKxEpt2F/8u9DQMt86W4XM1VHQKMNYeO7Zkv2ReqyJqactfqBoaBVmW7aLMRr
 Z3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cmGVtkaVqH/W+zbOVWl+JG0OzLHGLxd+GCCZk7lokFw=;
 b=nA1LC0JHp98iAR5oI/rUdXBXIr7P1mhgExnxm/fKk5DhiMyyIowb4XiHgcuKv9U1PQ
 0a4D/sdhmGAt6tuf7Fl/f2vWDTgNLGHt7Y6US+nqbAVsCfIc0ooEjY1V3FLleAriB2j5
 TNhwGnhgkkRPC/9IjP4h10/xFgyiR1L6q17FjQxrZR5VI0z7sHfn1A36/hDLW4qiOVu2
 EAQSV9TOUYvC/DDbK15okvw+O9uFEGhMVD+wvrIGvGI8wZ6vKPnlKOEXL2TO93TIpqT7
 wQvgO41uNserZsyo0rIfHYr1YiGLxTPLnPKGEWjpXSNN+PEPlJnf1ORq57KdiBpCWAO9
 ea9g==
X-Gm-Message-State: APjAAAVHCmbXXSwZ/61yyH1ghBgDytekkBBFitK8XGhSD7xxihq4nGaN
 ++M/l5IUcRYL9p3A0fflcoPBXw==
X-Google-Smtp-Source: APXvYqxbAn9CLz9nTqE+0IkT/6k5ufq0onED1kBySBBnntrLn/XYHBBwnfm0vI5LzP8aA67CJnHTsg==
X-Received: by 2002:aa7:9104:: with SMTP id 4mr87295551pfh.66.1560368718082;
 Wed, 12 Jun 2019 12:45:18 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id
 z186sm371737pfz.7.2019.06.12.12.45.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Jun 2019 12:45:17 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
 gkurz@kaod.org
References: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
 <20190602110903.3431-2-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <18b9c331-d61a-8cfb-1c12-56a7d818bf1e@linaro.org>
Date: Wed, 12 Jun 2019 12:45:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190602110903.3431-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH v2 01/15] target/ppc: remove
 getVSR()/putVSR() from fpu_helper.c
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

On 6/2/19 4:08 AM, Mark Cave-Ayland wrote:
>  void helper_xvxsigsp(CPUPPCState *env, uint32_t opcode)
>  {
> -    ppc_vsr_t xt, xb;
> +    ppc_vsr_t *xt = &env->vsr[xT(opcode)];
> +    ppc_vsr_t *xb = &env->vsr[xB(opcode)];
> +    ppc_vsr_t t = *xt;
>      uint32_t exp, i, fraction;
>  
> -    getVSR(xB(opcode), &xb, env);
> -    memset(&xt, 0, sizeof(xt));

Change in behaviour -- zero init to copy init.

Note for future cleanup: most of these initializations do not need to happen,
because we overwrite all elements of T without consuming the previous value.


> @@ -3410,23 +3382,22 @@ void helper_xsrqpi(CPUPPCState *env, uint32_t opcode)
>          env->fp_status.float_exception_flags &= ~float_flag_inexact;
>      }
>  
> -    helper_compute_fprf_float128(env, xt.f128);
> +    helper_compute_fprf_float128(env, t.f128);
> +    *xt = t;
>      do_float_check_status(env, GETPC());
> -    putVSR(rD(opcode) + 32, &xt, env);

Change in behaviour -- writeback happens before do_float_check_status instead
of after.  This may well be a bug fix, but if so should happen separately.


r~

