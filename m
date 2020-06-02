Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04401C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 14:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4893205CB
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 14:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYOpGZVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4893205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg81X-0001PQ-0J
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 10:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jg80e-0000oN-IY
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 10:35:20 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:43655)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jg80c-0003Lb-Ah
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 10:35:20 -0400
Received: by mail-oo1-xc42.google.com with SMTP id n31so1417749ooi.10
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 07:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HOCqWhwBUH/Ltbf6MI+Sz82CxwE71rN1m3HfnCpSks0=;
 b=RYOpGZVQJSWyyod8IvOI8tNcZ2YQrgWuYPTyRRYZSXF77SvVUTzRA45pnjOcWPakza
 Ftwh1nakP6Pw+5KWBo0PDDcyuN+d/KGeM2Qf/MsColbicCsCSebOK/T65w/kadtHLke9
 kzzwu5z6KrYT0xmFd4QQwROAooMnZPU23/DeaN/eBtBqd/b3HNebAnEiXeQADQED+o+B
 HHtl45qhwccPb0FBqL5RPJUQrFSWBEUglqXS7S4V8D1mzdGwnE9r4XNbJhhOw7mU6PqE
 NgEvG/3VYWrYjflx13n8qHdZSILu7kCqE8sjEMQEX2UANoq1Rjzvfn4lru6yfM3VnuXL
 5CSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HOCqWhwBUH/Ltbf6MI+Sz82CxwE71rN1m3HfnCpSks0=;
 b=AynbHPP/zvn2TKA3OtvkrJM7p9lRHR3rcM3N2KW5KX7bUFKn0Lv4exXGLuWMHgYBXX
 a8DBoSQrp91RDjKdSP3FIcCHGWPOGfTP+i47oqWbTDe57PxnwN+DEHIjqHchxRKCNk6r
 m1941iekejSXX6O+UokR+CJ2upjdV4iw7rTK9+GSLu0seVt+DnbswahRIQvnREKpiPpz
 J+MxtKauLVQv9ldHWzO9K8dVhq00vkJHMlPuzlLV+DI5zfqx+OYxZlaiy7h3iYAR70k0
 BaSJdNdGVp/PAUs1XWa19153yYI4r0spdlUmtR0gXaLS5CTyRVnVNaawks+x8rAd1lVK
 pICg==
X-Gm-Message-State: AOAM530qXPklMMB/Gr5UbJMslBf/g949lol0dxr0sE5M1obao3QJ0KuO
 4BXUYwUvKuFF0A+acrfmPHoKz8tJDZm3ok45Vb5A4hDmKv4=
X-Google-Smtp-Source: ABdhPJw+CEPc6cax6HszMvcRj6QxxgvU70f4UJxrMS31GDeiv432GSTDW4d/NdLNmudA6g0aMxQeOwvCI0s0PIQ5cH0=
X-Received: by 2002:a4a:381:: with SMTP id 123mr19016068ooi.85.1591108516877; 
 Tue, 02 Jun 2020 07:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200518164052.18689-1-richard.henderson@linaro.org>
 <20200518164052.18689-6-richard.henderson@linaro.org>
In-Reply-To: <20200518164052.18689-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jun 2020 15:35:05 +0100
Message-ID: <CAFEAcA9VHdzV+7fpZPqDzF6-Y2PhtR3ERm=8w=78BnogUE8uKQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] decodetree: Allow group covering the entire insn space
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 at 17:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is an edge case for sure, but the logic that disallowed
> this case was faulty.  Further, a few fixes scattered about
> can allow this to work.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  ...est1.decode => succ_pattern_group_nest2.decode} |  2 +-
>  scripts/decodetree.py                              | 14 +++++++++++---
>  2 files changed, 12 insertions(+), 4 deletions(-)
>  rename tests/decode/{err_pattern_group_nest1.decode => succ_pattern_group_nest2.decode} (85%)

> @@ -978,6 +980,12 @@ def build_tree(pats, outerbits, outermask):
>          innermask &= i.fixedmask
>
>      if innermask == 0:
> +        # Edge condition: One pattern covers the entire insnmask
> +        if len(pats) == 1:
> +            t = Tree(outermask, innermask)
> +            t.subs.append((0, pats[0]))
> +            return t
> +
>          text = 'overlapping patterns:'
>          for p in pats:
>              text += '\n' + p.file + ':' + str(p.lineno) + ': ' + str(p)

I don't really understand this code, but does the similar
looking build_size_tree() also need a change to handle a
length-one pats ?

thanks
-- PMM

