Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955E8C433EB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:34:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F472073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wt/nyHHE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F472073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxrTt-0002uu-LW
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 08:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxrT9-0001du-Ki
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:34:03 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxrT7-0003dk-SH
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:34:03 -0400
Received: by mail-oi1-x243.google.com with SMTP id k6so17004802oij.11
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 05:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7pzAIy2Cuz2ZgaZSDdy7tuJpWl/ZYvY4wXnjuidX6Qk=;
 b=Wt/nyHHEhoeKdunAbPURFguirdvcTfYx/u+yth6PUpaYqRBIo6+k1gegUZnZw1A6kh
 3DNdjahzVsqphprz+CXgXHju04ztBEadCqwjbzz8OzmqZVort8YQwAvvdQJZzDHWf4/W
 Vszbot4PAoAh2oE6PLwUnplHxnIX//0rcAXwGB9CEtfKwXVxaApmGAk2gWAZHKX7QYkx
 5e9sMT315Gu3XlFPgxgv3nEMatd9WFpTJjiJxGAWEJSMi9quqU9saqzT9Izk5FpAWb+m
 XVzSeCnrB4ELnPm3L2t2ReDhxJYB3pfzrgttbnw2afBmkt7E72qbzl+zp8JA+6uSsrzV
 TSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7pzAIy2Cuz2ZgaZSDdy7tuJpWl/ZYvY4wXnjuidX6Qk=;
 b=t0km5Cb309ayyADX+c1dGQEdw5/3C2OBJkyv9qcGlj7Gj7YIgwpsCL4wJFi2TuUTPE
 gVNXb/UzjqqM0TpO9O2KmHOs2bR4I6Xm6nM3vcDOiJOrRENl3Pjex2uAyfVvxgA4qe1o
 lqkCIGUGz2sZveTwwtlRQCWnCbMSfUQYOuYaYdaF74PDua4zir2L3Rai5OcvA1dlGsM9
 /7jpS7ZOPh1Fkcqy6uvz5r0VrXPGb/8Z06juVK5rcMR+dI9qrCw2neagbDyOJtr55Aom
 etuIpgT5ADYDiSASzh29kUof8JSnizMY0R3JOlMp6NunwoDd6IoICwdRcQx/TttKqDF7
 0dHQ==
X-Gm-Message-State: AOAM533fP1VJgW4AxwHQEWUA2ZXh7K9DOlahXK5ql5N5uw3Xw5Y9MB2H
 qhfrDY2gpqX9rNoEbbDSlm8jral1zE333ZOY7X1O3w==
X-Google-Smtp-Source: ABdhPJwjR8fA7wCPGNAvlt4KCdWtlsQQ/SCSeGoRU33JYlZmoOnaDDZ/GQwXczP85IlzGRovaHRIq9msW6ejureKmw4=
X-Received: by 2002:aca:1706:: with SMTP id j6mr2677635oii.146.1595334840636; 
 Tue, 21 Jul 2020 05:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200721123154.5302-1-f4bug@amsat.org>
 <20200721123154.5302-2-f4bug@amsat.org>
In-Reply-To: <20200721123154.5302-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2020 13:33:49 +0100
Message-ID: <CAFEAcA_C1C-5oSrEZgJoufCc_91TdC3vv5+SUSBHHnWDGVyOCg@mail.gmail.com>
Subject: Re: [RFC PATCH-for-5.1? v3 1/2] memory: Allow monkey-patching
 MemoryRegion access sizes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jul 2020 at 13:31, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> To fixes CVE-2020-13754, commit 5d971f9e67 refuses mismatching
> sizes in memory_region_access_valid(). This gives troubles when
> a device is on an ISA bus, because the CPU is free to use
> 8/16-bit accesses on the bus (or up to 32-bit on EISA bus),
> regardless what range is valid for the device.
>
> To allow surgical change for the 5.1 release, allow monkey
> patching of the MemoryRegionOps (by making the MemoryRegion
> field not const). This should be reverted after the release
> and fixed in a more elegant manner.
>
> Fixes: 5d971f9e67 ('memory: Revert "accept mismatching sizes in memory_re=
gion_access_valid"')
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/exec/memory.h |  7 ++++++-
>  softmmu/memory.c      | 12 ++++++++----
>  2 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index 9200b20130..84b5c617e2 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -1218,7 +1218,7 @@ static void memory_region_initfn(Object *obj)
>      MemoryRegion *mr =3D MEMORY_REGION(obj);
>      ObjectProperty *op;
>
> -    mr->ops =3D &unassigned_mem_ops;
> +    mr->ops =3D g_memdup(&unassigned_mem_ops, sizeof(MemoryRegionOps));
>      mr->enabled =3D true;
>      mr->romd_mode =3D true;
>      mr->global_locking =3D true;

Don't you now need to g_memfree() mr->ops somewhere? Otherwise
you've leaked it if the device which owned this MemoryRegion
is hot-unplugged, I think.

thanks
-- PMM

