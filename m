Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371BBC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 16:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91F3218AE
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 16:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zQTzjQCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91F3218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWjs4-0002i7-7n
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 11:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWjr7-0001j3-2x
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 11:26:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWjr5-0001KG-C2
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 11:26:24 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34878)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWjr5-0001Jj-67
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 11:26:23 -0500
Received: by mail-oi1-x242.google.com with SMTP id n16so15868826oig.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 08:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XIkGnW1aRZhqvnzNNKG7aAGx1vjkLpHYjgJTUtfIq7s=;
 b=zQTzjQCfPHL8cSUxxFIptzbn+pteWPqD0rc+uq29QAZYKZPTkbtvDpErjq0Rbh8nMJ
 KaN+cWOFwgrPfxUbtf1Tdt/TcQOCnSwLhJi8a5PBv0Gxz5Zy0oZB2I+qBfPmoWmfIV22
 XIoHho33pfS88oEBvJNsAWOOKQHtec4YjYiZElC9WAi05TDkz5P0x49FGjj/4oiUVfou
 msBMJCdeRZyTelz4RCkWBKL/EPI11T6mAK8p1162UrwtCJiXP4tZAZrJcLMdMfIMlc1n
 j/viMZkl0niBfC/pDIqzdcxKdgZ4Su6OC+gJqsrEStfjzto/l1FwBOosJ5C1tItX9o2N
 84FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XIkGnW1aRZhqvnzNNKG7aAGx1vjkLpHYjgJTUtfIq7s=;
 b=jnvWv7lCQeXkyHvMaA00T7zXGByvMKRufNG+goefXZkA5mq77fX34qf8A29BWgXaat
 14doxwtzds3WjCudf4ZOoGahHswaXTxYmJL0lwIsRgxeJe2fNsNOcDk1B0xOCXIkISOc
 UTKeWL0F8T0liFyYiEjfkDbJ4slUCnEc9uokm6XXGuDAK7NzKc8MnCJWl9Sjp1Ze+AnG
 HiPdu/3dUIZL5aSX+fUz3UFz2WCVMoaO9rsHq0dnKlKtZzOcc2QxLNZYaL6znk6tn3VR
 r9EJdLQtMBisM0ijeJY7Clsm8yfl5p3IQDEzM5KSMkdZ9Zgdrxb04UNzIdTSl2vUYKLk
 RzlA==
X-Gm-Message-State: APjAAAW2s4+1nyIE8twKnzv+Aq3HGI4oI3uBTK6CnqagnpQLOEPmXKOl
 wILzJ7gH0d5uXurmDtYoIuKhY5YkC5oykND1J5Qd/A==
X-Google-Smtp-Source: APXvYqzMMBcq8p0iHwjVeLutW1NH6INXLSoD0KnncDtLz0IsKh7lZ9N4dlh16MXdp/8uyPbx4f2H2JcenB8O3lUr3cA=
X-Received: by 2002:aca:cf12:: with SMTP id f18mr19906448oig.48.1574094381951; 
 Mon, 18 Nov 2019 08:26:21 -0800 (PST)
MIME-Version: 1.0
References: <20191017044232.27601-1-richard.henderson@linaro.org>
In-Reply-To: <20191017044232.27601-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 16:26:10 +0000
Message-ID: <CAFEAcA-36SCWn+FNgNiB_JbOJvYxpHa9S-gOVFH__xgGm2+cXQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] target/arm vector improvements
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Oct 2019 at 05:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The first patch has been seen before.
>
>   https://patchwork.ozlabs.org/patch/1115039/
>
> It had a bug and I didn't fix it right away and then forgot.
> Fixed now; I had mixed up the operand ordering for aarch32.

Since Alex had a nit on patch 1 I'm going to assume you'll
respin this series once we're reopen for 5.0 development.

> The comment in patch 2 about ARMv8.4-DIT is perhaps a stretch,
> but re-reading the pmull instruction description in the current
> ARM ARM brought it to mind.
>
> Since TCG is officially not in the security domain, it's
> probably not a bug to just claim to support DIT without
> actually doing anything to ensure the algorithms used are in
> fact timing independent of the data.
>
> On the other hand, I expect the bit distribution of stuff
> going through these sort of hashing algorithms to approach
> 50% 1's and 0's, so I also don't think we gain anything on
> average to terminate the loop early.
>
> Thoughts on DIT specifically?

I think we have two plausible choices for DIT:
 (1) don't implement it, since we can't make the timing
     guarantees it suggests
 (2) implement it but not actually change our behaviour:
     this is technically a lie to the guest, but it means
     that guest OS handling of the PSTATE.DIT bit etc can
     be tested

At the moment we by default do (1). I think we should
probably postpone doing (2) until somebody actually
asks us for it.

thanks
-- PMM

