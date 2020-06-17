Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F85AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246562065F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246562065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlaZ3-0001iV-DP
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 12:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guilherme.piccoli@canonical.com>)
 id 1jlaVZ-0007AG-LJ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:01:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from <guilherme.piccoli@canonical.com>)
 id 1jlaVX-0007IB-Fe
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:01:49 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <guilherme.piccoli@canonical.com>) id 1jlaVV-00046a-Sh
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 16:01:45 +0000
Received: by mail-ej1-f70.google.com with SMTP id g6so104114ejo.18
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 09:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jpIAJVEDvPogV7AUu3IXaXwIKWhryDywcckqT+7EMFE=;
 b=T1MBKBzH8H1ouc5yku4Bje6S8R02+W0Z7caLML8cgKW5liDuUeO4FWzcJSGE5UXalg
 HHg4uA8w6Xm4Bo8JDTsSMZ3WNeKsUhFomLUSIxJPwyU6Ah6ooyp7M/FkZLjdZWZF0h8y
 U2/PPOCbZGwU/sv1SVCRb7FLus+0/r+jsEjXxTc2WcVYkqC0/iJoLtpBdVlSLxfg9VTk
 LaW8XujIqsULqWCu52hlqv5LedF1qIOj41p7pacUJ8LbeU64S/ACi0hBO95e28Z2/E7m
 AmYn/KDlPENVn4UGwYnyulEiXE97h3SP7cvu/2IgDVosBn2N7+zskt05aMOlwlHi7Yh0
 jBUw==
X-Gm-Message-State: AOAM53154ozMNxYrGS9WcgcTk88K/AHmbJE8e6EqCo4zBd4kyqow/K09
 UEzNbThiIybovzpdRmbJcPmeM6xgmdKUy/2oCny+Y6ZP6Q6aqlqjxIb+gJ9+Tgm2icjjAydKl7h
 CzzGDgulEJBl5oo+MHCG/dbSXURhrolm+C/72cWNb9GDmLT7q
X-Received: by 2002:a17:906:7f84:: with SMTP id
 f4mr8013987ejr.482.1592409705454; 
 Wed, 17 Jun 2020 09:01:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUsHwJZ4R7uTtJONKTOXAw6Oo3h2S/MfAxwnGGZ/hpEDITqRPWqXLjcA3X9fio+xi4ydECR6JrddMBgzTdle4=
X-Received: by 2002:a17:906:7f84:: with SMTP id
 f4mr8013944ejr.482.1592409705124; 
 Wed, 17 Jun 2020 09:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <99779e9c-f05f-501b-b4be-ff719f140a88@canonical.com>
 <20200616165043.24y2cp53axk7uggy@sirius.home.kraxel.org>
 <20200616165746.GH2788@work-vm>
 <CAHD1Q_zGu4Q63HjHx3aZKu3wh8NppuP6T4kgnUN3j=-ZDufVZA@mail.gmail.com>
 <b423f4a4-2552-bdc8-7c9f-41f200aef672@redhat.com>
 <CAHD1Q_zmTatErCefeh349sSYsQJUVT3KB+VMDheEgBn5r7QGjA@mail.gmail.com>
 <084e2640-d71e-d4ec-efdd-3f7947a6b511@redhat.com>
In-Reply-To: <084e2640-d71e-d4ec-efdd-3f7947a6b511@redhat.com>
From: Guilherme Piccoli <gpiccoli@canonical.com>
Date: Wed, 17 Jun 2020 13:01:09 -0300
Message-ID: <CAHD1Q_x6E4Oggq_HnKH4xYX_CGY0dRQWRD-J-DGqh42diLy5og@mail.gmail.com>
Subject: Re: ovmf / PCI passthrough impaired due to very limiting PCI64
 aperture
To: Laszlo Ersek <lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=91.189.89.112;
 envelope-from=guilherme.piccoli@canonical.com; helo=youngberry.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 11:58:29
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
Cc: Pedro Principeza <pedro.principeza@canonical.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Dann Frazier <dann.frazier@canonical.com>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, fw@gpiccoli.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 12:57 PM Laszlo Ersek <lersek@redhat.com> wrote:
> [...]
> I don't necessarily see compat issues -- large-BAR PCI device assignment
> might simply stop working under those circumstances, because you could
> no longer use X-PciMmio64Mb, and the new way wouldn't be supported by
> (old) QEMU.
>
> This would indeed be a regression relative to "X-PciMmio64Mb", but
> that's exactly why there's an "X" in "X-PciMmio64Mb".
>

Are you planning to remove that option, with this improvement? I think
we could keep it for a while, as a way to override the automatic
mechanism we might implement. This is even for "safe" purposes, in
case there's some corner case with the auto-sized aperture that we
ignore upfront.

> > So, the code may be a bit complex, it'll
> > need to take into account this case (probably we could just rely on
> > the physbits "detected" by OVMF in such case, limiting PCI64 aperture
> > to the current 36-bits, right?).
>
> A "bit complex" is an understatement. The code is already much more
>[...]
heheh
indeed, it's very complex code! It took me a while to even start to
figure where things are done, I guess UEFI spec is complex in nature
too, which adds to that code complexity!

