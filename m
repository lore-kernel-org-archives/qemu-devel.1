Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BE8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E85204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B2Pz5DLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E85204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwSfu-0008K0-7o
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 11:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwSfG-0007tW-WF
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 11:52:47 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwSfF-0003NZ-Bc
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 11:52:46 -0400
Received: by mail-ot1-x341.google.com with SMTP id c25so7195311otf.7
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 08:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2Su7mXGWVHZPd/RTpmWcNZI3IA1sdIYZzLSkWCaROGM=;
 b=B2Pz5DLQKq0CMG85jpHtt16Tw1dy+FYJWSUdNHOH093UI3mdibOArA52oYHSejAWH7
 z0PYZZiQJLgZAXuRPcdRIy2o09vXEv+LBlWghJQOp49GdL9YdXs/80mSK0H8yelIhc66
 7D1UPx8Vj31/FGnBnkw4ow3g+T1P44P1Ln2Gq7IkUSaGZjBvIgZjS+JlBagPDdq6lAmX
 HQUSFICC9/7eWdBOrH8HeEnUYPb/sjRFzvzG4StuB8tbat8ev6lYVBmGguxLV2YOYr7T
 nlc58Usnyes7zvcsKW/W9p3H698ApEimtJCbHFHd/20kNAgOx4GJHUj+4RDsD0taPKB7
 +YFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2Su7mXGWVHZPd/RTpmWcNZI3IA1sdIYZzLSkWCaROGM=;
 b=S6oF9kcnCv7RGKl5I0IomjNKoqboljYYhWkfNjhg8cqr5Or20gdh7QmMCA7UgX6k5s
 qH5f/ySeRkHrfgcrtMCBO41+b56IgmveUZ4VxLl7JqvgIKfQe2q/z+CFkNMWlQWwbFSl
 acDXDbyh+EqSwejWwEHAz2CjhNsjY04uR0X0VlXb0Gh7nOkddObnZGuFI4dLukVeeBJh
 Kokkn7u1rFi7i7vPHbuT0xM3NdsR4Ij7dhj0+8IPnTj9RDUr6uw5C+d1MXWdImK6a6tI
 JPxDSmMpYxiS4nr8rbpc4tdTK8ttcwduY0FsExTOCH8a2Eh3nYkEwVb9kaOaVuaGVEpZ
 Jm+w==
X-Gm-Message-State: AOAM533+mhL/mB4j2Cruc8sbZobvIVJa8htHMQpv4Ybuo83YMotU5Hrv
 ZfH29hBjkSObdCBLOofCo/q9cGkitmSer7yAwmHwQg==
X-Google-Smtp-Source: ABdhPJzNoTaMPyNUHcPHqv6G+t8/l3sWMaeEEiY5cvsw9F7TPfiaunzlvPg74PU9xFH5yI3dEYN8Qi5cLuFYXKkwR/4=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr9008655otk.221.1595001164063; 
 Fri, 17 Jul 2020 08:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200716161453.61295-1-liq3ea@163.com>
 <281e3c85-b8eb-0c3e-afc3-41011861b8ea@redhat.com>
In-Reply-To: <281e3c85-b8eb-0c3e-afc3-41011861b8ea@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jul 2020 16:52:32 +0100
Message-ID: <CAFEAcA9bRhr2hN5nWMQAU7YrfUuGNXCCXNEA0TciOK9o2WAGaw@mail.gmail.com>
Subject: Re: [PATCH] e1000e: using bottom half to send packets
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Li Qiang <liq3ea@163.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jul 2020 at 04:11, Jason Wang <jasowang@redhat.com> wrote:
> I think several things were missed in this patch (take virtio-net as a
> reference), do we need the following things:
>
> - Cancel the bh when VM is stopped.

Similarly, what should we do with the bh when the device
is reset ?

> - A throttle to prevent bh from executing too much timer?
> - A flag to record whether or not this a pending tx (and migrate it?)

thanks
-- PMM

