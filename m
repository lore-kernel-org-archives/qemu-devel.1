Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A89C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 04:41:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6438E20757
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 04:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcyWYiZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6438E20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFrur-0001h5-4m
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 00:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kFru4-0000rL-8K
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 00:40:16 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:43775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kFru2-0004Kz-M9
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 00:40:15 -0400
Received: by mail-oo1-xc42.google.com with SMTP id h9so275774ooo.10
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 21:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lWjGsYqeWqPzYP7CRgDI6W8ZO+y9NFiTc72WtJMNcG4=;
 b=pcyWYiZMUOlpT/GfkExAscGodLhHX1RuWp308ST4geR+tQ/5Hu0i2OPyEPIdtv5Iky
 DVpSk5EjFywiIiTw4Hpj0H4aDQOCiEkFXVq7WzXXUxnkmz2H7O0XMTzljod5ybS+SW4G
 2THDtvCPaKprB4+sqCdKxb9zjwLvZ9LKt95SXrS7FADWvXHlUdFL/Az5wJx91MjZ71wi
 +UJLzIzHnzQg+lc6et0rGaMObVH4JEAbVCc+ZauGvn2yNLuc0msot1TEQxaABG0Pem/p
 lFj2bdR1BBuLkyPf0UR3PU8RBCAyO9zn5dZNPqedYRj2N1s4Vaf6mjpzRH2pKtWXuy+m
 o6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lWjGsYqeWqPzYP7CRgDI6W8ZO+y9NFiTc72WtJMNcG4=;
 b=SL7+yv7poNtobIkwWuOSxsVtrt9QLvCIXwfcuIQWTv2jlZclYMY0ESN1EyMSqMESMm
 Bd43e6uJuDoH7uhdHOTceiLHLR+k4ijEko+Hy6VxcKGU9oy3Ez9oJMTzLqePZz2t3gwq
 tmppkbVTP2ttefLr2V7p/NRvR3akJy1Z2oMpU2r68IFwsH8yKvDFCktKPzd2a/Vz6EZ1
 cr+Ek3FXOwEi1kr3eqLooMvJs/cylr7pCZU+MBInjbjGdzMJo7SsUd8VlbLiLq7vFhjs
 N/UDMJZCVoeXDSbbqgW9fnMxaBc4/w0V+H3mKbbYEOQ9hCws91kHRGZfJ21KeRk/bsbM
 MfzA==
X-Gm-Message-State: AOAM531caRFgNeoGABky4DwjNerSmSxfebHG8YahlNaqQiIQBxuv/OhS
 ZU1q93B/RvgamVyXvVhT22WzQfn35UfBh3k+Uc8=
X-Google-Smtp-Source: ABdhPJxvVMSNsAY0gOsDavf0gzoPl+2+sfMIlGzoCkWal4149GTDFHwaBxhJPPFtAY6jowc0q7HHlDdB7ijyzj42EPs=
X-Received: by 2002:a4a:5a06:: with SMTP id v6mr1500791ooa.22.1599626413437;
 Tue, 08 Sep 2020 21:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200908164157.47108-1-liq3ea@163.com>
 <f50624b9-dac7-c6ab-cce9-71cd9de477e1@redhat.com>
In-Reply-To: <f50624b9-dac7-c6ab-cce9-71cd9de477e1@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 9 Sep 2020 12:39:37 +0800
Message-ID: <CAKXe6SKkk0Qq4CKn8xTbXrUcDav29rVVK8bq4Y-5TwSfKnDuww@mail.gmail.com>
Subject: Re: [RFC 0/4] Add a 'in_mmio' device flag to avoid the DMA to MMIO
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=liq3ea@gmail.com; helo=mail-oo1-xc42.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Li Qiang <liq3ea@163.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Qemu Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jason Wang <jasowang@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=889=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8810:17=E5=86=99=E9=81=93=EF=BC=9A
>
>
> On 2020/9/9 =E4=B8=8A=E5=8D=8812:41, Li Qiang wrote:
> > Currently the qemu device fuzzer find some DMA to MMIO issue. If the
> > device handling MMIO currently trigger a DMA which the address is MMIO,
> > this will reenter the device MMIO handler. As some of the device doesn'=
t
> > consider this it will sometimes crash the qemu.
> >
> > This patch tries to solve this by adding a per-device flag 'in_mmio'.
> > When the memory core dispatch MMIO it will check/set this flag and when
> > it leaves it will clean this flag.
>
>
> What's the plan for fixing the irq issues pointed out by Peter?
>

Just have a basic idea. Just like this we can add a per-device flag,
'in_mmio' or 'in_emulation'
or some other names. The device need solve the irq handler/mmio and
anything other reenter issue by themself
or they can just check/set/clean this flag. This way we may can define
a principle which Peter mentioned that the device emulation should
obey.



Thanks,
Li Qiang


> Thanks
>
>
> >
> >
> > Li Qiang (4):
> >    memory: add memory_region_init_io_with_dev interface
> >    memory: avoid reenter the device's MMIO handler while processing MMI=
O
> >    e1000e: use the new memory_region_init_io_with_dev interface
> >    hcd-xhci: use the new memory_region_init_io_with_dev interface
> >
> >   hw/net/e1000e.c        |  8 ++++----
> >   hw/usb/hcd-xhci.c      | 25 ++++++++++++++---------
> >   include/exec/memory.h  |  9 +++++++++
> >   include/hw/qdev-core.h |  1 +
> >   softmmu/memory.c       | 46 +++++++++++++++++++++++++++++++++++++++--=
-
> >   5 files changed, 72 insertions(+), 17 deletions(-)
> >
>

