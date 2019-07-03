Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF7CC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 12:41:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E266B2189E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 12:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kWg60cDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E266B2189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hieZK-00087V-0m
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 08:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55881)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hieXG-0006xY-0j
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 08:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hieXC-0006VN-JA
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 08:38:52 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:45476)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hieX7-0006Iu-J2
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 08:38:48 -0400
Received: by mail-oi1-x22f.google.com with SMTP id m206so1889676oib.12
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 05:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xCIHXDp89Sigrozuq2lkzWGTWjBDphDSn+k2zK4hl2o=;
 b=kWg60cDRMfxhvQQ3ECP6pOiCLHc0/DQ4zO14UOdh4l8r+0vHJATMqoaSTqkR/6yo6l
 EiS0P/Q0Co0xg4a0Ryzl4htGbHQAG1UE3z6rrJYirfv5F7Nzsxx+fHOxj5Z//5DdANaL
 T8bvsuz4C+qjGYfw3nXNI3ZZ3cc6PJXPA6UC32V09efwEGRNNA1xnM6k2OGmrD4Ccb9R
 hQLvRD+UY1DEIngPv2sYT9uP5o2H4fivnrdSMafBGsJvO2OnTLsKIp3IP+4Ye11f41VH
 JdO0ossYpZhxiCTz+GH1NvCLyQ4j33vkAthbzvxRleBI9pd3T7wlFXIe+QcRll2viJE7
 wI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xCIHXDp89Sigrozuq2lkzWGTWjBDphDSn+k2zK4hl2o=;
 b=VpSqz4mZzIGC0ohRrhhCizDuMpqXj5H88z6CaTLQO3CeYXDNKMTG0DqEuH8vDgR5pV
 0ke8NP+HnGFZQVkSE7sw89Fa9KDdifSX5BmlRh7tSbMFpCZFoH+qSfOzRyuZ0soFGqbK
 G55cR6Er9toOt8XsvOAVFkHjj7o2f+cgbvOBlsY81OH3oRiUz7EcxLD9MizCk+HAb1p+
 J1abUZCSSVwr4rUudZq5PuN4nqb9cJFpGWU/6nVvtfFQkRZxyAaDR5yMerinPVi7NRBY
 FPMTZXv7XsYiTrWKmkjab+ArrJOfaqbhwSKz9+13jh5Gh+Kfv3VgYE6MhAXIYPCKnQ0J
 Kz2g==
X-Gm-Message-State: APjAAAVyPPwNXJ/NRnkmbQE8WXP91/Pvrq07TJb4zOq24eH8rRgZvbGo
 ytDmlzcPrXM1rGl3Ib95ULJDMSvNcEEz+lzlmfiCQg==
X-Google-Smtp-Source: APXvYqwPSBwaL6WnNsPOY1V7asad6m7eHYftYykrpzloz7cL8DZRko1Pkp0/1RCy/2CvlrMiFeO1iYiPRGd3+b1+mKM=
X-Received: by 2002:aca:5cd7:: with SMTP id q206mr6055025oib.146.1562157513246; 
 Wed, 03 Jul 2019 05:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190702114343.21699-1-armbru@redhat.com>
In-Reply-To: <20190702114343.21699-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Jul 2019 13:38:21 +0100
Message-ID: <CAFEAcA870rrGwBmEzRzVr0QtoymNE+srU+KnMMzVnuFeavvp6A@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
Subject: Re: [Qemu-devel] [PULL v2 00/18] Monitor patches for 2019-07-02
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

On Tue, 2 Jul 2019 at 12:47, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 7d0e02405fc02a181319b1ab8681d2f72246b7c6:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull-request' into staging (2019-07-01 17:40:32 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2019-07-02-v2
>
> for you to fetch changes up to 2608b3df8f9cd91baee9d04e246a0255dbb612db:
>
>   dump: Move HMP command handlers to dump/ (2019-07-02 13:37:00 +0200)
>
> ----------------------------------------------------------------
> Monitor patches for 2019-07-02
>
> v2: Correct PATCH 7


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

