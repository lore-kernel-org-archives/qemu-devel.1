Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32605C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:46:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 018E621738
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqBySKDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018E621738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hug7d-00074A-9K
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39083)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <fintelia@gmail.com>) id 1hug6Q-0006AK-Gi
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fintelia@gmail.com>) id 1hug6P-00024I-Hm
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:44:54 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:40566)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fintelia@gmail.com>)
 id 1hug6P-00023T-AH; Mon, 05 Aug 2019 12:44:53 -0400
Received: by mail-lj1-x241.google.com with SMTP id m8so46252098lji.7;
 Mon, 05 Aug 2019 09:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9FruRi6Xu7OT2SB3a0nBpyGnFSd5DR+quxKjBlWmUO0=;
 b=SqBySKDtvDhA5TRsCeHaCgrsqU6MQfn0EpNush9xmeNRQo701+ccRDZB2TqVpddpqC
 wLf2ZoOeIRaQrJjI7ImTCKbB4yKtSxl7BiV34WZd08vRjfVfXpAy/pQOEM7sgR1e6ZvF
 nV+t2rQTkAyr7S7q+SZzaEJw4O3ddLkPWuUhvt2CnVsxEjRTYMzjrhDkKLeEYrjzwsDq
 6GK5AYABOWGj/Ib7ifRVQCh2m7JrU5oFM18MbTBtez7IbmhfZJReF620QroHHJEkahXy
 stvh/BKc5CynjtTsZQQ2qWBeL37NpR1qoDDBlVDZPbuMhRrKY27tnZcfDtCJkK4g+MfX
 3Oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9FruRi6Xu7OT2SB3a0nBpyGnFSd5DR+quxKjBlWmUO0=;
 b=esKsLdf0WNLSGQuEd2Kavb0kuGbcFgaNne2N2WWpqp8CgpnFzHZcf9n6XJ+lZYH3R9
 L/g51x3VuwUFuPvBX3AwV4m/M1rw2Ezuz1yWhlJ0hvu6tXnHP2fQicWZAt951iRDT2FR
 nVfJw3suq7ftCdbNG6Vv5NCLbPbqvfJpUfUuLB8efSjswQHn7hjhb+B6zf/KNO89OR6u
 wA6ARRAsYeNMRh8SRtMYUwo0z6q2owUg2ef2lTD9OLcNlWM6u1hXdrn2HBartqaaNuwW
 CLI4736htpWO8jA3F+mo4i6lu5LeiZDo6MIMKQZzoYlM2HaeGJTitni5xDonRc2pi0MQ
 8Z/w==
X-Gm-Message-State: APjAAAUwiADyc+FCtaYrUtsn6Ub8+cDKizajLf+zXrL9nAxcbD6mSNt3
 DtyMCOdFGePIx+svCXRxS61AWW0CGbEE6YIx6a8=
X-Google-Smtp-Source: APXvYqzeZgZOP1DZbznXLublw5CLWW/xmO+ZTeR/jqJsBR6ppyxkM2qMAM+soqtJ6soaGzygDfQKUzf+UuYTuVvzb5I=
X-Received: by 2002:a2e:9d8a:: with SMTP id c10mr54537104ljj.147.1565023491117; 
 Mon, 05 Aug 2019 09:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
 <1565020823-24223-10-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1565020823-24223-10-git-send-email-bmeng.cn@gmail.com>
From: Jonathan Behrens <fintelia@gmail.com>
Date: Mon, 5 Aug 2019 12:44:05 -0400
Message-ID: <CANnJOVEg6J=ZiZ7cO+s6x2UBwBZ5fteJeKDhn38RcFCPiuTn7g@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH 09/28] riscv: sifive_u: Update
 UART base addresses
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
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Jonathan Behrens <fintelia@gmail.com> <chihmin.chao@sifive.com>

On Mon, Aug 5, 2019 at 12:07 PM Bin Meng <bmeng.cn@gmail.com> wrote:

> This updates the UART base address to match the hardware.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>
>  hw/riscv/sifive_u.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index b235f29..9f05e09 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -60,8 +60,8 @@ static const struct MemmapEntry {
>      [SIFIVE_U_MROM] =     {     0x1000,    0x11000 },
>      [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
>      [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
> -    [SIFIVE_U_UART0] =    { 0x10013000,     0x1000 },
> -    [SIFIVE_U_UART1] =    { 0x10023000,     0x1000 },
> +    [SIFIVE_U_UART0] =    { 0x10010000,     0x1000 },
> +    [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
>      [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
>      [SIFIVE_U_GEM] =      { 0x100900FC,     0x2000 },
>  };
> --
> 2.7.4
>
>
>
