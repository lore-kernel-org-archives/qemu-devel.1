Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1713CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:15:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A65E02064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eY/S4Yd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65E02064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNJIP-00007c-0t
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 12:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iNIud-0001oG-Gs
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iNIuc-0002C9-4s
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:51:03 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37404)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iNIub-0002Bg-Qg
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:51:01 -0400
Received: by mail-pf1-x444.google.com with SMTP id y5so13188976pfo.4
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=lGu68nCovEPsrHRd7JaveUjJGF93eRXSwxmkZjlbdJw=;
 b=eY/S4Yd3LHO7/oBnR0ioqvL15/MAblYJdjBoQQfRfMp9MMWfLpMmIoXY26MNTgCA8N
 gFpFxlw3lyK4KWVaWZcefIHmmmVA+T0LKduUO9yQQIArBZc1gCw2pjaKvfOSEj7Vk7QG
 yd439nMD1QfcnuFIgcGHUqfjVnJ5tnuKzhSvEteyKRdUfL66y9/pdsWkwakusWBPRwSr
 a3fgeuBRVojwSVlRysyCxvKOijnOQs+NS30cyKAVU1IXbLBlR5YeZ/xrVKjlwsHJ5vGg
 mtSMvwHl8Hy7Ot1Wk9rksXQr40yR6NQUXjvdiYWNRLx/YiOzPfT+vTDQ8RFcPpWPTUEO
 kU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=lGu68nCovEPsrHRd7JaveUjJGF93eRXSwxmkZjlbdJw=;
 b=EjeHRD1C+tGsscteFlsWytxwO2TZa4nuIsW6Eb4eURXHvASpELKenXyq8jSn0iT3sg
 OGFuK0aSpIvS7pNfx95Isiei6p0gX8A1auhO6g1LN9asrthvR0Rvf9k5WHFnh7T1c2JT
 uZDkuj8Nk23sizZiV5AE84lX/Y+xFNAPqrYxC67tt6naybVXrrXviOXeMYB4nyvMxAGB
 Z8ytyOZVIhupCB2NFM7MOqeRZBFb7RCvvMYyXEJYIDVeMEHEXAxicH+NP/E9krSW6DfA
 onBkhkr5AaHvxxQtjexNcMbhURS1vvqWJZC1VCNMt4Qm/ohHSOk24jjdHnxGJM/f30ZM
 WlFA==
X-Gm-Message-State: APjAAAUjFiwW7A3ifXhw8z75VnQStn6nqKsCVztFHDmo+kgZB9BsenGz
 +REMxo/xAdFEgixiI/WFDizVXAzSYjJeJg==
X-Google-Smtp-Source: APXvYqyT6x8Swfsd/vljMYdifmUQe4kOcuKxi4C660WcA6a1PgzYQ0K4zq7zAhq0m2x8KyZECeJobQ==
X-Received: by 2002:a62:31c2:: with SMTP id
 x185mr11788403pfx.112.1571845860194; 
 Wed, 23 Oct 2019 08:51:00 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id 64sm23863659pfx.31.2019.10.23.08.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:50:59 -0700 (PDT)
Date: Wed, 23 Oct 2019 08:50:59 -0700 (PDT)
X-Google-Original-Date: Wed, 23 Oct 2019 08:50:19 PDT (-0700)
Subject: Re: [PATCH] target/riscv: PMP violation due to wrong size parameter
In-Reply-To: <20191022212129.8452-1-dayeol@berkeley.edu>
From: Palmer Dabbelt <palmer@sifive.com>
To: dayeol@berkeley.edu
Message-ID: <mhng-bdf2777a-b43b-4192-aa4f-ba07fa146a62@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu, dayeol@berkeley.edu,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, diodesign@tuta.io
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 22 Oct 2019 14:21:29 PDT (-0700), dayeol@berkeley.edu wrote:
> riscv_cpu_tlb_fill() uses the `size` parameter to check PMP violation
> using pmp_hart_has_privs().
> However, if the size is unknown (=0), the ending address will be
> `addr - 1` as it is `addr + size - 1` in `pmp_hart_has_privs()`.
> This always causes a false PMP violation on the starting address of the
> range, as `addr - 1` is not in the range.
>
> In order to fix, we just assume that all bytes from addr to the end of
> the page will be accessed if the size is unknown.
>
> Signed-off-by: Dayeol Lee <dayeol@berkeley.edu>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/riscv/pmp.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 958c7502a0..7a9fd415ba 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -232,6 +232,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
>  {
>      int i = 0;
>      int ret = -1;
> +    int pmp_size = 0;
>      target_ulong s = 0;
>      target_ulong e = 0;
>      pmp_priv_t allowed_privs = 0;
> @@ -241,11 +242,21 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
>          return true;
>      }
>
> +    /*
> +     * if size is unknown (0), assume that all bytes
> +     * from addr to the end of the page will be accessed.
> +     */
> +    if (size == 0) {
> +        pmp_size = -(addr | TARGET_PAGE_MASK);
> +    } else {
> +        pmp_size = size;
> +    }
> +
>      /* 1.10 draft priv spec states there is an implicit order
>           from low to high */
>      for (i = 0; i < MAX_RISCV_PMPS; i++) {
>          s = pmp_is_in_range(env, i, addr);
> -        e = pmp_is_in_range(env, i, addr + size - 1);
> +        e = pmp_is_in_range(env, i, addr + pmp_size - 1);
>
>          /* partially inside */
>          if ((s + e) == 1) {

Thanks.  I've queued this up for my next pull request.

