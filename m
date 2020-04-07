Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C6FC2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 08:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B780D206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 08:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XeWF0iMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B780D206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLjpx-0004OY-Px
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 04:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLjnK-0003Rx-RL
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLjnH-00070F-Jr
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:41:16 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36752)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLjnG-0006zi-NB
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:41:15 -0400
Received: by mail-oi1-x244.google.com with SMTP id k18so810941oib.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 01:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mPoP9SOA3gisZqBOv6fWFTA/4XC/myugQYXeICEFOvg=;
 b=XeWF0iMz/r3Olt/OdexeTBgZh+VzohpRCZataVu2SV8AvCUl8awPpKT5JT3gEFnBuN
 kzkZoVzT+OZUTh6w+n/Zme75WIrCnelK4QEpe3O6xRENI4M7Ei8xNknWO4QhWXa1RJHW
 jQIOc/SCEIchODGG06bBDYriuo3XFS6rEwRrzsmSjoKUF6I5tZdCvxX2EZU9EqgFPPih
 ipSUzgi6o9ooQwkrBwXmnEMZjRr+TnnZAASo4/7dhhM7VuOwXXv9FyWnnBGlyDf7i0Sr
 K4kJP4JBueIHy++55ZIwEsHs9ZsO730MUBB4kQgZHdxUm6IfwmA/SLmCzZao/nkBfJ+A
 2RQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mPoP9SOA3gisZqBOv6fWFTA/4XC/myugQYXeICEFOvg=;
 b=CX1sSrE1A8/0AtqExR4ZeU4GIkxrKEk1vTX2DLNqamvmnEOrk76uXlxnkwPPYv4yq+
 Skd4x9vR/J5BiiLTBNW7gtcA0trIhjH9w9oXTXQ5V/ElBG+zBlRDNTBt949fJpsNtFce
 nPVQDEzjmc7u01BNZRl7uAzo6ev0jQ0n6/HXcOeoOVs5byGnX4VTENFstVcOo+Bm88BI
 O4Eb1L+wWeB8g+wg07O5rsKqzFicNfz2KyZ6Q2kQXd298u1h4ZywMNPPxM0+dpTHzA2b
 jp7tXYntvsj6UQESof6vRyrtLkGcDwZGCAxR9376M/t7K9W4LasMHGN42LuKXe7j1bkz
 xWiA==
X-Gm-Message-State: AGi0PuaKY6gXToPi2GUkC4x64BkPdXwXbrLYd/WblCs1Db3IFdWpcXA4
 SDdiXHRs5D29m8Foz3ynapaqnx+aXjqKtDQX7oyjBQ==
X-Google-Smtp-Source: APiQypJWvp0BRy1lxfuYuEiJ4li4q/pR8uKbya3gCP+dj9UcFySdmmNx6mXGoeh/lHYa7Xlgys/hMZyo78zQIyHionI=
X-Received: by 2002:aca:3049:: with SMTP id w70mr806821oiw.146.1586248873470; 
 Tue, 07 Apr 2020 01:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <0b02fe788de99120894f87f6d5c60e15d6a75d85.1586213450.git.dirty@apple.com>
In-Reply-To: <0b02fe788de99120894f87f6d5c60e15d6a75d85.1586213450.git.dirty@apple.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Apr 2020 09:40:58 +0100
Message-ID: <CAFEAcA9FSVzxwudyaDoCty8B+Up33caM20qytLNO7HAXWmcwtg@mail.gmail.com>
Subject: Re: [PATCH v1] nrf51: Fix last GPIO CNF address
To: Cameron Esfahani <dirty@apple.com>
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
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Apr 2020 at 23:55, Cameron Esfahani <dirty@apple.com> wrote:
>
> NRF51_GPIO_REG_CNF_END doesn't actually refer to the start of the last
> valid CNF register: it's referring to the last byte of the last valid
> CNF register.
>
> This hasn't been a problem up to now, as current implementation in
> memory.c turns an unaligned 4-byte read from 0x77f to a single byte read
> and the qtest only looks at the least-significant byte of the register.
>
> But, when running with Cedric Le Goater's <clg@kaod.org> pending fix for
> unaligned accesses in memory.c, the qtest breaks.

Do you have a link to this patch, please? I had a quick search through
my mailing list articles but couldn't see anything obviously relevant.

thanks
-- PMM

