Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF312C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 19:31:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF5B62184B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 19:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fB9vaoab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5B62184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiOUc-0007q8-Q2
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 15:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57643)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiNV3-00084K-MK
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 14:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiNV1-0002lC-Lf
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 14:27:28 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37038)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiNV1-0002gg-Fn
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 14:27:27 -0400
Received: by mail-oi1-x241.google.com with SMTP id t76so13922507oih.4
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 11:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AlNrUOwUk0O1Xf95q8qu5cZnAgj9wAvJYino3VGRR3I=;
 b=fB9vaoab6EVIUlDF3SjQUyVE9KrpRXM0NNlDpzA/Y/CKFpEj0K3egI1cUvv4xlFZGJ
 qcnv1aPJbHT3mGQmzct5GSl3fE7hJmx8UWyw96m0gWAckO9WwuALfJY2iBxhbPeJt6nV
 Nx8CAfWz+pODunUounH24/edQH8tOxxmiAbg+uGyrkVKU2eRpskrC1YwfSKHQzdgth1Z
 mtnDMnOP/UGd+gD23cdYOl07s363L4lq1vqhnbILyx/eiU0/GhMZEtVqw88qH4QXGrFh
 kSqkOV9PczYjc7g1z/AdnRQRDW/e/1gggmdzQiDoLrZU06vJ4nlee2ltKRoWUFywYRJ9
 QNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AlNrUOwUk0O1Xf95q8qu5cZnAgj9wAvJYino3VGRR3I=;
 b=ivIzuFNakWaGHIzM0Y7cCfRowcifjOuTJdHXGWOAzHf3sNX5LBFTK/rK3orQEW0V9j
 n5OCR6QDi2QaIvZx8bDcEl08b2yrJYtzsJRNJiq/fmOyH5fvLyBBOxeWoWPFssFV1d+U
 vaHRtjivo//tzNxkCCQAUaLHqJ8adNxt/Ah/EUZuWHVWObLc1zEMBcbo60XryKtGtrEA
 wQwLyKzrlBDRF/basH2pR5tkSSSsZBLaPmN9Hysda/AhPRTVSSto7xUw9HaOkuICRlot
 A4sDhIYpWJEnSZAWHP3M4o7biWaZ8uJyWTm6O/rATkgqW0xUUbpzKn7vim5Yaf2Dmz1e
 LI7w==
X-Gm-Message-State: APjAAAUeslcEUwgvjpgRKQDmlmpekHxAI5WvIxDONFHusMGxK5iunHA0
 FNWIN0BW+TUydl/HHWh4LqyPhwmPa72mIN6yuU6rZg==
X-Google-Smtp-Source: APXvYqyDHbvYfklp3IVQ3wobcIAYEN9ANPAm6c8QghGeuIRLrfoNzl3eLpnp3tDLhZUoSXQd/p4rExEaR+xVcqrTRIs=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr4075872oic.170.1562092044368; 
 Tue, 02 Jul 2019 11:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190702150606.24851-1-mst@redhat.com>
 <CAFEAcA-Qcq1ZmfDO_dkh_H9-aeQVU83ceLKU1NXM3VpW8g5sPQ@mail.gmail.com>
 <20190702124823-mutt-send-email-mst@kernel.org>
 <CAFEAcA-UFks7CmtcMT15KzK3TzRqGjwXWtFa8K6XZ=Bks92CJw@mail.gmail.com>
 <20190702142058-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190702142058-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 19:27:13 +0100
Message-ID: <CAFEAcA_c3UXPVy_rXR_FxyXRw5ZE1-QgumPr9B-j+pmvBGWgpQ@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PULL 00/22] virtio, pc, pci: features, fixes,
 cleanups
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jul 2019 at 19:22, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jul 02, 2019 at 06:20:01PM +0100, Peter Maydell wrote:
> > On Tue, 2 Jul 2019 at 18:01, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > This isn't from mainline. We have a bit of a deadlock with linux merge
> > > window opening soon. I think it's reasonable temporarily
> > > and then before release either virtio-pmem gets there or I will
> > > revert it and drop the header.
> >
> > It's definitely not ideal: until the headers are actually
> > upstream there's no guarantee that they won't change ABI.
>
> But then I'm watching it, if I see that I'll drop the device from qemu for
> now.

OK; I guess we can take this for now if we make sure we revert
if the headers aren't upstream by the time we get to say rc2
(23rd July). (That is, we'd want to do any revert shortly after
rc2, since rc3 might be the last rc before release.)

> > Are the headers at least in some kvm-next or equivalent tree ?
>
>
> Yes - libnvdimm maintainer's tree.
>
> > When are they expected to hit mainline?
>
> Next merge window.

When's that?

thanks
-- PMM

