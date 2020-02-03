Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCD2C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:45:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC04820721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W0doTvQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC04820721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyb6L-0006qT-Vb
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyb5X-0005mp-5Q
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:44:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyb5V-0008P0-W5
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:44:27 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39991)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyb5V-0008Ou-QH
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:44:25 -0500
Received: by mail-ot1-x344.google.com with SMTP id i6so13461157otr.7
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 04:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0TACardq4sWGXSfu6cw1G5F/KSy2qsowoO6yA15+Fhs=;
 b=W0doTvQV3yk4NyQVyDTsZ8yyAAaZ0afYBGXB/eYLIg5nPbDOQAsh4bUpa668LgA8RY
 fgbWzAnW+UC45m4UalPlpANXTfo7lB1HMi9SHgjL8hErdk48BdSo9kU6ykI3IRMPz2i1
 WzTr4UMBRIByc3YtRfM4QkK0XnEA60bCj1Mz8ljnkhjgwTTv4CB+BqOv4abAVgqh37f0
 SAMs2yhu6TXKjjbdzAOSOffUWgasv+R7wMIpVcWsoPF8Mz3xZ7f0YJr17r2VyRgJIKTE
 Y5o2L1sJV5hv0VnfBZp1bgCN/9h5hnSve5CsiPTmyxBZPddBBDdjx0GyCPWiTc6y8mWw
 CQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0TACardq4sWGXSfu6cw1G5F/KSy2qsowoO6yA15+Fhs=;
 b=CU9PnLeh9Y+IMillzE8EY4pfSF8mIi0NgeoDsCa5upoqx8mePCF+EyxGc/YJ9TAl3T
 bm6A09Bswwh/Yuc1WyyoTcDNc7IszulFzTUudtsB37Hz0OJG0mS3uSSqPPDg2fyuLyRK
 TSznedHB/CqFMkAeZGZtt+w8Xg9qBc3MoqoJyMMxAFEUD72cB8AWeHt+zPEEqQ8APLGe
 5WWvqEqTyQjcPdp1OIIUU9/qMMjunH2hRJIrHhxKQigRS8nYZnnT6USmAknCK88xOnsw
 sbdtnVnY9+K1WAhUTEq764CYr0fyXU/1CVYdgLFHjYhoeAnl4cLIJm4dwRr9vH2lFSt/
 BVgQ==
X-Gm-Message-State: APjAAAUhA8W2po304+B5fmE1ij5XERXSD1zIl3EBLoK/lU1h+UyVNDUE
 hzXa2cg7pJqqifuiQp9sX0HQk6XWcnls34BFK8gn5A==
X-Google-Smtp-Source: APXvYqzpbuCYe4SZMkwv9t92fyBnVmaOeFbtv4Dr9LEhmp2h/tNYgOSPN7XdCTPfq7KU31UDTEmCxpqblziVdrnA+KQ=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr17718277otq.135.1580733864951; 
 Mon, 03 Feb 2020 04:44:24 -0800 (PST)
MIME-Version: 1.0
References: <20200113103550.1133-1-alex.bennee@linaro.org>
 <2331e0b7-cad9-7b53-3d30-7fb88d692c8a@redhat.com>
 <20200115111042.GA163546@stefanha-x1.localdomain>
 <CAFEAcA9Q5nsD5iTPwsVVx73HPUD6aGKd0Sf2FUkAFqjAZhGMGw@mail.gmail.com>
 <82f0aa8e-b445-ad7f-1b17-03f4bb180a85@redhat.com>
 <CAFEAcA8pHXeqtC3WT67vwC=g4Vw7BsYpDxUih1XWYzC+dAjoGg@mail.gmail.com>
 <31ba2839-a7c1-28dd-8319-1ea6defb5daa@redhat.com>
 <CAFEAcA-kDpwAWzqME7-uKy7svu7wrJ8Vq2jxOqmjdsKXvO2grA@mail.gmail.com>
In-Reply-To: <CAFEAcA-kDpwAWzqME7-uKy7svu7wrJ8Vq2jxOqmjdsKXvO2grA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Feb 2020 12:44:14 +0000
Message-ID: <CAFEAcA8ai76afSyMhFr0u4fMtD7iR3mAi3EUsGA1-NBZ5bCeOg@mail.gmail.com>
Subject: Re: [qemu-web PATCH] documentation: update links to readthedocs
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 at 12:38, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 3 Feb 2020 at 12:12, Thomas Huth <thuth@redhat.com> wrote:
> > Ok. Should we then just remove https://www.qemu.org/documentation/
> > completely and make the "Documentation" link in the "menu" point
> > directly to https://www.qemu.org/docs/master/ instead?
> > We could simply mention the Wiki in docs/index.html.in, too, I think?
>
> I think I'd keep the current documentation/ page for now
> (we probably don't want index.html.in to refer to the
> developer documentation or the git tree).

There's also a 'Manual' link in the footer thingy on every page
which currently goes to https://qemu.weilnetz.de/qemu-doc.html;
since we already have a 'Documentation' link to
https://www.qemu.org/documentation in the footer, I guess the
simplest thing there is to just delete the 'Manual' line.

thanks
-- PMM

