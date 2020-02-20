Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32899C11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:47:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0095C20722
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oLncusbL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0095C20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4pun-0004FW-6N
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 12:47:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4pto-0003R5-Fv
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:46:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4ptn-0006IJ-FS
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:46:08 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33073)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4ptn-0006Hi-9Z
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:46:07 -0500
Received: by mail-ot1-x343.google.com with SMTP id w6so4501776otk.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 09:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vVV+PeeDEpkV8oLv/PEzvB5hm95L//V/w2qjvlQcLPk=;
 b=oLncusbLG/yuP/8MvzbeUfZLqH8vMEJS51M1seeUaz5uzE1elYxkqNtwv2HrnjnC6M
 /h1LP0C7VOd4+3Rxr24cOpkQV+vvItx4TpSUimaFYL8W0w4KWshU7Zu04eMWIgVoDKO8
 9Op2MRP0anhiZZSAuCNapMATboKtTtMNLPq5YLYECS08kjvdSjlfz1iHmNUOS7tXR0Kh
 /AtCY4zaGxFIW/bCpcJDTUyUOS8irNiMqHgk91pfXPdGwvgWCuLAriOw/K5vzMvsujV5
 /PhKDQYV9izt016H1GdtTtGM+7GOWXOC4CJwAwjjSg7dAvChFtcNYp4qlXuKfZHO9GjF
 1IkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vVV+PeeDEpkV8oLv/PEzvB5hm95L//V/w2qjvlQcLPk=;
 b=pvnqkJ4hEIQgwDfTfqN28NWh0U9gRjbAc5m9vkhE267/G1XEhqjvtOGM8xFAL1ffcw
 tTeBA0khvjAYcErT1vTOOy0SyfgM/1iQyWrYbUvg1SCmkHewPqCn7dFAidr6kRzINbPF
 JJrOWyp9gso1CKGiS8DjR6gXY29qoxUi5E2RjbYGGKqZ7yKrSJIwsO4R1CT9mEXO1uaV
 6P9tJCU0OITRBr053T9Zqa5XLq6lnjZJ/0F0qlToO95v5Pf6zSxFmvt+lZpgcSwYiF7Q
 uKnToGXmWRKlkvbFwN82cls6WfZClayOaBLQJv44RDh84FxKl6ZfyRaYbTODuhckxSH8
 iIRw==
X-Gm-Message-State: APjAAAV9NoACpsQ/QTEm9pBCzYv81im+P+fh4LWDoSbEUwHagCr/Kkdj
 skXX2ohdg6Jhwdi+3PZydoEdx2MDDsjso7VeoatYcw==
X-Google-Smtp-Source: APXvYqy+ROBQfpXJ9aef5vB3NL1+yAzAqOMCtQ5SyVtPPhgVi5ZHUg7XBmb6LS0OCXdP8/wk9nAEXDOFYeF9KRzhBDU=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr12455814oto.135.1582220766239; 
 Thu, 20 Feb 2020 09:46:06 -0800 (PST)
MIME-Version: 1.0
References: <20200214181547.21408-1-richard.henderson@linaro.org>
 <20200214181547.21408-19-richard.henderson@linaro.org>
In-Reply-To: <20200214181547.21408-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2020 17:45:55 +0000
Message-ID: <CAFEAcA-xtVwTMJdYNTfjbkh5YsKxw0o_J08ea35dK5bVrxQ8AQ@mail.gmail.com>
Subject: Re: [PATCH 18/19] target/arm: Split VFM decode
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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

On Fri, 14 Feb 2020 at 18:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Passing the raw o1 and o2 fields from the manual is less
> instructive than it might be.  Do the full decode and let
> the trans_* functions pass in booleans to a helper.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/vfp.decode          | 17 +++++------
>  target/arm/translate-vfp.inc.c | 52 ++++++++++++++++++++++++++++++----
>  2 files changed, 55 insertions(+), 14 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

