Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AB3C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 04:42:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A762084C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 04:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQ4zTOJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A762084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKDez-0002Ye-8x
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 00:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kKDdU-0001Kj-Mh; Mon, 21 Sep 2020 00:41:09 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37627)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kKDdS-0008NI-Lq; Mon, 21 Sep 2020 00:41:08 -0400
Received: by mail-ot1-x342.google.com with SMTP id o8so11199857otl.4;
 Sun, 20 Sep 2020 21:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=T9z5juxnqWaH5fSD6t1DfXl875cHuMo58ZbIdQ1757E=;
 b=hQ4zTOJv9+41wubiJuGgHXqPbLC3syUC3j8FAI/qCjXRiPCipoMB5yV8kdUF2sljOZ
 ndr3HWswJqleGmh07f9OvtFpuBwQFGDjQYm8zkUJ+vrz2EH2Ba8i43VMmqVEaWSHBgqA
 jry8e4Q6dQLoJJbM9I5K0EY8UMjP8bEiIpoMwbbnSnv6Fl/ZHoNQkv0gYZUpbURI/zzI
 a0yyGGvy1T9sKVErEGonS4yQDh/qHNsIM06ynaGMBPGx2yvq8zV9lZVWLKABiG7BJx0a
 mKM0jYR0+2IrWSyiQIF9+0qcBRQzR44HkSeXciTOq3oY/D7e9Ju96LwxascYw+Du63ih
 1FPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=T9z5juxnqWaH5fSD6t1DfXl875cHuMo58ZbIdQ1757E=;
 b=hPUBYnNOnQP88hytmiWfPIJ5EZQcgHoYDhLSS1UMDPncN4FvxQBc0CjLgZHHMdonxF
 rDCec1zLkaMmFqxxoiGVco0OPELhe/cdaee3tSYJWqMhIfRwUWWUGoQBZz/5MK44aDEa
 /PVoOAuJ5As8ToMr0tpIn/C2LEo1UirN1mku5bQpqhLWjGRhiSvkVzv9tlobXuKlodCA
 DdOSQaxaEuL76OzccIcaJOFJS5Y/rdM/+7G4nWr8HyuBhQ5+bx9LoC/XLpIuKdCsz/Uo
 Mky40wrrj3FWj8CC3PJlexkqPHGPJiLgWF/ncdfZxV3jldXsyl9zasdNIUqNDN8LzKLU
 5Uag==
X-Gm-Message-State: AOAM533LRpxr1LF0yHjaEQm24YtXBAALW81+5FUvG+Iq9EksJA0NcHaZ
 6WNq3ohEZuPVkjyU40Rbm5mZN2PYsi7HbTfyZx0=
X-Google-Smtp-Source: ABdhPJwGc8LwAHhKLaV0U98RJvyGHKIAsoHi5ljtSh+FQw/dmFnQ/VAZIidxhyB0I9a/GHwLq3NAcsvjInVIgmf5T0k=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr29373606oti.333.1600663265098; 
 Sun, 20 Sep 2020 21:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200921040231.437653-1-f4bug@amsat.org>
In-Reply-To: <20200921040231.437653-1-f4bug@amsat.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 21 Sep 2020 12:40:29 +0800
Message-ID: <CAKXe6SJL-=RfdtxV2rA6mLYzQGovcSEfUNHwgpO_dTz7P5yHwA@mail.gmail.com>
Subject: Re: [PATCH] migration/multifd: Remove superfluous semicolons
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x342.google.com
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
Cc: qemu-trivial@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =E4=BA=8E2020=E5=B9=B49=E6=9C=
=8821=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8812:03=E5=86=99=E9=81=93=
=EF=BC=9A
>
> checkpatch.pl report superfluous semicolons since commit
> ee0f3c09e01, but this one was missed:
>
>   scripts/checkpatch.pl d32ca5ad798~..d32ca5ad798
>   ERROR: superfluous trailing semicolon
>   #498: FILE: migration/multifd.c:308:
>   +    ram_counters.transferred +=3D transferred;;
>   total: 1 errors, 1 warnings, 2073 lines checked
>
> Fixes: d32ca5ad798 ("multifd: Split multifd code into its own file")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  migration/multifd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index d0441202aae..8aaa2f9ade1 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -447,7 +447,7 @@ static int multifd_send_pages(QEMUFile *f)
>                  + p->packet_len;
>      qemu_file_update_transfer(f, transferred);
>      ram_counters.multifd_bytes +=3D transferred;
> -    ram_counters.transferred +=3D transferred;;
> +    ram_counters.transferred +=3D transferred;
>      qemu_mutex_unlock(&p->mutex);
>      qemu_sem_post(&p->sem);
>
> --
> 2.26.2
>
>

