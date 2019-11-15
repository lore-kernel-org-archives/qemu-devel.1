Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7893BC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4330120730
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p64ci8sT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4330120730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVeL3-0005pl-Ex
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 11:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iVeFt-0000H8-El
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:15:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iVeFs-0003Wn-05
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:15:28 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iVeFr-0003WK-Ry
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:15:27 -0500
Received: by mail-ot1-x341.google.com with SMTP id b16so8437587otk.9
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 08:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UiU14tuo2Z+Fw3fwdTXdL3cwTjgYED6vsPEkPTAXsNU=;
 b=p64ci8sT6hrRtWG1QUYvLwxorbFnW1571L48ZvA3lPiHDEf2rnDRsRrWGJGH2iYqyO
 sYwhToIwdr3tQ35Ttq8eLzWHLiVhGjhGGWOKu7xuoiJSXAq0gdBArfDaPkoNsJeVxbek
 NeiYrDJRToxg5WCJ69HRC8/zD6zNtG0vPFXh5w49TF++beVFgkLrJIgbQBiPRypBSBt+
 Vf8pnYPx1ajiSrkolCADSf1m2Qx4E+bEjP4NVapAivwfHtmQSRjH7niG/tgQhTS311Yd
 T4E9Vlcy5E9KdVgPNh1h5yITSD0V9rJiHRJcotbQZE1QDO70/lLcKk0wJwzuPS5hDEPB
 K6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UiU14tuo2Z+Fw3fwdTXdL3cwTjgYED6vsPEkPTAXsNU=;
 b=e55vuig0v54lVwQTFFMaxgCqBs+Ql/vEj+iOwaPUHtr+aq40yHUrSmwcCmJdbVTtgd
 GPB/dVV3+9h9ivWZ5m4W9lpT4VVtgOf1dKbGGry3hR98fOThDIeB8K6WyR23RPsFZk8N
 TjEy7jffRIt59X+VSJj1E2qT3m3Q/u0Pk9B158IR8245JiF62Lx2PGj2nb3chnYVzYfF
 79V9Gq+SDjkmbp93rlch7CoKAwW+ABCx5OJ4pwJkBSRQzRiW40FwwNMRpVyr7pzeEx2L
 oLxDdFm3wi8tKMy1MWw81H3EuAGxUDf5w4q0GQqDXUdUtM7fxMX/s9F/u/eJUNmu6/Mh
 j/1A==
X-Gm-Message-State: APjAAAVte/huiOBiMjWhY1TgQXflxcYJbGoCubCi+eDl/7Eh6j7zuJ/r
 x+BLP4VtRDgNvIHgiyHMbO3LhGN2B5hgzxMt0RZqrw==
X-Google-Smtp-Source: APXvYqwUmeKm+p8xsuo+aZV7WnTBtauZLjrYUygKNlB1JQWTDLeD3nGcX48D+8ZbBdBY6gdXAp1/WdQ1RgpurtyvF3c=
X-Received: by 2002:a9d:7f12:: with SMTP id j18mr10887156otq.221.1573834526578; 
 Fri, 15 Nov 2019 08:15:26 -0800 (PST)
MIME-Version: 1.0
References: <20191115145049.26868-1-thuth@redhat.com>
 <CAFEAcA-EuQVBtr=BCE5sdHo+LMv8XchHUSPM=CgSYxPVryWKZg@mail.gmail.com>
 <273a3123-9eef-c78e-5b83-833a21e3988c@redhat.com>
In-Reply-To: <273a3123-9eef-c78e-5b83-833a21e3988c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Nov 2019 16:15:15 +0000
Message-ID: <CAFEAcA9N+T=M=5-xb3ahRMqD6oxhm5Lx55-1Mtk1vXsRJEomwA@mail.gmail.com>
Subject: Re: [PATCH for-4.2] hw/i386: Fix compiler warning when CONFIG_IDE_ISA
 is disabled
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 Nov 2019 at 16:08, Thomas Huth <thuth@redhat.com> wrote:
>
> On 15/11/2019 16.54, Peter Maydell wrote:
> > On Fri, 15 Nov 2019 at 15:10, Thomas Huth <thuth@redhat.com> wrote:
> >> --- a/hw/i386/pc_piix.c
> >> +++ b/hw/i386/pc_piix.c
> >> @@ -78,7 +78,6 @@ static void pc_init1(MachineState *machine,
> >>      X86MachineState *x86ms = X86_MACHINE(machine);
> >>      MemoryRegion *system_memory = get_system_memory();
> >>      MemoryRegion *system_io = get_system_io();
> >> -    int i;
> >>      PCIBus *pci_bus;
> >>      ISABus *isa_bus;
> >>      PCII440FXState *i440fx_state;
> >> @@ -253,7 +252,7 @@ static void pc_init1(MachineState *machine,
> >>      }
> >>  #ifdef CONFIG_IDE_ISA
> >>  else {
> >> -        for(i = 0; i < MAX_IDE_BUS; i++) {
> >> +        for (int i = 0; i < MAX_IDE_BUS; i++) {
> >>              ISADevice *dev;
> >>              char busname[] = "ide.0";
> >>              dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
> >
> > Don't put variable declarations inside 'for' statements,
> > please. They should go at the start of a {} block.
>
> Why? We're using -std=gnu99 now, so this should not be an issue anymore.

Consistency with the rest of the code base, which mostly
avoids this particular trick. See the 'Declarations' section
of CODING_STYLE.rst.

As Paolo points out, there's a nice convenient block
here already, so there's not much to be gained from
putting the declaration in the middle of the for statement.

thanks
-- PMM

