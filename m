Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F092DC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4FD0206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qp03dGSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4FD0206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRIz-0002xv-TW
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCR3G-0006Zo-NR
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCR3F-0007Xo-Ln
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:51:18 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:33874)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCR3F-0007We-G3
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:51:17 -0400
Received: by mail-oi1-x232.google.com with SMTP id g6so6172991oiy.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PZgDY9vobuSxnyPWf5zwR7bM4JNhdhgHqHxRg5+U/IE=;
 b=Qp03dGScRk0q2keb5WR3oTEbBVZ/y81Z4Gr2VB/rZJuf2ucvrJBZ0VnhHwhOF99B9G
 Xa1wCttBwW1cUQDV6+A64ilSUqHOsLwDA6qHBzlNhHoSMAKjpN6aRs00wF9Y+JVecVo4
 OZUFf0nYKIs9YIlbeb5C4jQtdD0ZXHLpoCstq2s5UpIB9Cu7hZDtA1hK7bJb9dTAxicX
 3nyDOS5CZVwQQ3v4YEzM8i26w23PBFJXwVtM2d13oHaQosqtPOfnBkKfCwSyWDaL1MBL
 jHZfMIFnWWhgwCZAZ5ZVAnciwTiK0YXJrmkNI9IVr31jct6GWQ6K8HXElUCJvcbyq++W
 BYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PZgDY9vobuSxnyPWf5zwR7bM4JNhdhgHqHxRg5+U/IE=;
 b=R9QqO0mpGxftSqPcyXeaFmU7OJzAx9bTevHhV+Q1lQLdGRSAPM7UzaJGJt9BHwxw9I
 sVOnzh3r9CTwUeYMCoc6vvOSBltCS65upWqzDUwi1+ZsVRHxoSlaJBW3/uAt0PwWquc6
 TUgA2zqKxI7gARSbiJGdUW7/gTfx38YXh1sIPzff0/9Gd6zTBkdMTnUGKkbO3+qQqtwR
 Ffdz7dYP2ASF+wJRcdU2XA5Y3XprTtKFLEbIhMObcilR1a+BTBzA7St4OUSpVHFXnKjP
 t8SY4h/sBeQoP5dV6kBLPnz+1hv8KtwoSFtF2ZiXBHC1KOsBsM8imyKsD/6FvvEeIp7K
 ZNtg==
X-Gm-Message-State: ANhLgQ3eXk1UHDCqpdKA0Vn3KBIXXBt0w73MkfeIJ/KSnzMhOMloATDV
 rmuHcPVdCFDs3CnlhKemFRIJeDfvFcLEZIsMUaiFwA==
X-Google-Smtp-Source: ADFU+vuSiFYWLpwVqHa5JhYf/ItndY9ohSH1P+pMldoMMMJkdTXsp+KWVclCkCYz8SHndOH7O0ZSjGgxRq/h27jjY18=
X-Received: by 2002:aca:c695:: with SMTP id w143mr3394834oif.98.1584031875160; 
 Thu, 12 Mar 2020 09:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200312151521.38902-1-laurent@vivier.eu>
In-Reply-To: <20200312151521.38902-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2020 16:51:04 +0000
Message-ID: <CAFEAcA_iQ018r5Y7gE18YQqRi27M5W7_wzLg=TNUey82mjPkCw@mail.gmail.com>
Subject: Re: [PULL 0/1] Q800 for 5.0 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
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

On Thu, 12 Mar 2020 at 15:18, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 104933c4a973960dea605b06fcd5d0d478255d77:
>
>   Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2020-03-03 12:03:59 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/q800-for-5.0-pull-request
>
> for you to fetch changes up to 80aab795f8a6d53cdeb55cc6ffac50b5e5ce9dc2:
>
>   q800: fix coverity warning CID 1412799 (2020-03-12 16:05:48 +0100)
>
> ----------------------------------------------------------------
> Fix Coverity CID 1412799 (Error handling issues)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

