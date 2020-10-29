Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40213C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 19:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B3F42075E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 19:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S118fViq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3F42075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYDNY-0001QX-99
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 15:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYDMy-00010y-LR
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 15:13:56 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:36488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYDMw-0002UJ-Ng
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 15:13:56 -0400
Received: by mail-ed1-x541.google.com with SMTP id l16so4226706eds.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 12:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8VMug5+DluaFQ2zG/zXgf69t5xA5pF6YEArqlbmZkbo=;
 b=S118fViqtWNIRmFcVe5ax5lVxu7RV/vEI76zklQruma1eVPZCcMvpuWzi9tj7pK7Di
 5CpOfaNX4NXzsR5xHiSgxCwnWkDaVlgUe7ol7vXwM4A5BApyXFSRrPVQb3OkKPwrhjDr
 4tb7gCQ6PN+cGLQIuuty2Jch9NSi86lK+jkq0eWtrwVbb9dC01e444UhqxKMIcS2CScf
 DFLmk3su4Rk6QOa9YvyRg4b+ycHcg44+cqqrcL+Kew1zDKBgJd5OHjeAcujSeaDaG5Lz
 +hFRGXWvjdjY5KGfsurohwxxLW5lLRQjSCrNBI4JX/oQk0zOYHpZzloNZQXSdy9jS6qW
 PWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8VMug5+DluaFQ2zG/zXgf69t5xA5pF6YEArqlbmZkbo=;
 b=kM8GXVSPyHvHo9BxzUK0xI02nAkv+aM3O2UHNzrIx8H5wO6LEHJ1oozKQrdSAwGtVg
 vfK8n7+H9vMdKQ6eHBky1mJex0dsMe3kyMRkC9Ce3beC7Vt/CJ3CCCBOtsbPtqTm9YR2
 EwHD8O4pUW0FrAA6sn5v5QzzrLoJ8IDdez2ZiCE4ImikzwqLTPsDunbJXwWyeF3VeWHS
 0kGr9o8bK6ebsq4QnfKY2VmvcIegOJj8r5eLlnSbXAVaCsrxghXRb5MzEQ/990xfRylo
 3KUUgixa0ThZEZnW8nPN28j+HVcDixcWsApkhr7rv5gc1rK5zrMh3c0m9SQEhQVjRPMz
 7UFQ==
X-Gm-Message-State: AOAM5309a1bq3u42NKJKp3RGE6J4jk+rMiYZSqAbvSn1FikrSOt5YB2A
 gd0s/uEId9OE+TeR+rkmR61uf5IwbM2t5FFB6uJ6iw==
X-Google-Smtp-Source: ABdhPJyKVINEIzoCGHW+1uZabe+pQhWIyzqh7cN8MDPQrKcRgoxMkUzSlCaU1iNMqcLTr7EoFCKXZKPWYfH+p5Z2LHo=
X-Received: by 2002:aa7:c683:: with SMTP id n3mr5527803edq.146.1603998832910; 
 Thu, 29 Oct 2020 12:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201029185506.1241912-1-f4bug@amsat.org>
In-Reply-To: <20201029185506.1241912-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2020 19:13:41 +0000
Message-ID: <CAFEAcA-spK9H6SWkx9FLZ2tjMZUS5qz7bJ9rFBwxLVW_fxLRGg@mail.gmail.com>
Subject: Re: [PATCH] util/cutils: Silent Coverity array overrun warning in
 freq_to_str()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <rth@twiddle.net>, Luc Michel <luc@lmichel.fr>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Oct 2020 at 18:57, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> The biggest input value freq_to_str() can accept is UINT64_MAX,
> which is ~18.446 EHz, less than 1000 EHz.
> Add an assertion to help Coverity.
>
> This silents CID 1435957:  Memory - illegal accesses (OVERRUN):
>
> >>> Overrunning array "suffixes" of 7 8-byte elements at element
>     index 7 (byte offset 63) using index "idx" (which evaluates to 7).
>
> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  util/cutils.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/util/cutils.c b/util/cutils.c
> index c395974fab4..69c0ad7f888 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -891,6 +891,7 @@ char *freq_to_str(uint64_t freq_hz)
>      double freq =3D freq_hz;
>      size_t idx =3D 0;
>
> +    assert(freq <=3D UINT64_MAX); /* Max 64-bit value is less than 1000 =
EHz */
>      while (freq >=3D 1000.0 && idx < ARRAY_SIZE(suffixes)) {
>          freq /=3D 1000.0;
>          idx++;

I don't think I really agree with this as the way to silence
Coverity. The reason Coverity complains is because in
one part of the function you have code that says "it's possible
for idx to be >=3D ARRAY_SIZE(suffixes)" (because you test
that in the while loop condition) but then in the following
part (where you dereference you have code that says "it's not
possible for idx to be >=3D ARRAY_SIZE(suffixes)" (because
you dereference suffixes[idx]).

We should either consistently assume that idx can never
get to 7 (ie don't check it in the while loop condition
because that test can never return true) or we should
consistently guard against it happening (by switching the
while loop to "<=3D", or by handling the idx=3D=3DARRAY_SIZE(suffixes)
case specially.)

I think I would go for:
 * remove the test from the while condition
 * after the while loop, assert(idx < ARRAY_SIZE(suffixes));

thanks
-- PMM

