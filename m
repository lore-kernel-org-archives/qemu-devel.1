Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34B4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 20:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83C242078D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 20:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agQGxu3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C242078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlIGW-0002rd-MX
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 16:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jlIFu-0002Pq-TV; Tue, 16 Jun 2020 16:32:27 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:35884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jlIFt-0007uI-2o; Tue, 16 Jun 2020 16:32:26 -0400
Received: by mail-il1-x143.google.com with SMTP id a13so3259121ilh.3;
 Tue, 16 Jun 2020 13:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4Y4bqwqBJ8bY09+wzc1iM9GySfKXguHDXQ1WuijyLYs=;
 b=agQGxu3dvZ0fCcONqXaxJ2rnL05PxcXUNCfVvU8+1LY2VqYVIGSDxtJUu/tY2KaPNO
 V54f8Fs4c6HHrrnd1ZNMkHgx1mkciqTWGjv/k3ANWGlso1BtremO/A1atllgdMkzyGea
 oo1/o6i+IQYil7qZpvJVry4fS26E50V7+gikJ8jteiJpd+gWWjRmXU1iP9p+E6gdw5zW
 Rd2Jj4kkXF8+RBR4kxw6m8qTqkmYS7qvwfh7KlxSaYZOzVvyCvGBAMUDNQ3g9QJ2awnD
 OORBaP6swLeX+dd4SeLZyURbHOeVDYk4pdlcR6KM1qzDcb7ZcewhPUvydOao0lcjCBXP
 PaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4Y4bqwqBJ8bY09+wzc1iM9GySfKXguHDXQ1WuijyLYs=;
 b=nUlE/yYW9aSUIAHRTJa/R3zEhPOd5ClsKZZ1l980vieRZvMTouhzrLDOudvtlHmaT0
 t6uCdt7pYdejPflimaWDpvRmAJaJfXK028LZfbnzMO+jS4pdVaD2DQFUF8ke0p44Y8EJ
 1NWsR9Y+gP9znljv+OOvYkQHte3+GOQBFWkES8W+ryLCi3h6CJPNHptidFgAMsgG4Y1I
 poMBd1r2stPIOwK+04LOuqm1cT+7hyDeogTFdeiV5ODfS6Sct1ZkS3hCE/st5vLo3YzZ
 K9VAzsF5lVYlIKNnZZLY2gf5qiDfI4vel7CTfWd74sbN1jbV/G2kPMSyLgF5yznf1b5i
 RP9g==
X-Gm-Message-State: AOAM533Pwp38vo+DUpZk77vbbXj7otz9OBRHNzbUEJlnL39O55qrgnQw
 Zsmov08xHF4D+xsTrYUW8KuNtNUF0d6XQ3Mhmyo=
X-Google-Smtp-Source: ABdhPJxp8d1nS5oTKpeFICkfKsLlY/v+lhZgjfZlAhB84JT/NXwMeUMND2OWqjirnnra2aqcHyYlhNgha+uYUQeeYXc=
X-Received: by 2002:a92:c94b:: with SMTP id i11mr5202304ilq.177.1592339543740; 
 Tue, 16 Jun 2020 13:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200616032229.766089-1-anup.patel@wdc.com>
In-Reply-To: <20200616032229.766089-1-anup.patel@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2020 13:23:00 -0700
Message-ID: <CAKmqyKOinG2szot6ka3WdoOtx48qbrfwe9h4uT0zs1jynuNmYA@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] RISC-V multi-socket support
To: Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 15, 2020 at 8:23 PM Anup Patel <anup.patel@wdc.com> wrote:
>
> This series adds multi-socket support for RISC-V virt machine and
> RISC-V spike machine. The multi-socket support will help us improve
> various RISC-V operating systems, firmwares, and bootloader to
> support RISC-V NUMA systems.
>
> These patch can be found in riscv_multi_socket_v6 branch at:
> https://github.com/avpatel/qemu.git
>
> Changes since v5:
>  - Rebased patches on Spike changes from Alistair
>  - Added comments describing RISC-V NUMA helper functions
>
> Changes since v4:
>  - Re-arrange patches and move CLINT and PLIC patches before other
>    patches because these are already reviewed
>  - Added PATCH3 for common RISC-V multi-socket helpers
>  - Added support for "-numa cpu,node-id" option in PATCH4 and PATCH5
>
> Changes since v3:
>  - Use "-numa" QEMU options to populate sockets instead of custom
>    "multi-socket" sub-option in machine name
>
> Changes since v2:
>  - Dropped PATCH1 as it is not required any more
>  - Added "multi-socket" sub-option for Spike and Virt machine
>    which can be used to enable/disable mult-socket support
>
> Changes since v1:
>  - Fixed checkpatch errors and warnings
>  - Added PATCH1 for knowning whether "sockets" sub-option was specified
>  - Remove SPIKE_CPUS_PER_SOCKET_MIN and SPIKE_CPUS_PER_SOCKET_MAX in PATCH3
>  - Remove VIRT_CPUS_PER_SOCKET_MIN and VIRT_CPUS_PER_SOCKET_MAX in PATCH5
>
> Anup Patel (5):
>   hw/riscv: Allow creating multiple instances of CLINT
>   hw/riscv: Allow creating multiple instances of PLIC
>   hw/riscv: Add helpers for RISC-V multi-socket NUMA machines
>   hw/riscv: spike: Allow creating multiple NUMA sockets
>   hw/riscv: virt: Allow creating multiple NUMA sockets

Applied to the RISC-V tree

Alistair

>
>  hw/riscv/Makefile.objs          |   1 +
>  hw/riscv/numa.c                 | 242 +++++++++++++++
>  hw/riscv/sifive_clint.c         |  20 +-
>  hw/riscv/sifive_e.c             |   4 +-
>  hw/riscv/sifive_plic.c          |  24 +-
>  hw/riscv/sifive_u.c             |   4 +-
>  hw/riscv/spike.c                | 237 +++++++++-----
>  hw/riscv/virt.c                 | 530 ++++++++++++++++++--------------
>  include/hw/riscv/numa.h         | 113 +++++++
>  include/hw/riscv/sifive_clint.h |   7 +-
>  include/hw/riscv/sifive_plic.h  |  12 +-
>  include/hw/riscv/spike.h        |  11 +-
>  include/hw/riscv/virt.h         |   9 +-
>  13 files changed, 873 insertions(+), 341 deletions(-)
>  create mode 100644 hw/riscv/numa.c
>  create mode 100644 include/hw/riscv/numa.h
>
> --
> 2.25.1
>
>

