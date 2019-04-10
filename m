Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B1EC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 23:25:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E0D220820
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 23:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJjUozcy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0D220820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39106 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEMat-0003ml-Js
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 19:25:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hEMWo-0000rW-3J
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 19:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hEMWn-0007of-3B
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 19:21:14 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:35360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hEMWm-0007mE-NA; Wed, 10 Apr 2019 19:21:13 -0400
Received: by mail-lj1-x241.google.com with SMTP id t4so3693255ljc.2;
	Wed, 10 Apr 2019 16:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=lJoXfOnx1+s02e6SfainK1cZ8EaORQ2JYPV9t1OAhcI=;
	b=MJjUozcy9umqxZg/1mF3u6X0HMiT6TOGo9bjzEKRw58rNvvxxY8F3Ijb+xnXL/0FLK
	KmOGvZkOqNm7Jrbyqdogd7UMv1Cq9E8In4LQcwk2R6frMgY4T7LINBI1AUvu9UTrxHFu
	vpj7f3gDNtCOYse+Fx1qwFQpFMr6R8wfzSTO4vLESVRfNYrxQqALUTNldeG/++45tZ1i
	82PR/HLfZQ/GVfZyeDhYBMZePoDP7lJkmufEG6aQYkjzHcI8F1PKx+zJlOXjoV6XJ3ps
	Srw9Fxsy8G/Rschb2nOs9BNR0gjuxCNmZS7xf080L86ScCpsjYgO21Z2oCC6NQI8LYrU
	KrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=lJoXfOnx1+s02e6SfainK1cZ8EaORQ2JYPV9t1OAhcI=;
	b=gd1ASAcbUdqVNxp2MaCYX9XP96iFHZPSG4xGTbroVM4zDdLtKrz/BYKKLiuRvjPeo5
	aHK4OZ1CPQQDJDWFvi94fldfcH+1pKBk6ZO0xFOohGnGdadfh6+X1CIImKFaMfwVGxWg
	cIanaxJ0iVMh9pWqswLzl8+vIDVAuVSZpJfS/vb/uYszm64uFaN+sdGntj+QeKYE0wJs
	qwejJAObIdjt5meDV6jJg0jzKEucSwkBxjqVU3ah9PgFw+CnY5QSI7NA9IUoTZWV6rjP
	Gba35wtZHOhO47fibge6IFOVJz67nrvyxbXEF7l1RMfNlzTV/oEN+aVSzNFEW+sRpA1r
	7BhA==
X-Gm-Message-State: APjAAAWrY7NWRWpy7H+dvF/K19MLSfqMyIGJ91Fo6lRvy0ehJQS4rEUW
	WnDSoOvlV9LxtMdOwfEU/H9LZXGEWLqmI2VJ1LM=
X-Google-Smtp-Source: APXvYqxi/ZS1O88wmn/8y6xtWv//iFCQfXu/QUl/qLdKX9XYY5rT2DJtdC7Y5vt7f7z7dlSsXJDukLh6uxuau267Hu4=
X-Received: by 2002:a2e:2a03:: with SMTP id q3mr24480631ljq.56.1554938469518; 
	Wed, 10 Apr 2019 16:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <CANnJOVHbCGcgnHT3qVbHGFh_Ba0=FqABSoM2SG9ddf-fawwaYg@mail.gmail.com>
In-Reply-To: <CANnJOVHbCGcgnHT3qVbHGFh_Ba0=FqABSoM2SG9ddf-fawwaYg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 10 Apr 2019 16:19:36 -0700
Message-ID:
 <CAKmqyKNfm2jL+qDmnoXfur7CM2XGLOV2Vu6jNY5kNkxRcYFZpA@mail.gmail.com>
To: Jonathan Behrens <fintelia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::241
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Palmer Dabbelt <palmer@sifive.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410231936.anoo6IpHpk3ulEwaar8oUuzvg9yX_htnD7f56u_Z2vI@z>

On Wed, Apr 10, 2019 at 9:30 AM Jonathan Behrens <fintelia@gmail.com> wrote:
>
> Unless I'm missing something, the virt board doesn't support HTIF and
> should not be including this header.

Thanks for the patch!

You aren't missing anything, it can be removed.

>
> Jonathan

Can you send a v2 without the uncertainty in the commit message? Can
you also remove your name from the message? For such a small patch the
commit title by itself will be enough.

>
> Signed-off-by: Jonathan Behrens <fintelia@gmail.com>

With an updated commit message:

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

