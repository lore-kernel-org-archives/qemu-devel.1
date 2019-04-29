Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A224C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3CB20673
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kazCPl8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3CB20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58268 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL77S-0002Dm-2z
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 10:18:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL75n-0001Dy-1v
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL75m-0005ph-6M
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:17:14 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL75m-0005p9-1S
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:17:14 -0400
Received: by mail-oi1-x241.google.com with SMTP id t81so8381899oig.10
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=bwtZb9C+gpll0EadX/mGMyD7mpXtLc+gIzGxvC+YZ7g=;
	b=kazCPl8m7TjKezeFZsdpdS9nk/dBiyI90quoV2bSISJkCdcAjqNB85jGSSk26We59p
	/ZiH5KAW8WqhrfACLbI8O/6dVkypRRI+9SDCEMioNFOxps5CYyhDP0U3iT3ys6V8xxm1
	O96hzoNmr1PJONmAPH6iJ0a+ahHDGaFZ7mSFv9w+olGVvJtaRZoFBQK8iwcTE7Kwdzx6
	pz1lBsLJQQQnZ3jEWd4D2g1w6zyhqrmhgW5lu3THSyx3c8koIokpuGUgGy9yT921jqXi
	EGHIKHE/iFPMe1PStOScPenHhhKp+nJoiUJ2eNdMUEnfqZ01+7PJ6iYNwMwtvXTgvbyB
	Xq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=bwtZb9C+gpll0EadX/mGMyD7mpXtLc+gIzGxvC+YZ7g=;
	b=jryELdQOzj2Zx3Op3Rw2aY3OC7RhyVoCI/m0PNR90vd7T2iytjVsfVx5Dw9+0en7cs
	sTfAOC/sz/6hxPHwL50jGALXwXZ79I3x0bqJVQlAwkMgAxWxaMbFcyFjJ1CYTVZs8cb5
	HEhY8TqnRrOpXTdLKMbNeKIHbmblxhuKqE9F76AXeG9sQs9CSH4en9IcJXIh43+kCYN5
	RMtDYjfc7XGUOjVb2CFsMTRHxYuk5QB5Nmz5LkhDTzTaTugvcW5MmR0hmouYhMbbeYFQ
	KaO3FLJn39fyPHYWeWAEwBCvaKls+FdE25FcxjnskPPjCNEwIPS2jUPZKHRTMQqXda8w
	X15g==
X-Gm-Message-State: APjAAAXqGGK4DN9edaGneHH/D0bivAZYkaBpnxdIdmhJTBn6BrIk8pU4
	F52lLbklaCOMR+frUDVDuvidrMs0jx9Bm+1qcwF5Jw==
X-Google-Smtp-Source: APXvYqxHIZP7ig1NjIEOL6kmhV0djwxolboK9VAEDfoiQV0yhndR+2HdYImMeYIJ2fku1fHOtOke8qsCdxmgVDiXsQI=
X-Received: by 2002:aca:b3c2:: with SMTP id c185mr16912983oif.98.1556547433283;
	Mon, 29 Apr 2019 07:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-19-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:17:02 +0100
Message-ID:
 <CAFEAcA9owxsLXDf4KcZjCCKM12Ju0h1kHQvi5Whw3Qx1XBeQDA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 18/36] target/nios2: Use env_cpu,
 env_archcpu
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429141702.5dgEjRS6KaXnYWZm_KLplSSIwCre-XdapigJl7RyGj4@z>

On Thu, 28 Mar 2019 at 23:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/nios2/cpu.h |  5 -----
>  hw/nios2/cpu_pic.c |  5 +----
>  target/nios2/mmu.c | 10 +++++-----
>  3 files changed, 6 insertions(+), 14 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

