Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D96FC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 19:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 372DE2075C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 19:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GFUmsX0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372DE2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZgrO-0007EJ-4X
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 14:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iZgoZ-00063P-5g
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 14:48:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iZgoV-0006oT-0z
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 14:47:58 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:43942)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iZgoT-0006nJ-7L
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 14:47:53 -0500
Received: by mail-ot1-x32e.google.com with SMTP id l14so16954603oti.10
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 11:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=Vw9w5utWht+1JCcdzc0FctgjedmZhvYgnmPoL5xJN3g=;
 b=GFUmsX0yuuGrpVMYW2HmER2vcA7jGMmj8cV3hmAUFdKJAOZFTMiK48p9ozRl2t/kpd
 apQxcuUhy9WXPbeNlyyt4b7AN3X44bpsCcn+pHCK7025Z5UEnh1sP+O5BP5+L5TWYRA9
 xNL9ocjNxQoG8YNKjWyculGDwCB6zOfIBfcO8K3J0+Nqy9Dxwe7e47v60S17lzf3vtLE
 P/2vexaDvF/BWbD4mXNs8e8mA/G+IOlp7lp9mZacLiU65/22Pv8xQODmiju+NYCPUuwS
 Y2cp1DjTCSNqazXj5iUFu3DLWaT8o7F0gyg1tWKDCmYNhOzFP5flnE7UjNRTjwvcqTTi
 R/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=Vw9w5utWht+1JCcdzc0FctgjedmZhvYgnmPoL5xJN3g=;
 b=CyXxWuKTxqdcEdNN//Ni72Riw4pprBdFSi7KF1Wg29PjQ01//LB5Nw1UHSShoTtlkP
 tBpp4KJbiM/slBhNQnuz+PI/O02vYf4FAfMTnDqfs1kSc3Ht61AYALsRlKW20pFq7dul
 Xf+Mhy9mZfEAnWwMFNZJp01xX86qMZ3HJ3t10/GH0oPLwpuYpfTuWQox/QNUAM+0DH7x
 9q3uA1gdMm4ED9okLOodYFZ9wYALw7vyyMx1sw50sjEoyzZ1fV+b/kdTKau8ytzTNCJs
 LaSffN+wW3FdIHGhpbm+jc0LDOfGLRxpuTUJ6GOSmjdrin3139FPtxcHGa9TM0Tsc9Qh
 a3QA==
X-Gm-Message-State: APjAAAXb5qpz1CvlFircoDvaQBNq2XD4K5wbUM94G3zuyOAjk558Gdfl
 yen85AivcDdBw9Ec4JsIHTUgFXHKMpzWQ9/2Cvty4JWC
X-Google-Smtp-Source: APXvYqzlqEPdp+AZmhnCEqUlunT3XvIg4oEmrcgoqm8saa9k8isePvVYrg6wu5HYbIU+KXSBimm9JcgMllKyROfxZ8M=
X-Received: by 2002:a9d:6357:: with SMTP id y23mr572584otk.91.1574797669345;
 Tue, 26 Nov 2019 11:47:49 -0800 (PST)
MIME-Version: 1.0
References: <20191126141239.8219-1-peter.maydell@linaro.org>
In-Reply-To: <20191126141239.8219-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Nov 2019 19:47:42 +0000
Message-ID: <CAFEAcA-9dETLZTpU0u3Zoq27vQr93CZHSJP8MfPCg017fx1oFg@mail.gmail.com>
Subject: Re: [PULL 0/4] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
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

On Tue, 26 Nov 2019 at 14:12, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Arm patches for rc3 : just a handful of bug fixes.
>
> thanks
> -- PMM
>
>
> The following changes since commit 4ecc984210ca1bf508a96a550ec8a93a5f833f6c:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-4.2-rc3' into staging (2019-11-26 12:36:40 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20191126
>
> for you to fetch changes up to 6a4ef4e5d1084ce41fafa7d470a644b0fd3d9317:
>
>   target/arm: Honor HCR_EL2.TID3 trapping requirements (2019-11-26 13:55:37 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * handle FTYPE flag correctly in v7M exception return
>    for v7M CPUs with an FPU (v8M CPUs were already correct)
>  * versal: Add the CRP as unimplemented
>  * Fix ISR_EL1 tracking when executing at EL2
>  * Honor HCR_EL2.TID3 trapping requirements
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

