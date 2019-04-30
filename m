Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E8AC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30B0C2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ssMQdLLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B0C2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42664 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLPun-0005iH-5g
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 06:23:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLPq1-0001iV-6Z
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLPeW-00044s-AE
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:06:22 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLPeS-00041O-Qm
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:06:18 -0400
Received: by mail-ot1-x341.google.com with SMTP id t20so11380259otl.5
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 03:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=EQMuGSjdIy98D0qkTLJ2KzRylNZb4X6/U90QJbyIYDI=;
	b=ssMQdLLyEtrTagcjpJgotvjuy1NYCELM38b87YyQ+eNS56mcBWBhiddL84TdTDNspm
	NvkjqF+SBtrU1KqKReW31quPoQi8N7l7RJSqtTviwVkUCmQ2BzO/RtKBrRa4BiZgCMUL
	lR/pdPxCs7dY+52skTpHR9SOyDMNDNxe7E/PhIHzwm5JKO5N3Y7ftOx5fRJTZwa0qX5W
	p0uXXUYUF7E1DuKUDxy3t3wByWOf+56ttjfC5M3yOBvtjWiUHWyApJr5hC2FV9cdPOOI
	koyfzgH8MQt+IA1pEOM+wt5o3NifTLiKbEtag5A5gtIv1Sdf1r4AhwakYO4sYFXJoDmc
	WPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=EQMuGSjdIy98D0qkTLJ2KzRylNZb4X6/U90QJbyIYDI=;
	b=dAfNXjVIfdQcGPIc3PLiY8O7cRa983SwMk5w6sQUhnhaEv7dGE46s5dgjaAd4XdTqY
	6c025M4wjUtO+iiGzG57YEqBwLYHN1ixw237iHOxorsK0Wb1I0payw7fUc/xjMWEBcpE
	EK3NPLqF2KNMn3sh8i1fs0SJelvlKA1Jo0h4UxmRnSWRlDZh/yTpX5htsOhXCbRFdC/b
	GCuWhu21SKCnKpZw5ol8ayUEubK8behG5HtGis4A8LrfP6Io5G/LQN0lHagt4/w/WRyo
	TR0uVkhvlfLnanMuxNfsBczm6AhTJUNMmrRX9IkNiHxM2lFq0kSFPk1Yq3ifUzDzfed5
	SFOw==
X-Gm-Message-State: APjAAAXD53FAcUTQDERzQ0X0NhgOYT1deJOljDrIO31lqFgSzFYqsitC
	djFdtKggZgRi7G+MhTeQ384M7jgVknOg5vl/ts7iNA4kiQU=
X-Google-Smtp-Source: APXvYqwVMgnjEZTGUu0BY4B1e/zjF1FuPmxFPKtNr39yTyUU8JG5U4/2/i5sLYxNeLyhLL3mHbKmlX96uBqpaq0p+NY=
X-Received: by 2002:a9d:404:: with SMTP id 4mr39621768otc.352.1556618773877;
	Tue, 30 Apr 2019 03:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-23-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-23-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 11:06:03 +0100
Message-ID:
 <CAFEAcA_jBgEvFTnSu_KMHD6Ofnr05DvX6mTZD1x7-jhdi8sdJg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 22/26] target/unicore32: Convert to
 CPUClass::tlb_fill
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
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430100603.aNEPOIW-kCdTrNir89JOUfC6Tkgtl_2cLLZ77fvJPmM@z>

On Wed, 3 Apr 2019 at 04:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/unicore32/cpu.h       |  5 +++--
>  target/unicore32/cpu.c       |  5 +----
>  target/unicore32/helper.c    | 23 -----------------------
>  target/unicore32/op_helper.c | 14 --------------
>  target/unicore32/softmmu.c   | 19 +++++++++++++++----
>  5 files changed, 19 insertions(+), 47 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

You might note in the commit message that we can just delete
the user-mode (non-)handling of tlb fill because we
don't support unicore32 linux-user any more.

thanks
-- PMM

