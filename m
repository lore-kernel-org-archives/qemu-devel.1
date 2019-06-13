Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A739C31E49
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE9F20449
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LRQMTOYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE9F20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41538 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbSfW-0005Kk-1D
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 12:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54155)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbRSd-0000md-Hw
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbRSb-0000qP-Vk
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:16:19 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:41197)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbRSb-0000pS-Nq
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:16:17 -0400
Received: by mail-ot1-x32f.google.com with SMTP id 107so19316616otj.8
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 08:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=TBeGGh9PGFD6r2q7Bpd+u+m0as0EBBPfOH7zXEMuwF8=;
 b=LRQMTOYudGuRtXgCACNa7ipd3+C/dJU9HerJwCQFVblCJoJ5HNkRaEbtJ9eAj/76Ly
 OL/XYkUZMGRupeKe7wqx9AglvykiH7y4etyCDg16CY0Iqt4DonHwkATfObD3czlSIpTZ
 ggbJYf4jUK7TSMCXxaSPhaqysnZ5pKeHp2Z7IDoybrijXksxpA9t0DdibOjLZvx1RpTe
 LvtRQiYgZRsM98LZya2B5tLBQFyYeBQBoBEk1NpUDcI8QPpJgfug3oHUBzWyCsl1l9zX
 Z0NUD/3cA2tDxHn8RxE+P2nrfYTQ6I0KGowO1zg9We8SicnEsAKg2rZetE/yAJbuVWKM
 KcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=TBeGGh9PGFD6r2q7Bpd+u+m0as0EBBPfOH7zXEMuwF8=;
 b=k2OHCj1I+6tyTSkUmzvlAkRSBgrvfbDLBwQJeEcyxsgBQa5n3hqHwMGQ/khExbyi4v
 X79sC5PhyqMdxF1MQ+mS5vCGiHMjxajhCGv3M/XI/hMnMPecB80BVfthI6VgHawb4G7k
 6TeWM1PjmQpsl9CbUmzoh4OyY1N9LkTH2FUMfCNTDktfTTDU91H+pXTi0pJjfgRc1VDj
 XGmLNejKlW24+83iJlUl9GuwrYQR0ML4mAAOHR9QhkG5j1f73dM+7USODjZ1y3SXB2ml
 Lt19ZNR69LAFyzLeRhrdqO347gXetIUJvRZx/Zf+/+CXE2T6ZYadSEKdHFnVLc6mjxBp
 V/hg==
X-Gm-Message-State: APjAAAWDJu66GKvcln86e+4+LFpX1pjTgsOmWpGrFIwNxnMAM1OvRTWm
 Y5rvjbTOKxBA24uja/88cCo351pcOqOcqbOJEskfGC7wqsw=
X-Google-Smtp-Source: APXvYqxnf104vRh2cfJxIFlxdTCs5E9oaLCtBXHZxl9t8sLqZA7qFhOt6iFTKhmfAzFUd/t/PEtS3aDsQvGrx/l5zDY=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr4929587otk.232.1560438976132; 
 Thu, 13 Jun 2019 08:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190613141614.20157-1-peter.maydell@linaro.org>
In-Reply-To: <20190613141614.20157-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jun 2019 16:16:04 +0100
Message-ID: <CAFEAcA_DkfgiFiKt20oOUm+5VML8_P99LFcZMwf4S4wSuNE7kA@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
Subject: Re: [Qemu-devel] [PULL v2 00/47] target-arm queue
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

On Thu, 13 Jun 2019 at 15:16, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> v2: dropped USHL/SSHL patch
>
> The following changes since commit 785a602eae7ad97076b9794ebaba072ad4a9f74f:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20190613-pull-request' into staging (2019-06-13 13:25:25 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190613-1
>
> for you to fetch changes up to 18cf951af9a27ae573a6fa17f9d0c103f7b7679b:
>
>   target/arm: Fix short-vector increment behaviour (2019-06-13 15:14:06 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * convert aarch32 VFP decoder to decodetree
>    (includes tightening up decode in a few places)
>  * fix minor bugs in VFP short-vector handling
>  * hw/core/bus.c: Only the main system bus can have no parent
>  * smmuv3: Fix decoding of ID register range
>  * Implement NSACR gating of floating point
>  * Use tcg_gen_gvec_bitsel
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

