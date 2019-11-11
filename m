Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD87C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 03:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A11207FA
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 03:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lHIHI7p/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A11207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU01N-0006YQ-5y
	for qemu-devel@archiver.kernel.org; Sun, 10 Nov 2019 22:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stevensd@chromium.org>) id 1iU00N-0005hw-8r
 for qemu-devel@nongnu.org; Sun, 10 Nov 2019 22:04:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stevensd@chromium.org>) id 1iU00M-000770-7S
 for qemu-devel@nongnu.org; Sun, 10 Nov 2019 22:04:39 -0500
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829]:42476)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stevensd@chromium.org>)
 id 1iU00M-00075Z-1e
 for qemu-devel@nongnu.org; Sun, 10 Nov 2019 22:04:38 -0500
Received: by mail-qt1-x829.google.com with SMTP id t20so14143773qtn.9
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2019 19:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s21XsScROhu9BPmbzGcegcYHTdkPFhp5GNL2cd4PxbQ=;
 b=lHIHI7p/r0giqXhBuGIZTt9zqLjVH/cm3hvX6R3JDUCmIvBCXP4RL/iU0REkYn+lJg
 VBwHj5196iFxzjLkbOlRgKQXcgu2EnT1sM8txIrRx6rt+5ofNp8ntZm9xXoA0UlKAUmz
 plhdmv76n5zJLHDJ+LnpkSGmmuBrxhE8jOyww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s21XsScROhu9BPmbzGcegcYHTdkPFhp5GNL2cd4PxbQ=;
 b=N6AEiRbLO4DikYLHJlwehJZ3T1yvus7i2BfJfe2P+qDOIUUjLMD+KlVmqvf2GjS/f1
 kXOs83Arb9saniR2KuAjA8KNRA9fGwT+mKUh05ERf9sCH4E3p5Q+yIuwJb3aGLspRctJ
 HdU7H9ggyk/zsVfDa1Mv33chhrG7mzw1bfjohM7xNf4BlN+hQi9ONo45wnB8MQHRz8UF
 eWq5rYGRpiukNu57WqPlJOCRulbE2P4Ks8r4S8+SF58wAbKI3HhWLZ2uqbbyL/BdDh8z
 jkmd4c7IUdZnh/jQFFu0nFQwHUJ0jX75VNP8nPVXTUFCpFjN1bwzfU1qreK8tiFtutCA
 ubkw==
X-Gm-Message-State: APjAAAU57YaOa1SM+siSFCl/d0z+jlFAXThy5r8JXjx01XhWUKTPS+bz
 2DKB1X+F5EFdAKkNmkBauWDj6koRAiX22AnS7dcIWg==
X-Google-Smtp-Source: APXvYqzEgRqM2b1k3cEN4mloUeEOhrf8cOZLFKV98ttWSKpDVQ51Q/jYgDxVozA4BQjDVb9G2TwgPcL03Ye994sE63s=
X-Received: by 2002:ac8:7216:: with SMTP id a22mr23844828qtp.187.1573441476623; 
 Sun, 10 Nov 2019 19:04:36 -0800 (PST)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain>
In-Reply-To: <20191106084344.GB189998@stefanha-x1.localdomain>
From: David Stevens <stevensd@chromium.org>
Date: Mon, 11 Nov 2019 12:04:25 +0900
Message-ID: <CAD=HUj41r8wHZ2-By8tLftkoqC5r_Bw=pr=zX2aZ7GTs1ESWhg@mail.gmail.com>
Subject: Re: guest / host buffer sharing ...
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::829
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
Cc: geoff@hostfission.com, virtio-dev@lists.oasis-open.org,
 Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alexandre Courbot <acourbot@chromium.org>, qemu-devel@nongnu.org,
 Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>,
 =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Morozov <dmitry.morozov@opensynergy.com>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> My question would be "what is the actual problem you are trying to
> solve?".

One problem that needs to be solved is sharing buffers between
devices. With the out-of-tree Wayland device, to share virtio-gpu
buffers we've been using the virtio resource id. However, that
approach isn't necessarily the right approach, especially once there
are more devices allocating/sharing buffers. Specifically, this issue
came up in the recent RFC about adding a virtio video decoder device.

Having a centralized buffer allocator device is one way to deal with
sharing buffers, since it gives a definitive buffer identifier that
can be used by all drivers/devices to refer to the buffer. That being
said, I think the device as proposed is insufficient, as such a
centralized buffer allocator should probably be responsible for
allocating all shared buffers, not just linear guest ram buffers.

-David

