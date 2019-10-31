Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4843CA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 15:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C4AA2083E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 15:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PyR7GHat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4AA2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQC17-0005iS-0t
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 11:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iQBou-0007rU-Qv
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iQBot-0007wc-AR
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:53:04 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:40644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iQBot-0007wG-3n
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:53:03 -0400
Received: by mail-oi1-x22e.google.com with SMTP id r27so5389834oij.7
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 07:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=glftck85+2W/7oPVEHYEBPdHm45NBxk94s2BUNFuF1o=;
 b=PyR7GHatCIbdRSu3YbYoUvq3dkgBMelvQjhRbSCJ1glYahSzDpi4gH8TuGRWZtXXMq
 6GnmxSQQkUcorqRjXDflDPcVkLvdTjMLxhdDpDLSB5oj9zPN80NHkMkRjPoJfk5nuHqV
 CyRzw1a4j/OJIx01Inb/274VpcB4pKJsPOIdyAtim8Cxhwpl9OHdhSU8KepX9xN9b3BR
 3Yr9Aw12cKQ3rhEhRyYijVMoBrynAr/0AQZzwWXOWA0C7N4jrYbD5BVTigesNYdUeLDs
 qwVeHAgwrCACVMZGGRMbgvHnrfsECfilJhfOkVpzkqT1g9lkXBg+PFA7rosZO+lMbYNz
 mxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=glftck85+2W/7oPVEHYEBPdHm45NBxk94s2BUNFuF1o=;
 b=f2wf56GCwJRY8zb2/LvZkqvt2j49M9EkZgBnO2Rkfr4CE4jXTbtNUvzhySGS8KVqIw
 JwtUZD2jYI9aZFKLSkGfbDoyRYnIKBiTjcR3XXYPKjKwIcowzePfZbsF4kJHhuxPKc0Y
 ER0IgXjBwGvoZ1g1d+ha5PbD9LmYuYS6pqiVNy5bBJXAgLBy1Yzbf1tSy7f1Vcn04QOc
 pkVuxgXAtSk20uyQuScEbUWiB9Vy37KKJDqHN82YNtlaN2HLnQoJUADGjTjynGIgZqxW
 D4AcNCCReayk2H3+vGSN7qS5n3VprVkOdmj20sVquzxU4GwQqGrO1wlXRV1iN57Xv9Ko
 /kiA==
X-Gm-Message-State: APjAAAXx8tSDsFvb93hF1gvMcWiYauTTSGL8mcejC6IxV7HXfQXvEC9+
 2sKQ1cjiQcJp0/5N3wTUHKw8ZqgiSNGGGdbVb+KFgA==
X-Google-Smtp-Source: APXvYqxMIc2pOIQ1+xmxojLeeFuAOF7ApWREAZRlZXa70B7EpEhk12xyepXwfmCZWl2pDaCb7hqdFD4irYh1rp+5Nls=
X-Received: by 2002:aca:3e8a:: with SMTP id l132mr1024277oia.146.1572533582157; 
 Thu, 31 Oct 2019 07:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <c83fe0e7157562c3c17598917977eb4d@hostfission.com>
 <20191030185248.GC3114@work-vm>
 <88f1c3701740665b0ebe2f24c8ce7ade@hostfission.com>
 <20191031132443.GB3128@work-vm>
 <b36330ecd38ce872982df4d41d3d4695@hostfission.com>
In-Reply-To: <b36330ecd38ce872982df4d41d3d4695@hostfission.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Oct 2019 14:52:47 +0000
Message-ID: <CAFEAcA8uWCQY8GwtH4oHU8ybXsvmYaB4Qa5hnxyd+344WFjJ_Q@mail.gmail.com>
Subject: Re: RFC: New device for zero-copy VM memory access
To: geoff@hostfission.com
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 31 Oct 2019 at 14:26, <geoff@hostfission.com> wrote:
> As the author of Looking Glass, I also have to consider the maintenance
> and the complexity of implementing the vhost protocol into the project.
> At this time a complete Porthole client can be implemented in 150 lines
> of C without external dependencies, and most of that is boilerplate
> socket code. This IMO is a major factor in deciding to avoid vhost-user.

This is essentially a proposal that we should make our project and
code more complicated so that your project and code can be simpler.
I hope you can see why this isn't necessarily an argument that will hold
very much weight for us :-)

thanks
-- PMM

