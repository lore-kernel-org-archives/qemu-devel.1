Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986A6C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:20:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DAD22173B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wg0pOapB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DAD22173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho3Wf-0003AW-7s
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 06:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57089)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1ho3WU-0002dQ-RF
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ho3WT-0001Aj-Na
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:20:26 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:36355)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ho3WT-00019R-HP
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:20:25 -0400
Received: by mail-ot1-x330.google.com with SMTP id r6so28430579oti.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 03:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lh7qhoD5/8sJDOswGOfMo7jETiZHnVcxZpWe8vlvJTM=;
 b=Wg0pOapBd0qUuwqDZg3I9CDgeeJLdRWyRBqhcnpOcBhEWlTkDX7Fp4wnd+g6a+NgGW
 xkv9IbKbQrwKtQm3HSIytWXBw1RbjsrXChRfRWXzYTMUSmD3Z3oIQQ5nn68odm+HtCji
 TgUQs3VSb0KdSrRap4D1s0VdsImsRSo8+Kc+Y2PUWTdUqkqAjSzIYJeFr/ba8tSk/L8F
 sdt1gUUMwMrE21T0Yx5t4y2mBjwB/CPXNcSyoomumaBsInf4kYrLoPwpklYrvMmkAnQM
 xwCry6HG+OTi5hghuBcjchmekLGg2HpoOzbqPt0RLpr8LyuoS/UTVBETEJbeI9OBGzW4
 SwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lh7qhoD5/8sJDOswGOfMo7jETiZHnVcxZpWe8vlvJTM=;
 b=IXL3hG2fBN01biHqo+e72cAFgUBgigPGibphIeEhiN2Bb+tu+lz8C2+Hi4PAKS09nH
 La/axURbQqVkk38mJv/34WsLhS8ANtkKm2Q/aSGK4LBW5GcMRoDewFOQK8B53Au7Cn8V
 qvh/GThN5phlzZ5xnyD3qIIREJEijpD1iBrPnqY1JFS6tz6YUPvLm/wgdzqtJ/uh7cXr
 DV+Mg3K0pVDbIvXchlUZYObA4yN4Kb57SlMDebRy0SWygzCyB4tZuJzVcFcij4Rm2sRy
 +jzT1ZMZq8h1DUrFTIeKCkSzgEf9QbgRSZEkef477Vu4ebkPdZUC9YlDRJhyd2BAn62q
 IS9A==
X-Gm-Message-State: APjAAAUh6uFRUQfEwi641hqTNZnQR5vTBViVNnMtYO2SiljDeEshX/eF
 A5qRarip8Y8atSDwSs/y6zex3TXvwKvoyAp6y+Znlg==
X-Google-Smtp-Source: APXvYqz6gxR7n+eW/h6Wgo/RreUkkzMVeChK5B4b9lF+M9GqdGzsyflRHVUI8GZnCI2qpe63sQaSvfxvN8TfcgPcqfQ=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr31762241otj.97.1563445224345; 
 Thu, 18 Jul 2019 03:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190717145418.23883-1-laurent@vivier.eu>
In-Reply-To: <20190717145418.23883-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jul 2019 11:20:13 +0100
Message-ID: <CAFEAcA8kMkRuqWt4_tv+ZH5NJ0-kidJ==2A_JdFbPhjYuS+XCQ@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
Subject: Re: [Qemu-devel] [PULL 0/3] Linux user for 4.1 patches
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 17 Jul 2019 at 15:55, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit a1a4d49f60d2b899620ee2be4ebb991c4a90a026:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/pflash-next-20190716' into staging (2019-07-16 17:02:44 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-4.1-pull-request
>
> for you to fetch changes up to ad0bcf5d59f120d546be7a2c3590afc66eea0b01:
>
>   linux-user: check valid address in access_ok() (2019-07-17 09:02:51 +0200)
>
> ----------------------------------------------------------------
> fix access_ok() to allow to run LTP on AARCH64,
> fix SIOCGSTAMP with 5.2 kernel headers,
> fix structure target_ucontext for MIPS
>
> ---------------------------------------------------------------

This causes 'make check-tcg' to produce new warnings from
running the tests (x86-64 host):

  RUN     tests for x86_64
  TEST    test-mmap (default) on x86_64
ERROR: ioctl(IOCGSTAMP_NEW): target=0x80108906 host=0x8906
ERROR: ioctl(IOCGSTAMPNS_NEW): target=0x80108907 host=0x8907
  TEST    sha1 on x86_64
ERROR: ioctl(IOCGSTAMP_NEW): target=0x80108906 host=0x8906
ERROR: ioctl(IOCGSTAMPNS_NEW): target=0x80108907 host=0x8907
  TEST    linux-test on x86_64
ERROR: ioctl(IOCGSTAMP_NEW): target=0x80108906 host=0x8906
ERROR: ioctl(IOCGSTAMPNS_NEW): target=0x80108907 host=0x8907
  TEST    testthread on x86_64
ERROR: ioctl(IOCGSTAMP_NEW): target=0x80108906 host=0x8906
ERROR: ioctl(IOCGSTAMPNS_NEW): target=0x80108907 host=0x8907
  TEST    test-x86_64 on x86_64
ERROR: ioctl(IOCGSTAMP_NEW): target=0x80108906 host=0x8906
ERROR: ioctl(IOCGSTAMPNS_NEW): target=0x80108907 host=0x8907
  TEST    test-mmap (4096 byte pages) on x86_64
ERROR: ioctl(IOCGSTAMP_NEW): target=0x80108906 host=0x8906
ERROR: ioctl(IOCGSTAMPNS_NEW): target=0x80108907 host=0x8907

thanks
-- PMM

