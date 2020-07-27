Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E776BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B7D20729
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hscMm1Wi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B7D20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k080G-0005wH-0l
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 14:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k07zO-0005Tr-E9
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 14:36:42 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42321)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k07zM-0004B1-MJ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 14:36:42 -0400
Received: by mail-ot1-x343.google.com with SMTP id v21so5778974otj.9
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 11:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HsxbPLi0uphf1nlPtSHQb8uGZ6vi9ih/kMEIrO5RoPE=;
 b=hscMm1Wi7JmEp7q28Qs1D42m3OcgQnCawRb/4nnXY9rYcj9wrzsNNCzHgBffmeboFm
 PvSzxboNEnvvSkmWdbQqYx4Wy/aOzxMsRQGjb9XdroXfHMmIyWlZKuHowAiX0kjJnrzb
 XgKwwRI8QTRhJ0t6UKH5l1Yf6ol3niGRxHRLWV93RQF8yohe/8lGr1dqx5G5ab8aF8X+
 k4RWzdNYXjrkv40I6889lVMlNZhXTYtoOkV/9Ukr8EiQ2jA/nViKp+2Hz+ducV4u/cEb
 N6AhZ9jaW6M0pYQ1mnCLgihav/8zsLl7QnZvWqJPuAcqHMafI7LKj5ujwwSYiMHFPsP5
 Kcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HsxbPLi0uphf1nlPtSHQb8uGZ6vi9ih/kMEIrO5RoPE=;
 b=PXXXeRJkBryCyfcQSLfjmEDg9z8ZdZR+0yKWfeoROyEXayB1G/J/GXgbHyAMOODEdj
 b+kOU8E4AexJGjBLK4D9BYIdN2N1QAl85P73rK+iztJPE9ttTpEp6vxL1JJ1sDlHvoEV
 BseIe/ugGWtZr1P2akuSp7p42r99pI9vM6RnHX8GA7kkysN5Ly6wsPOHTHi64HgOaD3y
 lpohJmk0dbm8DueYP7tKbLnlQWtJ50DtXX+kF/PBRkYmNUEetkPurzZJJmT8WLHziUNj
 RM5OoK3oQgwm6hwTsnZiEBse64gr6/RbUBehGSvHNwdqkOrt/ArbrUYAgP8XMKjXAx1C
 3E8Q==
X-Gm-Message-State: AOAM531BD4ILy4WhMiwT38ZpdtxEVIYQEjMB2r+1WGNYw8YbWaas8mKH
 IWUcI2SMl79U7DPIUYjHUbUf4Hq4hmw+z7s6QFsueQ==
X-Google-Smtp-Source: ABdhPJzaqoiI1B6tR+OS18MH/M1cU+WcyOnVvo5Ie++hF9IEXy54+KJpmeTNsEFmlEArEyNOKNIXCKGPCH7LaonLxZw=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr21351943ota.91.1595874999035; 
 Mon, 27 Jul 2020 11:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200727174543.4219-1-f4bug@amsat.org>
In-Reply-To: <20200727174543.4219-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jul 2020 19:36:28 +0100
Message-ID: <CAFEAcA_n=WB-QjcF4XCHX14D3gL_1JRsfr0QSyCOcRmATRh0qg@mail.gmail.com>
Subject: Re: [PATCH-for-5.2] memory: Display bigger regions first in 'info
 mtree' output
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jul 2020 at 18:46, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> When different regions have the same address, we currently
> sort them by the priority. Also sort them by the region
> size.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  softmmu/memory.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index af25987518..c28dcaf4d6 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -2960,7 +2960,8 @@ static void mtree_print_mr(const MemoryRegion *mr, =
unsigned int level,
>          QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
>              if (new_ml->mr->addr < ml->mr->addr ||
>                  (new_ml->mr->addr =3D=3D ml->mr->addr &&
> -                 new_ml->mr->priority > ml->mr->priority)) {
> +                 (MR_SIZE(new_ml->mr->size) > MR_SIZE(ml->mr->size) ||
> +                  new_ml->mr->priority > ml->mr->priority))) {
>                  QTAILQ_INSERT_BEFORE(ml, new_ml, mrqueue);
>                  new_ml =3D NULL;
>                  break;

I think this is the point where you want to factor out the
comparison-of-two-MRs function. Which then makes it easier
to implement the required logic, which as Peter Xu says
should be "address compare first; if those are equal look
at the priority; if those are also equal look at the size",
ie the usual comparison-with-multiple-fields.

thanks
-- PMM

