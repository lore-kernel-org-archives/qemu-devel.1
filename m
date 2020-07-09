Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE125C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:11:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B58692073A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R6o40674"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58692073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYCs-0005xX-St
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtYBF-0005K7-6p
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:09:45 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35]:40714)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtYBC-0008E4-U0
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:09:44 -0400
Received: by mail-oo1-xc35.google.com with SMTP id p26so409240oos.7
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 08:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YYLOhcMHKyqKriN6F8mgg7s3cekuGlFWrtBFfLrmy3Y=;
 b=R6o40674hEmPgn03V4lOAAyzBMh9hwTnLsDRhXGuS5smYyJlM+xfJ2nJRHRg1Qgyrt
 QCCLuetOlhVoNLKR88AxH6FPPY7/0zqaqncGdDUMgc6wvhhodPCDF/cJlYRoyLqtl1BC
 /uQ5H0EJleFk8Ona3wPnV06CngJWFbhHxOlU0iQdR8J1ztaszq/aLsNpLzvRccYYlp4z
 1hJwqIODav1SNRBBrpDoq1xmNsLC9PKfbkOuwroDXoqLfxkmrRewrGm1S8WT40jEX737
 xJM0Ziq94q6XPWf0BTfxk5MHIVgz7HyHtG5H4KZ0WxO98c5iWTxTqjU4RqpSwv5YOKCm
 U8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YYLOhcMHKyqKriN6F8mgg7s3cekuGlFWrtBFfLrmy3Y=;
 b=FnbVi86l3nzkyiAJFxrPp09+qP0WDBH5oHb0c7kPpPRq777iqaU8rd8354mzXCbq7k
 OcAMfR5bQ8vrVGyJAttAuoahwCUQVF2fT2ON1B0iNTsWwEF34njcyxcN4rWi9dmtfzzd
 IDoOGU7zk/7WY+z47TVcc5MyPsPmi34o5NIYYIZ8dHsvan4pBHasgV246W/NCDSbeDNk
 8p6Z+bKgk2SDrhh0YW8Oyu/SFTqwJ99AHDYsb+h4n7/rtOVaUcuU3BAr1EyF+dUsUedN
 jGpiVAJ49R16vEK3aGXfNKAyeBWVkdmRQmr28EsDzQIA1ooLQzTRG+o2JzqtpdavT2i4
 d8xA==
X-Gm-Message-State: AOAM530OoJwMTGq6k1geHWgemJXAsFTLAmF3nrVNwzuA3HHOuAUzA7wo
 OALFygafBD9Z0wXMuJWzafB8vD3Dto2otDn819ngfg==
X-Google-Smtp-Source: ABdhPJygi/rlRH8OksOyl9mHiMGBFd5MjQdT/3Gu4n8v760an0LNIUf9tVwAPFoXqofjFfQ4QVEL+zrQJGZsTjN5E1A=
X-Received: by 2002:a4a:2f15:: with SMTP id p21mr55031778oop.20.1594307381224; 
 Thu, 09 Jul 2020 08:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200706100432.2301919-1-mreitz@redhat.com>
 <20200706100432.2301919-19-mreitz@redhat.com>
In-Reply-To: <20200706100432.2301919-19-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 16:09:29 +0100
Message-ID: <CAFEAcA_2ysWK=fs4E422uVBjRe6qT6cAec5Haahb-uuZpafNOg@mail.gmail.com>
Subject: Re: [PULL 18/31] block/core: add generic infrastructure for
 x-blockdev-amend qmp command
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc35.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Jul 2020 at 11:05, Max Reitz <mreitz@redhat.com> wrote:
>
> From: Maxim Levitsky <mlevitsk@redhat.com>
>
> blockdev-amend will be used similiar to blockdev-create
> to allow on the fly changes of the structure of the format based block de=
vices.
>
> Current plan is to first support encryption keyslot management for luks
> based formats (raw and embedded in qcow2)
>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Message-Id: <20200608094030.670121-12-mlevitsk@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Hi; Coverity reports a possible issue with this function
(CID 1430268):

> +void qmp_x_blockdev_amend(const char *job_id,
> +                          const char *node_name,
> +                          BlockdevAmendOptions *options,
> +                          bool has_force,
> +                          bool force,
> +                          Error **errp)
> +{
> +    BlockdevAmendJob *s;
> +    const char *fmt =3D BlockdevDriver_str(options->driver);
> +    BlockDriver *drv =3D bdrv_find_format(fmt);
> +    BlockDriverState *bs =3D bdrv_find_node(node_name);

bdrv_find_node() can return NULL (we check for this
in almost all callsites)...

> +    if (bs->drv !=3D drv) {

...but here we dereference it unconditionally.

> +        error_setg(errp,
> +                   "x-blockdev-amend doesn't support changing the block =
driver");
> +        return;
> +    }

thanks
-- PMM

