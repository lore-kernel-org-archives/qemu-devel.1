Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A722C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 14:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 261D72171F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 14:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k1rL3WvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261D72171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw5bd-0002NC-FR
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 10:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37512)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hw5bG-0001yi-Px
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 10:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hw5bF-0006PE-SV
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 10:10:34 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44580)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hw5bF-0006Os-N8
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 10:10:33 -0400
Received: by mail-ot1-x341.google.com with SMTP id b7so82806964otl.11
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 07:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HWEjUnf0BBmT8RQ1A6LFXtofsCQr7i/VNcYjR50FUdw=;
 b=k1rL3WvVDzYse272wuVCOcefDIsmcVYCNnhQOykLn7V+Oc9xJyyKgQYZnkJoY8FeSn
 xalvqy07qNHhetHZm1BVEULzQiLudij7JBk854k1odO0+6wEybSMef5U6uFamlRC5ZNa
 1HKEzdKgvklS0RdPfR5s68NwKXINIipDL9Mhk2oRJ2zgXD2iiXY64yRa8cPsL8vPDwsP
 wMd/xlg6W984NmB6My/JjYcWsE34ODBDiX5A4Y9QjFkRdVpg5Dv70CgX+QOf9vXg0GMU
 05ffb52OBc89VjVkE3YmmLL8bbMm3uAkyHhZ8/5R1cr6pzOOe/jk5W7nIjuU0Uk5a9kr
 Vjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HWEjUnf0BBmT8RQ1A6LFXtofsCQr7i/VNcYjR50FUdw=;
 b=B+ukVcN5nIE6TqyLS8j8JkmLGCl3CWewqFooir53Rn1ft38AaVH0cgSMI3LXh7ab/R
 iToPirdX+8Nm6y+ICWe89z5c3En5pW7Q5ZLNBIDrY+YRV423gzK1UfvdRwX7MwaUjmEp
 5u//rlXH7OBgZQDJG9JQKBsx2hpbZ4k3IdjyBwamf/25wPdPe9c0pVmnxmZZe0JenKLL
 5dvcYZ8Gkt9NniXTpFcnPCtrS/8qbpFke/6pptFu7RXh7gT56Gvgy3OzBsSLHGj07KKE
 fmzPAqdlhd6LC/z3lfukfTdeInnSe4Oyy2Aybm+mwb8SG/vNaAl+rj/ed0awYuePaUsa
 Fcug==
X-Gm-Message-State: APjAAAV6sonAd55LWidejrbgxtJGNvzdXXHrr3ZJsgCwt9b7Wa/IiO6v
 JJFpU+UlOGtF89oNUDaO0TJG6G29rbgP0/fMRYzV9w==
X-Google-Smtp-Source: APXvYqy74Xd5crY/LRMhwU5vqbjUY2jZ5PXNz2dM1nShNRGZqtF1oChT9tMhULzW3SGP7Gx5tBtglEX5KglHPwZKEQ8=
X-Received: by 2002:aca:4bcc:: with SMTP id y195mr5841699oia.146.1565359832581; 
 Fri, 09 Aug 2019 07:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <87r25vd5y1.fsf@dusky.pond.sub.org>
 <CAFEAcA-3X0s-mxaD27HWQa7ysiEb6Uo-BD+Yxo0QhBV_yb9WLA@mail.gmail.com>
 <CAFEAcA-e2aW33GeuganVSnu9epuqt57rnZ_KgEHwDNqrWrTHuA@mail.gmail.com>
In-Reply-To: <CAFEAcA-e2aW33GeuganVSnu9epuqt57rnZ_KgEHwDNqrWrTHuA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Aug 2019 15:10:21 +0100
Message-ID: <CAFEAcA-jhnMWwE6GCNarioSzr6PuJg_BVCanpppAteb=fLB3nA@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] Does i386-linux-user build on an i686 host?
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <Laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 9 Aug 2019 at 13:49, Peter Maydell <peter.maydell@linaro.org> wrote:
> Easy fix: uninstall oss4-dev.
>
> Better fix: patch QEMU to provide its own versions of these constants
> if the system headers don't.
>
> Utopian fix: I've wondered occasionally whether for cases like this
> where the constant is known to be the same for the host and the guest
> we should have some sort of approach which lets us use the QEMU
> copies of the linux kernel headers rather than having to rely on
> the host system, which might have an older version that restricts
> us unnecessarily on what we could support...

I missed out this other option:

Make The World A Better Place fix:

Report bug and/or provide patch to the oss4-dev headers to
augment them to provide all the ioctl numbers and other
constants that the kernel's version does, so they really
are interoperable with the header they're diverting.

thanks
-- PMM

