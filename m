Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2FFC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 19:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46D9321721
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 19:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d2aGixWd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D9321721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ialrZ-0001HF-Gn
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 14:23:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ialc2-00015N-5M
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 14:07:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ialby-0002ko-OR
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 14:07:29 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:32781)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ialbq-00025A-Qi
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 14:07:25 -0500
Received: by mail-ot1-x342.google.com with SMTP id d17so2049143otc.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 11:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+FtFsuQtq3eVlLtLusxL2dw9FGxIT8kWy5OnLveth6I=;
 b=d2aGixWd7g5bE3+AyqaOyriJ/3AMKr+cfuMkOT24yV/t3bg3VDL9KI9z/Jji5pD7CI
 FWZsy7kpuiVyQiCRCYyYsoNGppsjvQ+ZFswedEakglw6ma66mHdvSy5Rr5QRqy7f1oQW
 Ze6Xz7GdJvNa6eeC8jGbPj6PqUBMO5tAG/O9dyAtABsXvVEyVcA/H6VIVb+zIgoG+no7
 OHgFp5T92/j8q5k7hs58H0m6dF8crUHzbrfGj4rOTfjKUjYLRSg6Hnht4SgSJEe1VUY+
 YM1MAyQVJS08iY0/lLhL7ol5SUPck+qY1bZP2FS0ARFm7e7VhjBequn/PXU6jwewdsCi
 uw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+FtFsuQtq3eVlLtLusxL2dw9FGxIT8kWy5OnLveth6I=;
 b=Z+38wLwtaMYOSqfN7DWE6DXlH+vkCIBidPQJnMaUraTq+eIAERN1LhCU+sYcZV0ETd
 vXZetsUGGa4IWQV8JYVDjPKvvLBIdamOsD7xwQL6BV5g+UvMnEAvTxO7bAV1BIobAFZK
 yO84LqY4Q9nx3OPVYOMTWfW68JO1NNaPWWXNHsIEVA1rH0NH8E1hP1yPh6NBizigOEf6
 q4U7RZ3hN9NlPaQdn81pLxF3J47uHxZXRVSTq6i4T7WyJ16/sIgSSRX6W17yxdYznyJc
 kw4w77NONbImVgXAlBKPDTQlQMFK+fZbtxvEWE6n9pYWx7iX8VtpcnZ1NyVPums7BLOr
 E1Zg==
X-Gm-Message-State: APjAAAUB/AtoZpZXRQWFaL9oXgdHMpntyMwWf55evyq2HvTnZLLFgnFA
 ST1LMuWLod7hcyglZIfS+TmGOxCdW4bhfiwp78QycQ==
X-Google-Smtp-Source: APXvYqwFFgtbZ55HnxPHaKhrFgSMWYNN3KTl86rSIJxhph8nzoCcUpwBqeHUrsAPZtTeOPkaABd0OHdYbz0/OqPw0xI=
X-Received: by 2002:a9d:6357:: with SMTP id y23mr12375124otk.91.1575054432823; 
 Fri, 29 Nov 2019 11:07:12 -0800 (PST)
MIME-Version: 1.0
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
In-Reply-To: <20191018150630.31099-1-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Nov 2019 19:07:02 +0000
Message-ID: <CAFEAcA8yMWyXyP08HWWkAo72KUQgN4JwbaSHA-Y8msiCLLrvzQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/13] Multi-phase reset mechanism
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>, Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 16:07, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Hi all,
>
> The purpose of this series is to split the current reset procedure
> into multiple phases. This will help to solve some ordering
> difficulties we have during reset. Previous version can be found here:
> https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg04359.html
>
> This series adds resettable interface and transitions base Device and
> Bus classes (sysbus subclasses are ok too). It provides new reset
> functions but does not switch anymore the old functions
> (device_reset() and qdev/qbus_reset_all()) to resettable interface.
> These functions keep the exact same behavior as before.
>
> The series also transition the main reset handlers registration which
> has no impact until devices and buses are transitioned.
>
> I think this version is way better regarding the transition from the
> legacy to the resettable interface than the previous one.
> After this series, the plan is then to transition devices, buses and
> legacy reset call sites. Devices and buses have to be transitioned
> from mother class to daughter classes order but until the final
> (daughter) class is transitioned, old monolitic reset behavior will
> be kept for this class.

Hi; I finally got back to reviewing this patchset, and I've
left comments on various patches (minor stuff only). I didn't
bother to comment on a few patches that I was happy with and
somebody else had already reviewed.

thanks
-- PMM

