Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FD6C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 19:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE17F222EA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 19:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yNBhiyi8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE17F222EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUayk-0003Ed-P6
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 15:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUatI-0001Gx-4y
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 15:32:20 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:40759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUatA-0004qH-Qc
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 15:32:15 -0400
Received: by mail-ed1-x542.google.com with SMTP id p13so506802edi.7
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 12:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Uf34+TPp7X6A4oy9aBYdfipDoZufOSNHweGW5LvmJfA=;
 b=yNBhiyi8HrH75EGlhBhwR90/TIs8uiKJVBE5uZHyQeTBXcHoH+/GkWWhku/v2GdIh0
 pl0XzLwWI/P8OPtwv2gtcUTFTaWRmx2RROg1IylJJ9K1UNRreoGj3ZkgOuBxHdCQJ+Kl
 gGyDtrtoCSZUM9I5E8Exvhzk46VnS2W5EhnnqwM0Ljn9CoXM6cb6VqHN14LwuizPM75y
 ksmy9kzmDJHonENvXchDika8TEnOulVOi2k7QfQZ76vxOFLgSQlShf5fk2OQlQPjMckl
 a6VhKYKx0S/9PVIwex8VDdSu7A4i3+yFC307qywc2BFAleVz3H8NNyYJW315pLGOAo6P
 IvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Uf34+TPp7X6A4oy9aBYdfipDoZufOSNHweGW5LvmJfA=;
 b=sBUir80ae/4RVeua+Xn5CUhz51bsz2z5GLR8LSur1jxGkIVH1CxraDQFB/N0E6v0LT
 rI0nNlsv+ICIjHYcnxzbL3zP7IVBm3teIans0MS0hy0Nfl6JwoV1cuG4OJR8Uz+utOsU
 n7lqfdBWyFB22QG/NBtseNAvOPSEfHe3A0tjZonz+UpUTJkWu7lQTar7UlyxIo5aY8zm
 YQq3JYNUUK4s1UO6RFSHiHH2YOJVeOXrOgEkBlInFUNEDX3/IU4s//0OCCl09PziuCFK
 wYsek+bO59ReaMw8BngJWZFW7pRo3b1SCdIsbU1x2nNvAZRe1K952/xLtIZFr42B6jnU
 FQdw==
X-Gm-Message-State: AOAM533vD2oJLG8IECeUAndZM08p+kXECb3YKqQlDVQrjopilLmT4Tqp
 I/gv4ZNnUuXQCfPABtKsX+vHb6rDtVs9n7YvX4QkAQ==
X-Google-Smtp-Source: ABdhPJwY0ytyWvX3eE0w0rAz0Pahs5l4PtfMixYS5C//byG7ApDUWHKyOw1Y/4BjohGNhTlHxr1tJ/KrBntE8dCYB1A=
X-Received: by 2002:aa7:c683:: with SMTP id n3mr1426520edq.146.1603135929335; 
 Mon, 19 Oct 2020 12:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201010135759.437903-1-luc@lmichel.fr>
 <CAFEAcA-F5WCv6We3V=kCV8vH79ko=KGHYWKLaxNVEd9HjFES3Q@mail.gmail.com>
In-Reply-To: <CAFEAcA-F5WCv6We3V=kCV8vH79ko=KGHYWKLaxNVEd9HjFES3Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2020 20:31:58 +0100
Message-ID: <CAFEAcA9fHTO2f_KdCnFvqhEOwTzOwtMf=EhKY=9S_5twpabaCg@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] raspi: add the bcm2835 cprman clock manager
To: Luc Michel <luc@lmichel.fr>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Oct 2020 at 16:45, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Sat, 10 Oct 2020 at 14:57, Luc Michel <luc@lmichel.fr> wrote:
> >
> > v2 -> v3:
> >   - patch 03: moved clock_new definition to hw/core/clock.c [Phil]
> >   - patch 03: commit message typo [Clement]
> >   - patch 10: clarifications around the CM_CTL/CM_DIBV mux registers.
> >               reg_cm replaced with reg_ctl and reg_div. Add some
> >               comments for clarity. [Phil]
> >   - patch 10: fixed update_mux_from_cm not matching the CM_DIV offset
> >               correctly. [Phil]
> >   - patch 11: replaced manual bitfield extraction with extract32 [Phil]
> >   - patch 11: added a visual representation of CM_DIV for clarity [Phil]
> >   - patch 11: added a missing return in clock_mux_update.
>
>
>
> Applied to target-arm.next, thanks.

Dropped again due to segv in 'make check' when running with
clang sanitizer, which I gather from irc that you're looking
into.

thanks
-- PMM

