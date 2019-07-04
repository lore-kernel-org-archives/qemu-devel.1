Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E174C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 13:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD8652189E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 13:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NTB9ijog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8652189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj21A-000791-St
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 09:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52141)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hj20h-0006hb-HS
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:42:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hj20g-0004Tw-Hi
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:42:51 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:34361)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hj20g-0004SG-AW
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:42:50 -0400
Received: by mail-ot1-x333.google.com with SMTP id n5so6036286otk.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 06:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z/cIzpwxteA4/CK4kElxmJs/wubV2e8rga+DEaRDRoQ=;
 b=NTB9ijogpmXX9M+RPtPkhV2JD+AUrl6pvnd/Uvhi1n0Jcx4e3NL1xIgUsB/nQmnZ3P
 9N+Wm2KLG8MSKvI7mGNVL5RaO/7Zft3bjjN/FHDvJXRc9qPg/HZsq4EuCMOwzwN8eJD5
 tIHi4FgxtczsJf+rCeP3cWJPxBihVZbMPf0K9U51g8+pPIWnxnpsU20W9WPpKPA+QgJl
 7hndEwbOKnNWLDFiNSSCzEZqpcJ8G/UzWQ6Cniu1oQXhEZNP3Qn4PB3enYP+Mr2iAqru
 6LzlrcRcq/Yob2x9vT6qPfTEB0i02htcQGlS5GHaktD9GGPBmyhh0x3QM7IZTyPMf+A4
 nZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z/cIzpwxteA4/CK4kElxmJs/wubV2e8rga+DEaRDRoQ=;
 b=huJr8L3RurcwzPgQMEpHEtMu7rRe7C8cFCSwUQ63q8b3Zbys66ZflMTio7f9mowM1t
 hX0fHwbcnVXjjyQeOdudhn4zzfUWZuR8J5fqxGANjd2IGTAQmLNHVjElaNxqHVAwqSYA
 9U6pry/i68oZwjpEy9JZOzig6RptLhgqWxdfCMp1VW/rHV0IaE9/nOCfX+3/GSlagM5j
 EciuAwFz8wUlWEZXud2SnDtM1PvrlsFKgbSUPJHPHw6Kqxt9b2Yh+zlqj9ip9QUejsCW
 zfmAKX+CzF+ZGpnJhmDOWJgNd5pMG20txTIn8eRLLDbttqnMHPL/z+1XLAQteMXLh190
 dZSQ==
X-Gm-Message-State: APjAAAXGLbwv3K1TcPtjFR30umvIceScrVxb+V1SI32slpOfzNX58g9Y
 2KnsZiXxhTQwKK96yt0AB/QgyBoX4j5Uhbz4QP4u7Q==
X-Google-Smtp-Source: APXvYqyKsliT7hZ1/PHKjV50/kHM+JERrntKJz+b/Q4zfXavd0X1WYbtGXfXyxYW4TDqZXX+pUZMoKxfB8uKP01ZPAA=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr12685836otk.232.1562247769163; 
 Thu, 04 Jul 2019 06:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190703065600.13535-1-kraxel@redhat.com>
In-Reply-To: <20190703065600.13535-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2019 14:42:38 +0100
Message-ID: <CAFEAcA8D3yAPop79=-cr=Rqrc1MVOgPUiFerhQOhP4tPFP2+qQ@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
Subject: Re: [Qemu-devel] [PULL 0/1] Audio 20190703 patches
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

On Wed, 3 Jul 2019 at 07:57, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-2019' into staging (2019-06-21 15:40:50 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/audio-20190703-pull-request
>
> for you to fetch changes up to 58c15e523af3e70149248e8a2a9dab0fefb4ce91:
>
>   fix microphone lag with PA (2019-07-03 08:50:56 +0200)
>
> ----------------------------------------------------------------
> audio: pulse bugfix
>
> ----------------------------------------------------------------
>
> Martin Schrodt (1):
>   fix microphone lag with PA
>
>  audio/paaudio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

