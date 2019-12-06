Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECE0C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01ABD2245C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="smqN0Zo3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01ABD2245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHWP-0001xL-HB
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:36:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idFoM-0001cM-JK
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:46:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idFoL-0006wb-IB
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:46:30 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41149)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idFoL-0006v5-CK
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:46:29 -0500
Received: by mail-oi1-x243.google.com with SMTP id i1so130647oie.8
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 07:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Pdre9Si9zdnLnZji5jvhEWMqNMAmGc7VPA2Ram4aBAs=;
 b=smqN0Zo3p7AWhUxu9cMrrtCDcTtJJNDMv1XSCTfLUdyMsV1lb17buybLen3xcJlkgt
 i0t57+53v7TdXfxETy5QiFuQGKnnlZaD5hBaXc6BcEna6lSMzkZpYCQPAIrJgYnPV78t
 yQG0yayLzwyMh7/edQv13w2cmxXSV2Lcgv96ux265aiPle5r0p4ugWy5ZsDDEdvEWRx+
 A5hJ4CFnhVCsPcFbaJnskwT7yxpAm++3JrD52we02eYrhN5OwrYeLJlvWcXpm0DZCNL3
 hxamFRNcRxO3YBIaNh3oXtG+TkIHx2RQ4pYuzWRtcXsKcKKRsHTMhUwO0wPYd3QgoDix
 E0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Pdre9Si9zdnLnZji5jvhEWMqNMAmGc7VPA2Ram4aBAs=;
 b=anpsSO1HQ/X1itn+ZCdDvb2hT3flr4llClPNk2DHf/Dk4RdHJmkLLILZh2dGCFV950
 kcPThhWzheD1fJ9TElu86qPnyKfTs698KoUJANNC4RLPkKqKfSZjHBJXsHWKqc+TOXgz
 rIUTopBcpbxzTJ8xqn3QXvWPYch1gHXk85LOaJaZB/lJQETMwSsZWuSGpprrKlHv0J8U
 r1jZ/wb8VjmNZti2RCNOZNtCA8azi1d4+LkhFBW1Omj8hrKE4Pkq5Q/zUjdC381glm9b
 4V43L1fEIM/JLy07zRyqTIHYUdukkbVCJVhLCbf3+RRe57/x3KGgRSTHshq5hs0u5dEm
 yOJQ==
X-Gm-Message-State: APjAAAVtsy83nvqr8P7jHopGhgu18SyHB6i0OlmpDyvOuefPHMVqFIoY
 KGge4kjht5g4zruWJDdWo5IFB8K6VoZDiPLGgO+Wtw==
X-Google-Smtp-Source: APXvYqxalfWrWoR3jCUeyjKcikZA21HXZZEJ3u5ZRtUbo2uYGuKQA1bU5lag7k6gmJslTdMZIW51o5FB2VYYMsqGAF0=
X-Received: by 2002:a05:6808:996:: with SMTP id
 a22mr12214250oic.146.1575647188495; 
 Fri, 06 Dec 2019 07:46:28 -0800 (PST)
MIME-Version: 1.0
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-10-richard.henderson@linaro.org>
In-Reply-To: <20191203022937.1474-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 15:46:17 +0000
Message-ID: <CAFEAcA-2mpUSjwnkAJGdwHX5P0xvF_eZyVLt9xPv57330Qu3dg@mail.gmail.com>
Subject: Re: [PATCH v4 09/40] target/arm: Rename ARMMMUIdx_S2NS to
 ARMMMUIdx_Stage2
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Dec 2019 at 02:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The EL1&0 regime is the only one that uses 2-stage translation.

...now what happens when we support secure EL2 and we need a
secure stage 2 MMUIdx ?

thanks
-- PMM

