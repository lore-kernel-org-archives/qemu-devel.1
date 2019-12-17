Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31398C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:18:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFE4F206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h9Fc7tZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE4F206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihHQf-00030W-5o
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 13:18:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ihHQ0-0002aG-Nl
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:18:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ihHPz-0004Bb-Pz
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:18:00 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35061)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ihHPz-0004BK-L5
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:17:59 -0500
Received: by mail-oi1-x243.google.com with SMTP id k4so1764935oik.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 10:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qlIwL1T3vKUuJdwbGQZhWiwt5TeFlxqC2m+K9m7lAqQ=;
 b=h9Fc7tZ99YviEXkMLvSUkH7xWmcwMcqZYT7Tc5KjpcjG9YB0MItnFTUuLao4zfrVcj
 Pe+9Da6L9PXzrToM9zxz/pYJv1LO4PMjMifxh/uLdMNiTWW1OvsI9mx596PFrznOj8/Y
 YKd9adQZEv/zPIsQkDXNS35k9sva+ULYS37TlaqRRmTt8CeGjKBh0rbuTrCU5ruetMis
 7gXS2D+OQDpXl/5Pc4CQfpiN+wwhKbWCZCb4DGAUwzCM6xS1DAxRDVnipfiySvSMmWwX
 B5znODy4cdMEiB1Gebel3o/kItDQX92ZSgNophdVOrg1GeWUv+ZvTN2Ep9VN9iZRbTVv
 0unQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qlIwL1T3vKUuJdwbGQZhWiwt5TeFlxqC2m+K9m7lAqQ=;
 b=gZfKgKpQ+/JBii4d8xE2BXSBmsS7XAwsTuvtcloeedhGikqifgzZISEVyirPT/RZzJ
 uo7BcnxLTu7FGUtEJdX543erQcUtVyCdXYNS+JPUOukjRk89A1VcvkPn2cZos0UKE36i
 7FyIjMUABre6CN0rnyWmW0pMGGybtHigrhqbXZd1myfVo+x/dUiOdiL7/fy+K4gfXMh4
 pUJ7YGh2BqerJ8XCgoiIDOZ2wz+nD6yn/DVuw6K/KNlPaARt+AU7/4PhB8sudlEVxHJZ
 uHhyEFL90ixNPDJq5BJbQRTAmV55C+ia+kHen5GqEss6GuTdXQA6+LcVBmzzD/Z6Tao2
 S7Ug==
X-Gm-Message-State: APjAAAWKXwZXHpR43KPqIkCOwTemVYW/YQyrXJ+9v/x8YtaRo3R0A3lK
 GFcFiJrcy1MEjmggRuCvcx2XjNvo5D0nVG2SYU9bOQ==
X-Google-Smtp-Source: APXvYqxOlsSRsLH9CI7geb3ZZimHuKE92z/GCFMiOmoJ0+E8I+Ily8k90w1N7qGz8gFQ2MxXCcdJ0qEAsb1Q9C/29Dw=
X-Received: by 2002:aca:f484:: with SMTP id s126mr2198088oih.48.1576606678698; 
 Tue, 17 Dec 2019 10:17:58 -0800 (PST)
MIME-Version: 1.0
References: <20191214160223.20012-1-philmd@redhat.com>
 <da81a3e7-62a8-f46e-c12f-4dead2a9091f@redhat.com>
 <92bb8e12-3ece-9811-438b-8fa64d2bde66@redhat.com>
 <4a07cc6f-8762-145e-2b54-c61b0e287f19@redhat.com>
 <127AF076-D309-4952-B572-52587A93F46A@redhat.com>
 <c5c27111-efc5-0a05-bdbd-415533e5bc30@linaro.org>
In-Reply-To: <c5c27111-efc5-0a05-bdbd-415533e5bc30@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2019 18:17:47 +0000
Message-ID: <CAFEAcA955AwoDiuYxm0mJKV1qzyBorAz06dqi0tg2kMBT9GMTA@mail.gmail.com>
Subject: Re: [PATCH] memory: Do not allow subregion out of the parent region
 range
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Dec 2019 at 16:57, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/17/19 1:58 AM, Christophe de Dinechin wrote:
> >
> >
> >> On 17 Dec 2019, at 11:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> Yes, the idea is that you could have for one version of the device
> >>
> >>   parent 0x000-0x7ff
> >>     stuff 0x000-0x3ff
> >>     morestuff 0x400-0x7ff
> >>
> >> and for another
> >>
> >>   parent 0x000-0x3ff
> >>     stuff 0x000-0x3ff
> >>     morestuff 0x400-0x7ff
> >>
> >> where parent is the BAR, and you can share the code to generate the tree
> >> underneath parent.
> >
> > I can see why you would have code reuse reasons to do that,
> > but frankly it looks buggy and confusing. In the rare cases
> > where this is indented, maybe add a flag making it explicit?
>
> The guest OS is programming the BAR, producing a configuration that, while it
> doesn't make sense, is also legal per PCI.  QEMU cannot abort for this
> configuration.

Does guest programming of the PCI BAR size actually change the size
of the 'parent' region, or does it just result in the creation
of an appropriately sized alias into 'parent' ?

thanks
-- PMM

