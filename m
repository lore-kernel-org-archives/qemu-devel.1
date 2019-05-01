Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5190EC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8582085A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+DrFnCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8582085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60862 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLqyI-0007hK-6z
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 11:16:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hLqxM-0007LB-C0
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hLqxJ-0002l2-Bu
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:15:36 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:33477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hLqxJ-0002ka-34
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:15:33 -0400
Received: by mail-yw1-xc43.google.com with SMTP id q11so8538626ywb.0
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 08:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=rCaE6dcBsO6SStgd2Mr3OlFq2adfjCNoF1xyYYN61AQ=;
	b=J+DrFnCZ4S55eUgF4qzb9G2je0JjRX2qLE6WL61rt4QL/IgYppfkxHGBlP0D4+OqwZ
	ndCKQ7vLVrlvG6HUfRBFYOqyebbkdqEcGtS8OXm7W4BK1GdJNaOWAa8GE4sW5k6JHqHZ
	P/LtK/sv/xMgn0aNipCZjMPk+HDZw5tdyr3uDL/qBs5ZK+brfwMQH4VLcyCuVi9uRxdN
	jlcLeVrXNiXxhO5IPBsX3VhPEbXajq0GyMB4/v+g/knTxaynLroEcCH9MED+QPcQGH/X
	BindpWApnpWTJUcHdCF3tQ9MVnEix3knH1MHg8jvw8A/BXXCECycRDwVbBHvrpK7889k
	Tvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=rCaE6dcBsO6SStgd2Mr3OlFq2adfjCNoF1xyYYN61AQ=;
	b=jAcjUshEEO1SyV7hfsQNg9DiToKlXl6DFDXe3qaPDJ2MZgtNYdI3WxRZi9pFacamSg
	v8AkxI6ByWEQ0wdKbkxt3GGHRRq6oa70yd9ZnliW7FUEcl4+AS4+YpvFDm56cgNT/0fI
	IDbq+Yt1FJWKsaLDqn7Gi7qiPo92QPs21Zpk0st3khFJ8yU49PAw3tgoatP5ftxq5E+x
	ZJN1uyldiLMKqJaJeneLwg5X2f/SK2TLoAo1OmkQiFC68mpEH5jpBJXWwson/H6Yb5Eo
	W9toq7oVSdwwnFITPbqZHvLiljkGVp5IrJ35AxeJWueqrUhhh5vx3t0LqhMe8MNwMMOR
	hV1Q==
X-Gm-Message-State: APjAAAUVgeKpYy7QmAK23Ngrv4Er5TcPQcPIsntiH5ybffOL6f4vXLdw
	4DkZnxQGY4/TQXqKgKVFpqrLcPk9zrYxPkbp4Uo=
X-Google-Smtp-Source: APXvYqxyPttj/5K5xAi70q+gQ79dG2W/1x7h64euFtwch4C3uxpxQQUIwCk5YdI87PhNaEzdm7TmhrpoTmWDysqMWN0=
X-Received: by 2002:a0d:f003:: with SMTP id z3mr42626636ywe.422.1556723732233; 
	Wed, 01 May 2019 08:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-30-richard.henderson@linaro.org>
In-Reply-To: <20190501050536.15580-30-richard.henderson@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 1 May 2019 08:15:20 -0700
Message-ID:
 <CAMo8BfKfSbukiqs9PNQu5ZmzG3-gGr-BAavBEcyHFazFi3DonA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: Re: [Qemu-devel] [PATCH v2 29/29] target/xtensa: Use tcg_gen_abs_i32
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501151520.RfERL-ACs3mIP3GPdkvM-HN8xb4Cn5hIHeUnn5_gCvQ@z>

On Tue, Apr 30, 2019 at 10:06 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/xtensa/translate.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max

