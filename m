Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD5CC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 16:25:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B769B20848
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 16:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kDMZU1BA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B769B20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51024 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRffx-0003YZ-TU
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 12:25:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRfex-00034U-6v
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRfer-0004eI-Ea
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:24:35 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRfep-0004Yh-Lc
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:24:31 -0400
Received: by mail-oi1-x243.google.com with SMTP id m204so5622268oib.0
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 09:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=jXkkwto/pM5j3Mg/TbuErCm0nmSG5Q/rF/IRfFGEpUw=;
	b=kDMZU1BATLcZ0Tr8CwYBDoyUk1MDdcHTqu5iftxrSsbTryL+0dBWoBzHzMVvrsMPEz
	4jvHlgft8WSQK4oNzbb/S9V4+CXZKYPk8KzKVvaMIvnr6TyiCEZbnRfplZ7bpl+NazB0
	wFrtFRihlfzZkkfYZNJVGtpyZpEYX2QJvZtgmESb5c3rUIf/Y9Nr/zyfIm157eYmUtNm
	av8KOGmzyqyM4Gr3bS/Eiq6tOLo5w/8taubjwGjiDaIBTPcH+4j8ROoZyKjR37KF7o14
	/oihTYJMpsur3m7KfypT1xk52wICSFDQvwXYccWsduLnmNcaPD7K8MfMaLRQtvGo8+8x
	61Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=jXkkwto/pM5j3Mg/TbuErCm0nmSG5Q/rF/IRfFGEpUw=;
	b=rYvZGLnDaAdpJNnp0cfHZB3xGJEX5/X1sdrsZPh6mNwO62bw8kzY+DVdYALle+5PzY
	lLyydKy4KKWbpD3M0HV2+8MomVtaBEreR9XCiQifGqqZVU0QZFMNlQ4zIbunt2Dpnc3m
	Rl3adESW56UC6Rwl4kFAlJjyButPnipWtIpkTK+MmTnRhh9dl1H8medokbZjQhJzTQkH
	oBkWZt6umHA+KHZeMwHZu4boM9kub9rYVScmDxwCyH6Gb9/8jxbhjuyChPPOi8wRz4vU
	k/ubmSQy5eUPq7HrUBuuDxFyCgbshT71ZuSCCQrDAStj89vNWxe6pY4/vq1ILARk4IBz
	3EMQ==
X-Gm-Message-State: APjAAAUKAu0XV09Vq+vmEHxUA6EXWMR+sVs6LZvXAIvLRAaq3OJ4uPIF
	5BpyDL9Vn8C3sNR+HY+japRsL/Tk4ePufP+OHff58A==
X-Google-Smtp-Source: APXvYqzTEsxm73oKaQYF8mowO5lS9uM6caSH2YpsTsg1ODdYgEAefcSJr3RZnZIgdj/1l+VrwMvyagKJ0AcdcoesDSU=
X-Received: by 2002:aca:5785:: with SMTP id l127mr13503545oib.48.1558110262233;
	Fri, 17 May 2019 09:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR10MB204723BF7D62501F0339242A810B0@VI1PR10MB2047.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <VI1PR10MB204723BF7D62501F0339242A810B0@VI1PR10MB2047.EURPRD10.PROD.OUTLOOK.COM>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 May 2019 17:24:11 +0100
Message-ID: <CAFEAcA9_oe2NTnyb9ce_hH5jaaTt=V4-iOzC3a5Un8k1TUWHzw@mail.gmail.com>
To: Torbjorn SVENSSON <torbjorn.svensson@st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] target/arm: Fix broken VQADD
 and VQSUB causing abort
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
Cc: Samuel HULTGREN <samuel.hultgren@st.com>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 May 2019 at 17:04, Torbjorn SVENSSON
<torbjorn.svensson@st.com> wrote:
>
> In commit 89e68b575e138d0af1435f11a8ffcd8779c237bd, the handling of
> VQADD and VQSUB was changed for Cortex-A and the new handling does
> not return properly after calling tcg_gen_gvec_4(), thus the code
> after is executed and that does not know about the VQADD or VQSUB
> instructions and calls abort.
>
> Detected running GCC testsuite for Cortex-A7 and executing the tests
> in QEMU using Cortex-A15 since Cortex-A7 and Cortex-A15 have similar
> instruction set.
>
> Signed-off-by: Torbj=C3=B6rn SVENSSON <torbjorn.svensson@st.com>

Hi Torbjorn; thanks for this patch. As it happens there's already
a fix for this on list:
 https://patchwork.ozlabs.org/patch/1100645/
so it should get into git master some time next week.

thanks
-- PMM

