Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF23C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4701A2067B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p077mU2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4701A2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jksIu-000810-K9
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 12:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jksHz-0007R7-Uc; Mon, 15 Jun 2020 12:48:52 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:44565)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jksHy-00039B-EY; Mon, 15 Jun 2020 12:48:51 -0400
Received: by mail-il1-x143.google.com with SMTP id i1so15901679ils.11;
 Mon, 15 Jun 2020 09:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yHItOiITX7pnZGV3EgK7vfMRWWkWCREC1RJ2BfBpJM0=;
 b=p077mU2Mwimh8dngzuy/g+Ey7/Jrcq5YoyY1EfwCeXcFnl5vIiUEb/4S+3rBYVGS0A
 C6gMSHPBDQPZ6MYAcKZ8rZg3lvbb5rAuPyl01KrjiG4EYzIfCS+UvS5AJwMRc9bSMaZK
 BtYIerdGauOCB4n58LNwTSSoMMJiFKwEY7bkUC/3A8qdf3qLrZgc3cGsn0LMhLbvF9Un
 VUB7Ou8m7KuteSuGBjX8Y9gaj8p06MfApp1QsbcLDqmstlcAY8YBghfDededxMy0Jhln
 bFlKYkTF29lqBn+0qyiwkH2f1uQfS2FXwOhckCVup2E2d4ZHzIbeV4tAff1O/DNDZPIr
 pkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yHItOiITX7pnZGV3EgK7vfMRWWkWCREC1RJ2BfBpJM0=;
 b=UKFr4IMVZ8L7CyY+YteI6pTjiaonHJVP68pBoqWAcwb9HxcqsYynBBt99VFci3e3R0
 amNKGkMPBn0VJ/tdy7xKHTCXhvon89iLWrMBzA4DwxqiewW6A+jsiqe6L10PHVpNA/VU
 nEAt0Qu1kMor/w6eJRS6Czf6DtDstLRBOD3lBMVh24EwIzMzV5BESEoOV58/bWUJ+W2z
 s+cXNjxfZysoWdjYe5B29x0NRlfOsSoFnkBw3Qc4OrVl6CuGOSzr/bBZsV9qrIgFf0pY
 0PYCS5kk0dCtOUkEUvg7eRiKF+LcxbptpB0tUtK47Jmhschi05D2A/VQIARE6T8mVRgz
 FJtA==
X-Gm-Message-State: AOAM532xkVsAbItQWf69NmCu0l8lfWqYYYWx3EQTiEP59I8+V5mmp//D
 Bv4ZeCNiyUXy7UkQYrCH2Kwfemr3+5Tq2a+4lE+kjqN6
X-Google-Smtp-Source: ABdhPJxaixL70p9q6a5LMxvLMdeXvQakkbULyPmi7aGGQkCL4NzRfIweT9VfSh8ARq5LmweILgxVwJ5i/rsNJP60kts=
X-Received: by 2002:a92:bb45:: with SMTP id w66mr28013329ili.131.1592239729054; 
 Mon, 15 Jun 2020 09:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
 <1591625864-31494-11-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1591625864-31494-11-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2020 09:39:26 -0700
Message-ID: <CAKmqyKNpqe6LDeTma0iaQ6yBNdjHgzKPRyepGiWcg6q2_Mu4fw@mail.gmail.com>
Subject: Re: [PATCH 10/15] hw/riscv: sifive_u: Rename serial property get/set
 functions to a generic name
To: Bin Meng <bmeng.cn@gmail.com>
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
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 8, 2020 at 7:21 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> In prepration to add more properties to this machine, rename the
> existing serial property get/set functions to a generic name.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/sifive_u.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index ef51874..07e2ba0 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -481,14 +481,16 @@ static void sifive_u_machine_set_start_in_flash(Object *obj, bool value, Error *
>      s->start_in_flash = value;
>  }
>
> -static void sifive_u_machine_get_serial(Object *obj, Visitor *v, const char *name,
> -                                void *opaque, Error **errp)
> +static void sifive_u_machine_get_uint32_prop(Object *obj, Visitor *v,
> +                                             const char *name, void *opaque,
> +                                             Error **errp)
>  {
>      visit_type_uint32(v, name, (uint32_t *)opaque, errp);
>  }
>
> -static void sifive_u_machine_set_serial(Object *obj, Visitor *v, const char *name,
> -                                void *opaque, Error **errp)
> +static void sifive_u_machine_set_uint32_prop(Object *obj, Visitor *v,
> +                                             const char *name, void *opaque,
> +                                             Error **errp)
>  {
>      visit_type_uint32(v, name, (uint32_t *)opaque, errp);
>  }
> @@ -507,8 +509,8 @@ static void sifive_u_machine_instance_init(Object *obj)
>
>      s->serial = OTP_SERIAL;
>      object_property_add(obj, "serial", "uint32",
> -                        sifive_u_machine_get_serial,
> -                        sifive_u_machine_set_serial, NULL, &s->serial);
> +                        sifive_u_machine_get_uint32_prop,
> +                        sifive_u_machine_set_uint32_prop, NULL, &s->serial);
>      object_property_set_description(obj, "serial", "Board serial number");
>  }
>
> --
> 2.7.4
>
>

