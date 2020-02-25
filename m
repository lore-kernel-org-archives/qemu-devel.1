Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719A6C35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 08:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CD0E2176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 08:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r/7xbz4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD0E2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Vza-0000W9-Dq
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 03:55:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6Vyy-0008PJ-H7
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 03:54:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6Vyu-0002Ys-BN
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 03:54:24 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42697)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6Vyu-0002YW-5w
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 03:54:20 -0500
Received: by mail-oi1-x243.google.com with SMTP id j132so11820486oih.9
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 00:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dqnKylF5HFciLFPtzz1NDtnvwRMuPol2Wp3vrExVO8g=;
 b=r/7xbz4aNyNr6RwlvL1OOZ+M+zLNU9Cc+UexnSCQaVAj4vHZSufgfP+s8331MkLPSJ
 l84ei7nkwF35uRylrZJ2oRvbhoiqGrrbjTMnOlW4BawnB/99ZJdaDyBVllJAt5gw+XTf
 6LIhJnlf845GVqJ9gPYy2drqFQWq+Yjho3O//FMro753kBrwTpevhEQ0KdGwrh2GMqOf
 aW6HQWTpXqECuqBr/SRKdV7QPCFPFZiQVR9SOmkvGL63QkdSO200bd+Wy2SMBislYrN1
 e3x7+uLfaiEAJa0zBmnBBwq/rILbX1mtC/KuIY88Gs+SZTzlSSCjgxBnLnbFL9I7fbig
 tGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dqnKylF5HFciLFPtzz1NDtnvwRMuPol2Wp3vrExVO8g=;
 b=cCd6+GXKbf5V5c2n7UF7eDH2TU0rGt6JqSrw3glOGeyKf2fp2LXIQZ0lSUYgN75a0C
 7e1yvTdbSvqulHQkWUhcSJ3Yl5CBQJi5Hxu/C2ap4VngITxzImjlwqrv1ULEx3VXRjUz
 B2SyxOcazp4CYNytE76lrGR9lQuPF+p+48Rp6ahQC9axf0NuvO4oohZFmuVpLEXCxge8
 NOLC+7OuQzPF+76y6SMv8nybCGoGSz3yVA7Pv/ZTEMubNNNf7pyNmr3mZyysXsNtoOUD
 7U2NtpvdXuObyDKIJZ/tRuT6W9k4E5xGYKBvqQ3E0LwFRRCMWRlpdGnrHZcFTsEukIfe
 q9nA==
X-Gm-Message-State: APjAAAX1S3q84EzDmZHMpcimYWDdWlHGlssPmJjZLyfkP6XgTFi5/wGa
 zXuofuzWeU/GI+t8NSuUKI1E4av7IC5kd0QBBwdRDQ==
X-Google-Smtp-Source: APXvYqz1X4gKcqOGaHJxF0nPqlbmz+VSqPW4ohODe1uOe7nVvHt5fIfMXWxzofk/ZJQybB1LVNMHhkz4bzuTBWcXaWQ=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr2579495oic.48.1582620859074; 
 Tue, 25 Feb 2020 00:54:19 -0800 (PST)
MIME-Version: 1.0
References: <20200217131248.28273-1-gengdongjiu@huawei.com>
 <20200217131248.28273-3-gengdongjiu@huawei.com>
 <20200225093404.0ee40224@redhat.com>
In-Reply-To: <20200225093404.0ee40224@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 08:54:07 +0000
Message-ID: <CAFEAcA9zjoa48Mth5aaOnhjDyY_qyrg9Nz5=0YEa2aE_aFcCug@mail.gmail.com>
Subject: Re: [PATCH v24 02/10] hw/arm/virt: Introduce a RAS machine option
To: Igor Mammedov <imammedo@redhat.com>
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
 Eduardo Habkost <ehabkost@redhat.com>, Dongjiu Geng <gengdongjiu@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zheng Xiang <zhengxiang9@huawei.com>,
 qemu-arm <qemu-arm@nongnu.org>, James Morse <james.morse@arm.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 at 08:34, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Mon, 17 Feb 2020 21:12:40 +0800
> Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>
> > RAS Virtualization feature is not supported now, so add a RAS machine
>
> > option and disable it by default.
>              ^^^^
>
> this doesn't match the patch.

Hmm? It seems right to me -- the patch adds a machine option
and makes it disabled-by-default, doesn't it?

thanks
-- PMM

