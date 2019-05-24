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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1E8C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0EB217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYa/D6H0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0EB217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54757 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUANO-0004ys-DD
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 09:36:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hUAKK-0002Fb-Mb
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hUADz-0003fj-Kt
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:27:08 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hUADz-0003eu-BX
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:27:07 -0400
Received: by mail-ot1-x344.google.com with SMTP id u11so8657795otq.7
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 06:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=mYlpT/2x3P3Q4pnWfTYeEJ6adGNeXy3CSb3fcqPEqIg=;
	b=fYa/D6H0yZNoYwXbt6kkGjPbT2Nd4tMlKGQTd5UPfn3hDTTye+xy/Ums/C8qJyAVBi
	Nk/AyuIzOcxCFynrM3uKdnaoMAZNKlwi2KPZJqPsr44wcpZ2cTqG56WvX/4cGHEN1vve
	o8Nf9fSrKkMQdDHhEHT+52OD+MYUHgsrLR9iIB0zjEOV238eXwdcacDLnlq+4IFHM4G2
	aWcY/Hi8XIDLJ9eW+NdE4Vq4N+JRKax6nrx8jOEa1n4/GSceLQBq9jAZh21oYWjR2wwZ
	TCpHgK5cvnzcN22mAjXV3x4HVGNDo3rBa2tcY7DXgDERT73eEfmBjiwc3zraBeYyrcjz
	aPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=mYlpT/2x3P3Q4pnWfTYeEJ6adGNeXy3CSb3fcqPEqIg=;
	b=MaQmBSTdm/x7WvL6ALLlVgObhf7tOxdQpFOwCwgBgmz3Y/V9W72OhXDevoaTasAAW5
	55pnpf7WMMRyAcKnybaNfNEp4bNpJD2BkAl1W3/37MMoVqSr+Ur4vUAvpNg9LAC/L4NG
	NaqndUptzHLymx6kmN85t7cYF103vSv9LlQlUBMsW5SdTCtIw65MkCkVykTIaMK3OzW3
	JCFeA1uILELdraB49XrsC3imSD9Rz2RRZHgsOgsYbXXAYfGweI1kmFaKbAL52R/LaOnX
	Hl6rKaFzihxSJKGbSNwenH7d6xLjxsNGDw0/DjMQJ9EcRdG6XAY1rfN3TcpcwLV6pQRv
	sCDg==
X-Gm-Message-State: APjAAAUpCqfE2xm9xpccIsKgcNQ8kUwNYvpZIWHRU16Zx1+l+33agxb6
	62z+NcVDNNaKBQruDg8jNf4IrN38UtMXESS368Y=
X-Google-Smtp-Source: APXvYqxkaHIV0ZBUwFLeoIcnjfCJt4g5Ar/U5KNNZ5ymvRwryCiGbfug5jPCeW8ez1Pj0gY2UKJg1fJ69WKErJ9BPow=
X-Received: by 2002:a9d:3f37:: with SMTP id m52mr27487874otc.181.1558704426434;
	Fri, 24 May 2019 06:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190524063553.5339-1-philmd@redhat.com>
	<20190524063553.5339-10-philmd@redhat.com>
In-Reply-To: <20190524063553.5339-10-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 24 May 2019 21:26:30 +0800
Message-ID: <CAKXe6SJs+_cduvdpVExS64FvPsb_p-j4yVX1umc065jnSCu07Q@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 09/20] hw/i386/pc: Rename bochs_bios_init()
 more generic as x86_create_fw_cfg()
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
=9C=8824=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=882:46=E5=86=99=E9=81=
=93=EF=BC=9A

> The bochs_bios_init() is not restricted to the Bochs BIOS and is
> useful to other BIOS. Rename it to be more generic.
>
> Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>

Reviewed-by: Li Qiang <liq3ea@gmail.com>



> ---
>  hw/i386/pc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index a3936bb29d..264074489b 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -928,7 +928,7 @@ static void pc_build_smbios(PCMachineState *pcms)
>      }
>  }
>
> -static FWCfgState *bochs_bios_init(PCMachineState *pcms)
> +static FWCfgState *x86_create_fw_cfg(PCMachineState *pcms)
>  {
>      FWCfgState *fw_cfg;
>      uint64_t *numa_fw_cfg;
> @@ -1508,7 +1508,7 @@ void pc_cpus_init(PCMachineState *pcms)
>       * Limit for the APIC ID value, so that all
>       * CPU APIC IDs are < pcms->apic_id_limit.
>       *
> -     * This is used for FW_CFG_MAX_CPUS. See comments on
> bochs_bios_init().
> +     * This is used for FW_CFG_MAX_CPUS. See comments on
> x86_create_fw_cfg().
>       */
>      pcms->apic_id_limit =3D x86_cpu_apic_id_from_index(max_cpus - 1) + 1=
;
>      possible_cpus =3D mc->possible_cpu_arch_ids(ms);
> @@ -1762,7 +1762,7 @@ void pc_memory_init(PCMachineState *pcms,
>                                          option_rom_mr,
>                                          1);
>
> -    fw_cfg =3D bochs_bios_init(pcms);
> +    fw_cfg =3D x86_create_fw_cfg(pcms);
>
>      rom_set_fw(fw_cfg);
>
> --
> 2.20.1
>
>
>
