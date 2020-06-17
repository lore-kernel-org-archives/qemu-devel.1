Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C141CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9802B2158C
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9802B2158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlYMv-0005N2-R8
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 09:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guilherme.piccoli@canonical.com>)
 id 1jlYMF-0004rx-Hv
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:44:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54407)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from <guilherme.piccoli@canonical.com>)
 id 1jlYMD-0006dF-E4
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:44:03 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <guilherme.piccoli@canonical.com>) id 1jlYMA-0001IQ-Si
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 13:43:59 +0000
Received: by mail-ej1-f71.google.com with SMTP id j27so1047210ejo.11
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 06:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a/mA0I2ObU2+S0p52HianOSA+6II4kqYo9nkDgagWAY=;
 b=TZwsKbIN5I85E4I0lECBb09IMwberbw12M/e6fUtKCMDHcE9524f/FODuK1hyGJz4t
 zKkAhHO0jkq7R0zff1p+uWqWRIk1G4Hy/+/SzoStj1rMt3C0Gw8Hy4EJVcGGWBCWlQXw
 jaVqGz1/HW1pnPSV8Z4Uf7cJmJGEHOFzVX5bBK9K8R5BE2gGhYIyGHoRqFNisXYiTLPJ
 637IHR1mfKkK+kxoY/GZ/mwUWI/YGn7p9WTHhH84aHU/2AqPab/zslAV92wr2PIns4E3
 N/kaOkNTVfTievLXwbI5P08NyNKLAxvLjA2wK3HFoaQZAIrPzgS2ShgESvaETadF0RnS
 vQFA==
X-Gm-Message-State: AOAM533wH/7INiq8/sqZXS6rHi8i6TGT+/VLhRLJfaEaIbQAurim+zKp
 uvbPpzR/a6eKQLF+24RXvfQ4WiEjE2W1ZtESN5a48KT5Iw+4PaSgOo6YdaUguLlVm1q7uwkD8Pa
 KVP5Q3PfPx/i1/qS/thiqxHh/Mz2jbIlcL2MqZEssklCJgj+a
X-Received: by 2002:a05:6402:1776:: with SMTP id
 da22mr7531180edb.84.1592401438502; 
 Wed, 17 Jun 2020 06:43:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTDS73SgPSHwLVuWDo/naAhDnvwYUBWY0+SmpfP04AiywhRD1r6siY69XfXKeHWMhC7KH4hpy7xkSS8FUEoY0=
X-Received: by 2002:a05:6402:1776:: with SMTP id
 da22mr7531154edb.84.1592401438289; 
 Wed, 17 Jun 2020 06:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <99779e9c-f05f-501b-b4be-ff719f140a88@canonical.com>
 <20200616165043.24y2cp53axk7uggy@sirius.home.kraxel.org>
 <20200616165746.GH2788@work-vm>
 <CAHD1Q_zGu4Q63HjHx3aZKu3wh8NppuP6T4kgnUN3j=-ZDufVZA@mail.gmail.com>
 <b423f4a4-2552-bdc8-7c9f-41f200aef672@redhat.com>
In-Reply-To: <b423f4a4-2552-bdc8-7c9f-41f200aef672@redhat.com>
From: Guilherme Piccoli <gpiccoli@canonical.com>
Date: Wed, 17 Jun 2020 10:43:22 -0300
Message-ID: <CAHD1Q_zmTatErCefeh349sSYsQJUVT3KB+VMDheEgBn5r7QGjA@mail.gmail.com>
Subject: Re: ovmf / PCI passthrough impaired due to very limiting PCI64
 aperture
To: Laszlo Ersek <lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=91.189.89.112;
 envelope-from=guilherme.piccoli@canonical.com; helo=youngberry.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 09:43:59
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Pedro Principeza <pedro.principeza@canonical.com>, ehabkost@redhat.com,
 Dann Frazier <dann.frazier@canonical.com>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, fw@gpiccoli.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks a lot for all the responses here! Very constructive discussion =)
Comments inline!

On Wed, Jun 17, 2020 at 10:22 AM Laszlo Ersek <lersek@redhat.com> wrote:
> [...]
> If QEMU can provide a *reliable* GPA width, in some info channel (CPUID
> or even fw_cfg), then the above calculation could be reversed in OVMF.
> We could take the width as a given (-> produce the CPU HOB directly),
> plus calculate the *remaining* address space between the GPA space size
> given by the width, and the end of the memory hotplug area end. If the
> "remaining size" were negative, then obviously QEMU would have been
> misconfigured, so we'd halt the boot. Otherwise, the remaining area
> could be used as PCI64 MMIO aperture...

That was *exactly* the way I was considering, but without the right
terminology due to my lack of experience in this topic heheh
Thanks for the great summary of the idea! I was considering fw_cfg,
but can be CPUID too, let me know what is the "trendy" way to do that.
So, the only problem with that refactor you're proposing is the
retrocompatibility with qemu versions, as I can anticipate cases in
which newer OVMF runs with older qemu, which does not provide such
trustworth physbits info. So, the code may be a bit complex, it'll
need to take into account this case (probably we could just rely on
the physbits "detected" by OVMF in such case, limiting PCI64 aperture
to the current 36-bits, right?).


> (PEI memory footprint of DXE page tables be darned).
LOL

Cheers,
Guilherme

