Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B184C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 19:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DD7F206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 19:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD7F206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiNrf-0005PP-D6
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 15:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>)
 id 1jiNqs-0004rf-Bf; Mon, 08 Jun 2020 15:54:34 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:41694)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>)
 id 1jiNqp-0005i0-N2; Mon, 08 Jun 2020 15:54:33 -0400
Received: by mail-ej1-f68.google.com with SMTP id x1so19694674ejd.8;
 Mon, 08 Jun 2020 12:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+sqv/n+dHdqVQBBv8HoeSPhIX6ntoKrWvEWJ5bo+JBY=;
 b=tz8z038QlT7UJZiRlc0I9j8QE6jwUc//9JdqZSsbdjqWUmz6DprZfOazcwBJp7Ftmc
 ATJ0G+AlBY7KHHoofkcrMYSFMhtHDrYG7xhC/0M7uEzmG6O6oBvThkZ5E1VuDl5mN51V
 7BShXXr1bjoy/Jg/qI+DKBgmeeGDqSp/spQ87Tgq68EyHwDAbalyuJDhWCE/hevXIbW8
 Iic49q6NdF6ZgoSFxb/lM6HBels41Pmq21WTbHHN0iFFD03DJ/6YsaRDZSY9WHZl4uZB
 70cl/7/mWjaWK3XxrshDgItb+uZBPP0qxL5ITJnMKBS4UNeOyOyG6jIvAStx8/044xZ5
 +vxA==
X-Gm-Message-State: AOAM532zvVCYP5HyLYboJGmNu+4TC4zWHPJpKe8LYqIQPUy709Ij6Mxq
 3Dcj908ZC0UlXLdhc4WAg9o=
X-Google-Smtp-Source: ABdhPJyCrlier8KckyArgpVfsoeX+3W0TZBdF5noENbZMiCB7EHb731EzfTxbYKJrA1Y2+nQa+g7kQ==
X-Received: by 2002:a17:906:d9dc:: with SMTP id
 qk28mr14717135ejb.6.1591646068901; 
 Mon, 08 Jun 2020 12:54:28 -0700 (PDT)
Received: from thl530.multi.box (p5791d09b.dip0.t-ipconnect.de.
 [87.145.208.155])
 by smtp.gmail.com with ESMTPSA id bg21sm11672524ejb.90.2020.06.08.12.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 12:54:28 -0700 (PDT)
Date: Mon, 8 Jun 2020 21:54:21 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [RFC PATCH 22/35] hw/m68k/mcf520x: Emit warning when old code
 is used
Message-ID: <20200608215421.6322016c@thl530.multi.box>
In-Reply-To: <20200608160044.15531-23-philmd@redhat.com>
References: <20200608160044.15531-1-philmd@redhat.com>
 <20200608160044.15531-23-philmd@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.218.68; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f68.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 15:54:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org,
 Stafford Horne <shorne@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am Mon,  8 Jun 2020 18:00:31 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:

> This code hasn't been QOM'ified yet. Warn the user.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/m68k/mcf5206.c | 5 +++++
>  hw/m68k/mcf5208.c | 3 +++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
> index a2fef04f8e..ec0d176674 100644
> --- a/hw/m68k/mcf5206.c
> +++ b/hw/m68k/mcf5206.c
> @@ -16,6 +16,7 @@
>  #include "qemu/timer.h"
>  #include "hw/ptimer.h"
>  #include "sysemu/sysemu.h"
> +#include "hw/qdev-deprecated.h"
> =20
>  /* General purpose timer module.  */
>  typedef struct {
> @@ -144,6 +145,8 @@ static m5206_timer_state
> *m5206_timer_init(qemu_irq irq) {
>      m5206_timer_state *s;
> =20
> +    qdev_warn_deprecated_function_used();
> +
>      s =3D g_new0(m5206_timer_state, 1);
>      s->timer =3D ptimer_init(m5206_timer_trigger, s,
> PTIMER_POLICY_DEFAULT); s->irq =3D irq;
> @@ -566,6 +569,8 @@ qemu_irq *mcf5206_init(MemoryRegion *sysmem,
> uint32_t base, M68kCPU *cpu) m5206_mbar_state *s;
>      qemu_irq *pic;
> =20
> +    qdev_warn_deprecated_function_used();
> +
>      s =3D g_new0(m5206_mbar_state, 1);

Ok, it's quite obvious what you refer to here...

>      memory_region_init_io(&s->iomem, NULL, &m5206_mbar_ops, s,
> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
> index 2ab9701ad6..72627f6833 100644
> --- a/hw/m68k/mcf5208.c
> +++ b/hw/m68k/mcf5208.c
> @@ -26,6 +26,7 @@
>  #include "hw/sysbus.h"
>  #include "elf.h"
>  #include "exec/address-spaces.h"
> +#include "hw/qdev-deprecated.h"
> =20
>  #define SYS_FREQ 166666666
> =20
> @@ -191,6 +192,8 @@ static void mcf5208_sys_init(MemoryRegion
> *address_space, qemu_irq *pic) m5208_timer_state *s;
>      int i;
> =20
> +    qdev_warn_deprecated_function_used();
> +
>      /* SDRAMC.  */
>      memory_region_init_io(iomem, NULL, &m5208_sys_ops, NULL,
> "m5208-sys", 0x00004000); memory_region_add_subregion(address_space,
> 0xfc0a8000, iomem);

... but it is not so obvious what you refer to here. I think that new
function should maybe have a "char *what" parameter that contains the
name of the struct you refer to. Or at least add a comment in front of
the function with a short description?

 Thomas

