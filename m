Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B57FC3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB6B20870
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAjedm6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB6B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9mmS-0007qU-3g
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 04:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1j9mlh-00077T-Re
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:26:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1j9mlg-0004k9-RN
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:26:13 -0500
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:45469)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1j9mlg-0004jh-NS; Thu, 05 Mar 2020 04:26:12 -0500
Received: by mail-yw1-xc43.google.com with SMTP id d206so4951329ywa.12;
 Thu, 05 Mar 2020 01:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ubfD/hQZzNOrfzbMaYHyYzozpLQuB4F/ZCpLlgKGeWA=;
 b=cAjedm6IfKA5m5FoNlAndqFcWrHWWreL3CMz0+m9ZEm0fwby/mNtBYMWGGiRS0MjLw
 +3ujoNnyt7Y23R/vmhaN/cB9C44E0uS9CvNv6lcpL7HUx82lVguNdk36kG/u3JpoFxMW
 Z1UetZwj4qO+DBxC2YZOAOaVY6wGhETGA0aZ1sSzjK8ieV3vYZxghEiW062PxwB/+3bq
 15quQrdSXSNuE6JbA0BIcQpBaNkL10jTGvAD6STsLYFbVMDAxnLFsEmzbTUz6EZFpBbm
 7d4NztXUOr8KJ+z83yXPqaBqiwonsPHMSuXTSxbnkEFt3CrfP5TuQtfVDIPugtZ0CDni
 3ONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ubfD/hQZzNOrfzbMaYHyYzozpLQuB4F/ZCpLlgKGeWA=;
 b=lmdttkW+RYq1gCDQhXJFTHIkf/lVfyW3jiIfLM6Bz6ZdYqvDmm3ue5AJVjWXFIuWRN
 FN7F6XLQWQud7MQ1YJ4EuE0m679xUtyBWDmfjux1zmdcaLyPA/xJ1e2vywIedUZymFqs
 e0dztuAnY76AKIlgV+tkoHsSv3NLcV4+yRKxtUiCQ9zAEVpmGGV6y6i+PZ2v+dS1eDkq
 KMwn8SvK7ecRsEW271VOiUSZ8r6siYX30ieC+6T13IFAiRDh/VKEO85eGnL+dF9uG7bs
 KVN2K3XJGAotnzzp2dTM/w13Db6vq2MtsWqR7iNg+Qe0rUgbftQOHvz/jjtquk6FHmYv
 Af7A==
X-Gm-Message-State: ANhLgQ3GPYfvk0IMWDv3AIvCXhhXvXa5zmOBP+a2jeJXvHCzgY8ie4hg
 im1hySczqB8b8Df+74Rbo5GuBJDYL67OCy+dggs=
X-Google-Smtp-Source: ADFU+vuA76UfskY6h3j23Py7UEmHi7RDvtPZezY9Ej4kRAESi6EATAqBQdlS/1JhUaXbamN1mexVw/rIjF1/plZsQ9A=
X-Received: by 2002:a25:bd87:: with SMTP id f7mr6997145ybh.11.1583400371876;
 Thu, 05 Mar 2020 01:26:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1583362888.git.alistair.francis@wdc.com>
 <d1942aa2b5ce772070507bbe7c1cd1d280b36323.1583362888.git.alistair.francis@wdc.com>
In-Reply-To: <d1942aa2b5ce772070507bbe7c1cd1d280b36323.1583362888.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 5 Mar 2020 17:26:00 +0800
Message-ID: <CAEUhbmW3VBUTTwAyh5EtAAZf-Mr4UFZtdNAaUBCyYfAZFUi1yg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] riscv/sifive_u: Add a serial property to the
 sifive_u SoC
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 5, 2020 at 7:11 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> At present the board serial number is hard-coded to 1, and passed
> to OTP model during initialization. Firmware (FSBL, U-Boot) uses
> the serial number to generate a unique MAC address for the on-chip
> ethernet controller. When multiple QEMU 'sifive_u' instances are
> created and connected to the same subnet, they all have the same
> MAC address hence it creates a unusable network.
>
> A new "serial" property is introduced to the sifive_u SoC to specify
> the board serial number. When not given, the default serial number
> 1 is used.
>
> Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/sifive_u.c         | 8 +++++++-
>  include/hw/riscv/sifive_u.h | 2 ++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>

