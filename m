Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C343C4740A
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 19:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 034272133F
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 19:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vYR6dHRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034272133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGpRr-0000qc-3l
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 15:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iGpR0-0000Gy-AZ
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 15:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iGpQy-0007P0-2q
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 15:09:41 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:35211)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iGpQx-0007Oa-NI
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 15:09:40 -0400
Received: by mail-ot1-x32c.google.com with SMTP id z6so7970584otb.2
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 12:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0dEyGnwP11tI1gEydSaaLTvzGUjEKrBwxhmDSIfRIQ4=;
 b=vYR6dHRMMPfpPSb1R7in61FGc7OYXq1fi4iJtnA2IfR3SE1OKl9oB9j1cVEypgfveV
 wgYeL0tlJIQwC6ivDgAO8GXDy3SD5+q/wCob+PfHY/KySOZvHrB0kFZQkrKBIElsARji
 7H0KKyBAE16uKrdKkpuHlu3T4NnsEzVYSL+gdUTxfZf4ZZ+azoNUknU9043wRDClvE7X
 blca2YuaUwSSWZhETQ/+TqoZnvsJGJEk3q0gsooSVIymWxdox5ocWSZxPUTorZk9pnmt
 5AgrlblxLqJ7bbAcZ5Pnn36tF20uBE475YQURxW6v5SCacZga91fF++Y/DfBEXDAbkA3
 oQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0dEyGnwP11tI1gEydSaaLTvzGUjEKrBwxhmDSIfRIQ4=;
 b=ESO+RC1o0MvwuGt83OgoaSWjGb1Gki43vpJQAbZrb4dVEWneH7hPZ2jqfhWfviSkWy
 5CKsunvM4qzgwx+vx5OE6LCxyO8hZs+k/gNQ8BDAyZv2dUIz0hLvU8p6WSKLsXC9aDHZ
 OL7TCiWceA30RoU5752lcNJ8Hahmv8cbZSONvJpkz9iiivY5IkUO1KMB+pkb7FACmE6o
 3wYyaBMv0tOoL0jgutwfbz29m31HCwws/7jNMW4uHGIFC5H+GWKC1/IwFGCr8KtFk2uA
 ejAnZjht+mjuxGmE872ZB5hzad8lmoRLZNLgfT30nxf3IYFvM3Y2N6fItq3yjNOSzZga
 AhUA==
X-Gm-Message-State: APjAAAXI4yc6qkB5QtgPgPIModn8jFqc2Se6P/jNcDS2+6MOAB43/mZL
 LXaeteBfBlLbBseddFVF8qm1+Xo82QuQlOGPRi2V+g==
X-Google-Smtp-Source: APXvYqxJqWhlCZ33uV3PxvBK2/ValPyEJmnD2xjQBRz0CR0yQrq1mUTCs0bXyaDmg87SEdEpm1insF1AGHFkJTwSnGM=
X-Received: by 2002:a05:6830:1357:: with SMTP id
 r23mr15421938otq.91.1570302578639; 
 Sat, 05 Oct 2019 12:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <CALvKS=EoaNnNQCmdp3rjjbaAYOoow8txsn1KX=Mb37Vk3he5Kw@mail.gmail.com>
 <5ef2c575-0bae-9f0b-cf2b-437280914cec@redhat.com>
In-Reply-To: <5ef2c575-0bae-9f0b-cf2b-437280914cec@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 5 Oct 2019 20:09:27 +0100
Message-ID: <CAFEAcA8bs-DZPsxzE=kJ-gRT-1i6wZ4FvkK+-MaygE0Zg3A4Yw@mail.gmail.com>
Subject: Re: Peculiar reply from mail list handler???
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
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
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 5 Oct 2019 at 18:13, John Snow <jsnow@redhat.com> wrote:
> I'm not clear on the particulars of mail delivery protocols or what
> lists.sr.ht is, but we indeed do not like HTML mail sent to this list.

I suspect the lists.sr.ht address is just some subscriber to the
QEMU mailing list -- the list server sent your mail to all
the subscribers, including that one, which then complained
to you. But the QEMU list itself is OK with HTML email
(we prefer plain text, but we don't reject HTML).

thanks
-- PMM

