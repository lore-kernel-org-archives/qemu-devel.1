Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C44C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:46:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E45FD22522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeceOeGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45FD22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itr3h-0004Rl-3J
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 05:46:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1itr1e-0002k3-CY
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:44:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1itr1d-0006VQ-FI
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:44:50 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:41951)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1itr1b-0006UM-CG; Tue, 21 Jan 2020 05:44:47 -0500
Received: by mail-lj1-x241.google.com with SMTP id h23so2210452ljc.8;
 Tue, 21 Jan 2020 02:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NBCTh5HwTl9ddrB9gE8PK+L3swUoYyQPLEhhi4wxcuE=;
 b=CeceOeGbtWCnlbssy9q4E2tNMoywoVxi3M6FSTgi7hdg6Sr94LCYLUG8N4EodndEgd
 y+JAKg5E2kQqTp/7zg8V67WIUQv3bqz65Cqc0gbyIKMwaXoERDtnVeDdkdEJbOSX6CuI
 FrZUr2UXsZYJWOW6DGs0vOV2gyFRpL7fA666NZpscskyJffsHPocEWwBqEol/doTKbm9
 xzNVUbjIM2yDIuPEMHWKUr39p/b8Cz0aYnP3Xjwce+GMVhNgo5khA5Z6woIOSDvGGsYl
 LufqhjUSj0ONuUjrNYPUGPA/vyul5M76SfTRJq698HR1qZ6l8jKnilgWY7Guv1S/1yZN
 7Ing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NBCTh5HwTl9ddrB9gE8PK+L3swUoYyQPLEhhi4wxcuE=;
 b=mSInmTZtGaJmzwEhg2HZlN2mmULFO2XcLEDZlLPbFK5s9qCqonPwdV7yYOl7FSINu5
 AJQ5ZzIRxK5eVU0rxKXwmsiYMW6aXwlyFrfs5qVldBEqP5NyYY9TkIB66oN1HYID/wSL
 d3iuN8CKOcQIsU2vW/+bpbdZLsTp+4jcobdWIWQSat/bwcw609kKmaALCuLyCvvxf82T
 j5jgxsIyAmC8FSbw+VwEVDJDfL7T/p8RaE7pxjhpvxc+Y+2JFSf9Iv+zgaFheuteuQ/V
 M8PyTPnFYWzz4YTn9YNJwSfbaSkcmnFIcxiYT1jmt3fEs92RIthu27l4T2gKIf1ZjgmU
 Hn8w==
X-Gm-Message-State: APjAAAWn6cyU5nVJhvWAeSbGx7K2LdO1W5qJJ0SVe2vm2gqiGAh5F4Tt
 y1e5fnqXHqT+setvih+cXiByud20BjUSHdvJFPk=
X-Google-Smtp-Source: APXvYqz0tLH4PmP9F6REfutfksROAEKHuPt1C2fVw0dOY7SE+5+l6PpOI1CRw3kJ7cR4fnWwgHFlIYgYz120zTocifQ=
X-Received: by 2002:a2e:9a51:: with SMTP id k17mr16066036ljj.206.1579603486168; 
 Tue, 21 Jan 2020 02:44:46 -0800 (PST)
MIME-Version: 1.0
References: <20200121085910.28834-1-anup.patel@wdc.com>
 <20200121085910.28834-3-anup.patel@wdc.com>
In-Reply-To: <20200121085910.28834-3-anup.patel@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Jan 2020 20:44:19 +1000
Message-ID: <CAKmqyKOiWkqFbikTwbT51vZJ3hKj=oSFFQwJYUXLZT0kB--7Ow@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/riscv: Provide rdtime callback for TCG in CLINT
 emulation
To: Anup Patel <Anup.Patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 21, 2020 at 7:04 PM Anup Patel <Anup.Patel@wdc.com> wrote:
>
> This patch extends CLINT emulation to provide rdtime callback for
> TCG. This rdtime callback will be called wheneven TIME CSRs are
> read in privileged modes.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_clint.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
> index e5a8f75cee..805503dc27 100644
> --- a/hw/riscv/sifive_clint.c
> +++ b/hw/riscv/sifive_clint.c
> @@ -236,6 +236,7 @@ DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
>          if (!env) {
>              continue;
>          }
> +        riscv_cpu_set_rdtime_fn(env, cpu_riscv_read_rtc);
>          env->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
>                                    &sifive_clint_timer_cb, cpu);
>          env->timecmp = 0;
> --
> 2.17.1
>
>

