Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528FAC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE69214DB
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mvs7TwaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE69214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8k1e-0000xv-9G
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:18:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8k0M-0007yT-K3
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:17:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8k0L-0001Ng-Fe
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:17:02 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34991)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8k0L-0001NP-Av
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:17:01 -0500
Received: by mail-ot1-x343.google.com with SMTP id v10so2179624otp.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 04:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aon4dE9H7+TmS7pGG/pcDTA8szPkhUqc8rzDeR3ly/A=;
 b=Mvs7TwaSwOZ/43N7mu8WAkFspbfIO5dS/BqFSO4KUlTv0h9nveMzBLROGWv/s9f6TQ
 JzdrHmQr5htp0aTF4RDKSMtxv8ri9QqpQtbvwyXD/4QbG9uoVteH5z0BNff1u27A1xm3
 kYNN6XXb9s4pWpqghmVQbAA7YoPO5qqJJbSvMf8H0jzvEWUn87sCiRbkorvkTeclQlqD
 kEw/Zvm2IKm/ZGMOpjWuFtwnVZLufHM73T9MLlm+lQufIfI4lMXBURDHgxnHFC5YbDPI
 l2ilPxmtRpwUFR26DDVyGucNbfxi8BEihdeyI+sVoyWVJmRv0VXZlWQnSyr3HTmxnQly
 w9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aon4dE9H7+TmS7pGG/pcDTA8szPkhUqc8rzDeR3ly/A=;
 b=e4NIP8rNvT5s95Dp2jEvyaKV6iLboKjcftFhDHCTk7X61FrjjKX261ZOwiz9sXqfM8
 I3BRHHvw6vZt56jWiCUGI9w9HkZ2PqN/nnwwzcAsY/Jk5nPGMKv9o1yODR4nl3FDNsZQ
 hZAiR4TLp+W7tfms1J3OAvOtn2DVGlOlHrgGN8vNpfq03g+IXBmBO+hAQx1LcdBxivU7
 vcLziN7QC1UyS19Fu4+c8bvzf6pSFT1gKyGOPQ0ufIahMVMTgwzdHW9+/BXR2AAW4gdt
 bciHn5YuXtZ8v2EPA+z2yglW3r/SGRkxTAfdpDPU87vauWSbBdvoxQxZ4XJ3UwK593QD
 mbog==
X-Gm-Message-State: APjAAAV6kAFhmlblvKM6If1oISGoI/t3bUVQiNMvVyoaO1XYEW71BKhG
 X3mO+FkORo0WeITAFB8/xMt+331GRg2nJdjwGSUO4Q==
X-Google-Smtp-Source: APXvYqxb+VSGj7yX4xmz44nJs52J+vJWr84y+kJ/OvqndTE1BxhuAJS1oYvkOn9TC2t1pHAXI+FI83VEuewK/iC8zYc=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr12279365otq.221.1583151417584; 
 Mon, 02 Mar 2020 04:16:57 -0800 (PST)
MIME-Version: 1.0
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-6-peter.maydell@linaro.org> <87wo83atnf.fsf@linaro.org>
In-Reply-To: <87wo83atnf.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 12:16:46 +0000
Message-ID: <CAFEAcA-WYXtkkCshv_eDV5Rj8ER4yfDmf5V=HaT-Jo5cSJr0vA@mail.gmail.com>
Subject: Re: [PATCH v3 05/33] qemu-doc: split qemu-doc.texi in multiple files
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Mar 2020 at 11:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > From: Paolo Bonzini <pbonzini@redhat.com>
> >
> > In order to facilitate the reorganization of qemu-doc.texi content,
> > as well as the conversion to rST/Sphinx, split it in multiple .texi
> > files that are included from docs/system.
> >
> > The "other devices" section is renamed to ivshmem and placed last.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > Message-id: 20200226113034.6741-6-pbonzini@redhat.com
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  Makefile                         |   16 +
> >  docs/system/build-platforms.texi |   67 ++
> >  docs/system/gdb.texi             |   71 ++
>
> The gdb test would be better served in docs/core if we could have
> optional sections on invocation rendering depending on if it's built
> with system emulation or linux-user docs. Is that something that's
> already supported?

No, for three reasons:

(1) we build all the docs, always -- there's no concept
of "skip some bits of docs if some configure feature was
disabled"

(2) there is no docs/core -- the subdirectories of docs/
correspond to the "manuals" which we want to present to
the user, like "Manual for system emulation users" and
"Manual for user-mode users" and "Manual for the
standalone tools"; a "core" manual wouldn't fit into this
classification, and we already have slightly more manuals
than I'm entirely comfortable with.

(3) Sphinx's support for conditional documentation is
not very good, as it is implemented at the "wrong"
end of the pipeline (ie it's not like a preprocessor
ifdef, but instead is just "suppress the output", so
manual pieces inside a disabled ifdef still turn up
in places like the index and table of contents). The
best you can do is to mess around with the include
directive, but if we do that too much then things get
awkward to understand and maintain. (We do it a bit
in this series to handle "manpage vs manual" stuff.)

thanks
-- PMM

