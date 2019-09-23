Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7014EC4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 18:29:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CD6520665
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 18:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UCqEsrfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD6520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCT5G-0005HQ-DS
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 14:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iCT3Y-0004gp-Ok
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:27:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iCT3X-0007Xk-S0
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:27:28 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41537)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iCT3X-0007XP-MO
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:27:27 -0400
Received: by mail-ot1-x341.google.com with SMTP id g13so13010497otp.8
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 11:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kE6GTsnxEsnSOYqZoVxiBRcQ9jMpOE4rFqMDVVkm1lg=;
 b=UCqEsrfy5zkY+UZnwpriH4g5cs0zmvxd6WR/yB6p+hRusOXUxrDo6qVASIGlFXdwK9
 5r4ASzCYEDjm/CvvwSm0xlyPivfixI1MNls0JqO5gwjRYuul9XsJ7VzD4ZsTHDO/rF+N
 aUfJnucgDqkdCbfXMpdwMpzf8xR5wWPOg8K9JANL+kAlegvH14O34EYer43CLl4u9t8l
 QY5neyzHTufOGnFPfCI6gGWHutsO9g+RDHlESRlXhwhcCA84uuvEyfLWS6KgpaYvghqY
 2lG4M+zNDnubLo0eRVLoRXv4XDyV9vSKHDDv9d0JIrAyv4542DAhfktv1D77jSVxNt/0
 9zmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kE6GTsnxEsnSOYqZoVxiBRcQ9jMpOE4rFqMDVVkm1lg=;
 b=hgWXFiMxo3okk1s+f7eczK6vtdqqJi3+vxuSxy8fQ1gQMtgihAk9Nc+iDRZufbdGUT
 2RP0fgcZFz0gPvrqwnE1bbxw/+G48Vtnlut9f/46SD+JuKIJyVWZRxxlKLhbTrZDY2FD
 tj9gRiPTr0oy/JwVFyLTZNbyWksiwYfnhevsA0kZ9tm5E7jZWU70Au1b5LphD5zSAUxY
 0r1CJ+/okRiMZAFhOP7jFt3bmS8ryyLZorLytJCoT4sDRgJ+KlSOZBFS3IEAX92bJHwk
 SJzMSTSaVJ1G/Ye3sKi84SVkG9qsj0EDUZBf28lNRUZreex02QKWFVDMMDWBIHQI4SeT
 4RiQ==
X-Gm-Message-State: APjAAAUC24AGoPAfoEbRPMnzuelWiU4CK+4Ms5UIfaJXBWCfWyNTBTjD
 BBCd3RQQavwsBzVDpDx+lB+7VRRYvQ3OcNUKfYeEOQ==
X-Google-Smtp-Source: APXvYqwlIOHUYbxQDOXg96jSQ0KvA1c1DZq7q+NDg1FDIQtF8eBxEyCOXiEU9DDULKiQa9z2UCFAChUZHYJ3Mg1yqTg=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr1032382oti.135.1569263246759; 
 Mon, 23 Sep 2019 11:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190921150420.30743-1-thuth@redhat.com>
 <20190921150420.30743-4-thuth@redhat.com>
 <CAFEAcA_6UxMBeyOMM0iT5cnCQEpWXfRO2XMuV9ez_0Su2osXNg@mail.gmail.com>
 <0389e9dc-7f78-5b27-4764-51f0bdef5bef@redhat.com>
In-Reply-To: <0389e9dc-7f78-5b27-4764-51f0bdef5bef@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Sep 2019 19:27:15 +0100
Message-ID: <CAFEAcA8XSQs=fw839O4+tTUqy-DpNh-jdHxQsfYQxm-nTbvH4Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/arm: Move armv7m_nvic.c to hw/arm/ and always
 enable it for arm builds
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Sep 2019 at 18:54, Thomas Huth <thuth@redhat.com> wrote:
> Ok, then what would you suggest to solve the problem that this file has
> always to be linked into the binary? I can't use "obj-y += ..." in
> hw/intc/Makefile.objs since that would mean that the file also gets
> compiled for non-Arm boards. Would you prefer a bunch of stubs instead
> that get used if CONFIG_ARM_V7M is not set?

I thought obj-y was for only-this-target and obj-common-y was
for all-boards ?

thanks
-- PMM

