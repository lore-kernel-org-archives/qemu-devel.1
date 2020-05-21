Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EBDC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:50:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F17E20748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SlQZLiB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F17E20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnSO-0008HN-Fp
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbnOP-0006qx-Lk
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:46:01 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:42143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbnON-0001Ob-RH
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:45:57 -0400
Received: by mail-oo1-xc41.google.com with SMTP id a83so1526469oob.9
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8h1ZPoBxJvuQvx2ziXpdx/NQiUgWmqZ1hoQbkwoXnSQ=;
 b=SlQZLiB4OFUSMtrURCnULNta22198oi+Z5RQAyBqo38LQk9Wha8N10/YPkuBWPYcSV
 v0dSGU9HBPNNIrm+eyaZTbxOTlAN/5UVuXo/cRYgucmP/HGV5nChW+Q00R9WpbIoCX6x
 PnDtVFdl4tD0EDId0iZ4Y8lp9MVazgA3g1/JGyZzN5QoT2KYF2uaj3bXRr4B5IhSI9Ix
 A+ZRl1caqAKOoRzSsN2cMlYXlQA5F+VlGNFj5+2ufUKqgS/NXx0aew8IzlZBikCPtrD5
 bMgxLoeMq5bcK8G35nZBb9ubrSzNanS+gwpQBB9ZWi77//UAfqBJZd82VOxRt5ykYr9O
 2Ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8h1ZPoBxJvuQvx2ziXpdx/NQiUgWmqZ1hoQbkwoXnSQ=;
 b=PBNsr5Yk9Uhrgq8BUviLMvEm1ihnTZRyD0T6Rm2QwGnlflkyyEfXBiWgX7kTRv1LU4
 bLP4peQ/8ihNnVkCNCZ5q9Oh+8TRW8OzWJST9LN+fkkuBN7u92L1bnca8Iu4fxaa3ETH
 E94yPggqLR8e0tzbWOjIiRIJ9sMGm1RFOicXLN/SqWbS3oUspzYetBKPV7iNpUwBXOex
 G01qiQDLTEAZLswz/pb2e7P5w0lN1sh/gG1jUl1D5A1m+/QtFN81CIVv/h6aCenFsX82
 HUaFTkjE1CpHBvbU+Od29lFYFijDS2ktTHP+aVgFycpQoANb8lt5uUmrV37T2AEv2KYU
 JTBw==
X-Gm-Message-State: AOAM530dGfZDacWnf+K+HuI+fen9Gx1x8WIJruUMQcgcSKe93/3NSHy8
 d2hwBxXiSloHN8IUhmR5ghMuitMbcMSLEtvN61WY6A==
X-Google-Smtp-Source: ABdhPJw5xr8eYxO7RpfOFZCX1bJlGCyf6NovnXN5CNJ3JraeuvE/zpszL7WYd8lUI2xweMQ38hKNv6LHhQvcl3d9SF0=
X-Received: by 2002:a4a:8253:: with SMTP id t19mr7809624oog.69.1590075954348; 
 Thu, 21 May 2020 08:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200518155308.15851-1-f4bug@amsat.org>
 <20200518155308.15851-7-f4bug@amsat.org>
 <CAFEAcA8tGgyYgHXT5LVGz675JMq6VWR56H++XO5gtTrcaZiDQQ@mail.gmail.com>
 <0c0cbdc0-a809-b80b-ade3-9bdc6f95b1a8@redhat.com>
In-Reply-To: <0c0cbdc0-a809-b80b-ade3-9bdc6f95b1a8@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2020 16:45:43 +0100
Message-ID: <CAFEAcA_WOEeV53yr7SmWqyOnbfWYg3COr-C+mjaCuAPw=refcQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 6/7] accel/kvm: Let KVM_EXIT_MMIO return error
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc41.google.com
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
Cc: Richard Henderson <rth@twiddle.net>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 kvm-devel <kvm@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 May 2020 at 16:39, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 18/05/20 18:01, Peter Maydell wrote:
> > The "right" answer is that the kernel should enhance the KVM_EXIT_MMIO
> > API to allow userspace to say "sorry, you got a bus error on that
> > memory access the guest just tried" (which the kernel then has to
> > turn into an appropriate guest exception, or ignore, depending on
> > what the architecture requires.) You don't want to set ret to
> > non-zero here, because that will cause us to VM_STOP, and I
> > suspect that x86 at least is relying on the implict RAZ/WI
> > behaviour it currently gets.
>
> Yes, it is.  It may even be already possible to inject the right
> exception (on ARM) through KVM_SET_VCPU_EVENTS or something like that, too.

Yeah, in theory we could deliver an exception from userspace
by updating all the register state, but I think the kernel really
ought to do it both (a) because it's just a neater API to do it
that way round and (b) because the kernel is the one that has
the info about the faulting insn that it might need for things
like setting up a syndrome register value.

thanks
-- PMM

