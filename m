Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F77C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 14:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F080C20850
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 14:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAYoT2Gu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F080C20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37891 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEwwc-0004j7-Tf
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 10:14:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEwvl-0004L3-Om
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 10:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEwvh-0004xf-D9
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 10:13:22 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:34366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEwvh-0004vm-4V
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 10:13:21 -0400
Received: by mail-oi1-x22f.google.com with SMTP id v10so8076175oib.1
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 07:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=JcFdkz3OomT3s0WksD79wpmBlehqbTgG/2YPrQwbvbA=;
	b=YAYoT2GuK2mgfJt9lnYfx8S5wOBOI/KNz/VC0us4y5zA0KKUM8SupDSxvqcNRMFvgq
	xpncFi/8awSuF7r8ER/PhDiJr1mF4qnjc7XbuFqNfgik1c31xOaRaj/gI9gUWs5+UDdU
	5wEY1zpvZgziKY0uvdRnuovIzLwFAPejpc7SNDDg79o8a5cKEukNRQ0ldiT5fJKWlEYZ
	+wiEcOeNAQzInZCh75o9U341GWPLEMTqbx+ntqvmy2KX2FALx6Yg0Ntkd1lbFq2JLCvQ
	333nGTa+bNnyqn8n9VAuHrgWaxIObHgxAGVVyzWmpEKQ7KC7sN/FkisypyRUlJprqrM8
	6QvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=JcFdkz3OomT3s0WksD79wpmBlehqbTgG/2YPrQwbvbA=;
	b=Y7SozpuMdN9FIS51XmxdGl2J5pSQr6MAGIbwDnOtqgwaxxaIYcLUASiGf+Zdr6Ln3Q
	0z/ZGMJRC+GYD/jk599f+W2epPTDgoSkRBwneON1CTK8cczlTzJuNdOq/9VL4oTXG1sR
	j+IVq/xorZ+mNxyzjrmMMrDhPF5b+S0LZkLrWOKEAuFdiRFEr+pW97gRMevR5Nq4qMOP
	5//F2l2YUgkONxp8vRs+Knw4iflF4C0FHnG0sDdGBPOZXsOa7ktzYS2MC1ldGIGecrVK
	uzc0u9NGvHeq41MGZK4d6qhrOKO6TKAjtNj395+34avIRtZ2e8aeDF8A/TjZ58pOayE3
	CNJw==
X-Gm-Message-State: APjAAAVncLBNmDa+thoEUV4bna+cDg6uDX3f0weyTBH5SoG9/TcABGng
	7qFad3q+ELl1CeoNWmHqm/5VrF49WkdzX9/IL9NTcQ==
X-Google-Smtp-Source: APXvYqxMFUXf+GBBAoaFGrgudGmDKbClNebX0Gg3KJ+kfocRhj4HwbfQ7mGENP8FtVONOoaSbGla7ZFTcCB4hP+TlrQ=
X-Received: by 2002:aca:c7d3:: with SMTP id x202mr9515492oif.48.1555078399817; 
	Fri, 12 Apr 2019 07:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190409210655.777-1-jsnow@redhat.com>
In-Reply-To: <20190409210655.777-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Apr 2019 15:13:08 +0100
Message-ID:
 <CAFEAcA8_V6p3BPZ8VKOCFzBoKKU-S2bsBamOXxy3CJGnwFWA1g@mail.gmail.com>
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22f
Subject: Re: [Qemu-devel] [PATCH] qemu-img: fix .hx and .texi disparity
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
	Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412141308.s5vA1eO-mXppliZ7TQnMxCU4oJwY5V62FGl4XoBIp0E@z>

On Tue, 9 Apr 2019 at 22:08, John Snow <jsnow@redhat.com> wrote:
>
> It turns out that having options listed in three places continues to be
> a bad idea. I'm still toying with the idea of an improved infrastructure
> here, but in the meantime, another bandaid.
>
> There are three locations:
> (1) .hx file, formatted as texi
> (2) .hx file, formatted as human readable.
> (3) .texi file, as section headers, formatted as texi.
>
> You can compare the two summaries within the .hx file like so:
>
> Human-readable command summaries:
> `./qemu-img --help | grep 'Command syntax' -A14`
> Detokenized texi command summaries:
> `grep "@item" qemu-img-cmds.hx | sed -E 's|@var\{([^\}]*?)\}|\1|g'`
>
> You can compare the two separate texi summaries like so:
>
> Texi command summaries:
> `grep "@item" qemu-img-cmds.hx"`
> Texi command headers:
> grep -E "@item.*@var" qemu-img.texi | tail -14
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qemu-img.texi    | 4 ++--
>  qemu-img-cmds.hx | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied to master for rc4, since we needed an rc4 anyway and
this is a safe docs change.

thanks
-- PMM

