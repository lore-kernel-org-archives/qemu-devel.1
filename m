Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA5EC33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 10:15:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD89D20678
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 10:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xMaFR1V1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD89D20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqwl6-0007fX-UC
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 05:15:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iqwkO-00079I-KV
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 05:15:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iqwkN-00054P-DI
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 05:15:00 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39364)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iqwkN-00053L-7I
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 05:14:59 -0500
Received: by mail-oi1-x244.google.com with SMTP id a67so7726936oib.6
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 02:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PMegUXs6T3N3bWEvV7aKC2ycNG7aRMU5M68hG92ENW8=;
 b=xMaFR1V14JAO0CEA6GUPe25y6Nd3uU+aUMnrGyXBKV4b+jg4aL9xZzfKPtAFmDSWTh
 e6oGhdDZYSnwM1Nm282By1w7+BnFKvRf2LdkoROhZDG6Ozl9N51DYzGxLgEYwSvwyJJl
 knQ7ZpXEiduhfCfyTCGRmNftLIezsEVDPmsspAHAyBCUqgIjJ0BUvV7vvEt08Mw7nlBC
 fvnfqZPUcZJ/W3SK8gohpJDZ5NxMCe9K4YmKV5L4V/2oX1XsytF43/v8k4RLV0qSszEq
 wMZA9tmcAJfDyAL8Ex0NtehQxadln2ytZjvSBsROQHmrGl6hoLEUljsAWUBKjrQVhnsv
 3UxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PMegUXs6T3N3bWEvV7aKC2ycNG7aRMU5M68hG92ENW8=;
 b=PTfNVEXEBbA2+eugWMdx4XrbbY0EFrWiCb1xBvgSI24MSt0b1BZajEu93iqJcIPYh/
 Rb7atYvrY97CA/K1Puu2WpDiU3PT7dOtMNGHZ9H4TTOK/K7pt5tbE06/M/+N/taS1uep
 /ApBEmMXslhazzYc022HiqpRMvoWAJA0nwYU99AxTagcJ0oargeHmEio1/U8UxUfK+Tm
 MMSJKPaogdilaoNZfQv+WNQKK01xI9rD2UpWzX7B0qxe7LgcLS0aAMqezVDVYmFrMG36
 YXWJO2qEzjJNw3DuzfJOtZk247753dtcsz+TO1GVFoUl8nfTSGUdU95KS8MYSigwd1V/
 v6LQ==
X-Gm-Message-State: APjAAAWq/HSqOwvLbMQRwzJWEsYmZ+2Xk5KNLqLiDpEs3ZSNSmNE3s7R
 u+OkHzAVKN54SxUWcV53n6Ls8D+xW4gyBfRvAHaTtQ==
X-Google-Smtp-Source: APXvYqyd6R6wvJEFyTKWlS20FXHn3iYSo/NHVZRAgyPL9R9CF5a+nPWeoSaQsn0C00U+U1spB8s7VmNQMwohw/zuZBQ=
X-Received: by 2002:aca:d78b:: with SMTP id
 o133mr12313461oig.163.1578910498023; 
 Mon, 13 Jan 2020 02:14:58 -0800 (PST)
MIME-Version: 1.0
References: <157709434917.12933.4351155074716553976.stgit@pasha-Precision-3630-Tower>
 <003a01d5c6b3$df62afd0$9e280f70$@ru> <20200109120038.GD9504@linux.fritz.box>
 <87k15v1z71.fsf@dusky.pond.sub.org> <000f01d5c9f4$cfbc1230$6f343690$@ru>
 <20200113100648.GB5549@linux.fritz.box>
In-Reply-To: <20200113100648.GB5549@linux.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jan 2020 10:14:47 +0000
Message-ID: <CAFEAcA8_snB=+i06Vna7t+E_5=ynPAr_KnLAABXrX5A=ntWOjg@mail.gmail.com>
Subject: Re: [for-5.0 PATCH 00/11] Support for reverse debugging with GDB
To: Kevin Wolf <kwolf@redhat.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Artem Pisarenko <artem.k.pisarenko@gmail.com>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Ciro Santilli <ciro.santilli@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Thomas Dullien <thomas.dullien@googlemail.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>, maria.klimushenkova@ispras.ru,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Gerd Hoffmann <kraxel@redhat.com>,
 Pavel Dovgaluk <pavel.dovgaluk@ispras.ru>, Igor R <boost.lists@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jan 2020 at 10:07, Kevin Wolf <kwolf@redhat.com> wrote:
> In MAINTAINERS, you are listed yourself as the maintainer for
> record/replay. I wonder whether you shouldn't just be sending pull
> requests after getting Acked-by or Reviewed-by from the maintainers of
> other subsystems you touch.

Ideally somebody else should be interested enough in record/replay
to review patches. "I'm a subsystem maintainer and send pull
requests" ideally shouldn't be something we give out just because
patches aren't getting code review, though I know that it
does sometimes degenerate into that...

thanks
-- PMM

