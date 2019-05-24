Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF181C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 795CE20868
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzfNEgjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795CE20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53987 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU9Qo-00030U-Ny
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 08:36:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hU9PB-00021s-Vy
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:34:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hU9PA-0008Ge-Ls
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:34:37 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hU9PA-0008Fh-FN
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:34:36 -0400
Received: by mail-ot1-x343.google.com with SMTP id i8so8506118oth.10
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 05:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=tCn09plksA728Eo8wlZNZ8cCEFr+8E2XrlSp0TSL2Jo=;
	b=AzfNEgjcCHLQSkmTeybbkn5yuGcNozGBzsMMhudXhV2VBWJmV1LITJnL3LgNkMCBEH
	kYqhQDF6PvcSKxu0jptG0YkVey9sAJs382KRqmHCmGC6hKTVe2MV+ZHWCm1em5SPANhK
	20/D/a/Vd2GXo2OH4CcUpaJBFhb1MHatU6PEufKufu5cNxR2I29ojgUYhQZMlE8P8xu6
	vktR1UldgNb9S2J98U2EsrbUtoP9lS1cB9NWz89axAm2IsGTbjNJ8EoPX8BfOeCMR9l7
	7hZudXLkpDxRakwZZBY0VH4u2zrURtEXDZaeOoWHB3UlmM2qtMXftXUghxJoff+03+Np
	1A5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=tCn09plksA728Eo8wlZNZ8cCEFr+8E2XrlSp0TSL2Jo=;
	b=UQA3XsXIyUkh7gfLl/hy6/GJPL8jEftyJA1czHYe5lR2wA7nie/TPqiJRNgwGvkNMv
	5qbBlfo3GjoPkA6aisT9EkmoXc+3F8WP23spEfuLh0IpXWBHvnnULOYLrAXhW6Djt8w1
	NayqAHVnDkJNX2C09b0uYEPC7S9Dbs+q993PyHVmfEBJ1Tkeq9rGo+NEFXkL+FfuoRIe
	Q7rd1O1ggbLO+UD/K/nU1sXHLeq9NOO/Llo4ZwZ9/uQ5ORo+4glAblbvZC5+Li2uGigx
	tNxVgtbcUqQVhkP0JF2OV2QCweQ+PXETF35BpdYI0GigTbit4LYQHGsx4ZYVwmIiJ6YZ
	QiSg==
X-Gm-Message-State: APjAAAWmR4c4ci5pEeJsyuKMKdTTGzeSCxRBsuEQPMxrdFblyZsRV2kV
	4mpehEmjsBXMwjHiLVah1e3wceALp6nx9Kr8LjU=
X-Google-Smtp-Source: APXvYqx/zNsI/UoVypmhOuVZDbkeE/jAnwIH1gAmrnk//Aylj31VNzv2Cjhx1oLkp6vPJhK8ovbFQz+jBMqYtkvf0Bo=
X-Received: by 2002:a9d:6c5a:: with SMTP id g26mr6833729otq.194.1558701274871; 
	Fri, 24 May 2019 05:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190524063553.5339-1-philmd@redhat.com>
	<20190524063553.5339-5-philmd@redhat.com>
In-Reply-To: <20190524063553.5339-5-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 24 May 2019 20:33:58 +0800
Message-ID: <CAKXe6SJaLz5Hmyi-0ZhZvqcZ=HhP78ad_Z5RcBysp70dXxZ4=g@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 04/20] hw/i386/pc: Add the E820Type enum
 type
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
=9C=8824=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=882:45=E5=86=99=E9=81=
=93=EF=BC=9A

> This ensure we won't use an incorrect value.
>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/i386/pc.c         | 12 +++++++-----
>  include/hw/i386/pc.h | 16 ++++++++++------
>  2 files changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 1245028dd6..ac8343c728 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -868,9 +868,10 @@ static void handle_a20_line_change(void *opaque, int
> irq, int level)
>      x86_cpu_set_a20(cpu, level);
>  }
>
> -ssize_t e820_add_entry(uint64_t address, uint64_t length, uint32_t type)
> +ssize_t e820_add_entry(uint64_t address, uint64_t length, E820Type type)
>  {
>      unsigned int index =3D le32_to_cpu(e820_reserve.count);
> +    uint32_t utype =3D (uint32_t)type;
>

I don't have strong opinion for this, as I don't like add an explicit
conversion.



>      struct e820_entry *entry;
>
>      if (type !=3D E820_RAM) {
> @@ -882,7 +883,7 @@ ssize_t e820_add_entry(uint64_t address, uint64_t
> length, uint32_t type)
>
>          entry->address =3D cpu_to_le64(address);
>          entry->length =3D cpu_to_le64(length);
> -        entry->type =3D cpu_to_le32(type);
> +        entry->type =3D cpu_to_le32(utype);
>
>          e820_reserve.count =3D cpu_to_le32(index);
>      }
> @@ -891,7 +892,7 @@ ssize_t e820_add_entry(uint64_t address, uint64_t
> length, uint32_t type)
>      e820_table =3D g_renew(struct e820_entry, e820_table, e820_entries +=
 1);
>      e820_table[e820_entries].address =3D cpu_to_le64(address);
>      e820_table[e820_entries].length =3D cpu_to_le64(length);
> -    e820_table[e820_entries].type =3D cpu_to_le32(type);
> +    e820_table[e820_entries].type =3D cpu_to_le32(utype);
>      e820_entries++;
>
>      return e820_entries;
> @@ -902,10 +903,11 @@ size_t e820_get_num_entries(void)
>      return e820_entries;
>  }
>
> -bool e820_get_entry(unsigned int idx, uint32_t type,
> +bool e820_get_entry(unsigned int idx, E820Type type,
>                      uint64_t *address, uint64_t *length)
>  {
> -    if (idx < e820_entries && e820_table[idx].type =3D=3D cpu_to_le32(ty=
pe)) {
> +    uint32_t utype =3D (uint32_t)type;
> +    if (idx < e820_entries && e820_table[idx].type =3D=3D cpu_to_le32(ut=
ype))
> {
>          *address =3D le64_to_cpu(e820_table[idx].address);
>          *length =3D le64_to_cpu(e820_table[idx].length);
>          return true;
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 2bc48c03c6..10e77a40ce 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -282,12 +282,16 @@ void pc_system_firmware_init(PCMachineState *pcms,
> MemoryRegion *rom_memory);
>  void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>                         const CPUArchIdList *apic_ids, GArray *entry);
>
> -/* e820 types */
> -#define E820_RAM        1
> -#define E820_RESERVED   2
> -#define E820_ACPI       3
> -#define E820_NVS        4
> -#define E820_UNUSABLE   5
> +/**
> + * E820Type: Type of the e820 address range.
> + */
> +typedef enum {
> +    E820_RAM        =3D 1,
> +    E820_RESERVED   =3D 2,
> +    E820_ACPI       =3D 3,
> +    E820_NVS        =3D 4,
> +    E820_UNUSABLE   =3D 5
> +} E820Type;
>
>  ssize_t e820_add_entry(uint64_t, uint64_t, uint32_t);
>  size_t e820_get_num_entries(void);
> --
> 2.20.1
>
>
>
