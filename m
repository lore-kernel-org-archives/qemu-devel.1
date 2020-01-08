Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CB7C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 17:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7232067D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 17:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8AqVgcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7232067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipFa9-0004aR-Q2
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 12:57:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ipFZG-0003e6-Ue
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 12:56:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ipFZF-0007d8-Vv
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 12:56:30 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ipFZF-0007c8-QM
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 12:56:29 -0500
Received: by mail-oi1-x244.google.com with SMTP id c77so3415774oib.7
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 09:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bxkJc4vC7HxNDXfNhuedGfCpneYHA71ixPp7hsDXqgs=;
 b=e8AqVgczCU0W992xRNPT7I1509gmTq89T8xvXwIQfejKcUTPlFzddpsv5kt6i9RoU/
 CyoSQoXaKARuUeKAfE5qnc7AlID2JRwasI4dakTMYinwvYPDr0ltOqQIivRxUrPrt0FR
 /nb/4KXmca+ixcBUSeyIbc5emIHtLvifONe7OXeBq70fRSNe0GloWDLj/kiPUeEmrWq8
 BNYFwKBVSssKyVzI72AeR0ty1l2d5l52ZlHyBRM+EPHn0Hg8Keg8vnmb6Qb4djVwlkxB
 HRF0xhgvWI+8GXGDMSKRE950alqexMfig2N6vbE1ar2fH2Ev9E3ol6Vt70/v+jtrUusr
 XRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bxkJc4vC7HxNDXfNhuedGfCpneYHA71ixPp7hsDXqgs=;
 b=AYM9Wb/PLFw8/2OCPMJBFSKmjCM07cO5NUtuzMciQJMNWqmOiKVUeqUBkicv//oPmk
 XGM60TS0lUJrHr/4rGQ485FSOgfGG7pLvVDzxn2kvWLRkuHa4fjMoyLkgYAmTCPeeHdh
 6BPjfnfkGjW+DUoomDGYveAoitp8bBei2hTlAWVWReGgO/EYvwVZNCDvuq94vW0sg9Z3
 Cx64gwCtNGRUw+yy4TWtr8Syx4DfnCox0i3Wg9xB/v77+3vDhdQin0kBTCMjSLxWUgF2
 Ug9/XUDOEnZm4S9QEHLUM6FNJn8MCBexf29A/xNXRgJHFRk63Bz9UMZZ9gxOtVfN/UvY
 4gzg==
X-Gm-Message-State: APjAAAUUrnm4Xm82pwZN/kTg0FvXIm2cWro8gBSWoR7jYeRdmL2nZxDB
 t+9nrRjiEJ3GonscOnF3GroQzXz+TbbIIU1fxq5tng==
X-Google-Smtp-Source: APXvYqwTySZ5Rin1rPyQMDoFnyzcBfgj8CH2rU7iW69nad3lkdCX9sPa2knUE7wXZDTbLlG4PdSRbkYVt2y0BJLLK2s=
X-Received: by 2002:aca:f484:: with SMTP id s126mr3916553oih.48.1578506189060; 
 Wed, 08 Jan 2020 09:56:29 -0800 (PST)
MIME-Version: 1.0
References: <157833123209.15024.12557979334447840996.malonedeb@wampee.canonical.com>
 <157850256701.5510.8747112724719044821.malone@gac.canonical.com>
In-Reply-To: <157850256701.5510.8747112724719044821.malone@gac.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Jan 2020 17:56:17 +0000
Message-ID: <CAFEAcA-X5L0j6esqjowx0n=xBdxyuK4XDB_MLUEn2tHya19pOw@mail.gmail.com>
Subject: Re: [Bug 1858461] Re: Please refactor linux-user/mips/cpu_loop.c
To: Bug 1858461 <1858461@bugs.launchpad.net>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 Jan 2020 at 17:06, puchuu <1858461@bugs.launchpad.net> wrote:
> I think about the following development flow:
>
> 1. Kernel updates and maintains "tbl".
> 2. Qemu developer wants to implement new syscall (like clone3) in "linux-user/syscall.c".
> 3. Developer clones new kernel into some directory and runs generators.
> 4. All syscall related stuff will be updated immediately.

That seems like quite a lot of effort, given that we don't really
have to update the set of syscall number #defines very often.
At the moment it's just "somebody submits a patch which
updates the list of #defines every so often". (And if you want
to actually implement a new syscall then the the actual
implementation is the bulk of the work anyhow.)

In particular if you really want to proceed down the path of
suggesting scripts for doing the update then I think we would
want something that works for all our architectures, not just MIPS.

thanks
-- PMM

