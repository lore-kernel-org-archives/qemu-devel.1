Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B40C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:57:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4433922262
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuttFKve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4433922262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKlbj-0003hm-8b
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 12:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kKla1-00025R-C7; Tue, 22 Sep 2020 12:55:50 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:43940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kKlZz-00065O-OZ; Tue, 22 Sep 2020 12:55:49 -0400
Received: by mail-il1-x142.google.com with SMTP id a19so17986061ilq.10;
 Tue, 22 Sep 2020 09:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fPIloXHzv7gWibrXw2Xpn1iYJ0MbEW8JCdQeOBp0bBg=;
 b=OuttFKve44X/zIOmhJ+0gPi9QsNFxoJVLb63JF843VzLkU5E+YnKSKXMtJ8ehaz+fS
 ply2OWjdC18+J2FxAveopbP8gXaZA9aQPUqZu4HAgm1+U6OPI2PUCw1WhAQM34S8dcI3
 AvXfV34oqBDn0LL1Ckf3Uswj40XFsEUzfeueWxfPHB8kxpHsO7L7CKMt5hk84F4WmdJS
 BlcRNKtObi7RoxJTbfVM/wzCF7Jgiknx5mij4b1SpKjVnyAqOMJiKdsgyFS7l7SFNaqr
 +gaUy3lsWXHAemnUWjB+qjbjTUwGVM3vWZSG/5Ooh1EQCgJ1Ag2ukyCDW5IcHld1fN9O
 SKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fPIloXHzv7gWibrXw2Xpn1iYJ0MbEW8JCdQeOBp0bBg=;
 b=Un0i96QVbqdSCXxurxfXQexiGWD2sKDUybC9jGotzZd7KXbHXxi/+S5A6UvQFyD/RQ
 XScvbv3KtYHTsY+beMuPVQSgw/k4zuNvQVC9rJ9IhCAkv7VyKMupfZF4A8Fbkm4whKus
 WoX38OwylENzYreh7rQDiUlDnyBVnzDRtLqS7GZwuujUMPNA9FB4bcAJME1Lb6cAmZ09
 hDtG1gqjfFqZvsbnIWJTo/QsV8K9jw8rWyybYo8HfAQLWSkcuz37g0e1V5bg8RSHtNW/
 U+zwIz5nM2dBOkI5u8UskoThz4ems4uD7WJXDziQ3EEMXfWrAyYM2eMmGNcjFalz9P5F
 PyxA==
X-Gm-Message-State: AOAM532wbo5VAdauLljavEyI6o87XyZw/bQnQhiDuiekVplzcx44rJSN
 eCdlILN72rSdDZmGtVJXllYtZrlEhRXR1UqSSlk=
X-Google-Smtp-Source: ABdhPJw6Qd1ggEET8h99DXMsVjOA8l4fVgHc7LdQX0iLHmv4bX2Nu8v2AkP8i9jEUqj4QIS8v8o8U32R7VB3JiRVDDA=
X-Received: by 2002:a92:8b52:: with SMTP id i79mr5301777ild.177.1600793744864; 
 Tue, 22 Sep 2020 09:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200921221045.699690-1-ehabkost@redhat.com>
 <20200921221045.699690-25-ehabkost@redhat.com>
In-Reply-To: <20200921221045.699690-25-ehabkost@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 22 Sep 2020 09:44:31 -0700
Message-ID: <CAKmqyKM9OvBHzPSppDBcz4usa_ZgXu7v7Sxw8QRXRRiQ6mA8Mg@mail.gmail.com>
Subject: Re: [PATCH 24/24] sifive_u: Register "start-in-flash" as class
 property
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 21, 2020 at 3:21 PM Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> Class properties make QOM introspection simpler and easier, as
> they don't require an object to be instantiated.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: qemu-riscv@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  hw/riscv/sifive_u.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 4f12a93188d..0f0fab9a47b 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -568,14 +568,6 @@ static void sifive_u_machine_instance_init(Object *obj)
>      SiFiveUState *s = RISCV_U_MACHINE(obj);
>
>      s->start_in_flash = false;
> -    object_property_add_bool(obj, "start-in-flash",
> -                             sifive_u_machine_get_start_in_flash,
> -                             sifive_u_machine_set_start_in_flash);
> -    object_property_set_description(obj, "start-in-flash",
> -                                    "Set on to tell QEMU's ROM to jump to "
> -                                    "flash. Otherwise QEMU will jump to DRAM "
> -                                    "or L2LIM depending on the msel value");
> -
>      s->msel = 0;
>      object_property_add(obj, "msel", "uint32",
>                          sifive_u_machine_get_uint32_prop,
> @@ -599,6 +591,14 @@ static void sifive_u_machine_class_init(ObjectClass *oc, void *data)
>      mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
>      mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
>      mc->default_cpus = mc->min_cpus;
> +
> +    object_class_property_add_bool(oc, "start-in-flash",
> +                                   sifive_u_machine_get_start_in_flash,
> +                                   sifive_u_machine_set_start_in_flash);
> +    object_class_property_set_description(oc, "start-in-flash",
> +                                          "Set on to tell QEMU's ROM to jump to "
> +                                          "flash. Otherwise QEMU will jump to DRAM "
> +                                          "or L2LIM depending on the msel value");
>  }
>
>  static const TypeInfo sifive_u_machine_typeinfo = {
> --
> 2.26.2
>
>

