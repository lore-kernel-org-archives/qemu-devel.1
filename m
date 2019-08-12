Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947EEC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 13:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E157206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 13:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ScX/iIel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E157206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxAZ0-0001oX-Iw
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 09:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55921)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hxAYQ-000133-MG
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 09:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hxAYP-0000I3-KS
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 09:40:06 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41898)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hxAYP-0000Hi-Ey
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 09:40:05 -0400
Received: by mail-ot1-x341.google.com with SMTP id o101so5865531ota.8
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 06:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Mnz8GgR2odvpj1t0ngPY0WAp+NVmgtDMzQAMO5KnUVw=;
 b=ScX/iIelJ9KgMT7h0ofiF7E4k+HCyLjJEmyMQ2BzbLOq9Zz/JjJLg8+HGce7MZmuqR
 HwOKsGodZU1jV13CSn3Nu1OzG1FpozOp5xQAV56bGnPj/QKoNupEilNmtSWOw68gM73M
 oqORuFh7xUow2FD+h5+H4WH3qJhm16Ylcvlx3jmYsbrUNdgFpNWx1iQoafuirpxey9NW
 3D49dHW3ox/5RkNU89qceGp0oGQ9BLOqK3aViAr/6T/1Fj8brct8NvupjzhcHmJi/LA/
 8oWhNBI5ic3cRG1S199HLH90YoOkRzfzor8x4Xpvxk1mjRCUGhsJps1OFOJ5MF9hRr0f
 em9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Mnz8GgR2odvpj1t0ngPY0WAp+NVmgtDMzQAMO5KnUVw=;
 b=ozRtFyDySReXYskZ9wEgQODMx9yWr4S6N5dPE2l1oyOaOgRbIapPdpqfLlxy1pjzgt
 JLZ06ih9WAfem+npngtUB4yw1l0b2/KB/FbWsfEJWVq7FNIMqKaWd3dVyNGpoiygl15O
 Ik/zdZll+vI/bN+kvq0lfDci0HRzq2uT6p0CA8NSUNAATLUuDKEcxoSmLDwKE0tQvsrO
 NSbvmBYrEg2PfckHcyFyA76XfFluZPfFib+yg+tmTBnzK6t6oOfiGDlghIasYUyJNSgF
 hIuauhWZwBb8U1nLU1Vkpilsz7c3Wtw0XxGUPKaunP6p7YoeUy3AzxpUEHhfJlb2J5Qu
 +CeQ==
X-Gm-Message-State: APjAAAXi7MqjbospvmOam1FldEfdi4wDRwISqUIhBkFwtZGFKRkvSP70
 6sltZQJJ2AWAliaZLbcEgk99JZum4B6w1tzUjguRiQ==
X-Google-Smtp-Source: APXvYqymCk3NKtP7VXyBn4Qk5LjejbRX2avvXC2XQ8HwrBFZZZuUFppMy3Z3SAxHGUIi8bdxtdK5/7kRrQdGgBzOWCw=
X-Received: by 2002:aca:4814:: with SMTP id v20mr1496819oia.98.1565617204452; 
 Mon, 12 Aug 2019 06:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190812065221.20907-1-kraxel@redhat.com>
 <aec51679-b766-5773-86cb-9ebd06a8cb49@redhat.com>
 <c4b30dfe-83d7-f1e0-d868-82791d56d6b6@redhat.com>
In-Reply-To: <c4b30dfe-83d7-f1e0-d868-82791d56d6b6@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Aug 2019 14:39:53 +0100
Message-ID: <CAFEAcA-3bFuy2DDG8=-_Y3JO4HWpCW80EcsGWWN8toxiMpafBA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 0/1] display/bochs: fix pcie support (qemu
 security issue)
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <ppandit@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 12 Aug 2019 at 13:51, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 8/12/19 2:45 PM, Paolo Bonzini wrote:
> > On 12/08/19 08:52, Gerd Hoffmann wrote:
> >> Just found while investigating
> >>   https://bugzilla.redhat.com/show_bug.cgi?id=3D1707118
> >>
> >> Found PCIe extended config space filled with random crap due to
> >> allocation being too small (conventional pci config space only).
> >>
>
> Can you amend this information to the commit description?
>
> <...
>
> >> PCI(e) config space is guest writable.  Writes are limited by
> >> write mask (which probably is also filled with random stuff),
> >
> > Yes, it is also allocated with 256 bytes only.
> >
> >> so the guest can only flip enabled bits.  But I suspect it
> >> still might be exploitable, so rather serious because it might
> >> be a host escape for the guest.  On the other hand the device
> >> is probably not yet in widespread use.
>
> ...>

I can add to the commit this paragraph of the cover letter,
and I think also the 'mitigation' note might as well go in.

I've also put the cc:stable into the commit message.

Updated commit, ready to apply to master if we're OK with it:

https://git.linaro.org/people/peter.maydell/qemu-arm.git/commit/?h=3Dstagin=
g&id=3Dc075b5f318a8be628ab8edf93be33f5a93a4aacd

thanks
-- PMM

