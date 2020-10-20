Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A326C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:30:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70D7722242
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lwU7Q2Gg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D7722242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpq4-0006JP-92
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUpoF-0004gs-EO
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 07:28:07 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:35032)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUpoD-0001dS-PW
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 07:28:07 -0400
Received: by mail-ed1-x543.google.com with SMTP id cq12so1447806edb.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 04:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Pt+QhO+deaAVcVZrNp3M1mMZwIEtRPo3Vp3HQGR5eY8=;
 b=lwU7Q2GgHH+IKRFxMPqH/yVpPgaSdAlEHLJF3VNsdsFuUqui2ncY+vmYoUbTKT+EYV
 5vyZqcydTvdnv71nWwU6mg0kMJ29fdWsopWPV4V/oH+aDIX71mYGW1MExSi1KA/rD+DK
 np1R/vJl7xE9O8mw3ntQk6uSbqqdPuNCvas7Q0qL8VvvN7QSQRlP4h5N6arnAaxhMIp5
 8/s7Tb40RqLQS5K/mezN43x2VKDlz9/uY9UEMQE8x9lC72xSlM2A1VKLAu4TYzRreufZ
 z7Lzx7bfZLownavSkqT3aXMPoKJ6ASnP8rbUbUdc/sQoKKPc/J1R8e0To6NZ77RKMfRN
 c8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Pt+QhO+deaAVcVZrNp3M1mMZwIEtRPo3Vp3HQGR5eY8=;
 b=T2XrXwlYhbF4Uoq1WAYGD5JluB9CpvC3y4Un+wUKbuYFjXfdVM/FVnsIXTJ1iP1Jxr
 EOCjGdWAI+EDlH7XcJfMlbNmvMLlOEjFIm+Ez5FeDMHQ6XPgr2lLs6HVS75OE04FnAf1
 EsfuGxuUv8BRSTqQtsxDjY1WZ4YWyX0PYfaZzQg4nRImBuj1Is4lH77U2fsn+mIKYJxU
 C8GilXzLCZZW6x45E117jNlPHGCwF9DCeYs2cpNPnlJGvrgrDFToDvEYVxM1jR5EV4lH
 ZWhSqnFXjTzkX7pQQRfMQ1Ftdn+o6bx123LhsbTI1LH/qiudB+ceGizW+elb9TRp/WpJ
 y1Fg==
X-Gm-Message-State: AOAM5329QvnfxPwaXLIMKNqXKOcZvNl02Mmq0kLjfdDa3kXesPdVlrT0
 Mpm2nTldcJk/4rFpwllBzI88ytRU7o013HNTa6T/TA==
X-Google-Smtp-Source: ABdhPJzmtEDVviKMHOvo/obvV3Qn8XBofPCVXD9k4DWtFxgxfsOIDYBRTs1A4Fuq8AE8DnH5U7pNY+8tDWxXuOiRE6Q=
X-Received: by 2002:a05:6402:3133:: with SMTP id
 dd19mr2338027edb.100.1603193283909; 
 Tue, 20 Oct 2020 04:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201019093401.2993833-1-liangpeng10@huawei.com>
 <786deb83-b6f4-d778-d5ed-19f3901ad211@redhat.com>
 <0c174303-50bc-128a-26ab-c062f98cd6cd@huawei.com>
In-Reply-To: <0c174303-50bc-128a-26ab-c062f98cd6cd@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2020 12:27:52 +0100
Message-ID: <CAFEAcA_AQ5V4ZrWYjCD3DcnUGFsA-HBDWsQZ=SAQh6hydoa-kw@mail.gmail.com>
Subject: Re: [PATCH] microbit_i2c: Fix coredump when dump-vmstate
To: Peng Liang <liangpeng10@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Xiangyou Xie <xiexiangyou@huawei.com>,
 qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Oct 2020 at 12:17, Peng Liang <liangpeng10@huawei.com> wrote:
>
> On 10/19/2020 6:35 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 10/19/20 11:34 AM, Peng Liang wrote:
> >> VMStateDescription.fields should be end with VMSTATE_END_OF_LIST().
> >> However, microbit_i2c_vmstate doesn't follow it.  Let's change it.
> >
> > It might be easy to add a Coccinelle script to avoid future errors.
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >
>
> I tried to add a Coccinelle script to add VMSTATE_END_OF_LIST() to the
> end of VMStateDescription.fields.  For those who are not defined as
> compound literals, it works well.  However, I cannot make it work for
> those defined as compound literals.  And Julia doesn't think compound
> literals are supported currently[1].  So maybe currently it's hard to
> check the error using Coccinelle :(

I think we could probably significantly increase the chances that
people find "missing terminator" errors in the course of normal
debugging of their device if we made the terminator be something
other than "is field->name NULL". That condition is quite likely
to be satisfied by accident shortly after the real end-of-data
(because zeroes are easy to find in memory), whereas if the condition
is "field->flags is a magic number", for instance, then the chances of
it being satisfied by accident are very low, and so a simple "loop
through the field array until we find the end" is pretty likely to
hang/crash. (If we don't already have such a loop we might need to
add one in debug mode when a vmstate is registered.)

(This is why the REGINFO_SENTINEL used for Arm cpreg arrays is
not a simple all-zeroes value, incidentally.)

thanks
-- PMM

