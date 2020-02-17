Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2755C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE30920656
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PdnUz/y8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE30920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3jze-0000qI-SN
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 12:15:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3jyf-0008JR-66
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:14:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3jye-0003S1-2E
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:14:36 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37583)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3jyd-0003Rk-T4
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:14:36 -0500
Received: by mail-oi1-x241.google.com with SMTP id q84so17365545oic.4
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 09:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TwZCvMtOo0F+ksGqXKn6050iWxu1JOIv5Rr1YgK2OIU=;
 b=PdnUz/y8o26NmX2V9HODL6a7yOYZkFRz9vt1w4wq1q0qLyRbyXLbQhTauCs7StI867
 xH0nrddKTmYcut8EL0dKwtgob6pgO1Ki9HdMHBazlsxWD2ngneci5mNAXHDgQwJ81eiM
 X99GqCyF3JBOYbg31N7/Lr0ib36FEicV83gLGIibW4SI6uM6KSe2bxaNKdizaVmnlGXf
 TEUWifk+OHMEJSJmAdSr/jgey90ei73R5WIT4euYYmUJDQi2Iug4KiHTK8Njw1W2YVyt
 rfFtuxk+dENBlGsy+m4PLcPi3YtfES9S9BWt6jB4WSvPHgY7hNA/eTj3wgHL9YGyxLzn
 ohMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TwZCvMtOo0F+ksGqXKn6050iWxu1JOIv5Rr1YgK2OIU=;
 b=sXhXp9/x4G3gc+onkIzBwJ6erxfsgCiTbqUBBmCA4vCqgJM9QL2ohO+uLCGLlf1JZP
 SpcE090WqjyogdEoNL5J+tHB0nRA0ZPdkchhK3pcUGwvf+VtBq2a2gZNnaR06jFEXSBu
 m9OWDX+MfIad0wh/9hynoBXri9DRklz9eDUwDivy1TACJboMXyTe19Sg4xbExwGPx0us
 H+mW1lFXTjVWOW7y5RDjJgD68MRu2Zxx7apnqxKLFtWl8cTwWGVkWX1KKXQ9hnwatLHC
 cQa8oZQJKadLwFbKEhEZpTeJFniq2UM8zIcsu5absCffrtUiZ3OmbzALA200dRrGFKBU
 G64g==
X-Gm-Message-State: APjAAAUtutAjiUgc9DzzF8RE9ng+J3Qp3LVja/0D6XRcJXJNIZYD9stG
 hMZlRb9TmOt7IhxmFST92oA1dyh6+cWK6NGY1mLbpQ==
X-Google-Smtp-Source: APXvYqx1lfDD+hiZKYWd8frRDI6grsamxN03XVcfNgKXacSDJe4v7U+H7QOAsO7sXIZpHRIaPMx/kHQvGQejnUJiCVI=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr20279oif.163.1581959675040; 
 Mon, 17 Feb 2020 09:14:35 -0800 (PST)
MIME-Version: 1.0
References: <20200215154706.19837-1-philmd@redhat.com>
 <20200215154706.19837-2-philmd@redhat.com>
 <CAFEAcA9cZHWziyk6VzfaxrqjCNNOmnmSkB=uuGJMp0TL521mAQ@mail.gmail.com>
 <8c4570e1-cd9b-9d33-2756-5c223df282ee@redhat.com>
 <CAFEAcA-hyEVPeT1wakaft6m3_WD9XG3eYFAwJJgoHRAZ1nntag@mail.gmail.com>
 <e530629d-c029-1d7c-b5b7-cdbbeb397a4d@redhat.com>
 <CAFEAcA-KzWv=_kZUPNE6yyUSA36XY+q91ihJ_xh4euJ9RsyaLA@mail.gmail.com>
 <c2ae28d4-3864-dfc6-2033-93bbd7aa865e@redhat.com>
In-Reply-To: <c2ae28d4-3864-dfc6-2033-93bbd7aa865e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2020 17:14:24 +0000
Message-ID: <CAFEAcA9P9L7xBk9y5a3k7cLX_60aTnV00uDT9=C-yWTaXKhTbQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/ipmi/bmc: Delay timer_new_ns() from init to
 realize to avoid memleaks
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 David Hildenbrand <david@redhat.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Feb 2020 at 17:12, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> OK, checking '!dc->user_creatable' removes:
[...]
> Previous list only reduced from 300 to 265.

You could look at what condition we check for that causes this:

$ ./build/x86/arm-softmmu/qemu-system-arm -M virt -device a15mpcore_priv
qemu-system-arm: -device a15mpcore_priv: Parameter 'driver' expects
pluggable device type

which will probably let you rule out some more devices.

thanks
-- PMM

