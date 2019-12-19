Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C57C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3817206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ej6/gQnY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3817206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii00G-0000Hg-Eq
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 12:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1ihzeI-0005tL-O9
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:31:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1ihzeG-0002JM-1a
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:31:41 -0500
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:34238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1ihzeF-0002Em-P9
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:31:39 -0500
Received: by mail-il1-x142.google.com with SMTP id s15so5574305iln.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 09:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ke7qZbM7reiuSB3wk55Kx2dSl54u4c20ddNDMFW954o=;
 b=ej6/gQnYxEetc8DV/K6ZU1QR+FVGa12N+Tz4gAPTaVJx+WxpHZ+KpsXP4biZr28IRe
 FNqRrpIvp2JFyd5HRRdbqpjtrFDeRMV2IZerqFw6mOIuTKjFnBGFMKKAhx1jKFyoOFXf
 s9QQQBhB0C0kgIgWRASQDQ/+m/MYW4Mj8WZsEQSOfIFIOBEhukkH3znXAFG4WZ67K3kW
 I6CRtoBW6eDhH8Mu7GJEZG1l/DdKJs3G3r8go8nBzLlNUxBYw9b5vqS4cGoUaqbcKk60
 2A2uwQFJ9TXJIZBfW/8J0D4eHSIAbqJVLu0EkEQE/hqspJjRi0bX18cy6XX5yb9AnuGH
 /bAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ke7qZbM7reiuSB3wk55Kx2dSl54u4c20ddNDMFW954o=;
 b=GOX8CrhXKvJxZ3RyaDDmxe8vvwTOcgmtPATDjjiwiLOOBkMguu8H6AwVNImYl2Sg3O
 ViK3ZW0eaqfTTY5HuR4zJQov65lwU+/ssuHuFe+1pXYNRrQyiseSfZVJHP8k99h1H2hS
 PSJWpp3+psU4AbrcwptRK2vkSt+HWdrgXPtprxfeTlRw1BL5oMgCCpTkTHia1797RLiR
 tYjE/AXGefFsbgeSktcuKfN816NIn2H/GEIOs/XU+DetZqZ6jdpZc/fqfeLx8dGaOUaN
 YeezZhNxMHhXH9UrKlMW6tXuGTVWjwcl2U+L8HT1b1KUrdTXO/XAupchZQ1ZaLHmxQHP
 rkfw==
X-Gm-Message-State: APjAAAXnIkIPwjxaVIKAvuYJTuzPHKEQy2cQg8gTkDe01ihSTtlI1fQ5
 3nTqg0cQWvvXfHhxCeNesrRdFgQRydQnTaqIxFvrMA==
X-Google-Smtp-Source: APXvYqz+d6L07kzmv0DlFJ9USrark7KAHFzfO4PO8h8XVoKOddD65DENrT6T9IU0C2OfA72ijkdmtRMUSaqZLVZ7eRQ=
X-Received: by 2002:a92:84d1:: with SMTP id y78mr8100876ilk.69.1576776698827; 
 Thu, 19 Dec 2019 09:31:38 -0800 (PST)
MIME-Version: 1.0
References: <20191219154214.GE1267@perard.uk.xensource.com>
 <20191219154323.325255-1-anthony.perard@citrix.com>
In-Reply-To: <20191219154323.325255-1-anthony.perard@citrix.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Thu, 19 Dec 2019 17:31:25 +0000
Message-ID: <CADSWDzs3sAec4iY3pCOUCexBZtRDG6jG_ecmccf77wP+xShhTg@mail.gmail.com>
Subject: Re: [PATCH] Memory: Only call ramblock_ptr when needed in
 qemu_ram_writeback
To: Anthony PERARD <anthony.perard@citrix.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::142
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Anthony,

On Thu, 19 Dec 2019 at 15:43, Anthony PERARD <anthony.perard@citrix.com> wrote:
>
> It is possible that a ramblock doesn't have memory that QEMU can
> access, this is the case with the Xen hypervisor.
>
> In order to avoid to trigger an assert, only call ramblock_ptr() when
> needed in qemu_ram_writeback(). This should fix migration of Xen
> guests that was broken with bd108a44bc29 ("migration: ram: Switch to
> ram block writeback").
>
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
>  exec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/exec.c b/exec.c
> index a34c34818404..b11010e0cb4c 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2166,14 +2166,13 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
>   */
>  void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t length)
>  {
> -    void *addr = ramblock_ptr(block, start);
> -
>      /* The requested range should fit in within the block range */
>      g_assert((start + length) <= block->used_length);
>
>  #ifdef CONFIG_LIBPMEM
>      /* The lack of support for pmem should not block the sync */
>      if (ramblock_is_pmem(block)) {
> +        void *addr = ramblock_ptr(block, start);
>          pmem_persist(addr, length);
>          return;
>      }
> @@ -2184,6 +2183,7 @@ void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t length)
>           * specified as persistent (or is not one) - use the msync.
>           * Less optimal but still achieves the same goal
>           */
> +        void *addr = ramblock_ptr(block, start);
>          if (qemu_msync(addr, length, block->fd)) {
>              warn_report("%s: failed to sync memory range: start: "
>                      RAM_ADDR_FMT " length: " RAM_ADDR_FMT,

We could also do :
void *addr = block->host ? ramblock_ptr : NULL

Looks good to me thought.
Thanks for fixing.

BR

Beata
> --
> Anthony PERARD
>

