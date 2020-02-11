Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA809C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F1B20675
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oZSMlWE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F1B20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1X4v-00058Z-Pk
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 10:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1X3l-0003xN-Vp
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:02:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1X3h-0002rK-1T
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:02:45 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39898)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1X3g-0002r1-ST
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:02:40 -0500
Received: by mail-oi1-x243.google.com with SMTP id z2so13046856oih.6
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 07:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NJzapH/OwUP25ait7xEggB84gbQoRFwSXIZjrFEANkY=;
 b=oZSMlWE6dBhBHhQwQ1+i7gRKxYHEABBikoGlmiHFHuDYpp7J2WXWFok71rvM1YbB+S
 qgV2t9acezLhTuxqoV2sDZIwX2WW6MwhSCZGP2Msbypdxnjm5b7Iry4vJTIcQNTqTn+g
 Ake2GyQJdzhXAWVkhxf1fLIr+KoTMLMGxjasaB7O4op7iQ9nMkgvWnIHeiU9AM9OlaL1
 Pa3+QrXiqnSC++/I25uF/cwM+Qq8XwVSj2byk4vBd/KT9obZUZDYbNd97kMzAWN0xJ9D
 qYZ/AWfXX4wDF3l7SXJ5xqjBGJCZ/dIkGj9M9qUS5YgoHPWhNMrPvdsilovqfiMnRz62
 g2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NJzapH/OwUP25ait7xEggB84gbQoRFwSXIZjrFEANkY=;
 b=d2cOYP0YRovEHQWn+znks52nrOhQwOWhe9Cr/4bW6Krtk51vcblo0eTD5emiZom92J
 fVKTzkIJV5p//0yvZyvWXxjpgjyFOGNU5KT9p4hqPkCkxpY7fCEoHwkyFKAtTpZIR/qH
 6KJmQBo/iCW7EkXf4RVD5sEqTfhZ79QkJ4AHu6/+O842yv/OoS0oR8+TNJYQFnxdB1QI
 VcwOR9zpTUmyGQMCxYZ0oe/n1hh7tOxxZk5fXYOCQfWzV3dloNoZsAmkj8NNKJCt7xzL
 RquopE99F3uhBc3phARsz0XGNpHjHNe+NAA3eDFAuAq144H90Kwlfbfet64NxNbwUBSj
 p70A==
X-Gm-Message-State: APjAAAWXHC1wnP9oe+IO6fzsJ6Xf5om9XADamkTxx0gBVPyLXGXF6G2a
 n2qUpFceQNpRS1eKJSjqKks660T/FOjf9Jc+ERFI+g==
X-Google-Smtp-Source: APXvYqwYGSEvrM48LXFDP5vFWPPaJcXG593h/ILPqmXTbu1OdYk30ZB2j1vn0iu2ImWvVh0bmoDFmDfGbZuJlzpAUBM=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr3029835oie.146.1581433359096; 
 Tue, 11 Feb 2020 07:02:39 -0800 (PST)
MIME-Version: 1.0
References: <20200208120022.1920-1-eric.auger@redhat.com>
 <20200211085526-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200211085526-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Feb 2020 15:02:28 +0000
Message-ID: <CAFEAcA8hWyHYk+PPLsyjyqiRqaWfosJwrpFpsRXnO+toSzaZfw@mail.gmail.com>
Subject: Re: [PATCH v15 0/9] VIRTIO-IOMMU device
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: jean-philippe@linaro.org, "Tian, Kevin" <kevin.tian@intel.com>,
 tnowicki@marvell.com, Juan Quintela <quintela@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, bharatb.linux@gmail.com,
 qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 11 Feb 2020 at 13:56, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sat, Feb 08, 2020 at 01:00:13PM +0100, Eric Auger wrote:
> > This series implements the QEMU virtio-iommu device.
> >
> > This matches the v0.12 spec (voted) and the corresponding
> > virtio-iommu driver upstreamed in 5.3. All kernel dependencies
> > are resolved for DT integration. The virtio-iommu can be
> > instantiated in ARM virt using:
> >
> > "-device virtio-iommu-pci".
> >
> > Non DT mode is not yet supported as it has non resolved kernel
> > dependencies [1].
> >
> > This feature targets 5.0.
> >
> > Integration with vhost devices and vfio devices is not part
> > of this series. Please follow Bharat's respins [2].
> >
> > Best Regards
> >
> > Eric
>
>
> Looks good.
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>
> I can see this merged through ARM tree, or through my tree with
> Peters's ack for the ARM bits.

Either way would work for me. I left some review comments
on patch 8 which I think is the only arm-specific one.

Can you use the virtio-iommu on x86 ? Would you want to?

If I'm not misreading the MAINTAINERS file the new
files in hw/virtio aren't covered by any existing
entry there, so we should probably have a new one.

thanks
-- PMM

