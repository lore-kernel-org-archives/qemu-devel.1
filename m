Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5F8C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 19:30:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A7B820725
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 19:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pqj/eIg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7B820725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVKpU-0001Mu-Fb
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 14:30:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iVKog-0000kE-Sh
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 14:30:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iVKof-00009f-QC
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 14:30:06 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37861)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iVKof-00009B-KX
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 14:30:05 -0500
Received: by mail-ot1-x342.google.com with SMTP id d5so5891427otp.4
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 11:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xqJqK77NzOu5YIrC2tR4eXYnlh7bbuOG6iBbGsdAtz0=;
 b=pqj/eIg1o4I41AeTNSDxbScGfqPkyAjrUHXwDQDV7y+64+gA3eKOdOrG7WSQimber/
 109X7DE833stPm6ikiHbj4+O1+xj/UW9ruFpoMrmFUYQegGdh7Q8lt8U7vrpos0IK3kr
 UXMMnq76wOC0tIcXvSLPzCcyOEfxNU0y9+lAFd1taQ9EnqhUWUSujUVQqWT3L7KtNlMw
 LHZ5KUmDKcMSnMOnb2c+WUYp+u+gxwGYlTipTMT9S1kSstasnxOrJXcjD8aXVRsS/q4x
 vu3LfXFbqYE1LOT6XDZ3WAwTLwDuk+DiYbqfRKi5TMb5TQFtC3OIQoEDPE8mzEx/9Jgz
 CkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xqJqK77NzOu5YIrC2tR4eXYnlh7bbuOG6iBbGsdAtz0=;
 b=iN9td1qKN/iAuiJqmoEig+r9B880Gykd7DQR5Tdkp/pnppEw/jEaAddXGBxZBQ87xj
 FXLBADlRBRvvB0MlVsUJuC3SUMbb0TyRmxZA795O9g/bz7CRbdb9/lTf5Qtjxc94ltSd
 F3z8pd1qoBLxemaYpyDQicP8gJWeoPKbMoB2tJxbYESkNAOX3sFf8x+8OP7Ns9WapnzH
 RRyUJsHveNbe2pqg2/VR1IXoZcG065Y3aLQLoq3RTnrJ/zxxf4BF/9I0U6uhXj0eSYhP
 XBgrrsjDHTHwk7EqiqccbEMOQgQRIExCM0zpLzZEMvJRueuyEEFQDxfcVwi6K6EPhx3A
 36hw==
X-Gm-Message-State: APjAAAWXJfjrV0VNr7tpIsguwWATwwGXC8Bsv2CtYuty7A8c6GtWo+z7
 en2DrqFzr0o5bjRI3BpXGVvY/JC/vwHmHEUZpyLOMA==
X-Google-Smtp-Source: APXvYqyqw7dnhQD+ebdJQm1NfSUmwuF11wI9oRTZyrRixviuD/yWyqdha0fe2G42hiWijt1i2LTB36SgvQE2ZKVmDV0=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr9073654otg.232.1573759804794; 
 Thu, 14 Nov 2019 11:30:04 -0800 (PST)
MIME-Version: 1.0
References: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
 <20191024224622.12371-1-keithp@keithp.com> <8736fhm9tw.fsf@linaro.org>
 <87pnik4w9n.fsf@keithp.com>
 <CAFEAcA-g+RkvYjseDE=1Z=gnLum0Cjvn_7bqB3ti+cBq9UZ3Eg@mail.gmail.com>
 <87mudo4owu.fsf@keithp.com>
 <CAFEAcA-MRtr9WUpqqwJiX9kc+ybGdgfv7ZB5Tc6_q9xwHwebsQ@mail.gmail.com>
 <d4baa0c3-694a-293a-385a-b3eba7d52d0d@linaro.org>
In-Reply-To: <d4baa0c3-694a-293a-385a-b3eba7d52d0d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Nov 2019 19:29:59 +0000
Message-ID: <CAFEAcA-yc9oBfsj1uvbYVCc8kivOE9k2QBGdKs8HZ-vj2iv-pw@mail.gmail.com>
Subject: Re: [PATCH] Semihost SYS_READC implementation (v4)
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Keith Packard <keithp@keithp.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 Nov 2019 at 19:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
>   - If the sequence crosses a page, then so be it.  Because of
>     step 1, this only happens when we *must* cross a page, and
>     will have recognized any paging exception anyway.
>     The generic parts of qemu will handle proper invalidation of
>     a TB that crosses a page boundary.

I'm not sure this would work. If you have
  insn1 insn2 || other-insn
(where || is the page boundary and page 2 is non-executable)
then the required behaviour is "execute insn1 and insn2 with
normal behaviour, then fault trying to read other-insn, with
the fault address being that of other-insn".
Whereas for
  insn1 insn2 || insn3
you want to treat it as a semihosting sequence. But you can't distinguish
the two because trying to read the word in page 2 will cause us to
generate a fault with the fault address being that of insn1. Or
have I forgotten how the page-crossing handling works ?

thanks
-- PMM

