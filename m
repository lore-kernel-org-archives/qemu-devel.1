Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2E6C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B608D205ED
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d+squ87/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B608D205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51348 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU6CQ-0000Td-1b
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 05:09:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU6BZ-0000Bp-UF
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU6BZ-0007xK-00
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:08:21 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hU6BY-0007wn-Pb
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:08:20 -0400
Received: by mail-oi1-x242.google.com with SMTP id u199so6499555oie.5
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 02:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=fB4Mx1+ciujWx737rFsuAYwMzrj1DN17Thp/F78Hnjc=;
	b=d+squ87/oI0uVVahDHP6UGzMXCXMhgPZZcDo3lVXzeXUKSHBkQhc7gqWzihqo9vOQy
	CdgX6zR6DifJEB+vf61aGhD4gh3pjN/pnahyKTvjQWfAdRzfOTpjHqbQQG/bkMktFaVp
	oWdn/FYmS4jPv8RbWG9Betj4zgRTJFRn2F9hb8Wbn0tjO5TauhiOmLa/pn7sCcvh8+Tq
	TctxiuJGuhmN+OnrJMgEv+EMTx6LdVEBzpYwedKNLMLLhNtznxp7PAlxH/NTLuN4Hwep
	sBLq4Ew6yYq1c0EyYNmvCukIEtsgg+E/rtyVPuSFE2csK8qrl20iJk7W3VyNwXv7P5ca
	hzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=fB4Mx1+ciujWx737rFsuAYwMzrj1DN17Thp/F78Hnjc=;
	b=CV3e4cu2fnSD4OEDA3mLkAfNu+AgTFvVC3OD84QpFGFRFxiDKEhf98Z8TK9SNg4XMh
	Q2aA5KCZWi7D3S07sa0b3tw4CgjH65/4R09agFvUAgzfaZm1cXP8tmA5qwc+DeCUoKRj
	sxOYn6sXmK53opz9ovLDfyd8RBETOVCckeaRZoUJwkqRYjIomdsMHyfDE6B5CKmBtGEm
	HXEussySRvuxf250+i6ZZ8J3S/XmbNpW3d9qJyUmjQ6lvWhnlphE+TJAVLk8WQzZa1P4
	UKWawffteUxVuD689cooPM+TdWp6Ho5vh+LkBHsdhRaF+jriEg11C74BaQ+aClHNv7a7
	66vw==
X-Gm-Message-State: APjAAAU3Bt3SrOXBFkVJio2MBZw2PaAmtYg3FcA0IxnzUtWQlzlBln3q
	a5GGMNLti9uTS/ucq7aRKuu/lm47lo1uiAkwuJznlQ==
X-Google-Smtp-Source: APXvYqxHbexWzTRLmkrsg+gXqQ60yiLxWfsxk2OkwvXCv6kRjRelFNf+AkPIWYQAJhahxwNOdWMgxZbeYGVl2JUIWH8=
X-Received: by 2002:aca:5785:: with SMTP id l127mr5290268oib.48.1558688899862; 
	Fri, 24 May 2019 02:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190520190533.GA28160@Red>
	<20190521232323.GD3621@darkstar.musicnaut.iki.fi>
	<20190522093341.GA32154@Red>
	<20190522181904.GE3621@darkstar.musicnaut.iki.fi>
	<8977e2bb-8d9e-f4fd-4c44-b4f67e0e7314@redhat.com>
	<c2972889-fe60-7614-fb6e-e57ddf780a54@redhat.com>
	<20190523183623.GB5234@darkstar.musicnaut.iki.fi>
In-Reply-To: <20190523183623.GB5234@darkstar.musicnaut.iki.fi>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 May 2019 10:08:09 +0100
Message-ID: <CAFEAcA8C0WN5FwaW2kfWiRm1T8wML_fWXDKqRXP-Lv_P7ysy8A@mail.gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] Running linux on qemu omap
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
Cc: Thomas Huth <thuth@redhat.com>, Tony Lindgren <tony@atomide.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 May 2019 at 19:36, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Cheetah works with serial console. I tried with console on display,
> and it seems to boot up, and the frame buffer window gets correctly
> sized but for some reason it just stays blank.

As a general question, when you're doing these tests are you
using a kernel image that is known to work on real hardware?
One problem we have with some of these older QEMU platforms
is that it turns out that QEMU is only tested with the kernel,
and the kernel support for the platform is only tested with
QEMU, and so you get equal and opposite bugs in QEMU and the
kernel that cancel each other out and don't get noticed...

(On the QEMU side these platforms are all basically orphaned:
if somebody submits patches to fix bugs we'll review them,
but they're unlikely to get a great deal of attention otherwise.
They're also quite near the top of the "maybe we'll just
deprecate and then delete these" list, since we have not
historically had any working guest images to test against.
If there's a real userbase that wants them to continue to
exist that's a different matter, of course.)

thanks
- PMM

