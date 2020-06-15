Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF33FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:15:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2FBC20739
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1YJc5Qz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FBC20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkuZh-0003XI-Th
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 15:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jkuYn-00029s-9m
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:14:21 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:43843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jkuYl-0002LU-Mo
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:14:21 -0400
Received: by mail-ej1-x644.google.com with SMTP id l12so18615886ejn.10
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 12:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9T1ZQ5GQfs/AcJrUBF3eCnp3mZyd8on0S4n1RgtchD0=;
 b=f1YJc5QzHXyIX7Wb0c8OUj7gX4infv+Tmk12naZin4G3t8vr+JrV9NfVwFFN8XdE9Y
 8AolABwNpCeLL/mHvoSPOddi19fYsiSo5SHKjMm8iN27E0230gJbfg8xE71E4hsPQmJV
 5wDLqxZU2y/EQpiAcKmOMoX+TruNFd9zdPw6iPusRu5FmijwA/4J04iVmd4D1fEkWqCG
 PAuCIweb8Bly0emiCufMhhEE1O87a/MixzKDs9qL85/e2ocNe3mRn60FaQCaHwCi0sBS
 qrkAZFTTqw7WCGu5KunpxpA3YqLoQzedzaArH1Fq+FG7J3ajHDw66BiRQKsKWx1UQl5M
 sxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9T1ZQ5GQfs/AcJrUBF3eCnp3mZyd8on0S4n1RgtchD0=;
 b=poFlCpQb69KZxBBH0H+ReWNF1/6oP5bXL7vHpTGBdGnnWU5xJwKw2hCOPVg8XefMoD
 b5NWUtDH0WQ87VRCxiCe4/WV7NExy1O6xDsCbSvP3+CLYKEug90cqve79WUdB8r3090s
 vqGdWEiHbfg3lXJE6w6GlY68nhPrH8IYyigfm7j+P1+xm76569Nb50muEqoZC+W6KtBy
 m3khzu1NJTpnl79jSSFpPcPLqOrKTzzf5/y6cTAj6P+iaoL2p4APA6sECQu5TfcWmBYw
 1gNm1dNV1eCyHdQoufUnhiEwvchbqdY5zV6STW0/E75uXr5oiSzr++XxEzyC8TZAHeyU
 vl/Q==
X-Gm-Message-State: AOAM530smRLkVH12U5SUmt15QZOh0A/6kBpSWi7hzT3pU+YtEf+/nVde
 RWLzCyxp+AqhAu5JyF/GrpX+W7F8vEHKHWnUGz4=
X-Google-Smtp-Source: ABdhPJzxT70RtRHlJjHbbhTcTXm6zcWDIMmob9MSOa9DyESOLWomzNhLLxYNRpV9rx/aX2vawtPLLXyoM1OsL4mEKEA=
X-Received: by 2002:a17:906:ae14:: with SMTP id
 le20mr26316986ejb.307.1592248458506; 
 Mon, 15 Jun 2020 12:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200613152133.8964-1-aleksandar.qemu.devel@gmail.com>
In-Reply-To: <20200613152133.8964-1-aleksandar.qemu.devel@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 15 Jun 2020 21:14:07 +0200
Message-ID: <CAL1e-=iz6t_Q41Me-d+4SJjWd7QeUyiEDa9TWcRunh8CQppsjA@mail.gmail.com>
Subject: Re: [PATCH v8 00/14] target/mips: MSA,
 FPU and other cleanups and improvements
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=aleksandar.m.mail@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@syrmia.com, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jun 13, 2020 at 5:22 PM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> This series contains some patches that split heprers in msa_helper.c.
> It will make easier for debugging tools to display involved source
> code, and also introduces some modest performance improvements gains
> for all involved MSA instructions.
>

Applied to MIPS+misc queue.

> v7->v8:
>
>   - added six new demacroing patches
>
> v6->v7:
>
>   - excluded patches that have been already upstreamed
>   - added six new demacroing patches
>
> v5->v6:
>
>   - excluded a patch that was included by mistake
>
> v4->v5:
>
>   - corrected some spelling and style mistakes in commit messages
>   - added changing MAINTAINERS too while renaming files
>   - added two patches on splitting helpers in msa_helper.c
>
> v3->v4:
>
>   - corrected some spelling and style mistakes in commit messages
>   - added a patch on renaming some files in hw/mips
>
> v2->v3:
>
>   - changed Malta patch to perform logging
>   - added change of Aleksandar Rikalo's email
>
> v1->v2:
>
>   - added more demacroing
>
> Aleksandar Markovic (14):
>   target/mips: msa: Split helpers for MADDV.<B|H|W|D>
>   target/mips: msa: Split helpers for MSUBV.<B|H|W|D>
>   target/mips: msa: Split helpers for DPADD_S.<H|W|D>
>   target/mips: msa: Split helpers for DPADD_U.<H|W|D>
>   target/mips: msa: Split helpers for DPSUB_S.<H|W|D>
>   target/mips: msa: Split helpers for DPSUB_U.<H|W|D>
>   target/mips: msa: Split helpers for DOTP_S.<H|W|D>
>   target/mips: msa: Split helpers for DOTP_U.<H|W|D>
>   target/mips: msa: Split helpers for SUBS_S.<B|H|W|D>
>   target/mips: msa: Split helpers for SUBS_U.<B|H|W|D>
>   target/mips: msa: Split helpers for SUBSUS_U.<B|H|W|D>
>   target/mips: msa: Split helpers for SUBSUU_S.<B|H|W|D>
>   target/mips: msa: Split helpers for SUBV.<B|H|W|D>
>   target/mips: msa: Split helpers for MULV.<B|H|W|D>
>
>  target/mips/helper.h     |   73 ++-
>  target/mips/msa_helper.c | 1296 ++++++++++++++++++++++++++++++--------
>  target/mips/translate.c  |  200 +++++-
>  3 files changed, 1271 insertions(+), 298 deletions(-)
>
> --
> 2.20.1
>
>

