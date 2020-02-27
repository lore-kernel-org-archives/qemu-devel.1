Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1010AC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF6D2246A0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yW9mwJRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6D2246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Kjb-0006ic-VV
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 10:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7Kix-0005zs-16
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7Kiv-0004hh-T5
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:05:14 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43633)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7Kiv-0004dq-Mf
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:05:13 -0500
Received: by mail-ot1-x342.google.com with SMTP id p8so3156305oth.10
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 07:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p8f6PdkyQTQ19JtioTotNZHYmsEx69lTT29YwyjTEls=;
 b=yW9mwJRSAF263UuqUfV+wEKxIz9YGyZMdTiCUbH2Rr7bCnOJDCa1hIUZ4KwLiD+1Ub
 lKGqnb+KA3YF4FNhxkNTdjP0RFmGR1mcD0qXqAJAcl1Sc/mnM+IcdVJuWJzMqIMOg2kb
 0ReLVJAtDM+tFXeMhS67OdEFn3v1ZerY6PcmDm+1ddYu+sZKiWVSHimgRQ+Nlf4gzDyR
 4LEGCOlZHyvQLowT7+CEVWmW3bqRGqz6xDheFskGoHL9klXvsMNlmCxhNIAvrhH+kM//
 +jdcF/0vj75oBFC+WFBNuByRrLdOTU9z+918f5lifSOI/n/g7tptoWtmcOobWtZk24Zy
 HbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p8f6PdkyQTQ19JtioTotNZHYmsEx69lTT29YwyjTEls=;
 b=qrGJS4rKGeGLblJFd8iGfLcIh+YpHbOaIrKp77A5v2r4XDxMbe2eXIfCWrJmG1HShX
 mUtnQG+n3yu3JyI/Keqfjd5XzvNtK81acaVNQAY/4tL30topmKywliUUOaip8oy+WLS7
 /QfbqDln86sSmWxX88TPl/6XKep4VBvp1RAWUCsptriBCLHETQnB6I6o6ARlQGBMcrCw
 zvAUdIZROtJDvzPA5fQMtBkHrMq/O5DY1lfL5cZVO0dw5UXX+KqkVSp0EsKJJGNmTvGp
 66SJ5q15WDv/OWydbjQ4zmRSCTfTxzUxyj2gaJ7927uo3wy+gNkHL9Q502YnaJE8VNrD
 ybzQ==
X-Gm-Message-State: APjAAAUI/dwBFgaupXp784j9bWsW8BGlFOEEqTG2jEHkPLAN35uLX2hP
 K5qT82rdYZRTU+5xDaBGDB21OCqHSvI3O1/ckKp1Gw==
X-Google-Smtp-Source: APXvYqzN9NdGn6+qKLtsWfb0XwBLfORjF5GLKxjRj+oGr7cnHAqjizsRjrQpy/ZB2lYWnzaluivrd+KzK/SFt/jeEtY=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr41735oto.135.1582815910815;
 Thu, 27 Feb 2020 07:05:10 -0800 (PST)
MIME-Version: 1.0
References: <20200226113034.6741-1-pbonzini@redhat.com>
 <20200226113034.6741-19-pbonzini@redhat.com>
In-Reply-To: <20200226113034.6741-19-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2020 15:04:59 +0000
Message-ID: <CAFEAcA_NsRdBOYXh=W1qgnrkh2o=Qq6RXBm+WtrVtRYv1ZL_Yw@mail.gmail.com>
Subject: Re: [PATCH 18/18] docs/system: convert Texinfo documentation to rST
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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

On Wed, 26 Feb 2020 at 11:30, Paolo Bonzini <pbonzini@redhat.com> wrote:

> --- /dev/null
> +++ b/docs/system/images.rst


> +.. _disk_005fimages_005fsnapshot_005fmode:
> +
> +Snapshot mode
> +~~~~~~~~~~~~~
> +
> +When using the (unrelated) ``-snapshot`` option
> +(`disk_images_snapshot_mode <#disk_005fimages_005fsnapshot_005fmode>`__),
> +you can always make VM snapshots, but they are deleted as soon as you
> +exit QEMU.

This syntax for within-document links doesn't work; the link
needs to be written

+When using the (unrelated) ``-snapshot`` option
+(:ref:`disk_005fimages_005fsnapshot_005fmode`),

There are only about half a dozen of these so I'll fix them
up by hand.

thanks
-- PMM

