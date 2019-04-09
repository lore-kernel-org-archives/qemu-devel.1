Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA01C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 12:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD45720857
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 12:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wZY/eXcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD45720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40300 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDpq1-0001gX-On
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 08:26:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDppA-0001NZ-Fv
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 08:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDpp9-0004LI-F9
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 08:26:00 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDpp8-0004L0-Sr
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 08:25:59 -0400
Received: by mail-ot1-x343.google.com with SMTP id s24so10153553otk.13
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 05:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=1o0cRCF659cDhxF1tOlzvQzKpfPnyIH0VtEYKyLTTlI=;
	b=wZY/eXcOZOCiVWu+zM9w1LjSkhlvMvEcceP9wlqRcFQ0sAV3lyVY3kzIdZcIjCKjiZ
	eHr2N5VzZX5winQekw/rE3HGKyz78JtF5RgJ7vFSOUJ+ljNyn0z6M3dOC3Di9A/3jF0p
	SXUGNWpMA8icXYZd3EZQDZRzrC1OLKfEyw3HIV8VwVLoHLukcAu1M0bd5Qjn3RpHMcb5
	oAL47Ar0utkzamqKICk1hS9NGlojzJCnAWT3zYcSgs7bsYkujsg6n89KCkQRW81lYZk7
	8jZhjiIi5Cahs+Un19y9OGNqr/gsg/I239lMFlkUl9qMI8gcQVr5xugSEeyhU62L4jKY
	bgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=1o0cRCF659cDhxF1tOlzvQzKpfPnyIH0VtEYKyLTTlI=;
	b=Ldzq/XWjfXqopU+qNsY7TId9KsSQrIYjg+OtPIGAeD9TzuAL8baHgYkYSJINq6TBfC
	okiCPi9sikBMdhUzkABrgUOjZPLRFAac14iC8vVPjeSj1PJUeenGgMM4MdJRYK51n6Nq
	AbE6bnhrRwIgEfRlx+zEVNAW6PY7hGnU68mXNcvF3OLpOhGPV4/vnFUnaTW4sSjB3LOc
	NDjL6DyxhiXaTZz9c5e1VHPCl5jFFIlJqlHU3tQBHxX6TAn/Lq/wVfb6IcSCjjjTA73U
	3q3MgvkKJ9fAhV/2u+npYnShRsvP1++RtOoGLCzjNZmOm/zJACf0WkZEJbE9oBxtCRFi
	826A==
X-Gm-Message-State: APjAAAWW2jkw+rJjpswgpqsu2sEj/F7WaAyw00aRShTIXTkUUg3o2MDN
	vTVRZ+DYIwUp4nAnsm9PaZ8kbGJlIT6pOvpvv1/PlA==
X-Google-Smtp-Source: APXvYqxqUAz0Fyiv7i9hCOOLBqwnmU4M9Ly6Bo6YQBixutMQF5WSUx1jPv383MIxOsBgp1u9YHI/WCkY8246MjuP8lI=
X-Received: by 2002:a05:6830:1cb:: with SMTP id
	r11mr18850332ota.302.1554812757876; 
	Tue, 09 Apr 2019 05:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190318112938.8298-1-peter.maydell@linaro.org>
	<6201d9df-07d2-6ed2-64b6-17d436111c13@redhat.com>
In-Reply-To: <6201d9df-07d2-6ed2-64b6-17d436111c13@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 13:25:47 +0100
Message-ID:
 <CAFEAcA8caDyfuCzMTw5zTCe=qTaA7TvEqF6ePNS1+WUM5FP8YA@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH for-4.0] include/qemu/bswap.h: Use
 __builtin_memcpy() in accessor functions
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
Cc: =?UTF-8?Q?Fernando_Casas_Sch=C3=B6ssow?= <casasfernando@outlook.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"patches@linaro.org" <patches@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409122547.Zq6KCUZTYM-8KNBxicyw0XCFI3WKX30gGtcb2E7UInM@z>

On Mon, 18 Mar 2019 at 17:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 18/03/19 12:29, Peter Maydell wrote:
> > In the accessor functions ld*_he_p() and st*_he_p() we use memcpy()
> > to perform a load or store to a pointer which might not be aligned
> > for the size of the type. We rely on the compiler to optimize this
> > memcpy() into an efficient load or store instruction where possible.
> > This is required for good performance, but at the moment it is also
> > required for correct operation, because some users of these functions
> > require that the access is atomic if the pointer is aligned, which
> > will only be the case if the compiler has optimized out the memcpy().
> > (The particular example where we discovered this is the virtio
> > vring_avail_idx() which calls virtio_lduw_phys_cached() which
> > eventually ends up calling lduw_he_p().)
> >
> > Unfortunately some compile environments, such as the fortify-source
> > setup used in Alpine Linux, define memcpy() to a wrapper function
> > in a way that inhibits this compiler optimization.
> >
> > The correct long-term fix here is to add a set of functions for
> > doing atomic accesses into AddressSpaces (and to other relevant
> > families of accessor functions like the virtio_*_phys_cached()
> > ones), and make sure that callsites which want atomic behaviour
> > use the correct functions.
> >
> > In the meantime, switch to using __builtin_memcpy() in the
> > bswap.h accessor functions. This will make us robust against things
> > like this fortify library in the short term. In the longer term
> > it will mean that we don't end up with these functions being really
> > badly-performing even if the semantics of the out-of-line memcpy()
> > are correct.
> >
> > Reported-by: Fernando Casas Sch=C3=B6ssow <casasfernando@outlook.com>
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>


> Queued, thanks.

Ping? This hasn't hit master yet, and today is the last day
for rc3 which I'm hoping might be the last rc for 4.0...

thanks
-- PMM

