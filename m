Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7462CC43463
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 16:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0078220672
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 16:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+62g22K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0078220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK1vS-0003s4-Tt
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 12:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kK1u8-0003Ej-Eg; Sun, 20 Sep 2020 12:09:32 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kK1u5-0006jH-0f; Sun, 20 Sep 2020 12:09:31 -0400
Received: by mail-oi1-x241.google.com with SMTP id v20so14012188oiv.3;
 Sun, 20 Sep 2020 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KSR9EcQNShe4PcH2UyrfPhvbdQUNB+WYtWmarGDvzrU=;
 b=r+62g22KTMzr0iK3FmBCfFkEuoAYJ6dXe+PjsxxDRbdN01tTe+QKD1xpdTl/wEi1MM
 i4eyA/oqDqxSFWbve4Bqbubu/Ch24Qu9vxfY4ec6vMnUU9VMHy8eAuqsJBQ205s0/cbr
 S2fcMld6NvlYfiRmxJQgaOpnwtMPeGFKEvFELj2unlrg7y2fj2kgvBQiY8NIF8PIdoYK
 av4PtX7uM1Z+vJrjFIs2cUrDAql27vbjMOv7AA0DegcZ8XoM1R95Qq4I9p/OOdbNOFuC
 v4M2rbjeyw2BLKJTZd5dMXVKYoxD5qPcjzqfNPbMoC1Aq6vVi31A/rDGk/vOnaSnhFTj
 CPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KSR9EcQNShe4PcH2UyrfPhvbdQUNB+WYtWmarGDvzrU=;
 b=cAEd3na/wVxVqRFelI1rG4j3fL6nbcv1F9lYg3mGCpTZeHY3OpHmxdZbswhb3OwUdo
 KMKruwT/s+9wXqHpgvGNOxDmrIAlAZyYEQiZgs+7ETVkVugMFZ+pAIo2O3YT1zojl6Mj
 NJe2EaR593Cn4YGrU7UCKcokcOehPDWNWbJnxphvaG8tKdh7uGh5rm6E/RiiVOQX40pl
 iAXAbTxBiPiZEs2B8OUbgP/kdfeJSIdwzkcuBc3Uhk59evNuWgG0oC8FfEtV06gcLOFg
 H/RQ8zLWRelDw1s1OjndovGtR6l+psIWyFH2/XCdIcMAUcTAh8W9lJsuy48WtJJRN4gP
 WuIQ==
X-Gm-Message-State: AOAM533ee1LFPKghYRG3ZM12m6Swcoov4sUSxVS1iWSAhj2zWtM7/VGL
 MogYFmUdhqpwt0KQ6VddWUt5wnc4/IoI6cKkPIo=
X-Google-Smtp-Source: ABdhPJxDgjimW+PmKDlk21dMGggEnwdaAkdAqSno7TZXkAHldKV5JDANwvDEVvEPnQrfj5LgE+VUFpLRqkguXDaMvB4=
X-Received: by 2002:aca:e155:: with SMTP id y82mr16047461oig.56.1600618166782; 
 Sun, 20 Sep 2020 09:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200920155340.401482-1-f4bug@amsat.org>
In-Reply-To: <20200920155340.401482-1-f4bug@amsat.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 21 Sep 2020 00:08:51 +0800
Message-ID: <CAKXe6SK-Va24T+t-jzjqEyfq160ZQZpHb2+FaK-4DzVjjNLrYg@mail.gmail.com>
Subject: Re: [PATCH] qom: Improve error message displayed with missing object
 properties
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =E4=BA=8E2020=E5=B9=B49=E6=9C=
=8820=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=8811:54=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Instead of only displaying the property missing, also display
> the object name. This help developer to quickly figure out the
> mistake without opening a debugger.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  qom/object.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/qom/object.c b/qom/object.c
> index 387efb25ebe..257914b1fe3 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1259,7 +1259,8 @@ ObjectProperty *object_property_find(Object *obj, c=
onst char *name,
>          return prop;
>      }
>
> -    error_setg(errp, "Property '.%s' not found", name);
> +    error_setg(errp, "Property '%s.%s' not found",
> +               object_get_typename(obj), name);
>      return NULL;
>  }
>
> --
> 2.26.2
>
>

