Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01646C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2892175B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZ7vxDC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2892175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54793 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUAPA-0006Wx-HU
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 09:38:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hUAKU-0001sD-VC
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hUAAP-0001Gr-Jh
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:23:26 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hUAAP-0001DK-D7
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:23:25 -0400
Received: by mail-oi1-x244.google.com with SMTP id a132so7020439oib.2
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 06:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=/dDRLaJf/TCxDzkzWnMYTqXNTD0B4I7tllRWkgA5mOE=;
	b=IZ7vxDC9DIf11I+b2Vy3uPhhCyruolcgh44WemanHrsx5hLkiI3/JNs0hpEzoVdPCc
	kG/085YcDNnBgL2S+EFtMoZQFDVHOh0t3iv2HlFLfPJ22CHXFot5pMU/e9nRv28uENK/
	pU13XAZe4GalrHBhLI80h1Xz6BjO1HhhpnMOiKXuyRsfXID/xFWj9aVYkZOjmAFOrH5Q
	+fn2B85s09/djbe9PgBfB9BC1azsotBDWlDNoUPaZIDlVPsix4fGpczNFy99leVPLkMi
	CPuHcxcwi62BijVvvNBgeF0IMcoAXu8DRqqNHQtamtZiYoBxDr1j/M+lzgV6u0u0LXQ/
	t4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=/dDRLaJf/TCxDzkzWnMYTqXNTD0B4I7tllRWkgA5mOE=;
	b=BjQFm3u4LafiBqXPyhCaaz8bC5TkbjzT04deI8oojHopTQfb4ah/fCXuZUEmcZ0C8G
	DLqE8xlGRgO0lMvs3iuUwX5OoorPjDZHHldwRebYCA8HZuqN2trd0QSr16BmoCO/cCrD
	Hc70X1c01Y0aDLwxsLDVhhaVt8S7FIwHjug1T/K765fZwWbWe93EW+Y3If5ZUMnDqGv+
	2M3qjwfLcMB8scfN86GDyeSKXS/NoeyKdALPnAaq7K0nJl3BprgVh6ZRb5ScUdqQduzi
	5JkYKfyCEHGWzR/iW3w5Uvt1uZpw9w78QwDNFRy85PjUdvxj94CbkbmFzMyoUtxvg1NM
	CfOA==
X-Gm-Message-State: APjAAAXytt6E/YkYK0llvoaTcjLdm8DYsNCVLP77i4p3c9OEQ6KT3+IF
	qebD7Dx8jq+L18wqIH5jjfrQjdiW53dVinrJ3KQ=
X-Google-Smtp-Source: APXvYqz6bXaAbWFxUDVbHaaQLwDZK/G0zYeoGtgguv95XT3MVyJ5E/Z9YvXRKC7tV1ERpKOqaxjWrAek8ggtOUHXv2E=
X-Received: by 2002:aca:b3d7:: with SMTP id c206mr6371367oif.97.1558704204475; 
	Fri, 24 May 2019 06:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190524063553.5339-1-philmd@redhat.com>
	<20190524063553.5339-9-philmd@redhat.com>
In-Reply-To: <20190524063553.5339-9-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 24 May 2019 21:22:48 +0800
Message-ID: <CAKXe6SKwCg=+K8iLBrznqD4ZgDbX97=Oan4J8VAUjvZc14sUtg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 08/20] hw/i386/pc: Use address_space_memory
 in place
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
=9C=8824=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=882:38=E5=86=99=E9=81=
=93=EF=BC=9A

> The address_space_memory variable is used once.
> Use it in place and remove the argument.
>
> Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>

Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  hw/i386/pc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index fc22779ac1..a3936bb29d 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -928,7 +928,7 @@ static void pc_build_smbios(PCMachineState *pcms)
>      }
>  }
>
> -static FWCfgState *bochs_bios_init(AddressSpace *as, PCMachineState *pcm=
s)
> +static FWCfgState *bochs_bios_init(PCMachineState *pcms)
>  {
>      FWCfgState *fw_cfg;
>      uint64_t *numa_fw_cfg;
> @@ -936,7 +936,8 @@ static FWCfgState *bochs_bios_init(AddressSpace *as,
> PCMachineState *pcms)
>      const CPUArchIdList *cpus;
>      MachineClass *mc =3D MACHINE_GET_CLASS(pcms);
>
> -    fw_cfg =3D fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4, as=
);
> +    fw_cfg =3D fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4,
> +                                &address_space_memory);
>      fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
>
>      /* FW_CFG_MAX_CPUS is a bit confusing/problematic on x86:
> @@ -1761,7 +1762,7 @@ void pc_memory_init(PCMachineState *pcms,
>                                          option_rom_mr,
>                                          1);
>
> -    fw_cfg =3D bochs_bios_init(&address_space_memory, pcms);
> +    fw_cfg =3D bochs_bios_init(pcms);
>
>      rom_set_fw(fw_cfg);
>
> --
> 2.20.1
>
>
>
