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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156BFCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 21:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C502086D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 21:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4zRQ30o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C502086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMeyH-0006T4-0a
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 17:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iMes6-00018W-8J
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 17:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iMes5-0001la-5H
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 17:05:46 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:39520)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iMes4-0001lE-UN; Mon, 21 Oct 2019 17:05:45 -0400
Received: by mail-lj1-x242.google.com with SMTP id y3so14863035ljj.6;
 Mon, 21 Oct 2019 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HHLNUJcgizwsCjrccvpMTH9xPKsLvXCG9xhUWPKSHUs=;
 b=l4zRQ30oL3sL7kvxOlPXyHeCFa8eLoxVWyxVYm6U7cfax8NI3o0zKyW3IBFu7R7/3T
 Zh9mWjgaCv17NAYoV+IG3C5EGSxqhBMGCUXnnh1fJ/9yjl+ZZiW1GK7rw8NgGwOrawVk
 Fkq2CCGMaIyvfv6b4DKqXBZzQmVaDNwryRwILNphqH6xD9ZoFcdGlBZFjyWK6L1hShfh
 dYZ9TIt+9h8fVhS772Y+f2yY3YvyDT1X21lHkoiEqdYsdd4owo4TisfwAOIHKqK+c9LD
 Iw5AAg1bg5jEQJXzG11/isw17O4iqayJqL76oMtZB3C7hqTFPDaHqeW5BVM2gQh1nWk0
 HXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HHLNUJcgizwsCjrccvpMTH9xPKsLvXCG9xhUWPKSHUs=;
 b=HJmvuSZ93Xg8DgCtQsooaKVM9m3EM+ArXYtq2YynZX8NMWFiItTYIy2HUU2zMyXX5M
 QEkVdQnNeFin5q//9pxqU/5HeSe1lmTW1NySxIBUP1iGU+H2k1G658RgPvj4xrfauTtn
 BYQND3ebX/5gbYnLqpcUQ/zCCtL63wpkIQYsUbT5RU4c2zhgp4pe+FhINpw7N2In1dgQ
 AF8KPzZLWG6BuGNEINs3ttDWHmOkbDs4mPHI36sJ2XcrmYYs8t1SlvmYgEmMLWX3enGy
 nBtqKf7b1pEOdSTDWRJ88MDs3SdbEK6d0Q9lSQ9kdQZgi2CmXVxaSe53qRK+GB7PHQwi
 /lTw==
X-Gm-Message-State: APjAAAXv3JOR4OJznI/KiGguMnzBFSVMu4gwtw+Jjgontl7qiS4sbp5H
 scxzzS8tIh8kADFP2l6fDN13ARvElMNEy2r1Tvg=
X-Google-Smtp-Source: APXvYqxAXXMKytfwRdqq4uyRMy0ABxE6LqKlq1RY+eUHVKzHUVQsN3o5TNn5NC92MLbe18l5U4UHPMS3IioaW1/05ok=
X-Received: by 2002:a2e:b17b:: with SMTP id a27mr16138627ljm.7.1571691943442; 
 Mon, 21 Oct 2019 14:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-22-philmd@redhat.com>
In-Reply-To: <20191020225650.3671-22-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2019 14:00:27 -0700
Message-ID: <CAKmqyKNtTMtjVjJdyCLb_WN5w12ZKV3jMrz1E0rFQ1DBMY1cdw@mail.gmail.com>
Subject: Re: [PATCH 21/21] hw/core: Assert memory_region_allocate_system_memory
 has machine owner
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

On Sun, Oct 20, 2019 at 4:22 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> All the memory_region_allocate_system_memory() pass a MachineState
> argument. Add an assertion to ensure the new boards/machines added
> set this argument, so all system memory object have the machine as
> its QOM owner.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/core/numa.c      | 4 +---
>  include/hw/boards.h | 2 +-
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 2e29e4bfe0..3e07e94d00 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -527,9 +527,7 @@ void memory_region_allocate_system_memory(MemoryRegio=
n *mr, MachineState *ms,
>      uint64_t addr =3D 0;
>      int i;
>
> -    if (!ms) {
> -        ms =3D MACHINE(qdev_get_machine());
> -    }
> +    g_assert(ms);
>
>      if (ms->numa_state =3D=3D NULL ||
>          ms->numa_state->num_nodes =3D=3D 0 || !have_memdevs) {
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 3b6cb82b6c..31ab6e7586 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -14,7 +14,7 @@
>  /**
>   * memory_region_allocate_system_memory - Allocate a board's main memory
>   * @mr: the #MemoryRegion to be initialized
> - * @ms: the #MachineState object that own the system memory
> + * @ms: the #MachineState object that own the system memory (must not be=
 NULL)
>   * @name: name of the memory region
>   * @ram_size: size of the region in bytes
>   *
> --
> 2.21.0
>
>

