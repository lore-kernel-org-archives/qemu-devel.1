Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63747C742CA
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:33:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31029208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RJJjhbst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31029208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlxY4-0002D0-CN
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 11:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34271)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hlxXr-0001kX-8j
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hlxXp-0001DE-Tj
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:33:11 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:42011)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hlxXp-0001CQ-Ma
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:33:09 -0400
Received: by mail-oi1-x236.google.com with SMTP id s184so7562529oie.9
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 08:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JvnRg6oN/wfzknfYgio02li+HQKaM4NOdDyXFaC8JxY=;
 b=RJJjhbsta4/rzqV2Yby+UkUp4KcQ2EoAgSU9LQtSCVLe38R5VfqiYiXdxAhZpIFyJ0
 ybtm0Z5FT3ge6MR8OEGlLuJL9rppzv+2VgI+xdD5t1nMqTCwO8NQw4Pfwn765iHaAW1f
 G3Bu12Yq4k/VPze/AK8JVC3N7fGKOOGwTgoKgbPvYniW0IBBOZ1VvGsym4FhVe+2rZj4
 3rDHQACatqY8M7MHqCrcmZS06jbsDxdJQ8qVg+YWSqFCU2CpBuMMLCZJaQwh6JF+Qgv2
 dw2q5e/MwOIPaREEYRB77snBjSCao0T28zj3qzIJ0XYPd93oqOwxWCilOpLm1MgW3rzT
 fLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JvnRg6oN/wfzknfYgio02li+HQKaM4NOdDyXFaC8JxY=;
 b=lKnADvmyEMNvVf5I6AwFg6jj0h+RyGzmNfzfiwwkHPNN0jXkAibnxqpmR2oKuhddYv
 bRFJFmdzizJywuALYvv2ZY6W1isJP7z4fKer4H8Kg1Yz7uHho8DbJo0KUgnvF7lw7RUl
 nXoxCJtvecIur3W24HDewndJvnPXQ8dnngPgsPHWcyT0AcLb7L4BqBeQJBZlcWZlY6iz
 jJkkoikKlpEnpK4Njh5rw3pzWEmvZSCchzV02YkJZTsDsFqW0JaqeCI21QL78eZMUw0n
 F0CTD466H/il/89eFqFgJ5vqX4lm0iIUU6fNAaNwqbffro39iOvE+wssYyq0D+tX/4Yh
 cYaA==
X-Gm-Message-State: APjAAAUr8L9cn9z5dU3R8m0ax3BVeAzzsDYpaset7Q4zjdIepEDg8g2h
 7MPE/EOmdrLaqiUC23DHIV5+djf9DaU8AJ08niV8eg==
X-Google-Smtp-Source: APXvYqzBu2W4tj4siRwfrlD5VirSjENm0FHpn9FZnR4WAMZAV8b6oFBzUsZQ46FiDyRaZqtr3JzXbJgXhJsn+IUijTU=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr6173166oie.48.1562945588160; 
 Fri, 12 Jul 2019 08:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190712135253.9410-1-kwolf@redhat.com>
In-Reply-To: <20190712135253.9410-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jul 2019 16:32:57 +0100
Message-ID: <CAFEAcA9BYbKfQziaUdv6Ryyp3UvqSVrX_u6X3XNYrjXvvBgx=g@mail.gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::236
Subject: Re: [Qemu-devel] [PULL 0/2] Block layer patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 12 Jul 2019 at 14:53, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit a2a9d4adabe340617a24eb73a8b2a116d28a6b38:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.1-20190712' into staging (2019-07-12 11:06:48 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 867eccfed84f96b54f4a432c510a02c2ce03b430:
>
>   file-posix: Use max transfer length/segment count only for SCSI passthrough (2019-07-12 15:42:23 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - file-posix: Fix max transfer length for non-SCSI-passthrough
> - iotests: Fix 082 reference output
>
> ----------------------------------------------------------------
> Eric Blake (1):
>       iotests: Update 082 expected output
>
> Maxim Levitsky (1):
>       file-posix: Use max transfer length/segment count only for SCSI passthrough



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

