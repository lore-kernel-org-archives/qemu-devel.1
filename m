Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48DDC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:53:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE12B2073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dy0Ip5ts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE12B2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jABXy-0000r1-Sy
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jABXO-0000Pc-9H
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:53:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jABXN-0000MT-6d
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:53:06 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:41613)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jABXN-0000Lj-2L
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:53:05 -0500
Received: by mail-oi1-x22c.google.com with SMTP id i1so2242000oie.8
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 03:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=ekQJ5vDDs11mk4Nivfm+28gsZpR0FxODrIYKM6TLLvM=;
 b=dy0Ip5tsuU4RRXprnXnlYPnOtk2o3xapdQCP5tQjVGaIAG1ZE3+BV8BkZ4VXPSpJPg
 gW5rr+ihXdb3jvkrXQTOH3UbJM4vTIPl3xX4j+yrmmDmVU5aZiGpCx9s1Jf2IsgOybxl
 ls5zB1C4S6YLwhSLF9ceYtlR/kvQ9Vsy2ei8i/aDTZ8ISGuXJ3UhkuUrazS8mb5hHu7q
 mwPLG5RH4LnxXkTeOxZjHoWssbNiHZCD5qg39ipZOD89ryTAT0Iq1Loi2XKffet2Q3Wr
 Ik9xCwvjLkFcDsO4eGDRTcZYlj1xO06su2cWA+6szfElVlNuaYdoZZ2026JzSKzsaze/
 Mxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=ekQJ5vDDs11mk4Nivfm+28gsZpR0FxODrIYKM6TLLvM=;
 b=lM4xhjB4YliLKFVlcNKkmAGhp6Bay+FBSnDmR0ahMd2SUW4P9bkSvqwhz0uEVhaclz
 4gMsi1pnHtaED+MQ4rKK0lyOSAdZl9TZAkUnv0LVNtrIdkuiLSB3QOsrCqBvwGKV/i8I
 BxpGfVTvgGNtnYToRpOWKK2pkgcObZtPa9H6aFU3ixW3YZYQ92I6ziZ3zbqqmmZgvoUu
 zULz9F4FcZRr9qXXNqwbJfdRIXaoNif94oeMFHr/1T/7iuKBIbOMuzn7NuqQF0kKw4wV
 Xb1i8aHpShrn5sNrSRbQeVZW+ptj+IyQJzwYZh65S5lsJaxqsAZu218OvWG5Z5GMU6J2
 801Q==
X-Gm-Message-State: ANhLgQ1khkzCVVvuH1rJP/6j6/giEJdEJ1SKwruw9RfIC1ErnX8yrqSC
 tklzxS3KFnPVNL6+Ss18RsBPtHJHFQrnR2t+xlj06pNVnkI=
X-Google-Smtp-Source: ADFU+vvlu9ujRuIzr7b0rC9ejID4+t2dFb5owQKD9ZlzObBEDvG/wj+WcwuCIWAkIQlFQVHu6HX9RUDgxt4FLim8X5s=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr2345776oiy.170.1583495584103; 
 Fri, 06 Mar 2020 03:53:04 -0800 (PST)
MIME-Version: 1.0
References: <20200306110959.29461-1-peter.maydell@linaro.org>
In-Reply-To: <20200306110959.29461-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2020 11:52:52 +0000
Message-ID: <CAFEAcA_sFWhtfX2dy8g0r-rJMz9oUZ=jYpDZohZLm1bNJ+4GkQ@mail.gmail.com>
Subject: Re: [PULL 00/33] docs queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Mar 2020 at 11:10, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> As promised, here's a pull request with the patches which do the
> qemu-doc rST conversion.
>
> Minor changes since the patchset was posted:
>  * rebased
>  * the two auto-generated patches have been regenerated, to account
>    for the qemu-options.hx changes that went into master since the
>    patchset was posted
>
> I have also now done the testing of the OSX change to the docs link.
> We've agreed to leave updating the Windows installer for later.

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

