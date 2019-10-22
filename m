Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8971CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 12:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5177B2075A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 12:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="laaLpwQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5177B2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMtY4-000871-Fc
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 08:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMtWx-0007SL-Ap
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 08:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMtWv-0000bP-Mw
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 08:44:54 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43691)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMtWv-0000b7-I2
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 08:44:53 -0400
Received: by mail-ot1-x344.google.com with SMTP id o44so14015527ota.10
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 05:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MQMQS9X8FxXUakL8jBDxQ5LiW7Ue2emV11Dz8Ypfc5E=;
 b=laaLpwQiHvtQa1wZOicEwrzJf9XiQTTPE6hfl8iT6tnzAC0RlpaAFhKPY4aWeOo3uJ
 k72qOQ/RzY1swhpJ5TqSR64MY63mhdoFvprHdYbRA2di+AZYDdOA2SAzkI3zO78DRt9Y
 WcxnlFhS4KyBdeuvhr83wbXGPvVzT48BVAFUgHefO+Yw3lqqCaIjxp5pEdEilYEyqOB6
 di6CSRd/GMqRnfYrG+LZlO0KXWVYsGgZCuAxmmtD/Daoj/oxPp9wScEhz4g14vEs+WGh
 U/EcdLLVljEXxAHL45HFOHSZomuM3Ga0F/tnXjSqT16a45AQNgdKQvZyWNXQhq+ICGJs
 +KoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MQMQS9X8FxXUakL8jBDxQ5LiW7Ue2emV11Dz8Ypfc5E=;
 b=ee0HVqzQVVKylPqoCTtftwliqtX0dz8lYcFWzFL3tB02xhZfOcWU5L2PqWV5Vt4n1L
 DAKerNFU2357oEa1wkq/jXEG037eeXCz+GpHdohuqvqCOHOCrJloiC2hUFxnfPfZlUTb
 zkHdtk9kBqN3humEqQhHj8yc9bqie/ejfaJ+kno8/4kvYthZRgKnC9EFMl/Q+pSg/VIO
 MRZMGvyc76EzcSMmzOx74bdh+l1sirI9u26LB6YsWy4vMUUVXwHY7ZRoswIBxJXwMI6X
 HiOYI7CRryYuTHnXh02lxv+mkgfUfHRjwIm6ceLnB5cSpJaFT4sGu16TbHPy+cZpdzSj
 ppyA==
X-Gm-Message-State: APjAAAX57Ermn+FyI6i5oqaiRY8RGoT7V5IyVaXqeARJ5pTgxs+OWmxs
 4M9b6hSxyCeOhGHI4a6EVn/gAxYs6rhL4LeuKpa4/O4TFzc=
X-Google-Smtp-Source: APXvYqwqKdJt+UjX3zBntFKUDBA2bJ1iRmCGTuwDiaOD8SCYfwHJ7mucLXRrA8mkLDizhtmd31cDH3abrQN1SPdiW6g=
X-Received: by 2002:a9d:708e:: with SMTP id l14mr2558424otj.135.1571748292171; 
 Tue, 22 Oct 2019 05:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191022082553.10204-1-laurent@vivier.eu>
In-Reply-To: <20191022082553.10204-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Oct 2019 13:44:40 +0100
Message-ID: <CAFEAcA8HQ=MeU=gayhsrCrO4EZgkP-Frd4HvZvcz+FuVV=wiqg@mail.gmail.com>
Subject: Re: [PULL 0/2] Trivial branch patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 22 Oct 2019 at 09:27, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit e9d42461920f6f40f4d847a5ba18e90d095ed0b9:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20191018-pull-request' into staging (2019-10-18 14:13:11 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
>
> for you to fetch changes up to 81864c2e6166c015d30b8d8ae998a5a1238a68e9:
>
>   tests/migration: fix a typo in comment (2019-10-21 18:14:43 +0200)
>
> ----------------------------------------------------------------
> Documentation update and a typo fix
>
> ----------------------------------------------------------------
>
> Mao Zhongyi (1):
>   tests/migration: fix a typo in comment
>
> Thomas Huth (1):
>   qemu-doc: Remove paragraph about requiring a HD image with -kernel
>
>  qemu-doc.texi            | 4 ----
>  tests/migration/stress.c | 2 +-
>  2 files changed, 1 insertion(+), 5 deletions(-)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

