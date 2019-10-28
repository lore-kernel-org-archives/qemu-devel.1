Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D35CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C529E21783
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uAibY66C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C529E21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP6xo-00081J-Ga
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 11:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iP6qj-0008O4-69
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iP6lP-0006Rm-Is
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:17:00 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41413)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iP6lP-0006P1-DL
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:16:59 -0400
Received: by mail-ot1-x342.google.com with SMTP id 94so6918558oty.8
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 08:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b3W8+Qp16hmsb7/JhtK8PXuOeb3m3ErHdyA5OPSEtIk=;
 b=uAibY66Cn5eqjLRfWcMvqp6bm84T/njNNWYsekP/MKFcRDuKTn6JlJTDmvhB+ZuMVC
 JqY1mF24mP+Q01BlOdZpS47rfjlTzUC54gSN589nwK50xAPrMwmbVnFVa5GbudhTXsO8
 3Jjq72jE17k85mdGDAVVued3ug04Jg8/PwdJOsw8e7RcgD5BmZQjh5uDcOrr4qKXoDSI
 I2HivvV1/6Kl26NEnNvzsASBXDkN+tqOMtYG2Moeg+VFEaJOiB1YAZR/jRA4s4CG6dVO
 df7akOVvV5rMiJzF0FHqEtzyf3kyutnWGOg3GFzLLN/8dCgxz6RBJTOvBKNNgO3YI+e7
 tAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b3W8+Qp16hmsb7/JhtK8PXuOeb3m3ErHdyA5OPSEtIk=;
 b=K3aY7pUrpbF/weSXw9Am93EDEJI7oyXk6gnsG+lgM3BLZwaLvWBX/eEtV0+Ki5ceCI
 xxnPMx1y0XufMBxMvQ6tlmL7Q+7XtlKsNrVXPVeKfHrjoX4qN4H6vC4f1tzYTjaTpMPg
 7NHqNtnZqExyaY35z4dGHpuyRp0MZx9kUKHaFjhui56xjWCOeCFLO1r1Cx/Oc/b0Wj8k
 Wyfqla19ayhXTssUwtkLOKqiUSCreSbdKd36skvhcf5EBX/hrkCipF/x0Z9vgGd24X79
 Um5fWmFfXmLp+gW9hqWObT9Ip0o1+1dysvQYNZFJ5HhRjlC39ZoI/Zkk+ojAsnV84Grc
 6tLw==
X-Gm-Message-State: APjAAAVImPS64WIc2EyUjQ40p9JSsP3TTEOfuBksHc2SH5DcEeyEvson
 M8WJNWgG1ITU8a0Gau5Ttg0hZtwAEe7HRFyH7qLzXA==
X-Google-Smtp-Source: APXvYqwqqKJhg7rD9h45FcQj/MOCW1kI8o9v8PwLEaiJloqU8FA8MBujZefHAT4c+ZPqFdOMOqMj8n8/SIENvz5VnJ0=
X-Received: by 2002:a9d:7385:: with SMTP id j5mr4039306otk.135.1572275817240; 
 Mon, 28 Oct 2019 08:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191026032447.20088-1-zhengxiang9@huawei.com>
 <20191027061450-mutt-send-email-mst@kernel.org>
 <6c44268a-2676-3fa1-226d-29877b21dbea@huawei.com>
 <20191028042645-mutt-send-email-mst@kernel.org>
 <1edda59a-8b3d-1eec-659a-05356d55ed22@huawei.com>
 <20191028104834-mutt-send-email-mst@kernel.org>
 <a16f00df-98cd-3469-1c64-d9d7a6ccaccf@huawei.com>
In-Reply-To: <a16f00df-98cd-3469-1c64-d9d7a6ccaccf@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Oct 2019 15:16:56 +0000
Message-ID: <CAFEAcA9fTOoOpeHfnhgy1p-tXk3b8p-e8T02jWkhhBmjv3OnDA@mail.gmail.com>
Subject: Re: [PATCH v20 0/5] Add ARMv8 RAS virtualization support in QEMU
To: gengdongjiu <gengdongjiu@huawei.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Xiang Zheng <zhengxiang9@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>, "xuwei \(O\)" <xuwei5@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, wanghaibin.wang@huawei.com,
 Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Oct 2019 at 15:11, gengdongjiu <gengdongjiu@huawei.com> wrote:
>
> On 2019/10/28 22:56, Michael S. Tsirkin wrote:
> > On Mon, Oct 28, 2019 at 09:50:21PM +0800, gengdongjiu wrote:
> >> Hi Michael,
> >>
> >> On 2019/10/28 16:28, Michael S. Tsirkin wrote:
> >>>>> gets some testing.  I'll leave this decision to the ARM maintainer.  For
> >>>>> ACPI parts:
> >>>>>
> >>>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >>>> Got it, Thanks for the Reviewed-by from Michael.
> >>>>
> >>>> Hi Michael,
> >>>>   According to discussion with QEMU community, I finished and developed the whole ARM RAS virtualization solution, and introduce the ARM APEI table in the first time.
> >>>> For the newly created files, which are mainly about ARM APEI/GHES part,I would like to maintain them. If you agree it, whether I can add new maintainers[1]? thanks a lot.
> >>>>
> >>>>
> >>>> [1]:
> >>>> +ARM APEI Subsystem
> >>>> +M: Dongjiu Geng <gengdongjiu@huawei.com>
> >>>> +M: Xiang zheng <zhengxiang9@huawei.com>
> >>>> +L: qemu-arm@nongnu.org
> >>>> +S: Maintained
> >>>> +F: hw/acpi/acpi_ghes.c
> >>>>
> >>> I think for now you want to be a designated reviewer.  So I'd use an R:
> >>> tag.
> >>
> >>  Thanks for the reply.
> >>  I want to be a maintainer for my newly created files, so whether I can use M: tag. I would like to contribute some time to maintain that, thanks a lot.
> >
> > This will fundamentally be up to Peter.
>
> Thanks.
>
> Hi Peter,
>     what do you think about it?

I suggest you just use R: for the moment. The code will all end up going
through my tree or perhaps Michael's anyway, so it doesn't make much
practical difference.

thanks
-- PMM

