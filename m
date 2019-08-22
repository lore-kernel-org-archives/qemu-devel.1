Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A51C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 15:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBC682082F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 15:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="evXWqyYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC682082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0onB-0004q6-Vm
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 11:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i0om7-0003LJ-Ga
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:13:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i0om5-0004oo-UF
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:13:19 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:43402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i0om5-0004o1-O8
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:13:17 -0400
Received: by mail-oi1-x232.google.com with SMTP id y8so4610058oih.10
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZG6QKYvUh7g+PaAaZ+CoZxk5QNtLYRhbNIiPd88OJ3I=;
 b=evXWqyYgM6oSzgBdEvBVd9NntlE/KcYmOE6nd/fmREk/IrAgrLPSK1A+Nr0LKZGtw0
 tnp8yfUbRkENAwcqPvyyJEtiy7znfODIcFXQQLJLpZyk9mcpG0jZmmo6iv4QGkYhxve3
 sJVHHvXlJ/ggRnW+nA/jx7ISvsIdSU8fxpub87lpTsx64Kkzs2DXQE5tBpH3FLyEp090
 jeFLNl1YcBkV5r0bHJ6zxWFagWT3COhXzLN4XbDPa5Gw03TM5udQ52723vKQaU7H0nU1
 bTKyQk8JSenhLeg4Wj6S1NE5WuMD4cRymzKdWsYhfW0JQoSZ4FCbIyN31QfkFuJUz+Zw
 xI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZG6QKYvUh7g+PaAaZ+CoZxk5QNtLYRhbNIiPd88OJ3I=;
 b=cjxOpagQIB6JvXFZLWZWXbc9c5nbGIyhOnPU3yC9dGHE9b1/D+IDoFc/61nzfSqzKp
 JstxuoRmMwnh896bdvF3RrA7/MX/xvDjZtiV31PnlLBO1hD1EJkuYcPCKrJXs1vZwaoz
 kYTzuuAWSZ4UGumjI80YxXZWxc4XdPPhSytsSZXZZUWxlTiTXDmIwdSBKJOhxwiXb+XI
 YSE+IApJsM9NjUqmxzzlK1axQHJzDyIj80Nw3sXBFBtyPaQqBVKFjDrGpljxgPmEH5Rl
 61UQMrTooFAnE4I3jx8GzuAqIcgtENEGc3XuELdmgiJR5kgxXOENLXn0JFwJWZ0hbeoL
 036Q==
X-Gm-Message-State: APjAAAXOmTevbIdTbmswCRDbOUaV3Xc4vMyIn8db41Nov7Vz2X2pMqXV
 5mQjBv5l/yFUIS/TqxS/lmGh703wb7+at3VaUnVMpA==
X-Google-Smtp-Source: APXvYqwU5MxfqXgPKQYKHYqNc//AKw2LEu8eZcnr68E5Mwy4TisydLboRUYsJUwme1zUNictvBLRvdyLE+2gL8zyLV0=
X-Received: by 2002:a54:4718:: with SMTP id k24mr3968695oik.146.1566486796717; 
 Thu, 22 Aug 2019 08:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190822065242.12496-1-kraxel@redhat.com>
In-Reply-To: <20190822065242.12496-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Aug 2019 16:13:05 +0100
Message-ID: <CAFEAcA-LpxY=NdwTtg3nuOvacTr9+p-bpzsW1-xE84+BXwxamA@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
Subject: Re: [Qemu-devel] [PULL 0/5] Usb 20190822 patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 22 Aug 2019 at 07:54, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 17dc57990320edaad52ac9ea808be9719c91cea6:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-08-20' into staging (2019-08-20 14:14:20 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20190822-pull-request
>
> for you to fetch changes up to 1be344b7ad25d572dadeee46d80f0103354352b2:
>
>   ehci: fix queue->dev null ptr dereference (2019-08-22 06:55:29 +0200)
>
> ----------------------------------------------------------------
> usb: bugfixes and minor improvements.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

