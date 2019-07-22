Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4011DC76190
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 16:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07723218EA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 16:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EfY6HGOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07723218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpamp-0000mO-2v
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 12:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58153)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpamb-0000Nf-Mx
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpama-0002Dh-KN
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:03:25 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39348)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpama-0002CV-Dm
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:03:24 -0400
Received: by mail-ot1-x343.google.com with SMTP id r21so34726281otq.6
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 09:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iJn21nEwRWdssE8YQ6E2iuuNCR55/C5oK+w8rhaw/8Q=;
 b=EfY6HGOH+tvPddQOyy2nC8VxQLpBfZK0ofyAmGSgNGUNw0qWdeh1V+yaQbJD4Bj+4h
 Kp3KQdiPmXAdITXZKgjJwd0PN1lkZHgM3ABuuYD/pSXGQuy+un40nyNzagMdhKHS+1Iz
 dgMHSufIuGtLW87kurBxwoM1L6i+kT95b0mytebj5msFee2dPGYtePxMXx3XFezUi8iH
 vT8Y3OGMvRhlfOrieEx5E5O5SP1fQRlWemJFmRHfLzobHHT9c3irTBLxZAB2GNvdrfmu
 QuIzUKoxh3hM1OfAihnbPQXUzZiqutmzRMy9duRWk7op+F/kjmQ/mweSmKaVx/vKCrrU
 jw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iJn21nEwRWdssE8YQ6E2iuuNCR55/C5oK+w8rhaw/8Q=;
 b=fpXyeYgszhSU6Z9/BS9NmL31RWqbC+9iN+2ugV2+6ye7j2kitI73TYa4SMjWWiqDE1
 D4LD3RUMcxLkgzSIqn3+YL5WXodW73QnH76zZoZGLo0gFn5weQueWzosSweYoE/VO2iM
 iepvvfoy9XIYEZhlXvI3X50z1uhUAo2+9yZJ7Wj+bqFLD2KAC7YQFYpKAzthURsuMaEf
 QRU+6bIzhwMp85VxK2YiMhZPV7TD3WJRnY6czEo5EIeh/OXqaGAvE6yTvNWFuVbXf4pt
 7z2ggUKDb3eGMzlbhi0wviL5zQ/vKPbvCVHnDC9JBl25p1IgK4oew7Rh8ywTDgvVaBHd
 nnwg==
X-Gm-Message-State: APjAAAVxdNHKbgEVW7SgzLMiAr20ZA+1bI/cCnhBybIqavf1WXHEfoNE
 zoVnhhdy9aq4CLRFEBKRwLb4pEgZdGoi6/XwSbRaTQ==
X-Google-Smtp-Source: APXvYqxx2sGbBzo6rPxp3Fd4osWCT3RRWIel8Y/olwhLDyO/jYPlKtyQNdOTkEZGJrqHTjN5QNXKZChIIp0QykT7mHc=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr16228965oti.91.1563811402641; 
 Mon, 22 Jul 2019 09:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190307170440.3113-1-richard.henderson@linaro.org>
 <20190307170440.3113-20-richard.henderson@linaro.org>
In-Reply-To: <20190307170440.3113-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jul 2019 17:03:11 +0100
Message-ID: <CAFEAcA98kE0VVu6K6AxPNb=YQzSsGunXL_EpwkqaOH=aDZCVTw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v4 19/22] target/arm: Create tagged ram
 when MTE is enabled
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 7 Mar 2019 at 17:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

> @@ -1182,16 +1194,19 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>      init_cpreg_list(cpu);
>
>  #ifndef CONFIG_USER_ONLY
> +    cs->num_ases = 1;
>      if (cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURITY)) {
>          cs->num_ases = 2;
> -
>          if (!cpu->secure_memory) {
>              cpu->secure_memory = cs->memory;
>          }
>          cpu_address_space_init(cs, ARMASIdx_S, "cpu-secure-memory",
>                                 cpu->secure_memory);
> -    } else {
> -        cs->num_ases = 1;
> +    }
> +    if (cpu->tag_memory != NULL) {
> +        cs->num_ases = 3;
> +        cpu_address_space_init(cs, ARMASIdx_TAG, "cpu-tag-memory",
> +                               cpu->tag_memory);
>      }
>      cpu_address_space_init(cs, ARMASIdx_NS, "cpu-memory", cs->memory);

This code will result in an array overrun in cpu_address_space_init(),
because that function allocates the cpu->cpu_ases array the first
time it is called, using the value of cpu->num_ases at that point.
So if  we call it for "cpu-secure-memory" when cpu->num_ases is 2,
the later call for "cpu-tag-memory" won't reallocate the array to
have size 3, it will just index off the end of it.

You should be able to see this with valgrind for the case of
the 'virt' board with EL3 enabled:

 valgrind ./build/x86/aarch64-softmmu/qemu-system-aarch64 -cpu max -M
virt,secure=on

==16861== Invalid write of size 8
==16861==    at 0x4120FA: cpu_address_space_init (exec.c:906)
==16861==    by 0x636F80: arm_cpu_realizefn (cpu.c:1617)
==16861==    by 0x80B920: device_set_realized (qdev.c:834)
==16861==    by 0xA9A94B: property_set_bool (object.c:2076)
==16861==    by 0xA98BC7: object_property_set (object.c:1268)
==16861==    by 0xA9BC8D: object_property_set_qobject (qom-qobject.c:26)
==16861==    by 0xA98EAC: object_property_set_bool (object.c:1334)
==16861==    by 0x5A0D0F: machvirt_init (virt.c:1677)
==16861==    by 0x81544B: machine_run_board_init (machine.c:1148)
==16861==    by 0x767B7E: main (vl.c:4348)
==16861==  Address 0x2c257720 is 0 bytes after a block of size 384 alloc'd
==16861==    at 0x4C31B25: calloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==16861==    by 0x6100B10: g_malloc0 (in
/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.5600.4)
==16861==    by 0x4120BE: cpu_address_space_init (exec.c:902)
==16861==    by 0x636F30: arm_cpu_realizefn (cpu.c:1612)
==16861==    by 0x80B920: device_set_realized (qdev.c:834)
==16861==    by 0xA9A94B: property_set_bool (object.c:2076)
==16861==    by 0xA98BC7: object_property_set (object.c:1268)
==16861==    by 0xA9BC8D: object_property_set_qobject (qom-qobject.c:26)
==16861==    by 0xA98EAC: object_property_set_bool (object.c:1334)
==16861==    by 0x5A0D0F: machvirt_init (virt.c:1677)
==16861==    by 0x81544B: machine_run_board_init (machine.c:1148)
==16861==    by 0x767B7E: main (vl.c:4348)


thanks
-- PMM

