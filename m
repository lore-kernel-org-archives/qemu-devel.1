Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB3DC06510
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:39:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EA7F2086A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQ3l11xC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA7F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60914 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hajnd-0005a7-CZ
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 12:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36973)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haj33-0004rx-Or
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haj2u-0001I3-2M
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:50:52 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:38393)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haj2t-0001GY-LB
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:50:47 -0400
Received: by mail-oi1-x232.google.com with SMTP id v186so9323599oie.5
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 08:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RaLj/zpp5phPfmHdEBF3TWQov7i352Xv6cujubNO7Vg=;
 b=MQ3l11xChVej/X0B2fYnMxczF5P83Z3sGZH43YnyANlJeJyMjI9O82CaHFydEZik2E
 4BkfQLRUSwHfnSNAMc2+5bxtBQROjBMDJS2/s/GmdHPh5y9OGIM53kfpYHnR2d+DiYgC
 6Xmkvk+oDYK+j2RIxjScNHboO4ZPTtwW71GKUCy8gK+4bjXneOep/yIPOl3+1sQjTt2P
 o3gui5kmfZijtu2HCYN+sraVFnUCaAmeVfpa+Xpj6jJO8gNcHzy4zrbthNOlpHIPPcSD
 ir3B/AU9wheMegskFfy7GvhF8O7CEKRnikLkb8qVcBiR5Ti4IDS22IYNSBF2Y6HR3wc0
 2csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RaLj/zpp5phPfmHdEBF3TWQov7i352Xv6cujubNO7Vg=;
 b=AAtInrgkQ4wRtu5jEYIKc+Tg0USsQi6G2zL6gWjoigmIOjkhyzuPdzpg1BXV3CAWZI
 P1QhSIfzCq9NOf4d8gT5KljNMIuuVkcyMkbAVeM6NBwAXAyN6JXoUehIZKNAoFMAv4xP
 avH+ygalkZ8YVgKbzHmeltlKn6NTCxIOeU41VS8F8aqc+qN3W3ndSq4s8OsoIkeBhRB8
 d5zDm/b4sZ9p+GrhzNYSYWQuRLqa7gKQYtaFTd15G1JSnS/efqlXP4XbB+3Y38voYxpF
 OiKRDE4DiCPesWryTfmDYJ1QVz+moAqpORlY0PLAF7/BqQEVgUH2+1X4OugVLTlLECa7
 Q3KA==
X-Gm-Message-State: APjAAAVrq2KB8kSMateDW4NAWrvUesclNeIVKLffvaKDOWAN6z1DJ/2A
 F69peKKCGhp3ol6uniYrzp6ypspcsNrSkQeOn09iHA==
X-Google-Smtp-Source: APXvYqxvEk5+OlERuitcGNSrnv6eVJmaJ0+CURQ9ncx/QgPc+MvidSw9tzC+mQkGwuNs2YZ0nTPzCAXeAz4qxW0QQlA=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr15304171oie.48.1560268246026; 
 Tue, 11 Jun 2019 08:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190607211544.7964-1-ehabkost@redhat.com>
 <CAFEAcA-wCqppsi+gcrTqGjR3bSDOHs5btKKE8oHYxbAUDtu7Fw@mail.gmail.com>
In-Reply-To: <CAFEAcA-wCqppsi+gcrTqGjR3bSDOHs5btKKE8oHYxbAUDtu7Fw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jun 2019 16:50:34 +0100
Message-ID: <CAFEAcA9ZeB1knLYYQLJG0d5McG2vo6w8P9+vOBWgtSVgPEG0jA@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
Subject: Re: [Qemu-devel] [PULL 0/8] Python queue, 2019-06-07
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Jun 2019 at 13:58, Peter Maydell <peter.maydell@linaro.org> wrote:
> Hi. This fails to build on one of my buildtest machines:
>
> ERROR: Cannot use 'python3', Python 2 >= 2.7 or Python 3 >= 3.5 is required.
>        Use --python=/path/to/python to specify a supported Python.
>
> The machine has python 2.7.6 and 3.4.3. (It's an Ubuntu trusty
> box; it's one of the gcc compile farm machines so upgrades to its
> OS are not really under my control.)

Rereading this, I realise that either the check or the error
message is wrong here. The machine has 2.7.6, which satisfies
"python 2 >= 2.7", so we should be OK to build. The bug
seems to be that we say "prefer python3 over plain python
on python2" early, but don't revisit that decision if the
python3 we found isn't actually good enough for us.

(I am also setting up to do builds on a different aarch64 box
which has a newer python3.)

thanks
-- PMM

