Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA21EC28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 04:45:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B546720752
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 04:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="qc9TM5Lc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B546720752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jV6Vi-0003jo-Qt
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 00:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1jV6Uh-0002jE-UK
 for qemu-devel@nongnu.org; Sun, 03 May 2020 00:44:47 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1jV6Ug-0002Yj-Mt
 for qemu-devel@nongnu.org; Sun, 03 May 2020 00:44:47 -0400
Received: by mail-wr1-x443.google.com with SMTP id d15so16843813wrx.3
 for <qemu-devel@nongnu.org>; Sat, 02 May 2020 21:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5oeafdwpi27OG4NG2IUa3kDa3FFg+iOMNPG5+RbDK40=;
 b=qc9TM5LcJ3pMFBDPl8gugv+Hu82LjQqlKdOGTBxiHMBP57RcAr3UarMNf5ENGjsgUU
 T/TedmcdOazCAuermaRpzSJuj+McTDvAPLYzc+zOF8XDuWsukv7239qt0Uoo+qfu7WEc
 fgMcw7SiOSBhxiwYVezv7gus1weiqineEdJmkgnId0F422gkG7wEbdcIicogVF5/7cT6
 /mQpky9nxQ6e+4PpV3HtRsqDWddEGRUGFpq+joseDPbu3jSHG6jZQAEyUk7KdP+NuOaG
 s2uvjnttvanO3F8NlkLqYmNSZ5kYm+WrZwEyIH8M4ovrKYqr/JvsmJIzhMUURdRtfWVE
 Uj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5oeafdwpi27OG4NG2IUa3kDa3FFg+iOMNPG5+RbDK40=;
 b=S/kXw/8R38h7uhqAihYD8UQIRC3BrS4V2mMzfFiO7wbEU7oWsg0OgNFYU24CnFwOMF
 0WGXprhItGWsBem2PZiNq5BXVsF4RSpPepn+phDO+vAekl3eUXLzYe04i1XiAtveQ0qp
 I80sn9NJtIxlng5xPAI7wnJWzDDqtl2ne9aYhfFUut3plcewcFVRHooKJqdm9iPk8TX3
 TA91OBzn427kZ4GAuxXrp1aMKokeXgwUo9OrSZnUh8OHthKF5k4ep3NuHkZoB/6iNITZ
 Ig5vjcM0P9DVo1MnsiPKvAl4G6vu1aIveGoaycl0FONuac3CsphYlDjhNwqEgMAbRAzr
 aR5w==
X-Gm-Message-State: AGi0PuaKUCSNi3eshn/zc5AnjwCJPz6ttOlhL+f6XAsW/LL5GQ/HVU6Y
 TyFmuvIM2166coYhIUMOZ5w86qMDgfTxW2VIxLgpGA==
X-Google-Smtp-Source: APiQypJ9miBbD2/jF0ixGhtuvEYYv2ENN4XCJeqAU6BOfOmHVKOy/3mR5EcqUnjf0+B9QclXvwf4gbChENNa0cpqWLk=
X-Received: by 2002:a5d:414f:: with SMTP id c15mr3345909wrq.61.1588481085075; 
 Sat, 02 May 2020 21:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <1588348254-7241-1-git-send-email-bmeng.cn@gmail.com>
 <1588348254-7241-6-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1588348254-7241-6-git-send-email-bmeng.cn@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Sun, 3 May 2020 10:14:33 +0530
Message-ID: <CAAhSdy2uH-Dhj5wTWkxmqHHcXB0PGBDw-TXS4w0cdpf3K74A5Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] riscv: Suppress the error report for QEMU testing
 with riscv_find_firmware()
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::443;
 envelope-from=anup@brainfault.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Anup Patel <Anup.Patel@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 1, 2020 at 9:25 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> We only ship plain binary bios images in the QEMU source. With Spike
> machine that uses ELF images as the default bios, running QEMU test
> will complain hence let's suppress the error report for QEMU testing.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
>
> ---
>
>  hw/riscv/boot.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index b76b2f3..adb421b 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -65,9 +65,17 @@ char *riscv_find_firmware(const char *firmware_filename)
>
>      filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware_filename);
>      if (filename == NULL) {
> -        error_report("Unable to load the RISC-V firmware \"%s\"",
> -                     firmware_filename);
> -        exit(1);
> +        if (!qtest_enabled()) {
> +            /*
> +             * We only ship plain binary bios images in the QEMU source.
> +             * With Spike machine that uses ELF images as the default bios,
> +             * running QEMU test will complain hence let's suppress the error
> +             * report for QEMU testing.
> +             */
> +            error_report("Unable to load the RISC-V firmware \"%s\"",
> +                         firmware_filename);
> +            exit(1);
> +        }
>      }
>
>      return filename;
> --
> 2.7.4
>
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

