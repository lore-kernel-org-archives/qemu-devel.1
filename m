Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A58C761A8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6629F22BEF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uo8C1+9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6629F22BEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqzhj-0006er-Kb
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 08:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52592)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqzhW-00064R-5I
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqzhV-00034c-4x
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:51:58 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46511)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqzhV-00031F-00
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:51:57 -0400
Received: by mail-ot1-x344.google.com with SMTP id z23so26870971ote.13
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 05:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=opLFJ+1TbCMyyPmSoY1408feYeWXrJF0otWrLK+ndXg=;
 b=Uo8C1+9d1TGqShpLeTBAnvQsx1QbL8jDVXS5SIIe07U6B9OExD3I0ELzDJYTygWtDU
 DEgbNHasZ/iywwEYByk37czX0cByK3UCYa3Md9X8T5hV0qmhpiIa2vneYvxeOs0Pobud
 YmnEamIbOs9ToY0sAmCWS9WqMdvNCip4GAxGZ+S1OHrVp6tLxLhbduS8kj2OI3u3sCT/
 eyHB/rMwk42qd6mJKN8o8brrfYReMD8q5TTfjOuOyD+gCstuuHdyjyAAtGkcCv4lM9Mj
 4J1Jc/ddS3euXTFUIGpfMPbCVc/26un/KOfZfbGHqbL8Dd3MI3x7pGUP3HqT3TxOBpJS
 C9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=opLFJ+1TbCMyyPmSoY1408feYeWXrJF0otWrLK+ndXg=;
 b=UAmNA5sD4tWtuhzwSTBwJonnMWLaL1RSS/IIV0c7u9ql4FxG6JVvVsZp/iHiggIjCu
 WsjPBo5q4+F5Dj0p6eVjP89zFbgsB71OivlXSNliF90Nu/2k0uZTtFA1PFOOJuBWqu66
 ALygAXwRf53PfJXZaV0O7jaThYobgD9BOkIm+ZAlTgIrp3WOTyN6VlFlxl5IxG4BzYkI
 kF91v717P2tpBanHOmvwNyyvYgegCcYrTX9976QNfz4AbKV8qhi/ZbU/ZZu9W/eVjva4
 wrjaJIlvnJpIbi4xICYAI5SFU8UyaX6+9uuaqWrd2UWJT98nxSJYYki04Ke+Dd0iOG1f
 xqwA==
X-Gm-Message-State: APjAAAU1sMik/wAGbtDonNvhKnNAXopbt8+IUaxZt+lJQTW3yaZEwv7b
 nDj6QC15UxDNKrSWtHlhGOe4zj9v61phI6Jzgr+A+w==
X-Google-Smtp-Source: APXvYqzzZnbQ79GDdP+IoVc6uQsgDjlVIMMwriLauGsZoEXX6rsaosJYK34K8cNcOvBv0YRmu57w53zBX0ctV4g5cfw=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr14582314otr.232.1564145516169; 
 Fri, 26 Jul 2019 05:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190725154806.1193357-1-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20190725154806.1193357-1-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jul 2019 13:51:45 +0100
Message-ID: <CAFEAcA8biNeToeUxWmzOdDoduugTS7yMQXRwVBLG3Q4qzo8wbw@mail.gmail.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL v1 0/2] Merge tpm 2019/07/25 v1
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

On Thu, 25 Jul 2019 at 16:48, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>
> This series of patches improves error handling with the TPM backend.
>
>    Stefan
>
> The following changes since commit 9d2e1fcd14c2bae5be1992214a03c0ddff714c80:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2019-07-22 13:20:49 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2019-07-25-1
>
> for you to fetch changes up to 7e095e84ba0b7c0a1ac45bc6824dace2fd352e56:
>
>   tpm_emulator: Translate TPM error codes to strings (2019-07-25 11:37:10 -0400)
>
> ----------------------------------------------------------------
> Stefan Berger (2):
>       tpm: Exit in reset when backend indicates failure
>       tpm_emulator: Translate TPM error codes to strings
>
>  hw/tpm/tpm_crb.c      |  4 +++-
>  hw/tpm/tpm_emulator.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++----------
>  hw/tpm/tpm_int.h      | 13 +++++++++++++
>  hw/tpm/tpm_tis.c      |  4 +++-
>  4 files changed, 69 insertions(+), 12 deletions(-)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

