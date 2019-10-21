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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D1ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 23:26:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A5D22077C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 23:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiaTSOMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5D22077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMh3o-0007hz-8D
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 19:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iMh2M-0006dW-LP
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 19:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iMh2L-0000w4-GS
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 19:24:30 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:41074)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iMh2L-0000vU-8e; Mon, 21 Oct 2019 19:24:29 -0400
Received: by mail-lf1-x142.google.com with SMTP id x4so5185281lfn.8;
 Mon, 21 Oct 2019 16:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CDR0nIHZNYeOYi81Mdnyq5M6nwo5PBTk5UyDeGY7B40=;
 b=eiaTSOMqApMCmJjpUN+Jp97wSj1Bi0nE3hkyrPV73yyKHAprQAiaBU50ywpbAZdE93
 jKSB2T2WQfh8Cn/fljbcmVuCz9PznUBRI1+mNzmZui4O0njGeiCF1g5J1nQgYW0HwzUc
 V+xeGcxh+/Wr91FwRFlf0hOOYhPNbw2cZMJt5GXrvAB9mimmsZouTGooVBfrO5DeBPXn
 Q4yTZkDWBZJAra0AU4+Eq7IsuqPoIHnh2fMrnFnr8s0xdSsy355l1lg7qIdufs/ENYv4
 1gjzRnLzFKGESTNy+DJDH+9gZBisVMX60i5RwDOmnXrDeR99draiHm5FKNVlGiE73Ucy
 e7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CDR0nIHZNYeOYi81Mdnyq5M6nwo5PBTk5UyDeGY7B40=;
 b=Pf897513UI/RGactI8GUT3Mr+3/zzXkFLV3BcPmOX1XdFLAUEP8km98nm2P6GmDWbw
 C/f+EhWKJNzop8yZuCESXeWbY5vMrLdR2gmEIVEq/+OHYknYzCgexZ5+MIzQczeHkUmA
 lD4BrO+tIhl44NQoHJ1xHER0AI7eHOmUBanbHDeLzmNULlzjGsO3fi75nHO/LXUq+43+
 XXJ/8IVeUpizXz+jVk5Vw7piuhQyVo4UrjnZDemlaiT/dAfKwrXcLvDeJqte9xWHT0Iv
 uEWv2uvWmuknnGpp7o+BqItWA9jlmv/0Rm2Bu2JSYB27ry4GmCDKvhkOnmE+a/mQXtyJ
 6htw==
X-Gm-Message-State: APjAAAUUi8BiU0pJjxv15dHsf/DoEG/y2ZhRFISrS5MsmJ4OaK1LaSyD
 w+/pnuPe/0PNzaXkueJbpZy5WMroZZqUl4poCfw=
X-Google-Smtp-Source: APXvYqxpK7IamAAJ6E7YiI1R4MAqwdNm3l/FV+GjCNBIblki2LePXobaicICLJz65c4w7HR36IRedCnx3ooXImx77QE=
X-Received: by 2002:ac2:5de9:: with SMTP id z9mr7979973lfq.5.1571700267854;
 Mon, 21 Oct 2019 16:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-10-philmd@redhat.com>
In-Reply-To: <20191020225650.3671-10-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2019 16:19:12 -0700
Message-ID: <CAKmqyKP-XsjkzAkXzs1AK9rfec=SK_gijbd6J4CLwK08DGQYFw@mail.gmail.com>
Subject: Re: [PATCH 09/21] hw: Let memory_region_allocate_system_memory take
 MachineState argument
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

On Sun, Oct 20, 2019 at 4:12 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> All the codebase calls memory_region_allocate_system_memory() with
> a NULL 'owner' from the board_init() function.
> Let pass a MachineState argument, and enforce the QOM ownership of
> the system memory.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/core/numa.c      | 11 +++++++----
>  include/hw/boards.h |  6 ++++--
>  2 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 038c96d4ab..2e29e4bfe0 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -520,21 +520,24 @@ static void allocate_system_memory_nonnuma(MemoryRe=
gion *mr, Object *owner,
>      vmstate_register_ram_global(mr);
>  }
>
> -void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owne=
r,
> +void memory_region_allocate_system_memory(MemoryRegion *mr, MachineState=
 *ms,
>                                            const char *name,
>                                            uint64_t ram_size)
>  {
>      uint64_t addr =3D 0;
>      int i;
> -    MachineState *ms =3D MACHINE(qdev_get_machine());
> +
> +    if (!ms) {
> +        ms =3D MACHINE(qdev_get_machine());
> +    }
>
>      if (ms->numa_state =3D=3D NULL ||
>          ms->numa_state->num_nodes =3D=3D 0 || !have_memdevs) {
> -        allocate_system_memory_nonnuma(mr, owner, name, ram_size);
> +        allocate_system_memory_nonnuma(mr, OBJECT(ms), name, ram_size);
>          return;
>      }
>
> -    memory_region_init(mr, owner, name, ram_size);
> +    memory_region_init(mr, OBJECT(ms), name, ram_size);
>      for (i =3D 0; i < ms->numa_state->num_nodes; i++) {
>          uint64_t size =3D ms->numa_state->nodes[i].node_mem;
>          HostMemoryBackend *backend =3D ms->numa_state->nodes[i].node_mem=
dev;
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index de45087f34..3b6cb82b6c 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -14,7 +14,7 @@
>  /**
>   * memory_region_allocate_system_memory - Allocate a board's main memory
>   * @mr: the #MemoryRegion to be initialized
> - * @owner: the object that tracks the region's reference count
> + * @ms: the #MachineState object that own the system memory
>   * @name: name of the memory region
>   * @ram_size: size of the region in bytes
>   *
> @@ -38,8 +38,10 @@
>   * Smaller pieces of memory (display RAM, static RAMs, etc) don't need
>   * to be backed via the -mem-path memory backend and can simply
>   * be created via memory_region_init_ram().
> + *
> + * The #MachineState object will track the region's reference count.
>   */
> -void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owne=
r,
> +void memory_region_allocate_system_memory(MemoryRegion *mr, MachineState=
 *ms,
>                                            const char *name,
>                                            uint64_t ram_size);
>
> --
> 2.21.0
>
>

