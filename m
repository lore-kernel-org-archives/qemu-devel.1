Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A26C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:59:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA53206E9
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p/PHugc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA53206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY9OI-0001yt-BL
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <masami.hiramatsu@linaro.org>)
 id 1kXxPj-0002Gn-Vr
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 22:11:43 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:46419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <masami.hiramatsu@linaro.org>)
 id 1kXxPi-000551-1C
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 22:11:43 -0400
Received: by mail-yb1-xb41.google.com with SMTP id a4so855557ybq.13
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 19:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lc088nZoBzO5fGaktrxcU2f5uhW2KCUmmkhovFmnDRE=;
 b=p/PHugc93k5KhasO70GRjI+ime6/EhUDb4p+zZUF4bm+4tFbJ4QnzopkeTWJlmYDLS
 QS+DlhJP+2ssbjo4MKmTnhhyXTsr6mcpN+UyHbMZ+8GG39WoRdtQzyCJrV8ti13X4m+H
 iLtjHbkfv3LO6yZVix/+eKeLk7QvuWMjB7mRLnWbDajnmbnkinFWR9SyU79dz3TSxtmI
 3cF4ig9aBrunJF3J0e6zGIKMQ77/4heuw5DD1wN+YZHowY5XUf5bre76wS1nhuyOqLre
 JtRYReN+ctoxgm4WkwUa24llNcHO0AN6OkUFh/9i+qaWpsJW/8t67SVaoKiV+1051qi2
 s8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lc088nZoBzO5fGaktrxcU2f5uhW2KCUmmkhovFmnDRE=;
 b=BLv86mQJYXtrNaGi5Linhim11MzOZvaGjWN7MknffpweaCiSGoASpTbCqmR90T3o1U
 TeCJ7O7VVf1aluvmQ1//mnm4sEUBmC/HJjI7ypbA6HPXysHyi65cmDJ6G0ZTHmizhs9g
 N7n6iTxdLZPJNEoKbNOpj3ih2lB39WrIGARetBlxl7lq0Gw3tiMq+8TeAkcrgSzrzC+g
 L5fcvVsFJTolE1qZzfiMPT0O6xFXnuLhTriMaih6W3B0pxftuR+FbMr1eK2uUvUC9OVl
 hnpJ3MnWnjGTn+znHN/lwVJfQ1rC8G99y/GN5wKZvqbYwamm2UL9dnpbfAFfMrpCFHep
 lPZQ==
X-Gm-Message-State: AOAM530YSuorGX4/veYmLqPo4G2S6DBnXSf351Z0sSCGPqZhzEXoePVd
 O4YoDJqaAro7PWsTJj9dJY4BAy9UKCgH7jHKPNlyMA==
X-Google-Smtp-Source: ABdhPJyA1ae5C1hgDl3PfWOToRM8A2j6q1B+Kp7Vbvjm/+coKjcmIlEUox3dKA5ObPMxt4zaoGwpxJ4CyeD7uhW7vuo=
X-Received: by 2002:a25:2d6:: with SMTP id 205mr2857987ybc.233.1603937500385; 
 Wed, 28 Oct 2020 19:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201028174406.23424-1-alex.bennee@linaro.org>
In-Reply-To: <20201028174406.23424-1-alex.bennee@linaro.org>
From: Masami Hiramatsu <masami.hiramatsu@linaro.org>
Date: Thu, 29 Oct 2020 11:11:29 +0900
Message-ID: <CAA93ih1z4dr0EMUg0G2WHXuzcK1ghET-8RJ_UuuFeWbToSnz3A@mail.gmail.com>
Subject: Re: [PATCH] meson.build: fix building of Xen support for aarch64
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=masami.hiramatsu@linaro.org; helo=mail-yb1-xb41.google.com
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
X-Mailman-Approved-At: Thu, 29 Oct 2020 10:57:05 -0400
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
Cc: Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org,
 Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

2020=E5=B9=B410=E6=9C=8829=E6=97=A5(=E6=9C=A8) 2:44 Alex Benn=C3=A9e <alex.=
bennee@linaro.org>:
>
> Xen is supported on aarch64 although weirdly using the i386-softmmu
> model. Checking based on the host CPU meant we never enabled Xen
> support. It would be nice to enable CONFIG_XEN for aarch64-softmmu to
> make it not seem weird but that will require further build surgery.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paul Durrant <paul@xen.org>
> Fixes: 8a19980e3f ("configure: move accelerator logic to meson")

Thanks for the fix, I confirmed that the CONFIG_XEN=3D1 on arm64 build.

Reviewed-by: Masami Hiramatsu <masami.hiramatsu@linaro.org>

Thank you,


> ---
>  meson.build | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index 835424999d..f1fcbfed4c 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -81,6 +81,8 @@ if cpu in ['x86', 'x86_64']
>      'CONFIG_HVF': ['x86_64-softmmu'],
>      'CONFIG_WHPX': ['i386-softmmu', 'x86_64-softmmu'],
>    }
> +elif cpu in [ 'arm', 'aarch64' ]
> +  accelerator_targets +=3D { 'CONFIG_XEN': ['i386-softmmu'] }
>  endif
>
>  ##################
> --
> 2.20.1
>


--
Masami Hiramatsu

