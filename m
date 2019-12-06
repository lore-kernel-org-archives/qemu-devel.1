Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E640C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:34:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4963821835
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cqur4xSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4963821835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idIRN-0000j8-CZ
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:34:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idIOY-0007kX-Pc
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:32:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idIOX-0006WV-GK
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:32:02 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44441)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idIOX-0006SF-5P
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:32:01 -0500
Received: by mail-ot1-x344.google.com with SMTP id x3so6582746oto.11
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 10:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lu07bfsNXvJyLxtguuPL5HrU16xG/Udq7hoIgPta040=;
 b=Cqur4xSjBaqT4z+15gVgEQaqK0q79JFP7+t69rbf8gp/10G1eJUfd+4n5/MBwMfeZS
 A2tYGKPON+VeMNwgEVaB7G13PZF2kavckaJe4gh/5reOHQ70OWNEU+zlgbc9PRjJvH/x
 EF+7czCN7StzbUSBq+vA1GxHOZGi4mYemPVHFQbiCtTPxQf3ih1naeOeuvaRIrX9F7rn
 9DD7/BfNyz6GgIGYzz1mNzOSLixtXBK5vKAlBqDeRQiNU4PFNUkbHCObNVWGfSnTj3Mq
 iWRqAGwjRrJtMNrruNrQ5+lGO3KV5HCGg6wl1pHvdfIXN5EnH9cgiBL2hofhc+2JhFlu
 R+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lu07bfsNXvJyLxtguuPL5HrU16xG/Udq7hoIgPta040=;
 b=BtEsXS7FZ6e9+W4ulhrM/ACLAG2znbmzQmjrz8HwmxV6YHsNfDlq+8tZO+rpiUwRXx
 RgrXWjwR/QoTD32YvmS9ftT9HVOYZ83RiQyhZSvj0ytsgn7Ft9okK54yvMZ7LNUQ67lm
 dlned0YSUt3GGB/6c1moFYJ5hRJyKKy0hEdNRjrlUqrDDTbMkh00tvFfwwifc1kR86ro
 5KEGfIuQfqLrHflXDXDfwTQ0twhVEmAqbaPxBG2ZP6r5PjK6/kEvX51acon9mldOvdHX
 5+b6iNL3UBIuH29a3TIqEn62YORyAFBozpWXw39d3q7kiNUKhEQ3nRWkXDACRHCRl9mm
 +8hA==
X-Gm-Message-State: APjAAAWGc8cQZyDaWGcG/YttVPqaaODz9vFovollBq8kjPOPpQAV9IVR
 yVLZ8zza7TpOnXtsdumtFqAoNQM7cux+DrvGF4vsQw==
X-Google-Smtp-Source: APXvYqxBNgsG1SRZZ6c0NdwJuTgvB7H7b26gaxmESnegfC+aJ4cogEmlieDedraUbNuuEykX2reiw9pY99QlbGgHjS8=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr12646155otg.232.1575657120214; 
 Fri, 06 Dec 2019 10:32:00 -0800 (PST)
MIME-Version: 1.0
References: <20191203234244.9124-1-richard.henderson@linaro.org>
 <20191203234244.9124-5-richard.henderson@linaro.org>
In-Reply-To: <20191203234244.9124-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 18:31:49 +0000
Message-ID: <CAFEAcA_iYsgguYyngs_o2WvvRy34Ny8YD_iihpevuVtmPSPijw@mail.gmail.com>
Subject: Re: [PATCH 4/4] target/arm: Enable ARMv8.2-UAO in -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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

On Tue, 3 Dec 2019 at 23:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu64.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 9399253b4c..03377084e3 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -674,6 +674,10 @@ static void aarch64_max_initfn(Object *obj)
>          t = FIELD_DP64(t, ID_AA64MMFR1, PAN, 2); /* ATS1E1 */
>          cpu->isar.id_aa64mmfr1 = t;
>
> +        t = cpu->isar.id_aa64mmfr2;
> +        t = FIELD_DP64(t, ID_AA64MMFR2, UAO, 1);
> +        cpu->isar.id_aa64mmfr2 = t;
> +
>          /* Replicate the same data to the 32-bit id registers.  */
>          u = cpu->isar.id_isar5;
>          u = FIELD_DP32(u, ID_ISAR5, AES, 2); /* AES + PMULL */
> --
> 2.17.1

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

