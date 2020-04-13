Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1869C2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4DB620678
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpignNU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4DB620678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO7Uc-0001tC-OE
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 18:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jO7TO-0000IA-Cw
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jO7TN-00062n-E2
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:22:34 -0400
Received: from mail-ua1-x941.google.com ([2607:f8b0:4864:20::941]:36451)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jO7TN-00062c-9p; Mon, 13 Apr 2020 18:22:33 -0400
Received: by mail-ua1-x941.google.com with SMTP id m15so3732258uao.3;
 Mon, 13 Apr 2020 15:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YzMwyUxjG9VjYUhzYdWXMKxuI7FUnl5tFZL2IUdOTm8=;
 b=dpignNU7ncFb7s4gJxsqDp964C4u1fm8PFQTs7wsS/Ko6GVjwhgPPIW3qLZca7/c1l
 oxVdZEl3ZPQKyv8VPVYF6YSClTiReCv6v0oGjEEQ7exzKtfIOaMnvIHxfgBPu4eTSX30
 KXenLuN8g6q2QmHLMgbYvQIteKyhdqhKE9fvfP5t3P73AjQMtsPMDo/AgLijqij2c0ES
 2vBxww5h+3O5V/Ie7oh/UD9k9nIFMr82/B+wlNRYReJM8c28lPI8LcE9dNwfqwH9+4f+
 P+P+0uKat6NvQRAmZv886vWTe4bx5TjkTVNoMgJYyUwZZSKYdZjUVlf+9dyW8okqShvE
 2VBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YzMwyUxjG9VjYUhzYdWXMKxuI7FUnl5tFZL2IUdOTm8=;
 b=UqSjcG8accLMrXDcuSG4ffYC0gB7mx/QXW19DMjMuA+1q922bVj0mygWQS4VZ/IL6b
 UZMoZGjsOuYmXIKOuTumqcfQjacGNXuh4QYQu4Jsi9yvWcNyvvGsqMN1gdp7jplX1XZK
 JvAIFpnK6Bb9xhbOxFtkT9v86TTgVCHXVLgukzgq9Cpi8P26T/V5zDCbbze4oUEl9jIj
 JCf/P2vwPDQEkzfml+L44VUOONSt2JS4lYipWozVTjWmn9q4gAo9yZSRmCQNbR+0vso8
 opJC3JUHXr5NiZwN1w0QoEdxJYtYCjJ1Rcoo1CAZV7voxJMIY+K9A1qrcDXMtJpU/f0V
 8f7Q==
X-Gm-Message-State: AGi0PuaZ5+SGEixCLLSPefRUb76i+VHKUbIgEjNwiF6wSQrxZeAyl2Mq
 R0SV9oiHqXJPAYikhjjjdvBs3hHOUq5frG30MDk=
X-Google-Smtp-Source: APiQypIqN5k/MQVlOi3FgEymp/5vB6DR/mb7e8jW0DqPuw2/0Xu2EeD+mIEn4zRoJsYVz7l14DRluQDMZGhLV4MDEP0=
X-Received: by 2002:a9f:2964:: with SMTP id t91mr12504390uat.21.1586816552774; 
 Mon, 13 Apr 2020 15:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200412223619.11284-1-f4bug@amsat.org>
 <20200412223619.11284-25-f4bug@amsat.org>
In-Reply-To: <20200412223619.11284-25-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Apr 2020 15:14:16 -0700
Message-ID: <CAKmqyKPV-BLHoic+y7W_j4E2WWkmgtOxiTS68z4G_34DtcTXpQ@mail.gmail.com>
Subject: Re: [PATCH-for-5.1 v3 24/24] hw/riscv/sifive_u: Rename
 MachineClass::init()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::941
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>,
 Wen Congyang <wencongyang2@huawei.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Apr 12, 2020 at 3:54 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> As there already is the riscv_sifive_u_soc_init() method,
> rename riscv_sifive_u_init() as riscv_sifive_u_machine_init().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_u.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 7bf1f30a35..e13ab34de4 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -312,7 +312,7 @@ static void create_fdt(SiFiveUState *s, const struct =
MemmapEntry *memmap,
>      g_free(nodename);
>  }
>
> -static void riscv_sifive_u_init(MachineState *machine)
> +static void riscv_sifive_u_machine_init(MachineState *machine)
>  {
>      const struct MemmapEntry *memmap =3D sifive_u_memmap;
>      SiFiveUState *s =3D RISCV_U_MACHINE(machine);
> @@ -606,7 +606,7 @@ static void riscv_sifive_u_machine_class_init(ObjectC=
lass *oc, void *data)
>      MachineClass *mc =3D MACHINE_CLASS(oc);
>
>      mc->desc =3D "RISC-V Board compatible with SiFive U SDK";
> -    mc->init =3D riscv_sifive_u_init;
> +    mc->init =3D riscv_sifive_u_machine_init;
>      mc->max_cpus =3D SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CP=
U_COUNT;
>      mc->min_cpus =3D SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
>      mc->default_cpus =3D mc->min_cpus;
> --
> 2.21.1
>
>

