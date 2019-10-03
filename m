Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97C1C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 11:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95012217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 11:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YI2cUW1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95012217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFziR-0006bZ-Q1
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 07:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1iFzh2-00065D-AD
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 07:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1iFzh1-0002xo-3w
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 07:54:48 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:34670)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>) id 1iFzh1-0002xa-0Q
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 07:54:47 -0400
Received: by mail-yw1-xc43.google.com with SMTP id d192so899590ywa.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 04:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DLfmwOm8ZWXkksWhQrVaRp2jfUlD3gnydFym2UvBbmc=;
 b=YI2cUW1BxucVm1p/Dqmu4LPRVGsGD7KmZZ+xRqveokMkSDv6t81P4AmXJ/7hl5rGqj
 3NC8PeGwkRUb8apQ+CgR23R1Rq7hETxyfd79dqy+PUhxfFQPth6I2IGKqEQVbGdKbmt4
 4opjIwzJjm9uikcxt6flOW67zs1XMdrdxEeURY4PSDwC6allsFNbY0Mk6wBCnhr//ZNn
 CYr8Oe/sLGH+q/0mzVuFZklURs4N6QU2hvmt3zHXkttMWioSZQ/Cqx6qLjZL8yc4vvtD
 N7M0l2Tznrfb37b6ulC7lejPZyT61oQKKF+ypT62UxHsNhXk22ZvraJ7IffvY2BoyZos
 1zOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DLfmwOm8ZWXkksWhQrVaRp2jfUlD3gnydFym2UvBbmc=;
 b=bcEBDKscVksKsRNSZxwakgAAZ96Smyf1CIV2FhIhxp1qDwdUmCSj823r++bpPMEi/C
 pl5By8BxgF/v4nHF7LYZD/6+cMuQ5E6jC5FcK8oEEosCW4L4NcyHIJ6aIX9YNzCrac1K
 7iKFxUV7eK18b1lgQ8kttxnxNyKoz52BRx+uuQWIu0xmL1m9g+2PdN7GRtjQJNt5eqCv
 /Wbxbv1RjUMXSdb5pse4d2WsajpFzrYkUgckUc/xiR/tjShF3XnlL1vCEJ4K529pa8zw
 KA98SPOP9slPxyTHj7H4Er+s8m4q7ZwkOC2tiYOGUahEVIGkZZGlJPth3GzczPTsuGP4
 iioA==
X-Gm-Message-State: APjAAAXyuOw5lPmPPR4dYFvXvWzVZOrVjqUD5gYXO2fX8vr+/EGiRR6T
 Zf4fcL953eolFrFkVlVtymugDYQfFQdI1Gr+Z+Y=
X-Google-Smtp-Source: APXvYqwWsu7htJ+0t+JeU72H4L9uvIpNx1nByHA3bObcM4PxFwrEvNN42KUnlRrQ96crD+BlPFtac0tsIhlMnchvHLk=
X-Received: by 2002:a81:48c3:: with SMTP id v186mr6210695ywa.140.1570103686328; 
 Thu, 03 Oct 2019 04:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <AM0PR01MB5795656B2DB2EA6E760BA8A8D79C0@AM0PR01MB5795.eurprd01.prod.exchangelabs.com>
In-Reply-To: <AM0PR01MB5795656B2DB2EA6E760BA8A8D79C0@AM0PR01MB5795.eurprd01.prod.exchangelabs.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 3 Oct 2019 19:54:35 +0800
Message-ID: <CAEUhbmUYt=kNzJMyhZWouuktSKkqRtwkzxSQeFygMTid-M=QUw@mail.gmail.com>
Subject: Re: [U-Boot] U-Boot build for i.MX board won't boot in corresponding
 QEMU machine
To: Waseem ALKurdi <waseem19992009@outlook.com>, 
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
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
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+QEMU developers ML

On Thu, Oct 3, 2019 at 7:37 PM Waseem ALKurdi
<waseem19992009@outlook.com> wrote:
>
> Dear all,
>
> I'm trying to get mainline U-Boot to boot on mainline QEMU 4.1.0 for the 'sabrelite' board, using the configuration 'mx6qsabrelite_defconfig'.
>
> It's not booting at all. Actually, not a single U-Boot build for an i.MX board would boot, with the exception of 'imx25-pdk'.
>
> I'm compiling U-Boot by un-tarring the source tarball and running the following commands:
>
> $ time CROSS_COMPILE=/path/to/toolchain/arm-2014.05/bin/arm-none-linux-gnueabi- make ARCH=arm clean
> $ time CROSS_COMPILE=/path/to/toolchain/arm-2014.05/bin/arm-none-linux-gnueabi- make ARCH=arm mrproper
> $ time CROSS_COMPILE=/path/to/toolchain/arm-2014.05/bin/arm-none-linux-gnueabi- make ARCH=arm mx6qsabrelite_defconfig
>
> then after the build finishes:
>
> $ qemu-system-arm -M sabrelite -m 512M -kernel ~/Downloads/u-boot-2019.10-rc3/u-boot.imx -monitor stdio
>
> And other variations on this command as well.
> No amount of kernel commandline options or anything would make it boot. What should I do?
>

I suspect mainline QEMU sabrelite machine only supports booting the
Linux kernel directly, but not booting U-Boot.

Regards,
Bin

