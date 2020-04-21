Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D407C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3918F20B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GzTIjz8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3918F20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQocI-0003Bb-BT
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 04:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQoaq-0001l4-Vs
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:49:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQoaq-0002gz-BB
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:49:24 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:32989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQoap-0002fC-US
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:49:23 -0400
Received: by mail-io1-xd43.google.com with SMTP id o127so14214529iof.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 01:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KkKS5mxEUyNUQ/UWF5Jwi+aCUCM7nLh10h+Dr7G6SXU=;
 b=GzTIjz8zoJFVvPYtvvxqWDhHHfKCbAkC9FSRDM9/tVEfctLpTCqvCCtJkqDxvayHf/
 ZL1EsC6K15t1YMtFK3t9d/srxuU+spu01BqUEJOgs4ERSGDcmIQn5/gYckYFBguKcbAV
 OCs+TFRQoWB2WXLEPFbQFo+KEspE6+6+8JwmS8g67HgrxisTBQ581bnURDz3JaukkUXx
 dWEB/Z14l5hpHzMvnNQDUEKzcObyo0iIR21htMO7xZ0ZoqWGu5Rk3LCxnuiAedFcgeDl
 HpSivTw/QL29pOc/UkdBlribn7hgHPRAKMTWtxn8t6as6k/QTmk7Z9Eujo8YHLIaggNB
 jBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KkKS5mxEUyNUQ/UWF5Jwi+aCUCM7nLh10h+Dr7G6SXU=;
 b=HD9g9a1xKrYxG0uBgeNiBD6HN/LtDXCAtHvWBED3Vjclkz73S1RHHbyJKTI4+2yP0R
 agc+UU8jdNJUPAnS7fNpHWAXXylZoGIdBquZC7K2Km+WQ/dKFV3YVEdcVbnEV5x12aO2
 pgkBoMTz/D+T89QewWr3UoOWmSwGlDherHzDB3mJ2vnbRllSf0DCewJ2Ws2I8EE130jQ
 6OCyUAGMxJvCdrs3lZfE959X/opZxtQG/WsyKl5J2He58oi6iBdSgnCU8Ox74O5y4raM
 tyJij3HIkkMj9lEC/5sODktuRnUXoljHbREf9f6j5gm9wrW7K3BsR5CeDWbHI6omLOSF
 1nfQ==
X-Gm-Message-State: AGi0PuYVDpbZEPF9xIaaZaecSuFXg25DvLm79ThmlWuuY7htp3FioL8i
 MB3OLBvGllA1dtI5EHOvjbDWtbWtyo1/DEO5CLYjww==
X-Google-Smtp-Source: APiQypL/e8fmdSVEfnVx4xbmrEKFYN9dCLPItqmuNSFSi5mZydL19G8dpJxuKoVnomICDp/JoMGO67X9qpKMkbf+Le4=
X-Received: by 2002:a5d:8d0e:: with SMTP id p14mr19909898ioj.0.1587458962835; 
 Tue, 21 Apr 2020 01:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200420212206.12776-1-peter.maydell@linaro.org>
 <20200420212206.12776-4-peter.maydell@linaro.org> <20200421074400.GE2669@toto>
In-Reply-To: <20200421074400.GE2669@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Apr 2020 09:49:11 +0100
Message-ID: <CAFEAcA85vOwzaLr7jwfqk=NELhn+Smkrm+vQD4BP6TE+khMbXw@mail.gmail.com>
Subject: Re: [PATCH 3/4] linux-user/arm: Handle invalid arm-specific syscalls
 correctly
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=peter.maydell@linaro.org; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d43
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
Cc: omerg681@gmail.com, qemu-arm <qemu-arm@nongnu.org>,
 Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Apr 2020 at 08:42, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> On Mon, Apr 20, 2020 at 10:22:05PM +0100, Peter Maydell wrote:
> > +                                if (env->thumb) {
> > +                                    info._sifields._sigfault._addr -= 2;
> > +                                } else {
> > +                                    info._sifields._sigfault._addr -= 2;
> > +                                }
>
>
> Am I missing some detail or are both branches of the if-else doing the
> same thing?

Oops, yes: cut-n-paste error; as Philippe says, the not-thumb branch
should be "-= 4".

thanks
-- PMM

