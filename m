Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B22C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:51:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF9E020715
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="noBhZxxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF9E020715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j02Ae-0005dR-Td
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 06:51:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j029r-0004l6-BJ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:50:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j029q-0002YN-4c
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:50:51 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:46550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j029p-0002Vx-VP
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:50:50 -0500
Received: by mail-oi1-x233.google.com with SMTP id a22so1652782oid.13
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 03:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=yBI6Qc5CrBGCBQ4nAtP3MGuMbQswIKfO60FEpzmU++M=;
 b=noBhZxxv8bW6v9p37XNXvSSnOFnVUU3S3sXlAtPJXlukp8EV8FR0TzAKvx45pgh8M1
 PdqUkZrKkjWVfp9AzW1lCXyxZt8Ay9dTD9wDfwsNkgHOIyN/FFV6za6LflQ1irTQCmYS
 9vYQosJaBhhr08r56Avs/MxR9bgUEwu72YnqCfUKMwyh/QLJ6uPDUSmPx8XcgqcM3kpc
 dXcuyPnvqE7Kfp1IEDN49bDIJcBxM3YIlAqokZXa7C7RKcM2FFRJlTvvpTI8F79UzSoB
 VwcvdLysJiZf5RtDFILFmej0f6XleGRkYGsHtR8ToOsbjDaQNZ24L+GDbCW1pUALMXop
 oraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=yBI6Qc5CrBGCBQ4nAtP3MGuMbQswIKfO60FEpzmU++M=;
 b=eepZn8cZ8y9re888NMofZPybR26pAeQLuMLckd2q80HpDJJdCJ48Y3JcNMR8qELTLM
 nreZa3w4ozUFSrYkcFCsJ61T7+NlTJrbuPuIo2eU5IF8Ls9/kFytn632Q+5IBPUf1WeH
 y2/lEFSxSe86ck7VpVFwDZGIqkXKvz/UShFg05UYKajdaWgzvIW9MLFkMQm03T+mIa3q
 osG+IyDp8lB+1a8e4K87fP+ERgLJhr3mp439+6/RW7I3lqIQz027rm/QBI+WqrSIVGP0
 DH80hNlceAreT7lRJYddNjNi89gIuFw214766/JIGtfUxXQFpSCNUwIVJ6TVsVj3CHwa
 BIgA==
X-Gm-Message-State: APjAAAU8YDviI1RmWW5c8yBG58Wz8wWANPh6oHeUUwAmf2jG6Uww1DlL
 VvIXrsE4GnkRY73ZSeWCLs5ROHPZ184cxEgq+Z4axguD
X-Google-Smtp-Source: APXvYqzvkBBhhjRsMBk3ZXYFicVwVO0kRgen5Jz9NIjS1kYEBnDLEbYHY+p5/xrnk7v2+EsyaDab840KHLMLzrNizWA=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr1852245oiy.170.1581076248726; 
 Fri, 07 Feb 2020 03:50:48 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 11:50:37 +0000
Message-ID: <CAFEAcA--P9FLM4qBxf23sLuv5Tz4HRgj7ONC7ODxnfZiLph9TA@mail.gmail.com>
Subject: should we have a new 'tools' manual?
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::233
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

So far we've been converting docs to Sphinx and assigning them
to manuals according to the division originally set out by
Paolo on the wiki: https://wiki.qemu.org/Features/Documentation

 * QEMU User-mode Emulation User's Guide (docs/user)
 * QEMU System Emulation User's Guide (docs/system)
 * QEMU System Emulation Management and Interoperability Guide (docs/interop)
 * QEMU System Emulation Guest Hardware Specifications (docs/specs)
 * QEMU Developer's Guide (docs/devel, not shipped to end-users)

but some of our documentation has always been a bit of an awkward
fit into this classification:
 * qemu-img
 * qemu-nbd
 * virtfs-proxy-helper
etc. I've tended to put these things into interop/.

The proposal from Dan and David was that we should add a sixth
top-level manual
 * QEMU Tools Guide (docs/tools)

which would be a more coherent place for these to live.

This seems like a good idea to me -- do people agree? What's
our definition of a "tool", or do we just know one when we see it?
What in particular should go in tools/ ?

thanks
-- PMM

