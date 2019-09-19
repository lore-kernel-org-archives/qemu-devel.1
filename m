Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69BAC4CECE
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 948D82196E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iWzA0JQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948D82196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB0OH-00019j-Gw
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 13:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iB07F-0008UJ-BI
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iAzwu-0004Uq-HI
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:10:33 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:39585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iAzwu-0004UI-AN
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:10:32 -0400
Received: by mail-oi1-x231.google.com with SMTP id w144so3397607oia.6
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 10:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FAB56JFUu/yqM7hm8jrd94XMu1x4vrGYZIwKIFYAjFI=;
 b=iWzA0JQHEQ9C0YnxgVOSCoKbIubodbDcjr3bXeiIXIq8Kde1xoDAfrLqxXMJL6iMhG
 Cc4DpNIdqcdahXc1x4dHpBjMMAJxs6wKMZ+9Jq9bMB97g4TzO3nBB43nAeWL4d35JjW6
 9uwWfIfehjE/5aThhZcteChRA54GcX1amZib6vMrVWudWSOzoIkst9ZPTIayCFlpBgqA
 5c+lCkvBZSqAXEhhnlDA4qAXno0KvqaupG94usR6LLuM/7lCPvO+JupkFYxUshzY6Kk4
 lTTrnOZrv67iLeIYEHfcIuZQpqULx/bB89g2DrGW/GNlDObes1WHc2v13ORm3b9nQGxz
 XhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FAB56JFUu/yqM7hm8jrd94XMu1x4vrGYZIwKIFYAjFI=;
 b=dDdRPYXWIhoo8Ppj5ANBnKy7//JttZJa/RPHrzxLeBRsi5KdKwnOgjF6Id+JEo594a
 LP5eVBB52IN5tZ4M11he57Gr0pDPCOUsdyRvd1T+8MwWy69hrWYIE7dD0/MlZuLSYooi
 PBS5oVbtLoLPdTo3BUv3AFq3agPPb/gX4Y4dvi6yGhDWzoWYycMKxbdBwkFxpoFbiehf
 rhdu3DnsJPRMidJEcBd75NV4x2huNppE5C/9bJmudkSaLCe/7JQAg8T4LgMhpIEK3ZWz
 XVzIL4xT4OoLmPlvhtnRnrtgkDircDclXgFPUl5xgI7biImUYH91B6CrCwGeY0n/dzwj
 CqJA==
X-Gm-Message-State: APjAAAW9K9QztDSBuycfYjd6nnyPZDj0Gxy7O+5M22U6ImeHPPZWN4JM
 6H5ESp9b+0EUqHxu6fTJQd31ESm4jDL56+LpNdEPTQ==
X-Google-Smtp-Source: APXvYqxRZVlhegsAylO9qXC1cu18bKpdy+v/FGTqZb2W2a7lN9UpFD+z4ZxqQHShSRfEqnH093rfhi0PqS7EPLN4A7k=
X-Received: by 2002:aca:b646:: with SMTP id g67mr3170823oif.163.1568913031415; 
 Thu, 19 Sep 2019 10:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190919070918.16059-1-kraxel@redhat.com>
In-Reply-To: <20190919070918.16059-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2019 18:10:20 +0100
Message-ID: <CAFEAcA_=_xZEGVxEjNG8XF+pdjpLQP_tJOX-dZcViUBnLAKVeA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/4] Ui 20190919 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::231
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

On Thu, 19 Sep 2019 at 08:11, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 89ea03a7dc83ca36b670ba7f787802791fcb04b1:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/m68k-pull-2019-09-07' into staging (2019-09-09 09:48:34 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20190919-pull-request
>
> for you to fetch changes up to 6bf21f3d83e95bcc4ba35a7a07cc6655e8b010b0:
>
>   vnc: fix memory leak when vnc disconnect (2019-09-17 13:45:10 +0200)
>
> ----------------------------------------------------------------
> ui: add barrier client.
> ui: bugfixes for vnc & egl.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

