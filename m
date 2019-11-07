Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4A1C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AC6121882
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="phknA85Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC6121882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSmNv-0008EA-43
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 13:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iSmLJ-0006kT-6p
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:17:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iSmLH-0000TA-S6
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:17:12 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:35423)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iSmLH-0000Se-MD
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:17:11 -0500
Received: by mail-ot1-x329.google.com with SMTP id z6so2863017otb.2
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 10:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RaapY5XQlNgmG2EtBxjEq8/30wwpYxNKsBz/jnFWk1g=;
 b=phknA85ZOBn5kEwnA4URCPyNTUCia4qq+9kvhNlDRImSat5EtarY+j8jw9dVaP3Sa7
 zV8dvNntwwSBEHSXmHW+vOIhxlglW/cWnLoaWqI9tUuNnWOb3k7qxAyumknzxQ6BANl1
 L8uUD+IQ4DNlBKfpJHWYdwvDHshzTZ5n1V5zu9BbmpEZ5N3UWCEukH5inAkWJIFpoe66
 p+8c2aOikx0obb6yHJB66fkuKnUga3drhOIILgJqHalkP1ptNM4kPm0uJNpMdcAd86nG
 GX9L5aC77nD5zTISuKr6QiEm05eDdVA4ipvtA2f0OYApTYmaPC2aADky4ARynuWdLPTY
 hljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RaapY5XQlNgmG2EtBxjEq8/30wwpYxNKsBz/jnFWk1g=;
 b=PoTYFcP/KS/lULErMCXVjeFzLQ3topF1ojAwd3C7S2l1giRer+rfpftQ5WKrTZAiMo
 5zCL1DcqQklk41yOo7Ev6YikMmxFpB+RAWzQ/vAlpaqvrzgKWwksa3RVOfcmVAwEZXeI
 AubqLSJHEuC90oSsh3lZSLJsgo+5oj3C8569/QCevlP/xmx9c1e98dGijgtG+3g/sCJr
 /3hR6+NsDVgcnPMEPiZ7ZyZQTkQLTJcYWij1aSbAAg+fh8pl/sF309V2/3jcrAuFQ6fU
 zpVDvwmHVigYVnIfZnBVQLE8Wv11Fj87zL1Qqv2tKg/GU2vv8VXQdRVyEzDMz+JR54uS
 Y7hA==
X-Gm-Message-State: APjAAAWlo+LIEjjh0YnpjkeRa0QWfKcxjbzzpaqVFq+VnROMT1nfiwjr
 pzFSWIFYA6tWbb2flPx+r9ny0igtxY4uUtl0jhxUSc5qbCs=
X-Google-Smtp-Source: APXvYqw2/6ayWEno7V1htJrHQNWarLkw3CuSSIXjleC/W+XZWnrzNA3o8u4o2EXDAE09ICtQf4jRAxXoJEVAzKoeiWY=
X-Received: by 2002:a05:6830:1386:: with SMTP id
 d6mr4127040otq.135.1573150630780; 
 Thu, 07 Nov 2019 10:17:10 -0800 (PST)
MIME-Version: 1.0
References: <20191107143356.579334-1-mreitz@redhat.com>
In-Reply-To: <20191107143356.579334-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2019 18:16:57 +0000
Message-ID: <CAFEAcA9QQ6=rJuPZ+-smow6F68WSyXY0muZSkeozB8s3J-1FxA@mail.gmail.com>
Subject: Re: [PULL 0/3] Block patches for 4.2.0-rc0/4.1.1
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 7 Nov 2019 at 14:34, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit d0f90e1423b4f412adc620eee93e8bfef8af4117:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20191106-pull-request' into staging (2019-11-07 09:21:52 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2019-11-07
>
> for you to fetch changes up to b7cd2c11f76d27930f53d3cf26d7b695c78d613b:
>
>   iotests: Add test for 4G+ compressed qcow2 write (2019-11-07 14:37:46 +0100)
>
> ----------------------------------------------------------------
> Block patches for 4.2.0-rc0/4.1.1:
> - Fix writing to compressed qcow2 images > 4 GB
> - Fix size sanity check for qcow2 bitmaps
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

