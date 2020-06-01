Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF86C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7291A206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeADWRQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7291A206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfhbU-0002SK-JZ
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 06:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jfha5-0000jL-CH
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:22:09 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:37894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jfha4-0000Am-3y
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:22:08 -0400
Received: by mail-ed1-x541.google.com with SMTP id c35so6854838edf.5
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 03:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7TLfC61BZIEPg1gcb/c/Cd8nDCCT9O4paWqKPZU4zKg=;
 b=VeADWRQ6Evq6hopaNo1d/UqKNAmDQzSxbrNoShICXZ3cP7nv+1Ufr0LKV5Qk+2NwlJ
 D7kXf8IGSPVFhcQauPaPLuy74hyKKkTKunFIXEWMgRj8lUhyTkAUCAS6ptPD/NhR6qg0
 UzVxRkB5j2Qzx3vCC07zWpW/FvMRJ0lmZ1Oaa4NRVXcz3uGQasAMPPUsjnxQsU38ikrv
 Kbo9aZ118LotOv6E+6gduv8Qec/J/GR1MXifkPFTJU9LfDezRQd4JgilA8Lku5jk8Rvz
 WTDnXG4LV7sK5jQjFXy3AHRj7q9VQbUdsnH8SnqWCWxqZdDDAFja2u9SZjBe/IwzsrVS
 FlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7TLfC61BZIEPg1gcb/c/Cd8nDCCT9O4paWqKPZU4zKg=;
 b=SL8XG9L5eHGJ51O/R2SN2y4NWIYmApw3d6QzvXtd+qZFRvK2gA5OtfgdHduNpIsH3W
 Wl/r+4P+io86ezx7eK/ExXbIMBxaCSPjuKDjwmqBWqeFDzBzVmkqRZIf+deNNDl7H50X
 fCJRvieoh74HOHrwwxxQpKp/XCBnqU4UiPoGuZX/dtIB19jmS1R4NLZjd+BHi0SjfwIe
 g1E8eGhNVfXXZu3Vt/8KdBRA57irLy5W3vWCxBLxOCT51wqllTtLtobvwqC+2cCbWnV/
 eH1xaYRqfi/GVXsuCL44CPvwiPF1s4o54xvW4rWWBN7H5gPENHP4xujRuymiLAHFtgOm
 z4Qg==
X-Gm-Message-State: AOAM5321jTGdhKtMlimk8EbVaeTkobndqqHxqMdYlFoEsRtP+w+H74UI
 yQeGRKgFm/r042aLwxfcL/qQKjpx6XB4EujyYz8=
X-Google-Smtp-Source: ABdhPJwabUOMkTjsHZpww/gQLUknAJycgyH9+aAPEgOzQQe6BSuqeWyzpSmph7N7UPOaKK3wvAnC9aNFoAlsokMcCf8=
X-Received: by 2002:a05:6402:549:: with SMTP id
 i9mr14174617edx.159.1591006926688; 
 Mon, 01 Jun 2020 03:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <1586337380-25217-1-git-send-email-chenhc@lemote.com>
In-Reply-To: <1586337380-25217-1-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 1 Jun 2020 12:21:55 +0200
Message-ID: <CAL1e-=i0W1AQXKVijiZC6DRXZvXRDoix1UqvezrYwh_-wNARbA@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/mips: Support variable page size
To: Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=aleksandar.m.mail@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 8, 2020 at 4:41 PM Huacai Chen <chenhc@lemote.com> wrote:
>
> Traditionally, MIPS use 4KB page size, but Loongson prefer 16KB page
> size in system emulator. So, let's define TARGET_PAGE_BITS_VARY and
> TARGET_PAGE_BITS_MIN to support variable page size.
>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---

Applied to MIPS queue.

I hope this email will find you and all citizens of China in good
health and spirits!

Aleksandar

>  target/mips/cpu-param.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
> index 308660d..9c4a6ea 100644
> --- a/target/mips/cpu-param.h
> +++ b/target/mips/cpu-param.h
> @@ -23,7 +23,12 @@
>  #  define TARGET_VIRT_ADDR_SPACE_BITS 32
>  #endif
>  #endif
> +#ifdef CONFIG_USER_ONLY
>  #define TARGET_PAGE_BITS 12
> +#else
> +#define TARGET_PAGE_BITS_VARY
> +#define TARGET_PAGE_BITS_MIN 12
> +#endif
>  #define NB_MMU_MODES 4
>
>  #endif
> --
> 2.7.0
>
>

