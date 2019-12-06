Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6835AC2BBE2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33FC624659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yeaXDVs8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FC624659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFFy-0002fQ-Je
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:10:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idEZ1-0004U9-0w
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:26:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idEYz-0001xq-UK
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:26:34 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33633)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idEYz-0001vr-N1
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:26:33 -0500
Received: by mail-ot1-x341.google.com with SMTP id d17so5968031otc.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6WfAA5W8BZkXD9ffx7UeqY8vIew9vi7Mn2RNb8mbH2Q=;
 b=yeaXDVs8v83FYKp/axfTSvAXTIYXbQKoBS3/0CvvtI807zf0TKZ4P1LfXqCWc/788w
 sUNd3V6t9UvVUeAYgHXRucfCT5ZT3OMxIHA2zOf1OmUxpSyk1UD8A45qKpDn+XaWK8s0
 wu9v0Sk+jFqmFG6oCAwOQ4q/AdgrAERZ9K5NrcTyVS0Ip1uBH7N4Ny1/ulYqZkuV2Ety
 Fb6STJpKI8RUgeh401W1L6Tu2azdHn6f1SCWAXPgyl8kEhY3NaFhJI2zUTB6vdY/fVlA
 pKJoBJ3Q+jYEpoW5GttQUoB9+HB8TQkE8MLneQGAt/qfBFddhkEjZT7tlhqugIEhN40E
 5pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6WfAA5W8BZkXD9ffx7UeqY8vIew9vi7Mn2RNb8mbH2Q=;
 b=HimRetzNqrqLoHpZwHZDsNEZUBtUewLHlYQooW1PqyVNIzmc3ab9cvDg2OJ90QWHxe
 ZrriQaZMX7HUu+ZN/MbVbq/jTq86dGPYZuj0IJkp9jY9d7lCSTznv/Zn7fTslcEP3i0S
 DV8gjLWbgQlt51QM8XKQSdhYaF4GxcKwlpYpWQp/UT2UirokEPrk/yHHZ8K8uIUohZ1C
 gOcVW+NgbEJWGwUIAXtyAfBa0xyWU5Nh/B7AuGMmNvn5mKEhC1I8BNcQQ6j6QTBIU4cB
 N1Vx5S2/LfN3heds/3U5sTAE70IBXxGNV0eMIXncD11MIiuP2mU6gzt7YHNAZye+dGj6
 y8Ng==
X-Gm-Message-State: APjAAAVKrpqru/ny1PDf/HBnIoE+j2BGYLqTZXRnc9quNwQBs1Pe/WcK
 r132TVpcvcaCcLK/EuMD/F4Qq2/TVrCAGX86q+S1H+eW
X-Google-Smtp-Source: APXvYqwf+2IoMlq5ZuCeWxiAi+OGyYXw+F8XkRm8Om33qIWxjKTR1d+07NjLkldp1XuE3YL2LQpe6AzmwGdnuJY5umE=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr11381867otg.232.1575640621933; 
 Fri, 06 Dec 2019 05:57:01 -0800 (PST)
MIME-Version: 1.0
References: <20191201122018.25808-1-maz@kernel.org>
 <20191201122018.25808-6-maz@kernel.org>
 <27089f4b-5bd3-04a9-9c16-91474a225c45@linaro.org>
In-Reply-To: <27089f4b-5bd3-04a9-9c16-91474a225c45@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 13:56:50 +0000
Message-ID: <CAFEAcA-oqASZ1N0q1F5qn4a6y3f+3=nMZo=Cb3EXU0LYt16xYA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] target/arm: Add support for missing Jazelle system
 registers
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 Marc Zyngier <maz@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Dec 2019 at 15:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/1/19 12:20 PM, Marc Zyngier wrote:
> > +    if (cpu_isar_feature(jazelle, cpu)) {
> > +        ARMCPRegInfo jazelle_regs[] = {
>
> static const.

If this can be static const we should just declare it
at file scope. The only arrays we put inline in this
function are the ones which need some non-const
fields.

thanks
-- PMM

