Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0300C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 17:17:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A42218A0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 17:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pB8v5NCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A42218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj5MM-0006gv-Hm
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 13:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53801)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hj5Ko-0006I4-0M
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 13:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hj5Km-0008UI-5N
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 13:15:49 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41896)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hj5Kk-0008SX-DL
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 13:15:47 -0400
Received: by mail-ot1-x341.google.com with SMTP id o101so6573373ota.8
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 10:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=AALsy9CPDdLlq4nh01m9X6eGvQwnByrHctc1wWDTNG4=;
 b=pB8v5NCicM89ikTCEz3cEhuOm1mugiJ75sWcLdWO6XUj6u2rVUzKWpIqy3yjQFjF4D
 zd8Su0kTi1WJYObYLZsAehGo1sCUonDZDElSw+mhWUSrhG7TE6kjyIUGnAsYl/0lq23z
 q0ARLK4zismfjn3Ix3UvRhGqXfpKuOA4E0t+qKAXDq5NsRvnACBM9QQ1grAGOF5Jo1dZ
 0tCILWZb8bw/CFIVyI78C6Yv9j60WMlBBCVOuPcsnZXZf41yCzL9lt5bSpfa+NzSxQtD
 dXKrxKO2hJrTCeC9T5lxCkzc7qUln5jJPXC0WozYRXGTu3UjS2ndnh3Zd1iRTcF1XcVi
 MSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=AALsy9CPDdLlq4nh01m9X6eGvQwnByrHctc1wWDTNG4=;
 b=Jrs3+D32mHvLHwYkJGoQdg+LzGAsKN1YQ0+f5Orq/RxLNWKagoeo8TeZNxbkki8fqy
 IUgKACHrRrZ+GOPz+rm84M+mO5Mcw1gR7WhYPsTIyYYYvL/l4g1xJOesGCTOhtEciLvn
 +es3++AmulYGbtHKS0swFB79xT52si+2a/OjIepR7+L7zY1Y5H7UkSqa50H22Veg0msF
 S/chXaXCWsH2p5T/7N5Hd8uB3qXuJ4+pF6FDctgXVuT/gxQWyYkOjWZx0cNwoRJyStyN
 Ldx9JiYCRnrhiu/faojsK69P2uHfRQ4EsNnbKhkJiVfWEnvGuywSBKildkORWOKNwiLz
 j0rQ==
X-Gm-Message-State: APjAAAUFCu3B91dzlZN4hh4CiSt6VbTvO6iyy9cV5Ts0/9DGV2U2Bgd/
 1lthoMfuO/HmgMqhiC43GATXs+KdwwHX5SQ2bmAuLqoLUvU=
X-Google-Smtp-Source: APXvYqxPKE4I08dkzyVnO+NceTRO5WgEu5II/hFVB0DB2pCZuqTQr392+GrDX1k6CUTFhbUeBtvoEC5wIvRBDUTvAiE=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr35727877otn.135.1562260544563; 
 Thu, 04 Jul 2019 10:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190704163209.14481-1-peter.maydell@linaro.org>
In-Reply-To: <20190704163209.14481-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2019 18:15:33 +0100
Message-ID: <CAFEAcA8gp9h52iZFCNPqw3exPKq0PmWKYfGx6=mH0O+3CCBBCg@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PULL 0/9] target-arm queue
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

On Thu, 4 Jul 2019 at 17:32, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> A last collection of patches to squeeze in before rc0.
> The patches from me are all bugfixes. Philippe's are just
> code-movement, but I wanted to get these into 4.1 because
> that kind of patch is so painful to have to rebase.
> (The diffstat is huge but it's just code moving from file to file.)
>
> v2: fix up for clash with the qapi refactor which only
> showed up in a build-from-clean.
>
> thanks
> -- PMM
>
>
> The following changes since commit c3e1d838cfa5aac1a6210c8ddf182d0ef7d95dd8:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190704-pull-request' into staging (2019-07-04 16:43:13 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190704-1
>
> for you to fetch changes up to 89a11ff756410aecb87d2c774df6e45dbf4105c1:
>
>   target/arm: Correct VMOV_imm_dp handling of short vectors (2019-07-04 17:25:30 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * more code-movement to separate TCG-only functions into their own files
>  * Correct VMOV_imm_dp handling of short vectors
>  * Execute Thumb instructions when their condbits are 0xf
>  * armv7m_systick: Forbid non-privileged accesses
>  * Use _ra versions of cpu_stl_data() in v7M helpers
>  * v8M: Check state of exception being returned from
>  * v8M: Forcibly clear negative-priority exceptions on deactivate


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

