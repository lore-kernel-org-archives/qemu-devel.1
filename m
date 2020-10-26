Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE08C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:55:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E400C20791
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XUHRXmTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E400C20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6iq-00036M-0z
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kX6Ez-0007T8-5C
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:25:05 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kX6Ex-0000yj-EE
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:25:04 -0400
Received: by mail-wr1-x441.google.com with SMTP id s9so13551452wro.8
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 10:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ysPxNijG4Aqx701ty20uzFlSvhmv1fPCzt8k8sSabLQ=;
 b=XUHRXmTtmw/q85FbL6mvWz4YUXTtz/6PoIsyS0gsiveSlZxfmSoPMjHnG6DpdR0tm3
 C+H8qmkcad3c7+giV2WdXfjUKLmgNmJqK3RKgR/vUvh0ckuM9G+5ikwDoEBUHw92+YUW
 69hpWlyzuUZLhfAGnczsWU7v3rkNQTYmaNmycBL6OuReCRwZCAr24n3y8e7Eek8pW+wv
 +0TY5dZq0sr43EPOww9CSzQMKxRJWow5/B3fvclFrra1jlBVN84wNXE9vvpNhcuhXe31
 Fc2L6fR5veUoMCr22u5dD5eHsDqezH3yC1/vPuhokuGYkU20YpD12qwHJkIAlh8R/nE4
 ucyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ysPxNijG4Aqx701ty20uzFlSvhmv1fPCzt8k8sSabLQ=;
 b=neNEYOGqEbQTaHSAiC9J63J39+g2NMjZMxXU1UZn/LsNxAnySC4iUMIEShUzklQhNa
 Vt+0tFPz7suIuDTBgbHbNQlDOY3dL3qAPg+l+oP9jWH17fNoRrgKoNH8WsslXnTAN2PD
 DLoqjTyqcx4Kioi7wDvjaVqoM9nnqTQ9yAlyoQ6kuri+TO1VuLx01/ibTDCs+xZETejQ
 HI5izmYJYmjOfl2BNZpkNfisM32u2UDeeQhRg6zNxhPH49J0QMGIbGo7OzZnxCbrVQmf
 mg77iP4RERxq4ksW68hlzdPp8fBwZxbnhHn55AxyGObYjglzyEod77c5/t7CvG4odF5k
 J+sA==
X-Gm-Message-State: AOAM532MDH1RB6wH4quzTrF/ttFkpna2O7gtyy44DqRRF5v/pXLRXsrI
 icLWJOZSqQXWRkme+ZPi3x1BMN7of0nKDA==
X-Google-Smtp-Source: ABdhPJzaMCNy3K4sbIalJaZjyUZG4Iqn7l1PG1rN8A+ClCoMUzPyvfuf9fw6Cjm2aN753h7iXRE9iQ==
X-Received: by 2002:a05:6000:1d1:: with SMTP id
 t17mr20075913wrx.164.1603733100679; 
 Mon, 26 Oct 2020 10:25:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b131sm2535776wmc.3.2020.10.26.10.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 10:24:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B070D1FF7E;
 Mon, 26 Oct 2020 17:24:58 +0000 (GMT)
References: <20201026143028.3034018-1-pbonzini@redhat.com>
 <20201026143028.3034018-12-pbonzini@redhat.com>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 11/15] rx: move BIOS load from MCU to board
In-reply-to: <20201026143028.3034018-12-pbonzini@redhat.com>
Date: Mon, 26 Oct 2020 17:24:58 +0000
Message-ID: <87lffsgas5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> The ROM loader state is global and not part of the MCU, and the
> BIOS is in machine->firmware.  So just like the kernel case,
> load it in the board.
>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/rx/rx-gdbsim.c | 7 +++++++
>  hw/rx/rx62n.c     | 9 ---------
>  2 files changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
> index 417ec0564b..040006c1c5 100644
> --- a/hw/rx/rx-gdbsim.c
> +++ b/hw/rx/rx-gdbsim.c
> @@ -142,6 +142,13 @@ static void rx_gdbsim_init(MachineState *machine)
>              /* Set dtb address to R1 */
>              RX_CPU(first_cpu)->env.regs[1] =3D SDRAM_BASE + dtb_offset;
>          }
> +    } else {
> +        if (machine->firmware) {
> +            rom_add_file_fixed(machine->firmware, RX62N_CFLASH_BASE, 0);
> +        } else if (!qtest_enabled()) {
> +            error_report("No bios or kernel specified");
> +            exit(1);
> +        }
>      }
>  }
>=20=20
> diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
> index 6eb4eea700..17ec73fc7b 100644
> --- a/hw/rx/rx62n.c
> +++ b/hw/rx/rx62n.c
> @@ -245,15 +245,6 @@ static void rx62n_realize(DeviceState *dev, Error **=
errp)
>                             rxc->rom_flash_size, &error_abort);
>      memory_region_add_subregion(s->sysmem, RX62N_CFLASH_BASE, &s->c_flas=
h);
>=20=20
> -    if (!s->kernel) {
> -        if (bios_name) {
> -            rom_add_file_fixed(bios_name, RX62N_CFLASH_BASE, 0);
> -        }  else if (!qtest_enabled()) {
> -            error_report("No bios or kernel specified");
> -            exit(1);
> -        }
> -    }
> -

I'm confused because on the face of it these are two different models.
I'll defer to the domain expert on this one.

--=20
Alex Benn=C3=A9e

