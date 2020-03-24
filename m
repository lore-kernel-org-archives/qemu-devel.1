Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD0BC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63F72080C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zUI3bXWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63F72080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGiAL-0008O8-S8
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 07:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGi9V-0007SS-1N
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGi9U-0006Jj-0l
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:55:24 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45692)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGi9T-0006J8-Kk
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:55:23 -0400
Received: by mail-ot1-x343.google.com with SMTP id c9so6533779otl.12
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 04:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NnFmSCiK7mbHVXfJboSyygYmU9laKNLNvG+KFqbLpXE=;
 b=zUI3bXWuJm5C2ewI85/rU1Jz94P/Q5ctsumVlr4h8mi3GIAV/WlD/kGA4QHl4HKG6Q
 lqbPYjlaOvCOxt2RYtk9jPViKm6iORAyqf/Nyf4wMQFV4ISddnUFxmZgH91zH/VePm5i
 Y05jq0TyBuI6kEPf2GK1bqVo6kKCHhheyR3OJTDLu7EmJT9hIcu1Cx2vtXoe18aF5RYW
 jLRWZEzzKTPxjB8+sEDf+aJkg6h/2n7/4Iap6R+8s+WPH9N77MOD2Kh3VIhjVpWq7+qF
 b622xkNLmXFpuJVb8rX/kQNjCYvbvzRe4LHC+pU92AwEWs53D7HRXPc3CKjHD/v9mKqy
 mmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NnFmSCiK7mbHVXfJboSyygYmU9laKNLNvG+KFqbLpXE=;
 b=tgtodvjmUOhlUXdyxRQqZ6WTNZekruiznHumhXRQ+idb3bwiYkLkpNO0bfGipOg8Tu
 WjSJ1WNTiDP72+BD6tzqOxN+NOn+ptArqMUVm1Gy2L1vN1RfvEMa4KM1rguZtSfsqmeU
 fawgPknf7wMilchbdYeF7bhi2XzDJD4jXEeouoNFSGivQThfkqAiGtMww+FIjkwwGXNC
 nqsnsCaxnL+ew+wj9LPXKEYkDeogf70SqmLaQ9Euxe6ULcs570td0iKQN+c8/LwMetP9
 RKVGP/xGv/X9aQFpuRI7JqmMYQSb1kLdWgHfLVdI4/g0XYhUTmCTnfmoJB0h3hZfSLHh
 Uh+g==
X-Gm-Message-State: ANhLgQ3DgdzCmIFDfjBG/ryxtkX6rHzeNO0J3bdkRvQBC6xxm8OEhSrW
 Ec3qJDqgBPnSWfs++wshYuj5iwyHMdebOFGumxdcjw==
X-Google-Smtp-Source: ADFU+vurOFQtMSE5S3yF3ZTiqP6N7VJcliI03ZQySy8czmueoQkE5PqfLIzc2hLJcjUDMKHfMFWB+iib7dY7oc2Sh+Q=
X-Received: by 2002:a9d:1d43:: with SMTP id m61mr21737115otm.91.1585050922098; 
 Tue, 24 Mar 2020 04:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200324105356.7998-1-yuval.shaia.ml@gmail.com>
 <CAFEAcA_D3ykX2mJwtJhvdQg3psCX9NdcG0xq4qmP3CkqHtnY8Q@mail.gmail.com>
 <72691a5a-8992-ec54-f2de-6209cafcc426@gmail.com>
 <CAMPkWoNqKpn22Y70vZizFqd3BQjVJaSwjE25KwHOcMJaZsY17w@mail.gmail.com>
In-Reply-To: <CAMPkWoNqKpn22Y70vZizFqd3BQjVJaSwjE25KwHOcMJaZsY17w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2020 11:55:11 +0000
Message-ID: <CAFEAcA9=AGgYAxjixjau8KDet-of4=Vg9a_2k-hV54h=1gbrSA@mail.gmail.com>
Subject: Re: [PATCH] hw/rdma: Lock before destroy
To: Yuval Shaia <yuval.shaia.ml@gmail.com>
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

On Tue, 24 Mar 2020 at 11:25, Yuval Shaia <yuval.shaia.ml@gmail.com> wrote:
> As i already said, current code makes sure it will not happen
> however it better that API will ensure this and will not trust callers.

I agree with the principle, but I think that here there is no
way to do it -- if you are literally destroying an object
then it is invalid to use it after destruction and there
is no way to have a lock that protects against that kind
of bug, unless the lock is at a higher level (ie the
thing that owns the destroyed-object has a lock and
doesn't allow access to it outside the lock or without
a check for has-been-destroyed). Just throwing an extra
mutex-lock into the destroy function doesn't add any
protection.

thanks
-- PMM

