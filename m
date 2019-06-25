Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A616C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 09:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086352146E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 09:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJT6s9AR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086352146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57824 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfhee-0003ra-8U
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 05:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40919)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hfhcs-0002YK-MO
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hfhcr-0000aJ-Q7
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:20:30 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:42623)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hfhcr-0000YJ-Jf; Tue, 25 Jun 2019 05:20:29 -0400
Received: by mail-ed1-x542.google.com with SMTP id z25so26100354edq.9;
 Tue, 25 Jun 2019 02:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5nNAQ6TNFgZWa3+/JyB2SRv7ZznuPusxfkmaMheDPq8=;
 b=oJT6s9ARd0QA2NaBdyHxQmZq0SnBDDblqg1lFiOa+TJg+B1HryiLcI+ITlFg+kPv4z
 RDPwUn64rNxcwzcSil6g0ZsLQNF4jzHUmb1umcgUdH103PbIN8xxBqZlDB+WD1PGDxXR
 v5XJhFuB+5lj0P9dTKWawQHYrLiSkU9BZ1E0Xcc+hQUPF1Kpk4WaA4ryUTju141pyvLD
 RPSD0lfxFhC8DQoL7KGwiHACOPqOOffARvenuxx+6ucGwIeXQ4YibYSTKpFFuNFZhgcv
 cryYW+/jSleN2l9PgzZluYfTKuMAKo82wpm4eAlRZ5ybmVAM5OZfCYcQ+9rhG7em99eS
 BHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5nNAQ6TNFgZWa3+/JyB2SRv7ZznuPusxfkmaMheDPq8=;
 b=RlG6D2806HNLoSJWD47wjkUh9KTrQ85pClplrOPKSrjixPYC3gKK8nSEehWYDXV2SW
 uwZJ5Bm+Em7FLCGWR4qZZ5sL1pSZmHyljavrPSW72uyO0BggCmk7TqrsNHFIacXkHnh9
 QrKaTjZphHsGR58/sKpP3FATWDzJPaEFX7IW5D6aw9+aXw0SY65cYed1ri0rsz6I/uW6
 e2Ww0DsC7hjfHExlnyY6lIAPd2mRFg4nP62F7tjC3Que9GwpWD2+6XwIB189ejqV37BN
 +iVAH3bkFpUqnQL9psy/WaggA6D1MqAfcDlC43guAIbS4YT3kLgxidGQxfE76nCV7hdW
 7opQ==
X-Gm-Message-State: APjAAAVeEI7sts7ZdLKKuo88mdaC7pU0eiz4FK4V7LhX+YskkG2qi1nW
 hSU+Na+xWQfPnpfgtxqP1I1S+ImjsshRhyVngvXgrg==
X-Google-Smtp-Source: APXvYqyzUvJl33mB7K8d4gN/wpm7HtZBV9E13tXsEOWArAGpiHI8XyE9Tj5aMmg08dXySlAQmG/G6vY2aWUGetS2yuI=
X-Received: by 2002:a50:9451:: with SMTP id
 q17mr106854310eda.119.1561454428577; 
 Tue, 25 Jun 2019 02:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561414240.git.alistair.francis@wdc.com>
 <03cdfe700a884b52a9f6da0e50bc0693c9a61e03.1561414240.git.alistair.francis@wdc.com>
In-Reply-To: <03cdfe700a884b52a9f6da0e50bc0693c9a61e03.1561414240.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 25 Jun 2019 17:20:17 +0800
Message-ID: <CAEUhbmWPo5YtaCrzaQZutGHMjj-7ddRk2kUQzxyZg9MsCM=CKA@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v1 3/5] hw/riscv: Extend the kernel loading
 support
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
Cc: Alistair Francis <alistair23@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 6:18 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Extend the RISC-V kernel loader to support Image and uImage files.
> A Linux kernel can now be booted with:
>
>     qemu-system-riscv64 -machine virt -bios fw_jump.bin -kernel Image
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/boot.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>

