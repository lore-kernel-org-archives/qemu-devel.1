Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB52C34044
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 16:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD7D208C4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 16:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGOJyEDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD7D208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j45rn-0006Ms-0Z
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 11:36:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1j45r2-0005d1-9I
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:36:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1j45r1-0000VO-55
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:36:12 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45771)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>)
 id 1j45r0-0000U9-Tp; Tue, 18 Feb 2020 11:36:11 -0500
Received: by mail-pl1-x643.google.com with SMTP id b22so8278229pls.12;
 Tue, 18 Feb 2020 08:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nRuzn8UKnTQ2cmdcyxv/wn2ocH2dZ8wVICl5F0i38wM=;
 b=FGOJyEDsRuiAt41/y0u01ygmLRCPE6mDOVZBTNJeYe1eZfTI3RULsmnDlAHJePgfOn
 JYkY6ZkcLg1r95J4TJnW5sx00EPaCkrJ4fqfSYu8I36eofJwsQcjXmk7vY3l6Whq2i4S
 oV2ap2M7OhWF29sGWsdNJ4KmMpxJAtFwGyw7s8u631YOK+Hi9jMQ0KFWGgH7dq3/ZVia
 gKHbjG3jwJEIJEzJDBQL1/3tyMVEPbKnsxViKFgTntd6Jrh5eHWcEjedhMH/Y2DgRwgF
 kxkhI7mlvHwuKPc1+2cu3Vu2Iu5xhSt8xV1p7oCTA2tThhlPLZJyUePiL7wj5VOAYriz
 bjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nRuzn8UKnTQ2cmdcyxv/wn2ocH2dZ8wVICl5F0i38wM=;
 b=TNzVdLuzE/nJzehPlDkyDeNkAkTNK2MGZV+O3orYtsZmSgGUfQHZopJzr7IZUYK5Br
 H8ARHRg8IlrZ+VzqTVdrxB4hVVjX6DKpABwLtWTIt7P8O3LKLlYiG0ba/dDS7G3dqhtL
 gewxiYMtjadhkj2lqEdOH4ITNdwgf432JrXh27GZgUcST0Hjus0L2H5P9j/Aeb/rWnDS
 zFV5vi8BR6ZLmfuVW3AhUek7KoP2mPl69iXb/J9gqg4HbKq/R8/La1CeSybRGcIuyhE5
 cUHsdvuz1gkKmIsIZ23g06nleYeZLvAfGoPe11vJ1GwUulz8NjjWfk+gGiPeU8HRt48c
 KJAg==
X-Gm-Message-State: APjAAAVYLjRom4NeMe0Ur644ttESOIv8fn2VzWcdi3gQXyZ/G5Q/O4/F
 gZgii/hrwCEq79+5gEadge/5xAri6AwpoEPEfak=
X-Google-Smtp-Source: APXvYqx+7gf9qXpxdpkBWNplw/D0Bs1+zafiZ0iBKU526ksLFZFMcMuvlYpSyUOVqGDHtd7h8g7/nzB0kPfiEBIeJ84=
X-Received: by 2002:a17:90a:db0f:: with SMTP id
 g15mr3518389pjv.40.1582043769392; 
 Tue, 18 Feb 2020 08:36:09 -0800 (PST)
MIME-Version: 1.0
References: <20200218091154.21696-1-kuhn.chenqun@huawei.com>
 <20200218091154.21696-4-kuhn.chenqun@huawei.com>
In-Reply-To: <20200218091154.21696-4-kuhn.chenqun@huawei.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 18 Feb 2020 08:35:58 -0800
Message-ID: <CAMo8BfJ1Jc2_+wMcKK9PZPXidczbQJ04N+3kMx7zV=KpDK__sQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] hw/xtensa/xtfpga:fix leak of fdevice tree blob
To: kuhn.chenqun@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: Marek Vasut <marex@denx.de>, zhang.zhanghailiang@huawei.com,
 QEMU Trivial <qemu-trivial@nongnu.org>, Chris Wulff <crwulff@gmail.com>,
 pannengyuan@huawei.com, qemu-devel <qemu-devel@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 18, 2020 at 1:14 AM <kuhn.chenqun@huawei.com> wrote:
>
> From: Chen Qun <kuhn.chenqun@huawei.com>
>
> The device tree blob returned by load_device_tree is malloced.
> We should free it after cpu_physical_memory_write().
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
>  hw/xtensa/xtfpga.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max

