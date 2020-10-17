Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D630EC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59FD620708
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ICn8OFPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FD620708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTnNy-00080u-HX
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kTnMj-0006tw-9b
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:39:25 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:47094)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kTnMg-0007g6-JG
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:39:24 -0400
Received: by mail-ej1-x644.google.com with SMTP id t25so7559372ejd.13
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mpeDWOYIO+zh/xykEhXu5Zg/XqiagYudAKo068JsRfI=;
 b=ICn8OFPfLapX5N9TSYsVnCKBn8F5JZAd3LDO+FzUK4XZ4Qx49dcXTXTle9Fo7piS4u
 Yn+u9E32a3IKE2XbCR2h84ZPOi9V+flR0bA5ThUwmZqj2MkeoGiCvfuqPQkZyD1jHr9J
 AkpRT9yUyJS8DgCvJ/CY9qHZxDLcCretXi6s0iaRNzwS/y6UZnM421uukjXjGmseGK5w
 X/WfwpHxL6EE9sk4VygHxdujWDooJNbyOnRK8+T848ZamZwitlA+DHs+m1IncoF8GCQB
 VQwsuUDvjIECnE2z/StkMJQkMFyUy1x2iMHbedBv+B5ZuaVYOQ/xCdzeSdphS7Y+q6QH
 NJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mpeDWOYIO+zh/xykEhXu5Zg/XqiagYudAKo068JsRfI=;
 b=Zw+6pu5zJ7Xg3UcbxLcrV3zAK/7a40UFaV23dwCmMkw3P0MfTXsTg5ggjt+wVrnev4
 NDFDODNoPTun5V1ZUuoMFJnF36yniJFTNfLJoSnedonvUdXWpw+Pq8N7zZEZrbh5LdZN
 GyzFhYiBSg/sHSBz8+xVhorMDbneohtJzPJtPkzm78O3OgQzBF6Aef0lQ1HUYtH6uh4W
 7SHxRbQSrL/eqeEbuwQzAAXLdZkIXNHW+G7djrnjeHFuuk35VJYHL2CBr+m8MQamugJ0
 dPLwKDzQ8CIQtbQ3r+lWDT6wU+PDbPoWKH+U3weceCjv1Zk7frq9Oof6rebS6tt/OMgc
 MreQ==
X-Gm-Message-State: AOAM533FT2Q4ukn0KugJTDQsZe4neJ5GISSNQX9/ruOGQ492YnOKKzOQ
 TlMFMz5Y5OXJiyvc3Sf5rVqCHq/q3LnxwJnpTIhD1A==
X-Google-Smtp-Source: ABdhPJyii/Hg2XBUoY0j/SHMQVp1nvX2XAIQVCV0CwVslnH48wCKqrawKz3ncK0eh6+iGT9W5uBU2Uwt1tQzPBgKXG4=
X-Received: by 2002:a17:906:ce21:: with SMTP id
 sd1mr9055656ejb.4.1602945560364; 
 Sat, 17 Oct 2020 07:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201016155331.1613089-1-pbonzini@redhat.com>
 <CAFEAcA_ZW2mq3ygzCjuphW2kkdOy4fcTzDObcyQTw0BJJgspZw@mail.gmail.com>
 <ecd2b5bf-0c3c-fa58-ce4d-3d4d55274424@redhat.com>
In-Reply-To: <ecd2b5bf-0c3c-fa58-ce4d-3d4d55274424@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2020 15:39:08 +0100
Message-ID: <CAFEAcA_HDoheozjRjcAKy3eEJ94cBgU29FDftMe2yn=SdMKHMA@mail.gmail.com>
Subject: Re: [PULL v2 00/22] Build system + misc changes for 2020-10-16
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 17 Oct 2020 at 14:38, Paolo Bonzini <pbonzini@redhat.com> wrote:
> OpenBSD and NetBSD call the ninja package "ninja-build" unlike FreeBSD.
>  I'm sure I had used the right name but well I didn't.  I'll send a v3.

OpenBSD built OK but meson produces this new warning:

Library iconv found: NO
../src/meson.build:531: WARNING: iconv required for curses UI but not
available, disabling

thanks
-- PMM

