Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C56C43141
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 14:22:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06EE8206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 14:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkeqXxiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06EE8206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZyCh-0000b9-7Y
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 09:22:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iZy8d-0003os-9v
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:17:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iZy8c-000732-1o
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:17:51 -0500
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:33148)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iZy8b-00072U-TK
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:17:49 -0500
Received: by mail-il1-x143.google.com with SMTP id y16so13630795iln.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 06:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rw6SqncViG8g/U65iBJl9Eo11IFYNdAKyB4CIX6LA7Y=;
 b=NkeqXxiELq3Qla7YMc4HegwW2zKyrSBGtSZW3Vd8bkU1i5AF1pz9fkkJy+xi3xBlXZ
 l1yuRnFXvSaifgVZ9s5oymK/qU6lZoaNCm9UkxC5eqyk+1YjYfP+RlGifFpllq5tvbc1
 bzZu9odtQ8ht/zy6Cj+rlTPtwymN2mtlk8rRWlzcsGYfIGHQjAl13UYFuxwHqA72aKdl
 gZsX+vbYlOT4ER1oB7ez/TTbD18aAykqrndoUZWdz2pUSZKLeM8i6gZixEg4ydzJDh7+
 5hG4uWyoRjvUDenbnm+VoiL6xCJCmEAvx4maBL/bqqgsTrsENC9mqSKcBX4xwNwIcfMi
 ZHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rw6SqncViG8g/U65iBJl9Eo11IFYNdAKyB4CIX6LA7Y=;
 b=qxjejhQxyg0GaWVIeA6xPWDY3MPvOLVjWy42+qUU4i11f/m/tqsarM4sTddLPsWGwQ
 vH34ptZr+jj7NupzACYG1cob7YoTzP2hbiHwxn8GlH6E1DgvCPm9ZhY7C0IALTglEP2S
 PTFl1R+nVz7KKqrcCdGt45Uva85Haf53znbr2GYISBsth3i9uMTMfzah0IdcZ2eOt2wg
 dNQaWWumDpC2F7sbL+b+EXpRfd+NYwznuaKHIJJvrqQueJsp3oEanmeqmuq7uK/M7wJ3
 ++bB3xE/XkJ6YPHMhk6uD1v63vDB+e8n/j2VidwgWOG+5axaotU3Fy8dcxDD/Dz7M1V+
 G4vw==
X-Gm-Message-State: APjAAAVZ0ckE5mgQTTXgoU5dS1sjDwwo1iOIJZNVuH0t/K2b9gimnrxL
 6Z2QvTEXJ7JeA2crvJZsOEwEBi1GuUMdL3/hNqqXoQ==
X-Google-Smtp-Source: APXvYqx/3cr5WbkOABQs3rQ1myCcLapY+jjjybliE0ysyRVqYUmZpAvIUGHIy5X9qBTDrckGiBV8Of3XegljaJ0LvE0=
X-Received: by 2002:a92:4010:: with SMTP id n16mr47263368ila.260.1574864269210; 
 Wed, 27 Nov 2019 06:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20191111014048.21296-1-zhengxiang9@huawei.com>
 <20191111014048.21296-6-zhengxiang9@huawei.com>
 <CADSWDztF=eaUDNnq8bhnPyTKW1YjAWm4UBaH-NBPkzjnzx0bxg@mail.gmail.com>
 <22a3935a-a672-f8f1-e5be-6c0725f738c4@huawei.com>
 <20191127140223.58d1a35b@redhat.com>
In-Reply-To: <20191127140223.58d1a35b@redhat.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Wed, 27 Nov 2019 14:17:38 +0000
Message-ID: <CADSWDztu=aP=ckxLsKdP7URmYFLn=JtOcm=zMAGJXo-G_9TOHQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v21 5/6] target-arm: kvm64: handle SIGBUS signal
 from kernel or KVM
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::143
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
Cc: Peter Maydell <peter.maydell@linaro.org>, ehabkost@redhat.com,
 kvm@vger.kernel.org, mst@redhat.com, wanghaibin.wang@huawei.com,
 mtosatti@redhat.com, linuxarm@huawei.com, qemu-devel@nongnu.org,
 gengdongjiu <gengdongjiu@huawei.com>, shannon.zhaosl@gmail.com,
 Xiang Zheng <zhengxiang9@huawei.com>, qemu-arm@nongnu.org, james.morse@arm.com,
 xuwei5@huawei.com, jonathan.cameron@huawei.com, pbonzini@redhat.com,
 Laszlo Ersek <lersek@redhat.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 27 Nov 2019 at 13:03, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Wed, 27 Nov 2019 20:47:15 +0800
> Xiang Zheng <zhengxiang9@huawei.com> wrote:
>
> > Hi Beata,
> >
> > Thanks for you review!
> >
> > On 2019/11/22 23:47, Beata Michalska wrote:
> > > Hi,
> > >
> > > On Mon, 11 Nov 2019 at 01:48, Xiang Zheng <zhengxiang9@huawei.com> wrote:
> > >>
> > >> From: Dongjiu Geng <gengdongjiu@huawei.com>
> > >>
> > >> Add a SIGBUS signal handler. In this handler, it checks the SIGBUS type,
> > >> translates the host VA delivered by host to guest PA, then fills this PA
> > >> to guest APEI GHES memory, then notifies guest according to the SIGBUS
> > >> type.
> > >>
> > >> When guest accesses the poisoned memory, it will generate a Synchronous
> > >> External Abort(SEA). Then host kernel gets an APEI notification and calls
> > >> memory_failure() to unmapped the affected page in stage 2, finally
> > >> returns to guest.
> > >>
> > >> Guest continues to access the PG_hwpoison page, it will trap to KVM as
> > >> stage2 fault, then a SIGBUS_MCEERR_AR synchronous signal is delivered to
> > >> Qemu, Qemu records this error address into guest APEI GHES memory and
> > >> notifes guest using Synchronous-External-Abort(SEA).
> > >>
> > >> In order to inject a vSEA, we introduce the kvm_inject_arm_sea() function
> > >> in which we can setup the type of exception and the syndrome information.
> > >> When switching to guest, the target vcpu will jump to the synchronous
> > >> external abort vector table entry.
> > >>
> > >> The ESR_ELx.DFSC is set to synchronous external abort(0x10), and the
> > >> ESR_ELx.FnV is set to not valid(0x1), which will tell guest that FAR is
> > >> not valid and hold an UNKNOWN value. These values will be set to KVM
> > >> register structures through KVM_SET_ONE_REG IOCTL.
> > >>
> > >> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> > >> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> > >> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > >> ---
> [...]
> > >> diff --git a/include/hw/acpi/acpi_ghes.h b/include/hw/acpi/acpi_ghes.h
> > >> index cb62ec9c7b..8e3c5b879e 100644
> > >> --- a/include/hw/acpi/acpi_ghes.h
> > >> +++ b/include/hw/acpi/acpi_ghes.h
> > >> @@ -24,6 +24,9 @@
> > >>
> > >>  #include "hw/acpi/bios-linker-loader.h"
> > >>
> > >> +#define ACPI_GHES_CPER_OK                   1
> > >> +#define ACPI_GHES_CPER_FAIL                 0
> > >> +
> > >
> > > Is there really a need to introduce those ?
> > >
> >
> > Don't you think it's more clear than using "1" or "0"? :)
>
> or maybe just reuse default libc return convention: 0 - ok, -1 - fail
> and drop custom macros
>

Totally agree.

BR
Beata
> >
> > >>  /*
> > >>   * Values for Hardware Error Notification Type field
> > >>   */
> [...]
>

