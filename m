Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9168C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3B112075B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S8XVEa2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B112075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv5Ha-0005Oq-Te
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 16:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jv5H0-0004tu-Pp
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:42:02 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43372)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jv5Gy-0004sT-NY
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:42:02 -0400
Received: by mail-ot1-x343.google.com with SMTP id 95so10638089otw.10
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 13:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mRK/nPxJ28h5nbdqUH91n56We29NY74C6cTjczMQCAo=;
 b=S8XVEa2ELBIekOmEhqYXYqpksdsqYkOIU5qyhQq7uNLJixDF40p9gQ9OYM7EqIUFC7
 GsWQlUgRKzhU9sR8P51TnRKD6aU3Hdt9Br3XnEV7D0K0HKliJLeuyIwaaZWDqiAqwEoy
 iOo6b2sin8K+d1NPKRSnUJbLUEHjQeBT5nVocTLx23Sxuxc3zFLgK/xJpx890ahqi7Lw
 0PW7NU3llCqE9ajYOTA1q8PQ7y1hSCpoveqzvA2TZFlm0lOwDdOYZ21j3EvVuDfmLywo
 Rzsz3WKPdqedTOrPTUsgpb5YkGU4Sh0BuoO2kfj/z4X12WV3Z10s6hkGKHtVp0qw14n+
 HxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mRK/nPxJ28h5nbdqUH91n56We29NY74C6cTjczMQCAo=;
 b=jgkGRm8DaR/R45zTUlXNi6KP1AjxNibR6Vts7mgvhI5K8fvg0T2bq7g0Uixfwtqlg/
 p3l0CvJ8+WuTZe2qyXi6nt+yt0WaSnAOSwbLWsfSO3nHSp8tX4NE27Bycc/IGsVfxrkL
 RA7RMh8O+Hnei4A0O+EFtY7VVyaBSc60XfdNe+VoMM2ey7Lu/i4tr4bMFlV/n4Nor23c
 D7yr7CL2FUDbL33IkzdKyxuvOj+DJPy+IkP2fACbVOCjEkf17xKnIYMSELqSZLtY3Ia9
 RgVzM5rk+m//SXnfhUfKXKXecuQXZe1fo/Vw3AZPvJldR/Hc2T3hjsQAL/90yfArjzqG
 LAzg==
X-Gm-Message-State: AOAM5319s0Ki+KqJVOiLt/2XjpgBqwI8Xyceqi6NIdO85p8TTiku+ZHh
 Rq1feTxc1DFcU6ccnne7O+0Jso175V/NEAWdyA4g5w==
X-Google-Smtp-Source: ABdhPJzi7j9aJcqTSLOmItH+lnc9yPkvSAWPM2ExsxzAgxlR7oiSeMVSd0Oxi9KmrSa2lhsW4v0MgURc/yb0himjMY0=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr1194299otk.221.1594672919273; 
 Mon, 13 Jul 2020 13:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200713183209.26308-1-f4bug@amsat.org>
 <20200713183209.26308-8-f4bug@amsat.org>
In-Reply-To: <20200713183209.26308-8-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2020 21:41:48 +0100
Message-ID: <CAFEAcA-kJQSZ-pudOrgutf24BG3UxA6F2ErocArs=f4sfndvTQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] hw/sd/sdcard: Do not allow invalid SD card sizes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Qemu-block <qemu-block@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jul 2020 at 19:32, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> QEMU allows to create SD card with unrealistic sizes. This could
> work, but some guests (at least Linux) consider sizes that are not
> a power of 2 as a firmware bug and fix the card size to the next
> power of 2.
>

> +            error_setg(errp, "Invalid SD card size: %s", blk_size_str);
> +            g_free(blk_size_str);
> +
> +            blk_size_str =3D size_to_str(blk_size_aligned);
> +            error_append_hint(errp,
> +                              "SD card size has to be a power of 2, e.g.=
 %s.\n"
> +                              "You can resize disk images with "
> +                              "'qemu-img resize <imagefile> <new-size>'\=
n"
> +                              "(note that this will lose data if you mak=
e the "
> +                              "image smaller than it currently is).\n",
> +                              blk_size_str);
> +            g_free(blk_size_str);

Some places that create multi-line hints with error_append_hint()
do it by calling it once per line, eg in target/arm/cpu64.c:
                error_setg(errp, "cannot disable sve128");
                error_append_hint(errp, "Disabling sve128 results in all "
                                  "vector lengths being disabled.\n");
                error_append_hint(errp, "With SVE enabled, at least one "
                                  "vector length must be enabled.\n");

Some places don't, eg in block/vhdx-log.c:
            error_append_hint(errp,  "To replay the log, run:\n"
                              "qemu-img check -r all '%s'\n",
                              bs->filename);

Most places terminate with a '\n', but some places don't, eg
crypto/block-luks.c:
       error_append_hint(errp, "Failed to write to keyslot %i", keyslot);
       return -1;

The documentation says
 * May be called multiple times.  The resulting hint should end with a
 * newline.

which isn't very clear -- you can call it multiple times, but
must you, if it's multiline?

I assume that "should end with a newline" means "must end
with a newline", and places like block-luks.c are bugs.

Markus, do you know what the intended API here is?

It looks like the implementation just tacks the hint
string onto the end of any existing hint string, in
which case multiple-line strings are fine and the same
behaviour as calling the function multiple times.
(I had assumed we might be accumulating an array of strings,
or requiring multiline strings to be multiple calls so we
could have the argument not need to be \n-terminated,
to match error_setg(), but both those assumptions
are obviously wrong.)

Anyway, I guess this multiline-message usage is something
we do already and it will DTRT, so

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>


thanks
-- PMM

