Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2542AC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE6320989
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bHYaYhPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE6320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiNvX-0000k6-Q7
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 14:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60009)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiMSM-00010a-LG
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:20:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiMSL-0004xK-Gv
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:20:38 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiMSL-0004jm-CK
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:20:37 -0400
Received: by mail-oi1-x241.google.com with SMTP id m202so13712490oig.6
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 10:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V9h45vlbeX/4Q/JZn8RMlDz+jJjvbOyIR9R5fc5UK6s=;
 b=bHYaYhPHZZpjtG3X6ZXuqqOTJPBeFV5JUbzOunshNeINUKoIUon3lR8gZzrHiBz2O1
 9FvLJLXPpfb2zUzuFnfndqfJzzdE+K+t46Sdj5Kz36r6NpBZt78zgV147ZyYo5c4WyWv
 ipyj7aOxThUsQgkkpjmKU6bYNaJieFlLY08ivsgqXQsh0s04+q/7PO9gk1yeMCeu/b2e
 lljRpUs12J65XHm1ozUmUZffRUsJJB3oUoqlJV4/NDLs3k5f7PCSuW5vY8vB222/nUAV
 H+qbO4PnpFFOGP/UTfY1efqPctcumRzDgHVGxOPJv6e0+PhUBkadrImVgDR3XHjFAYwT
 4Q5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V9h45vlbeX/4Q/JZn8RMlDz+jJjvbOyIR9R5fc5UK6s=;
 b=MsOzDQWhK7CGqkP4NuBIBGsHqbWX8WWqnZWDv9e1W/H8hqieB6n+Feep/rLMylrPBW
 h6TX0TQv1AVWSpMLZ7fe/WG5olgQaNJCSroQ1Xsqck/tHl6x2gFMDL+bgweTmgcMlBww
 rbYcHyBgzdPoqKsECJjd61dgitp8V37+FniYj1xonWWPP5cLDg0AbulbnagcahypBnyk
 w91zNxRp7ZZUeRl+kaJXf7OUFFhGgkhJcY03Z9k3CL6i5S2+G3F65keT2QtEnevoKUXb
 0JCARi8MUP7pEuQgPrk4KJSoR5Hne9uKB68iyHBs1zXGwiIcHT4DNJ+MBRowmJrRdl8A
 wybQ==
X-Gm-Message-State: APjAAAVPEtW2wrBNnDOXqyM2Aw9DcmakseJkLlZ5GcfF8yyD4+6ToW7L
 WFigyeeWUFxpvVEAN0fEX+sht+mk09J5mC9iOKZz9g==
X-Google-Smtp-Source: APXvYqwIpUGvN41jCmcrgHHgw7mkGJwSND9hGQ2L2Yv/sVXPUIeZFC5yLUQd97/4LnRQkyEgT711m0Pa/5QYyk2haw0=
X-Received: by 2002:aca:6185:: with SMTP id v127mr3898048oib.163.1562088012463; 
 Tue, 02 Jul 2019 10:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190702150606.24851-1-mst@redhat.com>
 <CAFEAcA-Qcq1ZmfDO_dkh_H9-aeQVU83ceLKU1NXM3VpW8g5sPQ@mail.gmail.com>
 <20190702124823-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190702124823-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 18:20:01 +0100
Message-ID: <CAFEAcA-UFks7CmtcMT15KzK3TzRqGjwXWtFa8K6XZ=Bks92CJw@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PULL 00/22] virtio, pc, pci: features, fixes,
 cleanups
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

On Tue, 2 Jul 2019 at 18:01, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jul 02, 2019 at 04:56:05PM +0100, Peter Maydell wrote:
> > On Tue, 2 Jul 2019 at 16:06, Michael S. Tsirkin <mst@redhat.com> wrote:
> > Hi. This header sync doesn't look like it was a proper
> > sync made with the update-headers script against some
> > upstream kernel -- at least the commit message doesn't
> > say what the sync was against and the fact that it only
> > changes the virtio-pmem headers looks suspicious.
> >
> > Can you respin with a proper header sync against upstream
> > mainline, please?

> This isn't from mainline. We have a bit of a deadlock with linux merge
> window opening soon. I think it's reasonable temporarily
> and then before release either virtio-pmem gets there or I will
> revert it and drop the header.

It's definitely not ideal: until the headers are actually
upstream there's no guarantee that they won't change ABI.
Are the headers at least in some kvm-next or equivalent tree ?
When are they expected to hit mainline?

thanks
-- PMM

