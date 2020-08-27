Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9F3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 01:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D52C2074A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 01:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bV3dX5A9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D52C2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB6n4-0000fV-Lk
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 21:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kB6m0-00086u-F7; Wed, 26 Aug 2020 21:32:16 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kB6ly-0006mX-OX; Wed, 26 Aug 2020 21:32:16 -0400
Received: by mail-ot1-x341.google.com with SMTP id n23so3124596otq.11;
 Wed, 26 Aug 2020 18:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+Vvy84qV2hOJuHQtvex0dsqMf+bkQF+w9I4U2EXKhuc=;
 b=bV3dX5A980ahvZkf5Glh/ze6eyzII7LmffeQRF8yxf2HafDs4/qKX5y6tamFn6fShU
 b9Yk1UVrltN+vpuU19R/+8FdOuf/FpfXpXpDm688ZYNDr6jqkh21wilX+8jCAGvZZZsu
 4Ffaxz3uU4YAL+Xr7Ibyvf3RLaiwnvX/KgOqI4EMbO2iZ5mZWt/tmpfjtcBlY2TIOGrt
 s4eLPmDaYZ5Dger5Z4AMuZpJqpXcwJDdM2qF2fWDNMKk4zY8jURkWWfWWhr8cpay4s+A
 WafNoWgwbBFG7vEhc8+IoYvUxiaSr8KZswKD61X4lQnql5rd0MJxbsbvF73lFcNuX9cR
 f6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+Vvy84qV2hOJuHQtvex0dsqMf+bkQF+w9I4U2EXKhuc=;
 b=dcFkmoZ1cx8AHrUbSpkO4GHyx2D0iRDFms4mOUSWMtmSPWYH66nxA+9rwjEOfKzDgq
 1GGYdypMDHl2lJmsHtbihzCzdCJwsDMsO0INEcI69OJ+sRAgo/DxTt7q3F8Z9mALt5KD
 MEcXooQPTIFbhTCbEZp8W0mWKM0s6E05w2ZEZWACe0MnceVR7SJoaMYKfrD1iG4qS9uF
 PufIKX5GuykN7oP10K/VPP8Wzl1VttHql4iEdIPjom99zrHLfArqLWqZ8r9UI0PtITmS
 sRCvsqRNn5F+UvND9XDrBYKU6hMuGBKnTJw6KjSAHLc5Ekf4n20GNInjPiRB/BpzGEAc
 8sqg==
X-Gm-Message-State: AOAM533ozIog3OlmJNLsPQd/dNMrOvM4nr2YZ6/8T0d5uqK7pR24i7GG
 qMv+jrcuOl6JzKSSe+ssXIigvxbDeEz41kxG3A4=
X-Google-Smtp-Source: ABdhPJzW+zZ4xjNha9RBYxzGSKOVCwPla86WcApQQgzXIw5hueGXt9o9tT9SuMcFduiCiBkbu0VSyPUA3RFIQ9Jlopo=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr8980457otn.333.1598491933254; 
 Wed, 26 Aug 2020 18:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200826184334.4120620-1-ehabkost@redhat.com>
 <20200826184334.4120620-6-ehabkost@redhat.com>
In-Reply-To: <20200826184334.4120620-6-ehabkost@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 27 Aug 2020 09:31:37 +0800
Message-ID: <CAKXe6S++M2LOjMHG=omTr923qAVwbUOxOi9H4Qx7V=Rj=OZRCg@mail.gmail.com>
Subject: Re: [PATCH 5/8] xlnx-zcu102: Use TYPE_ZCU102_MACHINE constant
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x341.google.com
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Qemu Developers <qemu-devel@nongnu.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8827=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=882:47=E5=86=99=E9=81=93=EF=BC=9A
>
> This will make future conversion to use OBJECT_DECLARE* easier.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  hw/arm/xlnx-zcu102.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> index 5997262459..672d9d4bd1 100644
> --- a/hw/arm/xlnx-zcu102.c
> +++ b/hw/arm/xlnx-zcu102.c
> @@ -238,7 +238,7 @@ static void xlnx_zcu102_machine_class_init(ObjectClas=
s *oc, void *data)
>  }
>
>  static const TypeInfo xlnx_zcu102_machine_init_typeinfo =3D {
> -    .name       =3D MACHINE_TYPE_NAME("xlnx-zcu102"),
> +    .name       =3D TYPE_ZCU102_MACHINE,
>      .parent     =3D TYPE_MACHINE,
>      .class_init =3D xlnx_zcu102_machine_class_init,
>      .instance_init =3D xlnx_zcu102_machine_instance_init,
> --
> 2.26.2
>
>

