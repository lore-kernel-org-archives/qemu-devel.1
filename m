Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D79C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 15:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 929A5214E0
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 15:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRTakYy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929A5214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUBhG-0001nd-M4
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 10:33:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1iUBec-00005R-50
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 10:30:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1iUBeb-0002wR-3h
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 10:30:58 -0500
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:38440)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1iUBea-0002vE-Tv; Mon, 11 Nov 2019 10:30:57 -0500
Received: by mail-yb1-xb43.google.com with SMTP id k206so2500955ybb.5;
 Mon, 11 Nov 2019 07:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nNX87jqf7w0yVC+SWgvceNRMH4E2BIFEdTKvtHwkW88=;
 b=HRTakYy7Q63CyRGUZ9nITftVbai57xCwUA4/OxZcep6z1FWq8smJV4G6OkupcBlsnt
 nqm0Ea30usX138sLfQvAU4NREMa+KnJzCnR9tZNtcpQh2Cm4sjy2U8TUIMD9zDjLmHaM
 9bsObPZgBNguCVemqFqah37gbrPWwqmcrp8AsuUJHz6wurvSEPSfVbkHP9EjHCdu2zUn
 vAO19ft6HqJocY+uLednhwYfbyPzcOMHoSI+7zhBqZ4a7iluNImCRToLQ6WUuRNqnSrj
 6mnPdocwXfrSS9nZ+QgK/uuDH7CPSfTWKGr+kCi1Ytw+cYBLLeOtU/8hywLvhDMu6Xqf
 /hrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nNX87jqf7w0yVC+SWgvceNRMH4E2BIFEdTKvtHwkW88=;
 b=VYVHVS9qzoAG5k0wG2+rf9pIE81DvNQxxozGTYcu6rMuaI1uemx6YW2+GjTc9A3I5b
 ecyJS/vQM4mrk+dR/HLmskzWSMmtz9J4S8aQEZznd/rY58sw108lcJVDNhSItCHdNsQL
 56fMhtXqpESXGcfEYFvXheyv459MG8MoulAIx+6iHTOAaqTXWfLJ0GcqzQeaOkcGYgeM
 f72BKNE9lQ7R/u88uzKQkIi7URA6m4YVmeeKaha/tJVwCoktKvhV+WP2LZq6BkwQ3DSH
 acUgewWN+gp90xbDGGwCYG+h7yJGBaVzJXVxiqRiDeQX4pUv6m6lGLnPUAXnBxH0Njou
 I97g==
X-Gm-Message-State: APjAAAUS9bc5D9BG1TKgMxGVdAeqUwKbIwO3yYlq617QdF/bT/hC56Gg
 1+kQHrN2UyXi7SVyrIHn54BkAPaB1OAnroWMb3Q=
X-Google-Smtp-Source: APXvYqzq2lCHJ5rDH1EDw7SEToEdbx1HFK3JpYPm+55NnT6E6tkaUUgaMOQHAvCtFL0jR+0zVv/D2VJDpeA9wdvurhM=
X-Received: by 2002:a25:4144:: with SMTP id o65mr21208253yba.11.1573486256031; 
 Mon, 11 Nov 2019 07:30:56 -0800 (PST)
MIME-Version: 1.0
References: <03c2f42b32fb4e304319c241122ae83584f085e0.1573087610.git.alistair.francis@wdc.com>
In-Reply-To: <03c2f42b32fb4e304319c241122ae83584f085e0.1573087610.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 11 Nov 2019 23:30:43 +0800
Message-ID: <CAEUhbmWaT06GAdz=d-oVtMsM6bOWR23bZjicgBsJLUHqaVRH7g@mail.gmail.com>
Subject: Re: [PATCH for 4.2 v1 1/1] riscv/virt: Increase flash size
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
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

On Thu, Nov 7, 2019 at 8:54 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Coreboot developers have requested that they have at least 32MB of flash
> to load binaries. We currently have 32MB of flash, but it is split in
> two to allow loading two flash binaries. Let's increase the flash size
> from 32MB to 64MB to ensure we have a single region that is 32MB.
>
> No QEMU release has include flash in the RISC-V virt machine, so this
> isn't a breaking change.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

