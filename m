Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0C4C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 01:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B593B2065E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 01:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDPMZyd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B593B2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvVsp-0007TA-V5
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 21:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jvVrf-0006NL-Q0
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 21:05:39 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:47103)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jvVrb-00033n-7d
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 21:05:37 -0400
Received: by mail-ot1-x344.google.com with SMTP id n24so176735otr.13
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 18:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HZ9hVUXZu9t9Vq4g+fiuPG4LRRLb1uijRffX5MHB3nM=;
 b=rDPMZyd/XDFaBpWXkJPt62+TEuT+cxOucJ3x+Ylf0OfM5d6B4QpdhAlSyUnaEbjEtI
 CVaI78/xb68KqX4UWXECh5d+7TNF4L3zQIoYPeF3VTQziLtInY+akFsNgxJJ6GOVfU/3
 2fG0qBnzW8cb4EDDXBPIcky+JPsSZwWRrqYeVx947Q6WkX8rFCixGLUu38nZbbSefVDP
 hKZMf/ROPIvkR/AU49llmdufPXDAJQonAywhQeT7RyZpxxIbrUfKyeYzu7n78UgOsbF9
 HcLQ18vl5ov9aeE3p881Cw66OUo/ciTzi3cD+YH2Q6WO1LRWWn9LHZfb5EKCo+BtiKb8
 WhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HZ9hVUXZu9t9Vq4g+fiuPG4LRRLb1uijRffX5MHB3nM=;
 b=NxitNioBDIh1vTUm9/E4CDGxR+40f59D/gBvsTS3pnzzyK6sDj0rfiJfhciUjYf2NY
 9x6AYtdPIugSvcBYg71A8euah5ocTkfyT/mYCO+2SCKrIqRJQlfVzv2g1CAHURQ/I/DH
 D79RviOyndUlSqOwxwkdOqdWx+gZv/bZ98+2WUgPY79MiMt/UFIcPM5RV+y19d6K6JkR
 onVcZRPaqT7Wq/MRRTi08/xYYuhb0fChc4gWHocSvp7T7EYrYCGU3CIoCeKab5A09hjK
 rQbQTNvzec28tbgLl5GSpDOJoU7l59Bcx51mM0DgG9xcVjReQPh4uLUfB/L/trmxxCJY
 GvIw==
X-Gm-Message-State: AOAM531BfR1mzpCCW0m6S4t6vqDYy5jzSkbXZJx+5K+eb9wd2ycsMilq
 octb+EOjuuxaXWDtCBQU7wB91eTezoG8Y8rBVpU=
X-Google-Smtp-Source: ABdhPJy7CI1Mpzxez9JOsYNYIn2eI3cqtHG0fthtD2yuvd5mEGv2B5EqIga/KEdts9/k+s3bcT2SuuZzKnmbsqMhCdM=
X-Received: by 2002:a05:6830:1ad5:: with SMTP id
 r21mr6275930otc.181.1594775132287; 
 Tue, 14 Jul 2020 18:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200714164257.23330-1-f4bug@amsat.org>
 <20200714164257.23330-4-f4bug@amsat.org>
In-Reply-To: <20200714164257.23330-4-f4bug@amsat.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 15 Jul 2020 09:04:56 +0800
Message-ID: <CAKXe6S+KnKpgcaJ5MairhWpYJ3vGu8Fs12aD1i1onERm2x46rg@mail.gmail.com>
Subject: Re: [PATCH-for-5.1 3/4] qemu-common: Document qemu_find_file()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x344.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Stefan Weil <sw@weilnetz.de>,
 Qemu Developers <qemu-devel@nongnu.org>, Michael Rolnik <mrolnik@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =E4=BA=8E2020=E5=B9=B47=E6=9C=
=8815=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8812:48=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Document qemu_find_file(), in particular the returned
> value which must be freed.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  include/qemu-common.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index d0142f29ac..d6a08259d3 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -110,6 +110,20 @@ const char *qemu_get_vm_name(void);
>
>  #define QEMU_FILE_TYPE_BIOS   0
>  #define QEMU_FILE_TYPE_KEYMAP 1
> +/**
> + * qemu_find_file:
> + * @type: QEMU_FILE_TYPE_BIOS (for BIOS, VGA BIOS)
> + *        or QEMU_FILE_TYPE_KEYMAP (for keymaps).
> + * @name: File name
> + *
> + * Search for @name file in the data directories, either configured at
> + * build time (DATADIR) or registered with the -L command line option.
> + *
> + * The caller must use g_free() to free the returned data when it is
> + * no longer required.
> + *
> + * Returns: absolute path to the file or NULL on error.
> + */
>  char *qemu_find_file(int type, const char *name);
>
>  /* OS specific functions */
> --
> 2.21.3
>
>

