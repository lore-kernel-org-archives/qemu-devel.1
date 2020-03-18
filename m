Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7604C10F29
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 19:46:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87EE820754
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 19:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dYqQ7A3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87EE820754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEeeV-00046P-OB
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 15:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40935)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jEedr-0003ei-AR
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 15:46:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jEedq-0008MC-22
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 15:46:15 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:34125)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jEedp-0008EH-Rs
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 15:46:14 -0400
Received: by mail-pf1-x42b.google.com with SMTP id 23so47838pfj.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 12:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=V0Au2y5AEyU3MMTTw2wCG3UqSHE5ZfdiztJ+09+ypts=;
 b=dYqQ7A3vJ4Ia5txrC3DYRCsatLTmcSqYZcBXLOyfnAbZrRfdV3fbF8lH9VI80rEyRv
 2NpnEFBYe7fCtoTSsoyRXNCzKn5XK32rUoqaq41nXVGnlSF89XpMv9d9arOt2QXRSsLy
 UX78tPBXkbrAGbj8QFFfF5czbC8IFp9LlXMoznkrbPapuKMJxYJy0FAQ2m5NxOfpTHs6
 /eNh2f/3vaTIWF+UpfmN/+nDezaR437+pvMCm3Z1M2ALeM4Wp8YueLIYt2m5gLPJHtD4
 ODgCVlLigbOqYwPVIoqmztHqX0Vi4ZoProS+176qtq8STWxikU+2gQQUbg52VR2g//oz
 xLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V0Au2y5AEyU3MMTTw2wCG3UqSHE5ZfdiztJ+09+ypts=;
 b=tFEqtx0WCuYsFa3WLA1xeVTtmY3ECq/96N55vrp3almwVF6dC++DgvYCeUjn028phY
 LckUOS9OOOnxmU9W345CDPEUUFKr8cuGVcoNdGsojVCPb1A1mCUwWC+npv4Ff6GlBIh3
 uIPok9YNelvvpaN4LZQgAYA2xUaLIUsCSIxXdB2bBzS+zhDwQ057vGlXp07c68uTI1kh
 P8w0rVoOr9rDPhceVwDjoSWpRyEwXJFwwrwZDcQV9n6S3c8SWX+tEdo86Bofb62gRXp3
 TXJv+Tl7MaPdTbU7M3ylSKwaQXgLMJ2XDES1Okr2Ou8ZiWv518qJTqiMBgkTvv7jltJx
 5zNQ==
X-Gm-Message-State: ANhLgQ3Y+0yv0vfjQcHnIIERjsXh4r3PIHJjU73xrfu49rbx1WqOq9W3
 FiQcwEYfeShu8MKLkhA7V7WSwYIh6WA=
X-Google-Smtp-Source: ADFU+vvXJ7w/FskB6ga6crKrT9Pils1maUaaoAiY8vGXuyJ657Mj68kqSf8FqPVjtwjPPwFCwV/gaw==
X-Received: by 2002:a63:195a:: with SMTP id 26mr5816536pgz.400.1584560771717; 
 Wed, 18 Mar 2020 12:46:11 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 k6sm3193398pje.8.2020.03.18.12.46.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 12:46:10 -0700 (PDT)
Subject: Re: [PULL v2 00/37] Linux user for 5.0 patches
To: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <20200317155116.1227513-1-laurent@vivier.eu>
 <CAFEAcA9Pd6D6xaqN7XfOwRANxm=4uOYmdaBoeQiX4_Z-bXEi9g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <610f250b-64b8-1cf4-00fe-5bf2f2eba864@linaro.org>
Date: Wed, 18 Mar 2020 12:46:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Pd6D6xaqN7XfOwRANxm=4uOYmdaBoeQiX4_Z-bXEi9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42b
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/18/20 6:57 AM, Peter Maydell wrote:
> My set of "run ls for various architectures" linux-user tests
> https://people.linaro.org/~peter.maydell/linux-user-test-pmm-20200114.tgz
> fails with this pullreq:
> 
> e104462:bionic:linux-user-test-0.3$
> /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/x86_64-linux-user/qemu-x86_64
> -L ./gnemul/qemu-x86_64 x86_64/ls -l dummyfile
> qemu: 0x40008117e9: unhandled CPU exception 0x101 - aborting


I replicated this on aarch64 host, with an existing build tree and merging in
the pull request.  It does not occur when building the same merged tree from
scratch.

I have no idea what the reason for this is.  Laurent suggested a file in the
build tree that is shadowed by one in the source tree, but to me that makes no
sense for this case:

It's target/i386/cpu.h that defines EXCP_SYSCALL (renumbered in this series
from 0x100 to 0x101), which is not in the build tree.  It is
linux-user/i386/cpu_loop.c that consumes EXCP_SYSCALL, and it is also not in
the build tree.

However, from the error message above, it's clear that cpu_loop.o has not been
rebuilt properly.


r~

