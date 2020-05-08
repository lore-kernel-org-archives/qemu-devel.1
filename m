Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE16C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52D5207DD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52D5207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX81F-0007ku-1Y
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 14:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jX80B-0006u0-Bq
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:45:39 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:39823)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jX809-0006zO-5u
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:45:38 -0400
Received: by mail-ej1-f65.google.com with SMTP id s3so2071663eji.6
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 11:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jjVZNMt+IPfHL79Ot+yNU48KtZN6p0+0N9d00BSFtYo=;
 b=jRAuMMxDxIvrQarTSNf/Dm9pnBCLa/n2GUw21WL7yCjCDv8OU9lqwRR6TXKeJO/f7a
 LIE2tQEgBN4aUhGwzOY5jiXxfoo93XS6SYX97KSXGbag/Ugb2M6YMQOzn8mRSdM2jVRj
 WDDCzXIs49IXr2rtkyee/GAzF14lUXuDaVltamjckPs3DixoWXLcZ3Fk7OwwD1TiDYCE
 yHcNk1ec2rUAgaU1GUkwvXuskz9dvexLbpl49bgipDUGYfZ2hQPLSONLGQB6YNLnslW3
 tb6bTDTJYbhqnSOvB7R4moYmJrHgbpqck6gBpeWLrckafhr2Xn6jm/5gZhaElthoi1at
 rSrA==
X-Gm-Message-State: AGi0PuYYVSX5Qw6Y6SGQXgu2PkWAIFkT/KvtEJ+qCYW//ptszgfmjIsH
 4Sbv+HR4KZFZsb4NbewnkfmkGsgpnMHy22cJwCU=
X-Google-Smtp-Source: APiQypLkAqr9LYgyXA1M4L3hDqb5An68/hrt0ZK4VVbrTCghQPNHYdhC7RQbHP3zvfg1bBLuYKRO5L4B1EtiZlYSFXM=
X-Received: by 2002:a17:906:7c42:: with SMTP id
 g2mr3158095ejp.328.1588963535680; 
 Fri, 08 May 2020 11:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200504192344.13404-1-richard.henderson@linaro.org>
 <20200504192344.13404-4-richard.henderson@linaro.org>
 <aaa3d497-3c54-9acf-7ef1-fc47bd9d699d@amsat.org>
 <0b943dee-7275-90ea-2b66-ed5b5246d4be@linaro.org>
In-Reply-To: <0b943dee-7275-90ea-2b66-ed5b5246d4be@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 8 May 2020 20:45:24 +0200
Message-ID: <CAAdtpL7O-g9iQ3uXbdjQsr6c9p+g+qgqfnf1uAsmL0Mc68VpsA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] target/arm: Use clear_vec_high more effectively
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.218.65;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 14:45:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 5, 2020 at 4:22 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/4/20 11:09 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> >> @@ -7111,7 +7121,7 @@ static void disas_simd_zip_trn
> >>       }
> >>         tcg_resl =3D tcg_const_i64(0);
> >> -    tcg_resh =3D tcg_const_i64(0);
> >> +    tcg_resh =3D is_q ? tcg_const_i64(0) : NULL;
> >>       tcg_res =3D tcg_temp_new_i64();
> >>         for (i =3D 0; i < elements; i++) {
> >> @@ -7162,9 +7172,12 @@ static void disas_simd_zip_trn(DisasContext *s,
> >> uint32_t insn)
> >
> > More context:
> >
> >            ...
> >            ofs =3D i * esize;
> >            if (ofs < 64) {
> >                tcg_gen_shli_i64(tcg_res, tcg_res, ofs);
> >                tcg_gen_or_i64(tcg_resl, tcg_resl, tcg_res);
> >            } else {
> >                tcg_gen_shli_i64(tcg_res, tcg_res, ofs - 64);
> >                tcg_gen_or_i64(tcg_resh, tcg_resh, tcg_res);
> >
> >                          here ^^^^^^^^ tcg_resh is NULL too.
> >
> >            }
> >        }
>
> When is_q is false, the vector length is 64.  Thus that line is not reach=
able.

OK.

>
>
> r~

