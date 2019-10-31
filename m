Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BCDCA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 08:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CC3F20873
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 08:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/ZJoWWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC3F20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ5vt-0004xF-Ga
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 04:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iQ5ug-0003FQ-1z
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iQ5ue-0004pf-V0
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:34:37 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34135)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iQ5ue-0004on-Pm
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:34:36 -0400
Received: by mail-ot1-x341.google.com with SMTP id m19so4683688otp.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 01:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ygqzx/hntnfzSa62iHIVKKOle9hpLcFbXGOlXuoe6tI=;
 b=P/ZJoWWqkX+5+5BsAPTdk2bVX9j/jGknMbg0TIJij8qZGRO/FFImbqlxOZ9W9B0Ts9
 h10f0chQ8sudPIRPo6QI4w1cUhWzmlB2IjVm9wV0Po6ENHyTqg+Eizm/WQ8Bc40ltPBt
 oVjKpRxQwrTTJQHhtzFl9HHbgODjpRa4vd+LdM10ftxHhLStbmJ629uln7gbJPEq/wOh
 pcZHFgY1nR0qum043uUV+KzW99j21lHM5Pkn98PGXSAE0K9a9m80yN4F2msbe7kEuc5+
 NR4pMXgetlPppX1A9yjOXWcRYiYN1ovDzeH+44PZL8ymcy9jfk7uTnWBgc0hP0VueWw+
 mkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ygqzx/hntnfzSa62iHIVKKOle9hpLcFbXGOlXuoe6tI=;
 b=e33oG1Y+QPNftCqxW5yqYFLR8tg6eaqtcVjicVzTrJiXsSGT6UBQYq9Je0yX4ip68K
 G4QR9iqZm3ldDoLC3zCUFsX+z7WUPJX07ZchZ80aOxg3bx3fT4wlVMmjzPeH+pJRVsCm
 WIbiaOSYO7yoISvhX1cpJJmIUcL1QYSgo8UGONMuZGxyt47Z6ZrSCvoYjY+9ocvtQz4A
 CyUE2CDHnik9cIM64Ejtzn1KzZn8B4jRlbgmoVWyfJuWLBt0R2FcYngPKClPn3BAKZFl
 t5XNjwnOhAQfTBelzz4VH7UMBLkw5afHgOlRqPUnAA2mviYUmBZA8TuQfH8y73Q/wxBV
 yY2g==
X-Gm-Message-State: APjAAAWOb7YwN4dzYELp2PrHdxkhAwyfEDXDuh4+FfFqxoabM3yHi4+c
 A1Miyu+ivX5dfyb9sjAc2p9jJBukyKvjhkG9mZSmbg==
X-Google-Smtp-Source: APXvYqxDoqmwjcBq9Vqs1rtXzF2Aw5MUkQGJKJNYCyynCxB/QN6O0lwliisQTVXTPA+fz47accD17jOsgQYKBMCZh8w=
X-Received: by 2002:a9d:6845:: with SMTP id c5mr1061693oto.97.1572510875632;
 Thu, 31 Oct 2019 01:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191030163243.10644-1-david@gibson.dropbear.id.au>
 <CAFEAcA885U=w_vY7TaY=ULq+PBGeNAy6AfuyK0repuGiAdgCyQ@mail.gmail.com>
In-Reply-To: <CAFEAcA885U=w_vY7TaY=ULq+PBGeNAy6AfuyK0repuGiAdgCyQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Oct 2019 08:34:24 +0000
Message-ID: <CAFEAcA_esrUjhMBL7cRWpQA__3QRFUAQLsFeoYQ-q2h1Y_RGow@mail.gmail.com>
Subject: Re: [PATCH] spapr/kvm: Set default cpu model for all machine classes
To: David Gibson <david@gibson.dropbear.id.au>
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
Cc: David Hildenbrand <david@redhat.com>, Greg Kurz <groug@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 31 Oct 2019 at 08:28, Peter Maydell <peter.maydell@linaro.org> wrote:
> Isn't this a bug in libvirt ? The default CPU for one machine type
> tells you nothing at all about the default machine for another CPU
> type. Libvirt needs to ask about the default CPU for the machine
> it's actually interested in, which is not likely to be "none".

Oh, wait, I should have read the QMP output rather than skipping
over it -- it uses -machine none but then issues a QMP command
asking about all machines, not just the current one. Sorry for the noise.

-- PMM

