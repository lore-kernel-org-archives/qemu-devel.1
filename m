Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BADC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD65B20674
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vmuj08Al"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD65B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibq4b-0002TV-SO
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 13:05:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ibq3w-00020L-N7
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ibq3v-0000cD-J9
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:04:44 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38304)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ibq3v-0000c7-DZ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:04:43 -0500
Received: by mail-oi1-x244.google.com with SMTP id b8so511171oiy.5
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 10:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bOPtoauUYnviVQTuXl+Qa5Rq8L2l4gqkUdXgm8dwmKE=;
 b=vmuj08AlYk0pgHFESE4KDWaRVU6cgNw4DyV12WAdej1mZ2UBuzrJym8zahAHyyMbuD
 EjlEpGJLM2/tobWopNqLpnxWb36JgHDaNP70qySifD0CYjNs5ZRYD7tdIYy9+Gd8tiex
 JaG1QK1Pe80VCaQRhIucgzpQgLR73D/IisZm/4e2GPBPgUVycx74LsR6YHhzI83Hv9bT
 nggIZgeaKJFWfAgl5Az9bDm1GdwkaT79yrs9e1e6s66tA4qi02KQzllAA6JIT85p3J1+
 YirVDq2ZFDl5R9+5kJH25yR1VWXxyZosNssBSRaEMHGi7cTbGm8zHp7FBShPN7VXuTB4
 zfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bOPtoauUYnviVQTuXl+Qa5Rq8L2l4gqkUdXgm8dwmKE=;
 b=feMajC+lKMfiOtuJy/61FctOlDuZRpYSxzRWCDsOmO8GAxhJrtdAyIuYQyoFRozo8C
 PxMvGvMi9DvJfy9MoBxmJTMqIi5A9MXYc/j5CxJwVSqcTIYqCYMlzV5StuJnv/QgOFDh
 x3Fu78etiPleJRuxsanKj2xpPAAFqYgoanC7EPu5MrNTkBVTErV3Bo+Q0HrjnaWIptSu
 E11y5TrWhZul/DPW1A8MCnSsbMT0U1LJtHv3tdoKq58RrIse/WQB/wieUmlkQIGmWuqf
 GL64eOM/Pfz+EK+Q/1VTMfTgWWdWAxJpt891rsQeipweyVrYDs4jst0RNxKAyei0Ztyc
 CC4g==
X-Gm-Message-State: APjAAAXWH9PQqOb6/irezXTEjEkBPgsxMoxHNZQLJJf/liVDGjStX25k
 hTkEINPXwGE5fKOGuOakxykK5NTrqefVWLJEtWlVXg==
X-Google-Smtp-Source: APXvYqxS25MWnT4Hi+U3IvJorWnABsPgD3QgEjZIOGB+JEvwA+/VEvH8RLp8EdHGC/MDoBi454TRGAeC6NB4ni9rBsE=
X-Received: by 2002:aca:3182:: with SMTP id x124mr259919oix.170.1575309882629; 
 Mon, 02 Dec 2019 10:04:42 -0800 (PST)
MIME-Version: 1.0
References: <20191129140217.17797-1-pbonzini@redhat.com>
 <20191129140217.17797-8-pbonzini@redhat.com>
In-Reply-To: <20191129140217.17797-8-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2019 18:04:31 +0000
Message-ID: <CAFEAcA_Y-8truVZkwHMULUwMkt01UwaCv62pgiKM2i=tskH6bw@mail.gmail.com>
Subject: Re: [PATCH 7/8] memory.h: Silence kernel-doc complaints
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 Nov 2019 at 14:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Fix a few instances where kernel-doc complains about doc comments
> in memory.h.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/exec/memory.h | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index e499dc215b..1e875996ec 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -360,10 +360,14 @@ typedef struct IOMMUMemoryRegionClass {
>  typedef struct CoalescedMemoryRange CoalescedMemoryRange;
>  typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
>
> +/** MemoryRegion:

Checkpatch thinks there should be a newline after the /**.

> + *
> + * A struct representing a memory region.
> + */
>  struct MemoryRegion {
>      Object parent_obj;
>
> -    /* All fields are private - violators will be prosecuted */
> +    /* private: */
>
>      /* The following fields should fit in a cache line */
>      bool romd_mode;
> @@ -452,7 +456,7 @@ struct MemoryListener {
>   * AddressSpace: describes a mapping of addresses to #MemoryRegion objects
>   */
>  struct AddressSpace {
> -    /* All fields are private. */
> +    /* private: */
>      struct rcu_head rcu;
>      char *name;
>      MemoryRegion *root;
> @@ -1673,8 +1677,8 @@ bool memory_region_is_mapped(MemoryRegion *mr);
>   *
>   * Returns a #MemoryRegionSection that describes a contiguous overlap.
>   * It will have the following characteristics:
> - *    .@size = 0 iff no overlap was found
> - *    .@mr is non-%NULL iff an overlap was found
> + * - @size = 0 iff no overlap was found
> + * - @mr is non-%NULL iff an overlap was found
>   *
>   * Remember that in the return value the @offset_within_region is
>   * relative to the returned region (in the .@mr field), not to the
> @@ -1685,8 +1689,8 @@ bool memory_region_is_mapped(MemoryRegion *mr);
>   * returned one.  However, in the special case where the @mr argument
>   * has no container (and thus is the root of the address space), the
>   * following will hold:
> - *    .@offset_within_address_space >= @addr
> - *    .@offset_within_address_space + .@size <= @addr + @size
> + * - @offset_within_address_space >= @addr
> + * - @offset_within_address_space + .@size <= @addr + @size
>   *
>   * @mr: a MemoryRegion within which @addr is a relative address
>   * @addr: start of the area within @as to be searched
> --
> 2.21.0

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

