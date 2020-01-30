Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8335C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 19:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5989206D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 19:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x3F2IwtR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5989206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixF90-0004kV-T7
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 14:06:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixF87-0003yd-QV
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 14:05:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixF86-0003us-Es
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 14:05:31 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixF86-0003t7-88
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 14:05:30 -0500
Received: by mail-oi1-x243.google.com with SMTP id d62so4645393oia.11
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 11:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4n2f/jvQERvuInqxmf2eKISqXf3NPJHMM//aCRwvzSk=;
 b=x3F2IwtRgfqpU5463sjF6kqZ2x/gcD9AMEsgmX14e1ub4OJY7KVRjLwGcdN5Nk1dOq
 DfjiwcSiEnJZyR3FeEpLBAS716Sz0wCWMi2FlSTlLPp+VeiPgBW89z7cQF2KE7UxzsVf
 PJ/Eh4Uje+BYfD/sNxWvK9ldpa9OUCqpTiBoc9afUlumw0c0Aevgfr5gAp0M+yc8r/fr
 dhN8zDbNmGyvd+V/zJbFUGMGHpUeG6o5Vd6gWdhWk8nZVXnYQtQT0gYkceAvmUYMzt1c
 2EeEAkB6DD3c0tzsS+UfR7vOdG5l0IVOv9jHrLywQ7fJaWGsIQQZvRhMUN9/SzzjKhzt
 Fhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4n2f/jvQERvuInqxmf2eKISqXf3NPJHMM//aCRwvzSk=;
 b=i/yeEkr2uqBZEuyqfBsXrhqf9SmnXDqg0pZfLil5NnbjU/qBJyUwghM3TKDPLNCDjC
 wLEm1Ifui9P1podneHuqe+Hox+HZIZMMrP1QD9CkNmJwoTrYTRKUsPzgCYSkH2/AiMG3
 hwjWNXbFg1UEkUFDmR6t0Uo8VF/UQJ/XCgvI7S1ICPZUq2bRFyiftW8QDMON/TO7aQIT
 cEFERyn2rbA6N+nI+yMwEtPWhjLnbh1nNe5s0NpcFSZUeC7FzgHfGPtWZucHxqv1Gd30
 2pkS96N0sgiPKg0C+e0n2xiVKzo7BcmJKNNYV1aCJpJSuhXKvlqTJxDRRE1/IUK4gu8s
 TXkA==
X-Gm-Message-State: APjAAAWPzaGTY8n4CBuiJSQvaWstgYXeaNB6Uy5CySIdbpg5bPWkQyvK
 bkuT0OCGqGPYip6DiEyLn7yRrGe/8B4b7k735A5gpQ==
X-Google-Smtp-Source: APXvYqzYoiTqLzjgln220IJvY+wzi56nw3lpoQXD+cRWFWU/tyK+aV2r1S1FMwZAipzWcUyS3fXrFHMKk40nATVN+Rw=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr3762792oie.146.1580411127844; 
 Thu, 30 Jan 2020 11:05:27 -0800 (PST)
MIME-Version: 1.0
References: <20200123070913.626488-1-mst@redhat.com>
 <20200123070913.626488-18-mst@redhat.com>
In-Reply-To: <20200123070913.626488-18-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jan 2020 19:05:16 +0000
Message-ID: <CAFEAcA98iqJkTp4F6qmO5f4VYNhE3Fs4toBuV1qNtujAo6=OJg@mail.gmail.com>
Subject: Re: [PULL v3 17/18] i386:acpi: Remove _HID from the SMBus ACPI entry
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Corey Minyard <cminyard@mvista.com>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 at 07:11, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Corey Minyard <cminyard@mvista.com>
>
> Per the ACPI spec (version 6.1, section 6.1.5 _HID) it is not required
> on enumerated buses (like PCI in this case), _ADR is required (and is
> already there).  And the _HID value is wrong.  Linux appears to ignore
> the _HID entry, but Windows 10 detects it as 'Unknown Device' and there
> is no driver available.  See https://bugs.launchpad.net/qemu/+bug/1856724

Is this commit in fact a fix for LP:1856724 ? If so, we could
usefully add a comment to that bug noting the commit which
fixes it and mark the bug 'fix committed', since it seems
to affect various users who would like to know the status.

thanks
-- PMM

