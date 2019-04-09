Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37C1C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 09:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B28420830
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 09:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JDoBgH2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B28420830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38239 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDnO6-00073z-Ve
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 05:49:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDnNH-0006lE-Sr
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDnNG-0003bh-Rr
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:49:03 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDnNG-0003b8-HU
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:49:02 -0400
Received: by mail-oi1-x241.google.com with SMTP id v7so13006863oie.8
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 02:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=K3Z5V+nDpKioAdfZN+7QarnPM3VFUfLkySyfT2Efwu0=;
	b=JDoBgH2H3P81147jCWdsbl7n1c/xocmbk9zGrkxkhREusG2kS2PP0z0tbnBfk67G26
	F4PHCmy6BUcu5LVfnUgL11KLIzZDcs386MeksQNJHyqO61CtqURwEmhxijmUKCwSWJsD
	CF/v/ac8QJM7ser9qHFaRN1jPIlspchvsPwERHb1IGFN9WR9KVKc5Ob7Lnd0Ui5uQraZ
	un1Pe63PIhenkl+WGr4hIyR5kzIYbbOK+Cc+7cSuVFrIfEzO4ZgsxrVXPd2DpyHoSWAp
	+90dkRZQ8IeLlDdpbo7oW9k7/etElDoSwjaHXGCY7IqgUruH2P9kRwliAtcjnJH0LQR8
	UCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=K3Z5V+nDpKioAdfZN+7QarnPM3VFUfLkySyfT2Efwu0=;
	b=UPNDDWjKsQox9X6bjcMEbGIWtWBgVlrTXGDHBLcJWLgC4qCl3q7B9J22SueLfovZfR
	P5/CxXE0AOPL8A1L82VO8NFkWMvDZjodNGg9FUT0pY9aweC5xSQpdGRVm5ShTYX5kGZd
	2ZvDGuBzDcTdApAN2XvYyxjzeXD8EDfTSODzkqy8daa8VoOjhEB9b4tZezx3iNiAwQHg
	LBHZfSOboeS22/oBAfA+n4hdNCUemqObUILDwbDV4HNFoq5h8fjBBAU2zVRat4hHbojU
	MJ7M1uMnFnavAfLSbb9ZmwsGFYDke01bbXYf3hGD1VLePCYKWZ+Ve79qHsO5L47kDYhu
	0XrA==
X-Gm-Message-State: APjAAAWfU/Hqb87Nzxp1azvdnBrVqbXqzobSCdegFtLK8e0jkpnJfcvx
	7N4LH0PFhbsLDxRb7E+NYSOjv6qdA0++ufwY/5UYcQ==
X-Google-Smtp-Source: APXvYqx6AyDiVS2iw6nCiSAsISyC3x1heEZBPCe82pTdgRLRjs9C7xznH1V6JaMN99kXn6qynLGsWQ4Gm544J3vZ73A=
X-Received: by 2002:aca:b3c2:: with SMTP id c185mr19802917oif.98.1554803341118;
	Tue, 09 Apr 2019 02:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
	<87mukziv48.fsf@dusky.pond.sub.org>
In-Reply-To: <87mukziv48.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 10:48:50 +0100
Message-ID:
 <CAFEAcA9LYR4RnvxX=YB6LgmHMbFsUxm1wjTRq_9JFVwJzZw=kg@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Jason Wang <jasowang@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
	Lidong Chen <lidong.chen@oracle.com>, darren.kenny@oracle.com,
	Gerd Hoffmann <kraxel@redhat.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Aurelien Jarno <aurelien@aurel32.net>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409094850.kLFE9jZkQtvdzuuYGGOQhU-muluFBoRQTofgEAZgdAg@z>

On Tue, 9 Apr 2019 at 06:51, Markus Armbruster <armbru@redhat.com> wrote:
> $ git-grep '<= ARRAY_SIZE'

Almost all of these are OK because they're the pattern of
checking a loop upper bound before doing a loop.

> hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <= ARRAY_SIZE(cs->ich_apr[0]));
> hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <= ARRAY_SIZE(cs->ich_apr[0]));

These are OK -- we're checking that the upper bound of
a loop (i = 0; i < aprmax; i++) is not greater than the worst
possible upper bound imposed by the array size.

> hw/net/stellaris_enet.c:        if (s->tx_fifo_len + 4 <= ARRAY_SIZE(s->tx_fifo)) {

This is OK, because we're checking that we can
store to the 4 entries starting at s->tx_fifo[s->tx_fifo_len].

> hw/sd/pxa2xx_mmci.c:        && s->tx_len <= ARRAY_SIZE(s->tx_fifo)
> hw/sd/pxa2xx_mmci.c:        && s->rx_len <= ARRAY_SIZE(s->rx_fifo)
> hw/sd/pxa2xx_mmci.c:        && s->resp_len <= ARRAY_SIZE(s->resp_fifo);

These are OK beacuse they're checking the number of bytes
held in the array, not an index.

> hw/sd/sd.c:    assert(state <= ARRAY_SIZE(state_name));
> hw/sd/sd.c:    assert(rsp <= ARRAY_SIZE(response_name));

These are bugs, as Philippe says.

> hw/usb/hcd-xhci.c:    assert(n <= ARRAY_SIZE(tmp));

This is another check of a loop upper bound, so it's OK.

> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {

OK, as Aleksandar has said.

> target/ppc/kvm.c:           <= ARRAY_SIZE(hw_debug_points));

Loop upper bound check, OK.

> target/ppc/kvm.c:           <= ARRAY_SIZE(hw_debug_points));

Ditto.

> target/ppc/kvm.c:    assert((nb_hw_breakpoint + nb_hw_watchpoint) <= ARRAY_SIZE(dbg->arch.bp));

Ditto.

> tcg/tcg.c:    tcg_debug_assert(pi <= ARRAY_SIZE(op->args));

This is doing a check after a series of "op->args[pi++]" actions,
so the sense of the test is correct and the question is just
whether it would be better to do the assert before every
array access (which would be pretty expensive and in any
case wouldn't affect production systems where tcg_debug_assert()
is a no-op.)

> util/main-loop.c:    g_assert(n_poll_fds <= ARRAY_SIZE(poll_fds));

This one seems to be doing an incorrect check, because
we are about to do accesses to poll_fds[n_poll_fds + i]
for i in [0, w->num), so the assert should be checking
"n_poll_fds + w->num <= ARRAY_SIZE(poll_fds)" I think.

> util/module.c:    assert(n_dirs <= ARRAY_SIZE(dirs));

Loop upper bound check, OK.

thanks
-- PMM

