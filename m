Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D662C352BE
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 14:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF98121927
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 14:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iB0UO4rr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF98121927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP5WP-0004g9-2g
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 10:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jP5Vc-0003ov-0w
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jP5VZ-0002Z6-TC
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:28:51 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:36024
 helo=mail-oo1-xc44.google.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jP5VZ-0002Yd-Oh
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:28:49 -0400
Received: by mail-oo1-xc44.google.com with SMTP id x17so689128ooa.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 07:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kJb0ObQnb0PelbvTX6UW4+KUHeJAFJy421iEdXcmHb4=;
 b=iB0UO4rr/1zKr6b9r9DFP1rBmTnltIt505S4x1ZJbuUpZw9krfAojC0J8bQHvB/glf
 qoM92W9QBKqiL8bronZ4yUCKDiJWR+dO/70DhmKQG45MfSBqXmlv0uPF9Yb5Qk6Nt5va
 CrsF/IIIim4jr4+LgXjsCcO3cats6Ku50kkpH2A44TVW50u9a4qyMtP7zScyfoXRuWvq
 LJ5MkUriFjvkz4kQv5qwsacRzqZCvG9hOxSX2yjHTLCruFXDu1IyITIm3qWRtBOstdj1
 ICII7zrbKcqIVy7gdwT+n0LK0qkXtXz8/92tqYmSYaqarCxx0urjNXXkw/FjcD5FATLV
 FFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kJb0ObQnb0PelbvTX6UW4+KUHeJAFJy421iEdXcmHb4=;
 b=MgLzp9WJxPoNPavoQY4jWO1QsGi1A2Otu+5lNfetSp/+TMuBokGNnk+XIsoV4r8EM0
 SG1IUpcNpxj+tRJcQBhNZ4M6OWOKvbLIUTJgYO4zM5+lLMW24FjDSxtPRDL0zlv9SbBq
 wkczMWJwLkB61+XSGj8B7BfiPdDcMd776uTCCzl3ClzG2f4efUpseJHIj2AuiXwoyiGv
 Dk1OAnVRwAW1K703DPmDS9O1Qh+cugOV0SssNVBBHZQYXLbR4n7acYklm5RW1MNzYD1e
 V4nG7I3szwkEfybRJJ0G9e/Z3OhSADSQGQ8SbpsxRjkpeHdqyrLtr9ZCYMYDqmmfRKwS
 Oe9w==
X-Gm-Message-State: AGi0PuZWGB0TOI/GOu98XURa/76M0IXuL3dVSu/jToBc1W6ytp+kZ+mO
 o4wI8OMQ9HDt/xpiBucA0x9DO0RXDCRIf4lBOJs+qg==
X-Google-Smtp-Source: APiQypIs38UJPPkZ8P8fZN0MrlDMrRaqcKWybRTWrEvLcR7ZSuCvBQg7Rw76TJO0EJG0uui85TcqGohkFQA/0ZfaAGo=
X-Received: by 2002:a4a:3f41:: with SMTP id x1mr17174005ooe.69.1587047328832; 
 Thu, 16 Apr 2020 07:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200311064420.30606-1-richard.henderson@linaro.org>
In-Reply-To: <20200311064420.30606-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2020 15:28:37 +0100
Message-ID: <CAFEAcA-p1HRLU0S4Zgz6hEL1fNxDXpoCQnjiz7+a=T7yyEGQ5g@mail.gmail.com>
Subject: Re: [PATCH 00/16] target/arm: sve load/store improvements
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 at 06:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The goal here is to support MTE, but there's some cleanup to do.
>
> Technically, we have sufficient interfaces in cputlb.c now, but it
> requires multiple tlb lookups on different interfaces to do so.
>
> Adding probe_access_flags() allows probing the tlb and getting out
> some of the flags buried in the tlb comparator, such as TLB_MMIO
> and TLB_WATCHPOINT.  In addition, we get no-fault semantics,
> which we don't have via probe_acccess().
>
> Adding cpu_probe_watchpoint() allows to *not* stop a first-fault
> or no-fault load when the page contains a watchpoint, but the actual
> access does not hit.
>
> Having these available means that we can handle all of the watchpoints
> for a given set of loads/stores all at once, before we begin doing any
> actual memory operations.  Further, the actual memory operation on a
> page of ram that has a watchpoint can still use the fast path.
>
> Looking forward to MTE, we can examine the Tagged bit on a per-page
> basis and avoid dozens of mte_check calls that must be Unchecked.
> That comes later, in a new version of the MTE patch set, but I do
> add comments for where the checks should be added.

Series reviewed; I didn't bother to flag up the checkpatch
complaints, but I think all but one of them are legit, so
please fix those too.

thanks
-- PMM

