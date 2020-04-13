Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DCDC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 16:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AFF12063A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 16:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDdDkorP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFF12063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO1h8-0007Xr-8F
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 12:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent.desnogues@gmail.com>) id 1jO1gV-00076s-Cx
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 12:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent.desnogues@gmail.com>) id 1jO1gU-0006jz-DT
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 12:11:43 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:39049)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
 id 1jO1gU-0006ji-9F; Mon, 13 Apr 2020 12:11:42 -0400
Received: by mail-io1-xd43.google.com with SMTP id m4so9852936ioq.6;
 Mon, 13 Apr 2020 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tB5FpqGbsnTDwpSTSzkgHmfFp1T8s709K8VP5MwHrVY=;
 b=eDdDkorPD5CCD3RUdCsjgsMiXWbnSk6SOPOhblGIiMPIXBEvx5NIcRKH4EFhqzQV6E
 2P+S3ueUTz5vo0mXtGKu6z7Xh6MpFyhagz7ihp5ksQLGcUB+H8W9uZSi3hvTg8dWnGMC
 l33L8omsmaQrPkZeW4gblq1wQVs5ICbsaYrt7RZK2rXXfMMoPeGTUqN121dIAowsGtB1
 JaCWqn/fxPaLZMwvJBCc9yaqpez0cSPVDILhKiu8CilTjH1aijBT25UAo22CZIZj2ntr
 rfJ2bPmAh/VUVI2eHiyHd/nTT5wvY2gYQhEuJVUPMhcLxutDiKy0XcrgFGrtU1PLoqDw
 e1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tB5FpqGbsnTDwpSTSzkgHmfFp1T8s709K8VP5MwHrVY=;
 b=AC5RAZUbXIcsRSiiolYPc8BxqeOGxg4SPfN+3JbbVap9GdGydi2BlnwGc0jktFXrJr
 WEG4od9ABsBtw7uWDmtpJs3jUCAym9jnZc0ndd9BmfYBohAnXpz+mJMt4KYxgipAOwKJ
 OPvYZ6fDsgZVFdWC8z9f1wBSZJ6uf5IrElw0Xkifipb5B1fz7kgKuzVTDt27wzQxeQGs
 umo8jrs13sEYiTJVZxsLGvHA+ZvQcyq9Bl4T24vK02dnewFciMTKV4SA1TVrzDr6tFqf
 o8gt1RQjLG8vQLj7SLTCrRuu3ZOJtC63lrPgjdkh0Zyxs2JaJwRCPrhd6AA8iMVWlmH0
 H8Gg==
X-Gm-Message-State: AGi0PuaSxZB+a37e1r+Q20ffG2b+gaw2un+vPeXnmsP6DOKRHkdZYos7
 4UbPJ7nW3fWnUINoRPHqSVs6AthHxO/XuK2wRBo=
X-Google-Smtp-Source: APiQypIXuc+nw7qcpViZwoYAO9NfY3Mki05KINQiWLi5CtQnm8uwiEqJR9DtjIsEw5aC4NCKYfdv2czbQN9CO9RfAJ4=
X-Received: by 2002:a6b:b54c:: with SMTP id e73mr16624794iof.136.1586794301482; 
 Mon, 13 Apr 2020 09:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200326230838.31112-1-richard.henderson@linaro.org>
 <20200326230838.31112-14-richard.henderson@linaro.org>
In-Reply-To: <20200326230838.31112-14-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Mon, 13 Apr 2020 18:11:37 +0200
Message-ID: <CABoDooMKzyhRwCxTdynh8H3kiDrM4Zp2UmFYQam_Zfgo+qwA4Q@mail.gmail.com>
Subject: Re: [PATCH 13/31] target/arm: Implement SVE2 integer add/subtract wide
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
Cc: rajav@quicinc.com, qemu-arm <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 27, 2020 at 12:17 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
[...]
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 7d7a59f620..44503626e4 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -1131,6 +1131,36 @@ DO_ZZZ_TB(sve2_uabdl_d, uint64_t, uint32_t, DO_ABD)
>
>  #undef DO_ZZZ_TB
>
> +#define DO_ZZZ_WTB(NAME, TYPE, TYPEN, OP) \
> +void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc) \
> +{                                                              \
> +    intptr_t i, opr_sz = simd_oprsz(desc);                     \
> +    int sel2 = (simd_data(desc) & 1) * sizeof(TYPE);           \
> +    for (i = 0; i < opr_sz; i += sizeof(TYPE)) {               \
> +        TYPE nn = *(TYPE *)(vn + i);                           \
> +        TYPE mm = (TYPEN)(*(TYPE *)(vm + i) >> sel2);          \
> +        *(TYPE *)(vd + i) = OP(nn, mm);                        \
> +    }                                                          \
> +}

For sel2 the multiplicand should be the number of bits of TYPEN.

Laurent

