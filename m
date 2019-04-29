Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCFFC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:17:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B8A20673
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BBGvF7ll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B8A20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL76A-0001Er-Cm
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 10:17:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL74M-0000E1-HL
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL74L-0004Nw-DQ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:15:46 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL74L-0004Ng-8d
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:15:45 -0400
Received: by mail-oi1-x242.google.com with SMTP id t184so5880385oie.11
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=WKU/ssGIGBI4OSgKNwed15HP+jgiy9KtC+JFxay639A=;
	b=BBGvF7llbE/FaSPH3ilkFTw15BU6GeX2DxL5yuGvY6WndyZVw5zNupkgqhcqW/thPQ
	u2VIrga9Kvn5q9ICLiROzExPUR3AogCLfFpueiCSXZ1VgY2Ihux7g5j++wm+An860Ubb
	c2b/qFR+gey6Dt1grRa0+PujN1ikmEvyGfE1YdRVnswVubTHpcGVkJmFngOq4ObCVcNY
	zBDAlSaQNw9BIWMGBYL0a4VZe6WMiVaoeXWQhjmahCH1jXzJNlAYzKLHBdqW3k5gck2+
	EAEMQTR9DrfpwZAXDObLw92/FRMgE0r3juI4nckaFuGXjaIWkcpxS+WLqY+t2vxWTuxZ
	JOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=WKU/ssGIGBI4OSgKNwed15HP+jgiy9KtC+JFxay639A=;
	b=ugS9ENKZl4nIwMJ15XtNb4cW89umtsb+HybvfoynS39nhTE1pdHUGp+kPzl29JE1no
	hpmNiWvg2xWrnlQkvRtzii33VEozwTmOu77fJxwdRiLa9BzAtM9T9aafj7AhWuWtFS7w
	u/7IDEe44y/DUqnMaRlLBCc9kDR9fyEXy5/V0AfQ6gHsa5bx8zrMpUzlt4NYc8MwXgqr
	nRoCRI1TSN+QVIgr0krtqK7S6WtF92hlvy7U/3YU/X+G+q32nlLUNIqY46rG3whZqhXE
	sgfer968EQ1kE3qs0TDIlpcncZXwRmlbLcRPnrarzVjgeKGBrfKhWKl3k8tfykMuagOd
	7+OQ==
X-Gm-Message-State: APjAAAUybWTP9C9Yzc459K+C/lvDENrsFuR7J2n+SlDAnHQqgcS1BWcQ
	XOeDA1ulADJtx/N1ASqg1kDHCkRfoCp6viUvLZF8Rg==
X-Google-Smtp-Source: APXvYqyxmeoECoDfv8YfXL2vEPsMm2Xv6KBL0PZctArcaW5mGOH3zDSCb9Ow5BgqKSsjAdXCbvAyMtJK1LJgX1xYfL4=
X-Received: by 2002:aca:ab12:: with SMTP id u18mr3781675oie.48.1556547344587; 
	Mon, 29 Apr 2019 07:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-16-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:15:33 +0100
Message-ID:
 <CAFEAcA-4gucDfR3tCtd3wXhEOsFQo9URpMfaCEg98brjeWV_uA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 15/36] target/microblaze: Use
 env_cpu, env_archcpu
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
Message-ID: <20190429141533.OJpaTq6QDuQV26hxLG22PqWL4LE3mXOyDPI4Qtx4OFU@z>

On Thu, 28 Mar 2019 at 23:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Mention in the commit message why we needed to move the
definition of cpu_mmu_index() ?

Anyway
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

