Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E873ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 23:27:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB90820882
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 23:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSSKKzPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB90820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMh4l-0000R1-Tt
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 19:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iMh3Z-0007lE-SL
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 19:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iMh3Y-0001He-Ph
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 19:25:45 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:42536)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iMh3Y-0001HM-Ij; Mon, 21 Oct 2019 19:25:44 -0400
Received: by mail-lj1-x242.google.com with SMTP id u4so1003197ljj.9;
 Mon, 21 Oct 2019 16:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GaEgKiOTRPFRJ37OiN1hvkJxw/u1/Kb5MqxlT0C/VMI=;
 b=ZSSKKzPsxHR5c2WGJH1+TUWql6nPtQkxaideGD7J/Lw5Dl2+Srg+c3xiHuTO70agfY
 rbcP/Faa55qYgs2+uOoPdf5A+SY7JQNOxYfHv87D97ng8PnldR2qUmQ9/oJ6ym4RukYS
 P0csxAmOPMSG2Rv561ymDDuTvW6wdst+Gs1x2pT9Lt1y6UDQUOHEegSjYRT0aQEcpRdo
 isdJcORSw3kg5ms6qCj9A4JCUuFzmE/sqaAi9YH1JCMwWzSUjJrqYc4GpGsUXr5ztHKe
 uBX3wcGj4VlaqWpnH6lj2qfimH5PCoF0w7eiQB/auJPz9YvroNORqcvzDUoc6ViMcbza
 xhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GaEgKiOTRPFRJ37OiN1hvkJxw/u1/Kb5MqxlT0C/VMI=;
 b=PN/FDBD2RKsIwo6UltgtS4uN5/1esj8cgL5f/ueJIcRXpIzBgYmQYCBAMT6QPRBnQN
 50147cTHxlKoStHIumtqp/2c/sdEGEXkwY/BaIAanVIrK5I7QL/1bQW1js3lB1Gth6NY
 QxoNiUJwRk+CmrmjNmTfBUCxf7O26yxsbkrC1jQf+yg9SXph0AScc/pO8rKzMudtN6Tn
 cq/ZzV/WZ7SU61DnxrSPuBu8q8bQSldOSbzHqT1c9D9sjfwla+2JjjtVBx3Jhj1tqk0K
 KVl35wLzL1IC9a2N4JmjsvOt4PtgLe4Y/bBiW4hYZJI9r4DqR1r4woTIi/xrriZA5v2f
 MqHQ==
X-Gm-Message-State: APjAAAW1wZfwFeJK+4qHm1W/wDO1Gd4eEWiPD2q8qQTYdYL+yCNFSEZw
 Eog53mZJ5bllDdAXX3w8WfX77xKrxBr/IkGPbxQ=
X-Google-Smtp-Source: APXvYqwUEM+ZxdaiBmSHdpQo/YhTgt7ftRSH7egIuG643Tsxz74DwCtvlIYpwDFBnlDRKW+i0RvCH4Thyb1HM0h3N98=
X-Received: by 2002:a2e:894b:: with SMTP id b11mr16472078ljk.152.1571700343037; 
 Mon, 21 Oct 2019 16:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-11-philmd@redhat.com>
In-Reply-To: <20191020225650.3671-11-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2019 16:20:27 -0700
Message-ID: <CAKmqyKNhMo5jBh=y_F+-M+J+AHp+k=AtYsVMCFZbhfrCR0dqCQ@mail.gmail.com>
Subject: Re: [PATCH 10/21] hw/core: Let the machine be the owner of the system
 memory
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Paul Burton <pburton@wavecomp.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Helge Deller <deller@gmx.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>, Fabien Chouteau <chouteau@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Andrew Jeffery <andrew@aj.id.au>,
 Michael Walle <michael@walle.cc>, "open list:New World" <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 20, 2019 at 4:07 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/core/null-machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> index 1aa0a9a01a..16546c8140 100644
> --- a/hw/core/null-machine.c
> +++ b/hw/core/null-machine.c
> @@ -35,7 +35,7 @@ static void machine_none_init(MachineState *mch)
>      if (mch->ram_size) {
>          MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>
> -        memory_region_allocate_system_memory(ram, NULL, "ram", mch->ram_=
size);
> +        memory_region_allocate_system_memory(ram, mch, "ram", mch->ram_s=
ize);
>          memory_region_add_subregion(get_system_memory(), 0, ram);
>      }
>
> --
> 2.21.0
>
>

