Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01F9C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9AE42072A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cx35nYTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9AE42072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBFNW-0002Ok-S2
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 06:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBFMb-0001ZM-JH
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBFMa-0001n6-1X
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:10:21 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:32933)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBFMZ-0001mz-RA
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:10:19 -0400
Received: by mail-ot1-x343.google.com with SMTP id g15so2865466otr.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 03:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0ywiZYF7qhTho7uI2vz897KGVViaQEWNttpFFbiZl5s=;
 b=Cx35nYTTtFHLAv8j7Oy/d1qwc7yRoSCMOQnpoPTjWm+X1wLwvKtppMIml3wtpRi9gH
 TXGFvpTw202I3T/bINkSrqO5dP/7Zu2f8CuqA86ZplEJYbR0raFwga9V2g9lI0mlgkma
 MndmcS2QPuFeoIHgJOheuZ4jKsS+zZ+3YbkuQpvyTHBmHByf6nQhreT7hO8aTR0muqaU
 GtADjEPVJ8mzKr+MlpiI8URyExk9bixE1jGLjSOkDanKKydQaJH+5m3V96+JqQbMAm13
 Wey0jEzgsb+qw9y4qbepFuYhOs3khkuI0/we35ar4K6U4r2zyLYnKFcEn0WsWaZZoKgk
 C1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0ywiZYF7qhTho7uI2vz897KGVViaQEWNttpFFbiZl5s=;
 b=OF0/41C9dFptk7x4obryBk5nqu8N9LAch3cHUIxW5cp0QA/9F+vJIdY9e0XvMyjqvz
 ++zZ1EZM47h2wL3jGGgFn3wHXnd7oYQR6GyjbShY3XoFoOUt7cQB+CSWNByEFGBcRCEk
 m8ZdaKj/dOQ1s/iYTLFBXE6fa6rX4d65U2aHWHNoxpqcm2SQtTZwh3dsnMSHhAX5CaST
 9tjzfdwlRKFHm9iJ4wR+lbmkNHA06Ttd3r9Jrd8KdRtsLTQ8DhPGHfYjdyMGixDjquR1
 NzBOCTVQfaw0tqt+oW+frDeQKA4y9mbFhieV14Jc/QIV/oAVnPUwl8zgCpBxKiPIur8E
 fTwA==
X-Gm-Message-State: ANhLgQ14iRErAuZWAdwa/qh7Kuvv/ECiKXtlbA9EfSzE1TZqY8+H4AQE
 BS3Nn816N/8XTbikAVr0lxkg9RtMSuH4Zrf7NayTdA==
X-Google-Smtp-Source: ADFU+vupu/WCreOn5EojS+tXVkYD2zdTWayJ2pgnv9DhiirD/Ft31lDDTSEwZdVW662qhBCyEfSvvHUC5l0bMnTQm3g=
X-Received: by 2002:a9d:6f88:: with SMTP id h8mr12464290otq.91.1583748618763; 
 Mon, 09 Mar 2020 03:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-3-pannengyuan@huawei.com>
 <CAFEAcA_twjUHpvf5ZpzA_bKyf8MZ4BuSY0MvNTgSEyVTYf9mXQ@mail.gmail.com>
 <0b2d3222-d122-e0db-db04-1c4e3028f8f8@huawei.com>
 <CAFEAcA9PQd=PwuF+j=3kOA_eCiRd_8TLEwPx8qB-jWvV_9CcMQ@mail.gmail.com>
 <0c3ae5aa-36c3-a809-4a42-159348f44780@huawei.com>
In-Reply-To: <0c3ae5aa-36c3-a809-4a42-159348f44780@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2020 10:10:07 +0000
Message-ID: <CAFEAcA8_RkECOT=YJ3ML0wxBrKiqVw=CssORU=jyryfcNueB0w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mac_via: fix incorrect creation of mos6522 device
 in mac_via
To: Pan Nengyuan <pannengyuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
 Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Mar 2020 at 10:02, Pan Nengyuan <pannengyuan@huawei.com> wrote:
> On 3/9/2020 5:21 PM, Peter Maydell wrote:
> > Could you explain more? My thought is that we should be using
> > sysbus_init_child_obj() and we should be doing it in the init method.
> > Why does that break the tests ? It's the same thing various other
> > devices do.
>
> device-introspect-test do the follow check for each device type:
>
>     qtree_start = qtest_hmp(qts, "info qtree");
>     ...
>     qtest_qmp(qts, "{'execute': 'device-list-properties','arguments': {'typename': %s}}", type);
>     ...
>     qtree_end = qtest_hmp(qts, "info qtree");
>     g_assert_cmpstr(qtree_start, ==, qtree_end);
>
> If we do qdev_set_parent_bus in init, it will check fail when type = 'mac_via'.
> mac_via_init() is called by q800_init(). But it will not be called in qtest(-machine none) in the step qtree_start.
> And after we call 'device-list-properties', mac_via_init() was called and set dev parent bus. We can find these
> devices in the qtree_end. So it break the test on the assert.

Markus, do you know what's happening here? Why is
trying to use sysbus_init_child_obj() breaking the
device-introspect-test for this particular device,
but fine for the other places where we use it?
(Maybe we're accidentally leaking a reference to
something so the sub-device stays on the sysbus
when it should have removed itself when the
device was deinited ?)

> Here is the output:
>
> # Testing device 'mac_via'
>   adb.0=<child<apple-desktop-bus>>
>   drive=<str>            - Node name or ID of a block device to use as a backend
>   irq[0]=<link<irq>>
>   irq[1]=<link<irq>>
>   mac-via[0]=<child<qemu:memory-region>>
>   via1=<child<mos6522-q800-via1>>
>   via1[0]=<child<qemu:memory-region>>
>   via2=<child<mos6522-q800-via2>>
>   via2[0]=<child<qemu:memory-region>>
> qtree_start: bus: main-system-bus
>   type System
>
> qtree_end: bus: main-system-bus
>   type System
>   dev: mos6522-q800-via2, id ""
>     gpio-in "via2-irq" 8
>     gpio-out "sysbus-irq" 1
>     frequency = 0 (0x0)
>     mmio ffffffffffffffff/0000000000000010
>   dev: mos6522-q800-via1, id ""
>     gpio-in "via1-irq" 8
>     gpio-out "sysbus-irq" 1
>     frequency = 0 (0x0)
>     mmio ffffffffffffffff/0000000000000010

thanks
-- PMM

