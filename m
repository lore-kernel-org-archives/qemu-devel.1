Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FD9C10DCE
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 02:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 250D42074B
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 02:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISKRyZ38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250D42074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCwq5-00060N-AJ
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 22:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1jCwpW-0005Ye-Bt
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 22:47:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1jCwpV-0004br-Bd
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 22:47:14 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:41207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1jCwpV-0004bS-87; Fri, 13 Mar 2020 22:47:13 -0400
Received: by mail-qk1-x742.google.com with SMTP id s11so4988432qks.8;
 Fri, 13 Mar 2020 19:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V33Nfi2fFPfeyvDwpaHOOyBVtzd9uH0yX578wpPPgHs=;
 b=ISKRyZ38E++TAOpqcoAmp+CiqNuGMJfFvdpoesBNkRIowd1meo1z3UgqbYecYZqEz+
 /GWB0EdyvjD8/9y0/Bbl+p/lsD4ZkC7J/WmZveeLVJ/nHf/np2rP96PazCWE1r6Raiss
 hatQCwqDQvxQdLu8wDggUP5ZnUsb5Wv/mucPYYRzpH+mtuf77H6viIzPvfzqbEEiawUt
 akksuyCUSpKquxdEO8ITiWfa+iRugKWlGcJcIRkEf52+Y5sB6Ftm2XhK4txyumKDZ5Px
 P+cNLTNK//R+SV/nns2IUbXbyl721BZzNmvYDAdhaq3MUnD6xc5EOMVr5d5AHgvjSh31
 t43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V33Nfi2fFPfeyvDwpaHOOyBVtzd9uH0yX578wpPPgHs=;
 b=YIvbca4ZKL6hKV9jddowpM3bV6p3LIBAcBy58mpqmKYf/EozqV0swKFQhMbd96G1kc
 We+pWcQ8t/hX1a1n26vUcWQg7wi1PO2ECtRWO8hBLhiACfJKZsXKTx+OvIY6BZkcHthl
 tslCjK3YxHghQcd7p+Lc47/pOIVcxUqNvUzPETMFf2GLraxjdTt0bwHbHy2u34OF+Inq
 +m5wmXd5R9i9i5RVQkuvyvEWTavl2Df5s0teBbRcwNs6mSY6sJDj0YjvMsb/WAbcdy6l
 sLJzpriA6gMyh2fXjnePZxzHeg4VQrT9u1uL42A+qhB7B3BMc4AUzdICg315qASgPvXn
 L9Dg==
X-Gm-Message-State: ANhLgQ1n7aCkipDSv9YmZI6SsnQkNCKx5bNs5tuxue/3s9ZFb+iyfscP
 PZ+yAhWY5kVZR5w/vvKFrvXzs0cKop6IpeZ/fdQ=
X-Google-Smtp-Source: ADFU+vuD0yV4NuzShVWlq7DUWFjv8+A1rs4jVDXwS0hs0si3XMcJum7oiI7dOrdG14SiBZ+Nzga1EkL06NJJPGD+h08=
X-Received: by 2002:a25:54d:: with SMTP id 74mr22592737ybf.490.1584154032719; 
 Fri, 13 Mar 2020 19:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200313193429.8035-1-coreyw7@fb.com>
 <20200313193429.8035-3-coreyw7@fb.com>
In-Reply-To: <20200313193429.8035-3-coreyw7@fb.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sat, 14 Mar 2020 10:47:01 +0800
Message-ID: <CAEUhbmUJ7ZrcodbkzPkny=5yZ2f4pNLPsdnqSB=XtNmn_0cECg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] target/riscv: Add a sifive-e34 cpu type
To: Corey Wharton <coreyw7@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Mar 14, 2020 at 3:35 AM Corey Wharton <coreyw7@fb.com> wrote:
>
> The sifive-e34 cpu type is the same as the sifive-e31 with the
> single precision floating-point extension enabled.
>
> Signed-off-by: Corey Wharton <coreyw7@fb.com>
> ---
> v2: Added missing RVU flag
>
>  target/riscv/cpu.c | 10 ++++++++++
>  target/riscv/cpu.h |  1 +
>  2 files changed, 11 insertions(+)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

