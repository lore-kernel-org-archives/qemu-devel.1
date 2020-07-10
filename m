Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC503C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:15:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1DC020725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ufMwsjrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DC020725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtujt-00058V-PM
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtuhm-0003X8-FC
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:12:50 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:33363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtuhk-0003MR-HX
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:12:50 -0400
Received: by mail-oi1-x233.google.com with SMTP id k22so5088726oib.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CcJ/vObs0NfBB933mKG+nSRyMmC8/i2uth25xvTsVHc=;
 b=ufMwsjrnzOqjkkyns80PBNwwBETm5uTXD6klTEo940VLPz3Bkb1Jl9ny2pw2BiTnp3
 1bgPzGM+V34VSaGemQMt4cCvfI1WVGZe4E1EV6EcGzmbibxR4KKZ2YnxfcaeXBl2dGXs
 7rA5yj0XMc6yjTnV4S+8is+nHlftJnjtVeE5OOvoOLFZ72im+GF6qIIsOp0BrbENwqLE
 Z5YQBFJPOKRPpoM/repPfSchKonIKTZoDr3YpwHif27F0dHkLuxe5tdBvRBVX6/juV2o
 pp7tTFZTGyfCQkUmXNQN3qA4+rC5Fdz+rEru1rV1NAP9yV93kZk+uB5EdRYd8kDz8Hvf
 8kSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CcJ/vObs0NfBB933mKG+nSRyMmC8/i2uth25xvTsVHc=;
 b=dDIudOFvKFviwm3xlaSTMvkgLTzxB+ApZn+Qhbowi9EoD1MQmda9zhAK6lvl0yxPAH
 D9xQQEm6H88OjB5TukC54fYrHhJs9wwuPj6Z0GTQ2AMbSmHj8NfjSu/EIwr4ZqQHdKXw
 p1OvOYB08Vh7sACIQiMuyLjzMn+PXKsg8bEs5fvj8EeOSXEnwE1ZfrVUVqmK74vZIATL
 frvAwABzqJ+hTrVmBjnLDtNyJZBxzqN9JwbmGXJ0ic/mmB2zaNQQPdF2CWKS2kw8d3ja
 vaIaQUoXb2OnPAXFqmukmAypV2cGSOOvB/jI5tjQLUHIBQKvUf1jCNxc0PP0+pHsSnUL
 cB8g==
X-Gm-Message-State: AOAM532Ta8hc0Ka61+01EZdhE+LP7VuuiG0n5FO2uyjmJ1KBJjc+vcTa
 nkSMFjC88yVflI/VESXsREWNMjG5kaopgSPOvsFDxA==
X-Google-Smtp-Source: ABdhPJytHBQwhMa1P+bjHpXoP+9nISfZ7aeFxweHBU1QUkM2R9zZSZBK8k8wQewe5uH/W9TL2t7QNEqBxbsmTdiwnII=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr4551474oib.163.1594393967220; 
 Fri, 10 Jul 2020 08:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200707181710.30950-1-f4bug@amsat.org>
 <CAFEAcA85TE+W39fphhm77hNKmAJyEMmaTseDkL1t4gTkzzcbJQ@mail.gmail.com>
 <47ca6b92-cedb-a6c4-754b-b7cd5da597e7@redhat.com>
In-Reply-To: <47ca6b92-cedb-a6c4-754b-b7cd5da597e7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 16:12:36 +0100
Message-ID: <CAFEAcA_wBT+Yfsn+DFZkcRxYWKmF04U2JHNVz5mNuXabeDcN5g@mail.gmail.com>
Subject: Re: [PULL 00/32] AVR port
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x233.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jul 2020 at 16:03, Thomas Huth <thuth@redhat.com> wrote:
> Endianess bug ... this should fix it:
>
> diff --git a/target/avr/helper.c b/target/avr/helper.c
> --- a/target/avr/helper.c
> +++ b/target/avr/helper.c
> @@ -337,6 +337,7 @@ void helper_fullwr(CPUAVRState *env, uint32_t data,
> uint32_t addr)
>          helper_outb(env, addr - NUMBER_OF_CPU_REGISTERS, data);
>      } else {
>          /* memory */
> -        cpu_physical_memory_write(OFFSET_DATA + addr, &data, 1);
> +        uint8_t data8 = data;
> +        cpu_physical_memory_write(OFFSET_DATA + addr, &data8, 1);
>      }

Or equivalently
  address_space_stb(&address_space_memory, data, MEMTXATTRS_UNSPECIFIED, NULL);

(better choices of address space may be available, but this is
the exact-same-behaviour one).

>  }

thanks
-- PMM

