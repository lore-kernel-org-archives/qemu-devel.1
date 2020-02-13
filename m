Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B351CC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD052073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WP+5Lnmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD052073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Ffo-0003Fw-E3
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fes-0002Vm-7D
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:40:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fer-00067i-45
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:40:02 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46654)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Feq-00065o-TY
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:40:01 -0500
Received: by mail-ot1-x344.google.com with SMTP id g64so5727120otb.13
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A4EPPn1XD+DrC3EutJ1d+JoZYSjW6TenIzcHdxfjf7A=;
 b=WP+5LnmzPYpCz1W88JoUB3XPljfC+Y8gXRoZakD0QsCtzfuBycN0/X6D07SflZQzCb
 IQLogAZ5rX/hGMw2TJ6jnI9/r6z0YxK6sMD1Bjqxj4yTPeeweVLslHSW63m17T/eoHCZ
 IjAo3GMVWWsE189yVidUxOKy56SNv8kLO76+x+hjXp9Nqop0dfYQkLFjgZCYsyZgr6tf
 YTxw0JquFLwP+blpXdXFGBmWdFh9ikNYofnbAAxEgAL8gTxLR/qBVXgDHSV5eslBaRDZ
 qk2ov+BkDppxTBGMVUeK8FsCLRNQ2pDGeHhKwUniOUP8P/ikNjvQ1ORnBOo3F7nA5SPA
 ILTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A4EPPn1XD+DrC3EutJ1d+JoZYSjW6TenIzcHdxfjf7A=;
 b=taiIvQhPOWnpW/kPUCvzh5PabJf2NOQBLVVMfFSjR1b35+GOrD/dTcBmegeZV0c1s0
 WowGkThtzyddny6mK3rQntjkwWF6VY+Xf9wONzW41V8GiIJ2ezXbAPQHy+dId+W4HaSd
 HRLohQOe4qa+y/Gl5T0g7vrtmNQAVSASx0C/vQQ5fMvbTPLoz9CIe5BB5ptnZmZMFxrD
 Ab38J/KrxhvbzpTgyuV6gBueuOugfk3CBG1kMe7oygsUGWo34qIa024MRnA6LcHu3r8s
 jRWZxKFzF0vvQfmFb8Nz1I7nkQ+4edjsZmhV/J1RaTdS5lvlWbqTv1P00ddfaYDtqoso
 ekIQ==
X-Gm-Message-State: APjAAAUwucgt9c4qNstyiqCuRni4xujxoJF+ip6BvTXXzK7J2zHBQsW7
 CkFW7KDOObsyO3kk6ZhXAr7l14+DrP0g8qeQp5S53g==
X-Google-Smtp-Source: APXvYqydj9Bn6PFD5jDxyVYkM5fsmTuxz5POgqf4lvuKlvngYkfNz0g6YXkdOktRWSsZSKwiLRaHTiD/9LMwYvCEBn4=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr12900017otq.221.1581604799968; 
 Thu, 13 Feb 2020 06:39:59 -0800 (PST)
MIME-Version: 1.0
References: <20200212184648.GA584@roeck-us.net>
 <504e7722-0b60-ec02-774d-26a7320e5309@redhat.com>
 <20200212230918.GA27242@roeck-us.net>
 <560224fe-f0a3-c64a-6689-e824225cfbb9@redhat.com>
 <279d959f-f7e5-65e1-9c68-459f3fed56d3@ozlabs.ru>
 <52f0b829-151a-3dd0-0ec7-c3155185510c@redhat.com>
 <9f652340-1277-0eb2-bc2c-402b4209a220@roeck-us.net>
In-Reply-To: <9f652340-1277-0eb2-bc2c-402b4209a220@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Feb 2020 14:39:49 +0000
Message-ID: <CAFEAcA8CyTqdqvT6xatkxb9EN49zD4OBaKrbaLpkyZg+eMoM6w@mail.gmail.com>
Subject: Re: Question about (and problem with) pflash data access
To: Guenter Roeck <linux@roeck-us.net>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Feb 2020 at 14:26, Guenter Roeck <linux@roeck-us.net> wrote:
> What really puzzles me is that there is no trace output for
> flash data accesses (trace_pflash_data_read and trace_pflash_data_write),
> meaning the actual flash data access must be handled elsewhere.
> Can someone give me a hint where that might be ?
> Clearly I am missing something about inner workings of qemu.

Probably the device is in 'romd' mode. A QEMU MemoryRegion
can be:
 * RAM (includes ROM for these purposes) -- backed by host
   memory, reads and writes (if permitted) go straight to
   the host memory via fastpath accesses
 * MMIO -- backed by a read and write accessor function,
   all accesses go to these functions
 * "ROM device" -- a mix of the above where there is a
   backing bit of host memory but also accessor functions.
   When the device is in "romd" mode, reads go direct to
   host memory, and writes still go to the accessor function.
   When the device is not in "romd" mode, reads also go
   to the accessor function.

We use this in the pflash devices to make the common case
("just read the flash") fast. When the guest makes a write
to flash that puts it into programming mode, we call
memory_region_rom_device_set_romd(..., false) so we can
intercept reads and make them do the right thing for
programming mode.

thanks
-- PMM

