Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E19FC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 10:22:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC69B222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 10:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lNYBmIxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC69B222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Y7Q-0005HR-3p
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 05:22:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Y6U-0004Hn-5e
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 05:21:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Y6S-0005eB-Tj
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 05:21:45 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:46735)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Y6S-0005bn-Mj
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 05:21:44 -0500
Received: by mail-oi1-x22f.google.com with SMTP id a22so8900622oid.13
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 02:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Pgjy7QbThT9nvOaSOpncbnESqIuLrZrH3wL0VQcQvfw=;
 b=lNYBmIxxOuYZxDXNWgdCrRyh3qZNzjpCVHdoyyPfhyBgumNjzL7m5Vwyx8A8i3VCbC
 gIzxYSeaA5Frf1AZLWbPiZQa1HTmHOdt7v1MSRBYpKkzwkcgS3yD0bb1ZEWUYWpBtGeK
 xuKXtXY6f51sH/bGy4z9MWw2NwyninuzvcaWlCTh2DGhFbbwfK4zeS9zUJCS3uaq7W7X
 3PxzFArQdnUthWPRAljPlOqwA7JdnwCFA0kTjFYqBrdwjq/tcG55e5uWEvB5c8+jMCRd
 0+bfg1JKTWMulF9UbhFud6An2EvDb9BiWSzqNDN3W+vIhqou5zHMbiO0Q/zVbHX1vlpX
 PAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Pgjy7QbThT9nvOaSOpncbnESqIuLrZrH3wL0VQcQvfw=;
 b=AHobbx4FiLlx9RAL0B83j5pIWaUXnBUUe9yo2JFbKJYn9fM0IViu8syCMnllx5IS08
 Vt8WF1vaMNn17gvKYh4tQegsXCG7nLYf00tWefx4hTDwzOkC0mNOroZBIXBK84JEbG+F
 Ihz8fbUhIM3SeAD0J70i7QAHA6GB+jeWNFJpMY/wdYnu+wwnOrhX7/VRhxpfCV3zTWU9
 eyfyf/vU6ICb/0CoKHrIoYluQfYLqMV1/UgUE60kWPClPMtQ/RxsUKHyDvsE4umB7RR2
 9tpmTXVjwCaGmSgOW4b1VoaO81j/1OvUlx1pVDCz2n8perb02wj4QWO6t5pcVlGoUziL
 o3NA==
X-Gm-Message-State: APjAAAXnQzUJP4591F4sO7cgeobzssKyefyHf2jn4AZ/6zx+jPIdmspP
 Kw3J5aSBPySn53zprzLUZf7DEeCvBB/9ebQ3Fb58NQ==
X-Google-Smtp-Source: APXvYqzJBRtE/cpBiPFiX9aauglPtSKicFCnPCmqWf3u05J5DrxnOCvdeID/KHMJuIGf8wNdykij4pyV7Ea7s/Rmhls=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr1351447oif.163.1581675703328; 
 Fri, 14 Feb 2020 02:21:43 -0800 (PST)
MIME-Version: 1.0
References: <20200213090627.2181-1-kraxel@redhat.com>
In-Reply-To: <20200213090627.2181-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Feb 2020 10:21:32 +0000
Message-ID: <CAFEAcA8=iiL0+V=7_CiVJdFABVvnD7y8DZTYY-FOGJCRCbkdMw@mail.gmail.com>
Subject: Re: [PULL 0/1] Vga 20200213 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Feb 2020 at 09:07, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit e18e5501d8ac692d32657a3e1ef545b14e72b730:
>
>   Merge remote-tracking branch 'remotes/dgilbert-gitlab/tags/pull-virtiofs-20200210' into staging (2020-02-10 18:09:14 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20200213-pull-request
>
> for you to fetch changes up to ed71c09ffd6fbd01c2a487d47291ae57b08671ea:
>
>   qxl: introduce hardware revision 5 (2020-02-13 08:31:40 +0100)
>
> ----------------------------------------------------------------
> qxl: introduce hardware revision 5
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (1):
>   qxl: introduce hardware revision 5


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

