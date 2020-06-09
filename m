Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABF6C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 13:08:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A12D20734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 13:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXVwpWqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A12D20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jidzD-0003bL-8d
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 09:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1jidyb-00039O-Py
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 09:07:37 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:38573)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1jidya-0004n7-Od
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 09:07:37 -0400
Received: by mail-il1-x143.google.com with SMTP id b5so20225217iln.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 06:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pXFTLjYkOP1A0xWhzVRdBZjZMZodMb+7rQNJes+y4zU=;
 b=hXVwpWqhy1l7F5QBWyz66qOo/0vWACpchYZ7c1no1QIuX9b4toYCcHT131T2Wr3NQg
 eDMei9AaZSYIn8htOuTfao/WzIZzXdIZj+HTFQZxulWwC7R+bec/bcwfRWYRnb5LVWrN
 PytKO8vIzBJdomm6pNcWPtFVM6dEpF2tm/ijR/QC920bKmAZHug72c21kVvI6+/cXJaa
 Q+Vda0wtvR7ivqVZe1eY/I7ydFjXd0rd0HMjy4EnwFQXnK2irlxq05YvmZVomFnyC9jc
 NrZXIKYaGVhQu8M6ZtS/4oNwwEWR5F+q/r4ZqiXgi6/vTSHrZGIseyPBIum6Bg0r+Ed7
 5ouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pXFTLjYkOP1A0xWhzVRdBZjZMZodMb+7rQNJes+y4zU=;
 b=JOO0GJDG+A5I74NLWQJFkQpXCkoSabJtB+yoHnj4cb3rpQKVsrKkZ8i5zjPCAvAETv
 PLAavzKt/+NQg8Ko9udEvli1SIqxBdbFnWLZ57um7xn30M4CF61d98btkuySq1iRTLb8
 a9laCVkkAIO7oRSxVEC+frQ8k02HLictq8etXUOcs9/OvxKlTmwr8Uja7Ix46TLI/+yy
 OB6kF94WdkpoOtio2TlfEWSSQm+C7aO/jIbX9iNUyF85nk7RbpMh3/rdUNKb+T/SN9oP
 HkcUyUysJ43tQ4T7+0sGb7KjHhrkOUt/4Skib993RW92e4ULM/v4scjEEaF+HtDItTZa
 G/JQ==
X-Gm-Message-State: AOAM530gQZoAJQTBP9pZyN6RcSAfRW4ZQNDMk25Y6KRH7gz/gNAXGgIe
 n5nZuJkci1Vp885mZSffmoaEAJy7tlKBkSu5+8Q=
X-Google-Smtp-Source: ABdhPJxJ797Ho0x36TQp9/mvxon6jsmJ2CEWWxJBLGIHbY62TRoXuobwfX7E1QxhXqYEKjMAZ81pZquZFPgB4EoFtOE=
X-Received: by 2002:a92:a1c9:: with SMTP id b70mr27447402ill.198.1591708055341; 
 Tue, 09 Jun 2020 06:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200609122339.937862-1-armbru@redhat.com>
 <20200609122339.937862-22-armbru@redhat.com>
In-Reply-To: <20200609122339.937862-22-armbru@redhat.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 9 Jun 2020 15:07:23 +0200
Message-ID: <CACXAS8CPhkjs8GDHm0c63C7JFBKtuVMZc9uJRL7Ykmfu42oXQA@mail.gmail.com>
Subject: Re: [PATCH v3 21/24] sparc/leon3: Fix to put grlib,
 * devices on sysbus
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=atar4qemu@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: berrange@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 9, 2020 at 2:23 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> leon3_generic_hw_init() creates a "grlib,ahbpnp" and a "grlib,apbpnp"
> sysbus device in a way that leaves them unplugged.
>
> Create them the common way that puts them into the main system bus.
> Affects machine leon3_generic.  Visible in "info qtree":
>
>      bus: main-system-bus
>        type System
>     +  dev: grlib,ahbpnp, id ""
>     +    mmio 00000000fffff000/0000000000001000
>     +  dev: grlib,apbpnp, id ""
>     +    mmio 00000000800ff000/0000000000001000
>        dev: grlib,irqmp, id ""
>
> Cc: Fabien Chouteau <chouteau@adacore.com>
> Cc: KONRAD Frederic <frederic.konrad@adacore.com>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>

> ---
>  hw/sparc/leon3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 8f024dab7b..3facb8c2ae 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -213,14 +213,14 @@ static void leon3_generic_hw_init(MachineState *mac=
hine)
>      reset_info->sp    =3D LEON3_RAM_OFFSET + ram_size;
>      qemu_register_reset(main_cpu_reset, reset_info);
>
> -    ahb_pnp =3D GRLIB_AHB_PNP(object_new(TYPE_GRLIB_AHB_PNP));
> +    ahb_pnp =3D GRLIB_AHB_PNP(qdev_create(NULL, TYPE_GRLIB_AHB_PNP));
>      object_property_set_bool(OBJECT(ahb_pnp), true, "realized", &error_f=
atal);
>      sysbus_mmio_map(SYS_BUS_DEVICE(ahb_pnp), 0, LEON3_AHB_PNP_OFFSET);
>      grlib_ahb_pnp_add_entry(ahb_pnp, 0, 0, GRLIB_VENDOR_GAISLER,
>                              GRLIB_LEON3_DEV, GRLIB_AHB_MASTER,
>                              GRLIB_CPU_AREA);
>
> -    apb_pnp =3D GRLIB_APB_PNP(object_new(TYPE_GRLIB_APB_PNP));
> +    apb_pnp =3D GRLIB_APB_PNP(qdev_create(NULL, TYPE_GRLIB_APB_PNP));
>      object_property_set_bool(OBJECT(apb_pnp), true, "realized", &error_f=
atal);
>      sysbus_mmio_map(SYS_BUS_DEVICE(apb_pnp), 0, LEON3_APB_PNP_OFFSET);
>      grlib_ahb_pnp_add_entry(ahb_pnp, LEON3_APB_PNP_OFFSET, 0xFFF,
> --
> 2.26.2
>


--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu

