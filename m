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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F23C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:00:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B64523787
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEGD/F08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B64523787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKleO-0006TI-Qn
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kKlao-0002s1-Ri; Tue, 22 Sep 2020 12:56:38 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:40595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kKlam-00068B-G6; Tue, 22 Sep 2020 12:56:38 -0400
Received: by mail-io1-xd44.google.com with SMTP id j2so20371515ioj.7;
 Tue, 22 Sep 2020 09:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MOrrgD2OLrn/zJyHEpYBTkI3bZ7N3UGcFQFv8ErJHm4=;
 b=XEGD/F08HsGxVV6VFFN64ovR0VwKoE5DvTTf71Bv3nzoVFm1g+MIsTK294D+mUjA7r
 lF58ezNiXhXyHr06bQJ/zNhgrSyoYjFhVFSBvPbBeMytvbTGwiNyOrdFXcP161GmAebG
 lsE1W4oyahIW3aQy5jAhqJ1Rk46xWI9eepRguDL0/DuU8uNmegfVPCQcG6AqQ684U2Aw
 SbE+2bNHztGW8kcOFoNg5EPuM7AQBjDq9pAFDu1U4FhYCe90TfVcFuSVF4EC2XDps64w
 B0PVO2Pb/MEy4iD8U0WhXTSNhxDUubqdHiHFmbO8poBU/n9itK52zMd/eoHkbyr6gyhg
 peFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MOrrgD2OLrn/zJyHEpYBTkI3bZ7N3UGcFQFv8ErJHm4=;
 b=J0PS2N2V3Zn8bZfATEb1X5JUvbj28/XtdUfPF89J8W9udC2KBZBuRP/v8bbgeNFQmq
 00gBezYVmXKnXzFcawSSD8W+FDsJfQIn9BL9eM6Q0BrsmfIlJPx0l8Hpn2Qq7OEbbRPP
 zcPonF5bJkWUsm90Z00mrw60+bAMaf33L8SvRTI92b5SLOHflKpftxnH6JBNKILmb+sG
 v+jbAqiiiKyY1EFUZu0VFvDREV5AvmmeWcKgA5T79mEOwQBm6gfpYjL/zTt4d6+0HzRI
 hpSY3DvAuvbTTs20HQMpeUqEjCOU4bpyC6cbcwwwHGNUhf7ECxWeVy57KUwKtVfjs9Jt
 Xg3A==
X-Gm-Message-State: AOAM533MiGesYqi/yXFrUNcdd3ZA7UsSZdcK6GNZYyM/IqpQ+rO6fPRK
 kAhYKBKyQJGri5W9HU0FZkHho3x4mBX7F9vcfpc=
X-Google-Smtp-Source: ABdhPJz4iiNgLQw0XLJQnRkYoJW7BUvA6kzd8qhQSW36S6rilyGj3Pl5ji+v0zzxQaQS9/pRN/vY/AqiNDeW1BHXZY0=
X-Received: by 2002:a05:6638:3f2:: with SMTP id
 s18mr4993977jaq.26.1600793795257; 
 Tue, 22 Sep 2020 09:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200921221045.699690-1-ehabkost@redhat.com>
 <20200921221045.699690-24-ehabkost@redhat.com>
In-Reply-To: <20200921221045.699690-24-ehabkost@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 22 Sep 2020 09:45:21 -0700
Message-ID: <CAKmqyKMxDQZaqt_XO9M98BWgomf1Wj=hVAxrUfN-YsM_PZAqDQ@mail.gmail.com>
Subject: Re: [PATCH 23/24] sifive_e: Register "revb" as class property
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
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

On Mon, Sep 21, 2020 at 3:30 PM Eduardo Habkost <ehabkost@redhat.com> wrote:
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
>  hw/riscv/sifive_e.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 40bbf530d49..9fe0c12df64 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -137,11 +137,6 @@ static void sifive_e_machine_instance_init(Object *obj)
>      SiFiveEState *s = RISCV_E_MACHINE(obj);
>
>      s->revb = false;
> -    object_property_add_bool(obj, "revb", sifive_e_machine_get_revb,
> -                             sifive_e_machine_set_revb);
> -    object_property_set_description(obj, "revb",
> -                                    "Set on to tell QEMU that it should model "
> -                                    "the revB HiFive1 board");
>  }
>
>  static void sifive_e_machine_class_init(ObjectClass *oc, void *data)
> @@ -152,6 +147,12 @@ static void sifive_e_machine_class_init(ObjectClass *oc, void *data)
>      mc->init = sifive_e_machine_init;
>      mc->max_cpus = 1;
>      mc->default_cpu_type = SIFIVE_E_CPU;
> +
> +    object_class_property_add_bool(oc, "revb", sifive_e_machine_get_revb,
> +                                   sifive_e_machine_set_revb);
> +    object_class_property_set_description(oc, "revb",
> +                                          "Set on to tell QEMU that it should model "
> +                                          "the revB HiFive1 board");
>  }
>
>  static const TypeInfo sifive_e_machine_typeinfo = {
> --
> 2.26.2
>
>

