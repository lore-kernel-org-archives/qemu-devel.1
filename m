Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EE4C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C931E20989
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W4xDIOwH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C931E20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiLtv-0004DR-7Z
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 12:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39094)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiKu0-0006M3-PY
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiKtz-0002JX-FH
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:41:04 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:39494)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiKtz-0002J2-43
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:41:03 -0400
Received: by mail-oi1-x22d.google.com with SMTP id m202so13406489oig.6
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 08:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rGW5k5Paj4tmdYv1D9BIVYMWFzsHfil6atEt9kC7Xx8=;
 b=W4xDIOwHB6Mfuwxg3difxw190UlhwuxEygMlb0JEFkehSQc/JFgrW8dlonSq0QPhzf
 zlh0UXZh9fK4wZhlrExqFcuAwm0oazNKFhEjR6OkWkMdTEGUDa5Bvx9VBcJ2Mqjx9RQu
 hEUbhLExNukQHooOvEI3nyXHWyOVMhO43KUYjFV5YTDCL7yMgk7fSCAulxgIyOsQr6zf
 lmfmBCGd1BYo/WfW2eHHJTpM+xGoSSefPQitlGbO24jWcbnB7z4ZUGWPCmwS9n99mcQt
 V5JRup+NE1EqZXsfjC17OGF9i5dycgE8irFH6EKfWQtkhKVakcacFKqKK2WTQqqe5XDV
 8c4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rGW5k5Paj4tmdYv1D9BIVYMWFzsHfil6atEt9kC7Xx8=;
 b=tqRo3Sd0ac2761PoBelHOeqnTwetHsVk3WKqD/H060h2GGSN/9xEEPdQvys5zwZShF
 T0YxJXSPjEoqVSS9ehF4U9Y+CxZgYLAsB9f1mR7OW5YxVOVLznO7emB0Xiqh//7j3C7O
 oMh+O3YyImx9szu6GcFXbIIuLFLBxwmoVT6N4fGczwwN2w4++97S4lnHXEdqsvhnVnD/
 nImdkPzPSSc0MbRjdP7c3KK6MO5hTKPdW/d9ewdxhz7qGKAztVFd+WLv7oIxjAgV66N8
 YXkAbfuHSYlv0iTBBEva6dvCfjIyUSboqc/kTmSUTDO6Izp43vDxzz/SpzYYitirL+XN
 bURA==
X-Gm-Message-State: APjAAAVzxLKpkOsJzp/cJMxdNa4qFpGpaUeej6xAZfLFHMP/T58Cf0qy
 tg4dGNcLm1Pao7/uNQVeJ4fldSRQCTtK6C25fvFmKE7oh9Q=
X-Google-Smtp-Source: APXvYqwK7b+bmR7daN2HOSEc7H1ehaB4yX2yed8uBzPWM8XtERaQu11fJ/NhngUv9U0QuBX5h16vmNuqMU7zNMHlEd0=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr3497590oic.170.1562082062243; 
 Tue, 02 Jul 2019 08:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190701175437.19223-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190701175437.19223-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 16:40:51 +0100
Message-ID: <CAFEAcA8YiXWcb7bg0dHoJhs6NdNMzEJUA88p4M5y0ict6j1X8Q@mail.gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
Subject: Re: [Qemu-devel] [PULL 0/1] qemu-openbios queue 20190701
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

On Mon, 1 Jul 2019 at 18:57, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> The following changes since commit 7d0e02405fc02a181319b1ab8681d2f72246b7c6:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull-request' into staging (2019-07-01 17:40:32 +0100)
>
> are available in the git repository at:
>
>   git://github.com/mcayland/qemu.git tags/qemu-openbios-20190701
>
> for you to fetch changes up to 9f4886430d61a4c452c0f1c6f5efeb1bc256a859:
>
>   Update OpenBIOS images to c79e0ec built from submodule. (2019-07-01 18:37:05 +0100)
>
> ----------------------------------------------------------------
> qemu-openbios queue
>
> ----------------------------------------------------------------
> Mark Cave-Ayland (1):
>       Update OpenBIOS images to c79e0ec built from submodule.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

