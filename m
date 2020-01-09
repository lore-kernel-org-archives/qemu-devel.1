Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99093C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED692067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVl1xfc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED692067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipYVy-0003SW-GB
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 09:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1ipYVJ-0002fV-3z
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:09:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1ipYVG-0007IO-UD
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:09:39 -0500
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c]:40911)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ipYVG-0007FV-Ow
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:09:38 -0500
Received: by mail-qv1-xf2c.google.com with SMTP id dp13so2979815qvb.7
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 06:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=8QV7o4T8Kss98lTXcXIWTfPETRl9+zSe6fXYbXvevAE=;
 b=sVl1xfc92GZB4kAfdA95fiar9VBggNsLhQkfEKj9Q9LzM+VDUW6jhJ7k5c2KpTr6ol
 hiYaVAOdZsSn3BszeMPd7ftyMSSGOQYfe9sSxIVJx9P6m0XfXdU2PZSmOwi4l+I8kYSl
 YcgqGbVRQqYMBBqwa6gVj+E594Gt9alpWR9fp1ao57eHWQt5UTid3zYD7O+dUwTVCgdQ
 LeP38UTL8FmbB48k87CBC9E6z6JrFK7jRVs/qocaIREjmH0GOVWb4aqutThiPSZwFzze
 M9CQmSe5QCIYJVFT8wJ/VUFNYvbMxy7MqICG+rq7UBaML9G3MXPmyzdq/VXZNzTfxhQ7
 G0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=8QV7o4T8Kss98lTXcXIWTfPETRl9+zSe6fXYbXvevAE=;
 b=mN/Vy8+WlJHb1QYmIxCIB9IJa6dfpUrftnVc/mSLvfV65Y4lEDov4jLoTU2dymt4qV
 DtZOdY4Stoe8ha9Hudh9nv+InDHxjNveKFG4EP2JG4aV2MNM4Yv6v9pIVxnKyyWutyKB
 bHc3dUHij4hS5MOhhkRAp4RHZun3gGqttZzmkNDaPLJ5bWuwqfX4RVDtIozAPzF/mvw6
 biT0hjwqKLnwbJApEFXdJk9Y+4IATsPhsXAGAGzQ9RyFOea/M1P8IcIxAACCzv8HNvwr
 9hN3F9PoY021DvFYTgzG4/f3NsxYYyuplQo0dVari8BLkxWYAc35AaAmtudQeHNDpzf3
 obQw==
X-Gm-Message-State: APjAAAV516STbw6V0e0AwvNa5w5X80FcD5W9jSMH4/SBV4rJeiFqTGeP
 Hs6CQ10D9QYElOILPkiGJmw4C5cHaac+OiuqgqSQApQkm+A=
X-Google-Smtp-Source: APXvYqx0MbY7XXKZZAhD1Uu31ENSh4p0PVArt3wjQGqvodtCD64KSLHLzPYXWV2rCkeCFoEjvHE+TDS5W3E5kMcQ2PM=
X-Received: by 2002:a05:6214:982:: with SMTP id
 dt2mr8622222qvb.174.1578578977711; 
 Thu, 09 Jan 2020 06:09:37 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 9 Jan 2020 14:09:23 +0000
Message-ID: <CAJSP0QWysOZdp88vqJSQ-7J8tPk6OdaSL2WDLetJ5+YXsNH-UA@mail.gmail.com>
Subject: Call for Google Summer of Code 2020 project ideas
To: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 rust-vmm@lists.opendev.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f2c
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 David Hildenbrand <david@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Alistair Francis <alistair23@gmail.com>, Yuval Shaia <yuval.shaia@oracle.com>,
 Valentine Sinitsyn <valentine.sinitsyn@gmail.com>,
 Alexander Graf <agraf@csgraf.de>, Jan Kiszka <jan.kiszka@web.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Dear QEMU, KVM, and rust-vmm community,
QEMU will apply for Google Summer of Code
(https://summerofcode.withgoogle.com/) again this year.  This internship
program offers full-time, paid, 12-week, remote work internships for
contributing to open source.  QEMU can act as an umbrella organization
for KVM kernel and rust-vmm projects too.

Please post project ideas on the QEMU wiki before February 1st:
https://wiki.qemu.org/Google_Summer_of_Code_2020

Good project ideas are suitable for 12 weeks of full-time work by a
competent programmer who is not yet familiar with the codebase.  In
addition, they are:
 * Well-defined - the scope is clear
 * Self-contained - there are few dependencies
 * Uncontroversial - they are acceptable to the community
 * Incremental - they produce deliverables along the way

Feel free to post ideas even if you are unable to mentor the project.
It doesn't hurt to share the idea!

I will review project ideas and keep you up-to-date on QEMU's
acceptance into GSoC.

For more background on QEMU internships, check out this video:
https://www.youtube.com/watch?v=xNVCX7YMUL8

Stefan

