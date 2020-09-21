Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405A5C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF2120874
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hufpkLSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF2120874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKLFh-0005au-Sx
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 08:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKLEz-0004jS-OH
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:48:21 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:39562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKLEy-0003hs-4w
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:48:21 -0400
Received: by mail-ej1-x641.google.com with SMTP id p9so17534230ejf.6
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 05:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JoNCaGe+GJNninP5ZSxI7VYQeMmb2lsGahYTpndboCs=;
 b=hufpkLSNFdj7EO0lALH4xcZApROvQDkYy817rL+JvgYXK84T/AF88SYFha4zecN7SR
 aZhEvVFY4ZGk7FjIi7Mvrg7h0q5+oTXf6uutnQww152sc49mJ7jlPlufXk+NbRTD+0eG
 rbNfV3QLUT2nbk1UH4RaD0kRgAKki7jcX/dcJKHnNnRmmgzx8o0RibFLs86OwZO+RU9A
 O3ug/LU0S57nOHElowp8k6Pp1Kcj0+kgZCYgdfjCUyLTLj99teps9ArbotUjU95BQvzx
 5Q4JjZa/6sgmwueNwmpLY2A8ggkelN7JKoneaeffqjI5UswagtPsU5hMC+wXnAPmw0JD
 SROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JoNCaGe+GJNninP5ZSxI7VYQeMmb2lsGahYTpndboCs=;
 b=uSAr+edyljuWrr4tWPHHKLXRn0azHawhnOTR/vA09MLnCjfYLijND4IvJzKT0KBqUt
 mw1NaiMVIp1Got8hNo/s5gMv8hcoAfcI9r64pkIpiP9nPj40UPJ1qKIIcipLto4mJCku
 64HlUsBYYbELNI8OPWjSCBbZhpDQ3Z1w+7TNoDMTTNORQkn1QURjkS5bBVX7AmXaZDqp
 mu2ec2bU7+imcEXjLUesQcMOjbtgEXxjdS3EskqtekkCYoACMt/tfZEZ/r4PfBJI/wKK
 m+j/pe9hfbG4YfbkveQCPHaPNLuTUI72GWjcWgujceorWCLq05QREsEHTwzkrys58BsB
 snMg==
X-Gm-Message-State: AOAM532V2AmP9lLkZuB9IAaQQ6MhAqusoPcw2PkEwRDKrSoOTq3exw4b
 2RNTTSkiuvEPIL6C0e9tlYll9BA2pD4OxQw9RSpc8g==
X-Google-Smtp-Source: ABdhPJwsVNGqRYA1a3+AZQg/cbxDkvtKDRrYRHty3DjwyPFW2DX7wB3bvyFpe5k1vcBX1ppBkPtyCpPjxmfAwfofyeA=
X-Received: by 2002:a17:907:20d9:: with SMTP id
 qq25mr47577899ejb.382.1600692498524; 
 Mon, 21 Sep 2020 05:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200914134321.958079-1-pizhenwei@bytedance.com>
 <20200914134321.958079-3-pizhenwei@bytedance.com>
In-Reply-To: <20200914134321.958079-3-pizhenwei@bytedance.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Sep 2020 13:48:07 +0100
Message-ID: <CAFEAcA-KX6p3aaKxmMx2i1G2n+9GdOXjDL2mqmHcngq3M_f+Gw@mail.gmail.com>
Subject: Re: [PATCH 2/3] iqapi/run-state.json: introduce memory failure event
To: zhenwei pi <pizhenwei@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Sep 2020 at 14:53, zhenwei pi <pizhenwei@bytedance.com> wrote:
>
> Introduce 4 memory failure events for a guest. Then uplayer could
> know when/why/what happened to a guest during hitting a hardware
> memory failure.
>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
> +##
> +# @MemoryFailureAction:
> +#
> +# Host memory failure occurs, handled by QEMU.
> +#
> +# @hypervisor-ignore: action optional memory failure at QEMU process
> +#                     addressspace (none PC-RAM), QEMU could ignore this
> +#                     hardware memory failure.
> +#
> +# @hypervisor-stop: action required memory failure at QEMU process address
> +#                   space (none PC-RAM), QEMU has to stop itself.

I'm not entirely clear what the descriptions here are trying to say.
These would be for memory failure events which are reported by the
host and which are not in guest RAM but are in the memory QEMU itself
is using ? ("PC-RAM" is a bit x86-specific.)

> +#
> +# @guest-mce: action required memory failure at PC-RAM, and guest enables MCE
> +#             handling, QEMU injects MCE to guest.
> +#
> +# @guest-triple-fault: action required memory failure at PC-RAM, but guest does
> +#                      not enable MCE handling. QEMU raises triple fault and
> +#                      shutdown/reset. Also see detailed info in QEMU log.

"triple fault" sounds rather x86-specific; other architectures
also have support for host memory failure notifications, so we
should design the QAPI events to have architecture-neutral
definitions and descriptions.

I think the four cases you're trying to distinguish here are:
 (1) action-optional memory failure in memory used by the hypervisor
     (which QEMU has ignored other than to report this event)
 (2) action-required memory failure in memory used by the hypervisor
     (QEMU is stopping)
 (3) action-required memory failure in guest memory, which QEMU
     has reported to the guest
 (4) action-required memory failure in guest memory, but the
     guest OS does not support a mechanism for reporting it

Is that right?

Anyway, I think we should try to find names for the failure
types that are not x86-specific.

thanks
-- PMM

