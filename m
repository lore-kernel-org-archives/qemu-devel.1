Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E03EC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27DE820409
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ao84itTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DE820409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX3mI-0005GH-9z
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 08:42:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iX3d5-0004cZ-8M
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:33:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iX3d3-0004j8-Uj
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:33:15 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53786)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iX3d2-0004ge-EZ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:33:13 -0500
Received: by mail-wm1-x341.google.com with SMTP id u18so3216299wmc.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 05:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=q880HofKbo9MmO7a7/b0N5kPER94gitbbieNcIqUPxs=;
 b=ao84itTYGq17eWeYHixovV32HXDTGN2trkn8O3bD7Vd7QQqGPqGgYPyUjNXGhWP3Wb
 NgFC0m2ag5GDVI+UQKYEsH782l5rL2heB/LyqPxRkbYA9bCFEAIEpnLKIUGAQttwxEez
 C4nKevxBC99SEEJW8Ooz+veIHtOtVIspyRpyIacCYcaHZ9ErbgBc24qJ11xUvHhET/EC
 QfKtr8wsPmV17uc8AD0RJEfI533572GgHcjU3xr6A/Qzzo4mPSZ3X8LZQu5+OaGcDWOk
 uSINwqZ/DCyymvR0aN+Lx68QnwNpIKEtUTjoz/BV2gn5Gb6jDl/3Q0fVGFTMF6TeonIN
 W9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q880HofKbo9MmO7a7/b0N5kPER94gitbbieNcIqUPxs=;
 b=fDNmEjJ0WfyKiBcq9VzFosRtcysaJPkRcooRgMQ0l1T7zqxh0I/k92Rq+KZ1s0mdJf
 e3nMtz29pC0YlCroLZ+Q40tWMpkOIFwgJdfJ9fpWXFc3tJ6i7wlw2x9RPX05MFgdxjxT
 wkK04ONkqCzSzY2E18Gj3LeZv4d1lSTCelJxs3f4vBMhMFcJJ/CSHI8nJkwcLUdeCX9M
 MtL+WUYO/6mFwsVw9Je+EmBR1rOC2opFie3GobCysOgmksqgKp0KRKbHItKlslgYR/31
 8HozsxcP9HFql6a7KDEyW792HP6uXqAp6SL8hKgqlrMsznb+VJhsskaj7UFnGnbZt009
 TEAg==
X-Gm-Message-State: APjAAAWQJFZxuLZwQglGKzso/nStL7YxJL+jdPLpbgCN/fk28eiyYq4q
 am2zs28+l71sKo/UgCl8o2C9VA==
X-Google-Smtp-Source: APXvYqzUiHstsDyfKNc3PLct3whOEqfLas1Yh+uPWsx7jBrXlcHcl2CIfa++5U71veEkGQGttf84/Q==
X-Received: by 2002:a1c:810d:: with SMTP id c13mr6071168wmd.154.1574170389953; 
 Tue, 19 Nov 2019 05:33:09 -0800 (PST)
Received: from [192.168.8.102] (64.red-79-149-204.dynamicip.rima-tde.net.
 [79.149.204.64])
 by smtp.gmail.com with ESMTPSA id 76sm3228726wma.0.2019.11.19.05.33.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 05:33:09 -0800 (PST)
Subject: Re: Exclude paths from checkpatch (was: Re: [PATCH] Add minimal
 Hexagon target)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>
References: <157412709300.27250.5531224491109755641@37313f22b938>
 <7851e556-a5f2-9059-faf7-3d2a4e32958c@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e0ded3be-03e8-115e-aee6-4c44c420449b@linaro.org>
Date: Tue, 19 Nov 2019 14:33:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7851e556-a5f2-9059-faf7-3d2a4e32958c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, tsimpson@quicinc.com, riku.voipio@iki.fi,
 qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/19/19 9:51 AM, Philippe Mathieu-Daudé wrote:
> I tried this quick way to filter some file/directory out of checkpatch.pl, and
> it works nicely:
> 
> $ cat .git/hooks/pre-commit
> #!/bin/bash
> exec git diff --cached -- ':(top)' $(test -e .checkpatchignore && sed -ne
> '/^\(#.*\|$\)/ ! s/.*/:(exclude)\0/p' < .checkpatchignore) |
> scripts/checkpatch.pl --no-signoff -q -
> 
> $ cat .checkpatchignore
> # A line starting with # serves as a comment.
> # A blank line matches no files, so it can serve as a separator for readability.
> include/standard-headers
> target/xtensa/core-*
> target/hexagon/imported
> 
> Would this be acceptable to reduce patchew false positives?
> 
> git exclude pathspec trick from:
> https://stackoverflow.com/questions/39931781/git-diff-stat-exclude-certain-files/39937070#39937070

Looks like a good solution to me.


r~


