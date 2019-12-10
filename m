Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A212C2D0BF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 11:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 179E32073B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 11:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tE2Bm7qH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179E32073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iee1I-00045P-5G
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 06:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iee0Z-0003YS-KQ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:48:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iee0Y-0006qN-EH
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:48:51 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35061)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iee0Y-0006pT-8I
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:48:50 -0500
Received: by mail-ot1-x344.google.com with SMTP id o9so15233614ote.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 03:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SfXh7eKZqdpO2LGEgz3P0HSgLknLGqn+asJn+CHcrPI=;
 b=tE2Bm7qH6GjY2mQXj1MWvgEieR2tcKUidD2+T4ja754WnhBE5poHvZhfvZk96rQ5S2
 ot2BaTtcY3DY42tK0z50hv406f57UoY7CIRrVDAwSk7/+YmaqNynl8/s0807+AgmdMcN
 qeKd5mpmh42vcCbxaUjAGhnzH+Fyp2gcCkdi9bAIAHhg+LdQd1EwriUvZeRcmZ1YteRK
 tlb/ayBCDE1x3f4pJyCP/RXMcyH7YTwW2dU5RF5ec/8ws3xgfU72zeJqC41XuS6IuSI/
 KwF0F7NrVQc+czEmGXwgkIIL9YLUS2x1tu6eu6kBkzMN9shDKY8aYc3+91OXMdGyoYFA
 MhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SfXh7eKZqdpO2LGEgz3P0HSgLknLGqn+asJn+CHcrPI=;
 b=cZKk8Z/T12E5C373+JopOI/wtkqVccDHzvNnPMAyt3mqVDKJAIbwvPP9JdzBNqjB9o
 2ZD5LKhrnCK1d/9ERgEA6hIS9hXiet80QGDU14RmDklEqqVf+4ZSk9aHOntWgNdpiJtI
 2IsVJ+HgqHg/1D8mkp+EbmxY+hcPC8ymaYv1Y8D3uufhaB07R5oAilQuicUhexB+IHSy
 8myVbsOND/kHRoRjCEJcqFfqqghfEE76nmFtkJRX6bKS9s3JTKiOC7mcyOwtEgOZ48hT
 iq02nGJ4d1B9D/mEz9AXmvOSrbfNDV7D4ccq3QBhQBr5CyvKC6KNuOJAUuowGcyU8+Id
 lS/g==
X-Gm-Message-State: APjAAAUfHZn8aaCZkaVy/1BsF5csACoun6YKDWpQikyAZY7KAuWbsRm4
 yiyG1QrOCrzNt5Iyp9q/JEcbm9gaPFlXQA4NlOCueQ==
X-Google-Smtp-Source: APXvYqx16K1ZVv4gv8fQvB3f5jY1DQINqwMflWH7jrq9BnIDUnmN6ak6Qlo+A9+K9Zeo9StUIhpvspJu/yxV93Rchq8=
X-Received: by 2002:a9d:4d8a:: with SMTP id u10mr10486979otk.232.1575978529096; 
 Tue, 10 Dec 2019 03:48:49 -0800 (PST)
MIME-Version: 1.0
References: <20191016143410.5023-1-drjones@redhat.com>
 <CAFEAcA8j8M_J8Ocdpms8a2XufigVQ6oB4JBy2BcYAkXfJX5y5A@mail.gmail.com>
 <20191206155327.7adiyjjkjh56mg2t@kamzik.brq.redhat.com>
 <596d07e933cb4da48dbba5b492e81a2438e78a2f.camel@redhat.com>
 <CAFEAcA9+G0jprsHRQp8g=Aso+2-_GhoWkDGx4WWxoC88maOKEg@mail.gmail.com>
 <20191210110531.psjzlikir2ep2omo@kamzik.brq.redhat.com>
In-Reply-To: <20191210110531.psjzlikir2ep2omo@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Dec 2019 11:48:38 +0000
Message-ID: <CAFEAcA_M61hTzU=qCiUbR4V9Mnwd0phFNqTJG9pCWKreVmjy6A@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] target/arm/kvm: Provide an option to adjust
 virtual time
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: bijan.mottahedeh@oracle.com, Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrea Bolognani <abologna@redhat.com>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Dec 2019 at 11:05, Andrew Jones <drjones@redhat.com> wrote:
> x86 developers could easily add this feature if/when they need a way to
> disable their current default behavior. But, since the kvm-adjvtime
> default would likely be 'on' for them, then they'd probably prefer the
> feature be named kvm-no-adjvtime, and default 'off'. Should we try to
> anticipate what x86 might want when naming this feature? IMO, we should
> not, especially because I'm doubtful that x86 will ever want to implement
> it. Also, what about the other KVM capable architectures? Which defaults
> do they have now? And do we expect them to want to expose a switch to the
> user to change it?

My perspective here is mostly that I don't really understand
the ins and outs of KVM and in particular handling of
time in VMs, beyond knowing that it's complicated. So I
prefer approaches that push back to "do everything the same
for all architectures rather than having something that's
arm-specific", because then things get more review from
the larger mass of non-arm KVM/QEMU developers. Arm-specific
switches/interfaces/designs just make arm more of a
special-snowflake. I don't really have a basis to be able
to review the patchset beyond those general biases.

thanks
-- PMM

