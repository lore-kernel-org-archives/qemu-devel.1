Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB0EC35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A783C2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sYZNsPMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A783C2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5913-0007LN-Oh
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 09:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j590K-0006dX-Ap
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:10:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j590J-00024e-DJ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:10:08 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38875)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j590J-00024I-7p
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:10:07 -0500
Received: by mail-oi1-x243.google.com with SMTP id r137so1677541oie.5
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 06:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FWVDkmsgLpByHs3eCi6sKclY4YV1R37ovc1jJnUhQAE=;
 b=sYZNsPMdslZdcvPHvQQcr0WltYjiT/Uxn2SLB7obLof1d3EgJ7b4163UoteGPlJyI1
 +s03NrPStjcs/pVGnIHr9ChIdcfXtK6BRPBd1Cp+mL8gjozESrb3QD8N1Fx1nL/MwLKa
 pAzdzPqEtcG6RROcunEocDFvsspFUuVkJZd73lXwyt5e0llpr8oyujVqnZGKseJXdE7s
 16ZFclOcmt6UjH8NLi0wkdjpxq76TL/EdfKJbXfCUIy88AC2t2O9c54P4yRnRISlE7eD
 mx3AOfZ/SmkSaZOefFkfg3yyxutIppFJXE/2zrjoZtoAVP7kultq2C0dsqJzbVNwGtkJ
 WYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FWVDkmsgLpByHs3eCi6sKclY4YV1R37ovc1jJnUhQAE=;
 b=CjrQZ2XPwkiEMDEh9RiF6kmZW02McUGOYvoSxLG0R47xbL380M/PkdFFl5ks1SRG/K
 BvX2DXrl5NWugFcrJxqfQTqkU5eE+fL0janj9xjBCZVno07Y+Jh8uBjHxX+f1LxI3vkG
 Oap/ejoYkaAHFfqKlXOa3wNuI2eDpfLv4IWraS3fFkwVi7ob71LGaouCIcG0TAfE568H
 JeAb8NR2XnCWUbu89EbHMzqGzxUam+uF8RYJ/PNn/BuVOrl6yhIcJ6rg3w4IFH96JB03
 5wSpvGF51DcPWN6AqXIMu11XbGEljL82f6OaBAvlb75R0QkToMe7lmtDnJtIC7IqPLL3
 NXFg==
X-Gm-Message-State: APjAAAWJjjiaGR0nG/GuMbhP329ZGdNCAlYZwxUl01GpmvuG7MPTo8eq
 9dthwOZvr8yOb8oJTJu4pW6P9ss2nFIuqacFXJZT1g==
X-Google-Smtp-Source: APXvYqyX9eeSuvuFP09qcS1lkRxxupztYJ917FYlclPxtdjWxmrxfdLsQF2GBc3ux1gL+c/jP6I4magBfiAsdoLFwbE=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr2098991oic.48.1582294206446; 
 Fri, 21 Feb 2020 06:10:06 -0800 (PST)
MIME-Version: 1.0
References: <20200217131248.28273-1-gengdongjiu@huawei.com>
In-Reply-To: <20200217131248.28273-1-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 14:09:55 +0000
Message-ID: <CAFEAcA9xd8fHiigZFFM7Symh0Mkm-jQ_aGJ7ifRCrXZvFY4DqQ@mail.gmail.com>
Subject: Re: [PATCH v24 00/10] Add ARMv8 RAS virtualization support in QEMU
To: Dongjiu Geng <gengdongjiu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Fam Zheng <fam@euphon.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Zheng Xiang <zhengxiang9@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Feb 2020 at 13:10, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>
> In the ARMv8 platform, the CPU error types includes synchronous external abort(SEA) and SError Interrupt (SEI). If exception happens in guest, host does not know the detailed information of guest, so it is expected that guest can do the recovery.
> For example, if an exception happens in a guest user-space application, host does
> not know which application encounters errors, only guest knows it.
>
> For the ARMv8 SEA/SEI, KVM or host kernel delivers SIGBUS to notify userspace.
> After user space gets the notification, it will record the CPER into guest GHES
> buffer and inject an exception or IRQ to guest.
>
> In the current implementation, if the type of SIGBUS is BUS_MCEERR_AR, we will
> treat it as a synchronous exception, and notify guest with ARMv8 SEA
> notification type after recording CPER into guest.

Hi; I have reviewed the remaining arm bit of this series (patch 9),
and made some comments on patch 1. Still to be reviewed are
patches 4, 5, 6, 8: I'm going to assume that Michael or Igor
will look at those.

thanks
-- PMM

