Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB56BC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 01:49:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D3A322210
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 01:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRhY3Tjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3A322210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR40S-0006xD-C3
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 21:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kR3zV-0006WE-DX
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 21:48:09 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:43494)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kR3zT-0002CN-Kn
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 21:48:09 -0400
Received: by mail-io1-xd41.google.com with SMTP id d20so12226964iop.10
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 18:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Dm/Qq3lylsRKICzg847LaG5ca5c1lkURCJkDVRbxNzg=;
 b=lRhY3TjyDS0zv7qvBgOjWUQTPvAPsbCM/w5JqKgct3qOlb9dxxW/GT/ccccswukkf+
 t6bZ9YmXoAGE1nIpjJugaPAjGyv9srM1H1ALktpJSekM2GtL/sy3r/OHH8pD+J4tjkPZ
 bnczUMSCsSwCuplxGkDzed1VDRK5pjq/GE9uOjZ16SOmRbI0xMQaPxJjO05utq3bcMyb
 jwOlxQaEi2469qHRQ1PtypiMaj2JsXNHHu5sEqADec/SJOja3prI3eVMswdQq92uO5X+
 A7DtveA0sHf9T2TWNHZhkpChIXHO1yGzPkNgJWGF8veawRt6xu+WSy2njPosfnwmtvIR
 DlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Dm/Qq3lylsRKICzg847LaG5ca5c1lkURCJkDVRbxNzg=;
 b=hydVgNTWX9LnB7Y0NGDG6YEqdoq4fad5KNdlB+Lx42ruG+o5iZsJYR2rHp0UIX1LGX
 DjvwaP2t4EgI80yDmzf1nqObMoGOhpbPH2LBA/RlY62si2i8MrKif5FH72BZfsFms6eb
 RmxTrW953odQUI7MmFjzdZ3cr38wLFEUI/XsR9fOKIgaPGbWcHYO1MI0mK9p9zd7HJ4D
 Ut7pMxDFU+CIepCS6aBd1leSb27yFEjNITSmUg3zMvj6u5YA++7dcQstyzH8eWkP53yd
 IgItCxeruyS8f4hXqdBFEphcWjBfkixEOoUcYKnxKwwDzATlM75bzZ5v3VpGJqxvL0dr
 nm+A==
X-Gm-Message-State: AOAM532X5blvE/TnhP1oj4jvcygKSYhF1BrS18pujw3Hm59JMTA7yfHS
 isDbrdQKDsy6BHLtaNT0u4zarN5vpa+irVVxP7Y=
X-Google-Smtp-Source: ABdhPJzvNVoG4V5yA68YxWKf4KSk5Hunwnz+zyrgaUit9eTaxoA5LoWCkpKZAl9yZPOrJMxKN2wLzwQSbzEXJ4Kte+M=
X-Received: by 2002:a02:cce6:: with SMTP id l6mr12289293jaq.32.1602294485981; 
 Fri, 09 Oct 2020 18:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <1602059975-10115-1-git-send-email-chenhc@lemote.com>
 <1602059975-10115-10-git-send-email-chenhc@lemote.com>
 <a4b8cb9d-d4ed-0acc-e40f-d4914a8adb51@amsat.org>
In-Reply-To: <a4b8cb9d-d4ed-0acc-e40f-d4914a8adb51@amsat.org>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Sat, 10 Oct 2020 09:47:54 +0800
Message-ID: <CAAhV-H4JOFzmoL1O_d=Fko5kxVC=Z0R5jywdihztuVVPaXVhNg@mail.gmail.com>
Subject: Re: [PATCH V13 9/9] docs/system: Update MIPS machine documentation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=chenhuacai@gmail.com; helo=mail-io1-xd41.google.com
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Philippe,

On Fri, Oct 9, 2020 at 11:29 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Hi Huacai,
>
> On 10/7/20 10:39 AM, Huacai Chen wrote:
> > Add Loongson-3A CPU models and Loongson-3 based machine description.
> >
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > ---
> >   docs/system/cpu-models-mips.rst.inc | 10 ++++++++--
> >   docs/system/target-mips.rst         | 10 ++++++++++
> >   2 files changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/docs/system/cpu-models-mips.rst.inc b/docs/system/cpu-mode=
ls-mips.rst.inc
> > index 499b5b6..02cc4bb 100644
> > --- a/docs/system/cpu-models-mips.rst.inc
> > +++ b/docs/system/cpu-models-mips.rst.inc
> > @@ -48,11 +48,17 @@ across all desired hosts.
> >   ``I6400``
> >       MIPS64 Processor (Release 6, 2014)
> >
> > +``Loongson-2E``
> > +    MIPS64 Processor (Loongson 2, 2006)
> > +
> >   ``Loongson-2F``
> >       MIPS64 Processor (Loongson 2, 2008)
> >
> > -``Loongson-2E``
> > -    MIPS64 Processor (Loongson 2, 2006)
> > +``Loongson-3A1000``
> > +    MIPS64 Processor (Loongson 3, 2010)
> > +
> > +``Loongson-3A4000``
> > +    MIPS64 Processor (Loongson 3, 2018)
> >
> >   ``mips64dspr2``
> >       MIPS64 Processor (Release 2, 2006)
> > diff --git a/docs/system/target-mips.rst b/docs/system/target-mips.rst
> > index cd2a931..1f86ccb 100644
> > --- a/docs/system/target-mips.rst
> > +++ b/docs/system/target-mips.rst
> > @@ -84,6 +84,16 @@ The Fuloong 2E emulation supports:
> >
> >   -  RTL8139D as a network card chipset
> >
> > +The Loongson-3 virtual platform emulation supports:
> > +
> > +-  Loongson 3A CPU
> > +
> > +-  LIOINTC as interrupt controller
> > +
> > +-  GPEX and virtio as variable devices
>
> What do you mean by "as variable devices"?
I want to describe "Loongson-3 virtual machine use GPEX as its pci
host controller, and use virtio as its device model to connect many
kinds of devices" here.

Huacai
>
> > +
> > +-  Both KVM and TCG supported
> > +
> >   The mipssim pseudo board emulation provides an environment similar to
> >   what the proprietary MIPS emulator uses for running Linux. It support=
s:
> >
> >

