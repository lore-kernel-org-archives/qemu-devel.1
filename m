Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD836C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:15:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C3E62467F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rhg9mDfa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3E62467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7FGw-000307-R5
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 04:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7FGE-00028s-78
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:15:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7FGC-0000m7-T9
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:15:13 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43372)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7FGC-0000kh-NF
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:15:12 -0500
Received: by mail-oi1-x244.google.com with SMTP id p125so2562998oif.10
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 01:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PBPO653nrRDilb+V5bdvLTuegWyUOH6huXVkJlyy0oE=;
 b=rhg9mDfaZlaDbmOKiL/nDRqQcc2o0b6kLHL+Iq90cKndLIv31GSw8lB28eAMhnnWrO
 UX+WeUa8phMHuPdTN4JkrdhF9na8qKLbOVrHd5gBdLrTYvAjUjm7PM5A4SjNvqHe2jnT
 8I2dGVYfuoeTFSs5bOQtFAbeaM26/yT0Q1gFruxxsiaXpFPN0a9fMkPt6kwGPKR9DX6H
 +fmyWrSHSA4LAOQ34fvuZ7dcX92QP+zzNbIKZKS/HEoCKiqa7BZBLx7gWrt4PP85LKck
 zCHG3YRTPy3+i3orp3Xkgk8O4A/SQ0I6ds1xeqdnPLUrm5o8RY4o5eFJfS8w1k/0zkGG
 r81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PBPO653nrRDilb+V5bdvLTuegWyUOH6huXVkJlyy0oE=;
 b=KmhBgLmWwNFx/OPmw0vXV97HkIIyF4wFvBFeJhdMQ4t4G8UPeIraDfxe1Xql6yZ/Tj
 YBotC8tWNsX3WKS53dhX5WT9WzSOVZkgYRouQPQmKlX6uR/KqLBIHx5OhimFkviHqhQj
 PEZ6ilFcjF5P+mfeQjxsN0WY0imPvhv46WVmb8MT4QosfCa80FJlDvCetLdzILsj0fFM
 Xg+qxMkqotTU2Osm4380MHqbonYmbthhdE0/DwapwGl67oR+KyvE2CBu09Fp9II2U+XN
 l0r/0DevcmoDTFj3v4rOyQdRyJ0fyEmIW2ITWzpx+rGh5Daae2BqLLNaXexS8gbl+nng
 AoRg==
X-Gm-Message-State: APjAAAWWEoF2DQ/m9BkZMp+/jeWI5Jftwwea+Zswm1WyK0AGUIyXLkq9
 0xkjbnZa6nHv0v3NtLoiLtgjp/mbVv13L6O3Evs+Jg==
X-Google-Smtp-Source: APXvYqyWz33fA8Z/ut99RdiAiASabli+ezQATS8z5LVvoKfaXEJU8f8eirowE3llGgbv1W8FwTBRiJuKTiOSV2PtrWg=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr2614609oiy.170.1582794911701; 
 Thu, 27 Feb 2020 01:15:11 -0800 (PST)
MIME-Version: 1.0
References: <20200226163539.31960-1-imammedo@redhat.com>
In-Reply-To: <20200226163539.31960-1-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2020 09:15:00 +0000
Message-ID: <CAFEAcA9BTrC_OOTRboydOFn6GFsyKzqUNEExw5VRXmRsYvoXYA@mail.gmail.com>
Subject: Re: [PATCH] softmmu/vl.c: fix too slow TCG regression
To: Igor Mammedov <imammedo@redhat.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 at 16:35, Igor Mammedov <imammedo@redhat.com> wrote:
>
> Commit a1b18df9a4 moved -m option parsing after configure_accelerators()
> that broke TCG accelerator initialization which accesses global ram_size
> from size_code_gen_buffer() which is equal to 0 at that moment.
>
> Partially revert a1b18df9a4, by returning set_memory_options() to its
> original location and only keep 32-bit host VA check and 'memory-backend'
> size check introduced by fe64d06afc at current place.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>
> PS:
> This should take care of regression and give more time to think about
> how to remove size_code_gen_buffer() dependency on ram_size

> +    if (current_machine->ram_memdev_id) {
> +        Object *backend;
> +        ram_addr_t backend_size;
> +
> +        backend = object_resolve_path_type(current_machine->ram_memdev_id,
> +                                           TYPE_MEMORY_BACKEND, NULL);
> +        backend_size = object_property_get_uint(backend, "size",  &error_abort);
> +        if (backend_size != ram_size) {
> +                error_report("Size specified by -m option must match size of "
> +                             "explicitly specified 'memory-backend' property");
> +                exit(EXIT_FAILURE);
> +        }
> +        ram_size = backend_size;

Why do we do this assignment? We've just checked that
backend_size == ram_size so the assignment won't do
anything, will it?

In the version of this check in set_memory_options()
the assignment was useful because the error check
only happened if mem_str is not NULL, ie there was
an explicitly specified 'size' option somewhere. It
looks like now we require the backend size to match
even if the size is not explicitly specified by the
user but comes from some default somewhere?

thanks
-- PMM

