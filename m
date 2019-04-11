Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AF4C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B9B2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ue+irlzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B9B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52781 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEdjn-0007NA-0h
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 13:43:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hEdiO-0006OJ-Gi
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hEdiN-00051O-LZ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:42:20 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:44654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hEdiN-00050w-Bu; Thu, 11 Apr 2019 13:42:19 -0400
Received: by mail-lj1-x241.google.com with SMTP id h16so6291681ljg.11;
	Thu, 11 Apr 2019 10:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=jIiUlaOr09GT6DH0wDyqFP+V6QkvuLkR+MdMEBfecDw=;
	b=ue+irlzVCi1UcStS67djF4oOvsfiUXWOihv/6IxjZ8SEAf9p5fPmIYAbT4csUEDH3x
	Wh7fVOHFMndGxN+YhNqIwB70nAA1KhDwsCQokxT8Qp8TCu3SbZR2n2efhDmpjMYVghJ5
	I5ehac7s6w9pTSftiiXyMAFT4to6pU4ypDoo/VqUEMAo7fSEVt6FP0c23wFdNtlduOq4
	fIaHetuhBgU6OG52a58Ob0sHE6OqzVIsHX16bFAqY3Z0TZXttBWe6cjN/dqHmmzLhxFe
	HGJDjJ5sZRI1gxmOTZO9cWvHrdCR02AnWqMXQieXHffFvfWYEk9lCnEpPal0CPPpi+o3
	pizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=jIiUlaOr09GT6DH0wDyqFP+V6QkvuLkR+MdMEBfecDw=;
	b=I179vo3Gq2zLkjcGZKc5oB27c6/TZESk7B5Sj3X+0pLuPlXAFjXI9LxhitfjS2J/20
	BJwldAyQmkA2/Zi6bFUR2ylfdcYwKSpcxdMYmaanBVWePm1PHRZY8RMps1bXdF7vr7YC
	m4TJyd9fILiF76/nnviv/p20hxZy8dyrRWztc5RzgHc1XybVW6RnR4J67L6ZiHKxV0Bq
	Iw7LY3tewyKwLaDZuV77ef8S2coZCY7DKWF9AkGz+vZEn2lf+RLDfTA6toWe/IfCfK2p
	RvJido+9WgZyHoLbFmkyrtAo403whizkaSqa8nnFtIHGxfRvdGRUXlTevrK4cJ6EuSSZ
	Xc0A==
X-Gm-Message-State: APjAAAVIL/QbTtY+exoZC8BRqHnL8IDQEFC1wi8yZolPJqgCHD4IJDce
	rgY+qzOj1WzosAUinuAqw2/XjsM/+NCfe377tao=
X-Google-Smtp-Source: APXvYqzndEK/OR+m99FpiC3sXYHV3S94hHQVl49EsP1mvBDLWZFDePeSdQ7spnrkLMsg1E+5JuSih544FIYkHNIRY9c=
X-Received: by 2002:a2e:2a03:: with SMTP id q3mr27213305ljq.56.1555004537951; 
	Thu, 11 Apr 2019 10:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <CANnJOVF2gE3b-C5zSb85SGoP+9cD9xOQQ5Z4tmsGouagR3xo0Q@mail.gmail.com>
In-Reply-To: <CANnJOVF2gE3b-C5zSb85SGoP+9cD9xOQQ5Z4tmsGouagR3xo0Q@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 11 Apr 2019 10:40:43 -0700
Message-ID:
 <CAKmqyKO_hggjML2-0d3QCoEM=ByfSKuP-jdRqnhpVHrGmVVVxA@mail.gmail.com>
To: Jonathan Behrens <fintelia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v2] target/riscv: Remove unused include of
 riscv_htif.h for virt board riscv
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Palmer Dabbelt <palmer@sifive.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411174043.LqDZ4qbB6ujJ5Z9SNh-30f5UpQNAA6zM7nO1OfyJzmI@z>

On Thu, Apr 11, 2019 at 8:10 AM Jonathan Behrens <fintelia@gmail.com> wrote:
>
> Signed-off-by: Jonathan Behrens <fintelia@gmail.com>

Awesome! Thanks for the patch.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
> --
> 2.20.1

