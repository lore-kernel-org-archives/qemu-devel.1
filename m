Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606B7C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 18:40:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA7820715
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 18:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rigSDmSQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA7820715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jakh4-0002S5-Bm
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 14:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jakgO-0001n1-Em
 for qemu-devel@nongnu.org; Mon, 18 May 2020 14:40:12 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:46406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jakgN-0003iJ-8w
 for qemu-devel@nongnu.org; Mon, 18 May 2020 14:40:11 -0400
Received: by mail-oi1-x22a.google.com with SMTP id b3so1975449oib.13
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 11:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uBMC2Fm6cDIp9cgM5ZvIcUzY/344wkYUNTPOSVDjF2o=;
 b=rigSDmSQXSa25R1CsuG8VKyek0W0wal6uM6NFJKOlvsh0AbTz3khIWPKAVQI/mndQz
 ZpJa0/h8NRQmYzEyp4F4pfP/InghPpvhoIxkWCn6rscdHZaWSaKmV27GnYdBhxYu9+Yj
 0m3HkKzEsVApMG303UA9sVElHTdAsLbjqx0Nlk63FqVpVfD19iWbhAzs24asKi3M9ZDM
 XCG0fHtpgq71dYWtLuidGeS28wjzrd9rTlN+Wtq53tHadl/v5X8nRuczAllkGUZIHKq+
 1JH52euL3QImN0GrvdG0Chsks5fSNrSRdl6md4LlWWjdYtK7OUK78b0au+m2KEzZoe8z
 amPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uBMC2Fm6cDIp9cgM5ZvIcUzY/344wkYUNTPOSVDjF2o=;
 b=LPLeoA4xVgK9HZjelIOuWe6iAZ0RcH515rjS2XFSs96hnxkfHCJzk4LqAf+n1lG+dp
 Jb8Pv4BebFR6L55/q84oht7rp2aSMvzbE86DanKqcXgo0ekTs9lfmbqNy10+GxYbQEn0
 8NxcFSxK6RnpNOKLJfxbCXKbImlusQiYTLPpYOGtgZNXG3JxayQ1P0V2yOkmnuLMDdjL
 yXVl2MFroy6HXF/tJ90v5HTB0fbNEI9GUytAVGJawsaykhmHbI4rFH/EY0YxRv0C6Aat
 cI0OjqAWcAwDiAF6SnGhkMFgHKRACWJm9nXEGcLmQVZ9GAMqd7lbindHU4eY2EYPF/il
 qtqg==
X-Gm-Message-State: AOAM5302oEyYHQIeGjyyF1zJK5p+wnSUytdzWRHZ7Pvqz/C+elWT1RmP
 u0Wh7pwIbLlpWXOkqfUR7PvmxQ+5rTWl1Qa8IL/Xow==
X-Google-Smtp-Source: ABdhPJyjRoAjhNpMn3fR08oc+d0fN5lLdGezy3thgBaB99tKGvE7rQ76+DEsK/Hs2+5ShC/sovLdPrc46CqBVPFlaKY=
X-Received: by 2002:aca:895:: with SMTP id 143mr516418oii.163.1589827209903;
 Mon, 18 May 2020 11:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200513180953.20376-1-richard.henderson@linaro.org>
In-Reply-To: <20200513180953.20376-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2020 19:39:58 +0100
Message-ID: <CAFEAcA_xBwNPWFd3w36JnuBsZSKb+q-aWXHfrLe1Rb-29eXpjQ@mail.gmail.com>
Subject: Re: [RISU 0/9] risu cleanups and improvements
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

On Wed, 13 May 2020 at 19:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This patch set does alter the format of the trace files, and thus
> means we'll have to re-generate these.  However, the space saved
> for sve trace files is significant, so I consider it worthwhile.
>
> In addition, the new --dump option allows one to inspect the
> contents of the trace file.

Alex, would you mind reviewing these risu patches, given that they're
mostly trace related? (Also you're the one who'll have to regenerate
a lot of trace files :-))

Richard: if you feed an old trace file to the new risu, what
error message does it give?

thanks
-- PMM

