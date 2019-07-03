Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2326C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:31:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7F82184C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WQskWGM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7F82184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hihEj-0005mY-0j
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 11:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40232)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hih9t-0001ex-06
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hih9r-0007za-Vx
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:26:56 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:36582)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hih9r-0007zN-Qu
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:26:55 -0400
Received: by mail-ot1-x32b.google.com with SMTP id r6so2776967oti.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 08:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Wa2nr3pOM9YKTME2p6Fzl53abg1fxXpLRiMqueo6uI8=;
 b=WQskWGM6+0qAozo1azCIT9M2IsdelXHiT42wo8lHJ5L6SXr7qgTaZL3AxPR1MMYdII
 MtbqhTb1teDO3rD9S2bujgCOLZNvN68epszZXnpZYsW9XoWf7K8ZgP8odmHfVM1+4tnI
 xp/haFerp0BOI+dSo2L0q8TXNLCTp/TB6DMoRr9A+GUEY24u/VYLPWpG8kGj0zWcgwEv
 RDKUdzLj56VWpyY3R6/AVrHl9oD2H+eyc2W6SZxFgVrsoqOehf28F8WAX8USq3vStOOM
 wfXjfV1cTQBBg0MQP1phnOyfBvjV27XfZ3z97lmUCBcbZiyDa9tBEa/LKXYlgdH4WAZz
 hyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Wa2nr3pOM9YKTME2p6Fzl53abg1fxXpLRiMqueo6uI8=;
 b=hZOJ3U0DZytGdgj9sZcXAe9P/S3wRpEUP6CmaA6Mn/IsNcYbDWWbRGTKbI9BsZpfgu
 mMS5GoSfLTqzu7vumnB7F0FdFOHXg9Gc4GUyXL/9GvqpQMSDa0iTZ6kZEGBQat85oy6I
 l8/nYIoZQatldv2ikmHOrSwPGHpRkG+kxTBtEI8GhmZJNtDx+Anjm1CKIhr3x23/JTie
 VD0+xqLB5Y6amc2iMNhM9dF5DJns+w9Jw6Tozh0kXx2+JcskS2lgCTNjer8lrQt3gw4X
 BHh592NKNQNfygfken132ViLt580chELNoCGI8+bmQiEdT19LDrUjl9F28rk2/c5qOG1
 T1JA==
X-Gm-Message-State: APjAAAVKuAtJNbR2tW32vuC5H71zrCjEPQtYEZvd6EzuQUUIv8MfFOJt
 sU5AMEK3dwKX7qmWmGCqKMPe6kbx5XPdqIet1CpeVQ==
X-Google-Smtp-Source: APXvYqwmPugBG1HtIX84qwVCR7XgbML7sbDxo2sSjRnkwTm2yUdF9shsc3/B5ti+HrRGwt/HHNyg/lz6+0vhqAV0CF8=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr28002523otj.97.1562167614519; 
 Wed, 03 Jul 2019 08:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190702123713.14396-1-laurent@vivier.eu>
 <CAFEAcA_Zu0X1zLfKtBkQdi25KCkjf_PNu8zKWE5Dx7uzzLEzBA@mail.gmail.com>
 <5d7fa8ef-c56c-1f90-d5d6-b230d1e3f363@vivier.eu>
In-Reply-To: <5d7fa8ef-c56c-1f90-d5d6-b230d1e3f363@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Jul 2019 16:26:43 +0100
Message-ID: <CAFEAcA_5y6HcTXWeyGHuLx_=ROiMBttQw7enW3HGgxuWPYb_kQ@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
Subject: Re: [Qemu-devel] [PULL 0/3] Trivial branch patches
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>, Justin Hibbits <chmeeedalf@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jul 2019 at 16:22, Laurent Vivier <laurent@vivier.eu> wrote:
> Is there a HOWTO explaining how to build QEMU on MacOS X?

https://wiki.qemu.org/Hosts/Mac though I think it's a little out of
date now. The short answer is "osx 10.12 or better, use homebrew
to install QEMU's dependencies, then just configure and make
the same as for a Linux host".

thanks
-- PMM

