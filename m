Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E2FC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 15:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A613206B9
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 15:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DraZjMGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A613206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT5P3-0001vx-6a
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 11:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jT5NP-00072U-Ia
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:08:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jT5NP-0000Yg-8N
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:08:55 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:38475)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jT5NN-0000Vo-RD; Mon, 27 Apr 2020 11:08:53 -0400
Received: by mail-io1-xd42.google.com with SMTP id k23so3918185ios.5;
 Mon, 27 Apr 2020 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yvwNr0TsV2C5FRbW9IT1GpULplIKWmq+3NhtuDOm2Ao=;
 b=DraZjMGhcItQ7MjC5WvBbW8tUbrF+CKmEmGKt8hs34vGnyhrkrSMhG1Wxg/HZD9v6u
 PXU9r33RgYxo1S5jsxgckuJ/bPZzUBANXcwyg+K9E5o6xBf+97apSl4IEjNkm1e+x8uL
 ktQoEX/VfDOlciD86myI6Ns0CPGotfvOWnHkeDemRMifiR/wv4Tc1xXVYAlrI6ThKUFy
 LrDP+BGsFKpnX926IB8HTXJViUj9Of7VNA9F/roOEEqzAr5cWeU0JC4OnhWEk9KH1F+F
 N5KqPO3ho1Nhs9g3Igj847CEguU3zYo9oB/ytZwNpT09atfgjtSr/EIxiI7AuwP98eld
 ZZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yvwNr0TsV2C5FRbW9IT1GpULplIKWmq+3NhtuDOm2Ao=;
 b=Ma2jYDfku9FEbpgF1xDCh5LkUG31Z5IdyWCBpMf7bmMGIAx10fwU9Vp6EhfrbT9ErH
 CH62BQ6H6zhjD5UGGjIIAQor9yKB+4uQszZDB9LHRUgg6XRdsuksUfROrX8BCI/zPBR9
 WAhCteZcuc9J/lS73dp0jR2VDE7V+ysdhQFz1yHYfIo4Fo6tGBRyG8JB6p8O+5jj3hDq
 YfvAAOZszUKMI/OgWKeDqOfjrxhmkhDS68Y2RlXBu1LUiYcsWVQwBcNF2mkOTN44tOni
 NeXqwwP3Amng+3nBwyyJuBUxUQfOF+kNVXQkbdt/liG0ufzwaz6sgWd+fIFuHn3SVJ5s
 aYyQ==
X-Gm-Message-State: AGi0PuZXiPFqHnhruat2pSsidswqvV4toQfWue++pBKp0v7W3BAlDsJh
 E3OISkqmJEEFSo6RhfgQoeuGjN2MWrYWKfQzZT4=
X-Google-Smtp-Source: APiQypIGRUfcUh5thKLZUlvqgIb9s+Y/dqn5JFT4BnBpWvrmxH/X5Uudwd3o6fTAYGRqFaffM+7Z0BluBBmSztucmg4=
X-Received: by 2002:a5d:984b:: with SMTP id p11mr21271941ios.175.1588000131966; 
 Mon, 27 Apr 2020 08:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200427080644.168461-1-anup.patel@wdc.com>
 <20200427080644.168461-4-anup.patel@wdc.com>
In-Reply-To: <20200427080644.168461-4-anup.patel@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 27 Apr 2020 08:00:14 -0700
Message-ID: <CAKmqyKOM-xWOx_MmcwVT_Gt7VcaV9LgJxNaB8m5jYnr1FAHHVw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] hw/riscv/spike: Allow more than one CPUs
To: Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d42
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

On Mon, Apr 27, 2020 at 1:09 AM Anup Patel <anup.patel@wdc.com> wrote:
>
> Currently, the upstream Spike ISA simulator allows more than
> one CPUs so we update QEMU Spike machine on similar lines to
> allow more than one CPUs.
>
> The maximum number of CPUs for QEMU Spike machine is kept
> same as QEMU Virt machine.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/spike.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index b0395e227c..1799b9291c 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -472,7 +472,7 @@ static void spike_machine_init(MachineClass *mc)
>  {
>      mc->desc = "RISC-V Spike Board";
>      mc->init = spike_board_init;
> -    mc->max_cpus = 1;
> +    mc->max_cpus = 8;
>      mc->is_default = true;
>      mc->default_cpu_type = SPIKE_V1_10_0_CPU;
>  }
> --
> 2.25.1
>
>

