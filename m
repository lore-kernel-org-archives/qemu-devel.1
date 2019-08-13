Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8BDC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:01:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 355E5205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YFuaIXKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355E5205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWQz-00043m-E3
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 09:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55650)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hxWPT-0002Pr-NQ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hxWPP-00015f-Ua
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:00:17 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36409)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hxWPO-0000vo-OV
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:00:15 -0400
Received: by mail-ot1-x341.google.com with SMTP id k18so39879159otr.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 06:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SD3PU5S1bg8AfupUXQScTw0ujoqLYw+MEu0wWMAtd8w=;
 b=YFuaIXKIxsZSHMkmP9+R7mvSo3nGVD4vANc5asjXTxrhqwRpk7dvETViYpKzC2D2pl
 4B4KhsBCEKSqyRjRhsoR8qmehoqeH6NQ9ODso+BtGM28hSih2dDgQv6DJWsRzVEGiE12
 pcKHm2e86PzMyTMeMgHo6yyWCN54845T1llwwY2x+AK0HTqP3DLdqw74rroA0yEZRvFA
 dh8iLf+/H1k+yxPYix/cM5y0PqqSocb+ujr3WHLjNV+1GKMG0jcECyXwfN2EjAM4Nt0l
 ORMJeL5jOurNyPnwncopAkiI0c6gxjwFmbQZbwCbcPgJO4HteOsUERe6hnPagTmecf6k
 nckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SD3PU5S1bg8AfupUXQScTw0ujoqLYw+MEu0wWMAtd8w=;
 b=c+XNFGCf0WtMKzWcWH9nmkGTD0t1VaPFD5D1uZLB+1EXmR5O0GJzgu/8rFNZpi0Kcv
 Weps/CV0s9fL6XVPHAxrWOqt5fhtVmggx6w8iXnAhTk4+Yob0iTLw/3MbND0xtp93w+T
 H3hsmL/M+fM4nKoOe9TMRAIzG1H9tuZzfoW5i4R07Ri4tCvstthhwm7d7NP1gzXsUuTw
 nLNom1vQS20SiipgTZMzw6AVkkLFSZoji8OXesAOC3nWbUo4S7WzDhp1oBKn0CEQmWt9
 N5/tCOqD909dGTdcuZJOjH26qFzKelvK/Tw9RjK+UzjTdorUDGF9TbZ6wFCIYVn+Oiwu
 hMkA==
X-Gm-Message-State: APjAAAWoJD2n35RVTv4mi3GzHsTp95QMJYlEnUZwJt6xqJdxJaO5ukmy
 eGi5ZFl0/kf+oX6F2Jx6t/4nxhIlK5230O7jI6hWWQ==
X-Google-Smtp-Source: APXvYqwNsREV+X2QIy5JwHGjXSn70VVyCSgWmtwNhXj6Cq1Nk6DojSdQ3tIyzfrJidIz00kMpZuy3JzDWZfiGk4bXEM=
X-Received: by 2002:aca:4a57:: with SMTP id x84mr1467802oia.170.1565701212317; 
 Tue, 13 Aug 2019 06:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <1564812484-20385-1-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKPW-nMc2zV-VwG_sY9ca7uSenUJW+mEcV2qaKT5dELmgA@mail.gmail.com>
 <CAEUhbmWwkMR4xKu9v=10ePj=feJ7b7e5Ko75zv1xMBf+JrVwwA@mail.gmail.com>
 <CAFEAcA91uvheC1gdu7DZSkaVtgA3Laoob6G+bQMQOdfsQj9aSA@mail.gmail.com>
In-Reply-To: <CAFEAcA91uvheC1gdu7DZSkaVtgA3Laoob6G+bQMQOdfsQj9aSA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Aug 2019 14:00:01 +0100
Message-ID: <CAFEAcA-J_QHUX4cnrTgtKLrRmOtBwzEP1fg1HTjWP5geENw50A@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [FOR 4.1 PATCH] riscv: roms: Fix make rules for
 building sifive_u bios
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Alistair Francis <alistair23@gmail.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 12 Aug 2019 at 09:38, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Sun, 11 Aug 2019 at 08:17, Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Hi Palmer,
> >
> > On Tue, Aug 6, 2019 at 1:04 AM Alistair Francis <alistair23@gmail.com> wrote:
> > >
> > > On Fri, Aug 2, 2019 at 11:08 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > >
> > > > Currently the make rules are wrongly using qemu/virt opensbi image
> > > > for sifive_u machine. Correct it.
> > > >
> > > > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > >
> > > Good catch.
> > >
> > > @Palmer Dabbelt can you take this for 4.1?
> > >
> >
> > Is this patch merged for 4.1? Thanks!
>
> Sorry, it doesn't look like it is, and it's now missed the
> deadline for 4.1 (only critical showstopper bugs and security
> issues would go in at this point).

Since a very late ppc pullreq turned up which needed to also go into
rc5 and meant we couldn't just have a single-change rc, I figured this
was safe enough to also apply for rc5, so I've put it in.

thanks
-- PMM

