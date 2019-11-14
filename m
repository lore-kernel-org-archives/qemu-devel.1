Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20142C43141
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E15DD206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IV9lFwir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15DD206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVCZb-0003OZ-Vz
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 05:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iVCYa-0002WM-Qk
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iVCYZ-0001ix-J4
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:40:56 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37311)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iVCYZ-0001iT-Do
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:40:55 -0500
Received: by mail-ot1-x343.google.com with SMTP id d5so4438571otp.4
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 02:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NAcFoLpm2lY8PWtLIZ7Bv4A7T1cwx/EQN8HAql7QP6w=;
 b=IV9lFwir7eY0CFnmXOXejuNc2cQiw4D74E4/DPRFWoSP8coF/RBx8R7NV+6Gn3lTqi
 h3KkNgNQRQJCMdem6VMwQAeTZhUnP9R+ocQyMU8TmEBl+r7la1GGqtfuSI23BbVhXsWo
 7cNykYHkL+HTmfzvVGkEKt38UtBcSC6a2erLWmqJu82vE6K9VQAnEhWMreQooDRzsQRM
 efatqs2q7oNMEeDBTzcgpyhPxUB250sZo1HJf9bT382bmG9s3+f4cL2oQ1p95GfzjuNi
 qknwQAAZ/+w8YdQAbHYFwumXVgd7r+PJzdN+P8Lsw80hVN2hP1Glyb9l/s7PTbuXcc7D
 3KgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NAcFoLpm2lY8PWtLIZ7Bv4A7T1cwx/EQN8HAql7QP6w=;
 b=JxpuUZBdXpo9OV/l5IeBUbMixfk4EyH9zWWssrN4jy3DabzvePuDATwmO6hmPj5YlR
 a6wx20/pQRMz0dYcykOYrTgBL+xY5thX80FYslcSHbdZ1VeopX9bfZUi7kJsc5ospiUF
 5fKYZmcfClhx91iL1iR0DCcUCXsawBSck+at6HQ218i4FFjwAXUy/3Gc72xWAXj4n3so
 /YrWYSaECLTdJu5aW2WAs3QHCZphMtNe5y/ok7n7q1+kd7jPg+VnGZXeE5A0Mw/1pJIf
 UakiccEXu7xCmbhN/IgbksojhUJEOIlgPRm5aM3CpO1IlIBee2A3cReQLwh15n++n0pd
 ux9Q==
X-Gm-Message-State: APjAAAVZqH4Hc0XTuVhvdElCl6nj38ZCHZuC8kyp7FHxz3TF7Bb/Hgtf
 hQWWthjqDPKwDV26tMEx9KEraKmVcz6QhbOV89GFrg==
X-Google-Smtp-Source: APXvYqzhecN14jmVhglPmCY23qXkqy0lfbcUMUTbVxhk9bb7CLaA0cwn9tJyGGmMMv50YjUOv75TbeqEVGD7gEB/auQ=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr6227962oto.97.1573728054300; 
 Thu, 14 Nov 2019 02:40:54 -0800 (PST)
MIME-Version: 1.0
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-2-git-send-email-pbonzini@redhat.com>
 <2db4f901-65ad-4b80-d309-b8b63330492f@redhat.com>
 <4783e606-19b8-c3c0-08ab-ac84b02af6f4@redhat.com>
 <CAFEAcA_FnfJx=oae5e_KGcmqwyUtM01KeywjpSSa09fu9++sMw@mail.gmail.com>
 <07c6a4ea-1d5b-da75-9fed-3b9e7bb1d193@redhat.com>
In-Reply-To: <07c6a4ea-1d5b-da75-9fed-3b9e7bb1d193@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Nov 2019 10:40:43 +0000
Message-ID: <CAFEAcA-9n38=Zg1YuFfy1pS-8Vc8EZD82nPdfYUf2gBAJY8tBA@mail.gmail.com>
Subject: Re: [PATCH 01/16] memory: do not look at current_machine->accel
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 Nov 2019 at 10:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 14/11/19 11:21, Peter Maydell wrote:
> >> FlatView #1
> >>  AS "memory", root: system
> >>  AS "cpu-memory-0", root: system
> >>  Root memory region: system
> >>   0000000000000000-00000000000effff (prio 0, ram): microvm.ram kvm:tcg
> >>   00000000000f0000-00000000000fffff (prio 0, ram): pc.bios kvm:tcg
> >>   0000000000100000-0000000007ffffff (prio 0, ram): microvm.ram @0000000000100000 kvm:tcg
> > Why do we need to print the accelerator name for every
> > memory region? Isn't it just a global property, or at
> > least a property of the CPU ?
>
> Not all regions are registered with the accelerator, in particular not
> for devices.  So we print it next to regions that are registered.

Ah, I see -- so it's really saying "this is a kvm memslot"?

thanks
-- PMM

