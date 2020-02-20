Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE86C11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:51:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7FA1208C4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XvT9C2r5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7FA1208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4nAs-0003q2-TT
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 09:51:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4n9l-0002TQ-3e
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:50:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4n9j-0000zU-U5
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:50:24 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45723)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4n9j-0000yv-NS
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:50:23 -0500
Received: by mail-ot1-x341.google.com with SMTP id 59so3838878otp.12
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 06:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=afYl0DVEoEhQ/EBMwBMpftX3lzsz91ArZ4Bz9hqJxoM=;
 b=XvT9C2r5f+zEmvR/bgZdkDRyZhwObYqZFMl/2N4K7JfLhbUm9R72p3VKo13fij+sma
 ++TsJOS9UnPtjKBEi5kWNs1phjZRM//LnaQx8gH6Z1GqvhatrlnncxL7kg1I9MewLRfc
 z6U6KYOOgF3FB5fHYyomtIIeMnEap42cnffRfvM0wbZgy/0Op5J8Znj0YDyirj8ymMdH
 HZIGoMeATLoAvDujTYULWAcjcKdl0m85rzMTqQvulgGDmaAEPDh1N3RH5MWMRbl2bt0l
 jtSMOzUus73QsJbkTLA9fPgWpmbrb/NHXb+/RKwTT/IxX8CEDjqXNdjDxvgoCqKR3Pjv
 1o3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=afYl0DVEoEhQ/EBMwBMpftX3lzsz91ArZ4Bz9hqJxoM=;
 b=fdGpZcUPaZFkzLhqs4mWGr7dvd5VsF+eiqsHNGzHL0b7Jd+b9NiD0nhpRHdjdicEFw
 SpTu5JOAfPwckTKQvbMMR6xVFNDv7htQZ4t2ZvCgCkgyMdbwW+lVE5zyiYBdFoJGO602
 WzOJZiZmXcSCeEbl4OLSXBDkANgyOqd6w3thoonqjf/BrEaTB1+55ewMwQu744XNzOo3
 VU0+EXkUr/NJYaQX4MddNDxQi4Z8qZUMMEPf1AV3OXRErKh3J6f2WBE6vrq0GBG9Smcs
 id8+OO4oC9fQLDbv+PYEBAxT40/X8J+t59mIq3FVqfA4WY1HBa46z7wH5wKckUQYnuZo
 U8Nw==
X-Gm-Message-State: APjAAAX/Um/5modTQQ3fZQJDJl4QRwvuRJZBXfWRXVxM3CjQ2DHd89pE
 7u+o2Mr/wy7f4hnVOsQZwODqif3mcjuWDoDO5YM+Vq2V
X-Google-Smtp-Source: APXvYqxiSl0mCUqEYCIM4obIVqbNMpWrpHB7B9FQKgPLN1UKkou1UFqkO+bod/lnAATmKh+NODmO9a832fv79YpxBmM=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr24095274otd.91.1582210222568; 
 Thu, 20 Feb 2020 06:50:22 -0800 (PST)
MIME-Version: 1.0
References: <20200217204812.9857-1-linux@roeck-us.net>
In-Reply-To: <20200217204812.9857-1-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2020 14:50:11 +0000
Message-ID: <CAFEAcA88XmvNkombS=3-vpYPbbKBoDdKzrrEDAU_0kmYHAkKSA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] arm: allwinner: Wire up USB ports
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Feb 2020 at 20:48, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Instantiate EHCI and OHCI controllers on Allwinner A10.
>
> The first patch in the series moves the declaration of EHCISysBusState
> from hcd-ohci.c to hcd-ohci.h. This lets us add the structure to
> AwA10State. Similar, TYPE_SYSBUS_OHCI is moved to be able to use it
> outside its driver.
>
> The second patch introduces the ehci-sysbus property "companion-enable".
> This lets us use object_property_set_bool() to enable companion mode.
>
> The third patch instantiates EHCI and OHCI ports for Allwinner-A10
> and marks the OHCI ports as companions of the respective EHCI ports.
>
> Tested by attaching various high speed and full speed devices, and by
> booting from USB drive.
>
> v3: Rebased to master
> v2: Add summary
>     Rewrite to instantiate OHCI in companion mode; add patch 2/3
>     Merge EHCI and OHCI instantiation into a single patch
>



Applied to target-arm.next, thanks.

-- PMM

