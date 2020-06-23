Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B12C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 06:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95877206E2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 06:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhdSPsf4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95877206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jncLP-0003Eq-RD
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 02:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jncKi-0002bX-FK
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 02:23:00 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:41519)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jncKg-0002aC-Ri
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 02:23:00 -0400
Received: by mail-yb1-xb41.google.com with SMTP id d13so10321492ybk.8
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 23:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8nP+5qMbtuYLE0jOUDyPsosWPHmFQuzjdvDUBdgWZI4=;
 b=BhdSPsf4cJLyFoN6tzzh56GGIJbNoMhOVuvbvxBjoj8b3M2v34+vfl+EBnP2vNl2ji
 IceyO6M0B1Pi3J29/4zOiRBYC4LeQw+Pg2FdL4Ile80ek87Y6nBPJg1vZbkcooW605n5
 DHmHg3IhbryNf7G6P1TB1hzMSpT5Oq2DpjACmLyBdrkX3fmgHyAUnPMmHJlkuhz9ccXN
 X1g6NP0TrbnNZRlvBQdqc9366hI6ckkpPsIbAhg40F2DZgQ7G3mP1tqzKHkpQw08HAq7
 qAHaSUA6LkimISDsyJU6phqUI15Zj8FHoWxWRQdiu0xFqUoRYZbfyo4eeCIJIUbK31yE
 L5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8nP+5qMbtuYLE0jOUDyPsosWPHmFQuzjdvDUBdgWZI4=;
 b=sFs8Q91hGUvS2fCPDiLsScaiHcz9hufvUWEXQwQg6kf3lnq2+gjmlJfAB0Vb8LmdbG
 p4AeVImO33JHZ0nhHXTKCzI5ZoX/yoiLQ0ptsH0SheAmG7Y1rDVsXEzAlNtQODv3kjbU
 PAYrrpDyPy9T6H+IEavOPy88BasrtQAI4ZiVq0j8ajHL1HylMSraRymmTwk9jCrH9Vy4
 10Mr0S9CiN7Gq90i5eaeKj+LP0qAafpcmrwGjz6WDFfkUu2061UEpJoFzHNgF288+amW
 fGaq8kaugu5m3CiUabBcIENr7J+qkZ0ncycgWR1jbDE3c226Mhy9H8CzBSlVVnwHJhZN
 5MoQ==
X-Gm-Message-State: AOAM533TWyP7y0bauY6vUQBkfJKuCky5Gng17UsTMDZaobYMphLTy7sc
 t0DCEQxI2J5g/lN12zqOiGIj2CIRQfudf2g2xA8=
X-Google-Smtp-Source: ABdhPJx7fY2qoehTT/m0qY8blJYIOfwCw4W2NX+RwYvBRjJQqpHbJwKY+yDCqmPgMruRV9vappPRDyfb0QTjzf0O8MU=
X-Received: by 2002:a25:800c:: with SMTP id m12mr35325720ybk.239.1592893377603; 
 Mon, 22 Jun 2020 23:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200619165817.4144200-1-alistair.francis@wdc.com>
 <20200619165817.4144200-4-alistair.francis@wdc.com>
In-Reply-To: <20200619165817.4144200-4-alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 23 Jun 2020 14:22:46 +0800
Message-ID: <CAEUhbmUEREaNBXBP6a0UgAYK6dmVbGFtDu8wLGUjNXHL5mWtoA@mail.gmail.com>
Subject: Re: [PULL v2 03/32] riscv: Generalize CPU init routine for the base
 CPU
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Bin Meng <bin.meng@windriver.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

On Sat, Jun 20, 2020 at 1:09 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> There is no need to have two functions that have exactly the same
> codes for 32-bit and 64-bit base CPUs.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Message-id: 1591837729-27486-1-git-send-email-bmeng.cn@gmail.com
> Message-Id: <1591837729-27486-1-git-send-email-bmeng.cn@gmail.com>

I noticed that patches from other people than you have the
"Message-id" tags, but your patch [1] does not. Is this intentional?

(not sure why we need 2 "Message-id" tags here, with one has <> ?)

Just want to know what's the best practice here.

> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
>

[1] https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06208.html

Regards,
Bin

