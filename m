Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60D1C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 19:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926442084D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 19:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKCmbhMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926442084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQc6l-0006ZT-O8
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 15:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jQc4z-000567-Oq
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jQc4y-0001j2-VV
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:27:41 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:41245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jQc4y-0001hj-Ji; Mon, 20 Apr 2020 15:27:40 -0400
Received: by mail-io1-xd41.google.com with SMTP id b12so12364689ion.8;
 Mon, 20 Apr 2020 12:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=F5ZSCC3CcIMAv8iVmzGMsndOutHrsQnmUxVOd4frLwE=;
 b=BKCmbhMvB4BIyTx5EfzpHmmhPs3crxcYOpULrnGowUGFr3CYC8pcnQhWJirvGlxHXN
 Fyzw6CmvBCkxBd6H14QWyJuFIHd30PbF5RPwPFppvXFu/vbOujDbiqUK6lHq9kjLjAkm
 xu03MtLMkA/EDUb0XtfnYah5wDWozf5aGTx838sQgtcqiLGkiNEaV0HI3ApNXcul8cjj
 H/u3nz5qxy/vamtQh2Q/rS1m0RrDQUmL4co+ea/c3Jx2eD3LNsGoRAYRRvyDvjz3qmR+
 Ojwppx7Va/zokoyCMAP37NhJd4a8V4/G6xSuKaXcaQ186l+17ii2AgEsCCbVGQqj389+
 94Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F5ZSCC3CcIMAv8iVmzGMsndOutHrsQnmUxVOd4frLwE=;
 b=GctIn5D1utDoYyYFCEbkuQ3UGdRQI/GrJvGCKXnTCWdR1GSS00oIg15Mj/rd9QBTiO
 iTOQ78Jc0jFwdLyL3gUABzwD9Qyip5KkXQTd5XFLOWVfvI22UPcjLQ1uA1+7b5M0ofFZ
 IEeY592srqIkb0oE50anh68fiEjA4t7BM5HC99P08vYkf2cWUIiFY5XmZR+5vzPAevJU
 /9zJFIJnxacNS4OiWH1fJ2amqpwyvhJUaU0S1Qp5mytp6snF38MwrHmLRNtYw+E/6x4G
 wwj0JImXOv+uXt9vMV+gNGn0s9BjdlAOwRjlShBd+mhJQrq2A9bauJX+vhRw/Am/58/l
 frPw==
X-Gm-Message-State: AGi0PubHiygcDkpvMNfmclkFMGHNmBN4afZ8LJ9n+GySj1LLCi0Pntmw
 pS/z17WpguT5DO8PCxzTh/NN5ThmZrx/2sEcq97eJ8E4S5U=
X-Google-Smtp-Source: APiQypKNmUVpPa3HCl81ND0ZEM8wBTTSaYZ2UjD2WnV0aSoJ8GW1LhR15SO5kwTcCZozLPyoSAVG2Odv6zNtwRTeNoo=
X-Received: by 2002:a05:6602:d:: with SMTP id
 b13mr17306741ioa.176.1587410858790; 
 Mon, 20 Apr 2020 12:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <1583585319-26603-1-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKPEptmsw222Tt1T1qvoSvfhgMMznypEM+wr8hWYkcW0qg@mail.gmail.com>
 <CAEUhbmU+w___MiNS7kCd-b9C4rKz_OMUCMFFeroo9ew5bayYrw@mail.gmail.com>
In-Reply-To: <CAEUhbmU+w___MiNS7kCd-b9C4rKz_OMUCMFFeroo9ew5bayYrw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 Apr 2020 12:19:11 -0700
Message-ID: <CAKmqyKMU1485WcBsaaW2EhNyNmTaK+QCSiSDQg9JkD6CxmBwGw@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv: Generate correct "mmu-type" for 32-bit machines
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d41
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Apr 5, 2020 at 6:28 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Palmer,
>
> On Tue, Mar 10, 2020 at 1:22 AM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Sat, Mar 7, 2020 at 4:49 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > 32-bit machine should have its CPU's "mmu-type" set to "riscv,sv32".
> > >
> > > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> >
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> >
>
> Ping? Could you please take this for v5.0.0?

Applied to the RISC-V tree for 5.1

Alistair

>
> Regards,
> Bin

