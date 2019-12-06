Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137D9C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D07EC2464E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h9/iFhzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07EC2464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idEhb-0004Zy-Av
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:35:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idEMu-0007xx-9c
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:14:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idEMn-0007V0-1U
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:14:01 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39287)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idEMm-0007Sf-Nt
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:13:56 -0500
Received: by mail-ot1-x342.google.com with SMTP id 77so5888615oty.6
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sAwG1RdahKAAnevB5fnXeo19T4BGa6gPTGH93hfaZww=;
 b=h9/iFhzntozkFHkukFSX0Kb7aymZtALNeROIGrhqu81gy3LwYfJXHDuf/ymfvDMQGO
 4n8A6KNL8K5BPpH7zAfXi+cQFBZ+742OSQgY0XRPJtN4U00cf7rZx+Fbiwu5jlGBkBop
 G+XSPmj3Qpaxft53Gl1nzArHbZ0SJBcHUzL1H8GTivixhYvkwbF6KAoRGqtqZfHxSeg9
 CIRYpHWdBIW7oPJORN9r0+4bki2ouNTI/Zth2wlspsACJHF6MncT6SU9gdjppNAQpR/Z
 38g4aXS8ur2rshwALmHUug/adW2t9NMeccCYWIJkwShLvIu9A0KeTXMJopt1FyVMUETq
 NoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sAwG1RdahKAAnevB5fnXeo19T4BGa6gPTGH93hfaZww=;
 b=YDkwbr6/dMFXDivitVS4n+LAWpJmJqZrwWOdsvK70obYrNEfVgl4sezpzROPzm5L0t
 mTsgY/g4ilEtHfGws+M5gbMXk/BKl2mhOckI/dU+QbMkXQ5ytSISCccPVO1iL2soCKAU
 T0cUX4kSodAISp09goUnIy+Qw8BWrtaQ3t8gIDH6Znzf+AxYKqE+ekpv+1uT3E9fWkIE
 vIZS6e6BSdGcFohG4cgzyCgMF9r3gPd/G15s6rgEaIbWmoi4IuyXugwCP+3cLjT9Rdm4
 +IH57lzjuBmfxil8FsH73GAYhtywCLYws6RHH5oO7VZM9wZdIaw2dC3gT8IeTZ5XZJTQ
 FynQ==
X-Gm-Message-State: APjAAAX/PMEaEUa1+v8AdbersU6A9sJacVJmW1Lh7mDwDNOIk7VKcBAi
 57eL3NxyCcBOZppnxDFl1RKV2a/OIsLcto5NzWMUQA==
X-Google-Smtp-Source: APXvYqwbA0R++xciQcgbFLyRMhfm9S1jgLftXf41A9mZ+0k3+h0K0Uy1L8rc0QwiBBkE/CrvLtXGQIZimKsFmk631ZU=
X-Received: by 2002:a9d:6745:: with SMTP id w5mr10591050otm.221.1575641635717; 
 Fri, 06 Dec 2019 06:13:55 -0800 (PST)
MIME-Version: 1.0
References: <20191201122018.25808-1-maz@kernel.org>
In-Reply-To: <20191201122018.25808-1-maz@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 14:13:45 +0000
Message-ID: <CAFEAcA_XWvO4yhJzEaTGatTfqqjZ9u3cTd=eo1xaPszwEYpPkQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] target/arm: More EL2 trapping fixes
To: Marc Zyngier <maz@kernel.org>
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 1 Dec 2019 at 12:20, Marc Zyngier <maz@kernel.org> wrote:
>
> Hi all,
>
> This series is a follow-up on [1], which tried to address the
> remaining missing HCR_EL2.TIDx traps. I've hopefully now adressed the
> comments that Peter and Edgar raised.
>
> I've also tried to tackle missing traps generated by HSTR_EL2, which
> got completely ignored so far. Note that this results in the use of a
> new TB bit, which I understand is a rare resource. I'd welcome
> comments on how to handle it differently if at all possible.
>
> Finally, and as a bonus non-feature, I've added support for the
> missing Jazelle registers, giving me the opportunity to allow trapping
> of JIDR to EL2 using HCR_EL2.TID0. Yay, Christmas! ;-)
>
> I'm now going back to kernel stuff. I swear!

To save you from having to roll a v3, I've fixed up the
handful of nits Richard and I found as I applied this
series to target-arm.next.

thanks
-- PMM

