Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0F0C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 10:53:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 195472467B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 10:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cTMeL1a/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195472467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwOVA-0001Ri-8V
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 05:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iwOUS-0000jj-3X
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:53:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iwOUR-00056l-1K
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:53:04 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:35304)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iwOUQ-00056H-RE
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:53:02 -0500
Received: by mail-ot1-x330.google.com with SMTP id r16so11563724otd.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 02:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y/tnOoANi8AiucqC0RhiBN0MlOCWbYT0MR/DWgs9ox4=;
 b=cTMeL1a/3akPzvqxJpscHolCP2ohRw7iBOcyCm6SfaztdvNppyu2vLbUPLRBt13euy
 MPO1D4o/xoAjZuXzEz92SPxoJIq2YkPjAlncxv0p8lbaapNTMJMkeXRORbpQHolZY4ce
 qVd1RdmmUT5BR7gWVa8n5OS1Nlz05XQFagSkdZQB5xiIzZ3SKdIfYOoRcKkODsAzLsDj
 TWSuUogjac6d5YlqDbR5QZAyx/Jhg3zwStSLPf2LCMC7WUu/Waaz5gBAC4rhemUXxwmd
 jq4PB4ddzvC2zhedBpJg8ZrmJvYbBam2LVedOceV4rQjpEtYi7atei7owD0WnvMR9P48
 f8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y/tnOoANi8AiucqC0RhiBN0MlOCWbYT0MR/DWgs9ox4=;
 b=nhSf6JQjKV/oCwu5h1laKJA4E3zP3YKjxHJ3qDWkvnmkViSLd1Y2yu9t4jb3RsbjDB
 ZvUKbABYCS9IMX31CVuRLzcn4hOjtA9gUuu4/8FL+7QOOzDHynSiAt+Xd/CtyM64juba
 2ibuws7PRbbgomO8CYLx51ZZ8UYhx0vN6E33eDjWQ0/+TP2ojyPxs2mZ1KoIP5UfjMB5
 R5mJpSNFu3V5JX2Y+UGCAc1DqryJdWaWlL6jDJTNItWmxbU+Uam3TlM3X1C5z2ovGCT6
 YvHge80xkZO8/xYEaX5wNxh4yIHQ+BbmYpgeFkRUk9xmRpqrn9srQ3mFUwQi/iJOvxBt
 fahw==
X-Gm-Message-State: APjAAAWluJKCFNiQ4X8XK3Nd5F3EpU/TwmHCvqRJZPLddfYNyqKQm4pX
 xL0RbBCF5IvLYdZO4B6zttayMPdqid9FxPSFmtTFfg==
X-Google-Smtp-Source: APXvYqwBXdmXDW5Spv0dRG3T0S3WUXPC8wuFf0vduT2rnqvZSiF4M7ENJcTI3VGKLIqtGdsNiJDLW1Ei1MSMO1TMX00=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr16072594otq.135.1580208781797; 
 Tue, 28 Jan 2020 02:53:01 -0800 (PST)
MIME-Version: 1.0
References: <df1d6ae5-b734-ef64-4ef9-c661e8f797e8@redhat.com>
In-Reply-To: <df1d6ae5-b734-ef64-4ef9-c661e8f797e8@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jan 2020 10:52:50 +0000
Message-ID: <CAFEAcA8hib-3YWuS-MajjvokOFCGKUHeuz+XQTBYf8LBz+PuFQ@mail.gmail.com>
Subject: Re: [question] hw/arm/virt: about the default gic-version in
 accelerated mode
To: Auger Eric <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
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
Cc: Andrew Jones <drjones@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu list <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jan 2020 at 10:47, Auger Eric <eric.auger@redhat.com> wrote:
> When arm virt machine is run in accelerated mode with "-cpu host
> -machine virt", the default gic version is 2.
>
> I understand the rationale with TCG where we don't have MSI ITS
> emulation along with GICv3 so we need to choose GICv2 to get GICv2M
> functionality.
>
> However in KVM mode, I would have expected to see the host GIC probed to
> set the same version on guest. Indeed most of our HW now have GICv3
> without GICv2 compat mode so our default values lead to weird traces:
>
> "
> qemu-system-aarch64: PMU: KVM_SET_DEVICE_ATTR: Invalid argument
> qemu-system-aarch64: failed to set irq for PMU
> "
>
> I would like to propose a patch to improve those errors and also suggest
> a hint. But I also wanted to know whether you would accept to change the
> default value with KVM and choose the host version instead of 2. For TCG
> we would keep v2.

As with the -cpu option, the default is there for command
line backward compatibility primarily. Even if we had
better support for MSI ITS emulation we'd still leave
the default at GICv2.

If you want "do the best you can, regardless of accelerator"
that is "-cpu max -machine gic-version=max".

thanks
-- PMM

