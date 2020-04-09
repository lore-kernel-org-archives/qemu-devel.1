Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9AEC2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 13:52:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E292078E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 13:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uWEGMOYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E292078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMXbc-0002UM-IX
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 09:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jMXaj-0001jQ-BD
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jMXai-00043A-7m
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:51:37 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:33792)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jMXag-000426-CP
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:51:36 -0400
Received: by mail-oi1-x232.google.com with SMTP id d3so3305998oic.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 06:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FV38sAjwEg9IzlxCXh/3X3jumI11v0IrNoGKwE1qIMQ=;
 b=uWEGMOYnz14Bb47t+B0qubYpgr0eEbP35aXwc5Us+t+/IT7uaSK4v2Ncwlvo9ktSM/
 6yttOPId3P3dzyy7lQOaZXiatjLrkOUV1iJl+SUhRvU05VCouWBgWGVfKckZosTmmTyw
 tQngaajH34yuhuisBlAKRdzDyWe1MwsKIQJz+WXdJXJjlBHIJ7GA+70J7zrXUY6rhipm
 /syZW/iNEndFIYPJbexbK7MLRO6WlusxQZmu5uYVUJK46TQjREeP55EfY7tYGE5YxJz6
 /m+CkzBRUKsW9B293FRPgho4VNuVUg2txhVeU/sLUkSxyDVjR/Uyr6mZsDFyLvn/6QZa
 K9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FV38sAjwEg9IzlxCXh/3X3jumI11v0IrNoGKwE1qIMQ=;
 b=JzybmGWJ0XAHHai7Z6XrxvKao7VddzAgPLnuxtivdV48CCJ7GcwDpA2nIKkgdwgUF5
 Pfu3z489NEHHtMRzv2k3/Ln0maWMJO8bmNCxkkoSZnqIthCYAGik/ELqqK8V5gCzEMdy
 /z82fSJ+JxxHHZsGMFvcrLDpqYvAiMhuwmRgchspUn5cxPKio1C6ic6GMd9wYGlf4Jst
 FxZaNa/ID1Wcsr6uyPWPhabtl81wmMOsuVOdDad+Bz+V6+L4GKHgNCN9IaE8Q2IwekT7
 x20NUndn/kyp1OuwMz+BlCPtHDKoyjLepDQmB1civ3xiptrXO4TOZfPZPiOPG4F4mOc4
 9aYw==
X-Gm-Message-State: AGi0PuZN/lseKApL/UQyIH/9Y7bzsveBTsyBZuNCF/td7qtz6Oo4pRUM
 5+QIXLZ0mM+b4JhR9XjrfjSioHIHx07/TP+RxdwTPg==
X-Google-Smtp-Source: APiQypKCsmT62uzWoAAOqbuTRwif4EKrsV8JIR07iIAV50kD/3MM/7T6joB3l4VjoAtRSFAjtYZDfEERZ9Fqlt7zakA=
X-Received: by 2002:aca:c608:: with SMTP id w8mr6405209oif.163.1586440292731; 
 Thu, 09 Apr 2020 06:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200408153057.31794-1-richard.henderson@linaro.org>
In-Reply-To: <20200408153057.31794-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Apr 2020 14:51:21 +0100
Message-ID: <CAFEAcA-cq+kmuD8rXy3bFv9WLoodU8Mp2s1RS5aJgbHWOhwnPQ@mail.gmail.com>
Subject: Re: [PULL for-5.0 0/1] target/rx update for coverity warning
To: Richard Henderson <richard.henderson@linaro.org>
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

On Wed, 8 Apr 2020 at 16:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit f3bac27cc1e303e1860cc55b9b6889ba39dee587:
>
>   Update version for v5.0.0-rc2 release (2020-04-07 23:13:37 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-rx-20200408
>
> for you to fetch changes up to 40bd0502dbee3ca1a9a481dd32dabe9230b8a37f:
>
>   target/rx/translate: Add missing fall through comment (2020-04-07 18:45:54 -0700)
>
> ----------------------------------------------------------------
> Add fall through comment for Coverity.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

