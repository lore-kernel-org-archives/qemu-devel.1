Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53134C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 19:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D6C620693
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 19:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Jxzmo/pI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6C620693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33917 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJjds-0000wK-AB
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 15:02:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJjcj-0008UF-VG
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 15:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJjYc-0006i7-S1
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:57:19 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hJjYc-0006ey-Li
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:57:18 -0400
Received: by mail-pg1-x544.google.com with SMTP id d31so291960pgl.7
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 11:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
	h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
	:content-transfer-encoding;
	bh=ZqUiWIRkd4FGmMptUc+o/kwZ71iZ9LxeQlW+P3BZ/6I=;
	b=Jxzmo/pIrqKp4pRWy47Qp/Ih9IvLTQE/lS9KFLF8CYMGdIuV3ODvRcEw9ij3xAU4tm
	EHhd0eSKR36lt60mEp/o+2kiKigLgRTqBoQSaMgLM8yDf9bep98BOF4epxa4fdh4SV3u
	i4rcdrzwmGLQAjW0cuNWLQ/APKBdcU0IJY9yXRSQoLjZbNQ08/yXyjHxqoEthWhb7vRl
	Q9LEFHOZR1bpKJwosoE4y4FbLvFJwb80Od4/5AhlZj97PNhJzHqOuXi1LnNyY3JDRmJ9
	jd2+ir4qjcGd6bgGSJlJlX0PSDnDW6TQU+NGrUFO8sLJAqEMez+YLgkCsg8T1ARdJozX
	WkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
	:mime-version:content-transfer-encoding;
	bh=ZqUiWIRkd4FGmMptUc+o/kwZ71iZ9LxeQlW+P3BZ/6I=;
	b=hCiqnEU5oG2TkgfuMWrG7WuYw1Fdzeh+ePKcgEHVKmyeNW34RhOzPJHGMyn5+B7MWt
	FOhoAFUJ2RA+ai4N/kI/ELJLBoGDonpO0OZFlMptDjqdlp616l0UPbbaWvrIlJm5kOIX
	jzRNteyW6vrWjoBvr8pRoyBdI4/f2B0tLR83ACrnG2SiLAbe9qzNq8tKflMohd4bFdU2
	sBioF5eRtFGWKvR69JPinhhnq59fBv7P4XIwzimUjVXIV9IGQGeJFRpJyOirBXQXhKaf
	OcKvNhJiGZu02sTGDNg/2azR09J/CmPrAzMgqMQrVsINXWiJyvOpEv+jlefQ0AbnvTbQ
	Abmw==
X-Gm-Message-State: APjAAAUxIVuTOYDgbswfX7pRV4uV4T+9Wd6/LVzbLzeisMeg5TXdJIHo
	MAMQognBYn2CdU3+iJlW0qLvTHpoFJQ=
X-Google-Smtp-Source: APXvYqw+MzUsHOMRUqj2MyQSQs1lA7IxhmiMtkSD91VKJkahUOvo/AhAAuXgodOG+LUp7nTi+Ru9HA==
X-Received: by 2002:a63:d34b:: with SMTP id u11mr7061204pgi.385.1556218637335; 
	Thu, 25 Apr 2019 11:57:17 -0700 (PDT)
Received: from localhost ([134.134.139.92]) by smtp.gmail.com with ESMTPSA id
	y20sm32537117pfe.188.2019.04.25.11.57.16
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 11:57:16 -0700 (PDT)
Date: Thu, 25 Apr 2019 11:57:16 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Apr 2019 11:56:10 PDT (-0700)
In-Reply-To: <CANnJOVHbCGcgnHT3qVbHGFh_Ba0=FqABSoM2SG9ddf-fawwaYg@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: fintelia@gmail.com
Message-ID: <mhng-5ee2a059-0cd2-4dc6-8952-2560c4f76161@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH] target/riscv: Remove unused include of
 riscv_htif.h for virt board
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	qemu-devel@nongnu.org, sagark@eecs.berkeley.edu, qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425185716.YdHWk-mzUEeVcC1gsjPvxfGvcU2iCwxDGrl1lLc_OXI@z>

On Wed, 10 Apr 2019 09:29:11 PDT (-0700), fintelia@gmail.com wrote:
> Unless I'm missing something, the virt board doesn't support HTIF and
> should not be including this header.
>
> Jonathan
>
> Signed-off-by: Jonathan Behrens <fintelia@gmail.com>
> ---
>  hw/riscv/virt.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index fc4c6b306e..3526463034 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -29,7 +29,6 @@
>  #include "hw/sysbus.h"
>  #include "hw/char/serial.h"
>  #include "target/riscv/cpu.h"
> -#include "hw/riscv/riscv_htif.h"
>  #include "hw/riscv/riscv_hart.h"
>  #include "hw/riscv/sifive_plic.h"
>  #include "hw/riscv/sifive_clint.h"

Thanks!

