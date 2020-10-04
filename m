Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB90C4363D
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 17:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861CE206B6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 17:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBcnL4pl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861CE206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP86U-0003AY-GM
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 13:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ngompa13@gmail.com>)
 id 1kP84b-00027L-4C
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 13:45:26 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:35401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ngompa13@gmail.com>)
 id 1kP84Z-0006Cr-6M
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 13:45:24 -0400
Received: by mail-io1-xd43.google.com with SMTP id k6so6832406ior.2
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 10:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KCpdTi7nc2spBsRkwJtc5ooCAClqTvVbiL6SkKpM/Ck=;
 b=DBcnL4plGJhSvW5tnNe+kU6EoF38vSCfatwrzc2exQtTC00hpN1UqGtvtDIG4n1dJq
 iK006UQXVhJ2FhFYo/rdZTSbU6iGo6+qpsRMqE8EfH+UTpSq7yG4vnqKP8WAPb3wwkTC
 ZVV6qf7yAL66vsWh/3d80QH4buQ3QpHOLOLkMbcxkHBXfjqw3fwHPaGiRT0FkTbRyMOW
 YPFj5+I5fAKfeX4jgPntlw+telhHrZwfWRV4EovhENt7LCsE3Ai5HKFGgFSTUUwI0+kK
 Yb7V/pgSKOO9gLllRFcQVaiS9qcrk1bJ32WorwIPrfPGKX9+2JY8mAn6GOmGx2f8dgwW
 ZcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KCpdTi7nc2spBsRkwJtc5ooCAClqTvVbiL6SkKpM/Ck=;
 b=k8U9KFhR2A2OV9YyB7lzlGOLA045lzPsh/y65vDc6N8fNKu9dehWpwglNcH9/fAscI
 wwSpdoCIWZY1PXz7MfsNdEHeWBTztFvK/gsIznG1VboBeIXo6BwdRHCz/pgzjpiw+vwa
 s8ZlpBB2S5fjM9Tcz0UHxU2dOAvZDU18mymPEh1vTa3pMXY8mBpfsmNellpc50x2hR1k
 FcGI4oDx3YgVMQZpN+FKfCgcAW19uBpkC6wIAH1FHCpqeJs1yKEtOkWpZEuMkXGJRW5/
 g08ILyOxN3Itm4loDmcGv3Lj26u6DrvM0kNO95YySiGSFpDq7eMfvsF5fXtHcDuuQ6Cg
 tnuw==
X-Gm-Message-State: AOAM531Twv3GBdQ0neADfItTEt6+CbhYCwNru2+VpXk8496CqIrQHoY3
 PQZXJLT2lrxio41lwpT6qlYaVUgqrwYWen8avyA=
X-Google-Smtp-Source: ABdhPJy/tknwCz6dJ0fVlAgTzXxxTAlhPGBGRwcULBIR99nVyFSZtcWfO4mUbX0EGpYFAdX2/UuIO04iNnvYj4gemdo=
X-Received: by 2002:a02:a802:: with SMTP id f2mr1320202jaj.47.1601833520998;
 Sun, 04 Oct 2020 10:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201003085054.332992-2-pbonzini@redhat.com>
In-Reply-To: <20201003085054.332992-2-pbonzini@redhat.com>
From: Neal Gompa <ngompa13@gmail.com>
Date: Sun, 4 Oct 2020 13:44:45 -0400
Message-ID: <CAEg-Je_YGzm5bOo61d0_y_MuUSiR+qyy1Qcvfd2aa3U0efh6Wg@mail.gmail.com>
Subject: Re: [PATCH] dockerfiles: add diffutils to Fedora
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=ngompa13@gmail.com; helo=mail-io1-xd43.google.com
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 3, 2020 at 4:51 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> For some reason diffutils is not included in the Fedora containers anymor=
e,
> causing the build to fail.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/docker/dockerfiles/fedora.docker | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/docker=
files/fedora.docker
> index 71e4b56977..ec783418c8 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -11,6 +11,7 @@ ENV PACKAGES \
>      cyrus-sasl-devel \
>      dbus-daemon \
>      device-mapper-multipath-devel \
> +    diffutils \
>      findutils \
>      gcc \
>      gcc-c++ \
> --
> 2.26.2
>
>

Reviewed-by: Neal Gompa <ngompa13@gmail.com>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

