Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C031C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56160206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dggdq2I5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56160206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZDOx-00089X-GW
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 08:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZDOG-0007d5-0n
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:55:08 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:45163)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZDOE-0002Rx-OV
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:55:07 -0400
Received: by mail-oo1-xc41.google.com with SMTP id p123so676675oop.12
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 05:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pgtt5Vf9zWMqvz7dLR73SNJzPhJc8IatImZjfB7FsGU=;
 b=dggdq2I5kB1qHEbRhH2y9FUFYmA+BcYOSxAv16sQgM+lRq4O3JlNWCeSnTddckGwwE
 yEDtiE9UluJTDFoixXn2SdrNmfMmAIULxwH32X7pNSLbbfTBIV6oeOkQchO+ofon9WO/
 zr9FSOej+NjMsr3VaLJP5wBrbH5nyxH6LBwWmkeTf5AxSc6rfPluyFKBqqtT+A0Z7Fb1
 C+1vu9hM5aBRZYmMcwDF/OkzUMfkhcv9UEXD/YYu9as+fTDejbQN8YIkTMG4C3mRBBjn
 JX3P7h3vgte08GxfIcc4ZtZEyKKUvGEJ63bpm2O/yIi2WtCyCiHcrM0hEiZ1y0VK/PEw
 BeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pgtt5Vf9zWMqvz7dLR73SNJzPhJc8IatImZjfB7FsGU=;
 b=QLwEG+pXY4NAY4RcmF9I4o/X4seNzQSSnrf0N/YyCBx5zTUg9Z4tc3zu6FbHnhVlTy
 6uRT9dacoXXFDcHRTVvqakrI+dccROo04dcVrAkSsUOqjWfYXEClgTC07iVsFtoa7vMl
 om5s6BG5s53qJNEuyBrGwcEk6x1LB2FWO1blJW6Jslg+Ychu09c4xP4HN0nya4LvjV6f
 b52Gz4sF7fdwXsZn2hzD2Txa4agvXbwKtS9I1ynYkW8e39mFnG5HBI7xBYr520jUsXEr
 h79j3VeGTe61QkPVNNjExU9sKu/emPAir2VeIw1u8S6dqbTIXhpVlyv3k3xiqf7jlAqi
 70MQ==
X-Gm-Message-State: AOAM532pRHX8IkJEEdukYUzNQ8+j5R05b++bj6QIIOrn6Va431FPEBwp
 dbCSUtrXQ/Cx/xUVepXlO00gYwZVhH5FS2IyPHRpOA==
X-Google-Smtp-Source: ABdhPJxfg97fMhIoChgFSU3gDahfzlhN0H+q+D4mK6npyKHUqsWmCzAT2+06SICQ6kodfA+es7/T0Roz7A1Gj/YhzB0=
X-Received: by 2002:a4a:d136:: with SMTP id n22mr3413007oor.85.1589460905312; 
 Thu, 14 May 2020 05:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200512030609.19593-1-gengdongjiu@huawei.com>
In-Reply-To: <20200512030609.19593-1-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 May 2020 13:54:54 +0100
Message-ID: <CAFEAcA-=pVwNXR0mqCBX1MRkzTOzxOFF_caxYSsCbiA_bq4OQA@mail.gmail.com>
Subject: Re: [PATCH v27 00/10] Add ARMv8 RAS virtualization support in QEMU
To: Dongjiu Geng <gengdongjiu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 Eduardo Habkost <ehabkost@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zheng Xiang <zhengxiang9@huawei.com>,
 qemu-arm <qemu-arm@nongnu.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 May 2020 at 04:03, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>
> In the ARMv8 platform, the CPU error types includes synchronous external abort(SEA)
> and SError Interrupt (SEI). If exception happens in guest, host does not know the detailed
> information of guest, so it is expected that guest can do the recovery. For example, if an
> exception happens in a guest user-space application, host does not know which application
> encounters errors, only guest knows it.
>
> For the ARMv8 SEA/SEI, KVM or host kernel delivers SIGBUS to notify userspace.
> After user space gets the notification, it will record the CPER into guest GHES
> buffer and inject an exception or IRQ to guest.
>
> In the current implementation, if the type of SIGBUS is BUS_MCEERR_AR, we will
> treat it as a synchronous exception, and notify guest with ARMv8 SEA
> notification type after recording CPER into guest.



Applied to target-arm.next, thanks.

-- PMM

