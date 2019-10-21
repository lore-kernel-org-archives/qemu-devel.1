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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6E3CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 21:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6AE120873
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 21:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niHm7hn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6AE120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMev7-0003vk-UJ
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 17:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iMeoi-0006nY-18
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 17:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iMeof-0008Cm-Oa
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 17:02:15 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:45554)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iMeof-0008C9-Hp; Mon, 21 Oct 2019 17:02:13 -0400
Received: by mail-lf1-x142.google.com with SMTP id v8so10670358lfa.12;
 Mon, 21 Oct 2019 14:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Qv1NKUmzdvo7SX8jW6Fbq0tCALDaC3eNuZxIeGztedo=;
 b=niHm7hn1qymTPjlhrt37yYbHowu+e3/obEAQvnRCPaWVyU2z2OyXYo5dWJ6dqhCGhd
 tkW9suQonN4Be+sR5so39vZBW8xIX1G6EzJaPTZdguRS3ewCwBFIWxg7ZILZjfE9rI7G
 eJCToL0nmmsei2vs01sQ9mH3RQVAvLSBSJd2GJzoUsc3JAvhJrJUkgxHcTJ3/p73vbnV
 o4ps6F70yg3wFs9EJKjkOoown0Vy4/JWp+ALpeYXZr2LXGOcXyxUXt1TtgGg9guveLBn
 iG9a9hCPwAWsL3MzdvYvEZ0H4ZLfuZ74zKcpR/RekEjlrKT5aA5Tju8G8cBlTt1ENR9A
 EvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Qv1NKUmzdvo7SX8jW6Fbq0tCALDaC3eNuZxIeGztedo=;
 b=oqIqZKaDcHOg9q79emshH6Ai7MlZzE1T2SY32oSqFp9ocUydN7FcPy2ZU3FNbeANgd
 mJbSx6jqyC7iq/4f3HqcXhab4zuKYXj+3Lq64oNvERbjp1PDXQVKvdgoE9ZRCQx+Gnv3
 wB3oZAzHVZLn6TbsUCypKZCCdXzXj54MNUmtHw+xxPm7RhDQi/7QTt0ShVrkeyR+XZfa
 Utbcgd6tvlvHStbbxfikVjmnWGwr0HrD00Zn5jHHMcx67FBm6EuHZ/I2yrL6uQkgLGta
 p+lBYQgQ4G2EEJwuHuXvhdswjBULZxvxDXDRNNSn7coLaF+wCZghLXueRPtcz6RORjFx
 nouQ==
X-Gm-Message-State: APjAAAXIGFku5N40XUPmKLdSgVz0cKQoj4If79MVnzD2Vw8+12bDaDk6
 CcJfthvH2omCYzg3qWE44h9UepFIjEWS56b1Z2Q=
X-Google-Smtp-Source: APXvYqxwA0aMyaDVVXY99k/K5mEHvqZ42MNhRQP6rbzug4Q6OjBX4Nn2qSeD+fL4LGnQwz3dhVVEvxKrzv8FC0dbNXM=
X-Received: by 2002:ac2:447b:: with SMTP id y27mr5633374lfl.135.1571691731895; 
 Mon, 21 Oct 2019 14:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-16-philmd@redhat.com>
In-Reply-To: <20191020225650.3671-16-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2019 13:56:56 -0700
Message-ID: <CAKmqyKM1xniqr7F1oUYUVdko=c8vux3xvft0WKBx38WN8xhJFg@mail.gmail.com>
Subject: Re: [PATCH 15/21] hw/i386: Let the machine be the owner of the system
 memory
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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

On Sun, Oct 20, 2019 at 4:20 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/i386/pc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 4b1904237e..3414dc423a 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1655,7 +1655,7 @@ void pc_memory_init(PCMachineState *pcms,
>       * with older qemus that used qemu_ram_alloc().
>       */
>      ram =3D g_malloc(sizeof(*ram));
> -    memory_region_allocate_system_memory(ram, NULL, "pc.ram",
> +    memory_region_allocate_system_memory(ram, machine, "pc.ram",
>                                           machine->ram_size);
>      *ram_memory =3D ram;
>      ram_below_4g =3D g_malloc(sizeof(*ram_below_4g));
> --
> 2.21.0
>
>

