Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60040C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 13:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A9542087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 13:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I50gEb87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9542087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPRW2-0001zn-Cy
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 09:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jPRVF-0001BC-U4
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jPRVE-0004Dk-OT
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:57:57 -0400
Received: from mail-ua1-x941.google.com ([2607:f8b0:4864:20::941]:39095)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jPRVE-0004Bx-DJ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:57:56 -0400
Received: by mail-ua1-x941.google.com with SMTP id i22so668613uak.6
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 06:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IkDKHSoXtkgxj/FtUPqqyiyfXjHOtFUFK0Fi91nt2NQ=;
 b=I50gEb87GSWahboVJ5Cj/zt+uMKqfHnFO3lGj1aoVELzOp5KJTnzw2iQ28z74Q71dd
 CyNmYdInYJ8kQDh+pG3SDJNqFh9SFOkNoZYcA8igIZrsvcqw+bk3z37gz+vRWrp4lquK
 EwYip5m8//tMFo1d/G6X14JEtFatxtKwkY8c91qYBgRCXSiWJpryWnA0YPYBLh+voEJA
 pLdkMp/Ms+YQ/Mtep62ovz6NAKdYDfbKUB5GrNA4bvdDkdQxQBUJmQzOJ0UD8t50ijx1
 rC5/GhsQ6Q23rQnXrGs16Ro01DJO1j3mXWIhLkw/aG8eG9HAZmBAAMDrR5sz8h0Np7mK
 2vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IkDKHSoXtkgxj/FtUPqqyiyfXjHOtFUFK0Fi91nt2NQ=;
 b=TJFsRZneOaJuAZT5WAMtE7EIsiV29ql64MOt/wfcpo0Wt9zW6ME9HiY0cvuRpQ3dzB
 xROKN6+ePBlwfCJqDVYHDo1lMXBlUDfgeeL67pQF4N3Qla3ROJ0wkGEcd1dnUIl67wvX
 l1NIuZsmhDhiSTshNZA+kvfBhZHxi4+aSi+C7bUL4x3elrtFb1aD7THGdPwBg1yjRXKB
 gK6JeCQNViviYQhG7ofCqXjZPJY1ZuUVL0fMYFNLIDG/2up+ncAZzeAR5pGA1lXrAyql
 NLrNKjSkYYqzjFm5NYdpVq8H8PdIfjUDPfIsdW5tfdOIxAdKGuwFiWntyuZ1GMipcaYB
 bU0w==
X-Gm-Message-State: AGi0PuZcYkxhHG3H8nQnt+Al9g8IQZHVjP4ZhTQyI9LbNCXbfGE5aUU2
 YE6/wACoEI13IBEb4XI7ARfthpD8/XMnWGtfJ/JhwoTHNsA=
X-Google-Smtp-Source: APiQypIFFsrU6jCmb2SzZ4GxzmAtcHKhq5TI0HHx1YaHIQgKXVMLnIiKIRRscNiPF9vaUKLBeWghXMx1thUZ6JJelQs=
X-Received: by 2002:a9d:2c08:: with SMTP id f8mr2674288otb.135.1587131874884; 
 Fri, 17 Apr 2020 06:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <1587048891-30493-1-git-send-email-sundeep.lkml@gmail.com>
In-Reply-To: <1587048891-30493-1-git-send-email-sundeep.lkml@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Apr 2020 14:57:42 +0100
Message-ID: <CAFEAcA8AOSEK4w+AvyLgOc6gX83_XN7FVvU7kkxpuTuSO3cz9g@mail.gmail.com>
Subject: Re: [Qemu devel PATCH v6 0/3] Add SmartFusion2 EMAC block
To: sundeep subbaraya <sundeep.lkml@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::941
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Subbaraya Sundeep <sbhatta@marvell.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Apr 2020 at 15:55, <sundeep.lkml@gmail.com> wrote:
>
> From: Subbaraya Sundeep <sbhatta@marvell.com>
>
> This patch set emulates Ethernet MAC block
> present in Microsemi SmartFusion2 SoC.
>
> v6:
>  Fixed destination address matching logic
>  Added missing break in emac_write
> v5:
>  As per Philippe comments:
>         Returned size in receive function
>         Added link property to pass DMA memory
>     Used FIELD() APIs
>     Added mac_addr in emac state
>     Used FIELD_EX32 and FIELD_DP32 APIs
>     Simplified if else logics in emac_write/read
> v4:
>   Added loop back as per Jason's comment
> v3:
>   Added SmartFusion2 ethernet test to tests/acceptance
> v2:
>   No changes. Fixed Signed-off mail id in patch 2/2

Applied to target-arm.next for 5.1, thanks.

-- PMM

