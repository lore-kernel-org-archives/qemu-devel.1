Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C61C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB8420767
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njxIO1tT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB8420767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtpKh-00083d-Hy
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 05:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jtpJv-00073y-SZ; Fri, 10 Jul 2020 05:27:52 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:46738)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jtpJu-0004Ey-4v; Fri, 10 Jul 2020 05:27:51 -0400
Received: by mail-yb1-xb44.google.com with SMTP id 2so2367960ybr.13;
 Fri, 10 Jul 2020 02:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GYM42a/VZW3mHzxpnAoFOcjsD85ZFQks0Wc0kJQbPTw=;
 b=njxIO1tTsGluVRCPdb4etDQQ7j8XEB96TsXRKLJorfNIteMJvf9J0koSYDLGmMv7r7
 CCZkIiW9RkjFKwxfxJZqB36muqsULrXsviCtsxF5araA5cgcrUvzmW8ZuT7RmkNQFQpp
 ENZiiIPFvYHtaZj0SNfCtT83z9uYAo4//3LQH79qYNexuh6A0L6Y/Ak3QP7ucwLcVna5
 9JwmMePbWnQ3stA5YfivP2ORZzHwRcdqM8wIFQw/b9l+bMOfPxjh+3rbWOJatQkI6cX4
 fta8fKcpr0Rn6XKqJCWNJrIb/NFerEnl93R6BENrEAhaWiX2JLwDVLZNQ6tcDXulL5As
 ySsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GYM42a/VZW3mHzxpnAoFOcjsD85ZFQks0Wc0kJQbPTw=;
 b=MOYHfyQPC9lWOgQWp5Cazg5WFcqtJ0trK+qtPx+lA1Y7KJqbWfJLUL0t898GFAipKr
 W9YfmIWAoKvJnff5PqcCRGTAN67+VT9ka/PlKVUqRewn21G+Y4TCN7VSjw5dlUmvhkLO
 QVKpi1YZ4Dq3NiOSphZD7spnc2atntL5AgRzGQho587XFlSLLuE+Q9k2i8VMRxK9asll
 pVvSDIT9CSl/7QJsyiGh33xxrl+i2c2qFhN962ztuRigFRnB4FgYb/aVhRDKEPE6fIH3
 lYpbYq6dXs2Rjamsw52DhB79JbpOW5P6TjvxI+AAmVA03WzXLAOXQfZ3Do0IM+97LBaA
 0KXg==
X-Gm-Message-State: AOAM530piUwggc15ebQKEh2gb0M+ESiFlroaGRcCxFr2dDpT4U6xABo/
 UXygXdh2vJG/TgDIF5csn8aQCvl7soVyCk55mGw=
X-Google-Smtp-Source: ABdhPJyv+m0rqjkjLuaHHkmZQCbZyzzXjzfFrhQPahGLjrBzPIg3J7tGBmpNfghCrzFdbUdqmBdeOfBqd+oWkngbWNI=
X-Received: by 2002:a25:5806:: with SMTP id m6mr83374149ybb.152.1594373268329; 
 Fri, 10 Jul 2020 02:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200705220731.28101-1-f4bug@amsat.org>
In-Reply-To: <20200705220731.28101-1-f4bug@amsat.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 10 Jul 2020 17:27:37 +0800
Message-ID: <CAEUhbmXV1ZvL3N7di0HgVnGmMB69H=RTFFET=3+VLyK+e3Dj8A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] hw/sd: Deprecate the SPI mode and the SPI to SD
 adapter
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, 
 Pragnesh Patel <pragnesh.patel@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b44;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <huth@tuxfamily.org>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 libvir-list@redhat.com, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Mon, Jul 6, 2020 at 6:07 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> I tried to maintain the SPI mode because it is useful in
> tiny embedded devices, and thought it would be helpful for
> the AVR MCUs.
> As AVR was blocked, I thought it was wise to deprecate the
> SPI mode as users are interested in the faster MMC mode.
> Today Thomas surprised me by posting an update of it!
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg720089.html
>
> I'm still posting this as RFC to discuss, but I'm reconsiderating
> keeping this mode a bit more.
>

AFAIK, SiFive folks (Pragnesh in cc) are investigating supporting QSPI
model on "sifive_u" machine, and it will definitely use this SPI over
SD model.

In fact, the QSPI is the last big gap in the "sifive_u" machine to
make it a complete platform for hardware replacement.

Regards,
Bin

