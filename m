Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED22CC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 19:11:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1B44204EA
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 19:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXs3PDcE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B44204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfTML-0007CY-0S
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 15:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfTL7-0006Rw-Ui
 for qemu-devel@nongnu.org; Sun, 31 May 2020 15:09:45 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfTL6-0007U4-Hv
 for qemu-devel@nongnu.org; Sun, 31 May 2020 15:09:45 -0400
Received: by mail-ot1-x342.google.com with SMTP id 69so6263234otv.2
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 12:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=n2w956jMdsw0P8qO81PAt7xkN4qJuBxhJ3z6uUclMiY=;
 b=qXs3PDcEIsr00VmppHIy8ksP0cFD7Pqej1UQ+PLdpVloFNJC9YpYqjABIQ17gwUH08
 qgw2CG7wEdSPdc63UXVQmAJNvHPfE/6ojahsu7UTZ5gKLZq6d2vZih0MsveqyEpiWi2K
 ZwCssbdPwMXDG6Nq/iEs/uknC2a9TK6//qv2BzbADY0is01LouB+8LFhkQoUI0OlTBOf
 qyc1KiEzHBLqRjpK22Vy6iOc+ETjprEl7Dy3J66SmRo0XucmxoibF84ukgc7Qjq7yAYQ
 xVh0sX+d/ZaMIu/XTsZpxkBl5IHrcMVS2r81TWqR9BF1Wsi5Vey7naA3TgQCOG5xouyT
 +oqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=n2w956jMdsw0P8qO81PAt7xkN4qJuBxhJ3z6uUclMiY=;
 b=ucHUmnsbnPgWw/J+K6LTusH0GK4C6nJ3fLdjdm6Dfrbe2jm+WyveZ53HMVHcpm25bn
 5nwp0qbFPA7l/00hf/SLDv29seUz4FEMESLH6d9A51LWGdVirpX287JKY3Pl0Fhw9HNT
 mrzaHy1XigSjcGgJup6irFUq/CY7nG0TFwsiVDhzIQ9/y3vwo31LI6+SlhXkcp9NKWH/
 opfCUxjJvP5dx9S68m8aIXX4MKAawOSk6MUgRJRgLQP1ub/aRSZBn3Q8OJZe8hRkrqR/
 MRZqwdRLj0h7xbGBlSy0VsW0CRPPp8SLqYomTgSVJ2VrqY2a/D+LJi9tFHZZ//erpx+P
 xO0w==
X-Gm-Message-State: AOAM532pVEKGY3AYgM5ppPCR/RROsL5Jhqbn+6XhywndJDFtuhl/XtI6
 5uqnMgWcL5Bgq95UA9sk6L78WoFcQSRq2BWaKRftkQ==
X-Google-Smtp-Source: ABdhPJzrRkfO7MvBFoBD+niNJSwFovl/93vstAHh2dStkPg7lhujDi4o59P11ZetCE6Wk37/yYl1/YaO5kcWteFoZ/I=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr13378596oth.221.1590952183170;
 Sun, 31 May 2020 12:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200531175425.10329-1-f4bug@amsat.org>
 <20200531175425.10329-6-f4bug@amsat.org>
In-Reply-To: <20200531175425.10329-6-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 31 May 2020 20:09:32 +0100
Message-ID: <CAFEAcA9CkBy=e3EmJhKko9XGbL7A_E_vedm8jt_H3+Gr6yzbhA@mail.gmail.com>
Subject: Re: [PATCH 5/6] exec: Restrict 32-bit CPUs to 32-bit address space
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 31 May 2020 at 18:54, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> It is pointless to have 32-bit CPUs see a 64-bit address
> space, when they can only address the 32 lower bits.
>
> Only create CPU address space with a size it can address.
> This makes HMP 'info mtree' command easier to understand
> (on 32-bit CPUs).

> diff --git a/exec.c b/exec.c
> index 5162f0d12f..d6809a9447 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2962,9 +2962,17 @@ static void tcg_commit(MemoryListener *listener)
>
>  static void memory_map_init(void)
>  {
> +    uint64_t system_memory_size;
> +
> +#if TARGET_LONG_BITS >=3D 64
> +    system_memory_size =3D UINT64_MAX;
> +#else
> +    system_memory_size =3D 1ULL << TARGET_LONG_BITS;
> +#endif

TARGET_LONG_BITS is a description of the CPU's virtual
address size; but the size of the system_memory memory
region is related to the CPU's physical address size[*].
In particular, for the Arm Cortex-A15 (and any other
32-bit CPU with LPAE) TARGET_LONG_BITS is 32 but the CPU
can address more than 32 bits of physical memory.

[*] Strictly speaking, it would depend on the
maximum physical address size used by any transaction
master in the system -- in theory you could have a
32-bit-only CPU and a DMA controller that could be
programmed with 64-bit addresses. In practice the
CPU can generally address at least as much of the
physical address space as any other transaction master.

thanks
-- PMM

