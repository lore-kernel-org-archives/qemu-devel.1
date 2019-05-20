Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCFAC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AEBA213F2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0bXUr+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AEBA213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42478 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSqDA-00056U-Ho
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 17:52:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hSqA6-0003BB-5D
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hSqA5-0005U2-9E
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:49:38 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:36019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hSqA4-0005T1-GE; Mon, 20 May 2019 17:49:37 -0400
Received: by mail-lf1-x142.google.com with SMTP id y10so11468506lfl.3;
	Mon, 20 May 2019 14:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=koufGJffk4TKMQ9ktHHDRxKPvbMzt7Wf2ZYKsbOYO7o=;
	b=u0bXUr+r9/bPiVzwJLzgv0nQ1og1wdajhlcSIogC1byW1W/HNr6Krb81kkg8fBYAgc
	jQKG7LVe8x1qddPmrc6v1p2Dyj2nJIgZNvQ8tO0kmLi4D1vWfd4X2cjftT7zo/HdSN0U
	LXraznxPrZdBD61Dl+pe//GE0jS3t/IZi5A57/GujItj44fDgYTDTdAqkamrhJlr5CnH
	M/5UrZCK1SYS71ITymA+zu5RBl2buIVfmDm3qoMtB/eCiSkhn61MI+8yrz9zRKBj/G3g
	AYqolzZLkMDLJ5rR84jejnC77ZD816pnJ8YyZtuCpQnAtlW2J+gjybOAjM4LQBeHaXf7
	pJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=koufGJffk4TKMQ9ktHHDRxKPvbMzt7Wf2ZYKsbOYO7o=;
	b=mCn6pBnQi7ss9lo1R1fcgsEUHZibWrjiCYEe+ign6T4CVLYJNYtGhR9TeT9Buk8qh+
	q7oN8bX0e1NXS6TItsSc6LO1TVnZue8lSpvzZCX88jt0x+XHwSHJot8VxhVAmCXDfKLS
	XZvGASJnkCodBkslGb4fqUnMY6Xbjkv0RDoxfOdIkpCg4jCTYli1/XnLXHzEdVtn4LM2
	lcvkruiEwVSa7UhE88TU+kavK4Zx0nDlkjMt4VO5QPp5LBV6C1ZCCRnp7pTgNXkQJew4
	iD9ugbR+XTT+mTWbE1d0ve9TiRJcuMbSFGJP9Hdsa2rv3KmCvPdcECsQ8fKw1s6HBRCX
	8a2g==
X-Gm-Message-State: APjAAAWynTPqFA7d48wfNzLNkDLj7Zw9YT9RhhrlbgErMPXTqX0nN1YK
	Z8SHhhPId9tHYJaekuhPheygas310GiguUg2lAQO9CTs
X-Google-Smtp-Source: APXvYqzi5KafbkHOuuyw1hxH6pj10HKQ6HSfktUMKSZH6XDdiQFvhdcLzZPqXIAnCk4hpYa911CtDb9V0Sr6EvOv/2E=
X-Received: by 2002:a19:7516:: with SMTP id y22mr16900911lfe.26.1558388975142; 
	Mon, 20 May 2019 14:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190520214342.13709-1-philmd@redhat.com>
	<20190520214342.13709-2-philmd@redhat.com>
In-Reply-To: <20190520214342.13709-2-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 May 2019 14:47:20 -0700
Message-ID: <CAKmqyKM2FYAsC6mDJWdOOOmHq3XL6+9MEnAWfCrNzK2s7AAUPQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCH 1/4] hw/arm/exynos4: Remove unuseful debug
 code
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	qemu-arm <qemu-arm@nongnu.org>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 20, 2019 at 2:45 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/exynos4_boards.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
>
> diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
> index ea8100f65a8..f0c24b7992e 100644
> --- a/hw/arm/exynos4_boards.c
> +++ b/hw/arm/exynos4_boards.c
> @@ -35,20 +35,6 @@
>  #include "hw/net/lan9118.h"
>  #include "hw/boards.h"
>
> -#undef DEBUG
> -
> -//#define DEBUG
> -
> -#ifdef DEBUG
> -    #undef PRINT_DEBUG
> -    #define  PRINT_DEBUG(fmt, args...) \
> -        do { \
> -            fprintf(stderr, "  [%s:%d]   "fmt, __func__, __LINE__, ##arg=
s); \
> -        } while (0)
> -#else
> -    #define  PRINT_DEBUG(fmt, args...)  do {} while (0)
> -#endif
> -
>  #define SMDK_LAN9118_BASE_ADDR      0x05000000
>
>  typedef enum Exynos4BoardType {
> @@ -140,16 +126,6 @@ exynos4_boards_init_common(MachineState *machine,
>      exynos4_board_binfo.gic_cpu_if_addr =3D
>              EXYNOS4210_SMP_PRIVATE_BASE_ADDR + 0x100;
>
> -    PRINT_DEBUG("\n ram_size: %luMiB [0x%08lx]\n"
> -            " kernel_filename: %s\n"
> -            " kernel_cmdline: %s\n"
> -            " initrd_filename: %s\n",
> -            exynos4_board_ram_size[board_type] / 1048576,
> -            exynos4_board_ram_size[board_type],
> -            machine->kernel_filename,
> -            machine->kernel_cmdline,
> -            machine->initrd_filename);
> -
>      exynos4_boards_init_ram(s, get_system_memory(),
>                              exynos4_board_ram_size[board_type]);
>
> --
> 2.20.1
>
>

