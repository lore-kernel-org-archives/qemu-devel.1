Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A53C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 11:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E3572173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 11:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gp5b3bxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3572173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j412V-000492-AG
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 06:27:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j410L-0002mO-1N
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 06:25:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j410K-0001fN-0f
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 06:25:28 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37512)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j410J-0001eY-ST
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 06:25:27 -0500
Received: by mail-oi1-x244.google.com with SMTP id q84so19753802oic.4
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 03:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AeJB+9de45roMhDPx74C8YWAezIBo75bldUqX7+HDPY=;
 b=Gp5b3bxzBIElw5MNXYabVWqNT/Dqh0YhOhdNGmiA3ARgKRHx2quX8YAPK6Hc32/PB3
 D7cYvyq3izxr/UXSnQ0nSGTqW2j3JteNPmaVe66cQnaf4w0yq374OwQyPR3Cyh5FIJbj
 oEEpAduf0A1Khx1Mi1RmDy+qru0sNISXDzJM1gEJo5tyXAyt9C2TOyn51OmU8Gl3k7yR
 DfPaRNJ0QTVqhJarL6kLE4M3ZBtx839kJLLsQhvi8Hb84MlntxfhM3ocTQgNJVx/52Jz
 odHxKywtVHgvmq+qX3LKwxYJeKby3plgGB3niDvM3njcUv0KDftmHPYt2rD4cUE6gwRq
 U58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AeJB+9de45roMhDPx74C8YWAezIBo75bldUqX7+HDPY=;
 b=Mr0Cm02osUWUnJ/KzFo2NVwqxkspvR+S9Emd7pktzrOuGAvUeo0xQa5ubziW9bsqOZ
 3446ZpHz07a4ABYKOaaJdZLWaf681LS9/kZi0YCobr5Lld+87Rcfy1aUxHjGbOdRN3uH
 jf0mu2Hh5XqAAi8PglscVzyYwAzQw1M7C9+EhEvTKlHnmuWEPHjmZEKJQS2I5hdcNBpI
 lMPN2qapd20FfTBY9mPsvx5mt4YzvoR5UwKPH3IhSWeTp53fqSxFk/WeWFZenxXst6EJ
 629dFsPOWHWoE9lnq8fR4iL+9sAc2o3/MtxXgZyDQqxHykdGuoEv57fczSv9b9isMfE0
 WYWg==
X-Gm-Message-State: APjAAAUyhcJ34krCxKL/NRLoosXnBbTY7PWKu8fsJMZ2zlUfD4S9do2h
 pq7O2daNsK2vJdtHthTWat0Nw3MqoBRa1JKZ0kK3eA==
X-Google-Smtp-Source: APXvYqx3/wbOmFinU6Hw0dkBcoFvYe7QRDBlvS49pQ+NOlJZR60RGP9eIPqR1VGNWcNdjlIQ58GmWCh/n9HcxE+qMcY=
X-Received: by 2002:a05:6808:289:: with SMTP id z9mr868453oic.48.1582025126952; 
 Tue, 18 Feb 2020 03:25:26 -0800 (PST)
MIME-Version: 1.0
References: <20200218110137.22161-1-peter.maydell@linaro.org>
 <6db2038a-099a-9f7f-1b27-07a13896de82@redhat.com>
In-Reply-To: <6db2038a-099a-9f7f-1b27-07a13896de82@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Feb 2020 11:25:16 +0000
Message-ID: <CAFEAcA82B5Yjfq3D=i0=dtaJNGX1BM+u1fpWC66P4faWzhAP6w@mail.gmail.com>
Subject: Re: [PATCH] Avoid address_space_rw() with a constant is_write argument
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Feb 2020 at 11:19, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 18/02/20 12:01, Peter Maydell wrote:
> > I could break this down into separate patches by submaintainer,
> > but the patch is not that large and I would argue that it's
> > better for the project if we can try to avoid introducing too
> > much friction into the process of doing 'safe' tree-wide
> > minor refactorings.
> > ---
> >  accel/kvm/kvm-all.c       |  6 ++--
> >  dma-helpers.c             |  4 +--
> >  exec.c                    |  4 +--
> >  hw/dma/xlnx-zdma.c        | 11 +++----
> >  hw/net/dp8393x.c          | 68 ++++++++++++++++++++-------------------
> >  hw/net/i82596.c           | 25 +++++++-------
> >  hw/net/lasi_i82596.c      |  5 +--
> >  hw/ppc/pnv_lpc.c          |  8 ++---
> >  hw/s390x/css.c            | 12 +++----
> >  qtest.c                   | 52 +++++++++++++++---------------
> >  target/i386/hvf/x86_mmu.c | 12 +++----
> >  11 files changed, 103 insertions(+), 104 deletions(-)
>
> I agree, but please include the semantic patch in scripts/coccinelle/.

I'd forgotten we had that. v2 sent.

-- PMM

