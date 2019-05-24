Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D543C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 15:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56AA20815
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 15:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEYegJic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56AA20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56384 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCGq-0003L4-6u
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 11:38:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hUCCk-0008I1-In
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hUC9q-0000zB-7q
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:30:59 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hUC9p-0000yh-Vt
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:30:58 -0400
Received: by mail-oi1-x241.google.com with SMTP id u64so7344512oib.1
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 08:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=z8YRA/h9eHF5FlwyPNkwoKAR9ps+6VIhgLnM44sLbqY=;
	b=UEYegJic6neCJ0oriEwR+cIBdxFqm0x23euQ4uAZB25UfLeeHh5pLxl8SjydHKocZE
	TYwsuN5rIMpVoAioFOVQUAbLzleepck/S7jnGpOfyJ0M9RLktdYDAAjjT4Dy6POlgZzr
	DeXQTbpVEZiboNhP3prvRHjg5xVG+DomxBHFHTQSrRBiea5MKh1mDmoufwXk/nDSqFju
	BLLOMoJWtYiXE0a5evx3rgf/8nrhqw1R2zWvxSzNmjLs4OvaAcAMzoougzfqWdmaFNA0
	O/WCx0M7SjoIDezkPh5n40w04DJ5hAYWAP7ZVA/rWa3K7VX1oOhpUjj1x/23BwJC6Ycm
	Hrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=z8YRA/h9eHF5FlwyPNkwoKAR9ps+6VIhgLnM44sLbqY=;
	b=njiE2sHTbhNrwpgWnfWWBiVxSg/uxPaRJ0u5Nc2aY7i00m1mL3iwHFY1XvqaZqU9sL
	d73MgIyDMkuqhnV3nmggT63eodFhThCj4iXnPj1E71L+2dHqeDDuIjR64IZuJdeNnAu3
	odQd7YZGuszf8+SmBVK/vb68BcZVCPYdMntGvrrlo00R93/Qj0Gzy9oJl7ojiWiPZ9Po
	BqvORD+M/FR3VvPdDMX29Jd9ILgtPBYGOLLfSGo7rp6cYxGZ6VYjJSk1VdETpG36fJ41
	5YDxrswJjoHJko4hYYdqzQvGljtZJXPznCyJPPO1xzIPC2lD7/eDwg/9x9IDUmlC/j6d
	tviQ==
X-Gm-Message-State: APjAAAVK5rvt4+Ge+wkv89soVaeREgoM+Pj97FbF3xq7Kr1sl37rd/Kw
	jiPm4IrHBFzPHNw3xGYEVq4SmDyvJ7A4rNv+EoM=
X-Google-Smtp-Source: APXvYqzBaooSq/Tuq7gytaKmMkyy7NKHbYy2SIz6aB9PZ1M9CQ+GXVRNfMiSqy77vU5Tu0GxmwHU5KOVsRw2ZRDs4iA=
X-Received: by 2002:aca:1807:: with SMTP id h7mr6460131oih.150.1558711856933; 
	Fri, 24 May 2019 08:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190524063553.5339-1-philmd@redhat.com>
	<20190524063553.5339-11-philmd@redhat.com>
In-Reply-To: <20190524063553.5339-11-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 24 May 2019 23:30:20 +0800
Message-ID: <CAKXe6SLrVkLhe3bG-_LsJd0qKBM8NQ-jDJjat80xLkqp8cg_ug@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 10/20] hw/i386/pc: Pass the boot_cpus value
 by argument
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Yang Zhong <yang.zhong@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
	Rob Bradford <robert.bradford@intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Qemu Developers <qemu-devel@nongnu.org>,
	Samuel Ortiz <sameo@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B45=E6=
=9C=8824=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=882:50=E5=86=99=E9=81=
=93=EF=BC=9A

> The boot_cpus is used once. Pass it by argument, this will
> allow us to remove the PCMachineState argument later.
>
> Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/i386/pc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 264074489b..01894b9875 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -928,7 +928,7 @@ static void pc_build_smbios(PCMachineState *pcms)
>      }
>  }
>
> -static FWCfgState *x86_create_fw_cfg(PCMachineState *pcms)
> +static FWCfgState *x86_create_fw_cfg(PCMachineState *pcms, uint16_t
> boot_cpus)
>


For the patches 10/11/12, I don't think this is an elegant solution. When
we add more data like 'boot_cpus'
we need add more arguments?


Thanks,
Li Qiang




>  {
>      FWCfgState *fw_cfg;
>      uint64_t *numa_fw_cfg;
> @@ -938,7 +938,7 @@ static FWCfgState *x86_create_fw_cfg(PCMachineState
> *pcms)
>
>      fw_cfg =3D fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4,
>                                  &address_space_memory);
> -    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
> +    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, boot_cpus);
>
>      /* FW_CFG_MAX_CPUS is a bit confusing/problematic on x86:
>       *
> @@ -1762,7 +1762,7 @@ void pc_memory_init(PCMachineState *pcms,
>                                          option_rom_mr,
>                                          1);
>
> -    fw_cfg =3D x86_create_fw_cfg(pcms);
> +    fw_cfg =3D x86_create_fw_cfg(pcms, pcms->boot_cpus);
>
>      rom_set_fw(fw_cfg);
>
> --
> 2.20.1
>
>
>
