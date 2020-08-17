Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D85C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1B2206C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfHi29dK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1B2206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bpY-0007SP-AH
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k7bp1-00071h-L5
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 05:52:55 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:39586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k7bp0-0004R2-3M
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 05:52:55 -0400
Received: by mail-yb1-xb43.google.com with SMTP id q16so9088192ybk.6
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 02:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZzimqhwgrDEi+ZhRf8NMe0DT+iTTLK5LuyTz+IU9jiM=;
 b=lfHi29dKK1YPaqRXaLZs4TC5ILYiXPaeIIm01fwpkDouns8720yNFwXW+kWKU3UezV
 wHxGVzFzSiAbzIuUrA3aRZfmQ7apa3V9exPOb8gv2o60a6l+aNbbk4R/IPbT/plLpsNX
 ixcmNw19aSfjCIc2os5wSy1Ems68zrpIh91JApT1O9U8zhbYkuZv1kqE+eY5icXoccUE
 cav2X5RnxAB/Go81tOT6v8F+H+C3tXFfHVxgIQSg+/X6rQew5YmxPQOHzOBUEjKMS78O
 jn09p1hxwcAZ3aIXKpxoOEnJdGCaSNjTRaVpcNMDpQWcJr7RBjMLNbWEHx7lf2PqULXU
 dWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZzimqhwgrDEi+ZhRf8NMe0DT+iTTLK5LuyTz+IU9jiM=;
 b=cOlP6T4poD9KuVClPq4o6d9paj07vNA9MeaYmmYQLG4cGRarMB86xpBy2Fv79WBWBB
 IgC4itwNh4Y8reXqr4DXpnboHKcfb0Njpm7YrTfHxyGy2/Hlpngf25MjMDfambiaT0Ac
 +wPU/f0booK1koGCR29pzqPa+tVrQOT/NCv8AWceYpekp98M8OdAetlXjeHC3PxoVI7y
 3S6rk91KEC14mXRGgMWn8/khdYRKhj+PSvr/KiTtLjt9PC5ykn6nYQHKs6IMhfwj6JIg
 AfcthHxPv5QYC2N7K0X/vIQtOi4u/f7V5Yc+xeLu04hshHVU/46YGc8L0brSQpu5K6V8
 +OUg==
X-Gm-Message-State: AOAM530A5PU+T7oaM1WNw57uzgTEl2HCPcZPU6SWrJ0y0ZeKeOblXtRc
 eItMcWa6bCEtiQVb9Ib8ZfnkxfUxzZ8lt+a93HA=
X-Google-Smtp-Source: ABdhPJy9+cjJ5GYKaMVcriFBSu3FutF5qacrexgwgl0aVbpQFFnltqv/v66Z3yNJ4wwjTDWXIFwcHhzsjSurB5x3PnY=
X-Received: by 2002:a25:f20d:: with SMTP id i13mr19200670ybe.152.1597657972724; 
 Mon, 17 Aug 2020 02:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200813222625.243136-9-ehabkost@redhat.com>
 <5a14f92e-139d-38e5-5ffe-c77636c090be@amsat.org>
In-Reply-To: <5a14f92e-139d-38e5-5ffe-c77636c090be@amsat.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 17 Aug 2020 17:52:41 +0800
Message-ID: <CAEUhbmX=7+ke100stoVFq7A++Lhy-7zoggB=Of3KrWPTf6C0gA@mail.gmail.com>
Subject: Re: [PATCH 08/41] opentitan: Rename memmap enum constants
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b43;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 15, 2020 at 1:56 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 8/14/20 12:25 AM, Eduardo Habkost wrote:
> > Some of the enum constant names conflict with the QOM type check
> > macros.  This needs to be addressed to allow us to transform the
> > QOM type check macros into functions generated by
> > OBJECT_DECLARE_TYPE().
> >
> > Rename all the constants to IBEX_DEV_*, to avoid conflicts.
> >
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  include/hw/riscv/opentitan.h | 38 ++++++++--------
> >  hw/riscv/opentitan.c         | 84 ++++++++++++++++++------------------
> >  2 files changed, 61 insertions(+), 61 deletions(-)
> >
> > diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.=
h
> > index 8f29b9cbbf..835a80f896 100644
> > --- a/include/hw/riscv/opentitan.h
> > +++ b/include/hw/riscv/opentitan.h
> > @@ -49,25 +49,25 @@ typedef struct OpenTitanState {
> >  } OpenTitanState;
> >
> >  enum {
> > -    IBEX_ROM,
> > -    IBEX_RAM,
> > -    IBEX_FLASH,
> > -    IBEX_UART,
> > -    IBEX_GPIO,
> > -    IBEX_SPI,
> > -    IBEX_FLASH_CTRL,
> > -    IBEX_RV_TIMER,
> > -    IBEX_AES,
> > -    IBEX_HMAC,
> > -    IBEX_PLIC,
> > -    IBEX_PWRMGR,
> > -    IBEX_RSTMGR,
> > -    IBEX_CLKMGR,
> > -    IBEX_PINMUX,
> > -    IBEX_ALERT_HANDLER,
> > -    IBEX_NMI_GEN,
> > -    IBEX_USBDEV,
> > -    IBEX_PADCTRL,
> > +    IBEX_DEV_ROM,
> > +    IBEX_DEV_RAM,
> > +    IBEX_DEV_FLASH,
> > +    IBEX_DEV_UART,
> > +    IBEX_DEV_GPIO,
> > +    IBEX_DEV_SPI,
> > +    IBEX_DEV_FLASH_CTRL,
> > +    IBEX_DEV_RV_TIMER,
> > +    IBEX_DEV_AES,
> > +    IBEX_DEV_HMAC,
> > +    IBEX_DEV_PLIC,
> > +    IBEX_DEV_PWRMGR,
> > +    IBEX_DEV_RSTMGR,
> > +    IBEX_DEV_CLKMGR,
> > +    IBEX_DEV_PINMUX,
> > +    IBEX_DEV_ALERT_HANDLER,
> > +    IBEX_DEV_NMI_GEN,
> > +    IBEX_DEV_USBDEV,
> > +    IBEX_DEV_PADCTRL,
>
> Similarly, why is this enum in a public header and not local
> to opentitan.c, only place where it is used?
>

I believe the reason is that opentitan.c implements both SoC and board
stuff. These enums are helpful to define SoC peripherals hence
technically another board that uses the same SoC may utilize these
macros.

Unfortunately this is the case for all RISC-V boards so far. Should we
clean this up, for example, splitting SoC and board codes into 2
files?

Regards,
Bin

