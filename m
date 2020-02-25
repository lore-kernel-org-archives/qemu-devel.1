Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E248C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:20:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D25FE21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sjcaXbnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25FE21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6a87-0000t8-0J
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6Zeg-0001cT-7W
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:49:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6Zef-0008GW-52
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:49:42 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:35592)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6Zee-0008G9-VX
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:49:41 -0500
Received: by mail-ot1-x32d.google.com with SMTP id r16so11956233otd.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=rjPOeRl1emyKs41SGwLjjIKK7KyH3mTlKBHEYHXSHxA=;
 b=sjcaXbnwkE+YBrve2dSr2nNTMouaShANY8RFJQzpxo1323iNqNz1Ka9PIFle68Xmg7
 3kEulzjokgEDrtD8DjqoY/a7F22BMkIRId+vxNIKTscKgYe/ldcQeidbiF/ID9V3m04R
 41TaQ01Ptlg1cv7pUJP1Fo5RBK4/tfc5bx95Ast8SPNfW7iVplmhMehnmko2ScXCbt0M
 g9Hr3o9bJePc9yHXUMJp7a7x+Xgz0Q+97uetEUES4Apq9mkB0iW8rPaeBso7hfqPg/eK
 Rpv8epq0ncNNTeR+OtT2T3y3Dfb+b8A2GRSHqZgoH2/OsZuk1csxASN01zvMAhULSTbn
 937Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=rjPOeRl1emyKs41SGwLjjIKK7KyH3mTlKBHEYHXSHxA=;
 b=fYykTYIrbE4kBP8LlmMmkIfkV2ZuutgK8IvzyUgsAcCbsODPuu810bpq9STRl9fksz
 Sd7qbZpTt5pZLT0ppyYTsePRhdi1RRM31g8U0HLCzK7mZ14r57vtp2HlhG6Fje2wuHh+
 Su/aX8pYGNFBA/BfIFYztPygrJHdAo9V6Q8Qx43YIuYgiWfgrgSIrYYCle6AS1mRbaRM
 GHJBFKuz0d/S6nqtSP22HFqk3l3tGuRyVWJIupLWACg/Tx1NSJwS/cLdBhAlt3PbMZUn
 smNMLmJsPzHV8OSIRQ4J75/h1OP40QVdihk9TCLB9M0mcBqUEd4jy0ENMp1G/4DiszMW
 EerA==
X-Gm-Message-State: APjAAAUjryFbNVdx7EITeMyXkdGCNPDGEWDK7yAYOxh0Vaj0Snwb/E2L
 /aviUxpLzft+zvguVDK4ZKl0XQeAQQiVhweV02jvidBH
X-Google-Smtp-Source: APXvYqzu1EixPihYDjzifDu9BS01t8NqpmGTmJiPjD/QlQXdzNLKf4/TkwRZzjRTOJH5qJGSgUKumIj/kZOTevXLvbo=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr41555313otq.97.1582634979994; 
 Tue, 25 Feb 2020 04:49:39 -0800 (PST)
MIME-Version: 1.0
References: <20200225110204.30662-1-peter.maydell@linaro.org>
In-Reply-To: <20200225110204.30662-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 12:49:28 +0000
Message-ID: <CAFEAcA_G2YFuDRn7zyvg_o_yqeDcyXVmBPyXCMBLz9FduwmwPQ@mail.gmail.com>
Subject: Re: [PULL 0/3] docs queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 at 11:02, Peter Maydell <peter.maydell@linaro.org> wrote:
>
>
> Just the "create the tools manual" patches; I'd like to
> get this into master because it'll be a dependency for
> some other stuff (even if only textually due to Makefile
> changes).
>
> thanks
> -- PMM


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

