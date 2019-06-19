Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E86C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 10:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095F42070B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 10:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095F42070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36868 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdYJB-0000Rz-3O
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 06:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34962)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hdYIJ-0008QF-Hc
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 06:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hdYII-0003CZ-D2
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 06:58:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35622)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hdYII-0003BQ-5Q
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 06:58:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id s27so9472263pgl.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 03:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=ug1+sTIOcguDXuV47ig3Ir+RrALqTw3KtFfEeZbCNWI=;
 b=aYlQ9YJiyPJhrbs8L0ISiAJ6K9vQsjigniNX8RKuN27fxS4v/sZpFW+aLAxqwp3f7j
 iYMROra4YZ+CaEYdAiR3ZQuoyBSmaGYcYqqkS6L8T+CiOIQytoONFfgvAaxDqwTETtHz
 /3JsaTOykOkem6sLAi0EhZLeWsdxHveRTSczfmICEweawYcpN4/U9lX4B3GMugYYxRfa
 FqJ9qlVk4X0JsFtBdVhGr3uCCxXofWkIJui6sUGQmilNGcsYj2Vxd6ibUbbrhb7dcrJT
 acf2ZIwqdynh/v3FOp63zPJ2sCH4xvE/DqFtW1GZZD93xwieu2U4CFFW5qKZsRlOJKQy
 kfdw==
X-Gm-Message-State: APjAAAUx1C9FnuHyxI05dS3e47fsn8bixXTyxWd7oQ2OfdI8sk5YGrGw
 9MmXXcroYakjf+CrjMp/gKb7k2aM6U+jLw==
X-Google-Smtp-Source: APXvYqyldb2X3lyR5+N43hUBL2cV+iEpZP0QBg50+htLuFimO0KvW7ROFDQJuwJiTKvA2ZHDB17hfg==
X-Received: by 2002:a62:78c2:: with SMTP id
 t185mr56756419pfc.142.1560941900737; 
 Wed, 19 Jun 2019 03:58:20 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
 by smtp.gmail.com with ESMTPSA id a22sm21898713pfn.173.2019.06.19.03.58.19
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 03:58:20 -0700 (PDT)
Date: Wed, 19 Jun 2019 03:58:20 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 03:54:09 PDT (-0700)
In-Reply-To: <cover.1560821342.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-966cacce-c410-473d-b043-996f3cff9a36@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.193
Subject: Re: [Qemu-devel] [PATCH v1 0/9] Update the RISC-V specification
 versions
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Jun 2019 18:31:00 PDT (-0700), Alistair Francis wrote:
> Based-on: <cover.1555726824.git.alistair.francis@wdc.com>
>
> Now that the RISC-V spec has started to be ratified let's update our
> QEMU implementation. There are a few things going on here:
>  - Add priv version 1.11.0 to QEMU
>     - This is the ratified version of the Privledge spec
>     - There are almost no changes to 1.10
>  - Mark the 1.09.1 privledge spec as depreated
>      - Let's aim to remove it in two releases
>  - Set priv version 1.11.0 as the default
>  - Remove the user_spec version
>      - This doesn't really mean anything so let's remove it
>  - Add support for the "Counters" extension
>  - Add command line options for Zifencei and Zicsr

Thanks!  I'll look at the code, but I've currently got this queued up behind
your hypervisor patches so it might take a bit.  LMK if you want me to invert
the priority on these.  I'll probably be buried until the start of July.

> We can remove the spec version as it's unused and has never been exposed
> to users. The idea is to match the specs in specifying the version. To
> handle versions in the future we can extend the extension props to
> handle version information.
>
> For example something like this: -cpu rv64,i=2.2,c=2.0,h=0.4,priv_spec=1.11
>
> NOTE: This isn't supported today as we only have one of each version.
>
> This will be a future change if we decide to support multiple versions
> of extensions.
>
> The "priv_spec" string doesn't really match, but I don't have a better
> way to say "Machine ISA" and "Supervisor ISA" which is what is included
> in "priv_spec".
>
> For completeness I have also added the Counters, Zifencei and Zicsr
> extensions.
>
> Everything else seems to match the spec names/style.
>
> Please let me know if I'm missing something. QEMU 4.1 is the first
> release to support the extensions from the command line, so we can
> easily change it until then. After that it'll take more work to change
> the command line interface.
>
> Alistair Francis (9):
>   target/riscv: Restructure deprecatd CPUs
>   target/riscv: Add the privledge spec version 1.11.0
>   target/riscv: Comment in the mcountinhibit CSR
>   target/riscv: Set privledge spec 1.11.0 as default
>   qemu-deprecated.texi: Deprecate the RISC-V privledge spec 1.09.1
>   target/riscv: Require either I or E base extension
>   target/riscv: Remove user version information
>   target/riscv: Add support for disabling/enabling Counters
>   target/riscv: Add Zifencei and Zicsr as command line options
>
>  qemu-deprecated.texi                          |  8 +++
>  target/riscv/cpu.c                            | 72 ++++++++++---------
>  target/riscv/cpu.h                            | 19 ++---
>  target/riscv/cpu_bits.h                       |  1 +
>  target/riscv/csr.c                            | 13 +++-
>  .../riscv/insn_trans/trans_privileged.inc.c   |  2 +-
>  6 files changed, 71 insertions(+), 44 deletions(-)

