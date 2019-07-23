Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3C6C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 18:08:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC585205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 18:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQ+smv+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC585205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpzDN-0005RK-56
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 14:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34506)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hpzDD-000501-TD
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 14:08:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hpzDC-0004TS-T9
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 14:08:31 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:40450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hpzDC-0004Sc-Oi; Tue, 23 Jul 2019 14:08:30 -0400
Received: by mail-io1-xd42.google.com with SMTP id h6so83783443iom.7;
 Tue, 23 Jul 2019 11:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VBJh6Kh+3IVi7vzQ+fYq1sXUwYpPLUGzKDCNsMbyP10=;
 b=rQ+smv+EyxvNKoJ9akS++YKhBVxeUUqk+JQLd6h4f7K6enNjMQTdub7j+1ARBniCdD
 POin4Kw+NN1WaH2J01eI338kaVSFcTHZW+1zQ71zJOojfCOuHRppNjws4sdq1Hv/oUcA
 D8ng4mho4lCtuL8OyhNlHUn4DiUvDE2kcCE4KAQXehc1J4uCotRC6YpggeLb2o5PlHGn
 /bJdhR+sxN2/tHwV7ADrV1mexS38gU2YhXPhuZUtD+bcLsBf56rrP05j2fu8CCmWdQ8m
 vYXaJmmTB/exSBJXp55U2EBQGN9aLIwbtpqJkIwxOdSK6ARG5+aE47v7nLU25sFsIjrT
 36DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VBJh6Kh+3IVi7vzQ+fYq1sXUwYpPLUGzKDCNsMbyP10=;
 b=h4uMSEcvuVDoH9GIbGSk8RlCwiCKpx7mqMLPqF+3mzpOt/Q/UdKN/A3AkxZrTEF8Ul
 VI7i3As095r2WOGY7AN1P8lMJBlvR54IAX67eaofbLNb9e1N+iKOMdOUFZ28S4hcw3Xx
 ifadssbIDS17Py0WD6SBSLPMcNZdqBR/HAmH0dUKrjruR5fhuHGVwyVut2kQAHMdY1bD
 sWzGkVXaF7RFFMkEIgudNRUH3E+X4lx8SPzrAJIgvQ4tCHm0WpXv3BiHrIc3Id6kzcgS
 9C8K9ip/dRBt3IT1PbBfUTdtL/UggIuW2j/ro2vlbj1pj6Y0fK+bVMFs75LaAtQEgdCN
 vf4g==
X-Gm-Message-State: APjAAAVsi6ETKcLXxtgnCAk1xDEQ0nyg80e6hCEPWze44kZTzpmJbL6+
 ZhDwEBn4q2AKToqtPq2mdMcCrrPyQapZjl6erNU=
X-Google-Smtp-Source: APXvYqzH+k6VQD4+cAvw4KtbQr7UIMDfLtK26oQn7+glfmzXSqjPf/ucD88QXugSv9A/gbc7i3pLKqYvncMJl/g7Aac=
X-Received: by 2002:a5e:9b05:: with SMTP id j5mr9272902iok.75.1563905309986;
 Tue, 23 Jul 2019 11:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190723120816.1361-1-philmd@redhat.com>
 <20190723120816.1361-2-philmd@redhat.com>
In-Reply-To: <20190723120816.1361-2-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 23 Jul 2019 11:05:02 -0700
Message-ID: <CAKmqyKP2ez1Sbv4Sr4hdFn8mQ7LjkNscPKEkDV7dTss+MTDb6w@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Subject: Re: [Qemu-devel] [PATCH-for-4.2 1/2] target/riscv/pmp: Restrict
 priviledged PMP to system-mode emulation
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
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 23, 2019 at 5:08 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The RISC-V Physical Memory Protection is restricted to privileged
> modes. Restrict its compilation to QEMU system builds.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/Makefile.objs | 3 ++-
>  target/riscv/pmp.c         | 4 ----
>  2 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
> index b1c79bc1d1..b754e4bf32 100644
> --- a/target/riscv/Makefile.objs
> +++ b/target/riscv/Makefile.objs
> @@ -1,4 +1,5 @@
> -obj-y +=3D translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o=
 gdbstub.o pmp.o
> +obj-y +=3D translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o=
 gdbstub.o
> +obj-$(CONFIG_SOFTMMU) +=3D pmp.o
>
>  DECODETREE =3D $(SRC_PATH)/scripts/decodetree.py
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 958c7502a0..d836288cb4 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -28,8 +28,6 @@
>  #include "qapi/error.h"
>  #include "cpu.h"
>
> -#ifndef CONFIG_USER_ONLY
> -
>  #define RISCV_DEBUG_PMP 0
>  #define PMP_DEBUG(fmt, ...)                                             =
       \
>      do {                                                                =
       \
> @@ -382,5 +380,3 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uin=
t32_t addr_index)
>          return 0;
>      }
>  }
> -
> -#endif
> --
> 2.20.1
>
>

