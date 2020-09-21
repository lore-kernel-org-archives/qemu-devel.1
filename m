Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F970C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 04:42:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED20C2084C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 04:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Usx9O6Zr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED20C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKDeR-0001zB-2a
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 00:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kKDch-0000mC-PY
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 00:40:20 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38531)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kKDce-00089c-Ls
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 00:40:19 -0400
Received: by mail-oi1-x243.google.com with SMTP id 26so7137995ois.5
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 21:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BdHLyOZP66z8XCBOF8IL1V8cTakK3hasb76y+ttXiVU=;
 b=Usx9O6ZrbApEiGZpRwnYq4RajG9S6i214nQm/iyhZ2gTK7lo91CJOi0S7iw5yWHuqX
 qGzxSTAjRj0z/ViQrWEx07GcZz/KnGxgzPXVW8StF4MsFlEvzumGgaMfZjpAaP5/Rbvk
 qybf8CkCroolXtqMkqtciZ0aR8qnhMFeRmJOP+bbz564RumlsgGCi7bZe8ZuxlbLHvhv
 64Vch9LALBa+/cSmozKxceW89DgxApoEatqVEhm+sUFua4Db8qRtDUvXNrOutWWoB8EF
 WjootysaRMPX+Tw3e1YfbmpZLPOGo4xB+w+AtN5sp6Y5pMmedNmd5gyHURH451H3nEa/
 YBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BdHLyOZP66z8XCBOF8IL1V8cTakK3hasb76y+ttXiVU=;
 b=dvUE/ZlMeFN9/mt4rH/axOq6tOQExcotImZ43RsugNGNDkfbQG0aBShX3K+9O/HUFA
 BdRZfdekpv0s+ngeqxCskKBXt79gKKTWbIWmjZ2b7XvtoCB37ch1AejlTXTNkuTASOBD
 rQ5FkiZFhFJhDs6yg83Rpigi0TI2t0XIqdiB5o5ePAzFwWlxrzFNCop0cUtng6wsp5Sg
 nCR7e+GlFLyECufczhZTKm2yopxc3xtED0ab6PTZ6cry1Y9GjCRfLVuqzt2faeF+/Ls6
 lXX4dbHErlRJck5HObeBZVZVsXGKr3bsQrt9h12xcuuqElLBd70L14RQXqE1VUP8fZ1L
 Osjw==
X-Gm-Message-State: AOAM530fFd5azSti69+HWNcDqu+OT+A3VfCHjJIgyKc7zeGEEvV8ACtd
 dyyt5KxPMB5ICo1poeyU/AY9uF1mSr5ZZo0GgfQ=
X-Google-Smtp-Source: ABdhPJwdetRmmPKexD0gsN5JOpGQaCyxkL3sKnGD1nvS1oZh34A3gO8fChbiwJzUO9Jrg3ZeZ/MLeS9uoLL+IoaEeTU=
X-Received: by 2002:aca:b454:: with SMTP id d81mr16104665oif.150.1600663215370; 
 Sun, 20 Sep 2020 21:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200908164157.47108-1-liq3ea@163.com>
 <2ea35f00-3388-22b3-6961-169d2b8a55b7@redhat.com>
In-Reply-To: <2ea35f00-3388-22b3-6961-169d2b8a55b7@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 21 Sep 2020 12:39:39 +0800
Message-ID: <CAKXe6SJNjUem5+oXmUMHFhfWdM_GXY9K=AuvL1cte0O+QvVgkg@mail.gmail.com>
Subject: Re: [RFC 0/4] Add a 'in_mmio' device flag to avoid the DMA to MMIO
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x243.google.com
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
 Eduardo Habkost <ehabkost@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Li Qiang <liq3ea@163.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Qemu Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8820=E6=
=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=883:56=E5=86=99=E9=81=93=EF=BC=9A
>
> On 08/09/20 18:41, Li Qiang wrote:
> > Currently the qemu device fuzzer find some DMA to MMIO issue. If the
> > device handling MMIO currently trigger a DMA which the address is MMIO,
> > this will reenter the device MMIO handler. As some of the device doesn'=
t
> > consider this it will sometimes crash the qemu.
> >
> > This patch tries to solve this by adding a per-device flag 'in_mmio'.
> > When the memory core dispatch MMIO it will check/set this flag and when
> > it leaves it will clean this flag.
> >
> >
> > Li Qiang (4):
> >   memory: add memory_region_init_io_with_dev interface
> >   memory: avoid reenter the device's MMIO handler while processing MMIO
> >   e1000e: use the new memory_region_init_io_with_dev interface
> >   hcd-xhci: use the new memory_region_init_io_with_dev interface
> >
> >  hw/net/e1000e.c        |  8 ++++----
> >  hw/usb/hcd-xhci.c      | 25 ++++++++++++++---------
> >  include/exec/memory.h  |  9 +++++++++
> >  include/hw/qdev-core.h |  1 +
> >  softmmu/memory.c       | 46 +++++++++++++++++++++++++++++++++++++++---
> >  5 files changed, 72 insertions(+), 17 deletions(-)
> >
>
> I don't think this is a good solution.  These are device bugs and they
> need to be fixed.

I agree with this the device should finally handle their cases. But we
can do something in a pattern if the device hasn't
do that.
I have posted a patchset:
-->https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg00906.html

This is add flags in the Device State. And check/record the flag when
doing reentrancy code.
Once the device has fixed the reentrancy issue, they can remove this flag.

Thanks,
Li QIang

>
> Paolo
>

