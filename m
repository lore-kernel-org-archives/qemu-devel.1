Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DA9C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:50:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9EED206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDR6bboN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EED206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvijm-0000Xr-Tc
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 10:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jviiZ-0008OW-R8; Wed, 15 Jul 2020 10:49:07 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:41691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jviiX-0000k0-B1; Wed, 15 Jul 2020 10:49:07 -0400
Received: by mail-il1-x143.google.com with SMTP id q3so2184711ilt.8;
 Wed, 15 Jul 2020 07:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZjNwVPAoqSbfouoFM+Try6jwW4/cFWew31JYb8/WKR0=;
 b=FDR6bboN68+tXVd+1BpZ9GSq9BJN8w3M4ufLbiv7nRIklRh+G9xX+WURccuGe7swY6
 C/SuGdjLzAtYQz8j2qj+N1R/IYtz0pEjWU8BeJFa3l3E3IAkqMM63Rhu9hnSwmHxHHLP
 42fzT6cFZpBTUUyeIpXRa8fLB9wt+LM9dA6pdqnAjLL66iYFmRce8MufftEy/E0Q3DX9
 mgLUSzJ5hIRZzCuzg4AiwrTre7u3mypuKauZWheOvxwDxFQ6q0g0ok/v4b6Ord8pe9lL
 S6SwQF94pd9auGyn7zZFJkTVgkgwTaXAaUbMRxrTddVgKMs2R15fZGA+ynCaD/dy/ipL
 JT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZjNwVPAoqSbfouoFM+Try6jwW4/cFWew31JYb8/WKR0=;
 b=O3OxwBOIx816lm0IWdPtuEA+CpRkrBcCBO7a5dl3UVhrOoxtaIWlyBjYdEsWKFpYON
 IcimWaWT3DDZfM6Nprsgx6tMxnH0hx5gGfvB8FR824G/zaAAZcif8/AIMuNc4RF6mWe6
 +70Hv+8LckoEDFbWaqSoKvnCNVY/d3bRDh+dL+b+3xqMfhBIw6h/3kxczztE3Xs6BkB+
 fjXaFlINFm8zMcX19Nd4wUlAXDmDhZRyfL8it3yx68U6WqG9UJX31WWvtXDK1dypW5qL
 LIIR9Dp3XBwhkDmwmWm4rvkLgCPoAh9bDU9coYsEwnF45PkK8uDaFq/tjTdOaVVoi4Sm
 cl6g==
X-Gm-Message-State: AOAM531DWRyRlsdB9T9B5LAgfLL5GswA/izBTeZ4tAMpjEIEGRWZOS8x
 0Mj+Hc03LLxeec1w6ESWpvjVfMM2uBdlOL77x0k=
X-Google-Smtp-Source: ABdhPJyGrJcQfu5S+ly7GD7abMhfqh/xrBcq/NQG4luJSp9TuLg7LexHuC/w1se43wMyuAeX4g9SO4hsDQ8S7IXXTKA=
X-Received: by 2002:a92:c213:: with SMTP id j19mr10474891ilo.40.1594824542820; 
 Wed, 15 Jul 2020 07:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200715140440.3540942-1-armbru@redhat.com>
 <20200715140440.3540942-2-armbru@redhat.com>
In-Reply-To: <20200715140440.3540942-2-armbru@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 15 Jul 2020 07:39:01 -0700
Message-ID: <CAKmqyKO5KoK9rJ6JkcnJaHeXTVK1e8iMMS0UzBfygkUw30kudQ@mail.gmail.com>
Subject: Re: [PATCH for-5.1 1/2] msf2: Unbreak device-list-properties for
 "msf-soc"
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Edgar Iglesias <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 15, 2020 at 7:08 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> Watch this:
>
>     $ qemu-system-aarch64 -M ast2600-evb -S -display none -qmp stdio
>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 0, "major": 5}, "package": "v5.0.0-2464-g3a9163af4e"}, "capabilities": ["oob"]}}
>     {"execute": "qmp_capabilities"}
>     {"return": {}}
>     {"execute": "device-list-properties", "arguments": {"typename": "msf2-soc"}}
>     Unsupported NIC model: ftgmac100
>     armbru@dusky:~/work/images$ echo $?
>     1
>
> This is what breaks "make check SPEED=slow".
>
> Root cause is m2sxxx_soc_initfn()'s messing with nd_table[] via
> qemu_check_nic_model().  That's wrong.
>
> We fixed the exact same bug for device "allwinner-a10" in commit
> 8aabc5437b "hw/arm/allwinner-a10: Do not use nd_table in instance_init
> function".  Fix this instance the same way: move the offending code to
> m2sxxx_soc_realize(), where it's less wrong, and add a FIXME comment.
>
> Fixes: 05b7374a58cd18aa3516e33513808896d0ac9b7b
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/msf2-soc.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
> index 16bb7c9916..33ea7df342 100644
> --- a/hw/arm/msf2-soc.c
> +++ b/hw/arm/msf2-soc.c
> @@ -82,10 +82,6 @@ static void m2sxxx_soc_initfn(Object *obj)
>      }
>
>      object_initialize_child(obj, "emac", &s->emac, TYPE_MSS_EMAC);
> -    if (nd_table[0].used) {
> -        qemu_check_nic_model(&nd_table[0], TYPE_MSS_EMAC);
> -        qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
> -    }
>  }
>
>  static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
> @@ -187,6 +183,11 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
>          g_free(bus_name);
>      }
>
> +    /* FIXME use qdev NIC properties instead of nd_table[] */
> +    if (nd_table[0].used) {
> +        qemu_check_nic_model(&nd_table[0], TYPE_MSS_EMAC);
> +        qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
> +    }
>      dev = DEVICE(&s->emac);
>      object_property_set_link(OBJECT(&s->emac), "ahb-bus",
>                               OBJECT(get_system_memory()), &error_abort);
> --
> 2.26.2
>
>

