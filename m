Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88808C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:10:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D6BF206BB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XHzhGtCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6BF206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hziMD-0004A5-Cc
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 10:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hziLD-0002pB-6y
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:09:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hziLC-0005IU-0C
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:08:58 -0400
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b]:45658)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hziLB-0005I4-Qd
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:08:57 -0400
Received: by mail-io1-xd2b.google.com with SMTP id t3so4497059ioj.12
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 07:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9bKYx+zJ6NiHXoUt4YObnCpnjcuxo/ICemB8c0x04/E=;
 b=XHzhGtCV0BEUkicmDdt4OJoyG9GxICaRA0gLjTv1niSGLFVdAkqZ0k42PCVqMqsaoQ
 uVgpCu1INEXokzbcN8qQ5pGqNFJGEgHBFcBVaaLPZ3VkFgoEpj7IPlW1fZuZn1T6C/9U
 ol6NKzxBptfPqXDEYeACCDzVftjCwNAVQ3mUH8DDB+9tv63XHBOVVInGDnJ330ZwIq49
 ACTg4p0uItj4fuZ6rVLRLnQEDlHfoQ5SlmbLCuRiyQ0XEuExHSFqNChN5WQtFMrdMTRe
 O/3VlHxxcdG//GyXXSiPehp7adXa54tYVmck8XXYmnISMdldiQVqMXaY+F7tSaisdBSA
 lk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9bKYx+zJ6NiHXoUt4YObnCpnjcuxo/ICemB8c0x04/E=;
 b=phcDens3LknkkW5QoYfYfib3QrucQvt9vv0huClcAY/yYda0IKOAfKiStasQ9zlKyq
 vNS/URz+BhQgXE8d5Ai/FqtRkozao+j53iAB25nWEdyX4dC6IqUS8mDW1BHu9q32gy0q
 QwfC/TTTjWIOSddvao2xLJoa4yrk1TO9u/QDOSnxjd2cGEeZv3PheoNv1+WTbHVuVH7j
 wOMTprlr1J9gC9mrIr9/mjOmoX+c908t0S5FHzC6/dAzVziAQH8Ecwj2kk0Lkc0ROYbu
 Hi8v1waLppT5lh1q1Uzc/VWyfu8qA9VvMC4jWmqPG1fibH5Io//TjGtSQVJmurQkJusF
 G6BA==
X-Gm-Message-State: APjAAAU9Mppq2BQmWOy6ZeM4mxVD+j1ryrZT664BQ8dtKUjQ5ij/VekG
 6Refl19IqZyJ5xtVssRSPT7nRcMAxY7+OVDqiVLcjw==
X-Google-Smtp-Source: APXvYqxtsPe2YuYuOgRJAMQaUpx7h0zJwj0WN0qP5GcGwRlOLVz0tMXcyHatkx6T06dP0XELhUqECo0D8aYOLA7tExM=
X-Received: by 2002:a5e:9319:: with SMTP id k25mr15971959iom.137.1566223736849; 
 Mon, 19 Aug 2019 07:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190817085443.11471-1-thuth@redhat.com>
In-Reply-To: <20190817085443.11471-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Aug 2019 15:08:45 +0100
Message-ID: <CAFEAcA84O3B3d9Tyi2NeB05Mk4_jhZuP10punJX5tspdkcU3Gw@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d2b
Subject: Re: [Qemu-devel] [PULL 0/3] Run iotests during "make check"
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 17 Aug 2019 at 09:54, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit afd760539308a5524accf964107cdb1d54a059e3:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190816' into staging (2019-08-16 17:21:40 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-08-17
>
> for you to fetch changes up to 72e031f3b80a421b309ce0d1759b26e428f944db:
>
>   gitlab-ci: Remove qcow2 tests that are handled by "make check" already (2019-08-17 09:06:17 +0200)
>
> ----------------------------------------------------------------
> - Run the iotest during "make check"
> ----------------------------------------------------------------
>
> Paolo Bonzini (1):
>       block: fix NetBSD qemu-iotests failure
>
> Thomas Huth (2):
>       tests: Run the iotests during "make check" again
>       gitlab-ci: Remove qcow2 tests that are handled by "make check" already



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

