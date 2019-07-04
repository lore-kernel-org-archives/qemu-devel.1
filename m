Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E545C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DE5D2083B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GEEgULEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE5D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj4Jx-0002Og-BR
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 12:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43193)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hj4Bw-0005eR-CE
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hj4Bv-00079h-Do
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:02:36 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:38553)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hj4Bu-000761-VS
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:02:35 -0400
Received: by mail-ot1-x32f.google.com with SMTP id d17so6414081oth.5
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 09:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=aUaGRFqGwaGwOvo0cSAoDNVu3YjQ9jD7eDEAqJfnWgU=;
 b=GEEgULEJ1p8GSRUrsvfrFI89LlyaJlR5mzn+L9JVUUt2ojMP6weEOBM168NTVJufll
 tb7bzharOu5aogs3/nj6YcjKYVFpSU96xYA6fzVyqfgZp7paGhro/VfxuOO6SHj7O0bT
 +fqCuySD25ttPfsgR5/Jf+hSHjxJoDupmszWoGtdiCxrK4XDQe+KzRH8q3Pn0yh+pa/L
 htMqZk/S0O1HrI9EM5DJM7pw9ASLhnn6Xb7A/jgRKsQO4r+2U+Oz/3nVe/ZfAjO8dziF
 IrZFVObKlwNT9pf/P1d0WzpEbTNdq/sfdOb9RRYV+EXeWWDIdpDLuyG673R4veHzPfYw
 r0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=aUaGRFqGwaGwOvo0cSAoDNVu3YjQ9jD7eDEAqJfnWgU=;
 b=DAdKGQfzIouD8wsYKcn4qn3tTC3xKqi6G994nfuqlkIY+CUv6SbZ6AGv8wBoW3fEe+
 o2BLnWm0RY0elN3JbZYG2r5+/0X2zY6XA9/wyLGOvWpaB2dnOLwF3CzG4QW1rVL5EXrP
 Z3AtxxEpVvGyT5bGHHh4GoANZ+ugHq/qBTcwouES0/3JMKv9Q+FzDo7HWrAl/asG9j1u
 F+w2yMKLSq5d7ncpKg5GNGP9yf76jwi05OCCh6PEA3vrnykQi6pRwT5eeaeziTjs6m5a
 6QxZ29ilE92LNO3HtHicT/VK42l/9JPme/TXAihvuk8jG1JdNyUn7waQVRWz6G9oFCbI
 9XAA==
X-Gm-Message-State: APjAAAWNfAoo0/3zHXC6zn4BRR9X+28MQkf79uZnikxO513tvhvAgjE0
 EliVEw6Eabf3sypAl6NKnCMqhzUzydPu1E0lnOFxmhqVeKU=
X-Google-Smtp-Source: APXvYqzMcfOyoEQZwVmms6740aQ/sFUNcnEKXJYGPRmTrsfGuYCviAbOUzsFM6e2D3f3YWXGv+Jrao1HJk2mD+M5Qco=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr1872302oti.91.1562256147975; 
 Thu, 04 Jul 2019 09:02:27 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2019 17:02:17 +0100
Message-ID: <CAFEAcA-yzWhwYPzC9px0H-=x3XEPVBjZOhk402is49YpbmJX9g@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
Subject: [Qemu-devel] pl031 time across vm save/reload
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I've had a report that the way the PL031 model handles time
across a vm save/reload fails to correctly advance the guest
RTC when the host RTC has advanced between the save and reload.
I looked at the code and my correspondent's analysis (which
I quote below, lightly edited) looks correct to me, but I'm not
entirely sure how our RTC stuff is supposed to work. Paolo,
you wrote this (way back in commit b0f26631bc5179006) -- any opinions?

In the pl031 RTC device. the current time is given by:

    int64_t now = qemu_clock_get_ns(rtc_clock);
    return s->tick_offset + now / NANOSECONDS_PER_SECOND;

On save we do:

    /* tick_offset is base_time - rtc_clock base time.  Instead, we want to
     * store the base time relative to the QEMU_CLOCK_VIRTUAL for
backwards-compatibility.  */
    int64_t delta = qemu_clock_get_ns(rtc_clock) -
qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
    s->tick_offset_vmstate = s->tick_offset + delta / NANOSECONDS_PER_SECOND;

On restore:

    int64_t delta = qemu_clock_get_ns(rtc_clock) -
qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
    s->tick_offset = s->tick_offset_vmstate - delta / NANOSECONDS_PER_SECOND;

So, no matter what is requested, if "qemu_clock_get_ns(rtc_clock)"
increases (eg, because host time increased), then tick_offset
reduces, which makes time follow QEMU_CLOCK_VIRTUAL no matter what
was requested on qemu's command line.

(That is, because we migrate "offset relative to CLOCK_VIRTUAL"
and CLOCK_VIRTUAL does not advance when the VM is stopped,
we don't get the right behaviour of "offset is relative to
the new CLOCK_RTC, which might have advanced".).

thanks
-- PMM

