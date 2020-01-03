Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067B7C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 14:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C69E7206DA
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 14:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dk6pbeG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69E7206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inNrc-0000a4-Rr
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 09:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1inNqv-00008J-0L
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 09:23:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1inNqu-0002I9-19
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 09:23:00 -0500
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:39962)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1inNqt-0002ES-Rp; Fri, 03 Jan 2020 09:22:59 -0500
Received: by mail-yw1-xc41.google.com with SMTP id i126so18558150ywe.7;
 Fri, 03 Jan 2020 06:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t/9tzaHSOw4Etp7svWNKYnXFNtq34ho3I41bW1D5osI=;
 b=dk6pbeG7AUH8bfzp+WhT9SYHFtfhCibFqgTwcNiCjben8Pxymvv9VdJktJtvTEdtIr
 8srB/Rz0eFpi6Bk9dV7FCu5EavlxMKbuclVvJ/pob5EOWbRWVi5BVe7WtZMGy5Seeb+w
 uttgqPsZUzdRJts150iJAjgi1jY7oTwDUckyCk3ngS9p1ZASE5jNmT614djWrUkAAKMK
 puHU76Il3sQvkLWp071XgweeYCwuRB0uTAVAyaMk+IV8vuuJ1hieXVDK4zZl8kXSCNZR
 34cUgdf6gIAS2/NKJws4aI9Cx/D2H3GLy9mEcuBIAbIBclC/wf2cJRsN6mLljYoV+Ij0
 FU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t/9tzaHSOw4Etp7svWNKYnXFNtq34ho3I41bW1D5osI=;
 b=rKQSj5ccdLJgsR4aaniLqnz/k2Xb1Q5HvzeI+VGiJZauQCUsRAeixqjD6kjTgSnMpb
 hn9EQw+LHLczs5Jd9M+c6EeU8Psf1DU1tr2CVkzu4ZbFzAUwL3X0+EcRDH8a95L5G0+Q
 bcWIGj9QuFGBEdxrJnjDB82p82wfj9IcSwYMFFlWuAqhty8GGXhXoPg+3UAlfH5uwkb/
 jZTZq6q7pqRJl3GC8E0xBidFaKHQ+/UkHxrwkunGY/2F/84mli5sB8S5xoK2usbXq95e
 wA2Bg9dpEz6C0yMZF3vOtK8W08pCWW2vV5Jt/dfCmeEzZ7YS8CKL9yqv9j8f5dh0FGCj
 lh9w==
X-Gm-Message-State: APjAAAVU0wZe77XlKIA3QGT1ju4WA9+LmMxV9wZVQOEG/PKoU1uy397T
 LuYtkzxSg1eB1XbUn6ITILRVC9pUbygDrmcpw9A=
X-Google-Smtp-Source: APXvYqwB31lYh0qxre9PwNjvlspHDl5I/84mN1oVe+8lhSSxCsY8901NQfWZBuE0+WXpk0QEKTjJAKedCNHKUpdI5U8=
X-Received: by 2002:a81:7841:: with SMTP id t62mr66924993ywc.140.1578061378986; 
 Fri, 03 Jan 2020 06:22:58 -0800 (PST)
MIME-Version: 1.0
References: <1578023622-49180-1-git-send-email-yiting.wang@windriver.com>
In-Reply-To: <1578023622-49180-1-git-send-email-yiting.wang@windriver.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 3 Jan 2020 22:22:48 +0800
Message-ID: <CAEUhbmWVBAK2EUCiTOFpY4c1k=Tcva4iYP-jBsDPJ-uEfGNSYg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Set xPIE to 1 after xRET
To: Yiting Wang <yiting.wang@windriver.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 3, 2020 at 4:03 PM Yiting Wang <yiting.wang@windriver.com> wrote:
>
> When executing an xRET instruction, supposing xPP holds the
> value y, xIE is set to xPIE; the privilege mode is changed to y;
> xPIE is set to 1. But QEMU sets xPIE to 0 incorrectly.
>
> Signed-off-by: Yiting Wang <yiting.wang@windriver.com>
> ---
>  target/riscv/op_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>

