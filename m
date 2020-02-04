Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5EDC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABA5021741
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DNefLlAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA5021741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyvMZ-0004hl-Sd
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:23:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyvLy-0004Cf-Nn
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:22:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyvLx-0005vt-Oc
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:22:46 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43305)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyvLx-0005uL-IW
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:22:45 -0500
Received: by mail-oi1-x244.google.com with SMTP id p125so17883329oif.10
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 02:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Vib72RK1mz4kVITADDK2FtUXi807Li9E+4tBGQjWb7A=;
 b=DNefLlAWwhN19RdzfL8iKSltIh/MPRMexpZtus9Eh2id9neJUq97bZHGBEvIYDrMxU
 2F0dPW8LGEyFPmzlsnPgWjtZ00JVgGB2gOfslw3JmOH3zZlw9w4xcgwfd8HAKo8oMGKR
 de46S2gvKHljzqLpsMrVahaZhAwpZO7jn+ZMEhFpkCKGK+DTh2W8/QuRfcVqTHJbqiX3
 w5yUrsrWd3EmWNtocXaHhv91AcsrK7wXqmtY5gA+Ae8Y/v08XyIPBMigUBC6ek1zDC8Q
 3Z5/vmYk4nhJSDdUDPmOczUbd/Km20zcOYvumsmX8jgH6JtJO3nREXvg6+0wXFJzk3wC
 p2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Vib72RK1mz4kVITADDK2FtUXi807Li9E+4tBGQjWb7A=;
 b=tqrnsFtMl3ysFKg/29TU015yP7oyqz/LAxoSf7AMCicd0UbO/nGrXWeM4NlrGnxKQh
 JK/pnzlqtIflTcngnoSfCorj3nwQtcYZrKedefPiLl2RvP7Q6T5wYoDzFpDodT2OuelN
 5DrpCVtxXG6QuSzg5dlaOFcdNFYQ92y/ESADfEvhKd0TKo1ksJVwXl71ZoiL0pA8PyiX
 yFW1/+PHZRKcPvHcI10GRDsM/32xqD+yE14Uu35LlO5ban+vdhXgoSBePbKIix9Gly/A
 o3UFAfJ0w0F2S5qFrcRyczCkG+EL9Pu4UerXzMuAbdsF8rHYbJ4xnCQcrDmAqmy48C+6
 7sOQ==
X-Gm-Message-State: APjAAAX4dRSW9uYbHjsAxm23XuL504MD8zmpmrDDoP5tJqKlBtG7rQI/
 tz87fzAa1RfO85uARKZCiPu++J69J5uxdRGHm9Z9Ag==
X-Google-Smtp-Source: APXvYqzjv3HIsJgJj3po0pnc3SJV9O/chPGgbQxs/F6ts+DcocB6d9dQt3PynhmErONMxZ8sDpd5o8jTwSdN9Y/SAqo=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr2989706oif.163.1580811764753; 
 Tue, 04 Feb 2020 02:22:44 -0800 (PST)
MIME-Version: 1.0
References: <20191219040612.28431-1-gshan@redhat.com>
 <d972631d-7db7-b6d5-61b8-244ae2c85882@redhat.com>
 <7f6e29e6-1df9-4513-79ba-b53873b0735e@ozlabs.ru>
 <544f261e4b9c97f1d3a5fb64cef42ba5@kernel.org>
 <ff584722-1b51-e538-7c45-c71cdc40105f@redhat.com>
 <c61c95c434dbcf97a0c946f0993d4843@kernel.org>
 <8a286e1c-c3f3-3052-e497-d44a90667451@redhat.com>
In-Reply-To: <8a286e1c-c3f3-3052-e497-d44a90667451@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2020 10:22:33 +0000
Message-ID: <CAFEAcA-wKbF7mYToaAsxDxahuJ_X3_i3Z+8DqXmj8mKySmTW7Q@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/arm/virt: Support NMI injection
To: Gavin Shan <gshan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Andrew Jones <drjones@redhat.com>, jthierry@redhat.com,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Marc Zyngier <maz@kernel.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Shan Gavin <shan.gavin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 4 Feb 2020 at 03:51, Gavin Shan <gshan@redhat.com> wrote:
> Note: I'm still investigating the code to see how SError can be injected when TCG
> is used. I think we need same function when TCG is enabled, or it's something for
> future.

TCG doesn't currently implement SError -- it could be added, but
there's a bit of plumbing you'd need to do to get it to work and to
ensure the exception is taken, routed and masked correctly.

thanks
-- PMM

