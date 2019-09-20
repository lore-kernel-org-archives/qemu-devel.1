Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710D1C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 05:20:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 361EE2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 05:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDFUek6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361EE2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBBKv-0002K8-9y
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 01:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1iBBGe-0005hn-P3
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 01:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1iBBGd-0004f5-DH
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 01:15:40 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:42864)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1iBBGd-0004ea-7N; Fri, 20 Sep 2019 01:15:39 -0400
Received: by mail-yw1-xc42.google.com with SMTP id i207so2080407ywc.9;
 Thu, 19 Sep 2019 22:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9wkG71jm8Rk3YgbQqvxPJwcH/NyU1phLwLBHRXsNmCA=;
 b=PDFUek6bLDJq7DOmoh5hk7l8ebz1fnwwYVzzrVFdXbEMtR8Gh7hg0HdFQh3AE1IyC5
 4VGA28DMSfCFxMBDKleNSYR92Gy/AqGFCWWL4JYsD0AA4nG+KpxKIM4TW5p7qzsvFBT7
 R2TEiRNHGJebI8sTbeyMM0MPjFYbuPFbcUXs7c+H2BSCBQ+/NkKCvnFsq0K/KOza0E7X
 +usD6dxpZvacfVfd7gpGpjN7hM3g9uCI9859xgSugBsvTwHzBsTFlNMDj3cVP1DJakuD
 4Sh3RLmaFNffKHx4FD+yx0CrER0tNThvtjCaBLifd8Ep+JOpAW0/pEv/UPX5a/4ijwF3
 I54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9wkG71jm8Rk3YgbQqvxPJwcH/NyU1phLwLBHRXsNmCA=;
 b=ZUpT8a5PqPR2gD2Hh786uWZrY208WguWx/due/zxb2gCR+AHMXvTJJZUrhOQuWX03p
 x0NWzv066I3Cg/IhzBkxHtWSfd5mLTkdMJO2BS0Bp5wBa3t/Hm6ztmIN/Qco/whIR66z
 nAvAK16/3nmYsat6zPHFBHNHIIBIiJX3KkFodDsJkTa2ir2v0hSpRE1GfubldJZnz426
 CFeJUkGtryYaNnP4IGWfdWrJBGWv9pXmwmmniRIzzsgZLKmFPngEyXlSoGNc/JT31i+o
 JIc7wDLKXNgEOlVeDoveR9/EuhqFNPHsDlxicUF/Q8Fv/QH/AcbVTxKp2Tcyd+n4yvOn
 kxaA==
X-Gm-Message-State: APjAAAVj+0JA8SMXPfn3YeG8yvPCqo44hDliQDAHJBXfggAcHxKVloBA
 pgn5IC0jnxKec48nAWgJ+aytdfud6J/j6/Wa+00=
X-Google-Smtp-Source: APXvYqw58Z5orDVnn/coYkr+bhffUttMe2SQbPaTs52OwnvtHvOF4CN3OAn3GK/8stBA8DDWOhS2l0G0groygJ08dy8=
X-Received: by 2002:a81:4cc8:: with SMTP id
 z191mr10694394ywa.137.1568956538641; 
 Thu, 19 Sep 2019 22:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568931866.git.alistair.francis@wdc.com>
 <95b47a08da3038df82cd1cc9d69cd005270906f8.1568931866.git.alistair.francis@wdc.com>
In-Reply-To: <95b47a08da3038df82cd1cc9d69cd005270906f8.1568931866.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 20 Sep 2019 13:15:25 +0800
Message-ID: <CAEUhbmWrNY=acPa=W71DhGoJC9uAzETjWnOFfq8XH2_96bhMvg@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] riscv/sifive_u: Manually define the machine
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
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
Cc: Alistair Francis <alistair23@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 20, 2019 at 6:34 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Instead of using the DEFINE_MACHINE() macro to define the machine let's
> do it manually. This allows us to specify machine properties.
>
> This patch is no functional change.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/sifive_u.c         | 27 +++++++++++++++++++++++----
>  include/hw/riscv/sifive_u.h |  7 ++++++-
>  2 files changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 9c5d791320..c3949fb316 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -310,8 +310,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>  static void riscv_sifive_u_init(MachineState *machine)
>  {
>      const struct MemmapEntry *memmap = sifive_u_memmap;
> -
> -    SiFiveUState *s = g_new0(SiFiveUState, 1);
> +    SiFiveUState *s = RISCV_U_MACHINE(machine);
>      MemoryRegion *system_memory = get_system_memory();
>      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
>      MemoryRegion *flash0 = g_new(MemoryRegion, 1);
> @@ -545,8 +544,15 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>          memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
>  }
>
> -static void riscv_sifive_u_machine_init(MachineClass *mc)
> +static void riscv_sifive_u_machine_instance_init(Object *obj)
> +{
> +

nits: remove this blank line

> +}
> +
> +static void riscv_sifive_u_machine_class_init(ObjectClass *oc, void *data)
>  {
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
>      mc->desc = "RISC-V Board compatible with SiFive U SDK";
>      mc->init = riscv_sifive_u_init;
>      mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
> @@ -554,7 +560,20 @@ static void riscv_sifive_u_machine_init(MachineClass *mc)
>      mc->default_cpus = mc->min_cpus;
>  }
>
> -DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)
> +static const TypeInfo riscv_sifive_u_machine_init_typeinfo = {

nits: riscv_sifive_u_machine_typeinfo (no _init for consistency with others)

> +    .name       = MACHINE_TYPE_NAME("sifive_u"),
> +    .parent     = TYPE_MACHINE,
> +    .class_init = riscv_sifive_u_machine_class_init,
> +    .instance_init = riscv_sifive_u_machine_instance_init,
> +    .instance_size = sizeof(SiFiveUState),
> +};
> +
> +static void riscv_sifive_u_machine_init_register_types(void)
> +{
> +    type_register_static(&riscv_sifive_u_machine_init_typeinfo);
> +}
> +
> +type_init(riscv_sifive_u_machine_init_register_types)

nits: I would move the machine declaration to after the sifive_u SoC
declaration in this file.

>
>  static void riscv_sifive_u_soc_class_init(ObjectClass *oc, void *data)
>  {
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index 2a08e2a5db..a921079fbe 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -44,12 +44,17 @@ typedef struct SiFiveUSoCState {
>      CadenceGEMState gem;
>  } SiFiveUSoCState;
>
> +#define TYPE_RISCV_U_MACHINE MACHINE_TYPE_NAME("sifive_u")
> +#define RISCV_U_MACHINE(obj) \
> +    OBJECT_CHECK(SiFiveUState, (obj), TYPE_RISCV_U_MACHINE)
> +
>  typedef struct SiFiveUState {
>      /*< private >*/
> -    SysBusDevice parent_obj;
> +    MachineState parent_obj;
>
>      /*< public >*/
>      SiFiveUSoCState soc;
> +
>      void *fdt;
>      int fdt_size;
>  } SiFiveUState;
> --

Regards,
Bin

