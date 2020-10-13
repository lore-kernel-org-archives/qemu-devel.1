Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6238AC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:57:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3ECD25225
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnN2x9Nr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3ECD25225
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSMgD-000333-Rg
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 11:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kSMan-0005lG-Ce
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:52:01 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:43212)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kSMal-000689-Oo
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:52:01 -0400
Received: by mail-io1-xd43.google.com with SMTP id d20so23204164iop.10
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 08:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cXzUaU7hI/ax3CPy1Zwv0gLjsb1dXu1ZO1o7V+QNkNs=;
 b=hnN2x9Nr5DVa88z/UUjKrCBKvVEjgBrRj66IYI23VRAcH+TewTUaigUZsfX+5V8wTy
 leXvsMpFIFCyaKsUlXOoXIAAHz/VOlpzG0f7ooLv4FolqA3Ni1Ds3OdXpYwt0BiEqj3E
 Gcq9/dx4Jy7GAqVH+8x9WJI7K+vvUc4LdSucD8CzKTWWobrPCUIRhhiyWHdKYwV+lls7
 sXRY0S2RWMFPUVGZ5/gklZllnFMuyOD/1zkCwzJPNU01usCm07Qn6IHtQqcmESdUixzj
 kgUXDmOJx+bRF2y36pflwGsz9x5bNL6cCE4BoPoo46hI2MX6bMmnxE2gUVaEpYcHT7pt
 duow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cXzUaU7hI/ax3CPy1Zwv0gLjsb1dXu1ZO1o7V+QNkNs=;
 b=ZaFH44kIaClfF80xG+kVveM+FYiD6BU3xVsni32Db4ejLxw6wq0dGTLdu+Pb1oREyP
 gjDfrYMC6lYIm7+7dve8JG1/EgU1qmTqFjkxIjmZP2489PxZz7jccshLsZ0zx/oLvMmY
 wGscIvAYUg/GyizsEb/HeFzBvD9Y7LanlVhHC42Pf7ho9Ymt1HssmW0JD+Z/E6KjSpdn
 5SK5ho7VRvowOaGanAvs5ReZ9WwdFwXHTatieIi129znJM28+B1sqOKUgCsdPyhGaYEm
 H8L9v8qI6YHkFCyWBpQ6ujqzjVa1sLtlFVZKMTJuGc0n+azfNc+5x5UAV6+dnG7z7gln
 /rTg==
X-Gm-Message-State: AOAM531TdaYUcNhdJiz/QLPcLOfdjeR1OA8SVgUr5+b8DLKN9VgLAszg
 xS5g8HEv7jbYl2G8dzVyRt9yT2xDBPNqd45UYDE=
X-Google-Smtp-Source: ABdhPJxyJzHd8AX9lElaCCzw11FzqFvmc1VEvngVSlDwbVuyCgcrNCBF8XTdq5u986PaoXfX/7tJnbZBJWiI/oVOtPw=
X-Received: by 2002:a02:a50c:: with SMTP id e12mr576916jam.26.1602604318202;
 Tue, 13 Oct 2020 08:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <2d8747944b70d105c7ce320be0151c4c4ec78d24.1601653938.git.alistair.francis@wdc.com>
In-Reply-To: <2d8747944b70d105c7ce320be0151c4c4ec78d24.1601653938.git.alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 13 Oct 2020 08:40:21 -0700
Message-ID: <CAKmqyKMzNt5__bPPHL-jGhVeMLejTq5gpT5VuUs3V168twjmtw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] register: Remove unnecessary NULL check
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 2, 2020 at 9:04 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> This patch fixes CID 1432800 by removing an unnecessary check.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Ping!

Alistair

> ---
>  hw/core/register.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/hw/core/register.c b/hw/core/register.c
> index 31038bd7cc..3600ef5bde 100644
> --- a/hw/core/register.c
> +++ b/hw/core/register.c
> @@ -258,10 +258,6 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
>          int index = rae[i].addr / data_size;
>          RegisterInfo *r = &ri[index];
>
> -        if (data + data_size * index == 0 || !&rae[i]) {
> -            continue;
> -        }
> -
>          /* Init the register, this will zero it. */
>          object_initialize((void *)r, sizeof(*r), TYPE_REGISTER);
>
> --
> 2.28.0
>

