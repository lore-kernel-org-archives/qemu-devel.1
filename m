Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E04EC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 09:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494F320727
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 09:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ccjbiq+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494F320727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBEdI-0002mO-E5
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 05:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBEbY-0000RC-8N
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 05:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBEbX-0002Ga-2B
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 05:21:43 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38586)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBEbW-0002GH-RQ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 05:21:43 -0400
Received: by mail-ot1-x344.google.com with SMTP id i14so8863331otp.5
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 02:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AHAHIhwFKs2k8PQfvg9sekLc+EdY0MRJArKE4TiyhMk=;
 b=ccjbiq+L6VUbhQPKNgIh3Dg2VtniXMnxS2HZVafcLPfQ/ztgcqlBCkLN/Jb/GewEB5
 1vRtrWGCSz+IJjm0WbjF+iLtl7LKQr8A0Fesc5QjAzROhhoxJEbNYwOtWpC/WH85P25H
 qL9Voa+K4NjS8RntX9Vh6dMl5Qw0Ias7y3m8aJVqsyepfVpqiH5wRJCDWXtN6ISvRiB/
 N6Mb172vTz5QsgfPwbJ7ZNXoSStJfyt2B9nDSmf41z9fqBJXGCTEVqOcUH4m+OwNB+t2
 yLXanybggdzECxrjB+ODch+MlIt+bmO8glZJBC9f8bs6tfChml9zc9ThI4UvmU45/fgD
 U7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AHAHIhwFKs2k8PQfvg9sekLc+EdY0MRJArKE4TiyhMk=;
 b=ZL1jSDLCUcigDVyNJ8/wqbL1m6kkYicJFilxBlH45f0NFq0/+jPPHEIKs75VM0kS3T
 EXLVFlXQbUWwNS7L1DWkYEWk2Aukq6DafMvLNFcCpLFMSfTtwourSZjxgv4OUMjaLu/1
 s8vwyTsQan2tuDJFiGFSfixZDXD4bKCHIXXx198D93MfrvgOy7OMztJ80NODNRjy93pf
 NtW/czddpz9c7+oZc224CkNo+BXRv8SJTiE/1t5eaD4N/rGz3ExjywFSW7KsQ3ZCyeFN
 ldnC8PYkrPb59R+R5pb4XGnb+j8sNVJgfmrHJXkcx1FzCAARdavfBBAxsrzEy4MytuYI
 MzHg==
X-Gm-Message-State: ANhLgQ1ZE+tPY/goiLVwjoSpck09/xd/ltQX4fVrpLaKdlhvturAtTTh
 s5HFwQC89MOhT7ha3BoswnUbUlBGZsy+3VlLdOvWGw==
X-Google-Smtp-Source: ADFU+vso+6lDlFwhsMcwMjSQc8EZY/JEfefYfwNk9Lz6HyEpUXtUZB9r3EabCofvyoBclHw3FryNZmzpESCUyUNArTg=
X-Received: by 2002:a9d:76c9:: with SMTP id p9mr12300099otl.135.1583745701474; 
 Mon, 09 Mar 2020 02:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-3-pannengyuan@huawei.com>
 <CAFEAcA_twjUHpvf5ZpzA_bKyf8MZ4BuSY0MvNTgSEyVTYf9mXQ@mail.gmail.com>
 <0b2d3222-d122-e0db-db04-1c4e3028f8f8@huawei.com>
In-Reply-To: <0b2d3222-d122-e0db-db04-1c4e3028f8f8@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2020 09:21:30 +0000
Message-ID: <CAFEAcA9PQd=PwuF+j=3kOA_eCiRd_8TLEwPx8qB-jWvV_9CcMQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mac_via: fix incorrect creation of mos6522 device
 in mac_via
To: Pan Nengyuan <pannengyuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Laurent Vivier <laurent@vivier.eu>, Euler Robot <euler.robot@huawei.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Mar 2020 at 00:56, Pan Nengyuan <pannengyuan@huawei.com> wrote:
>
>
>
> On 3/8/2020 9:29 PM, Peter Maydell wrote:
> > On Thu, 5 Mar 2020 at 06:39, Pan Nengyuan <pannengyuan@huawei.com> wrote:
> >> -    /* Init VIAs 1 and 2 */
> >> -    sysbus_init_child_obj(OBJECT(dev), "via1", &m->mos6522_via1,
> >> -                          sizeof(m->mos6522_via1), TYPE_MOS6522_Q800_VIA1);
> >> +    qdev_set_parent_bus(DEVICE(&m->mos6522_via1), sysbus_get_default());
> >> +    qdev_set_parent_bus(DEVICE(&m->mos6522_via2), sysbus_get_default());
> >
> > Rather than manually setting the parent bus, you can use
> > sysbus_init_child_obj() instead of object_initialize_child() --
> > it is a convenience function that does both object_initialize_child()
> > and qdev_set_parent_bus() for you.
>
> Actually I used sysbus_init_child_obj() first, but it will fail to run device-introspect-test.
> Because qdev_set_parent_bus() will change 'info qtree' after we call 'device-list-properties'.
> Thus, I do it in the realize.

Could you explain more? My thought is that we should be using
sysbus_init_child_obj() and we should be doing it in the init method.
Why does that break the tests ? It's the same thing various other
devices do.

thanks
-- PMM

