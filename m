Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAD2C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:31:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AABB3208CA
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m2TPgg7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AABB3208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhxL9-00015d-HV
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 10:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53206)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhxBf-0006Kh-6d
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhxBd-0001Xq-Ka
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:21:43 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38676)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhxBb-0001QI-Fv
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:21:41 -0400
Received: by mail-ot1-x343.google.com with SMTP id d17so13678121oth.5
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 07:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7jKn/glfJZ7+q4vbaBGW+VsR/O9vJnh77TasloERjnU=;
 b=m2TPgg7lNbeLvOk7y3CLyI8upmKGyE65o4NU0MvULeyNvp6DgI2CidWXEAut398lU3
 0dbdSf1o1PS/RAD0CMsj6E13gD6+q+Rr7/hZj2l6IS96RMTAd4XCvuXjKL14I/QJTF98
 X0ucOHGDM/zQbXFJYDC/qQLQT/i0rcFVc7yDR8eujmCL9hGvKtm0HoVH1ofCEwPeDNj7
 Fpp9a20GpqLx7fFeZ4CrdiUfCn/0u/SkQ6qpINv39t1bouA8diM3ToYbdgfRrzJNTbBS
 QqFkiCbkb1dbATz6JgHBOvAfMSctTL7wNQIRttkr1gNRtKoMziak7A9hriiTdK2bvP2X
 kieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7jKn/glfJZ7+q4vbaBGW+VsR/O9vJnh77TasloERjnU=;
 b=ihKNNEX8BiDJZ1pHBuz/IlJNf0wLZNpCKct2jJpI2GU4nEIZ62NjQEeXyqirp6Bb/F
 U4ax1xMvQ8sNSoCyIXE+r0WwmIm4d2g7ZMR63uqWf9JtZwas2TN9bK803rjQLX9CmcMP
 oj0zBENxCXIz6fv2D2NF/MEi6EKNClBXxNJ5PXmubrioEcVyJjPmRl2QvkYQmhSZHfvY
 TQS4rfZ/ZGBOQW2A+tqEI7Q+7/Kq7ajmmbj4MUL6wLED6zl038oBG8DfERT3tSSdVI92
 n5CQ9QMvAXF8Z+vJhV6q9No2DYaEW/8d6VfK/hvvqXxdOXsSXNWlcw1cnQL+WsGeKTtY
 km8A==
X-Gm-Message-State: APjAAAUCDTH76jif/3AV+PS1CtPXePNsbujT1DX0qeXKii27btJik6eH
 d3lsH+/wW8AsEQiRqbnb4ARTzPW/fYmONcSf5W6WEw==
X-Google-Smtp-Source: APXvYqxys8p5KfJxSAGN4UbKf3JOkoF34nr7JxAMgjj0jVyFWKpXZB4UaR7zkOtZUD9zzFBcS4KYwOY9i1dNXPCnHxU=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr8803580otk.221.1561990890402; 
 Mon, 01 Jul 2019 07:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190625121421.22280-1-shameerali.kolothum.thodi@huawei.com>
 <20190625121421.22280-5-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20190625121421.22280-5-shameerali.kolothum.thodi@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 15:21:19 +0100
Message-ID: <CAFEAcA8TgTeia99880_CyEircQY_2cAnNQ-TPbaizh32+gqNag@mail.gmail.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v6 4/8] hw/arm/virt: Add memory hotplug
 framework
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
Cc: Samuel Ortiz <sameo@linux.intel.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Xu Wei <xuwei5@hisilicon.com>,
 Linuxarm <linuxarm@huawei.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Igor Mammedov <imammedo@redhat.com>,
 sebastien.boeuf@intel.com, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Jun 2019 at 13:15, Shameer Kolothum
<shameerali.kolothum.thodi@huawei.com> wrote:
>
> From: Eric Auger <eric.auger@redhat.com>
>
> This patch adds the memory hot-plug/hot-unplug infrastructure
> in machvirt. The device memory is not yet exposed to the Guest
> either through DT or ACPI and hence both cold/hot plug of memory
> is explicitly disabled for now.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

