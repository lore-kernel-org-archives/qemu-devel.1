Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB27CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 029FE214B2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d3gLT2gn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029FE214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP5Je-0007nL-Tc
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 09:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iP4oK-0008Dn-47
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 09:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iP4oI-0005FY-QS
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 09:11:51 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34873)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iP4oI-0005F7-MT
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 09:11:50 -0400
Received: by mail-oi1-x242.google.com with SMTP id n16so3548006oig.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 06:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HyBAqeapYuxtXuJfIQdZix/p7r93MkELXxCsBd6FUY0=;
 b=d3gLT2gnqwgF4vTsJWZG2UcUvIo2shVw4quoZlQ619do68aYEqet/Gkytufd9Y47QW
 1OAJLtOmor5P3hloUEhEgf1qewgfieyCwLY/J2el3oBg4D2RpG1SHN8njt5GE6oXY1ZA
 5wI0j/gyjN8QMZliHHlHIQJSlw6uUPP87ylJyqDQM7JseBWpS7pexOdBdpYZZSHR8GQ6
 K3GVtBiJ+tCFru3960DZtJr54RnHX5rOP/DDry7XYs7WfAlcKKiqKTdJiQ22t7BjXqBS
 awciiSNMtPxFW3ca9QA68yNiRKvLZP2RaDmJJxT9vAIHLKshpAtfvZXNN2bY1QyqDDle
 ZXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HyBAqeapYuxtXuJfIQdZix/p7r93MkELXxCsBd6FUY0=;
 b=IWYiI0go/GCBaiueBULMrj2OrnREQugLp3mNP2y52F2O/YmnA5tKo59aSOUzdTKayD
 AQG6IKGjcbWgALR0GjorwZnN8DJASxow+kWAcdJaLgosw0sd6Dkz3YfSNOmA9zSfapYu
 yBPOpe75YYTF55MKhBx4tSe6GK7CI+ycRXX12Fdu5fs4ivsQ2NWIJWWxpl7sgIwMaITp
 ay9khpKd4ZC3Nu2fnYdhKyE0OPiA0rNc3HQbMXOtelRNjJbqn2aOgpKfPJK3tkyvTB17
 WmRwSyfT6GrdfcujTvck35b5VukZEkZocihHwnGLPfCFVVlVgoNQJpEqH5RhJHvHqRTQ
 8EaA==
X-Gm-Message-State: APjAAAWcK9ZK/wBliZ6F1IDBs60m+lMEP8NFjk2is7qWDvK/zMiT/dBP
 M/nyZ9UNKBmdiri8EjBTDmwtQ1MlzNUPqMnrBcZupA==
X-Google-Smtp-Source: APXvYqwVpkGGXygFILUaoGHg5RHvXOv0ZlsxyMz9ioegP3kMBRg6K49wBY1vUSlOnuTspz71c9XrupumfPXIVhI0G60=
X-Received: by 2002:aca:3b41:: with SMTP id i62mr13367511oia.48.1572268309051; 
 Mon, 28 Oct 2019 06:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191026032447.20088-1-zhengxiang9@huawei.com>
 <20191027061450-mutt-send-email-mst@kernel.org>
In-Reply-To: <20191027061450-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Oct 2019 13:11:48 +0000
Message-ID: <CAFEAcA-gkBFgqYfFOPera15x2cK_a54Abw_0Gad1Jq+tGcC8rQ@mail.gmail.com>
Subject: Re: [PATCH v20 0/5] Add ARMv8 RAS virtualization support in QEMU
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 wanghaibin.wang@huawei.com, Marcelo Tosatti <mtosatti@redhat.com>,
 Linuxarm <linuxarm@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>,
 gengdongjiu <gengdongjiu@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Xiang Zheng <zhengxiang9@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "xuwei \(O\)" <xuwei5@huawei.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 27 Oct 2019 at 10:17, Michael S. Tsirkin <mst@redhat.com> wrote:
> This looks mostly OK to me.  I sent some minor style comments but they
> can be addressed by follow up patches.
>
> Maybe it's a good idea to merge this before soft freeze to make sure it
> gets some testing.  I'll leave this decision to the ARM maintainer.  For
> ACPI parts:
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Thanks for the review. Unfortunately this has missed the softfreeze,
given I'm away for the conference already and not in a position
to do any more review/merging of arm stuff. It'll have to wait for 5.0.

thanks
-- PMM

