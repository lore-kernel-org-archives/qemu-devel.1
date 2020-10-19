Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7C2C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C05E0208B8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="zyQy1ExU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05E0208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUeU1-0001SZ-Sv
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 19:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1kUePZ-0005r4-Hs
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:17:53 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43207)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1kUePX-0008K9-OJ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:17:53 -0400
Received: by mail-pf1-x444.google.com with SMTP id a200so881675pfa.10
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 16:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=ihogz++RMafYFkYEoToIEZq3aX2RkLbpOQVdCdFpN/E=;
 b=zyQy1ExU1yJ+O3Kkq1w3a/ZyFF3HxJYAckBoGFeS6B3/swNmmmKZO4NOqAgsT1ZMbZ
 4oAw5vn7ZmzBsouss/1/hYhKH7pbh4acFefw172XWoB7GZU0d58R0Nh1Wy6OhQ9X1WDg
 x5kjJ3CssurAS9QSZ1WJyRyB0qIBRE42pOuNocfz26nbEhAnXqg8eke5QL+enGO5t/i1
 STiUhvmLuGIYGikvnJSd0eXIqcY97mdsP/QfYpKm05xwd95vv0gVHtHo57KsnV0C81Bw
 xNU8Q9iZy8o1cVLFLY29HmzIzwwzeoy/qmyCXnlN4V7sCWSMf4VGlDry28VQxlOHmzYl
 IyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=ihogz++RMafYFkYEoToIEZq3aX2RkLbpOQVdCdFpN/E=;
 b=Q6Q48hqI+An1D2VBDG/kydw9bTOt8YasWFuavYoYWPRWxyxTzYXgANe+J7qNkjkH10
 sDCxYFHRO0fOkxghXWkMLYKKLRiTwTkoi1X8BZgpN2vBnvo7HTNAzuEJMJoAr2FgOsIu
 naB5aYXhNuUUF+GkSwnUAe8n7B15k3qyaYSNSvGWwEt40f2x9rXxbSZPJ7xUZB7woqWj
 z7BhgNsiS4toXIjNnMnBvr0U4E4qJFin+r+UckOH7dHIL4V9H5O80UWL+Wl1nu68P6nm
 S1bly/HdHnMOi/KgneeTIR7nbjwzZiOsX0uJkSWJOYqxGeETHMbJCrbUPFfUd0KX2vKT
 I7Iw==
X-Gm-Message-State: AOAM530ERgf4dan0fhju5u64CvGogTCbNCkeXgjZlQmdClUhatxTT8QT
 7oMx4/AZ8tTEH1K1RnbAjAs4YhEhK+Kplw==
X-Google-Smtp-Source: ABdhPJzYFQucFg25h4CVtSJgFXoWgF546xL9UyEoLoBIZF9iODCP/UAN869sKf+OAOjQWobg9VzPmg==
X-Received: by 2002:a62:e516:0:b029:156:3b35:9423 with SMTP id
 n22-20020a62e5160000b02901563b359423mr1901913pff.19.1603149469893; 
 Mon, 19 Oct 2020 16:17:49 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223])
 by smtp.gmail.com with ESMTPSA id 23sm567144pgr.53.2020.10.19.16.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 16:17:49 -0700 (PDT)
Date: Mon, 19 Oct 2020 16:17:49 -0700 (PDT)
X-Google-Original-Date: Mon, 19 Oct 2020 14:40:44 PDT (-0700)
Subject: Re: [PATCH v2 3/4] hw/riscv: Add a riscv_is_32_bit() function
In-Reply-To: <4c6a85dfb6dd470aa79356ebc1b02f479c2758e0.1602634524.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-1ef1d729-a8e4-4116-b23f-509f3562eee1@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=palmer@dabbelt.com; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, bmeng.cn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 13 Oct 2020 17:17:30 PDT (-0700), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  include/hw/riscv/boot.h | 2 ++
>  hw/riscv/boot.c         | 9 +++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index 0acbd8aa6e..2975ed1a31 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -23,6 +23,8 @@
>  #include "exec/cpu-defs.h"
>  #include "hw/loader.h"
>
> +bool riscv_is_32_bit(MachineState *machine);
> +
>  target_ulong riscv_find_and_load_firmware(MachineState *machine,
>                                            const char *default_machine_firmware,
>                                            hwaddr firmware_load_addr,
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index fa699308a0..5dea644f47 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -40,6 +40,15 @@
>  #define fw_dynamic_info_data(__val)     cpu_to_le64(__val)
>  #endif
>
> +bool riscv_is_32_bit(MachineState *machine)
> +{
> +    if (!strncmp(machine->cpu_type, "rv32", 4)) {
> +        return true;
> +    } else {
> +        return false;
> +    }
> +}
> +
>  target_ulong riscv_find_and_load_firmware(MachineState *machine,
>                                            const char *default_machine_firmware,
>                                            hwaddr firmware_load_addr,

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

