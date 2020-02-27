Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F3CC4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:46:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C77A24692
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J7UTjO1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C77A24692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Hch-0001S3-Hx
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 06:46:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7Hbc-0000vZ-0J
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:45:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7Hba-0001XK-Ii
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:45:27 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41879)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7Hba-0001X4-Da
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:45:26 -0500
Received: by mail-ot1-x341.google.com with SMTP id v19so2589044ote.8
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 03:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OttzwSAB5FjP2AnIsJdZXCBNV3Bpq+i2RGCoBFPNnFQ=;
 b=J7UTjO1cqHhBbcnh5M7eA+OVDVN8JmqDox3/eDK7k7rxgApB2EVVGKd8lASt2M1ncT
 SEdOjBm7F5qpeZTXwRTu9oFAMRzxFZNiLb2FSks5JLZJgnXvmH2mVusA+jT0EnzEQc54
 mf9MUPJ/mxfqVYGHAfrXLE8jBMawYSd0y6lZKxDykTykymDQBSRMPoDlnVPh157O8ZUI
 LYJoOPXzCKLdv5VSppoflvbfAk/EID/ZDrssN8BRcE0LWy1d8p3Gk/XK31RPL9sXcDHp
 Vl9z2dAcbsf5Zvh8stAUaPBIhJUcnztr8lWMOXlZSCKqhiBJwMgsYT76jtcGypMNg+nW
 EDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OttzwSAB5FjP2AnIsJdZXCBNV3Bpq+i2RGCoBFPNnFQ=;
 b=KKOKoHr7hzV/pWaEYhQhH0PUprxxD4WXrPqyyMSbuv8jS8zJAseP1e8SvwgkgPxg3A
 EqmaF38w1fDSfvSDdtrreKWslPQAciklh62rwLVsnFb2YNv7OseSQpSwY6B0dETY56DT
 u1M5ASSQVR+xcu7aqden3YBNpjHt932hmNp8g1dC2lzSaGjr7Ja3v5ZfM3c81XjSFC9L
 shOH8+czL5cXYOnQpE8oE8V++zDyYXLbJTe9hbbqQPW7p3VA8uFFDOKBnbCmQgasxoeH
 zaJUiy3dv+uPq0+Dx1EUlxr6E2Gh6ODTuFSb8fnMFqrhnYLeBl1q9eElFaBFdhpYUMSR
 LFRQ==
X-Gm-Message-State: APjAAAUHKOPuNF+4g90mbttEwRnS2TJMdTp6ZZ6vhX1Fh7HuqI5R5b3a
 NwSh76tqMIKbb3FR7QcubSALlbv0CqK82hKsJOIlAg==
X-Google-Smtp-Source: APXvYqyPfgmA5xyR8IwR4IMEnMzocRCb7c+sRbdu/I1/PKTd9QJNnjI2GAJnOP25FKtTW9XUN0c2Ia+8R1x8kuksyt0=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr2968483otd.91.1582803925427; 
 Thu, 27 Feb 2020 03:45:25 -0800 (PST)
MIME-Version: 1.0
References: <20200226113034.6741-1-pbonzini@redhat.com>
 <20200226113034.6741-9-pbonzini@redhat.com>
In-Reply-To: <20200226113034.6741-9-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2020 11:45:14 +0000
Message-ID: <CAFEAcA_N8WTM-RVJV=PrX7ir0uiK==z+bpKSW8hDncg+T2P9yA@mail.gmail.com>
Subject: Re: [PATCH 08/18] qemu-doc: split target sections to separate files
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 at 11:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/system/target-arm.texi     | 264 ++++++++++
>  docs/system/target-i386.texi    |  92 ++++
>  docs/system/target-m68k.texi    |  46 ++
>  docs/system/target-mips.texi    | 152 ++++++
>  docs/system/target-ppc.texi     |  78 +++
>  docs/system/target-sparc.texi   |  96 ++++
>  docs/system/target-sparc64.texi |  61 +++
>  docs/system/target-xtensa.texi  |  56 ++
>  qemu-doc.texi                   | 873 +-------------------------------
>  9 files changed, 853 insertions(+), 865 deletions(-)
>  create mode 100644 docs/system/target-arm.texi
>  create mode 100644 docs/system/target-i386.texi
>  create mode 100644 docs/system/target-m68k.texi
>  create mode 100644 docs/system/target-mips.texi
>  create mode 100644 docs/system/target-ppc.texi
>  create mode 100644 docs/system/target-sparc.texi
>  create mode 100644 docs/system/target-sparc64.texi
>  create mode 100644 docs/system/target-xtensa.texi

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

