Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFB3C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 18:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B1F72133F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 18:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSzAcByG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1F72133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxy4U-0003ZE-Bw
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 14:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1hxy3B-0002z7-TV
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 14:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hxy39-0004Xu-Ox
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 14:31:08 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:33994)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hxy36-0004Ux-3U; Wed, 14 Aug 2019 14:31:04 -0400
Received: by mail-lf1-x141.google.com with SMTP id b29so72797485lfq.1;
 Wed, 14 Aug 2019 11:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DFkgjpmN5cP3DrRJr9ukZaWTXCSxmvw+EK1ldDL4oxU=;
 b=bSzAcByGuhP+Ft0+LgjpT/+QJ5GS6QKg72SsYmaOI+rGGCjav2JL2ixuI2BMFbpFBS
 bvEkmBjBGEimMJCMlb5Gyyg8QOj+9ZFRNzybPpkfJdXoEbi0hv4m5AGo2h0WdDUJ/di+
 UAQUI3b7Wh3LMZMY/rPy4Heml+yY2kucTVI0uujQJJkbvWKjS13o2c+zO5L5b8vAG/oe
 GoPjvs63rn0ROhQqUn1rDQOxwXJj8kbQRHGtonz6P31g5Q6LeFe6tTW/8AHNVswHVfxI
 4d+A9qwu9RTni1e+n9jAKoBRrLwfqd0EeRFd3j8NizmEc6uKWecrfYQohQePBKj91UYO
 TMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DFkgjpmN5cP3DrRJr9ukZaWTXCSxmvw+EK1ldDL4oxU=;
 b=Vh3TJDzG0l8ap797hlcL8hdTiaGC18olgdFRZLR+9fJwLPCy9UXsIsy6qlXBXCZazu
 jtWLzRXq915OC7vTKjtympbyo4U73Rad957hniPCxkGwCgmmLuvpfyefh2AbKFdX46fA
 zH4CDOX7k0rtnFjWTUlL5JHDKHtAuOfoQOnwkD3q1tYkYitLKVlULnfHCDRX79hFS3tE
 qYKQOD7kFN1cCeWSjbmBlJPy3BnGsSGM0iMfERWtyrE57WQVDEyfWDc3/SLngaZicBR7
 WcVRJEvHaHRcqYKko9PNR52KllXwciswho3THQcBr4Amwn6vQx+AEWQZjh71CpXQCEnn
 kPZQ==
X-Gm-Message-State: APjAAAWdARFz/ybDe97uexr9W0LMClMCyCxLpibLi/Sm4ETOwQZqrM3s
 oaHVEN3o8XheRIW6TUAFCjuEUk5HON7kn5xxUFE=
X-Google-Smtp-Source: APXvYqxELyLM/QN0bktsKyz/1sGpNWW2A8d2ZXCEr8l6KU6n748nQKdZELghBnrDx3ERqgdkXfFXEtKHLt1roHGuNVs=
X-Received: by 2002:a19:c6d4:: with SMTP id w203mr388233lff.135.1565807460662; 
 Wed, 14 Aug 2019 11:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190813225307.5792-1-palmer@sifive.com>
In-Reply-To: <20190813225307.5792-1-palmer@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 14 Aug 2019 11:27:08 -0700
Message-ID: <CAKmqyKMJr=4-2VKKd9cE6LLts_y0OnDjm3v0sosgaZ+achxpGQ@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH v2] RISC-V: Ignore the S and U letters when
 formatting ISA strings
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
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 13, 2019 at 3:54 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> The ISA strings we're providing from QEMU aren't actually legal RISC-V
> ISA strings, as both S and U cannot exist as single-letter extensions
> and must instead be multi-letter strings.  We're still using the ISA
> strings inside QEMU to track the availiable extensions, so this patch
> just strips out the S and U extensions when formatting ISA strings.
>
> This boots Linux on top of 4.1-rc3, which no longer has the U extension
> in /proc/cpuinfo.
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

It looks like you are using tabs in here, once they are removed:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f8d07bd20ad7..a67c54c738ba 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -501,7 +501,23 @@ char *riscv_isa_string(RISCVCPU *cpu)
>      char *p = isa_str + snprintf(isa_str, maxlen, "rv%d", TARGET_LONG_BITS);
>      for (i = 0; i < sizeof(riscv_exts); i++) {
>          if (cpu->env.misa & RV(riscv_exts[i])) {
> -            *p++ = qemu_tolower(riscv_exts[i]);
> +            char lower = qemu_tolower(riscv_exts[i]);
> +            switch (lower) {
> +            case 's':
> +            case 'u':
> +                /*
> +                * The 's' and 'u' letters shouldn't show up in ISA strings as
> +                * they're not extensions, but they should show up in MISA.
> +                * Since we use these letters interally as a pseudo ISA string
> +                * to set MISA it's easier to just strip them out when
> +                * formatting the ISA string.
> +                */
> +                break;
> +
> +            default:
> +                *p++ = lower;
> +                break;
> +            }
>          }
>      }
>      *p = '\0';
> --
> 2.21.0
>
>

