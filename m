Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722D1C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B50206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/nv/bSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B50206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57489 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJehM-0006O5-83
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:46:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJedu-0003jo-TV
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJedt-0007bb-Pq
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:42:26 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hJedt-0007aQ-Hz
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:42:25 -0400
Received: by mail-wm1-x342.google.com with SMTP id z6so1724213wmi.0
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=JLNFcwzWENHlpSVEWN5VZCxHZmphsGdlN6DAt+MctcY=;
	b=S/nv/bSoTa5jtFE5DQJ3gftx5h0rfeZZK70xq1/ue5T5J9pUAmciS3TXSXiO3xiuAx
	qZQSMLCf1/AsHmsQwDpF2vVUm9Gebw3OFuJvZnq7ukGnyXxCFiCUGRPsjrbk6tj9V21H
	rRQsR2GJfs5EUVHGQGZg7EY+HeGme0d6XaCGONAv6r/kh2PZhjgaOwXk6oHfpickpIGq
	2gu4cxL83SrU8on6X6P/BJiiw9wS+BGbR7Xc7LwvxY9dnYOgSHvwxvBohxs3HnFhCqco
	XJ8WhY4MHGCVrcuVVC/JHJuusN4vjIKX9MKMRNIqC8bOCWM35RxFqy4BUAnhl+hMexHg
	fAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=JLNFcwzWENHlpSVEWN5VZCxHZmphsGdlN6DAt+MctcY=;
	b=iQ3NczWIlkIi+6wEx3LntgPkBSynDhTcpDDEWVC/X6VkWibiS+zzq3WPdlIgpT9pXc
	yGq0/48PtEjW94t/ApaMkKJJXHO8hKeE3s04z2heM4T1ADWrJJwBaU5YMWTWmj3EAIDK
	PM85WRfqXr99NhBcO7AzM9H6wBbK5o+NJ3WjFoFOgCDQ7AJ7Tbq38XUJymWYQsDbPgii
	kDvMF2wjARy/Uc4A1PrslXi6VQmzQhxudW4Vb9cjdEcFIYs5mop62syXQIsYCNfsGs60
	g1nPm0npSz1EcX4oTt6/1WJKuLqZrjoZ7xEe80Xm1Gn5xXeCwX8R81fg4sCtSY5NdBlS
	qpJg==
X-Gm-Message-State: APjAAAVgmzfH7VJu36Sden5t0BPEEOtTJ5Q51iNH/0yWEttS4/KFka/P
	4I9z1y1nbSbdMXfbOdPT0E+y2g==
X-Google-Smtp-Source: APXvYqxHZSX7rBn9gu3iQ9mRp+JRU8s3BghPhJCxZFqZPHw6INqXQd40AWqo8q4tic+Tgh9E7RvMdw==
X-Received: by 2002:a1c:3507:: with SMTP id c7mr3448677wma.20.1556199744091;
	Thu, 25 Apr 2019 06:42:24 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	r10sm5018164wrr.65.2019.04.25.06.42.23
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:42:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id C024C1FF87;
	Thu, 25 Apr 2019 14:42:22 +0100 (BST)
References: <20190408182748.1238-1-jan.bobek@gmail.com>
	<20190408182748.1238-4-jan.bobek@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Bobek <jan.bobek@gmail.com>
In-reply-to: <20190408182748.1238-4-jan.bobek@gmail.com>
Date: Thu, 25 Apr 2019 14:42:22 +0100
Message-ID: <871s1qw69t.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [RISU PATCH 3/5] risu_reginfo_i386: implement
 arch-specific reginfo interface
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425134222.phS02DG5YJcgHCr9UQ6fpWNHsBtFFtub-cxcrjm5Jew@z>


Jan Bobek <jan.bobek@gmail.com> writes:

> CPU-specific code in risu_reginfo_* is expected to define and export
> the following symbols:
>
> - arch_long_opts, arch_extra_help, process_arch_opt
> - reginfo_size
> - reginfo_init
> - reginfo_is_eq
> - reginfo_dump, reginfo_dump_mismatch
>
> Make risu_reginfo_i386.c implement this interface.
>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  risu_reginfo_i386.c | 48 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 42 insertions(+), 6 deletions(-)
>
> diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
> index e8d671f..3882261 100644
> --- a/risu_reginfo_i386.c
> +++ b/risu_reginfo_i386.c
> @@ -10,12 +10,28 @@
>   ***********************************************************************=
*******/
>
>  #include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
>  #include <ucontext.h>
>
>  #include "risu.h"
>  #include "risu_reginfo_i386.h"
>
> -static void fill_reginfo(struct reginfo *ri, ucontext_t * uc)
> +const struct option * const arch_long_opts;
> +const char * const arch_extra_help;
> +
> +void process_arch_opt(int opt, const char *arg)
> +{
> +    abort();
> +}
> +
> +const int reginfo_size(void)
> +{
> +    return sizeof(struct reginfo);
> +}
> +
> +/* reginfo_init: initialize with a ucontext */
> +void reginfo_init(struct reginfo *ri, ucontext_t *uc)
>  {
>      int i;
>      for (i =3D 0; i < NGREG; i++) {
> @@ -51,18 +67,38 @@ static void fill_reginfo(struct reginfo *ri, ucontext=
_t * uc)
>      ri->faulting_insn =3D *((uint32_t *) uc->uc_mcontext.gregs[REG_EIP]);
>  }
>
> -static char *regname[] =3D {
> +/* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal =
*/
> +int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
> +{
> +    return 0 =3D=3D memcmp(m, a, sizeof(*m));
> +}
> +
> +static const char *const regname[NGREG] =3D {
>      "GS", "FS", "ES", "DS", "EDI", "ESI", "EBP", "ESP",
>      "EBX", "EDX", "ECX", "EAX", "TRAPNO", "ERR", "EIP",
> -    "CS", "EFL", "UESP", "SS", 0
> +    "CS", "EFL", "UESP", "SS"
>  };
>
> -static void dump_reginfo(struct reginfo *ri)
> +/* reginfo_dump: print state to a stream, returns nonzero on success */
> +int reginfo_dump(struct reginfo *ri, FILE *f)
>  {
>      int i;
> -    fprintf(stderr, "  faulting insn %x\n", ri->faulting_insn);
> +    fprintf(f, "  faulting insn %x\n", ri->faulting_insn);
>      for (i =3D 0; i < NGREG; i++) {
> -        fprintf(stderr, "  %s: %x\n", regname[i] ? regname[i] : "???",
> +        fprintf(f, "  %s: %x\n", regname[i] ? regname[i] : "???",
>                  ri->gregs[i]);
>      }
> +    return !ferror(f);
> +}
> +
> +int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
> +{
> +    int i;
> +    for (i =3D 0; i < NGREG; i++) {
> +        if (m->gregs[i] !=3D a->gregs[i]) {
> +            fprintf(f, "Mismatch: Register %s\n", regname[i] ? regname[i=
] : "???");
> +            fprintf(f, "m: [%x] !=3D a: [%x]\n", m->gregs[i], a->gregs[i=
]);
> +        }
> +    }
> +    return !ferror(f);
>  }


--
Alex Benn=C3=A9e

